Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E288006BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377882AbjLAJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:23:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8710F3;
        Fri,  1 Dec 2023 01:23:13 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B19K3Il011426;
        Fri, 1 Dec 2023 09:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5S3JFfrH/gyF1N2VAUVEzzkimG5or5dghztnloX0ZG8=;
 b=UASUe8pc6BBMjKz8CEadJfQbXBBt9uzwFTlU4FQlegZsiGIZnkoyN9dtHL0gG/RhXryM
 E/dmIR8Fc3GzBdhK6+z9M1cnP1zV/Ik7sy4Nybzc3CWWbcLeZsjg/JinnY+yn0NJVDmA
 OWl63TSinPfUg/C6hkpNJm20fz5mv0jDzDQiUhE4TDiLOCN10ddXDYiy0r6pCtnChzo8
 vfemLRRQ/j7LKq/G2Di0psQceO5vh3DeEgJT7LAFjHIn17UYHYBgfwpwqaFh19wkRMSo
 AN73+8BQWdaz+rQNjqSm7VgjAhxSUr7Kt01Apnm/IQwMSBT15Grywqk4fOigbWZ2GJL7 DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqbs3g2f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Dec 2023 09:22:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1885D8012668;
        Fri, 1 Dec 2023 09:22:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7chhjwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Dec 2023 09:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0eu7qM0K1zmM90KiE8/zyYA+NcM0plrIC+KvY1fgOyWe6r3uweMhFDHUaLFczDbKS6Akn/k2Rbg+/Uv4q92r0/Uu4do21TZIpqnYVnoiAFYn1otgRuxo8qLcbrvM3y6G8vMv4/6+N45lkBSAUcSNStEEjmaNWcR5IIVNy5e6BnU/3kx2wvrBZFMU51zmk7+sT2mWBd1XSgadfX7uz8tm9shpaXCg5AGNB5B+jkkLYZhR+31gMfK9yWzbwvGPavERsS21C4dQXKHSOgMGmFVNfWvt95cTs64t6qBfNqxGKEwQW44VxufalTwMMKjRpq3HgwAb6B08pQJOePpxibW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S3JFfrH/gyF1N2VAUVEzzkimG5or5dghztnloX0ZG8=;
 b=P78rp//ROWkRINDsrVrl9/hKsEoMtRnWFq+vAhhIT5wdrYeIfhyZnI7mjWVZkrZkVsvcL0/AtLIl2CDfef4vXsxruNBCQQ5NJlLLkIlKYKQPjXfJd9sH7NHKXv8vJh6QAf62xIitHPtQcCeepVOuyIz3qi/aB3Xtm+0ZG6RIlMmsODQ+mpAM+gJ+vsL8kABbRS9xmUVdgzLqXmOG8csMyBp5v/ChlKyzJM/j3vjw2P1cZ7Alk2e5uT6UccQAc5Boxiu0BScBT81UPu2twJCUMurT/70T6aXbrusV4qIDXiQEcBsn+oGeWyrSvrvNnvsIjtLqeDDfFeiDvnsLX2Gscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S3JFfrH/gyF1N2VAUVEzzkimG5or5dghztnloX0ZG8=;
 b=Q+B6uD0ThnfzM29L5NYJDndptazxKREqCN7iO4JJreo6H6WzHm02aDW5z47jg/DnIji3cXkjO7E+DuY30cUVmU4fOEnyfNNdEWenJoNKduHi4mZzmTDQ1zpIna8keEHnq47XznQHyqBaIqsFLWDctNgTgyTVyVmQUCKN+fbbYCc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 09:22:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 09:22:52 +0000
