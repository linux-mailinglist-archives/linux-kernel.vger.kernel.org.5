Return-Path: <linux-kernel+bounces-143124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3328A34B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1CE1F22CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FC14D70E;
	Fri, 12 Apr 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nh8T1JK9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QYY89Fhd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7814D44E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943039; cv=fail; b=NvRodylw9RMLz3BYWavr7bzE5DUqNYv567DtBHdmwXDqgDYTPxC16vypHgaP6C/rwT6nKsvpfqTqI52dFiSqgKV/s3tsVhT+yu+GZ3TBxH+Jl2Jtw4i3lqua05w1wsH0g1xBkp3+Fcx2J9bHa3HlJah2s7yq0rYx4I55VUpGjlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943039; c=relaxed/simple;
	bh=ZrTtwZm95PnY7NismF4gcOlKAvRDwPkybDfl2Pw3fJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HVnVW0C/EWIBY4Q1bem7oJsC0Li+iDVPboAFJwxDAs74MVVOiDu1zQZtLGRdXlu5/n5cqCNwfPVOV8I5ccF5A6GgrCaxt9Lid6ArU/0el3mdLJU+SvxHQMzr/jOFBQNZhIrHf0FWZ/jlZV4Clwp/pb2bGPIz9Efr0hkX59A82ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nh8T1JK9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QYY89Fhd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CH353K028869;
	Fri, 12 Apr 2024 17:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=K3cEiWDjk5ZmK4zmeuj9Ha8vP8zyNPDO6cGTVlUIQ5A=;
 b=nh8T1JK9dJRvwLjYGGPtEH9wkqYIaJAQomsMCxhKhCX9JbWuni9YigsJ8lNyANV23WFS
 b2ryKboIWQSdTsDDLlufp9ksaUMCzM/kjQ9ocO0VnRnAb/o2Y6batcqe2LufSCblaxwR
 18HORfU5WijgRNqSlm8IqExCmR/T0BpMaQq/PpCAazL4oeKr80D+W+4trIAEGnS0Re4j
 dM0nCGb6I9RLgi2KbZFnBgTiy5+NHYpL+ydje3rBNiKS+g4PfcGikPpKnb0xJ4seKy5G
 sojW5G0e2VIJuOSG14qvb1O/6JEZ9qEYA2x6Rv5MhIoKyzO5SbDtHQXFcJlbzxLVOPp0 nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedvfth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 17:30:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CGtE1i026403;
	Fri, 12 Apr 2024 17:30:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsucv0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 17:30:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGgh5L8U7LhcXzD7ApYikmJa1swX9/9tLfztHbYyG/kcA+B6/y0KtYzGpNgGv3YJ5BpmVhjnFHWBrQRZTlNeNqd9OUiMWmUdgAO8DgIdcps75eiP1MLf64VuUXgnBpA/YdpQPNH0GfSzLzbw8oWg9lmjl1IeXzBlDuMbq+2jrqc/67bGm20MKrnzJWfXZS3soOcibk+KPkPSuH0Wl3Nz30bJqNkFXSCNnrpLzwtm/+N/gFNEzIx1WYf43V8KxvV1pHHmsWWB0PVYyGx4pMlam8lHb+KiifkEFOV1PI3ayOXbjd9mt1tp7wHVdiiZUDVhmQg43u+VTETq1YD0f6MNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3cEiWDjk5ZmK4zmeuj9Ha8vP8zyNPDO6cGTVlUIQ5A=;
 b=SGQSg+0hvxg1wFNGuqzSlQh7WxYWhrt0lysNBiJ8hevpvCquj6vVlGOWfiuEmFnUrqmFhoJJqQndbW9qjWWC/90VY0WkDmwECfxUP32Qm6w9A5FXPD6sQbwOE9Fd0JHR6iBxNm/y4hlNsa3sL/cQa8G7FJ5Hc7OYXj2rgvuG9tkm9rgO1E/ZLWViMiGzHRB+0WB0iMuevHw+kysmVxMiNmBWp+90/8o3UTi/hlC4O/jiprc0KPjd+hwMyVY8cnLtMmvmsju+WPmHKRNwD4gQFSWRqnjByxnHyR6r85E4VLKFKyV2Oda6jN3n4kMVZrvUQwH4EaDXYAjUMt3empSe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3cEiWDjk5ZmK4zmeuj9Ha8vP8zyNPDO6cGTVlUIQ5A=;
 b=QYY89FhdwaT7BaqQ3Xw2s/9opR8O737D+/vWTtXjbmowVPfTSjz/RiLa1UXrS2Du/bVsO/aot20hifb1tOTtWWFo3m4j3WQ6eH50k8EJthIIUUZClV2ofg9ZONniL0VCFdY0RksAOAbMgH0mq+XhsDNxm4Xl6t+vebPjYwKEgZk=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by PH7PR10MB7803.namprd10.prod.outlook.com (2603:10b6:510:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 17:30:19 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 17:30:19 +0000
Message-ID: <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
Date: Fri, 12 Apr 2024 10:29:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] slub: limit number of slabs to scan in
 count_partial()
