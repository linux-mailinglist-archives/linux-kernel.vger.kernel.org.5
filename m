Return-Path: <linux-kernel+bounces-23469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20482AD37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E6D1F23BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A286E156E5;
	Thu, 11 Jan 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oiIKOZwM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b5XrO/A8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2DA156C8;
	Thu, 11 Jan 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B8aMcI010551;
	Thu, 11 Jan 2024 11:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ep+4MFE9uaz+xSz58LRflrb6KfeANSpNoq13hnxED+s=;
 b=oiIKOZwMFN/vu3IP9VzKOaJv27QYtgDva5ggotKvS1uPzP4l/MnHY118B/GgE6JZ/czo
 S3qRKLOS4dnaG52ZnPdiUloZ0Dwmpe7ePOJ+wlWduKz1joS4rFVNmnTE5GuWkX+K4ucd
 sPEDD3wLrdcdxAxVgpeGIsQ5+4wixU417EsAdnH5lfJ0wmneuSo8l3MU+vaq9lQi4JAb
 OqvL56xMJhytqqDg5L8qATZH2/d+Go+dEVDMnl/Q82oUjAj7N7gou3HVKrB1lv+Lb8wV
 keMy4xuRCc6Okix3qXn/LqEqWRegg8Fq7+5GPUDjS0V99/iDH2o50VTom6ufsbJdw0wQ xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcbkgbts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 11:18:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BAAF56012149;
	Thu, 11 Jan 2024 11:18:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwksv46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 11:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzTc0Bgar+qvbXzL8A+ujagppN6yKj6vGYgb9GXUxLmGS7hdWWSQPFvfD2ouzoZDqrWo9G28lYH4PGqOcDp77jSCsmPtvrp4ND58FXR7meb5yqzOXzlYnZ28ufbbeSumO+xqZb0v/03Ad7Blg5exzdWRxwo49HOaAJsAwEWglCnvgATv7CcCshQOO9osB/SUy8ELJR+yxFob8FPoXnl9XYtgI9IoxRUdLEophc2CbRTacN5GMZB/2s/Nr0fSm8w4rNhwFLkoIDEZInBnmUJLI6iEI2AMIlKYU7WSphWB4oKIUsPbV7quw3kPR4jrF/3N93Ig0HAHT/Dobwiy5+KPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep+4MFE9uaz+xSz58LRflrb6KfeANSpNoq13hnxED+s=;
 b=azgXkRcoiE/8bg4FLa1pOlIn0aC2prMcnN1lQj04NVb9KrxoKWY4m3Mo+tnwx86MQeJkE0uwXVKys5p9qao4s08JNFju286PIljPrvMy4bXdbgt5y3loTKjWj1Pan6WpQdW4LtdkkcaxrbUBJ8RsLU6GFbWO9yy9dlouPjazads8+XfoDD/IzkmLNkJ8zUx45Jyzq7ZqMOfV31dTgqW1hn324hm50UDuLeK8b7zFmGThXd0phJ+vP+mZGoJ8m3fn5GEZfsASIr5q+885UPoDZ3AgXyRnQw6COoYOOvkLKG1mKIasEw5hGcnmePCMUvrHZGFbZNm+smpBdeQl+CZCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep+4MFE9uaz+xSz58LRflrb6KfeANSpNoq13hnxED+s=;
 b=b5XrO/A8l/u+fGs0FuowbTMu63LRxK8GX5JiQqbm+3LmhyT7RJP7mSddyDwhsNbG84AAw1ru0FmhGEa0LxrXzZCLugERhtp3U3CGo11khdmCexdso4ua5c5RF6AVqcu44/EuQI/eLVEBwhRay4W9XGojyxlkuruCFM3uJ5XBYOk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY5PR10MB6238.namprd10.prod.outlook.com (2603:10b6:930:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 11:18:49 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 11:18:49 +0000
Message-ID: <50045aff-91f9-4809-ba3e-b722b325d233@oracle.com>
Date: Thu, 11 Jan 2024 12:18:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sphinx: Require alabaster <0.7.14
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
        Attreyee M <tintinm2017@gmail.com>,
        Adam Turner <9087854+aa-turner@users.noreply.github.com>
References: <20240111102128.37192-4-bagasdotme@gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240111102128.37192-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::8) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CY5PR10MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: b9739cd2-2dcd-4b9a-2b0e-08dc129715bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XNKwujD6mj339qDsxr09/HVS/YdQVoJxSaaC4gJG8gq82EwDlArYn0HN+eqQ7+9pQOQdqcnYcrTFcnLC4V7Pny5sfdTTXq5JE2crNa5f0QVzdvL97MKdqtjmrpwDJjiX/x6dUUZnXqKZhWMtvptiOsXN7Ju+6lnq8Nf3A6Y9Z/qMBfNiU6n9e4KKhPlJ7GwdRhWzrN7PcG48haNoXe/Rr6HHUIhEqez2ZupSHwfsNxRvgxQJ2IlmcTF41t2pRjGbTrKFSEoXdEUY30jI/xIZyawHFMTZtKboMnw8atpaapYsDl9s0POSvkxH6aVvzFyvhITpSq9osjraTx0fuGlLWwwhxf3bYcrevJGdnh7bcxUx973YPaFRtjwNel/6SIu/NQ9+Rkc62mkzdgjEDG5yrLXsX0MbJCPHgxuIMpEnN/2PQWZWeUC6p40eDJaT5m1Pqpf8igWRiY19nMrxOtGsvYiXsxWSmCv5WnDYlDoC1YgDN97jHFlFgQDVK9fd7EoArIaf290b5wJo9lRSVEJ0uZtU+CzAPB+w3TFjyUN4gZB/vyeGujbuXdd3CRKmzqiy08ym0gKZymiyLv6TqeBTuXVROlm5ZUGWzKHUUW/DQ1ri5fiOqENEweVyd0JO/KlL7rAy3qpGE0BwmLspDaIBgg4O1d06H5r1/+gOiSUSwI2xsc9kErRUIancshGKiZze
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(26005)(2906002)(110136005)(53546011)(316002)(54906003)(66476007)(66946007)(66556008)(36756003)(2616005)(6666004)(6506007)(6486002)(31696002)(4326008)(6512007)(8936002)(31686004)(8676002)(44832011)(478600001)(966005)(38100700002)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHJFeXJ5YWpkcHlMUGZjUEhha1hZSnBjdWlFMmVnU01hQis5YjR2SnBTbThD?=
 =?utf-8?B?b01EYjRGSDVpUmVBMTBSUGpqbU9pbTNJZlNHNFlQOHczcGJEY2lpa1FaUk1G?=
 =?utf-8?B?SDhMMWJrQ0RkQytLNVhwWlBVckgrS0ltamVMd0QvQU9yeFV2SWtZRjR3d0l0?=
 =?utf-8?B?alEwbHp1L2hpdGV2VEZaSXFQTisvc3l2dWVoV0Y5aDF0bnZ5Wk16ZERzNEhH?=
 =?utf-8?B?aXBBR21QZll5WVRINkY5UE5VVjlmNTVRcTNKOCtTc0V6VjNRc2l6QzA5b3Rn?=
 =?utf-8?B?bGFCTStOYTV6UUxGdElpZ1FzdmZJVW9zTUd2bEJXR0MrdzFSMmNCSC91cDNE?=
 =?utf-8?B?dGVSNE50VEQrbnZBUi9YNXpiVnl1UzYza2dKQnFQdERiTmpNTlBPdC85M2E2?=
 =?utf-8?B?RW9EY0dLWWJMTk56ZkRPenFnalEzeklxTmRnZ0pjaHNxZzdTRUE5N2FLbjNy?=
 =?utf-8?B?WHRpclllVkJYWlhRWVdwY0R4TmpBemZYODN0VThOd3ZZRGQ5cXZSTTM2OTJo?=
 =?utf-8?B?WjZIbmF3cFlaVExpNXlwLzV2VFNkWDZqMmgxQ0s1MGkwUlNDaURRVHg2THYz?=
 =?utf-8?B?TUs2TUJKbFpPTnN1K2VzUjUxeDY1V3IrSWZnMkhMVUlCY3hIMEJ6am5MS0Mw?=
 =?utf-8?B?U3hVVEk3NitDdmxzanB6U2hCc1FUbkxRVG5yUGNzY1BMQ0E1dkQ1TklaNDEz?=
 =?utf-8?B?c3dvbW5kL3grYTk5SWNKZ0NYNXJRMHFhbXBwcjkxWnFYUGZ2NlRDa2FVMjIx?=
 =?utf-8?B?T0FkSnk2M3JuMzJOSzg1bE9jVVF6U0EvWGpHT0NuSHlOVjljdEkwcVhNQlF5?=
 =?utf-8?B?VGlXU05SWXErVlA0VHNrOFBhMkQzU2ZNdWlvMjRvb1pvNHA1VFplazhpNEtv?=
 =?utf-8?B?MDdNVGZhejlSRlhVWXdFV2V5RkdHNitYU29BNTF1R3p5MVZBWllHSnpscXJV?=
 =?utf-8?B?SWZRUE9lam96cUxlY3FxcEFxdVluSlB1K2FKUEpuQVNYbWZ3eTdkU0x0dTR3?=
 =?utf-8?B?SGlBeWdSQXE5Zzc0YVVXNDVlbkdmM2U3a2lzT0tkNkhXSVIrVlpkNzlDT0E3?=
 =?utf-8?B?UWxSd0hDQ1dqTVMxTGVDSmtwRjFTZnhyTEhDdy9NMFNXYk5DZVhta1BSOFZq?=
 =?utf-8?B?ZDhjMGpOT3lVWCtSaTJJRE9IRm8yWGVvMkJsMEh1UzRyYzU3RC9VQTNWK1Jk?=
 =?utf-8?B?czA4QmhzbndBTmhZY1p1QmZxMjY5OHpydy93K0lkczJqVjFEWXlWcUxVSnZq?=
 =?utf-8?B?RlRicjQxd1RQMUpZZnMyVmxoalNVRFZCeDJoWHFGZk0vdnpON3U3bE5PbVRW?=
 =?utf-8?B?OENIUzdhcXovSXNvY0M2dHFTS1lxWXVVaVl1NjRBbVR1aXU5cmZobXQrbzVY?=
 =?utf-8?B?dzdCWGZLU2dLUnVEa0tOM0M4NnlLczJSanVwSnhPeDRBNUR1ZkhQcUs0U1Vn?=
 =?utf-8?B?aWEvRTVVZ0lnVGpvUGY3ZGVUaGZBblNpdkliaVJGcnVLWFF1L0UyUXdibmJs?=
 =?utf-8?B?UC92K2QrZ1NrYXRIeXV5RmJVZXMzbWVrcUZ6WlN2RFQ4RStOajRhTkhqZDRy?=
 =?utf-8?B?ZVp3NVM3MGFWaVpaS2cxcEpHSlkzTnhGQ1k5QldlbXcwNU11OFdYRWYyeGNj?=
 =?utf-8?B?OFBiRE8vWTJuazZIelZFNmlMQWJRMVpoVVRsWGFITXhPMExkTUZHbnhPVkVq?=
 =?utf-8?B?RW5PL1YrcGJCbVZUMGlPam1aeTFHVE5sekw1dFdVN05aVC9XQ1ZTZUV2SDRs?=
 =?utf-8?B?ZzdqVHF5Z1RyU3pHTW5kZU92eHFlNzRkalRGMXk1VVF6cXRNOGhhc3hRYnor?=
 =?utf-8?B?MFVTU3E3bjhFMVVaT2l0YnA1MjBXdHlXbEN0RFZNbWt3TDRSem5IMHp3ZmZX?=
 =?utf-8?B?WmdFWEVVdnczNzlPK2FaRWM3Y01MZ1M4UlFBcUVGNjJTOTBCcjJPckEyTjA3?=
 =?utf-8?B?a1VpdmUzaUNSeHNodldHcjZxcVNIcm1Nc0NDTkNNM2NrSVZSdU5mYW1CdHph?=
 =?utf-8?B?TlY2b0hFSXMzcGM0YjZYZmZmczJnQXNRUFY4b1hOQlp4U0N2UzlkbXl2c2dL?=
 =?utf-8?B?dWJ1a01ucFdKbm5HclBwdFY0UTlSRmlMY2dUN2hQZG9wTStjSkVWSUZhUDAz?=
 =?utf-8?B?b0JDSjNIREN1L1NIVS9VSm9maisxVjJpV3ErL055ZlNJYlVGQ1pnZHhWRVJy?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pwq2lq0Zr8b6cibnq7kHhzbLvn+Xg5cOVn1D0R+OHuTDZvr31jfOum8ox+HocXfJGuErNjwsZCEVSL+yqgUiCwlMnP4b5piTXl62+LpZbjlGQtVnYQX+AtT7kLNxgBYjA7sQTI1+WCbQkReoxctTVqci79pBMeQoUDMmD3FiF1HNLQ4pHNpPjhdSoo6zaziA3NnRn9GA6YvOVxnXzd1PMfx8wG3maEpShkGsLKgte8zl4THlhoWwzZkyHNgY/iAr70HP7Lx4MW9sJo/VvcrHArcYDmSviJGEsWMRf5OhZPnsPDgSbo54Z9R1wx6RPnP0NHGh1i5vPU4yfcYtJ7G4q4mexCy/dISnaiwPRhr6r2Z3WwQfoqOGnBYmA32VRYhEWGCmrbEWJiJsXqyUgcPbU+QXyVkkouJetF+0EtUlG+Tssu5pOwHpNlLbw+Q3hbgzbOKpB2X9zUvKlHBDk9YlyBwqx1jvbqhZv44JTwKWA9jBknhjrjipF8Z7kqSMfZLj7geB+0eWWjvBhS2GcqKCYur8RjTy5qJWuCg5GcHaKZbqaXuTSnuUeT3JFNDp0XamCsjcpEf4ZJjy30MpB8ECimrWYNjpHu+NUP/d3SZFurQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9739cd2-2dcd-4b9a-2b0e-08dc129715bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 11:18:49.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4h+/TuztshLpFXLuoV4Eow+AdavNNhn8PKa8ASNy2cDySq71CKt3LttuyDVmyXXyE1gwrhQ6Kq4mHo26k6mMjxdtoXjqwVD5w9HgYVlcik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_06,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110091