Message-ID: <25b6b575-3108-41cc-96d4-70279ce61a48@oracle.com>
Date:   Fri, 1 Dec 2023 09:22:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
To:     yangxingui <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20231117090001.35840-1-yangxingui@huawei.com>
 <32c42e1e-0399-4af4-a5ed-6a257e300fe8@oracle.com>
 <307d251f-ff49-5d8f-1f8e-aed314256732@huawei.com>
 <a13f0419-c4ef-4b8b-9757-7cf7cea32458@oracle.com>
 <baacad33-f568-6151-75a2-dfc09caf2a81@huawei.com>
 <cf98eb9f-ac42-4d9b-9cf3-3085f6fc0cda@oracle.com>
 <d6b20d8f-7653-6806-d7c8-0adc54f1333b@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d6b20d8f-7653-6806-d7c8-0adc54f1333b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d36527-0a41-4006-3f89-08dbf24f180d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCuCIbZuXVI50yKfP/5De+ndKgenrwiAmqE8RIal0cOdWOejwb27xxUfmYHCtMiErkdv5zkHSYUvXMtti635DoGozxcJ3S3xwiMK0kbRf3f6cyd5obWH2EXOL4qkLrnzI1CBphPWCZVDcECHgW9CtgRoZbQKY9lqqrYrLIrHNsEmdWJtBDcKo15dsiFLwctxY72MngyB54Zl6iEPOCSw3Tiqz8fIo20Ya0L11BfM6esLW8LHBOORNy8L3bN7BMvxQv31RCwRlGVvR43SX+Dt7IEY3S6/LSLQh55Jtx8ryWIDZFJXU5oMFtwmYqB2+fa3N7Q/OsFw0tsAwq/Fvke+baHnOqAf3szcYyEP92dJB82e/CnBgSSpiZc9F4F4SxZAQBgGrN6sJ8+XX8Rtw9Odu6KThWCfalJOzjFzlb+71ITqdnSvhxXlvRrn5oRovF+nOIjgGCGSgvfO3CB2NkXz+e7QbmC3rBx46pTtUb/CeEzWt4e5HnhypSdar8hmLduqXgfzLBaHRIrMJCIb9mnX940rtvCsEtO50tYTWm2YHw6Y/Pcw+Fi80oCPS+QkucChY+ma4k50jYqH5wmEDxIJJWgRGZezaf8m7HThFr3QvYkZPbgSHBmXHxd0LIRbhoR6YTiXNOfsC17JmHEHqxFSqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(4326008)(6486002)(2616005)(6512007)(26005)(31696002)(86362001)(478600001)(8676002)(6506007)(6666004)(53546011)(66946007)(36916002)(31686004)(83380400001)(316002)(66556008)(66476007)(5660300002)(7416002)(2906002)(38100700002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnBBN3hOYlk3d3U2THRybGI1N0VsRlpSb09HdE1VaWF3RktCNTFVK0xKN2JI?=
 =?utf-8?B?Rm4xNUtmRFlSejlSWkUxald2MGo4NXpQRlMxMGoxZkNQTStYVC95TnliL2RU?=
 =?utf-8?B?WjlQczVDMzZlUXBJcDlweFlFNjR2WDJWdDRYUkowSnlaNzlzWTRWclo4aW81?=
 =?utf-8?B?T1ZkbjdpZHJSaFNoTjIzOVhTUUt3UzBmQ2RXbHN2NVd5S0dsOTQvZm04K2FK?=
 =?utf-8?B?ekZNMUZPOHlqcXhIZGtMc3NUZDAxdXVDdFRIY0ZJWmhyMW5ZdDBTMEpxalkx?=
 =?utf-8?B?UVM0UzJZYUh1VVdzaTYrOCs5MjNTZnJPb0h1bFJWRUJMVm55NWlucjh0SlA5?=
 =?utf-8?B?TnRkT3d2bndZZFQ1NlV2WlE5Njkyak9FR1V2TGpqMUt4b1E2ZjJwVFNYQjJF?=
 =?utf-8?B?UTJ0R1lpdUlHblN0RGpxRmtsVFNCMW1Yc3ZxNFlTaXVnQ0IrWlpSM1VXS05s?=
 =?utf-8?B?RnFFRzVzOFR3VGNKbkp0K0RRdDBTa3dCV3B0TG5uQ3FFU0kxd2xvQVRGYzZy?=
 =?utf-8?B?NnlXYVhkT0o4WXB4WU84ZmY1T2I0OEIrYm5UWGsyOG12THJGNFN1U0JQRGZH?=
 =?utf-8?B?aklxMWtzb2ZVR29HZFc0TEZMWnJMVzZuQkUrby9BZ3NXYitlRzk0VDdwL2RV?=
 =?utf-8?B?aGdIa0h1enM1SzJoZVBKbmxXZ3grVmZ4VlI2aytaZzlYNCtEK1ppNEJHYmdt?=
 =?utf-8?B?Vk1wa0RBZWhOc1VvL0NtU05uVjZoamVxamRVTnFtM1ZBM1hzRkF4VDJmUFBm?=
 =?utf-8?B?OG9JektUbnlvSzR4MFpZNFNBZys4cDgyNW9WS1pMSW9kbW9jMkRQdjRRc0Ns?=
 =?utf-8?B?YkNWaXBDdTRBckpSZTdPbEVyZit5alFWRGxudWFWZ3hsRjNKNzkySXZ6Q0xW?=
 =?utf-8?B?TitkNXJ5M2xJbU82WVBMVHByalJ3d2lMUjQrQjI0bVpuZTl1NmYvS0VjSmMw?=
 =?utf-8?B?Q0N2ZjVZMmVoL2JGN2h6dUdDY1lWanVSOXpQa3l2ZDVyRnlqSWZWaEFDd1pp?=
 =?utf-8?B?QjNKeWFhVTh6MXlzcEF5bzErODBpZjZheFkwWUM3dGRGWm1DbGRvUjN6aXpY?=
 =?utf-8?B?QXd0RlNTVG5TY09xUDQ2cEdxRjEzbnJFNXJob3V3TndqbHN2cnZML2J5VUdq?=
 =?utf-8?B?WTVGRFg5NmQrZnREdDNFN1JyWVpwRU5qOWdnTDhGUlI5dWQzN0t1Z3NIK2xC?=
 =?utf-8?B?d1VybnVTZ2MvRVFxS3BUUWpmYjFmdUt2OW9FWkZSdU9ZcUN0RzQ4a1RqWEdy?=
 =?utf-8?B?a3RndUQ2VE1GZkVYQWl2S1hNc2tBQlJsR3ZqMnFtYlRCdlZNMlY1aHVkNlF0?=
 =?utf-8?B?VkVZY2JOb1cyOVpPaVMzVnY2VXhWaGtMaFNNZ2VxWEJyeStCT1dKY3FhZDlQ?=
 =?utf-8?B?czNUZDhkaUY1ZEpGZ2JxZ09LZUp0WGpnbnp0UDNYY0VYYW44R2JWOGNFc0Nz?=
 =?utf-8?B?UEZoOCs4NUVqaDY2bXd3WlRuZ0prakc3TzdqRjFhWHhNenNhaXRzWGxrZFgv?=
 =?utf-8?B?a3Y5ZjZ1V2o2UGxRZWZ6ejFId29IOStJVWNITHo4V1dvT3FTUEVJbDFLTUNu?=
 =?utf-8?B?S3pWYVdsUjN1bm03MzFFMGRMVlNHTGFzQ0d4S1NGN2RnKzdXekw2WGpFd2JI?=
 =?utf-8?B?WjI5UEtwSXZkUzkrK25OdTUybkJtQW9RQnoyc2c1OC91RGIwbyt1TmM2S1No?=
 =?utf-8?B?Y0w2bUVWRmluQmw3MnFIUm1MbHRhZjVqWFlnVWZWV01Pd2tUL0R2LzNMUVVY?=
 =?utf-8?B?R3U3bndONXpqdWtMbUVYOENkK2QzUEdwdk1UbXl4K1cxUlNYa0xXRng2a3Nh?=
 =?utf-8?B?RGdtLzNIczhYQ2ZDQVp1RDVQemY2UDVkSGZDZ0ZHSml3UjJNZnBHSmhmUFNJ?=
 =?utf-8?B?c3g2VkZwSEdnVU04cHl2ZWZVNkh1bG1nN25NZGdEVCt3QWNZS2JkbzBPU1hj?=
 =?utf-8?B?VWRiMGJhTmU3NTdxc0FVeGVKTnd5c2FaMUc0RTZpeFI3SUdaRnZpVUswN3I5?=
 =?utf-8?B?SndML2dJd2RZWThGME9uWUpWQVc5VXViVzQ1RDMxeVN1V2xaY1VWSml3dEJ2?=
 =?utf-8?B?UGhCcWxkMlViR3ZuU1RZN3lvSHU3ZDREYjBVcmZMMThZNVFucDcwcG5ZRkNa?=
 =?utf-8?Q?LaK6kfNoDSk+u0aNoX6V8aLWT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x9jWCTUEuTXQPPQYEYDN+0Jopb7CicvR+k5gmlcY4hYnlGIBR/tfDGk6Sd5Kkpo505hzO9gYS/RNFFLPSw1l8NmEIjEtQrOaaLkZJR3ZBwHCWcHrKcK8dTXOekMyb2PwnEIDPcKPUMrEoYXLkDDFFlrY9cAUtAfnrs8OObtuuE1FXSbr6oNpjZOYwpdJjV3bTYmOT+IWqZi4eWmBLr4NadYtu6lY4SrGnCegt4GYg+2+Mlxuc1XnzddBwb21qiiooWSvHHW4RHkxqRJ6ghErsCGW8qAB5SP9ucmQFmi+cSLMm5qIDSQgdMQH094J4PPw17AyEQDNwKXNTiwMAjBjPqCi9/NDEJ/A0qCGoMda6YQrdzNTUsj1kEEg2Mj4G7PM/OOZLb9HyMV5bLU16pJYsSYkcqjH+DAVu93olqOO7ag5tolFZkUcHZmLXa5eAZIM74J7Rc+EgXwHCTtYdwLG5Cakg2k6YQ4dNenAlGZaiKyRFfil1+t+7Wte2H6+NpVnNhnJmWk3pZrQiY1QVqA8zyAnIvCLQFL397hHzbxHO5whrl6THvbhJH7G7s3ddea3+JpAynRMJoBxc3NZAJyPn1D/S4r/RFj4RvW4a/2jvgo6kYLPfYnnrrY8p52jR0RHrMRzak+Mwp4uVaOgJTl/yHR+k6Ng7UJPsxPpmC+8HTZshw3dtYq4UN/w3Nk6u8Xq/kJR+Fpbz4oZfXWnTnwp3RG4fHii5sc3SvsRK59YFYIyCwJfiSlNuglqDdyY+r6xex3n4PMx68EgBeJ5dUf4BWw7H4z1za7SMzWFBbHeM8XawqmeZLcyXMM1TNpNBQbrooR2Al6xibItpOfjOyiruZVayWtPRS6BGazMi0KMNYP36JLp10S2Q1g9gnbLaLEbotXFhfYSki46nyhNt9lbKp25bc25rBt1Y+8XPy813nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d36527-0a41-4006-3f89-08dbf24f180d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 09:22:52.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL0BzAo/TsAxJZAof+xW76cW1jEjGW044PRhtVPRwX4cswtKFSBHWXU75cm36fmML2pGoDMnvZMSHcg/0q3tRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010061
X-Proofpoint-GUID: TQW_wMQpM_60_ZezGdc81XlvDg6mf1jm
X-Proofpoint-ORIG-GUID: TQW_wMQpM_60_ZezGdc81XlvDg6mf1jm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 03:53, yangxingui wrote:
>>>
>>> For phy19, when the phy is attached and added to the parent wide 
>>> port, the path is:
>>> sas_rediscover()
>>>      ->sas_discover_new()
>>>          ->sas_ex_discover_devices()
>>>              ->sas_ex_discover_dev()
>>>                  -> sas_add_parent_port().
>>
>> ok, so then the change to set ex_phy->port = ex->parent_port looks ok. 
>> Maybe we can put this in a helper with the sas_port_add_phy() call, as 
>> it is duplicated in sas_ex_join_wide_port()
>>
>> Do we also need to set ex_phy->phy_state (like sas_ex_join_wide_port())?
> 
> Well, okay, as follows?
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -856,9 +856,7 @@ static bool sas_ex_join_wide_port(struct 
> domain_device *parent, int phy_id)
> 
>                  if (!memcmp(phy->attached_sas_addr, 
> ephy->attached_sas_addr,
>                              SAS_ADDR_SIZE) && ephy->port) {
> -                       sas_port_add_phy(ephy->port, phy->phy);
> -                       phy->port = ephy->port;
> -                       phy->phy_state = PHY_DEVICE_DISCOVERED;
> +                       sas_port_add_ex_phy(ephy->port, phy);
>                          return true;

this looks ok. How about adding this helper and using it in a separate 
change?

>                  }
>          }
> diff --git a/drivers/scsi/libsas/sas_internal.h 
> b/drivers/scsi/libsas/sas_internal.h
> index e860d5b19880..39ffa60a9a01 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -189,6 +189,13 @@ static inline void sas_phy_set_target(struct 
> asd_sas_phy *p, struct domain_devic
>          }
>   }
> 
> +static inline void sas_port_add_ex_phy(struct sas_port *port, struct 
> ex_phy *ex_phy)
> +{
> +       sas_port_add_phy(port, ex_phy->phy);
> +       ex_phy->port = port;
> +       ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
> +}

