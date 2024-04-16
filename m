Return-Path: <linux-kernel+bounces-147339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC38A72B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F3B1F21FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB9134405;
	Tue, 16 Apr 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnl3nh5S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TLGYAWvH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089012EBCE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290088; cv=fail; b=XmsUWFl0BB+QCWCYnJ7K4z0Kyt2//6TT4IfFrEzWpdV6ehAvOcxCDblX/8cg9ohB1u4JwvEZ/Pd6u6ywpNwAs2vpTmMB+r3V30PspHwoAVWErXZD2mdMWEtAyYFNZ33imkijRFMd3T1UzM7F15gzdofaXq/iMvQVmFqGefzdDwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290088; c=relaxed/simple;
	bh=evbKEKPXDjkehjLeG/UtsB2oYbESEUBlwVgXUUZq83Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TFhyYK6S3VBwnsCGgrKXi2ne922Gxvrd1faJyWK/TYv8SQ1kGaCFKBf86Vb63oUX36WzzwbCCIswTJjDoWPbJCAlLrpYshgirtrL3IeMeucm7sDxx++LQosP6M4RXv/zG7VzPO/IL8IXtLoI8N8mKhvAH/OZRSxKDHmI2Q4bR94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jnl3nh5S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TLGYAWvH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHhxTm006225;
	Tue, 16 Apr 2024 17:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+bTsnJnSnLIU/lhCBdXtOqwhQ1Hu/+KP+9xm5D+xu0c=;
 b=jnl3nh5SKIRo/KCHBAWO3uIEB9gNyNNwKEYDy83nipTU/87bmV/ezqcZPRX74KMjpXaD
 tdsNt8IieIm4cIWHD6maAEStedzdI51OumpZC1NPZHSxHT0fp/ITvlsyZk9CeuhD2B4o
 SQ56vAn7Eoxbyh1Lf74vN0I1SOe71aGm50yaN8qL/psSOpxwN1HOOPf8NxH9foMm/dPI
 WplLV6s7HkbNEaoEAZDsC0Hx0mNBJKtvnbbEfunnJlRnjQPzisFltl9pNznZxwkD4Xpy
 vAFmm0i3UIv+6aS6iQqdlYtlGZERXB75LPamVe1jv/Mk7uMWsoeqlUBYxwoAtWgU7kf1 Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffdyg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 17:54:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHBhQU029207;
	Tue, 16 Apr 2024 17:54:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7kshn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 17:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww7mLxOf4hTuWWKYS88kS+z4U65zWbPkW2fI+u0k/67D3VPetPJafm5stLGuQQkTfte3RkqoPxnxVjH5V1crtUXXFUJz2VeqF6+Dq23kCOnD1fGa++L56mO7dhQONAbK2cPEnXd0LyN0uDHVbF9CMY1YxGRwZtltXQJGVo/XkqOcN5KzxBGo26+WE+iQxa/vHXxIKRP0IxiIsiTCCFLLIDGmLymud87k1NVi81EHuVRqJkjkakRs1gJvYwUnZ3MmBzQD+Uc5tjLWeWfEtdf1nvs/OO9V872XKsn4ciA3n5g2NnbtyCpLwtNhiMwTPp6gmBprmQ9I6ufREMivoj/hEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bTsnJnSnLIU/lhCBdXtOqwhQ1Hu/+KP+9xm5D+xu0c=;
 b=GCHK8v0ER1huP65jq0yXckU6yQzTY8NtxNPYAcNiT1y0DzY1WKT7+XgW9jQxwDSZeosW0mt7NYpJGJczJLeebeRuooKnTnyWv1xrJIA+vPLlnm7ETZWXfjaRNLi/qutRpoStDN430QEvs8GE9brHs6+f7cNZ7S1S2WOmVnLCaBXXJSb5AwbufaW8GF9pxjqIYkOxeKKSAlNqZBVctCvYhQ8MurywBysSdMG8a7P27okdvJq62mvhj2uHtplOg9tc3UxY0DFvQzPzuxFeAB7zjMlXQMVD1sZSe9U0PuL7LzOz9cu5mOf7DfWdhep5sQoplwCmfvrhZJW6IZJe7NgkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bTsnJnSnLIU/lhCBdXtOqwhQ1Hu/+KP+9xm5D+xu0c=;
 b=TLGYAWvHndKR/FzOpA9GzEX4Pgg9QxH+wW+jwIar1EJR3W3DQ8hP52rLyOnor5h7tK/y4cCxzDNHLDOa6T0ZPnD4KQhDJHrekHUfDzVlID7MEtTaslWBXh/7ukAUv7Z1dtnONKyBKM+CW1jPj6aWlLMP9LybInBeoIih9UjgQD4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH0PR10MB5066.namprd10.prod.outlook.com (2603:10b6:610:c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:54:22 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:54:22 +0000
Message-ID: <ae710a51-09b4-4829-877b-0f88d7da8714@oracle.com>
Date: Tue, 16 Apr 2024 10:54:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: naoya.horiguchi@nec.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240412025754.1897615-1-linmiaohe@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20240412025754.1897615-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0038.namprd20.prod.outlook.com
 (2603:10b6:208:235::7) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH0PR10MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 692e61d0-a0e6-4061-a06c-08dc5e3e3eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8iTAyvbIrYNEgaRVhEb2UrXNfsjaLuiYSGVxyYQzLL/zaHyCEYQSdPhaYtVHmC7PBatcRN3vXwMo265K7Jz9vjGhjq1E/Y/1JawRnSSmAZ9PvDRc965GEGdQQnjiu49QSYzbeezUCMPfBzVVjQoowNtD2XFajvXu5gaMMii7WYcb16KtUnZUyRt65JYrSSmSL78nYaQzgwKh1K2RDZR2QBwtYNXT/307rHbjjXZDLfjeWPvjBUbGM1zOKPubnC0D8c2uS1fxCywwmaGV/FKbpUSkKABwjPAXQfwH4WJQ410KPNVvSe5J8sEPNRKH8tu5LjLLRQTbGObR5nmSzfVCJB3RMj06WYpsH+MyeQWDGUXs9yZTG5jos08rAGxSpYTmvEBgKXY5mhLlo42qzfih7m5adGLqOjII8xKJ3117ALSKGtEYM6DF9Crlu4KljU0ZO26+mZOOnarupw2HETOdyWtclMfyPj836IGnf5u0RrQs5FaNXn1WA6t4ahUVK+L2WAqIcLqg4R8yIWmLiDvlN4WUqS2kYy/JFR4PeJ6k4nbyG7Dbh4myDGssPokJ4Dzg4m6rBVr78TP0jQMLi2KoMvJVVaQFxbr0HjL0hidb6Gph6r2arewrO8NNXP8Z+XoIhh7NvMUDXTn5kINgVJIfcaHlFcO4YCIst9/XF9tZnHo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2xYVVk2UnFDMS9ab1BXRGVPTGtIMFZaYThJOGMwd3B3VVlxQW5BdnA1MG9X?=
 =?utf-8?B?SXpTaXVOd1diOER0cWVJM0dJMVFKdE4zdEZ1UDR0Vm84Q3ZyeVlwTThGb1hQ?=
 =?utf-8?B?VnM5aitUUDBSNllHNExMZW9Za3lSSE1Qb1pMbkUzSExtYllKT0hyMXdJT0I0?=
 =?utf-8?B?SmpxR0lKWFJCMFl2T1BteFFpS2MrWG5IVHlJbnF1dDNXZDEzMkJQODBRa2RL?=
 =?utf-8?B?UExBdE80U1NQQjh5UDhBZUlRVFN3Y2NsclVHeUNwT1hUdDlZNmlHZlBMVHBr?=
 =?utf-8?B?bFo2RFE2cFAyak9jRnVYWXRIaVNtQW9XZCtqcllZdjFYM1pESlpjUGFkNTBN?=
 =?utf-8?B?c3Ric1lkdFlOTStMMUk1eVk1YW1VZFhkLzFscUVGUWZFTVJVVnNHQ2xaaGF2?=
 =?utf-8?B?NFo0ZSt1bXRIdUNqNzQwWU96Y3pYSlhnSmlrRkJHcEtxT1BUU2pySHVxVFI1?=
 =?utf-8?B?VEQ0TEZFL05wbFBlVGtPZm9jbmwzNkJOZ0h6Y3ZNcEx0Y0hraGdYcklrZ2dJ?=
 =?utf-8?B?cUhkc01tVVdmOEoxMHh0VUd6dk1oRzJHNktkSWxZMVBVQUZIU2JTWURpU3pU?=
 =?utf-8?B?VDZuaWpBV0ZYT2tpd2xBMjd4QkduaDl4OEZ3VlN0NkFWZTMxU0ZsR0ZuY0do?=
 =?utf-8?B?M0VvSERkdVUrS0JVZnp0bmdUWHRodnc4RGU2a2NGdjJRYnRUZ0Q2Zm9KNE5O?=
 =?utf-8?B?NzJJZ3dnc0FMMjBidGx1LzhmRmZ2cWdHTnVabTJpcGpqZ1VPVTBzcnI4TUJl?=
 =?utf-8?B?TC9zMk15bTNGc0owWFkzNmhlTEZ5MlhUUHpuWWVKSFlyQnhCUWZ0S3puQVZW?=
 =?utf-8?B?WHZ3WkxEQ0dsOXc4RitnTkdURWxDMTBjOWZyOHpiTG1nbmRGeXRRL3VmUU8v?=
 =?utf-8?B?WVU2c2JaSnM5OG9pbGI5czA4V1YrTlpIL0dqd1pLVVBKaEpnaUJIRW5PTFRZ?=
 =?utf-8?B?aTVQUTBReWU4YmNwb3VhVGt5NWJtSWkyTlNSRi9sNzF4anl5UjNTbXFjcUs0?=
 =?utf-8?B?VEdWdzR6WlZkbDdlbnhaT0JzWmwxREpVUnVvRzF1TlN2ZGxwMjdqT1dVS2lN?=
 =?utf-8?B?d2JOS2ZoY1JQcWtKNXlKaVZCVGZFY25iRHhOb1UyejVVeWJIbXpqSi9BaXUy?=
 =?utf-8?B?N1RPQkhKUUYxR01oa0JzaE02dWdjQ2dxUitmNlcydUsvQTRPSHhtaVBLWng5?=
 =?utf-8?B?TXozTjZ3VitQdVFWZERnNzdXVER2YXl2RGRvWEliZy9FNmFGOUlMV1JNR3Fv?=
 =?utf-8?B?bkFpbzJjQWFiN3hZeDdDZ2VTN2MzZWdmY2JIRk5sbjNycVJtc2JoOWtQSE1h?=
 =?utf-8?B?SnZkcytldE9KY0dhVkkydGkwdkRxMnI1cGFEbTVBeHZ1Z2M5YXN3eUdRc0E3?=
 =?utf-8?B?a2wyQjJWaFp1WU5SZTVneXdMOHJzRGI3YlV6NDRjUkNCZktYeHBVSDVkVVdu?=
 =?utf-8?B?ZVR4dWppZ3JPd1VhWWFXV0duZG4vQ1FEMk5ndklHSnBBWmxhOHN5U09SOFRm?=
 =?utf-8?B?U01uUTVqbzAxaXdhcjB1NllIejZSUFN2SkNNTVZ0N01XTEt2Q1ZpNUhuNFJs?=
 =?utf-8?B?UHRwczhmZUQvdVRpZXF0VkwrWVM0M3dFd21wNFkrVzVsY2lnQnZyZ2MwUGky?=
 =?utf-8?B?alpjNE03WVFpcGt5b3hTY0YwOUZMRnpsY3lObTk1ZjZMcGdjb3RXcjE3NjI0?=
 =?utf-8?B?d3NsZ1AyWjhXWHJXKzhlWGtLM1lmbTRacHppNmxEWEJXZE1ET3dqREpKUVUx?=
 =?utf-8?B?MVFIRzExOWlabk02azlNSVgvY2RqNjhoelFUUCtha2puSVg1ZlBmQkZSbDdm?=
 =?utf-8?B?RU5EeGVldEJZajZzMXlhd2FaaHNqb2g1NzhQQ3dhclFYdjIrNzJ6ampJbWV3?=
 =?utf-8?B?SVkzQzcyMUIxVER1Y0dDVVJOMkRJVVNkeEJjdzZPemV0bjc3aGpWSzNZbTBE?=
 =?utf-8?B?R1VVcDJTR1p6Mm9vUThaKzB4TS9na1d0VGtmWEpOVFRLYVN0cmRLMDArVyts?=
 =?utf-8?B?STlCYnUveG5UcElES29wcjc4SXBGaVkzYkF4VXNsRkp5TGhZTTVmdjNiWE1Q?=
 =?utf-8?B?akpwckVaUE95TGt0Z2RQeUxVeFRWUjR2QzJ3VnBHTzVsUUVFS09wczhaTFVp?=
 =?utf-8?Q?f9N4x1gVvp9EU8NY54E5Iu+Is?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QkGqeQhR+OZqAoIloSsVG55ZN5JE2ehj/e38nWj4yORW7tWefuwsGYhD+JhwHAKAWTFmg5FclJWxHOPBk2NEOt5kP5a2Yinu7/XoUCBNefvFeUv30vIbnBiEGLyB0dbP00rrYHC9vtuo042RMWHcbcIDgG5fVlukHaG/zcmTvb0+/iSdkULx7OgesciAozkg6PDm3kblmn1fPNNk3ovMr0tVInDFbcseHDc7CiTsMnkfXANQsR++IyADKttapu6M2drF/vZxRZWjlspATgrswJWHrQkVCAJlmQ8ZI5BtHpiEMtnkEbQfeC24uhHdKEg+CYF5WxUJRHjgd2EysEM56UfQHPiikcLvh1B6HHR8DjXIsGHZ9dR7eBdHJanhoY90amqfqodWysaGl6n139e8eH71RHhxr4tnMcsR3I3ODDZn3qyaQ5+h8I/3parREVfumRzgBelwqfY1hsJ6WNv7NwrjluN/d9R4F10Sz+7DjyzoatjXucX9TjbHPejtjPvKRUlQFTZvGDvINrC/+Foagj8jWDvrl2HJvSmpOD0ccJyhNz2shCHcIOF08fyGohpxhoe//4E7pgNyhgYb40rOftE2zI0654atxjsqIU/b6+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e61d0-a0e6-4061-a06c-08dc5e3e3eff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:54:22.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBIzZUh6lOqAmjepWLz+jylDLraHJiGAdjB3/LHSqesnptDUJ0oeMY+cjijtfHx69Yhl+4kxI/7MvHmEXwhHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160111
X-Proofpoint-ORIG-GUID: RVxGohJXOYiy9qKncTGyG5U2jnQ1_l6w
X-Proofpoint-GUID: RVxGohJXOYiy9qKncTGyG5U2jnQ1_l6w

On 4/11/2024 7:57 PM, Miaohe Lin wrote:

> When I did hard offline test with hugetlb pages, below deadlock occurs:
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-11409-gf6cef5f8c37f #1 Not tainted
> ------------------------------------------------------
> bash/46904 is trying to acquire lock:
> ffffffffabe68910 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_dec+0x16/0x60
>
> but task is already holding lock:
> ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (pcp_batch_high_lock){+.+.}-{3:3}:
>         __mutex_lock+0x6c/0x770
>         page_alloc_cpu_online+0x3c/0x70
>         cpuhp_invoke_callback+0x397/0x5f0
>         __cpuhp_invoke_callback_range+0x71/0xe0
>         _cpu_up+0xeb/0x210
>         cpu_up+0x91/0xe0
>         cpuhp_bringup_mask+0x49/0xb0
>         bringup_nonboot_cpus+0xb7/0xe0
>         smp_init+0x25/0xa0
>         kernel_init_freeable+0x15f/0x3e0
>         kernel_init+0x15/0x1b0
>         ret_from_fork+0x2f/0x50
>         ret_from_fork_asm+0x1a/0x30
>
> -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         __lock_acquire+0x1298/0x1cd0
>         lock_acquire+0xc0/0x2b0
>         cpus_read_lock+0x2a/0xc0
>         static_key_slow_dec+0x16/0x60
>         __hugetlb_vmemmap_restore_folio+0x1b9/0x200
>         dissolve_free_huge_page+0x211/0x260
>         __page_handle_poison+0x45/0xc0
>         memory_failure+0x65e/0xc70
>         hard_offline_page_store+0x55/0xa0
>         kernfs_fop_write_iter+0x12c/0x1d0
>         vfs_write+0x387/0x550
>         ksys_write+0x64/0xe0
>         do_syscall_64+0xca/0x1e0
>         entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> other info that might help us debug this:
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(pcp_batch_high_lock);
>                                 lock(cpu_hotplug_lock);
>                                 lock(pcp_batch_high_lock);
>    rlock(cpu_hotplug_lock);
>
>   *** DEADLOCK ***
>
> 5 locks held by bash/46904:
>   #0: ffff98f6c3bb23f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
>   #1: ffff98f6c328e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
>   #2: ffff98ef83b31890 (kn->active#113){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
>   #3: ffffffffabf9db48 (mf_mutex){+.+.}-{3:3}, at: memory_failure+0x44/0xc70
>   #4: ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40
>
> stack backtrace:
> CPU: 10 PID: 46904 Comm: bash Kdump: loaded Not tainted 6.8.0-11409-gf6cef5f8c37f #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x68/0xa0
>   check_noncircular+0x129/0x140
>   __lock_acquire+0x1298/0x1cd0
>   lock_acquire+0xc0/0x2b0
>   cpus_read_lock+0x2a/0xc0
>   static_key_slow_dec+0x16/0x60
>   __hugetlb_vmemmap_restore_folio+0x1b9/0x200
>   dissolve_free_huge_page+0x211/0x260
>   __page_handle_poison+0x45/0xc0
>   memory_failure+0x65e/0xc70
>   hard_offline_page_store+0x55/0xa0
>   kernfs_fop_write_iter+0x12c/0x1d0
>   vfs_write+0x387/0x550
>   ksys_write+0x64/0xe0
>   do_syscall_64+0xca/0x1e0
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fc862314887
> Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007fff19311268 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fc862314887
> RDX: 000000000000000c RSI: 000056405645fe10 RDI: 0000000000000001
> RBP: 000056405645fe10 R08: 00007fc8623d1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
> R13: 00007fc86241b780 R14: 00007fc862417600 R15: 00007fc862416a00
>
> In short, below scene breaks the lock dependency chain:
>
>   memory_failure
>    __page_handle_poison
>     zone_pcp_disable -- lock(pcp_batch_high_lock)
>     dissolve_free_huge_page
>      __hugetlb_vmemmap_restore_folio
>       static_key_slow_dec
>        cpus_read_lock -- rlock(cpu_hotplug_lock)
>
> Fix this by calling drain_all_pages() instead.
>
> Fixes: a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> ---
> v2:
>   collect Acked-by tag and extend comment per Oscar. Thanks.
> ---
>   mm/memory-failure.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index edd6e114462f..c6750509d74c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -153,11 +153,21 @@ static int __page_handle_poison(struct page *page)
>   {
>   	int ret;
>   
> -	zone_pcp_disable(page_zone(page));
> +	/*
> +	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
> +	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
> +	 * when hugetlb vmemmap optimization is enabled. This will break current lock
> +	 * dependency chain and leads to deadlock.
> +	 * Disabling pcp before dissolving the page was a deterministic approach because
> +	 * we made sure that those pages cannot end up in any PCP list. Draining PCP lists
> +	 * expels those pages to the buddy system, but nothing guarantees that those pages
> +	 * do not get back to a PCP queue if we need to refill those.
> +	 */
>   	ret = dissolve_free_huge_page(page);
> -	if (!ret)
> +	if (!ret) {
> +		drain_all_pages(page_zone(page));
>   		ret = take_page_off_buddy(page);
> -	zone_pcp_enable(page_zone(page));
> +	}
>   
>   	return ret;
>   }

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane


