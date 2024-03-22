Return-Path: <linux-kernel+bounces-111273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBA8869F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031521F25FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF9636AF3;
	Fri, 22 Mar 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKEsv/CR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P6r9TYrb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5424A0D;
	Fri, 22 Mar 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102063; cv=fail; b=TwfaEvqLBXgiPEX9PUeRj1tlatkvNL7X5YR2vGsZRTUNZ+1bG9wDo+5evB4xwUb51FolQYNLdYtR8VRhxvWDFSe7G6TGYZbrOPB8Cm4z8BjKQd3Ry2RKj5AxYEpxkqj9TOlwa0Txz1P4ercScSJaj+4dDGiV3KiRVLRpraihgMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102063; c=relaxed/simple;
	bh=8bXUFY07kcCZHUgJx7JVD4yFTg6ydfkTZZco2MvjPnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdQIA/aAg+uxeez7ch+TemlM2XrzZ8g4wYSTcF77R+/BiGPkVBC/R8Z5yY8SSRzumWp0bsP+FiSBHDxyE1EzmNtjGDUPviuuP5FNLzebSAFkf9Q1f7wUpWVgftZYkObU7PhCIKwajAH33hxu75VyzLKDppSG3NoT/BxcD0O/pOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YKEsv/CR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P6r9TYrb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y7dO004098;
	Fri, 22 Mar 2024 10:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=99IpJJtAPfY6b+9fG23jv0nWO31VbrQZ9ZJMZk2DmXs=;
 b=YKEsv/CRAolMuX8ivyGcK9q2E2HEMiFOkmniBvDpr58bDoVdIG+40FSd3/0ptTYusMNX
 G1IY3wI55ZoWRdzhTf2Ue78xKn+aw2KbPgckRB5sDVsGHJ292ck6pAVH0BdcsZXvlrzt
 XFVZ0Qh7OABcUeimevlI58nrPId2dAgBe01U44j1s+lpRrPv/m5mKnPazZvGmrGGvMtL
 ipG8jFxVwSdBf+3z7Q95gIdTLDPj0bqIRtkD/zCbn/f7r4Z/TyYJg3a5p627mPQRPJNW
 3v9eqR6XUP0gOUe583GSs0yoF+xsOwcMMCFqatXNPyK6etL2ncgAPdi+mDat65xLSTvQ EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvk8sfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:07:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9EWOp012743;
	Fri, 22 Mar 2024 10:07:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvfst6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrR0eZ+KjD4IhOw49K+Sno2LSVNTSnq9yrAyDeclkN+ti5fwkLM/+3Zsp23WquFfti8NKQywgAy9ux/Dz5DnOIdfgcRVUlMzfU5r7OtUwd7mUH0DftwIPnf+cMCMZXdTq0tkCvk9u+B2ifwB6Z4uCs12hgbAtms/miCJw/idTpJn6u0YpOlyxCcunhaRnlvn/8jKjx2eCs18N9m5mbYLhmnNdh3wKd3ypXIqgtx5UOOMvOhoSGOBwQvgLKJmk6bjPuWmE25lpTgj5v8keXY2lHaP88YNucYTwvt9B39Bt+5L866zoF1BZPaLYT27v3hV6neHMSl3G4FwGX3lrdC4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99IpJJtAPfY6b+9fG23jv0nWO31VbrQZ9ZJMZk2DmXs=;
 b=W9rSJLgga9mAzQtvd/K+NSdXUGLK4u6wUnWQYL004ijV7xGhAr5XqI/q6Bbab5ps/+25Q/nNP7JxYnIJZAo9II5RM7z2+RWpUO5DOVqTjnQWlPqq9veA4ZG1es7TVAYdqJooRKg0E8oeo1KmPatNWFmxvBYGW1kzWPfufG/LlRYlwRwD68/zVsm2mqaRBiDvRf0S2YmWul0BJjeEdOhriK5T0nbbrDx7XPqvRDm1UQvbUhM0vAtBbGAuglDbQmqT1vqoA4/QYeUsCZ2x+lQdmsO32sqt2996bHN5zbGr3e/9aDSgAHh1XX9pvvlessefMdeHs29n1ELXB2O53Q3L5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99IpJJtAPfY6b+9fG23jv0nWO31VbrQZ9ZJMZk2DmXs=;
 b=P6r9TYrbppe3Xau4vCFGMuqiJO5VqebB1jwTMSvqsdsyPEuLfBNtdIzRFEP4jLG4AO9IzifJVmbWEXx9H1PCp0Y2l5n60KKO7musv4W2ll1I+vCTUGPxehn4FIS6VhoKjrQWTww8jEejt+PfeexobmhgwlNmV8ulFnu8BQncHgo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 10:07:05 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 10:07:04 +0000
