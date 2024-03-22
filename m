Return-Path: <linux-kernel+bounces-111952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08188732A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A181C2367B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FB57864;
	Fri, 22 Mar 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZl3IHBO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SRChI7F/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13644664D6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132273; cv=fail; b=P4xvCPRzcmEblArFdqCakgOi0AJaGqicLwufn4K+UIXo58059o+zrJ91ZhiFLivCCCALv63sEm0wg/uvewXZZ3DXfJ6j4ip9JAKhtBNB41C160SB2n29RW0MW6c69Qc23oxWq1qxTcCZruwXDUmuKbk+1h6D9g/5SGwtvwrhRRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132273; c=relaxed/simple;
	bh=H32urIcrLcxGSEsT7W7JVNycPbA2kYdAIjZI8fOAr9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmBVKyp8G/Nd+/2f6QLKnC2ZOjT7Z7BZWbhWdtkn4FIhVM8PXoB3ZwmeJ5ZrfWqdoz8n5FVS7iol3u4yDPHDDj07LHGF9xdHrrwrKscdls43GP8/Pdp67z4ji0kg1UccDY1q0CuzT3lXyCuxTE1I58F/5E1PBHqMr8VQ7FuKCPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MZl3IHBO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SRChI7F/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDJl5j001238;
	Fri, 22 Mar 2024 18:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=H32urIcrLcxGSEsT7W7JVNycPbA2kYdAIjZI8fOAr9M=;
 b=MZl3IHBOTsmQJssVLAd0ZPDgP3pMFW7wfo/gYFi9lr3AEL8OyQbAXPly/FZvQkUxfc96
 gvTgQEiP/DdXn2fPddZopS21jAQrsIgsXhwIxjJCB3XUD0w1oq55jhsljwLGZGBK4drn
 jHlWZgLNXE1oJMRMtZ+nnTxVooaconE6yaDcDXprIPAunCbIlsyIBcpC+afkIrZWQzf4
 4smIpDwokiVa4bOqCbkAvYUyjzPAwRmr2SnFGJd31OJVt6sOy9jEJXwpY7bw2f2faZnk
 qrcU8ww4EgkL6Xc84RoNcT0bOIIGyvdNksbLnJTyDWNdkxT1VL8iNwRAdKHFznkWIQP/ IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvhht57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 18:30:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MIB5gZ012761;
	Fri, 22 Mar 2024 18:30:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvgcjrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 18:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvx75RvrMdUf3aliHuoxrqCC+xUHb4bzt5N8KHJgWpDklpZL0C5JD5r1jHQlgHEKLyartw93ZE3sX+iblnIBQr77WKbXDQD/4d9rz68bU2j7nWBKIXUO2waifFKW5nKWbIWh9bG3maivo98bWKTZqaYuZt0sOzo6jWmFp22wZZhmBxwqQaVnI1CYDiKEMJ40R9LIAWPYDlyae8ElDoymyiN7OWwqoiuDU0+K6PgwfWIrSLXi4Nf3nIYwfUm/mYkLYgbE1/mbRQa9AR/T/O5FJmXurYCsPOcTb3cEKd+5GJLErso+nuCCIztl3D7rOkUXKuhmPdaCp6cMu/YtgpeXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H32urIcrLcxGSEsT7W7JVNycPbA2kYdAIjZI8fOAr9M=;
 b=B2Rcf2LV44k1Kf+0ntGNc9cmbYcKU+WKYOWitcPZNvsphQad/K1lj3MLAEQDlBzdPsSMsb8KuYWIhc7ds4Mwo1kh8cqamZzma8/j8PMbvssP44qIEU5QRRIzECx/8rLReo292FA7pWNjibC5zNiJrFbzNBRmRAStaoaaEy8uGU8wPMP8ngeBQLGtpwj64x4mrv5e0jOnbafLmUNcUS2clHZMfvlSVuHMob2q7Qw4GsGyGxI7xjfZYtnZ327KjOuzdvk4+n/csL09KrbKQP5msNzormEItycsWFYGXqZt6B1Lvb9RfhtUTl38kPkt/E1MKeA+yGBXpScF8EjY830IZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H32urIcrLcxGSEsT7W7JVNycPbA2kYdAIjZI8fOAr9M=;
 b=SRChI7F/eDOstFZudayHavZLiUH8ZydG+3Dz+4ikmBI2AkziKd/4kke2LxZefOO1K5tPkqhSuH6enK7OBiCsblR70FfRqJ8/RVAKA3HMszzClJk1hvMeUoafz+adQU1LY3ecguGv6GMpsNoAhJMghgJH99rYWLZcitz4C52Tj1I=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:30:53 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::2c16:18f6:a8e2:4caa]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::2c16:18f6:a8e2:4caa%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 18:30:53 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Ingo Molnar <mingo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before
 XSAVE
