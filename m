Return-Path: <linux-kernel+bounces-73809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56585CBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB9D284329
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65147154BEC;
	Tue, 20 Feb 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqlF0uHi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h6iCkZP7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC05135416;
	Tue, 20 Feb 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470934; cv=fail; b=uDqof4yDryVbzCI7ITzMPDtC5lFyOuf/i6faDBUg8nMAgCmWYua8erdvonsAGff5Nib/OkWFrTneOZRY8aXtUJ51Lpce5gWHRIej2ZXv+UJRNHs8HLsd/rpurVjt4YIPHnbmBUvk4uSNpXX4M408g1r8RP1eucK22ZS80lCHnPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470934; c=relaxed/simple;
	bh=fnIxMB8prp2zbXeiT/F+EO6fA8dplEPA11WaTCn/Gls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqf5Lp4tWFwph8I5y0/XNsjpm3EtQM/wp/TiknOrvPAykDK69YzM0r3VuoeJEyfmpGD57NFcbvAfJ1TDazY8OLV/Nf2LiPOcK8KL4eCHWCR7WaIGpyKVdNbvTtvtXru51buq8SG+ttPezQ1pLypzMEz/MYLdzxTdivl8eFtYB1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mqlF0uHi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h6iCkZP7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLL6f9008338;
	Tue, 20 Feb 2024 23:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eqYPwap6b/h1H5VV6Tpu2uH0SW0OASdctnCylq013nU=;
 b=mqlF0uHi7kCfGpTTl1ABqa4YYLuInXOAvWMfE2qbbRf86j5FDRWCNANm39H0LwcRkyv1
 McDhSNpKxJZZZxi3Ew7zzg2/X5/SYNL5r1fawwhv5PXxl3TdKwPPPp8SHQOrnJDyiU+i
 u+fMTZXJyQ1PRVLTCPYHJspb5D1PglB7d0Pf4rBug9TpyDds5AB94KJzqqm78acH2+nX
 PsFlDv3O53chZMdiDDGFvhDODa0mCUomb9j4h93LlYTd1Fm8l1WxqOmYyJPmjswEkMc6
 Qn3+KbArwI5lPf82ztOdsZgoyBQasuA6bkOw+BkuQhSC7Pikxsmkh7j/Og7iO7xEjDZ8 mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvg5gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:15:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KMnJFb006689;
	Tue, 20 Feb 2024 23:15:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88arqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNBlEagEtx81k36hNsKns4GBncD2Mt4toj2JL4StNbXjAOxLBUNTRavAPf8XOs9ZsGKdxr5J1ShdWhxPmo2pkzHq8yZnh9J/e8DGVa831uY0W6DII7y6HeDvFg6qt9V5ZfS7+pSWisBiG+28Vv53wvIiPwYBIu3fBj+TZfEKarKsb4F3NoL2W4PQVIYum4kbLMQbss2ARJFUpSAVE+WqXcBHf4gCNvjJHhz5gboNigqiE+jfikqlZ/1bzZGFeR3P3tKKy1DlArbj2OsvbLfXq2o65/3e1wajcPj3NPD0jknyn5zUThpYm9Mot3rzWlAA++aHKHB1teg5kron8Qhg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqYPwap6b/h1H5VV6Tpu2uH0SW0OASdctnCylq013nU=;
 b=c/Sraoh3GO2+3jU69eUM1861w92KQsx+BSMByx1NE0dQxlcqOwO1uKwKN0NRGqRFzRrLKrcWOBgZBvXRoznsVGugZL9s3Ak8OM0gYLoVgcLplsFV9HQ3pz+YzfzP/cOCIJM0eMPXlu+fbu5Lg5b9n9Cgv5E8fpU98KzticYOD3ZTte8UrYKBQ6v1r5Gc1+Di8DvBbGfn5JmQ49lFEg70mx+PTV1rZ41/xXmMjTYvItfuongm81NO07oUIAmwF+XvfiYj4wd7BB5oENuIyVcOLy17vN2KpYvbggDynsjyDVGR5nuZh3IXJ9zSclnxSE9sj6NasKJPyiUYwXmzy2yTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqYPwap6b/h1H5VV6Tpu2uH0SW0OASdctnCylq013nU=;
 b=h6iCkZP7ORn2HOrrMy+7JyzUgINEyc2m3gQxkBPbdQ+BivAX/AWoSoMgU1j9QbgDWnG1mZryfchZBt7WptEuHARd6eN5Xz7gaO+Ifc/F+7XZqmgZv7LTtMp7vEFoRlwEYLpGmAQD4g/geFbTQHd737+jF5sBL8LWrPVK9Vxatu8=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 23:15:19 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:15:19 +0000