To: Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        junxiao.bi@oracle.com
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0495.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::20) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|PH7PR10MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbdb4c9-4200-4a64-5d49-08dc5b1639ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P966hBqo28xKSpEe7DovzrsmQwEfl5WmVfewHPRaDr7BU2RE/K0xFKWrjUBJrSCDJBKXXyy8NiVcKkXcI3sXR4mF1niTE/jcRnp1bxgHvqDsYEnMdhpOeDpxUTBu8lHlORUcu4Bs1r2PXQotHFtb8rmKYSDIEweDQj48r5iJLT3O1ddCKwTrglYAzwZv+XJdWdBPJcgs6tbSgxyQtDBCdD6crdSVk8P5xcqshbaMlc7Z/x2nhJ4BtRF0+O2e/8l1vgrtHeEQN8qlzqBUpaY4FGWmpJcrXT+I/ftcei9tgnzWgTa1F7ivLv/VtTlJqp0Z5WR8/i7J+vlmXPPdSS6Cy/sr2NX6AJ7ct6FwBPmb5cvUQbIPmqbkjwClP7FtUw4YSG+Dusbl6R/VmvC0naeP+z7wnLojipvLTkh8p13rOwzQgOXdIRE++KTm9aRUmkNnGFdK0JbP79vBwQPypTpfN0ULLnhifcveu4ZMUOL14S4o5/Lur9zChYv33WWkdW40eJKtSG9a4eHpCMdI+FiT8Jrgtrd2khVC/uIIvCqs0v0uTeM8MroGZJmvrt6qn2rOrg8xbv/Yiv9OmW1iqziZOMuFe5PguO/IAZBAuKLCZP6/KpbNRdZc0kqyndl2+OzePS7Moq3wfeLGiO5WuF8qFZHKLSPtRGsL3rtoyDzCyBQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1BGUmFramx2UlZ3RnpCQXhpemZUYVc1dXVWZGNScVNlclFkdERIU2dJK0ZS?=
 =?utf-8?B?a3VZT2wxc1dRYUx0OUREakM2Y2IrSVVmSGx5MkI4ZVFwZkwycmtENld4M1Er?=
 =?utf-8?B?UW1haFp5SHBLWFhZcXZSVGx5Z05WRDVtMEZHK1MybUJyUll1dXQ3N2JjNVhw?=
 =?utf-8?B?c29LZE8za2xlTG9iLzBZRFljM0pTRkpVV3plSjdGMnhzQkFVZ0UybENDUStH?=
 =?utf-8?B?K0ZJSVF2ZjRVTXA2dit2ZFdYNUlMbG1mMWdoQ3I0aTRpSDRXYWlreFB0OWFQ?=
 =?utf-8?B?Y2M1QXpFbnQ0M1lNOU5UT3lkUFArQ0J4N2hwZk9nU0JLcUU0aU96d2NsS0dh?=
 =?utf-8?B?ZGRURVNyL1FNRUl2dGRDZUlWMW5BbGhtS1BWOEUraTdobXhFWGkvSXhhUUt6?=
 =?utf-8?B?QjVwVVpGWW9JaytqbEo4UXMwOGx2RTdVWk5oQkJJZXhPOGRZYzVvb1hCdHp5?=
 =?utf-8?B?ZDhick5kcDFXbVQrcU5RSlF3WUJ2amorclRNU1Jad0d4TUZkVVBhM2R6K1Iv?=
 =?utf-8?B?SEhXdlg1akZXZ0VDcy9IVjNpSGpBak9HTjVFK2F4cC9lcVpzcnhNYzlVUUFG?=
 =?utf-8?B?MjdWUFo1d29XdjdjVGJSQmttWnhzKzRCWGhTMEYrNHBGNVRiU2hRT0xTbFBz?=
 =?utf-8?B?MWs1UHdzQkxWMkluUmViSWdUUjM5RjFBY2VGRGl6Wmk0d0RTVDREMllvSUFj?=
 =?utf-8?B?OGlzUXV6L2lyUzJoQ1FVYmZOOEZWOWtsSkR5Vm9TVFBVMFdsbWp1V1hEMVgr?=
 =?utf-8?B?YnJGM0NKVzVyTFpUT040VnMxRTgza2craUZnVFYyb1Q4UERzSG51SEFwU3pF?=
 =?utf-8?B?RkNPcHpkRzREYldvVzAzRmFjeFlIeUM5QThMbXZlb1FINEhyZUpLMkVBMkNh?=
 =?utf-8?B?QXBxbFhpY21ha0tRWU9xUkdGbFFmLzErQ24yMGJpeElvNHJVdzlvZ0VZNDAy?=
 =?utf-8?B?eW4vek1NcnE4QkV6MHFoUjVCM29zWXo4WUVnU2RkY1p0djczY1RSbjdIS2Mx?=
 =?utf-8?B?blZNaDJhdmxXN3haOTVrc2pyRmFOcjJKaU5OOFNEMFdFRWZjcGVvVlQrTW1r?=
 =?utf-8?B?aTg5ZEg4ektaLzZvNzNPakdpNitVUFRrc09zTTEranFuWFdhRjBRSnE2OStr?=
 =?utf-8?B?OU9nY0NBaWd1RGsvV1RKdm4yYXRpdzUwekZycGt1RmNMcVo1MDloZ2dNaTBB?=
 =?utf-8?B?RmxzNlpQeTNRZjVhVWE1M2d5dG5RZFNGZDV6WEp5M1d2TlF5U0pPcTJOV3Vs?=
 =?utf-8?B?REcxV0t5a0pDMGd1dVdHL0JVOTNMSDhlQStwTjM1S0pVRHltOTZlaFd1cGxP?=
 =?utf-8?B?QmRuUFJxMjZCY3g2bmdUTTlrVVFZcEJBNUFIZ0R5MThDZmxOb0xpMUFRa0Fv?=
 =?utf-8?B?ekpmQ09XRkZLMTMwQVRnMjkvOTc5UmhoZCtiZTU2am1kZWJucGphdi8yMU4y?=
 =?utf-8?B?OHVsUlhHL3IrelJIWUFRZkc4M2pyREdiY0NmN0x2dXFqUjQ2UVpRNkt5b1Zy?=
 =?utf-8?B?andWWG44QWhVVnBQblp5RE1iUEZEL29EQUtyUzZPWUxwcnRPbmdZV21Vajda?=
 =?utf-8?B?MWpHVjEyMWROQXl4eU5WcU91azNEUDRmWTFISG1EWi93NUU0S2hYK2psS0dR?=
 =?utf-8?B?cy9EajhpcCtmeTY2RzFKUXVyVFEvRnFPZDNBZGdtbWRhRjQ3MkRST2JPVnZ4?=
 =?utf-8?B?cE9YMzNLT0tKMS9pNDZCNUtoN2tLZkFmTEZpQVdwN3FoODltMGNFcjRSc2My?=
 =?utf-8?B?aE9iUEdKLzJKRTljR1hiVFlMUmQyK3l3L1djUWtQZlQ3aGYvVWV5b3VkMjFq?=
 =?utf-8?B?M3JkS0lSSVdtNXk3Z2pRVFN1U2p2SXlnbzNVdjZVbGRhWjd5Z3BtcVY2ekQ0?=
 =?utf-8?B?Y2k1aEpEN1hqT1ZQY2xxb3pyUFFHb1BVVkF1QWVUc0Jld2llZ2JhU04xeUhC?=
 =?utf-8?B?UGVWZ2h0d2VwUzdUbGRlUTFIT1VRR1B3MkZOeXBtZUVRZ2k5ZGgvWnNLTUdG?=
 =?utf-8?B?bGRaSVZJcUxzMEtVRVRvaGw4aDBRMVpUMFdGcy9ReHFQaENxek1XbVlmd3J3?=
 =?utf-8?B?bVVyWk5TSG9rTU5wTEhmNXp6dDl5a1B4UmRlK1h2SCt6dWFNTXJjODRrQ0VK?=
 =?utf-8?B?ekx1ekZRUllkZExGS1krQm5BRTNCd2F6UzJvWnUyVW5ycU4xMHBoa2lPZzc4?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PTbjX18eXwFgKOzPTk2jK9dBPft8F2HnaVCqpX1Xb1jBWIy5S4SWZJbKqYmOS/S4Z3UICZ4kvtR1506MM9TgklDMycFZCDL2ssPDagVmWqifwT+ySw3MewnuYNQrRJyJDSITCTaRW9tLJ1o7ao8uEpvBGDrcyp9dvMp+WHFF61tyf8msjSfM69CQzv+H2LnIq9DzfNCU5ulE26jR/NYKiqcBR2iP0LgNs0oe3TU9d0iyCZ9JyBxfWCJykPhH3tU3M+FRJWpuSX1hbsLalU1v8+bncg4GuPMATJyRit2nzD+WuFt5zjxqAI0H4c9N18V2dxqiCeun27WHKfyfKWLFWJF1HFUMCFjXGxArtE9mS2AxEgo/qjbWMv5EL6OVOoPCKIzE6j8Uc88aLUJaEG+gCh/2ruf1WsuItUAiTwW9aNgUCBBmyMV2BV51xxqoRd84jKXURgKS4vsd0b70IVZHFBDbSEKhnGffNtAve66S730nNuHIHSkm95QSItIq1B29bVAtv1HX1ePX9Jm2V2/PTObPmj/LRqIpGyJxKqYag7o2VE/Cbc7k0Pc5cxZuhNI8xU0FDYNcmqFTU6SGIYDHD9x+DdeiBe9ei8ltjdYvKJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbdb4c9-4200-4a64-5d49-08dc5b1639ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:30:19.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sATbVJabVnfqSx+6tIv14fS/Np6lPXrgxU3kpIr925ai6R0q3WC7RWjJYTkOYQhsG8J8DBOwe0ulCLHrgfxEy5Cyh3SRlEH91GIiUAC1nCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120128
