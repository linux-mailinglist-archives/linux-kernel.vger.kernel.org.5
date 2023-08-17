Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5677F291
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349205AbjHQI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbjHQI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DF26A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GNgV7W001770;
        Thu, 17 Aug 2023 08:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Zot0aB6TRAPEIFFDbEn25mqG/HFJ2mzDWXCsq3KZhyg=;
 b=l1DZSJcOvqwCmkqRtsVN/BCE9B7KHEBy7rVSSvAqremrJzffcVqIsHKV4O0AbuOj8+tm
 0SDybXDdAxP2GiztfUToAxGH6xicAz4WivEgggj2wSDnhq8lu4hO6D4XYkJ+08wfo4z4
 zU443HjUKJ1OaIX0suwH7k5WO9f6aHSLtMBwCBw1YUrErolD1kNGn4sfEFFRHC4sUvUp
 nYH5GffipG2TLGpEzWnCsThThHW1QWmNCdpkiNj6NPNHM3fxA8ptZHHGJcl6BMpAgJVR
 v1wO3Kh/9ThfH/dXBhNHqx670+aTS4GkOrvh28OT+gInC69720pC+UmVnxlGtOqW59eR Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xws35j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 08:57:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37H8tq5m003714;
        Thu, 17 Aug 2023 08:57:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexymbkxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 08:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw/ZXHMMiRlsnmbsNQobBWIJes3W6gcOHBU2kAQaC/SzohnYAmuTsdq7dD+fSTa3mWWGzkk6KAdcJfi7FiH79LqvQGlr/mv3AeiH0bBInifRxyI08bKSBZE0aov6hSOHWU56dzwCUniwWGQr0Nr7F8yhpAEEP7ungmhbXDMtfVRFwR+gePU6qNP1La13mewtbrOVRQQT12gfca/Ibjx8yPloWlmDnm7CbiSgApZhc9OlUCtCG+FRLhn04U5tE8f5NiAPWyradaLgCHZq81Gz8+AaLNlt69AyOJUfcVh5pgVUyOtRHePb6V/0PKzzZB6KOzr/HbJsgzwe9YODKO6CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zot0aB6TRAPEIFFDbEn25mqG/HFJ2mzDWXCsq3KZhyg=;
 b=YMLF5OI5VwDnhp6KLDiOBSxh1EKI2d2mugKvp2x+V808JGLfNYna6yUF6ReD8s1qRmJayC8O7mjem3q4a2QFceWK71Ml/jOeLflNcQbeMv0VRz9aNlKb2NlTUf2s5QhKSW/kd3tBFj4269iOP3LAN2llyY6uGAZNm4MTGax/JyKCCo+GUy/Gmy5d4Ib7nkdKkPNDagOSZE0sLwTUWQiNQ+L56iNKrFxPkz5/2YVlYeEYwm/SUYkRVXr2szanTKd80Bw/iOi1Q570AAGHnSlg9FetJBvRcTn09gceked9U1kns3qiPPmnOTZizqIzWatde35A/2E5rhZW5Sq5O2mKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zot0aB6TRAPEIFFDbEn25mqG/HFJ2mzDWXCsq3KZhyg=;
 b=u5gpjRcUmWqjKNx581E+F1BevHO5Ah+a7N1CGX6b+qIEN+n5NH/K945o4htm7tLpbxfxW7pVFw3SgzjjVTBV+8+LHNnTi6PE4b2cv39bOuEJiwQCUNtcAevSm8nOBfcPsFznkG8g48GDTLO9TmSa5gd5BIMm03d9koA68ibTaXc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6483.namprd10.prod.outlook.com (2603:10b6:510:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Thu, 17 Aug
 2023 08:57:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 08:57:35 +0000
Message-ID: <372712cd-d825-e5f2-bd02-b2210c6ecf61@oracle.com>
Date:   Thu, 17 Aug 2023 09:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Dumping a struct to a buffer in an strace like style using BTF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZN1pveIr5W1ulPHh@kernel.org>
Content-Language: en-GB
From:   Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZN1pveIr5W1ulPHh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2b5374-072e-4e4e-b5e4-08db9f00005e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvTqt21emC10hP2DB7NwY/JHjuNhuBmtIMHq5P0KEn4VQVArTl+xAxupCDSXZx6GO338QrIurR4PVkFJI5I37fCGUC5y+EX500bTBHACwhS2RLk09b3zlnJ61IoWuZk8hFhLe1+v42afKkHQZBTmimmgJcLMYPeCGBGQhfZfRmo/2jMUQC2I1K4VPRf4gH7AENk10Q7mATTgNZ9ECgtaUG4F0yBbljBXS6LXHzCh05m/aoX3PYVS1VCBh0XYD32zY1lBOxNR7MD2K4ko26othSX2o51e4uxG0UDYgoVNnFiBV+POxJXyjwT21jMQOvG7ZVKY7g2UyDV7lUJw1frJ+q+c4ah+fTItlgwSSFc3AXwZNX3MIjgFwoSAgDEZPOMm+/N9pNJ1gN0S+hKFYhHHWVxWLrkCeEpYEM8UoDP5z1WrletL/UNH3nsKikdJfZ6Ay357UtdtzLsvZUNpDJN1pr3QHIR4JYM5luBiw1h5S6R8zq2AldAECwe7CgZ/fkYELyV8uKOxBVmrUrNLlT5FXBa0G5QoYBhBdv+z+GvvDa8DVHMui2bOIqYEUSaajZCkwZkgVadt9JkAUaqrxkONIlP0k/ONLYaodsTfoj2a+mzk93bXvgOCz1rTGD459fPAEZOtymgHaDQbfeR89/31DCr3PuGNx65l7yFg0aRPscs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(31696002)(2906002)(83380400001)(86362001)(478600001)(6506007)(36756003)(2616005)(6666004)(6486002)(6512007)(53546011)(966005)(44832011)(5660300002)(41300700001)(54906003)(316002)(66476007)(66946007)(66556008)(6916009)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekV1eHJ3ZnJhNkhuUEVRVW1NUzNQOHBMa28rd3BqdE1ZMVY0b2RtUGNuaEZj?=
 =?utf-8?B?QllldVNFN0kvVmJnR3lTb0VUalhPRGF4VTgzNnNlNjlxeDc3UmF1Nm9lOHBr?=
 =?utf-8?B?Z05mU2pNNHA5Rkl5cnhheHV3VzJDdHh4MVdxaW90cEpHMDhxdkV1MlU0dXcw?=
 =?utf-8?B?TmhzdExLVmlqN0trMmJVVG5JVXh0RGNnUmpKYWd3blFoVnFqUGY4VEJlTm14?=
 =?utf-8?B?RmxBVU1ldzkxa0xzZXNLRndkblVLRnE5Szl0NzEwb0hzUlN0b1Z0TnJXQmRt?=
 =?utf-8?B?ODJ2WWNKZnFBNDBVMGJRT3pKWkIwUGM0Vm9JZUt4ZE9UWWpDWEM1L1FLRmcy?=
 =?utf-8?B?V0hUcHBmRmN1bXp4d3NPbkFRbEVscEZXM09BN3MxbEJ3L3NXV3lOZWV1c0dw?=
 =?utf-8?B?cy9udEdzZldRMnNrV3VxMC9Vbkw5eGVURk84aU52SVhTbWd2VCtTUHVSLytF?=
 =?utf-8?B?cnR2bDdTcmVkclJJSFNvMU1NUnlWWW1kVlFhK1daNWJHZHc3K2VRRHpMQ053?=
 =?utf-8?B?Ty92b2w5clcwUExIc01NdG81YnVIcm9yYjdlTjhKSDU5dmFSYlFDbDhLbDNE?=
 =?utf-8?B?Q1ZPd0tNMXcrc3NrZE14TmN0NGZDUGtMM2tDdFpSYzBZNlNqdUVZRHpMbWM3?=
 =?utf-8?B?aXJrdGc2QWZZeFVlZlBNeC9nK3IwSmM0UERhWG5GQUFHTVVRK0F6NUt1dzNw?=
 =?utf-8?B?cDg5b0tkNkFWSjNUTHRaQkc0MGRqVkhHUGk3VUNtSDJ0S2o2M0M2M0YvMDNJ?=
 =?utf-8?B?dGJVWTE4aEFCTGFKSWkzY3cvZUtHTHZiNUNnSTBPeFlDWmU3VkRuWnRNN1Fr?=
 =?utf-8?B?TEQ0TUZ4TWx4NkpQMC9oNTlEWWkwUUlTeFZTSzNJOVd1YkU1MERmZklTVVFr?=
 =?utf-8?B?eStjRWEwRDJKSWkvWm5URmRCV2R4ZE5RVEpsRDFUWmE1bXF4Q1ZtQVdPR1p2?=
 =?utf-8?B?Z2phT0s0dWhaajdobVBiQ1pPNUZoazNQRDVMZXJ6Q1d3VzA1ajl0ampGTTdL?=
 =?utf-8?B?UXI4cjQ3UklQNWhDdmZvUDg1TkFlQTNrSmFtTERkNHFzV1ZuUUZnUUducS92?=
 =?utf-8?B?VDRKQXBLaUJ3bVdOdmZkQWgzU2pEREozOUkrK0NQaVBKTU85UHlIUmxIaXdn?=
 =?utf-8?B?ZDRZSWs3R29BZmlPMUZxSCsraUJXcElaTjE2REtQN2pjbnM2am5BakxESndj?=
 =?utf-8?B?MTY0K0x4MTNCVHliRk43akRpZVJSbUF1ZnhjNnN6WjdWT2pwQVVFU1c4UE9R?=
 =?utf-8?B?bk1qcXNoSFhTRmp4T0hyaHRiTzNtYzhXZHlmZENmVHlEaTNPTGRZOFB1blBy?=
 =?utf-8?B?Rnh6UDhhWGMxRDF6OCs3eGRKdUhMR0h3SzV6TlNUM0xJTWQ1Tm9FbUJFcng5?=
 =?utf-8?B?d0U1RWR0MldmUE4rK2ZoNjV5ZGNEWkY3Z1lpaXFPRG9JR1FDTUhWRitMS3Z4?=
 =?utf-8?B?Q1NGNkQwSzZVTEdtRk8xVFNicU1xdVk3MnpRSTdOYnlhSERLV0Vrb2Irb0lz?=
 =?utf-8?B?STcyZjQ0bUJFMlRIMW5uWldjZHNYeEJ0ZHh2ajd2WXEzQlBaWThKdzgzK2lq?=
 =?utf-8?B?SkEycHcrZDhpTHdaek90T3hiN0ZhcjJ0SWFEUUtaMEx3akx6YklERjdmT0NF?=
 =?utf-8?B?MzUvYmo5ZnRiQU93VEhHYUF3NkFRUUN1Nkc0d0NvYmZWSUN4VFU4dlMrWHVl?=
 =?utf-8?B?WEpEbjBrNXJtU0NvM21HbEtrTm5Wd0o0UGxtRUp3WXRlU1JCK3dhZVhUOFV3?=
 =?utf-8?B?WVFSVnJ2KzV0S3V0SU4xK25lUEVueUFlOVl5QzNKenN0VXRpK0Q5OWVaa25S?=
 =?utf-8?B?V1BLem5oSDAvdk9jLzg3Q1k1aGlVWnBKMWNYaGlEdXFweWtFeTRKRjcyU2ll?=
 =?utf-8?B?YXNlc3FpQllNNENZSTlLb1phYi9DNGZrYklEd01nNHErcVRWdWs1NUlHMDVu?=
 =?utf-8?B?b2N4dVVVaHAvdkxKcHc3SVF4eXIvS3lnOHlLNXdZSUx2cEt4K0gyWSt3VFUv?=
 =?utf-8?B?QlJUL0lvdGpVS3MyRnV1dTFGVDl3NGNxSlZMTUNRVks3U0RWazB0SHUwMVp6?=
 =?utf-8?B?OVJ5NXpKdEdMajBFcjZSM1cxSmRqS1gvb0VtLzN2eXJUVXFvNHY3cW5ZcWM5?=
 =?utf-8?B?YmYwbkVBbXRIbFdDam0xdmJJallacE9Jczkyb1FtbXYwY0xiU0lsMWRISDFU?=
 =?utf-8?B?UHQyUmY5RDVyOStaclMvaUJyKzZqWGFxRlRkd09ra29RQ0xSZUpTMTcwSzVW?=
 =?utf-8?B?S1UzQitUMTFsdnJIWGQ4c0VMbHJnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HbbX55DC3nEjoPuFOih3wtFR5no9yK/joG8B7ZT+ssJWqDw91KBCEARm+e279kF03wbMo/CH7xVFzj13VQrVdrh3glaE2lZRgfL11gZAyNxXg4hsi9V0p/TZQ7cE+ljJr9sicBTM/aX8IVp2ktJ+8PvdCTmGZvDCObi8DRvUsR0lRRbzOHzScxjp7Xh+1JD7vctpvjvQDGPmrKmcz9q6A6IvlIB6BmwRDqwaRz8IoAln2WcApuMlxmtuCYgwWhrE5XG2C+sWgC+xIvErP5jDLgNqOP7c4tdMVM8xUvPQdf/hmKo53PH0G7DeNGG8CoqJLlgV/0Y4Ouz9+nfgf+OZZ3jbymHWx3pcW3jyZGA9t4HS2YxbtWXy0SFtwSiU16Wt3Lx9iAn2gQy9HZyT9IoYMc2+bcFSVQwrCrjh4VcvrqSY9rIT7Db2nUhnsfe1G2CLUZREyDFIUyw/CdDasuvFo73YaBKFtyeL+PGrIDqG1CAP3Wxk1HusvXtfQzuULYC0OCJSi2psfzguw+jcJjNQYfaWtJMmbonFda17BeD3IUh3XetZwgKIEb5gBe1h0YsDMmcwrk5IRpoHji+g6LeuuEfpp8OBjVzqrSr7wqKmp+MdIpcgpfrQ2yx8WuBiaYXgA2VwuiIMoo257yjuKeKH6UdNqHh3Q+7G7mFG6UOVfP5BA5j6fWMRyuWxbpWexTjIe3tE86/4zDuUvpuDdPx40i3amTSraxYlwd6bsKYcgGbOT4uf8ZZSUdZTXtlB7qXOT9vB79CRIngIIqWWkBf7WY15XLS5wmJDIuBXr4jlEGa825yey1HojqhuxUkgKa1BNmhITO9UGW34EOBU6Wj7k+bE/JLeFNqQpxXJZkPJs8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2b5374-072e-4e4e-b5e4-08db9f00005e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 08:57:35.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5lTDxJ5pvbO/O5vjc5FIdzAEoAtLbIe2LohsKyMwR+lq2homdqOD8sWs8EHxI1p9yk4ZTVyBAgpaHxJJYhoGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170079
X-Proofpoint-ORIG-GUID: sXWAkiFXEAhYkJbxbYqQSIxaK4QxHOzm
X-Proofpoint-GUID: sXWAkiFXEAhYkJbxbYqQSIxaK4QxHOzm
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Arnaldo

On 17/08/2023 01:28, Arnaldo Carvalho de Melo wrote:
> Hi Alan,
> 
> 	Something I planned to do since forever is to get the contents
> of syscall args and print in 'perf trace' using BTF, right now we have
> things like:
> 
> [root@quaco ~]# perf trace -e connect* ssh localhost
>      0.000 ( 0.342 ms): ssh/438068 connect(fd: 3, uservaddr: { .family: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) = 0
> root@localhost's password:
> 
> in perf-tools-next when building with BUILD_BPF_SKEL=1 that will hook
> into that specific syscall and collect the uservaddr sockaddr struct and
> then pretty print it.
> 
> That is done manually (the last leg) in
> tools/perf/trace/beauty/sockaddr.c:
> 
>   syscall_arg__scnprintf_augmented_sockaddr
>      af_scnprintfs[family](syscall pointer contents collected via BPF)
> 
> which leads to struct sockaddr_in or sockaddr_in6 specific pretty
> printers, I wanted to do what these two struct specific pretty printers
> do but using BTF.
> 
> I guess this is already available, but from a _really_ quick look at
> libbpf I couldn't find it, ideas?
> 

This would be great! If you take a look in btf_dump.c, there's

int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
                             const void *data, size_t data_sz,
                             const struct btf_dump_type_data_opts *opts)

This will dump a typed representation of the data, presuming it is of
the BTF type specified by id. You get output like

(struct net){
  .passive = (refcount_t){
   .refs = (atomic_t){
   .counter = (int)2,                                       },
...

You need to call

struct btf_dump *btf_dump__new(const struct btf *btf,
                               btf_dump_printf_fn_t printf_fn,
                               void *ctx,
                               const struct btf_dump_opts *opts)


...first to get a struct btf_dump *; as you can see above you supply
your own print function. There are options to control indentation (tab
versus spaces), compactness, etc. If there's something else you need
from the perf side let me know and we can try and add it to libbpf.

I coded up a proof-of-concept example using this stuff to dump kernel
function arguments; it's called ksnoop and is in bcc:

https://github.com/iovisor/bcc/blob/master/libbpf-tools/ksnoop.bpf.c
https://github.com/iovisor/bcc/blob/master/libbpf-tools/ksnoop.c

...so that will probably help with the details. You probably want a
similar approach; something like

- foreach syscall
	- populate BPF map with vmlinux BTF ids of args/return types,
	  and associated sizes of data to store + whether it is a
	  pointer (since in that case we need to copy memory at pointer
	  address)

Then the bpf program can use that info to copy the right amount of
memory to the associated buffer and dump it to userspace for display.

This would allow you to have a generic augmented raw syscall BPF
program; it would just need a way to look up the appropriate map entry
describing its arguments etc. ksnoop does this by storing the map
entries by function address, and in kprobe context it then looks up the
instruction pointer to get the right map entry.

There's more info at

https://blogs.oracle.com/linux/post/kernel-data-centric-tracing

Hope this helps,


Alan

> I want to try the code at the end of this message for another
> multiplexer syscall, bpf(), with this on top of what is at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
> 
> Best regards,
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 9c1d0b271b20f693..79767422efe9479c 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -319,6 +319,27 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>  	return 1; /* Failure: don't filter */
>  }
>  
> +SEC("tp/syscalls/sys_enter_bpf")
> +int sys_enter_bpf(struct syscall_enter_args *args)
> +{
> +	struct augmented_args_payload *augmented_args = augmented_args_payload();
> +	const void *attr = (void *)args->args[1];
> +	unsigned int size = args->args[2];
> +	unsigned int len = sizeof(augmented_args->args);
> +
> +        if (augmented_args == NULL)
> +		goto failure;
> +
> +	size &= sizeof(augmented_args->__data) - 1;
> +
> +	if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
> +		goto failure;
> +
> +	return augmented__output(args, augmented_args, len + size);
> +failure:
> +	return 1; /* Failure: don't filter */
> +}
> +
>  SEC("tp/syscalls/sys_enter_clock_nanosleep")
>  int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  {