Message-ID: <49fa2bd1-bd6e-4404-a1c7-2170d37f0194@oracle.com>
Date: Fri, 22 Mar 2024 10:07:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: disable pahole multithreading for reproducible
 builds
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 358db59d-99fc-49a2-4856-08dc4a57d32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lj4YwLD0l9fOMe589kq0CcRiUjMHqp5/p5eyvwLHcJ0tXXS2S0vEXnftwtenscUGf/8cJ6Tnikuu0yXpK5S7tDLLVweMU4+zoCF7KKnI93jMnIemS3ctgOB8IA+lbBMd5xTd2GkjBc5vsWKRZmHGtAjumSeg6t+q/0iZsqZ5/VD2o32eT2K6yKQTf+1Hloh8zvNZERy0bb5VFaLV8XQg7GRnEKb3ZJ01uy9/0JuvMeqGRQ2srRCNecajhk+YhYXvX7bEktDyf45gq6EquHD+49YstwzKKsZZ77DFVfZHmTdKJCECqNq084XXcOyaX30gHnA+BAU+/TFDp/CKhpMgqRgwDvEqMgfVdidgXYGt/27OCxIXYCQC1DRZtPQ8oyWXeaOQBNuoSSKN6DhtLjnU362Vv1T2LFNcWHijuj8XSNW1ylJI/Z0ltLvzt5gDRBiuCS0Q/3CG8blxwRgklqBYIZyNlLTnsUTy0KRr5JPaQ+k210qVzuo2XokaEEQkzGLNPuWVaFO6ihuCm8OaDDFsCI5Oyhw3vq0g5M7zVrCu+Z3lJ/Z3CKmd522n0NzB7c6Ly8ddlguWUhynZVtIJKtgde3UoCaAgsw9oFNv4I+tL6X8d+hNeI2nsshfhhvJJE15u0V8Cmbx/xpDxMZ2sB4nSA8X+ZGyQUV3nJ86rmdbOtwoRf3NDqOYdk4erHMN7yYKb5MTgqoHuHyqQ/1RB6Dg5A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2p4ZEx1THl2emJKRk1kbGN3L1NyZFdRVlNFWFhva3dId2lwc0tTS252Njhk?=
 =?utf-8?B?VDdGL2pZaEthdGhLWjdBZkFqZWpVQnFnbU1UWXhlZE9QU2xVMjVWUjBsRlJ4?=
 =?utf-8?B?NHV5cWJKaEdOUDJyMUhVTXZQUU9MNW9XS1lHbnd4akZkakQ4SHFCWG9TaFoz?=
 =?utf-8?B?M1J2MlNWNTdmUmU4cGNiZ3NXeTU1MTNLZ1A1Z092SWZjVmtKNy8rQkVpZFp2?=
 =?utf-8?B?S1JMemtxSlhYajNGZEFIQUM5R1VhMk4wSDRXamVpQVNoZDhobUtCTDgxVUVW?=
 =?utf-8?B?eU5mVnhXVk9tNG9rWm1VUURQYXhMS014dGF1NDVuR2NyKzk0TW1icHlJRm5K?=
 =?utf-8?B?TWdTZHROUWVKbzZ2VEhHYzgrWlduNVdiUnpqdS9uZHh1MTZoUS9SaFVNcGVv?=
 =?utf-8?B?aEJtZFp0RkhNS2ZXcGVpQVc4UXdwcklQOUJWeGtZTERsTkNmYWk1bUxvYkN1?=
 =?utf-8?B?TVhZYWFKVGNtMUIxbUtRb3VOa2k5UUJpcm9rRFVaeDNOL3VKWHE5NURpTExY?=
 =?utf-8?B?ZmpsSklxQ0oyT2UveXYzSVBGbURQRWJMOFQ0NG90YWtnaHJ4N0RVc3Y4Yk1J?=
 =?utf-8?B?cEpxUmtnS1ExZ1hUOUh6MnJGZFNBSFV0T09WWXBmZVFvUGw0TSt1MWtrS0pE?=
 =?utf-8?B?emZ5MlFQcVVrUGE2L1M1cEZ2b3J6eXdsYjZuQ3o4MGFmY1ZuT0RCd3lrQTB1?=
 =?utf-8?B?bDBLMlBLLzJJZWxONmdpNlE1ZVdvUXlRZk1ENjhUM28yWFZnK2hXVGJRMDNH?=
 =?utf-8?B?dnNuclN0Z2dZRnpXU1VKbHFORzFkWFpmeXpOdVFaZDhKekZTdmlpa0RFbm01?=
 =?utf-8?B?L2c1LzdmVkVhbmc4dXhCZTYxVUtXekJZTi9PMUpVVXR1N2JYbTJTdEZCQkRV?=
 =?utf-8?B?dityMDZqUllNdXpHdlJVMVBjOXc0Y2VLYzZBdTBUNHhrSkZKUGZrZTJGRnQ0?=
 =?utf-8?B?WGZvWUhSQlNUNkc2U0h3TytUalhCOC9VWEc4ZWJTOTFwOEExRldBK2crWjF3?=
 =?utf-8?B?NFlMTSt3NUlEdVJhOWh4TnVRRVIyS2xWMzF3cmpuTFBucWJrWnVzckgydTBH?=
 =?utf-8?B?dGdGYUlIVDk5bTBuM0lTMVR0czV2Rkk1T0k5bnNoMmIxVko4RlE4c2RlVWZJ?=
 =?utf-8?B?VlV4Q3RYVWdoaFVWQnVlVkZ0YjhuTDJVSk4xcm1zMmYwSjJLSXVCelIwT3lz?=
 =?utf-8?B?NDN3dzF4SGY1Mk9lS3oyRmNsTUsxSXBGaVFKZk5VZ0tMNTArcGE2NWg5Vk9w?=
 =?utf-8?B?djZkdU9UNElKaWNvYmRONFVHaXNBcUZrbmlIay9PbGh5VmlzckFxeGNBV0tm?=
 =?utf-8?B?cUJXOEpEMTVFOTNXMXZwR1JKLytkalY1NGlsMWdhcmpSZEJabzdHQ2hiM01H?=
 =?utf-8?B?ck1xek1hR3V4cWphaUd5dEVobUNqVjhDd3lWVTVweE5Pc2pnU1RMRW1uSlZx?=
 =?utf-8?B?Qy8xUFNBd3k5VFFBeHZxOGZsMFhXdkVKTThjWFFrOGdOejJNc2NUcDA4eEU3?=
 =?utf-8?B?dmVIN3pKTDVnVjVMeStpeWdjVjN5ZnUzMTJReHpOQUZHeGFZVmVFTCtqMmN0?=
 =?utf-8?B?Z1VrQkx5ZHhjZFhiem0zMWwzV0w5RGNHTXFTUWdycVNvMU5BSGROdGlwK3BU?=
 =?utf-8?B?MVppK3RGeThNUHRJOUlLNHlEemJRSC9icFllVzIzUVc5dEkrTVllUDhXTkdF?=
 =?utf-8?B?RkxrWUlnbzV4eEFnL0xxQU8vYkVJV3l2VDgzRmtiNXNKbWJnUStrQ1pPbDly?=
 =?utf-8?B?ODNvYmt4T1VYc21TVEV1QzA3VnRRemxkejVwM253QjBOSVh0SWtWS2pCVnNG?=
 =?utf-8?B?bG5ic3l5MHJRc1JIaFRaZ2FxQ3JOb0d3bitUN0N5eDUwTjFIWWUzUHJOYjZh?=
 =?utf-8?B?NUhmT3o3Q0Q3ZE9VNCtUeDVDSUxHUnF3U0YrbndrYko4YTBIQUs4K045bjlk?=
 =?utf-8?B?cDF0OHp2NWRxQWhaazBRdkF3eDZYZUp6MVRjQnZNK3NQelNZa0YxYTRkUGFW?=
 =?utf-8?B?TTZlUjV3d0p4TTVWKzl1Y2E4WFVrWGxtVEJtUmJ5dTVFT0NXK1draWlSWjUy?=
 =?utf-8?B?cW1DQ21uUVIxeVRsVjNPWFBvTWxscUxpbkpYMEtwcHhWS0k4cE5mckhtUTZi?=
 =?utf-8?B?MUdyWFBBWnBOb0VtSTduNXByK2ZEQXY1R3VOSHU2ay9GU2hZdzF6TEVKNXN2?=
 =?utf-8?Q?bnWoBuPH93K4fcMhy/4O5cw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wCyGnWtE3VdxaWZUexCi/LE/vcYg6I/2Pwr8pmaYiZOBl3x9INlGPXU/IrzCD9fuQT06+T2jLBCyJyB9k73iYfQCmQEjQ5qfRATNJASxFIXSkD6XuxQjDwusye/3C3xekAmMtzAx+iU+OONoQ95dRuoiflItHogYMxvLoEsp3MkYfATxtqpLGmd3KXMMCv3wIQ8ARh+NJsMRlJqJHaUCAjyXVZAhpDu7TJua2+LUteAOm6ElUiGzmSNd7n7i78H7p3zU5AyvZpRmToxXJ7lCbbafM/e2md5JmGKZudevEWSBLpgRLd5jOR+9OqqSAYwqguhCKQoWfFxUFhxKNeSb52THbKXzBdzsqdv5Q43iqAzWBoo/xhaPeXbt9ty784JPFgytssYMwWzJIC3Rdf24k1PSk1uGeW/kVkotdBDthFN4uK5MpoTRZy8Fe12YDfaf2YsgdIGWsT1vCEEU/L3d5uLPodhTrsaj3zi1o+WkxoB1G+sxvIIMUZ7SClSs2y9gN75YH8nXRAzdlMgAYgdullbvo5C/wiY8vin0xzXHiM0GE4QwoCKtq6B5oGk+nRrm/FbVsokA3xAy9N6HSI3kAQaPexfc4vs8hPKexhHjUyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358db59d-99fc-49a2-4856-08dc4a57d32d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 10:07:04.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHZ6WfiZYIb3aW62NGU42hzbHsx1C5JNEUI03DPLYvVGrqZwdMPCp4bIsTTB0/hc0WET8E828u56cyBLNnXDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220071
