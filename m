Return-Path: <linux-kernel+bounces-150032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9548A9961
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAF31C21C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833515FA89;
	Thu, 18 Apr 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ty+YaBqA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qeoro3CL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37315F316;
	Thu, 18 Apr 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441592; cv=fail; b=dVYG3fpPSfwtUfkkcWBuNsn/f8SkraPNYCzH/JUPo1pvLsD1Jwh1+9n5s47rjIcQ3Qszgvz8kkqdqRSMloMIKezkdKihx1EPlfqFEMfR0pwQ7izvlF/5sYOJlRZ/qaEBGUnhgHjARRW0v2p08prI6RE1ejESr6eS4ClHyOGHwOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441592; c=relaxed/simple;
	bh=Fjn1qcPI076jCu0rhuOpFhejBlZUbED8s9/xfFd1Ags=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=mAN1QcLusWOc7vv3fTYOPAc5467CanFhISwv+FVFumF6Y+Rbv/HXqBf7V4xaNyuOVIgRaeHaB/JOzPq+LjjQo/sAbRsdw6WKQ5W+BYB8Z9/ohe9G5QugHqTfKjPSrNoeIZDchOt4digiYO78lwpoiiWZn5sRc/habgreohF+Axw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ty+YaBqA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qeoro3CL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IBxE7U024998;
	Thu, 18 Apr 2024 11:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : mime-version;
 s=corp-2023-11-20; bh=NUtjyIgP8oJ5uW9YkmNCTz5F7fZE5L8L84vbdYE6wqI=;
 b=Ty+YaBqAr5FOLRUY5A/QiMFBRTzV3C2M3oYjSRuGSqeUTBqf4Fh/WMfGjAmiBVYmYS/7
 SsmtxRUlZxfHOj35Dbh2SoWlongUC9d/NVgWczODvZRdLHaMFqfPTVPO3Y0hntdqAVJH
 Llad7bJGxAQmqEsuTwfVLMS2vhsMEqKw2wpG6l6/MnFlvZNDaVSCflsy8xogjB1cWGhC
 wg04DQNPA/zO8c3Vt+CZKUkX832wcXCC24A5Stq6V0iOp8evGrG7C820YpfdLwF4B9Lk
 ZzlD5dBi6LD+zMz5qC4hfQmHyp6dnaAV3lpFmM9FlmK42/NLlJ5weNMpEZvJkb9s37Ki yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3eacjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 11:59:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43IAtdYt005105;
	Thu, 18 Apr 2024 11:59:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgggj4fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 11:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxXcm4P4aCdTrBPmh0MIEuGEOjToH9IY8Uys1xJqoOk58RMTumaockgVayDxKMUGWXcfx9CseYXwKutqC1kNnNz1g28QNNjPxxRhXtoIOclUVToHQo2KctVvjXceTfYzpcLtM4v3WXGq7M1PcTpgUOAQFCxNcSKdSkVlVCMED7mymukqaJqrcx6Qy+S55jx0YywrpJxgTMDSR4JXwnDGlELf85m2gtLo/+uiK8CoLmjEH3hPz4PJmUHk1PECuVGqvcfez6c8nhQAIIVummeeD2lmAMQZzMFiNXmqs9jME0ykioX+hRpwDO4Cmby+z9zb7aPoADzH6n1Ah1uhPyL9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUtjyIgP8oJ5uW9YkmNCTz5F7fZE5L8L84vbdYE6wqI=;
 b=kJwckLXOAV/gYIG29b9q6xEgSq5cRl9ir0fISOMy1wkS4IJUsHqUtNknvtN7WLB1wRu6eYOpTbEhzPZUrNwzjLDKT6uTTAGjGxFDiGm6XfKzRLcpqQioQZso2hL/eipP4eHcHY57hl1vlc240Nk4hAHhB1pa3JW2zRXTyd5qIbaFFpy13GcnbnD8SsHyUvbsh5QxNJfe2OWGeehtpC6ybEC5B5M2CONsJrmVMXVrRrmsySpgAPnevsP32ARY8Kuc5Rs0JOKLQjcUnXJ/bh5Dfc09pRYNrYAvhLBjJTb4hCoO3Pgp1ZUiumewntlfT8szM7H3vAF3Ibua+gs0a3n0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUtjyIgP8oJ5uW9YkmNCTz5F7fZE5L8L84vbdYE6wqI=;
 b=qeoro3CL3sePlR3PRdOrkkJKj2HzG0cZov72SyU+ZE2qAlrj2Oe1Lu5TlBaUVrxpclxef3Zagm3so1WES0BbtKnLTuGX3cceHZyY0TKnnozobznDjXIjl8yLrtg+tt9y8EVjXCEV/Be1XZmKTz+3cpXsMeILEDxHgPmYk/szkZw=