X-Proofpoint-GUID: q7QF_EM1GWQNRfasCJY8yAWaPoC0rnkH
X-Proofpoint-ORIG-GUID: q7QF_EM1GWQNRfasCJY8yAWaPoC0rnkH



On 4/12/24 12:48 AM, Vlastimil Babka wrote:
> On 4/11/24 7:02 PM, Christoph Lameter (Ampere) wrote:
>> On Thu, 11 Apr 2024, Jianfeng Wang wrote:
>>
>>> So, the fix is to limit the number of slabs to scan in
>>> count_partial(), and output an approximated result if the list is too
>>> long. Default to 10000 which should be enough for most sane cases.
>>
>>
>> That is a creative approach. The problem though is that objects on the 
>> partial lists are kind of sorted. The partial slabs with only a few 
>> objects available are at the start of the list so that allocations cause 
>> them to be removed from the partial list fast. Full slabs do not need to 
>> be tracked on any list.
>>
>> The partial slabs with few objects are put at the end of the partial list 
>> in the hope that the few objects remaining will also be freed which would 
>> allow the freeing of the slab folio.
>>
>> So the object density may be higher at the beginning of the list.
>>
>> kmem_cache_shrink() will explicitly sort the partial lists to put the 
>> partial pages in that order.
>>
>> Can you run some tests showing the difference between the estimation and 
>> the real count?

