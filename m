Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3244B7AF1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjIZRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjIZRiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:38:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99085127;
        Tue, 26 Sep 2023 10:38:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QFOrVx004897;
        Tue, 26 Sep 2023 17:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R3ALr+vMHm9Yhkn3YOPBHxFN8f2HS4McAZjN0W/kdyQ=;
 b=GHo1ZtbVJwIQXmxo/4sZ51QAG4L+2w5vzeIa3jVhnjsWk53ScU9CtKkAKiSxM8OhYb1z
 idiLqTQxEHRkd5ClwSVpT4XbEjgcrD/SmmoX6msEFbvmZ57NxUxk7Cuj5cRpZTk9R9E0
 S4bqlem7GdDQk+rndrjMpJ4JVunxGyfPkEQ0+wIDPzzjJoV/+ORj5cCuceyDM/t9roxX
 MLyc7a1u1Y3GsmXEozjwzcPzAsqSKEgkFkKusWqSCgd0uLAGhQDJ1mSBnNxkEJAb9Ggb
 dq/ES1a7C/l2TLhk8yN6nCHlv98WZWvkCbwVZgdRWTjtjN5BsN7EGWzrmzbWMgaW0GWe gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuf74d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 17:37:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QG5Rj6034959;
        Tue, 26 Sep 2023 17:37:40 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf6qs57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 17:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7WadybibHuQIej5OGnoe39q5qBV6x55drKTQwzYRUs0RrHqlBLzsSOojiD8SJrGYEaRxt8DHZgFjA471vQzN8JRR0urqYUO6+OCZmLUoxi3Qh7hTjn5cDigAyFySBYdFNeDjyRQsKQU1vLUG3DKUmIAnSpiyyXEFM2pWi9rMQnFypWTqSM4uCK+gDfc8RFNhaihQpK4+Z7fSesONGctJSE/LMlBfANKzYcCwWe6oFbfqEEfC9n1eW0jCBi9skFCjbcxjYDjgemGD/HqvfC8GJdS50XAfjlvdTtMld9GQshAuVi7PbkimGWfl9RfVmNW0PhqibGn1U9tbdXl890VQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3ALr+vMHm9Yhkn3YOPBHxFN8f2HS4McAZjN0W/kdyQ=;
 b=eeZlUVsUeKWZQOVxtaPJUxhK5GOGPIUaIExR7uy2h3fl0m6mxiBNbIMHTersuP9qw1rFcSUoNjf9Dp1ljhoUt/7+lrcTTUw99bJEMIhue6inns++kFFWKfsUo9Qh3dMS+NlrRPvps3RqEqV4ap/ypJ5mi30+Ti/z3tgyfQY1fsf3r8YqOK1mrHWrhn28PLaCmnrb52TAsf7PiimptDYtoW1HTvLsA5/ClDcsvHg2NEsMdiCYYfGyatgpFqvrXMO6UHRuHB9cQfPKA3rp8UlCd+GPZj8721ixjCZLX/RB+sd9+1JuNP+pRLXkuYoghjcfhVvI8MrcawzPB4m4U8Gcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3ALr+vMHm9Yhkn3YOPBHxFN8f2HS4McAZjN0W/kdyQ=;
 b=WfilSLcRpzwMR9wNMneI0+ICaTqhGG5hX2vgp4hvyU02NppUDQAqQ+AfUeFqMiAouE61sXt9orcmemc08esVqFFpDXEYPXinZYMjeDXqHEb4j4URReh1/DOQRrYK9y3Z2fYblvpJfGhmqtehJxJ6yyYzoYWVWNqGMnG/uqHFGD0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BN0PR10MB5382.namprd10.prod.outlook.com (2603:10b6:408:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.31; Tue, 26 Sep
 2023 17:37:35 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 17:37:35 +0000
Message-ID: <27eb28b9-46e9-489f-9826-5e8f9a9a662f@oracle.com>
Date:   Tue, 26 Sep 2023 12:37:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com,
        lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
 <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
 <06268327-cfed-f266-34a7-fda69411ef2a@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <06268327-cfed-f266-34a7-fda69411ef2a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BN0PR10MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c6fb1e-e931-4d16-e76d-08dbbeb74557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYzAQO5A1xFyBECK6bY9M2KE3dvkRly9LYlh04pv8IgVDFSj7Z8Z4ChMocH60kzjn436rySZEAxqPyn7OlZtHTOnam+3Dj9o03O0zeE2ZHqsGcj5L5QNrvEvZ3nrMq0W2WuN3QCm3gtd7O5bXWl4WPXiBPLnlMzVX51dy8bRy4bkmnwYyoACKlIF17Tr2+0hurhGV7VSR0xK0LmCA1bmtAZpAkVDBjxQxAAXmJ0dOt3mY3RubQC3a85Q7c6Ke68x+IborCC5TFnIm+O+kQJhp/6mkPObNQDWyOWng7FO08ionqG+c+MnYNz2XWBf+b5VV32Hs1mlKrMbIBErJEGODwvklaFRINfEV1gSUzBn8d9OZZcq5z64PtLKVn4/Gp8WPNZVzFlFSvit1RxSWIpuQhGBpJ56+tf13o3mTNt8P+KHyThC54lAzCsEB1YwJ36JgCFrVSjsMrmr6MsFR2AepG5pnKF+qgadl7Esq3VOW3nQ0DMuR2CbipHP3D0eyqX/1pgcUHJQC9dXmdPj79CbERlPnwHPbQqONSsYIPu8unLk7/plWawBI9+E0vR8AWLI4MX1ViRaZDV9CRfElvqioCjWwP/uceSX+Lpao+vaslWnf+zAR15gQ9veFq+GNMpBjJ+VebX2JEBLNcr8KCJlEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(26005)(2616005)(53546011)(6506007)(6512007)(36756003)(38100700002)(31696002)(86362001)(83380400001)(54906003)(316002)(66946007)(66476007)(66556008)(4326008)(8936002)(8676002)(5660300002)(41300700001)(110136005)(31686004)(2906002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xwMFN6bWxtWTZkekR3dmU2UVc0L0d2Sk00aGhEdit6M3RPb1UrSnlXc1Bk?=
 =?utf-8?B?Mmhnb0p3dWI3M0Rubm1Lcm1wYzBsa0pVbVR0dmxXL3ZST3RvakRzYVgwcmU5?=
 =?utf-8?B?TGtGdjU5NHRZbVcrK0hXNUtvc3M3YXI5MU5JUGpRWGZxRnhDN2hIQjlzVmJC?=
 =?utf-8?B?S1FaRWZiVU1aand4eDg1U2RYV2xLMlJNN215WUEwakM4bEdNSlRJbEhvL3VV?=
 =?utf-8?B?UVVwVzNQcVYxeFQvZmgyRUJIUDluYzhsWGoxWmlKVU14WXJtQU5CT1gyZEtv?=
 =?utf-8?B?dDc0U0J3dGxwL3BCNXRtRnN5SDFNNFUxZEdtZEpvTkRLOW02Sm5aYXE4bG0z?=
 =?utf-8?B?b1JoS2Y3cXBvejFIL3BWQkRtZkJOZjBXUnJQRUJYUW5GZE9vZ3NJelRoTjJN?=
 =?utf-8?B?emFld2ZnU3hmdUN4WWF3ZVd0N1J4QmIySHFqRHJVQit4bXJPTzlaNFBUdDJN?=
 =?utf-8?B?VTlGY0xYcnJnZ0JsV1VTWXJoZ3NYSjFoMUxhcUVra2s1SUpsb0lYQnJGL3JV?=
 =?utf-8?B?Y0VyQzJJSEVzeDl2SzlGVVlDVXpGMzZCMFNvM3NSTmdhWTZZT01ERlJEVVBV?=
 =?utf-8?B?cW5kNVpZS0F0MVVHc0FEUUZzdjQ1dFNTcEhlZjJNTDcrWDJSRjhBVjV4emNF?=
 =?utf-8?B?T1RVbHFGV2p6RUFIdUk0U3NJZjJCMjZxNXNCRlM0eWlraWNNai9EcERUWDZj?=
 =?utf-8?B?UGhpelpJbnNuUmlOTVBiQWwvdVc0WklKVFEwaFZUcHVZWW1ldUxHOUFhc3Jz?=
 =?utf-8?B?Z1JXZGJXaERTa09uSUV6amNzUC9kMEpIU0NhQnBObW1qMnQzTVIvOUYwRVAv?=
 =?utf-8?B?YUVzdG1zeTh4NVZ0WVRaSk5LWXdWdFRwbkhySC9DQ1hXTi9FVk9Ndjc4RitL?=
 =?utf-8?B?QjZnSUJFdWM0d25BWDVSYStITndaMUhvTVJuYUJrZ0ZCZGtSVkp0elovL0J6?=
 =?utf-8?B?elRxY0FYWDZsc2g0dlZOOFphT3dIeEM0aHRTcUM3SzEwNVp6RHFhYzBFK3ZS?=
 =?utf-8?B?VmYxSFMrcW5raElVTFpUbE0zMFlWckFuY282eDJaWjlQZFd6QmlYTjdTYU1p?=
 =?utf-8?B?MXpIWngvWkw4ZGhZWFEzQSt4ckp5NCsvak9NWjVwbkM3S09aWWM0ZFNkeVRT?=
 =?utf-8?B?ZnpkNXdOT2JUWGxWVDdRYisvOWk2SWE3c3BsS3FINURSazZZcDR1SXU1aHZn?=
 =?utf-8?B?WWEwZ2xLZHJMSEFlT3N6R0NFQlFNMkFVc0ZLeHpJYnNkb3pOK2l5TWgxQTE5?=
 =?utf-8?B?SHRMSkJoTlZFdlN0MW5YZXFmNEVBVFgrNytpQVE4S0xRTnBWeU91YzdmRlQ2?=
 =?utf-8?B?RzNJd3l3M3l4Z0tUR2dQTFdudUt5UklFUFdIWVpQRjRyUlJ6NE9OWWJ2Nm9u?=
 =?utf-8?B?TEFmR0VnMUJRSlRCQk11UWxsOWZvRFpDVkhmT0VROE45MlQzVkwybXNlaHFl?=
 =?utf-8?B?QUFyZ2F5MEhvMndyVklWWlB3YlRmZ215eVNMUXBLWFQ1enJJQU5YM2ZlVWxM?=
 =?utf-8?B?ZGU5UlhQUFQ2VWpFTEhOZzQ0SkZUb1dQOTdYTVByRU04d0RPSlhkUGhCTVQx?=
 =?utf-8?B?S1N1clloK3ZsS0JDT1VNMUJGMXU4REhIeWxiK2pKSlFtMjcxY0Z3K3dyTm1U?=
 =?utf-8?B?SnpNMzFGNllENkl2bFAzczR4U0ZrblloVWNEVGRJRUJsWUdUZStvcHkyTTFR?=
 =?utf-8?B?UGNrV2FFTmN6ZzVacTlUYTFvL1RVamRvYUJxTWxhcU5yeDhJRTlUQk43TlJa?=
 =?utf-8?B?SXYyc0crK3ZQTEQ1dUNpYVNyUlNmSkpKQzdyaUpLbXpPZ3JBUGw2R3RrK2hm?=
 =?utf-8?B?ejRtcVhqYlFIN1ZpaGtZYzlFTkdTZWt0S01uMms3MEM5azRtS2VlWmpIOWlE?=
 =?utf-8?B?a29Ua2ttT0VZeTYrQ3lpeGwyemh0NVl5c2p5U2RuT0FMZUV5bXFuZ0U5b3ZK?=
 =?utf-8?B?OVRDRlNidDM4YUV3SFM0Qm5sWUpSMkVqL1k4VklKVWhlRmt4QTVDNXhQRjRq?=
 =?utf-8?B?Vk1MVm5yQUpEN0hJUGZwQVp5SVBNY2pDQ1lRVEtheFd3VC8rbnBXbjVpd3U3?=
 =?utf-8?B?TkZncW1ER3NGV24wMVBLUHArSFMvZFRDVm1Hc3VtOFErVUROdHVwN3R3TmZj?=
 =?utf-8?B?ZU1UUTd0RVpYbWRlN3dqREZDVHUrREYvNHJOT0Y5TllGWUd2MnVzK3Fod0Fw?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: osCCJls9YHLdiVSEwrJF1zvhSpcQ3XObrkLJoO3PskRgY2cHagGeCD6HBBkFhZbfRsyoJNh0fjcU+o6Oruz00VUVJfjXWv3g0YFNj8NVSev/iwCS+semm4csiWPHbm1oJmxTrnjV43HVDTUvR7b0GzA7EYJa1+YegfjmfCpsbVQZdhp3OyUgJywwUjwpFxLhlZ0jZHNEoSv/YIzyl7l7nF4KYjGx8pNixjKWioyGO6Oa2uPc6u9SoSnTgGE59jpX7crkiHAHdheMIH7FMehk24Li7tvytATPGor/03E2F1Yu6cK3nWtyZtgPjf+zKcqF9l9RiVh98tsHPRCdh77kEzqHjKxD4blyOwRLNSH63JOIFwT2adBW29JZEr5VYKDDkQy8DPCWiW2B2Qh0mf8LfsNtHNI0hMPn37YYHQHO8ZZhQC8mBvnegV1D13mvwrTFRlgGunyrGdm6D2gl7Rk5lDtv5B9BA+ZiFHDfehsJMijaS1Ka28zpEHyjuRo9dCoVhleQoiBoySpyUBC2E4PYzr6P/xpgE0fkFwyrypkQE2/VW1PJ4uzTSYewuk4F+Zpqj21hLnr62d57H5K2kT4u4YNYrtxyBxLW0xLp6oqY5IWJTgedtHpnkqmmqF238j5qQeyXZCz3M/McY8b0TCBAGN3mks0PLnEwkIsntJClaESf9aO/VlUZdG3ilrU1rmyADdwnxy9jbtPNfKDzU5UbFDh5gAHxb1tVlN6eacbM1wi76NrjzpdqkHCeh4eiw4231OHAA1++vCgXwXAl2hrJSWH2PQdWGsle1iVm5sxabW9LvMydcIfbZbEkkuc6RLLrQbFFBg1X0eR2t89nLnLQrg4gdWGDEx9IG0OAqLlGZq/ygKpjsV95UnWZFN8xX87z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c6fb1e-e931-4d16-e76d-08dbbeb74557
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:37:35.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vCsg8yQVudoAM6puN1xM6+KoL57leULtyqxXxrlldvJCrKo2/AnPHocNhFRY2ZS9LPkOtaFmGK8Zi9pDCXCEnzzp+S7lgAoQx7fjmX8Uhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260153
X-Proofpoint-ORIG-GUID: ZYx9y7dxY1vqVK1xZzNj0DzOpGpBTwiA
X-Proofpoint-GUID: ZYx9y7dxY1vqVK1xZzNj0DzOpGpBTwiA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/23 7:57 AM, Wenchao Hao wrote:
> On 2023/9/26 1:54, Mike Christie wrote:
>> On 9/25/23 10:07 AM, Wenchao Hao wrote:
>>> On 2023/9/25 22:55, Christoph Hellwig wrote:
>>>> Before we add another new error handling mechanism we need to fix the
>>>> old one first.  Hannes' work on not passing the scsi_cmnd to the various
>>>> reset handlers hasn't made a lot of progress in the last five years and
>>>> we'll need to urgently fix that first before adding even more
>>>> complexity.
>>>>
>>> I observed Hannes's patches posted about one year ago, it has not been
>>> applied yet. I don't know if he is still working on it.
>>>
>>> My patches do not depend much on that work, I think the conflict can be
>>> solved fast between two changes.
>>
>> I think we want to figure out Hannes's patches first.
>>
>> For a new EH design we will want to be able to do multiple TMFs in parallel
>> on the same host/target right?
>>
> 
> It's not necessary to do multiple TMFs in parallel, it's ok to make sure
> each TMFs do not affect each other.
> 
> For example, we have two devices: 0:0:0:0 and 0:0:0:1
> 
> Both of them request device reset, they do not happened in parallel, but
> would in serial. If 0:0:0:0 is performing device reset in progress, 0:0:0:1
> just wait 0:0:0:0 to finish.

I see. I guess we still get the benefit of not having to stop other devices
when doing TMFs.

I think we still want a common way to allocate/free and manage resources
drivers will use during this time. Maybe have a init_device/target/cmd/eh_priv
and exit_device/target/eh_priv (I'm not sure of the name, but something similar
to the init_cmd_priv/exit_cmd_priv we have for normal commands.

scsi-ml then calls into the new eh with the priv data. Drivers don't have to
do the preallocation and worry if it's per device/target/host.

I'm not 100% sure about the low level details. Check out how Hannes's is
handling tag management for TMFs as well.


> 
>> The problem is that we need to be able to make forward progress in the EH
>> path and not fail just because we can't allocate memory for a TMF related
>> struct. To accomplish this now, drivers will use mempools, preallocate TMF
>> related structs/mem/tags with their scsi_cmnd related structs, preallocate
>> per host/target/device related structs or ignore what I wrote above and just
>> fail.
>>
>> Hannes's patches fix up the eh callouts so they don't pass in a scsi_cmnd
>> when it's not needed. That seems nice because after that, then for your new
>> EH we can begin to standardize on how to handle preallocation of drivers
>> resources needed to perform TMFs for your new EH. It could be a per
>> device/target/host callout to allow drivers to preallocate, then scsi-ml calls
>> into the drivers with that data. It doesn't have to be exactly like that or
>> anything close. It would be nice for drivers to not have to think about this
>> type of thing and scsi-ml just to handle the resource management for us when
>> there are multiple TMFs in progress.
>>
> 