Thread-Topic: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0
 before XSAVE
Thread-Index: AQHafD3KBhVMcTr0lU6QlR+7RegrZLFEFZ2A
Date: Fri, 22 Mar 2024 18:30:53 +0000
Message-ID: <34F412AB-F301-40A9-9252-BDB4BA7CC4DE@oracle.com>
References: <20240321215622.3396410-1-aruna.ramakrishna@oracle.com>
 <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
 <Zf1TX3QXjWQsVp2R@gmail.com>
In-Reply-To: <Zf1TX3QXjWQsVp2R@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|BLAPR10MB4914:EE_
x-ms-office365-filtering-correlation-id: 7f7c5dbc-02a3-4253-93a8-08dc4a9e353f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DZibWbqdZdnIgXJeB2wHIFyFEBR05J1GmvojAuFXAoOlQYBzylXg0e0/nBpui+lUqluWXSlS6G+zcEE0R5nNqqXtYcpV+z9BWz8NS9iKl8MWNgL0/I6O6U2p/3ygmObXxxg0UmJl9PkqBf1LxoI7w1oOyjmsHltuMBxf1H/HSv521MSxOF+2cOfhcsuoQsc2Cr0ZZJM0WoMDMsAjNlhlu8pAaXza8iMnOaagLicokulwIFdAYJNBQMXhM9W2RqbX9VF2zRH+E+ftyZva7dQf6N02mnzY8QPKYt3zJJm5t54zgb5n2EczH8z7YYQ0aKXZ66+EMjIIHuiM7ImguW9++m+km+77e9FoJ0NihrnBJx+0ClS+KVROSuLg+Ax4DmMXnmCLroyZuDy263R1HMI+cz5nsz3qwacsgJuUTEa5ahXp6hMr7vF11p9SFDpGYsTvqYjhIbmJtWb7vJMbj4kmcpwDy1fVWC6opmGb+jnnS10aQRvlek9Asr3JR/dddUCGF+vNqumwiohKOBEHktmCJMEZqXK1GFMuJwwY5Ld/ShcQD61iWUhrtWZ62I8H3quvswQ5lq8b7gK+RN9niZtnChroGRltfw647Ixz6y8xQOzvreuCj5z3Tck+KsAY3FysLzP86gGYpPAUaU8FWL1aSfCiDN+EQRIXHuvipAVm+Zx9sSOH6i9AGPjEXx9gOfC4zb983VQFt/aekwqNfQB5wA44/w3OtkUdTe9jnGiUVj4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U0Q0dnQwRnhqNjc0K3ZrbU1PeENXbXRyRXRXaVoxTWRzL1VwMUJVM2ZnQzhX?=
 =?utf-8?B?WWZWcEJnbks2M1F1VjhYNFhaWENrek5zbDZRajdsaW9LcUVNL1ZuMW1PN2V5?=
 =?utf-8?B?VlR6TGp5dk4xU25WcVN2aXNkWktOSnVVZmtSRkNJNTQrS2tEeXNZWjZWcnV6?=
 =?utf-8?B?eElGUnpGL3NyU0QwSG1MMXEzaXhEV1g3eDgxVGxQclRPSjgzTHcxSmhZclNl?=
 =?utf-8?B?QXhYVUZwS1B3ZXkyNlBFeEtNQUVsaHM3NU1ud2RaRlNkeHoxcGw2eDVmY1BU?=
 =?utf-8?B?R1pHczBiOWZlU2Nubkg4RDhBenVTamtMcmQyQ0luT3A5Vm5zSFRuT2FYaGs5?=
 =?utf-8?B?dVpHbHNJNHpWNWN1d3RuT0dLMFU1ei9DV05ldXF5L0txQk9FcDJKdkZxR0Fh?=
 =?utf-8?B?MXhhcUNnTitUSklZODFRMXRyUnkyVU03bXlIYjByQUNNNzhaVVhZVzZZeFdB?=
 =?utf-8?B?cGpoRnJWaDBWOENHMkZiZmx0QVBpY1lpekJydHRmMElwZTBLRVlqNm92WmtG?=
 =?utf-8?B?djQ5dVN5L2FQRjVRQndsSzZTdzk0SWc1ZFlGZ2JUUmpaYXlTYW1kc3kzTmFi?=
 =?utf-8?B?QWNuRHJoUGJ2MnpzdFIzTEltVVVYamRoOXpBTWdLbjdFT09yN0xLTUczc2JW?=
 =?utf-8?B?ZXhVMWNhRVh1SXZ6SzNaZncyUmdwdngzanc2cVhTL210S1hta2V6Z0RvQkV3?=
 =?utf-8?B?NWxrNVhhM2lSNmdEc0hFOWV1MHBGRFVianVaeVpQZUVPVmpBS2l5UGMzcUlZ?=
 =?utf-8?B?T1d0VFZKV2llKytSMmc0NzNpSzBBcUxGeHNncExWMjhrN1EyeElkMkxWVDhk?=
 =?utf-8?B?M0trdWhReFBBenNqTWtQN1NJNWxJRWxQNXJDaGxjODVvUHlVaytyMWdrQ09o?=
 =?utf-8?B?UFBpcXNrT0xXaTFPTEF6K3E0bFZMVUhhSEhOR0k1blV4Z0R0bXgrQlEvaEJB?=
 =?utf-8?B?YW1zTjUvTzJlTTl0KzlaU01WYVp2Nk44RUFrbjZrb3lWTStWbXRVNERLZTIr?=
 =?utf-8?B?MGZnOWtCOTdRSlZVRXhMMktjN2tjNG5mVjAwV1kzQnowYTBscUZsaTRoYzRa?=
 =?utf-8?B?em1SK3hQWGxjRWNvbEc0eU5wYzBrSS9HOEVZanVxVHFmcFNFMHRWa1FTT256?=
 =?utf-8?B?cFJCWlRHdjlWSitaK1huMSt0TTlSbUUzclBUYmlrN1M2WUVla1U1Wkc5QUhS?=
 =?utf-8?B?NXJtNno1dndsNGFwbHNmQ2w1eXdXTDc2dmRZZUkzTURINmtmQ1hGMHNuSUxr?=
 =?utf-8?B?MThuTlRTbUZTTjlSaUlJVWFRaXpCYlE0eTlpSWlTMUpXVTlvekVrWU5mYkVG?=
 =?utf-8?B?bjkwQUVoY2t5Z1IvWkpNQzVXcFlGWC9BRjhETDNmVm01UlZ3eDVPWnBsWnd2?=
 =?utf-8?B?M0NRU2dyOUNEMVA3R2VxRUY5Q1hoNVlTYTErbVYzd1JRTmZkak4vK0xlV1pE?=
 =?utf-8?B?a25PWVZEUFUyNS9ldjJnKys1b0JHU21FN1FoZkVQT3ZDOXV3V2F2TjUyU2Zt?=
 =?utf-8?B?WDNaRWNwbllvc3FWSnRqUUg5V01nNmNMY1NvWVhxMTJyT2RyMXgzbmpoYVBJ?=
 =?utf-8?B?SU1BOTljRE54NEtPZjFZQXJMSGFsK01LQUQyTjBNMzB3R1BkYmZCRDM3cGlw?=
 =?utf-8?B?QlprMU1LaFpwYjFQQUtMeXgvejJFczVBUW1xaU9vQjA4Y3hmaVFnZlcwc1RB?=
 =?utf-8?B?Z3RtVUZUdkcxemZ2dzcyZVhobVV4RjRsQjJDYUxFNm9pd0tDTkJCdVY1OFc0?=
 =?utf-8?B?WlEyMlJsQTczdHppWS9DVDd6Vi9tc01Oa1BPMTVqNFJyRTRSTGF3OG5zRk1a?=
 =?utf-8?B?blpmdHFVZzRvZGQ2WU1weUJXMHMwME05VnBMVVErUU0xUDhOdDIzK3doSk9x?=
 =?utf-8?B?TDNIak8xQy9oMkRSUDFvbmZLMFJsemlHZi9xUFNMMTdJVkQyVjF5MGVSK0hI?=
 =?utf-8?B?QnBtSkVaWHVuWjZ0dmk5Z0FYazBjTVVQaWJuSURTNVhKY3VQZ0lLMUZoTVF6?=
 =?utf-8?B?ZnFrUm9JZ1VyN1JhNmVDalNSbEl6cUJGWUh5RjN2aXhiR1JkWVFyaEI5UGtK?=
 =?utf-8?B?RDMzYVdrUlVYV1FUK0pnVE5XcnRzaFlQK0xLZGw0QTB5ZjNXRFIyaUVjYXp1?=
 =?utf-8?B?M3B5YlIzWmRTTnAyb2NjUDlDV1g3eSt1VElhSU0wdVNhRkg1ZVNjMTUxQmE4?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB652536E818F248BB4734B1B7AD86C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z3JIbhsXsrGWkUaejPyBt+xRbZsGxtTGbEniMNjaFYSgADzv3bdjtd3vm5aEeLZUEMy7siDAOeIqfvpB970wxS4SqkUltyxqz2RRtxdNptTTS66muLExlpTbga0v/xIAdFd/Bu6fi5qUc0IxFpQ7SV+5nKNNtgZOrKRrSocGoWemszZ06W72wJDIGW91hY/qCzcCT/H9kq4dmP135IAirS+/wPFjiYc/6SO4OCgjZEnt4hsjKvNv2xNVxbqoHx2HuquTylJfgRucCwXcL3JP6m+trD+/2aMKOBpQ6ZzVxHfSELp+65ZzxLBcXKtd6AZftOBnSNbQMN3xpoPfXpU6cL0D5yaM5uRZPd0j/gwB87ebupQUZv3wZUzAh0WzVqIxrFGxmh0PGz1S4qdLv0pohoeJV1S169vImlabFRu+2SuRH6kg20S3P5S4TPmVDlRLtlvJUnWa5F5EEpAznY+N4FVJ+SN+afqfqx6w9Qnvgu/IMTTBo3cnM8H2JnpS2z/KD5Ef5unuv5hBPbyx4drnfcl4l1B3uxC5ZhsizJfY9H/tdc2GJ9bB7+QiR3qf0Z4Sn0o9Sbd0psrGV1QBjVCy6HT939pFCPuJsEDMjeB8AjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7c5dbc-02a3-4253-93a8-08dc4a9e353f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 18:30:53.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aa6AeUpeLv6hF1MPd9m9w1yrzlJHxnJpzBg7WOlBJhz6uCudmI73M8poROxPGuEZ7/8wMhWD+ZuN9PUtqfEUVSmmQjpzmwWJhTv/F8cQn/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=927
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220133
X-Proofpoint-GUID: Fuvv18A0WsMRiYfiaot4dx84noCaUhTQ
X-Proofpoint-ORIG-GUID: Fuvv18A0WsMRiYfiaot4dx84noCaUhTQ