Received: from DM6PR10MB2810.namprd10.prod.outlook.com (2603:10b6:5:71::18) by
 SA1PR10MB6637.namprd10.prod.outlook.com (2603:10b6:806:2be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Thu, 18 Apr 2024 11:59:42 +0000
Received: from DM6PR10MB2810.namprd10.prod.outlook.com
 ([fe80::639f:6c93:12d3:cd5c]) by DM6PR10MB2810.namprd10.prod.outlook.com
 ([fe80::639f:6c93:12d3:cd5c%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 11:59:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-cve-announce@vger.kernel.org"
	<linux-cve-announce@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-26920: tracing/trigger: Fix to return error if failed to
 alloc snapshot
Thread-Topic: CVE-2024-26920: tracing/trigger: Fix to return error if failed
 to alloc snapshot
Thread-Index: AQHakYflavlUUMfH9kOorpGL09z+TA==
Date: Thu, 18 Apr 2024 11:59:41 +0000
Message-ID: <6fa1eb4368cbaa2d0b243539f1d91692da95e117.camel@oracle.com>
In-Reply-To: <2024041738-CVE-2024-26920-a681@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB2810:EE_|SA1PR10MB6637:EE_
x-ms-office365-filtering-correlation-id: 2974d143-5b83-4e18-d44a-08dc5f9f07ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2R+v+M8GkCRYMkVAd+O4JwXgSmGuK6Rle2UF8NrEL3G07SGUEBLbySIwpjO04N9d9DVQZMxndjvADOXDs5mH3aJTeKmp33jLimzIU8UorU/QWOoobFdVPvQMFD3sL7b9W9PFMugVePcwMkueZ6lzvuAe+p7ohAKDHGVS+P07EZCcfoOtKLoOMdb7G+Adf8skbUGMjZxLWr2XAE1VxtlmWtOWnvdx9joTCFAulbyRfZbjgiN9xGAIaQBKqaB8+ZT9QO1SkEF/ZK7yxFsBqd8XdZKytpTVt0qjcya+hEoXzz1pQ6kci2+BAwukCj0FiNa0RElMPlWopX34Act9JCnwKPIflyCVIwKNgDAixDHHfaWZR2rLJl9yk0R1c8/1R+QRy9NcuouviGgwP03aA27pKW66MK0cCYuEbLu4ojW5FgoBwqxkXAsvg2H0Tso8mbk0eOyYKC5AAQEuK7NWfbWTHergPcA86jo1rZt1GX9TI2GuZEv7XzJCanUoLfyEb0LUrMo1mNUbetw4U4YPl9aiu8coEY83t2MuX0sB8dLxQ+vv04g78aF0rm+0Pd4O2v/A+tM9ohPcCZj6N4o+3qGZ6YbSPUNwqUKs9I64yx2j7dixvo6sRkiHL95u0bEOgKpOdi0rsjmGz+JAypcnlumWQdg6WIDLwtQw81e5ln0wqjCah2V1kSA9Jh+uSrGmMaeTXlilAwZhkLc+7LBaYz1VbeGE5WuQHI+eBdXiUxFv6gM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bWdPL3RRWDN4dzM4Q0lmRlBlT251STJ4dWFNaVlBbnBRdE9TWkVEYjIxc3hh?=
 =?utf-8?B?dDVUd0VUcWwwM1lXb3B2UUNuSDVhK3pRY3owQm5wRXJJckZDVVFqVGZ4TUg1?=
 =?utf-8?B?alByN3BiR1NpQzhWaGZPOEFYMEJRRTJ5YVF0YlRTRXFUY1lzcVBoMkFLTU9N?=
 =?utf-8?B?VzF4ZDNhV21Pc0RJRzVmZUQyQm43VnRMc1cybjRKcThwTXo3L0kvZG83ZGZY?=
 =?utf-8?B?RlpSeStDbnFkWnlGY0o4SzFDSUhwTzY5RWd1U1VzR2w4Z3hLYWV1dStlcVdi?=
 =?utf-8?B?dVVGY0xSK0VmUHlIYVBVWWVUMzQ3TkxJcktaRytPVURXL0N1M1gxaXplUWcr?=
 =?utf-8?B?ZlFHRHh6UWNWMGIyRnFCWkJmMkRqVmlsN05aRW1sZHh5WldmdHE3dEYzQkNw?=
 =?utf-8?B?MlpJYnE1b2EvQ1hPWm5ZdWdoZ3YvWFJwZlowQ1BNSXU1RmxqSUJ1ZDcrZThX?=
 =?utf-8?B?ejZVQzlEQmUyeCtlRk5NZGgvMHpNQmdtZytOZVlRYnU0MVZrczBwMFdoUkVl?=
 =?utf-8?B?bGtTSnU2ZUFDNndvTmxYU2ZDNDU2T3BiZXorbjFSdksxWHdDQndONEFuUTEw?=
 =?utf-8?B?U1QzaGFNU2FEMnFaT2xkNnlsU1d1U2FNR1dOYnpHck9TclhmVk0vOWY2WExN?=
 =?utf-8?B?SVd0aDdBRUwrdkJZK2RsdkFFZncraEZWV0pRTWVDYjg5TkdaWVViSHJ6NGx4?=
 =?utf-8?B?TVR2Q1RmaEZqRko5empMQmhzMmZZUm0rWUZqLytxOVBOeVVSOWZpc29DTGYv?=
 =?utf-8?B?TWVwK3k3KzY1YVFhWkVTTmxONUJoQ1FOVTNMc1Erdjl1dkJkZjdkMTIySE9s?=
 =?utf-8?B?bzQ5OU53a2lXUmVnN05zd01pOWlyTVhPTUx4ZzJCZU5BbTBNNjNMTlo3Ly81?=
 =?utf-8?B?dGowbEJQVm1TZ3p0S0lxVU1zc1pWWi9DUHVqS1VWcjNleWw2Z2tHVWFiL1NG?=
 =?utf-8?B?Q29xSm5ackl5R0RRUW14U09jZUVzZS9EUzd0NW5tenlyVG5GTUlWeHR3QmVp?=
 =?utf-8?B?TzlXbm1DY0pDcytxZUdxMS92aFdrQm1QQzJwZS9iY2VCaVNZS1M3cjZwcXcy?=
 =?utf-8?B?RHpNd2pyY3JMZzVzVlg5ZHBGcWoweVV4UEMzMFh4S0NkTWwzenkvamxEdkhH?=
 =?utf-8?B?R3ZsZ0hzRUQybHBGWFV2ZnRQQ1FWeXEyRjNkcldmMHpIS1IvbE5OMS9KVXg4?=
 =?utf-8?B?VlFXVmg0bG5rVjZkR3dMZFBIazVXWXZGRmtyL29DMExPditaSWlMTE9wdUNh?=
 =?utf-8?B?ZS9pMUFnZitrdFU1UHNKcCtWTkZqWnpjSjR2Zzk3RVl5b3pRK0dRMGI4aTFu?=
 =?utf-8?B?K1UrZGljSnFxYkNBdVdGWE16Q2F3allxWkRBOTZPUWtFZzFZd3pCRkVjUjNE?=
 =?utf-8?B?ZWQ5Q3F0UFlwWUJ0bllEUk45WUI0a0FZREVodE95c00xdVliRzIwV2tlY2x4?=
 =?utf-8?B?ZTJsQkxFMmVROHJ3QUNiKzdybTNZVjNhTlc2UnhpOWdFYUM0ci9ld0o1RmdL?=
 =?utf-8?B?SG84R2hwakdId25QZG8yTkNUUFdOYUJldENIYng4L2M4L296dldJWXgvbFlF?=
 =?utf-8?B?UDFHM09rYmVqVTUzVHA0UFB3TmE1MDYyNDY5RGFaV0NyeDNnQWE0bmJHejNl?=
 =?utf-8?B?eTBRR3pQMjZKRkFsdHhMMDgwTzdxbTNMM3ZtNHA2V2VXN0g5RnBla2FlNzBP?=
 =?utf-8?B?WW1xNHJDdFlBM3VSNkFVVDdIYU5nZGcxQXBtZGU4bkpKRk9TdWMxRHV3WXFw?=
 =?utf-8?B?SXBQRnhWQUpubzNaV2tMM2k2czQ4VVVCVHNrR08yRFdHN1BIMjFML0xLTWZF?=
 =?utf-8?B?Z3ZmKzF6dTFUMTZJNUR1Qnk0VndCeFhGbDRlekczTjhuUnZ4bnJ2Z3VubDdk?=
 =?utf-8?B?Ri9VOWVuc3RkSGVkSENKMDlpZ2dNS1YrSXpERXdrSjh4d05wUVFpbjJrSURY?=
 =?utf-8?B?bksrR1FSQzY1Sk1lWU1mUXY1NTRTaUFEaFpGRFlVR1Z4R1FTcnVWQ3gyNm5z?=
 =?utf-8?B?NDBpSXBGVVZObE9vVEFaeFdNb3RZZjZsMktGMFgvdUlGT1VPcjd5dlp0Ni9W?=
 =?utf-8?B?UGhnRmFyQnBuZExQSHBzNFJtNTZlOWRrdmw4QXAwYzNrZWpBSzJPWUhQTld6?=
 =?utf-8?B?QlNQbWtkS1pSRVdGamdEWmN6ZGFBNlJhdUY0a3hiTjMxakZERWE5U09adEsx?=
 =?utf-8?Q?tKCFfikzwloL0I2Ggn4bv3ccmC9Miy1AJGDvCwUDi/Zm?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-W9aZEBLwnMAziiiz42I7"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uhOOBxvoNFVgBxiML9XcklypcVWJPS+Fi5N1Rb1wAnoTAv8BoxYOLb3XAZcjSR164GM1kYiyfQKuDeRF7OISOqCFJsJYPomLWdMTB4gyfrDCqg2DtjJOnrMNQxZhAQflT+O/jBLancnB9/e1kyuqOPOL1BrRsjGHVmZuuDlLL7n63s8c9TP+xfyto43AfvAx0bSRr9k0RMa5hOTTBgmLFnO03x+LvCLLB6D09JoPyvLUbiHqctbeNpXFcIzT35XdqmddtOIBM+N9WNlfyRAiXw01R8TsgmtD99/HcCAZ5HjBc7AQjvQOeBVXmGbcXp6EQVzoVC31E2b3VVftVvhPWG/mLuB/xpLxOei449XQCw51TKMct9RqVUkPKmTMmPJcdKuDdYocPrQxqzdvWxzAzZHWY4RUDZyr2lUcNxP1o7SzwZPy8Qb6X9qjEV0wSyxy41G/CdXHvLoSiqzdwaG8l0vc0lk+Lnnruk4WLVpvzKelPlifSDelhoHswaaqupEDp0Rw0wH79so1KM19MD0F//flvtCvN0WaNEqC2zxV8cGEE5jPTXvONMSKSIi1Xr5WlmcJzUfCk16+GtArK31oqnSm9cdc2uYLRx1cicl1Y5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2974d143-5b83-4e18-d44a-08dc5f9f07ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 11:59:41.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80MoVsSDxbfoCJdq9Ft93xEpR8KPoGpBHzF7Lb1AXxUvugfnB9zu5o75u7u7RTsklkj2FLvnZMx1tXfy6MlnagyZ57jE0VJUWtbboUwoxp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_10,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180085
X-Proofpoint-GUID: UerYFLX5mOT4vytleE4GhaoYPYejBxR4
X-Proofpoint-ORIG-GUID: UerYFLX5mOT4vytleE4GhaoYPYejBxR4

--=-W9aZEBLwnMAziiiz42I7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> In the Linux kernel, the following vulnerability has been resolved:
>=20
> tracing/trigger: Fix to return error if failed to alloc snapshot
>=20
> Fix register_snapshot_trigger() to return error code if it failed to
> allocate a snapshot instead of 0 (success). Unless that, it will register
> snapshot trigger without an error.

This commit is problematic on 4.19.y, 5.4.y, 5.10.y, and 5.15.y,
and should be reversed, and this CVE should be rejected for those
versions.

The return value should be 0 on failure, because in the functions
event_trigger_callback() and event_enable_trigger_func(), we have:

	ret =3D cmd_ops->reg(glob, trigger_ops, trigger_data, file);
	/*
	 * The above returns on success the # of functions enabled,
	 * but if it didn't find any functions it returns zero.
	 * Consider no functions a failure too.
	 */
	if (!ret) {
		ret =3D -ENOENT;

Thus, the commit breaks this assumption.

This commit needs b8cc44a4d3c1 ("tracing: Remove logic for registering
multiple event triggers at a time") as a prerequisite, as it removes
the above.

Thanks,
Siddh

--=-W9aZEBLwnMAziiiz42I7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmYhCw0ACgkQBwq/MEwk
8ipm/Q/9Fw0bVZiofCcny1J5qEdsjy9m5J9Q+BW6GmFAV9Wam3m6HmASk9udrDWp
HY88I51/ds8KaoLUzMBtEU7liB/qvpO6POkzuX5DkqWSseN/4aU08uXvdw5HppwW
SQmgh7sKKzcm1xgjCJJc3zrZexL2I4JOBU0LBzlCQq7oatp9Se6G9Y1Mq2Ke3Nv/
hNyRweCSnunhZaAMWF2y2yncGPoarA8DXghK5FyxYS9rxpd/qXQ8fl84uzTZTfS3
5xdWOm2TZd9utGMIwmONyHZSVvZnUBytxB1f3oA11ZjfoGjCw0r8iimm1yn3japJ
FU+fZqictFl+5ChwNLr/+s2DkZx2dWCD0DYiFrP8U1cqkbKCQcimbAOUT2o1egVB
KESCDL75ljTQFICt+QiuFd3h/rMt1pKJRKLRQG7hmlYQhuW1600LP3ko8dLnjQ5i
5ReChVDawZl7+ir20Nqe20rErGgXSxVHYxrUiv2IFoA2v3ABI72wH/nUyB2lBtDv
gWr++k9/5XXNJ7+QVpIZMSi/S20w6xo7OufaJmfKOfdbrsH+Z4ZcIXUyjs0lqT0I
iIJtGWO57BxzgjITS6CGu/G85JdffHP89FbLI6E+PAJvH6XGyut3Fb1HTWJ0E/QX
GOdLaCYSn4VHaRmb1O9/VIdtsRkku0LBDX9eRn/qpSeGyRl7uL0=
=WAXp
-----END PGP SIGNATURE-----

--=-W9aZEBLwnMAziiiz42I7--