I'd prefer sas_expander.c, but sas_add_parent_port() is here... having 
said that, sas_add_parent_port() is only used in sas_expander.c

> +
>   static inline void sas_add_parent_port(struct domain_device *dev, int 
> phy_id)
>   {
>          struct expander_device *ex = &dev->ex_dev;
> @@ -201,8 +208,7 @@ static inline void sas_add_parent_port(struct 
> domain_device *dev, int phy_id)
>                  BUG_ON(sas_port_add(ex->parent_port));
>                  sas_port_mark_backlink(ex->parent_port);
>          }
> -       sas_port_add_phy(ex->parent_port, ex_phy->phy);
> +       sas_port_add_ex_phy(ex->parent_port, ex_phy);
>   }
> 
>>
>>> And the path called when it is removed from parent wide port is:
>>> sas_rediscover()
>>>      ->sas_unregister_devs_sas_addr() // The sas address of phy19 
>>> becomes 0. Since ex_phy->port is NULL, phy19 is not removed from the 
>>> parent wide port's phy_list.
>>>
>>> For phy0, it is connected to a new sata device.
>>> sas_rediscover()
>>>      ->sas_discover_new()->sas_ex_phy_discover()
>>>                              ->sas_ex_phy_discover_helper()
>>>                                  ->sas_set_ex_phy() // The device 
>>> type is stp. Since the linkrate is 5 and less than 1.5G, sas_address 
>>> is set to 0.
>>
>> Then when we get the proper linkrate later, will we then rediscover 
>> and set the proper SAS address? I am just wondering if this change is 
>> really required?
> Yes, but in fact it has not reached that stage yet. After setting the 
> address to 0, it will continue to create a new port and try to add other 
> phys with the same address as it to this new port.

creating a port for SAS address == 0 and adding phys seems incorrect, right?

> 
>>
>> BTW, Even with the change to set ex_phy->port = ex->parent_port, are 
>> we still joining the host-attached expander phy (19) to a port with 
>> SAS address == 0?
> Yes, in order to avoid this situation, in the current patch, we will not 
> force the SAS address to be set to 0 when the device type is not NULL, 
> but will still use the address obtained after requesting the expander.

ok, let me check that again later today.

Thanks,
John