Yes.
On a server with one NUMA node, I create a case that uses many dentry objects.
For "dentry", the length of partial slabs is slightly above 250000. Then, I
compare my approach of scanning N slabs from the list's head v.s. the original
approach of scanning the full list. I do it by getting both results using
the new and the original count_partial() and printing them in /proc/slabinfo.

N = 10000
my_result = 4741651
org_result = 4744966
diff = (org_result - my_result) / org_result = 0.00069 = 0.069 %

Increasing N further to 25000 will only slight improve the accuracy:
N = 15000 -> diff =  0.02 %
N = 20000 -> diff =  0.01 %
N = 25000 -> diff = -0.017 %

Based on the measurement, I think the difference between the estimation and
the real count is very limited (i.e. less than 0.1% for N = 10000). The
benefit is significant: shorter execution time for get_slabinfo(); no more
soft lockups or crashes caused by count_partial().

> 
> Maybe we could also get a more accurate picture by counting N slabs from the
> head and N from the tail and approximating from both. Also not perfect, but
> could be able to answer the question if the kmem_cache is significantly
> fragmented. Which is probably the only information we can get from the
> slabinfo <active_objs> vs <num_objs>. IIRC the latter is always accurate,
> the former never because of cpu slabs, so we never know how many objects are
> exactly in use. By comparing both we can get an idea of the fragmentation,
> and if this change won't make that estimate significantly worse, it should
> be acceptable.