Message-ID: <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
Date: Tue, 20 Feb 2024 15:15:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
To: Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, regressions@lists.linux.dev,
        song@kernel.org, stable@vger.kernel.org
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
From: junxiao.bi@oracle.com
In-Reply-To: <20240220230658.11069-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CO1PR10MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e0a056-148f-47fe-00c0-08dc3269ce19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jPNWmrnCBT+k1fvti+SMI+wVYLD8xMaUyk6g3gdjmTIGjb0+vz1fTNYB9+4HuD+apSO9jHHUSO/GsK+iU7orDvi/p0J6googC+g9OVmxtpQq+l99br/DJzyOPBFKGEA7x8aGANm8WjZYY4QZtjozSksEBI6gTCbI5AYYymqYak3ljUTNzric+C/o09hEXdBuRand9JnSMZtB5R7q/R744GwGtkPFBt5Y0+QWYmrLLr0jOf+P/7Sq57e4Mk1Liy51mcNde3Fhmw0G6X/+U8tQvZDXQil6I9kX/GrFsz+ayKjR/lM/0y40IRIYPHdyQ3jjGuJirx+zxn8FFHkYWgRrmcpLQu6JoB21YYRvEV/NJSA4xYehz/KsbKNAo7CjNrPiJkgmuKCRM30ilz8RtqKbjPOwmMuMmiWx5Eb2u/LQmGU3eDRXhQPQtyD//cx0M/7ZkhJ1B8eqtYPoOPIkOyi/IF1kTnVhce7blLVRVgylIhbMQvontEL6N4JXZW72/DNVV0qDAT5d5y/OmwEcLPVPmYQrAb6qZB3xsUoQmYgKdX4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjJjbzFDTkdhY2J5cnJiNlRRL0FsOG9XVUZYUGJJK0d0YXp0TUNTdTFSVm5q?=
 =?utf-8?B?ZGdPa3ZFL3YweGZBV1pNamVvZnhwbkh1dlZjRmE3VmQycW1OYUJKV0M5Q1Vw?=
 =?utf-8?B?MkVORE0xOVRxQ2lDalA3aEc1VXBVaTVwb2J6QnRLaDltUTdLbzQ2a2tyeER1?=
 =?utf-8?B?K2ROUG0vWGRGNElLVDNNQ3VOSERxbC9TcFlqRUFrcWxaM0ZweHh6dTViSDF4?=
 =?utf-8?B?aTlteks0QzhrcUZjT3J6ZERES21tc1R1em5CUzRycDZ6Y3dxTEg1akZKcXQz?=
 =?utf-8?B?S0xSU29UTHcyalpWbUwyZlpDd0xiRlFGTFo1RzVCTUp1OTM0eFEvODEwTTRj?=
 =?utf-8?B?Z2xyVkgwU1dCYjhDNWdQeFdYa0wrRzFnWVFRTG1GRjhuQTNOSERaRnlqKzky?=
 =?utf-8?B?SFg3aTM2V2JCeG5CaFI1MlcycWNnMkdpVHlLZXVIK1A1eDJta2RJT3krdkRp?=
 =?utf-8?B?TUhLNks5M0NUMXBKOGpuRzRmblFrc1JUUGw2RlF5VU5nbEJpNzk2R3EvZlZH?=
 =?utf-8?B?V2xOZXdmRnBac3kvR0JTMkgrZHE4QWpOTkwvQloyV0kxd0o0SXVHTnNDNVpR?=
 =?utf-8?B?Uysrdkt0WFBRRTJjSkhVY3VMeDA3QVQ3SmVtelpVYkFzUTNtWW4yaEgrZnhO?=
 =?utf-8?B?S1NVbDR6c2NIOWxYMzZvNDh2c3I5ZytBS2xGWkRoaExIWGlJbHppMjhrNUJu?=
 =?utf-8?B?K0hOYjBqYXo2ZFRHaXFoWm56cjNuQ3RHdFJvY0xZV1N1R0hlK2NvLzR3bTFm?=
 =?utf-8?B?OS9hMEZML1Y0eWF1eG9qckxEM0QzNVhscXRzVnF3YitmU21JZDVpRHVZbVJH?=
 =?utf-8?B?VHZXZC9UM2dNUjRjVzVOS3NlYm9qMkdEcndzU3dySnA2ZE1PMmFRRlZFVm5E?=
 =?utf-8?B?YzVRdGxRK0VXKzRkdHVqVlZoRkNySDNDcGM2cU1HRVZMSVJzNVlxdk9CcFQw?=
 =?utf-8?B?aStiQlVReGl4SFBibU1WbDdtakJ0QU5PNEI5OC90ZDc2SGNqYUhKcU91aith?=
 =?utf-8?B?b0NxMjF1SEppMlFKUjJUZDJuTmZJcy9sMmp0TElFMDBvUklFZXVQUHlhWEFC?=
 =?utf-8?B?UzJGL1hIYWNOdGU4UmEwMVV5TzU3UXR1dlIvSFNOK3JOTHprM29JL2JBYzkv?=
 =?utf-8?B?cVJvUUxXbXIrTE5JM1U3Tmx5Q3MvSVJPb2N1aXJiSThCakV0V0pkbzBNN2g3?=
 =?utf-8?B?bWVvdnBpcGpNaVpVWU8yckYwVi9tMWhTclZubGJwUUNxN3poQ2RxckhTMEFS?=
 =?utf-8?B?RnRCMlNpYm1lVFZyS2k2SytvMkxZMXR1Z1lMY2FSRnF6ODJsU09Cc29sQlhr?=
 =?utf-8?B?dzlmSGwzUTZHRmtXRSsxaFVady9TekdEcE1LZFlkWXlCZ1pCbTZMa1k4bHBa?=
 =?utf-8?B?Vkw4NWtGYmFjczluQzZmU3hPS1V6aVhMRUhpTHI5RExxdGFWVTJ6Ri8xN0ZR?=
 =?utf-8?B?NU1XKzlUMWU1N2VDdmpGaVJqT0NsZnNrOHhCSkp5M0pZa2xrMTRMWVVCYjV3?=
 =?utf-8?B?NSttbG5mcW9QMmZNNFhtMkFzVHVGRHZ5NUl3di92aXd0VmRKZzB0TEhpYWN1?=
 =?utf-8?B?QzVCdm85clZmOUxjMlk2eTJMeVcrenJHMHJWeTJ5dTZ4aTRxSHFHQzh4Q2N5?=
 =?utf-8?B?UmtLeEo3dEFBbEpZRk9oNWc3MDdHd3Q1TGlkRy9Fc3Q3akxRZ3J0ZDR3MWxO?=
 =?utf-8?B?Q0pIWDRtTlRJL2t2MmtNcmF2WEEzQWVhQW5LcnR3SnVYWGNqVDFLQVQxdThU?=
 =?utf-8?B?citubU4vZG9iYUkxQnh4SHArUmxXa0lRWGVzblZNZnljbzZDNndnd2dycnM2?=
 =?utf-8?B?MkhHS2VuYkFTSjQwWGwwSmcxQzl4YnFKMzA0U2hjSjBhc0dzYzQ0TVh5SHIr?=
 =?utf-8?B?UndUdGt0ODRDNkhrK1dQd3N6Q2xVS1NPMG9FdGZtR2xKa1BiSnpqa21BN2Nq?=
 =?utf-8?B?cWJkOEN2bWhyTUdScE1NT2c5RVQ0K0ZjT3pkTnZMT3c0K1Z0R2lqTlkxaFlK?=
 =?utf-8?B?eG9pcFRCM2JYR1FGTWIvZ3lyM00vZDFPT3BwN2YrRUtORk41U2NwbEJ3akcz?=
 =?utf-8?B?bE1TQ25qWEsvWU5sREV6SDVKOVhYOXpZdmR2VDdHczdNWTJCZVRVaDloZnc4?=
 =?utf-8?Q?PyBMqfi8mYce2hN0vlJH3lpXh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3t1Fp6eFz2iR0wqSkkC/BjPu8yKnMErjgwBIU/HGfogpAIO7+CmuTTJumUIJkcNTuD+gasn1Z0Tg+MikAGC9YEdSGHrCAexsgsjySP3jyq1TE5e9f54yAsYdTYxAX75YKf2nph0Zs9C7tHTGhMa6DUhqeoWHbUwbfpPBvJs1EbnaS1Yx9VxXDqKvBP4ZOMQiU9cgWLUJpi6fU2qjDdNgTkCavTp58xy7hqO/E420QnQLvsRnAM3ntlMlZ7sRTWKPZCytGCMP6Y2HhsbEG4QzpePafL+A+7/0KES4fzKc7Tz7HLIJWCa7N7M328Xs1aeoZvzIwk8/CnNgm7LFyeYz3s+3uTuBvt0T0TBODi+Kqk4WAV7Yj6hsHQEYR3gAWj4EgonOm6QPf2/fXSq6tfcbbWul+Rvfw4yUhzQBqXwAajTVZ6sXQJZzdTyXON30H5PJ40Pr+8JVRNfEyqPlWIkNPQU4aDHC5/JNOUcNO5V5quoebitk1GzUEp7r19iIhaLGK2Xih9NLD0OY5lxH/PE8iL+yaghG9URp8drxgcRpe3Yti0E0eHGnYfphetP/iNI2iGdcuW4dK+iVs6MehRGvj3E+dAC+3d/nsF0G2QUMfYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e0a056-148f-47fe-00c0-08dc3269ce19
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:15:19.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6CAf2tYwfW3QskPq6Bd3bydIGw2+runZeLkDYlGR0DUG42YvYPuvMcf1GiQTkwNF6/OtudExHkaLSXO01hIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=813 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200166
X-Proofpoint-GUID: BVVres9gmVuou5LNSM5QmMPfKscDQNDW
X-Proofpoint-ORIG-GUID: BVVres9gmVuou5LNSM5QmMPfKscDQNDW

Hi Dan,

The thing is we can't reproduce this issue at all. If you can generate a 
vmcore when the hung happened, then we can review which processes are 
stuck.

Thanks,

Junxiao.

On 2/20/24 3:06 PM, Dan Moulding wrote:
> Just a friendly reminder that this regression still exists on the
> mainline. It has been reverted in 6.7 stable. But I upgraded a
> development system to 6.8-rc5 today and immediately hit this issue
> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>
> Cheers,
>
> -- Dan