X-Proofpoint-GUID: m2iE9KaiCuMWarir62dTPbdkmAMso8ae
X-Proofpoint-ORIG-GUID: m2iE9KaiCuMWarir62dTPbdkmAMso8ae

On 22/03/2024 08:31, Thomas Weißschuh wrote:
> A BTF type_id is a numeric identifier allocated by pahole through
> libbpfd. Ids are incremented for each allocation.
> Running pahole multithreaded makes the sequence of allocations
> non-deterministic which also makes the type_id itself non-deterministic.
> As the type_id end up in the binary this breaks reproducibility.
> 
> Therefore, if the kernel is built reproducibly as indicated by
> KBUILD_BUILD_TIMESTAMP, disable threading in pahole.
> 
> Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
> Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Yep, we've talked about sorting final BTF in various ways but until that
is implemented, non-parallel execution of pahole is the best way to get
reliabily-reproducing BTF ids. We should probably update the pahole
manpage to warn about parallel non-deterministic id allocation in the
meantime.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  scripts/Makefile.btf | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 82377e470aed..2356929e62e4 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -10,7 +10,10 @@ endif
>  
>  pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
>  
> +# threaded execution randomizes BTF type_id allocation, breaking reproducibility
> +ifeq ($(KBUILD_BUILD_TIMESTAMP),)
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> +endif
>  
>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
>  
> 
> ---
> base-commit: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
> change-id: 20240322-pahole-reprodicible-02e904e45686
> 
> Best regards,