DQoNCj4gT24gTWFyIDIyLCAyMDI0LCBhdCAyOjQ24oCvQU0sIEluZ28gTW9sbmFyIDxtaW5nb0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9rLCB0aGlzIGxvb2tzIGEgbG90IHNhbmVyIHRoYW4g
dGhlIGZpcnN0IHBhdGNoLg0KPiANCj4gQSBjb3VwbGUgb2YgcmVxdWVzdHM6DQo+IA0KPiAxKQ0K
PiANCj4gUGxlYXNlIHNwbGl0IG91dCBhbGwgdGhlIFBLUlUgcGFyYW1ldGVyIHBhc3NpbmcgaW50
ZXJmYWNlIGNoYW5nZXMgaW50byBhIA0KPiBzZXBhcmF0ZSBwYXRjaC4gSWUuIHNwbGl0IG91dCBw
YXRjaGVzIHRoYXQgZG9uJ3QgY2hhbmdlIGFueSBiZWhhdmlvciwgYW5kIA0KPiB0cnkgdG8gbWFr
ZSB0aGUgZmluYWwgZmVhdHVyZS1lbmFibGluZyAoYnVnLWZpeGluZykgcGF0Y2ggYXMgc21hbGwg
YW5kIGVhc3kgDQo+IHRvIHJlYWQgYXMgcG9zc2libGUuIE1heWJlIGV2ZW4gaGF2ZSAzIHBhdGNo
ZXM6DQo+IA0KPiAgLSBmdW5jdGlvbiBpbnRlcmZhY2UgY2hhbmdlcw0KPiAgLSBoZWxwZXIgZnVu
Y3Rpb24gYWRkaXRpb25zDQo+ICAtIGJlaGF2aW9yYWwgY2hhbmdlcyB0byBzaWduYWwgaGFuZGxl
ciBwa3J1IGNvbnRleHQNCj4gDQo+IDIpDQo+IA0KPiBJIGRvIGFncmVlIHRoYXQgaXNvbGF0aW9u
IG9mIHNhbmRib3hlZCBleGVjdXRpb24gaW50byBhIG5vbi16ZXJvIHBrZXkgbWlnaHQgDQo+IG1h
a2Ugc2Vuc2UuIEJ1dCB0aGlzIHJlYWxseSBuZWVkcyBhbiBhY3R1YWwgdGVzdGNhc2UuDQo+IA0K
PiAzKQ0KPiANCj4gVGhlIHNlbWFudGljcyB5b3UndmUgaW1wbGVtZW50ZWQgZm9yIHNpZ2FsdHN0
YWNrcyBhcmUgbm90IHRoZSBvbmx5IHBvc3NpYmxlIA0KPiBvbmVzLiBJbiBwcmluY2lwbGUsIGEg
c2lnbmFsIGhhbmRsZXIgd2l0aCBpdHMgb3duIHN0YWNrIG1pZ2h0IHdhbnQgdG8gaGF2ZSANCj4g
aXRzIG93biBrZXkocykgZW5hYmxlZC4gSW4gYSB3YXkgYSBMaW51eCBzaWduYWwgaGFuZGxlciBp
cyBhIG1pbmktdGhyZWFkIA0KPiBjcmVhdGVkIG9uIHRoZSBmbHksIHdpdGggaXRzIG93biBzdGFj
ayBhbmQgaXRzIG93biBhdHRyaWJ1dGVzLiBTb21lIHRob3VnaHQgDQo+ICYgYW5hbHlzaXMgc2hv
dWxkIGdvIGludG8gd2hpY2ggd2F5IHRvIGdvIGhlcmUsIGFuZCB0aGUgYmVzdCBwYXRoIHNob3Vs
ZCBiZSANCj4gY2hvc2VuLiBGaXhpbmcgdGhlIFNJR1NFR1YgeW91IG9ic2VydmVkIHNob3VsZCBi
ZSBhIGhhcHB5IHNpZGUgZWZmZWN0IG9mIA0KPiBvdGhlciB3b3J0aHdpbGUgaW1wcm92ZW1lbnRz
Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSW5nbw0KDQpUaGFuayB5b3UsIEluZ28hDQoNCkkgd2ls
bCBzcGxpdCB0aGlzIHBhdGNoIGludG8gbXVsdGlwbGUgcGF0Y2hlcyB3aGVuIEkgc2VuZCBpdCBv
dXQgYXMgYSBwYXRjaCByZXZpZXcNCnJlcXVlc3QgbmV4dC4gQW5kIGFkZCBhIHRlc3RjYXNlLg0K
DQpJIGFncmVlIHRoYXQgdGhpcyBwYXRjaCBjb3ZlcnMgYSB2ZXJ5IHNwZWNpZmljIHVzZSBjYXNl
LCBhbmQgaXQgcHJvYmFibHkgcmFpc2VzDQptb3JlIHF1ZXN0aW9ucyB0aGFuIGl0IGFuc3dlcnMu
IFRoYXTigJlzIHdoeSBJIHNlbnQgaXQgb3V0IGFzIGFuIFJGQyAtIGJlY2F1c2UNCkkgd2FzbuKA
mXQgc3VyZSBpZiB0aGlzIHdhcyB0aGUgYmVzdCB3YXkgdG8gYWRkIHRoaXMgZnVuY3Rpb25hbGl0
eSwgYW5kIEkgd2FudGVkIHRoZQ0KZXhwZXJ0cyB0byB3ZWlnaCBpbi4NCg0KQXMgRGF2ZSBzdWdn
ZXN0ZWQsIEkgY2FuIGluc3RlYWQgZG8gd3Jwa3J1KDApIHRvIGVuYWJsZSBhbGwgcGtleXMgYmVm
b3JlDQpYU0FWRS4NCg0KVGhhbmtzLA0KQXJ1bmE=

