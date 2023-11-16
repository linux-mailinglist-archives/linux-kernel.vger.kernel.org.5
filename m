Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008BB7EDE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjKPKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjKPKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:13:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E219E;
        Thu, 16 Nov 2023 02:13:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9KU0p014803;
        Thu, 16 Nov 2023 10:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a08UcUVLoZOMzvhfMPbsUtOgHS7OotEvKPb9ea4qd7g=;
 b=nUFpucRAKyARRmR1J+2QlML4RgbvQwf+XBuTQU3WdzbXD8XDhLRErJSOTcZ1TslleNY0
 +/ocHUnDfnbLTHuTXtnsHnq4oDx6kUp+UJstrKiZZ4bFpZ0Yxqc68oXGdhXsF8KOeKjy
 qZZ3OONjCRA7e9a3Yv1xzb1dHiOD55ihyCOKH9td41vFkfOBknhsKciyBk1HLXFSU1M3
 bU63zSUW2XnQ36VT1QGINiDUTQDBDMy1d4ll/zltxV4Yqe+DzcCvQ1ifeDmQgMiwweHW
 oPTiED2Z/hjWQuQtFZkdLr2onp/x7gu9OyDM3BktcmdzuyktGSY0xlDK5z6LVHTRAjYB ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2jq4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 10:13:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9bewS009775;
        Thu, 16 Nov 2023 10:13:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k6muja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 10:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eld9mVuYA9XvDYRt3BOq2EOIugfHN/GgPyWbKDsVIGyjBgxmrJ11FXKKC/XEaLgLh4AiB7mXEuOokSiEdAxjm8xeUbxcPGVqz+8Z5rCrft/5DsVwzQqlvLOG/8p2S/VmNGbtrsNQ5PjQAUYCEuTBqdotSU546u62PvZQUzqMRVyZvgXH3Ew802q562XUvzVqrGQg3HnuevqYcY+LX9bEtCpGZl3TOdruKsTlVNsFEjBMZceipstXXNWptDA0P3KB2zkPKYU0F3SCqvNIvvKImpbxbTn2uCL2f1vciZ9xtPxpKh1QRYMnJboui8kO0zH+xxroANFuA4GYqemoO1aRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a08UcUVLoZOMzvhfMPbsUtOgHS7OotEvKPb9ea4qd7g=;
 b=QDJuzM9tNRfzadl5/vbt/6LojhCtDS5sGa8VZKkr4g8ztT1TFdBfQkef6Mzf9ylgy+yg5pe/n+P9AIpi34KFfuqhKctvtPjwELz0/2282S4oAHiy+vNg36Li6MqmLUOe4dTNnaSrmf6HxxcAxGiSuCKGW/fkhXlyZWVOjZTGj7IhXfhBIDXi7TKA3JBFUiaXCR4SNauM6gk3MD7bzXheJ0IPnlLyj1aOCvHkDLM2IbeoILCVakNkFODMHRVxe1RvOid6ePvybVmf6bzCYEyXiWn0w2R35k8J5y53y+epEBnlbhxrnqxGf5SatUWkXddVbxdqdPQ6mL3uBOT5fsSAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a08UcUVLoZOMzvhfMPbsUtOgHS7OotEvKPb9ea4qd7g=;
 b=olLLTQ1MkmlDAsbdllPcbRSYarXdANb8k9FUrBszCzSTFL7DdHWIn1jZDBgpUZOXXfAbtEDrT5EsMXdkCL7UI4RPLkd2gF4iRECVvlKziKIoK0zKMXcs3DqhDj8JsvwamIlMxXJtThc4xEwAnDotoGGs904ND017f3T9pd7EAJA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6841.namprd10.prod.outlook.com (2603:10b6:208:437::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 10:13:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 10:13:23 +0000
Message-ID: <dea5cabb-7d9a-44b0-85e4-878c13233f6a@oracle.com>
Date:   Thu, 16 Nov 2023 10:13:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: libsas: Fix set zero-address when device-type !=
 NO_DEVICE
Content-Language: en-US
To:     Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20231116035241.13730-1-yangxingui@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231116035241.13730-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab583e5-62f9-4d29-0994-08dbe68caa8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0t2N6FMApenBuaYrvpjSIlbW2cYlmobpHhUGMrJPgdOgHVxPVjeniNYeS5H92/7hSG/3SMEvG5I4U+ye4Q0vA63iyo8B9J74zJt4htfnoHOMGlKkYaBC/o6bviCZVKX5XkWn3mXdBr0d/9uF3n4CRTm619OFqtzcKE2h0zgavn7tyqwM2bC/bdsHhKVNobj3g0pUY+xueRAbzAdOnIg+DoVddn7rjcj5QrF4yjzZmeeuk+m+NQxOwVu3BckWH5nPqtZ/LkrbkL4+B/+oJKKugjIK6UYDTjjKaO57UaG+Bzjg07CZRHrPDiCgBMGbJfqXBsse2tBP0vzUJu+sM026qyMlcgBH8jdMeneRcuF9L8s7uAT3l81VbLFne4JyFI/RB9VRnkjtowtOdUePPvJMCBcf9yhireglMnf3GDJ56dOq0QwUk+3BY0WO2FHosLqDviGbJexWFewF8iNItyosaY+zpjF/C0ilvsbd8Zz0/6swG1Hljg0k1bkWFQ32PdQHnTlWAKgmKg+KpxVHi6FejYR/clwn3aDR/11bUmLgHjkdqLl7GNcg7Yhe5ybGbDrhVtdwsBZp3gvuOxjyH2j8aRHf2p9IXGmCmsHTb7HnbBTSHHZySERdosJiZC8x9GhGvyUHRvfYO+vfXAmAsPOuwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(316002)(66556008)(66476007)(36756003)(8936002)(8676002)(66946007)(4326008)(38100700002)(478600001)(5660300002)(86362001)(7416002)(31686004)(31696002)(6486002)(83380400001)(26005)(6512007)(2616005)(6666004)(6506007)(53546011)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGwyaEFTekUyVjkwZENsUCtheStVcVVZVHhMRjE4Z0p1Yks1aUdtQzRNb0hZ?=
 =?utf-8?B?QWFtVFoxdEZpY1dtNEo4TDhSK2xDYXNsSzgrY0NRSi96MG5wQnBLUGxlaHNK?=
 =?utf-8?B?V0hjWktmSTU0QncrSThjVmc4R2Y0b2RCSVN4UEhMZEpLVUs0Q0NudTFZcStj?=
 =?utf-8?B?WDhmaTE0azNWSUYwQ2YzR3p4MHdFNUdISkg3L1NKTW1kZFB3SUdDRE9IcVNH?=
 =?utf-8?B?cUxHRERmcENldUszMlN6TkZoeDJYdGo2TVFlNktjMEFiWVhsZkV1K0RlNTk4?=
 =?utf-8?B?LzRYcmhzU2hJa2JEUGxUODZia0grS09WbHYxdmZhU2ZPS3B1eW4rTDFvWTJX?=
 =?utf-8?B?UC9BSTVPMUxlNmhORkhFcnZOWU5JMjhmT2RHcVc3RGZsS0pBNHNDZUJTWmhs?=
 =?utf-8?B?dUthdllTTVFadlJhMlZtTm9HRDZzMjg1Z1d2K1Qya0R5NFd2blZuNFlXaFRP?=
 =?utf-8?B?ZlhReW5vTmNXVWFsNmF4UklsMTVUdjhURkV4TlZ3NS9GMmxMM2tXb05sS3k0?=
 =?utf-8?B?VEZERlAyZ1IxL1IydVJMdmJVWTYrb3E2K3MxbFlGUWVzdHluNWdFaWhYcStT?=
 =?utf-8?B?RFdoZFVHZ1hEVXhRWTBOSlFlWnBQOUJEMWJQdzhaRWY4NGxidnUwUk5yV0Vm?=
 =?utf-8?B?eEl5ZkdBQUUvN0tXYlZWd3BadCs4WXArcjFJWE9YejFzeXg2MzFnVGxGWStr?=
 =?utf-8?B?THA0K2J5N3BCcS9aWFR5ZzdkK01CbXFEWVFmQjVDNUZuU2FDVWc0b1RqREJy?=
 =?utf-8?B?UU4vU3dsQUJtcEVsQUhtSGtGL25yMUJ4TkZRTVY1bmhxbjI2NnBVNTZKdXhS?=
 =?utf-8?B?U0lZMk9oVTdXNjZFYVE0cnVPTmRPUm1KRDNMcW5wWHVMUGtsM1BPS0lBbUR1?=
 =?utf-8?B?THdHTlZhTTU3eTZ1N2s4QUM4elRCdXkyMHA2K2hUT3RUczcwTk1NT3VRNW0v?=
 =?utf-8?B?QVJSYjBkTHc4SEJpczk0cldSd1VDSlc4S2Z1aUZlUk40Wm91NjZjZXhUSWhY?=
 =?utf-8?B?OExtVHA5YU1MVzJXRERNdC93SVpVa3JjcUF0UXBZMi8wY1JIdFBvT3Y2Q05Z?=
 =?utf-8?B?cEJXN0dkay96TzJHUDNFcFRPQ2ptbmtSR0lEcCtvMVUwcXMrVEZNQjdGUWk2?=
 =?utf-8?B?KzRPRXNKVy8rVXJtd2R1UUhaa3c5ZE9hSXdmclJrQzh1UGc1c3lhQzlnMEpn?=
 =?utf-8?B?aURDVEVQSlRqS1Uxd0dOUGMwcVJJd05qVWt1bXloQ2FtRFdYTng3TWZmTGlF?=
 =?utf-8?B?WEJDOG43em0vbG9VdTJXY2R2bkJleS9kSmhPSW42TUczOElDYXpoOWZ3YVpE?=
 =?utf-8?B?Q1NjbXU2UEd0QUdJOTdYLzR4N01zOFhjOVZ6SDVXdVFZbTNnUzN1UFNQM200?=
 =?utf-8?B?QTdqdlhidHJEdWJjTmtGSllMKzJrQTE4a3B6V0svUVhoVHMzeExoOFZ4cHRC?=
 =?utf-8?B?UmF6Um5YSDd3R1l5SDBSZm44LzJKYzd2K2o1aWxsL2dzS1hZcjgwZzdldnBH?=
 =?utf-8?B?dm5BYmZGa08yeTZodWdyWFJxcU1PTFNGdmMxaXU5RGI3THJGTzZFeDd6dmRW?=
 =?utf-8?B?SkpyS3daZnNWRnJnUEVGMldYY1FmZXhtdzhNam5JQ05vM2hrWVpNNjlBUC9z?=
 =?utf-8?B?cEYyTkxobGZxZUZwYmd6S1VzY1MrR3hPSm14VnpyNmdOSlZCUjQwVnN0clhI?=
 =?utf-8?B?MlpIYk8rVXEweTVyUDU2QjFUeTZRSys0WnhBUnJFOElZaGNiRWVxZ01yZmdI?=
 =?utf-8?B?NHUrU3JoaUQxMWxITHIxZzRmemFkajlOQTBlaHFGU3ZlN1k3WHRtOS9QR215?=
 =?utf-8?B?Z3Bvc0Z4a3dxa0xBTU1TMHVqMHQzR1FhMHBOOFpXbHUrb3JsYklMcDRPNzVz?=
 =?utf-8?B?WFZFTGJWaG83NDRVTzR3Nk5PTFVicVNtWlJxY2lsNXFJNW1vWW1MQ1hSdUNx?=
 =?utf-8?B?UDhCUkI5eSt6YW1sV0pRYnpyQWNWR2plK1hwQS9DdTYxS0dNVEdkNmVld1E4?=
 =?utf-8?B?YUN5WTJENzZYYVc1NTdNZ0FFSXRER0p3ZkwrN0FhY0tTZ3dFVkxRVUtxWmlI?=
 =?utf-8?B?UEZwbDVYVloybTYydWF4SUdoTEF5R0M0U1JxWk1NZWdjQVRtaFhjZ29QbDZw?=
 =?utf-8?Q?y2EpU0Mn4wvXjmuNtVoatIRI3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WtJw6ysE/8oQBJcGBolCkK5sE+PkyMrGG2NhNKdg4v9cj7imSsS73v4c2HqgF1vMYErAOvTmKxzYIUx+fZI229Qk+AHzZjMExxkxKVKbcbN+jwQrT+d4TesNWJ4NyPDNu6oN5Nv0TiHj4SG//3gzhJ34TRe79UIE/X3yfu1OM3iAf0Jkl8xI6/7lwT6kAu2+PX4sTuukgEPQPCFldDJGHiyQQIhaZ6O7JuZDuMjz/sO2h2orwQX8fD2wBrQwX27VdaupW2/nzGPizWX4AbtBusMn9UlgmQ719/PPPrGWmxz6CW65AhEE/REf9QSk9R+FKPmjONB3lOa76hyCwfHmub4pQTivZsHPMEOVJfllQgtJRtCYgCQ4bZ2Hrr4l9R8fvEpAktYmUpzyFFWosuGirvFmgiXBF4+FXHQ5LvsRYf1B7j3sKmR6Mpezf75ZMCjUKI9O3d8zcM6DTn1HkmwhOV3tfdHhACtYS9wI40x3tnGzmxOz1T7z+EinSzENsV9KtS2DtxqTmjU8FpIEpKqZXGHuZz+iF9MoRgjXOG4skolUbbLoqjXgCH04L673BglNlXRtw1yOfl3q0bF1NHQarYujk9VPJqQWZBg65S+9+9JVSezCfwA7fo5JWOcTGjoWFcZDv+Y1n3RB19lT4PEREf7BBXLmlAGq2uiODCmCR0irCV3MAk0GDwMfIdXZmrYYNhQf5/6qLRdI40YSp21hQucgV4qj5URQ04dkkd5ZJ7IaG/VRqCKB05I882CXt8YSOrgfTReYB7oAwYEuzF21XqZI6rxtbO4EFIypAvqcLiHaPKlZVsTZiNSvgI3Xhdn/U/xzWVprZXNXQqGi53A+yFyXwo+jQvfSS7wL8fTZcgcu6ZT9PaISv6x9XqKMDpdm/8wu+wttwziDaKHkZaacgeQ0L/8ngzxqjt1pb6D6nA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab583e5-62f9-4d29-0994-08dbe68caa8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:13:23.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHxzpGZmHmD/2toihOG8rvxTymgf7Fa0jCiGCfmOCrXvPmA2FjMAGYRKO065ztuJ+Co2efBv3rMBer+v72hy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160081
X-Proofpoint-GUID: TTaruvPHrXo-pLduG9Dc2fIx1Ce1Phfr
X-Proofpoint-ORIG-GUID: TTaruvPHrXo-pLduG9Dc2fIx1Ce1Phfr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 03:52, Xingui Yang wrote:

I think that patch title can be improved, but I would need to know more 
about the problem before suggesting an improvement.

> Firstly, when ex_phy is added to the parent port, ex_phy->port is not set.

That seems correct, but why mention this now?

> As a result, sas_port_delete_phy() won't be called in
> sas_unregister_devs_sas_addr(), and although ex_phy's sas_address is zero,
> it is not deleted from the parent port's phy_list.

I am not sure why you mention this now either. You seem to be describing 
how the problem occurs without actually mentioning what the problem is.

> 
> Secondly, phy->attached_sas_addr will be set to a zero-address when
> phy->linkrate < SAS_LINK_RATE_1_5_GBPS and device-type != NO_DEVICE during
> device registration, such as stp. It will create a new port and all other
> ex_phys whose addresses are zero will be added to the new port in
> sas_ex_get_linkrate(), and it may trigger BUG() as follows:

I think that it would be better to first mention this crash, i.e. the 
problem, how you recreate it, and then describe how and why it happens, 
and then tell us how you will fix it.

> 
> [562240.051046] sas: phy19 part of wide port with phy16
> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)
> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
> 
> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port
> [562240.085064] ------------[ cut here ]------------
> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 0x0000000003bcbebf)
> [562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain [libsas]
> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.479751] sp : ffff0000300cfa70
> [562240.674822] Call trace:
> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
> [562240.756014]  process_one_work+0x1b4/0x448
> [562240.764548]  worker_thread+0x54/0x468
> [562240.772562]  kthread+0x134/0x138
> [562240.779989]  ret_from_fork+0x10/0x18
> 
> We've done the following to solve this problem:

I'd use "Fix the problem as follows:""

> Firstly, set ex_phy->port when ex_phy is added to the parent port. And set
> ex_dev->parent_port to NULL when the number of PHYs of the parent port
> becomes 0.

Thanks,
John