X-Proofpoint-ORIG-GUID: Lm5jDAQoz8PuEMTvxGBcXJkIGXJL-S-u
X-Proofpoint-GUID: Lm5jDAQoz8PuEMTvxGBcXJkIGXJL-S-u

On 11/01/2024 11:21, Bagas Sanjaya wrote:
> Alabaster commit 640273fd3ca7 ("Drop support for Python 3.8 and
> earlier") [1] bumps minimum Sphinx version to v3.4, which breaks
> htmldocs build due to version incompatibility with Sphinx version used
> in Linux kernel documentation (v2.4.4):
> 
> ```
> Sphinx version error:
> The alabaster extension used by this project needs at least Sphinx v3.4; it therefore cannot be built with this version.
> ```
> 
> Fix the build error by requiring alabaster version less than 0.7.14 (in
> other words, at most 0.7.13).
> 
> Link: https://github.com/sphinx-doc/alabaster/commit/640273fd3ca7cdc1528c591172fd9cce2ead911c [1]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   I'm noticing htmldocs error when trying to build current master (still in
>   merge window). Is this patch OK for 6.8 material after v6.8-rc1 is released
>   (as stabilizing fix)?
> 
>   Documentation/sphinx/requirements.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 335b53df35e22f..b2ca7432437518 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,3 +1,5 @@
>   # jinja2>=3.1 is not compatible with Sphinx<4.0
>   jinja2<3.1
>   Sphinx==2.4.4
> +# alabaster>=0.7.14 is not compatible with Sphinx<3.4
> +alabaster<0.7.14
> 
> base-commit: de927f6c0b07d9e698416c5b287c521b07694cac

Note: I submitted almost exactly the same patch yesterday:

https://lore.kernel.org/linux-doc/20240110104646.3647600-1-vegard.nossum@oracle.com/


Vegard

