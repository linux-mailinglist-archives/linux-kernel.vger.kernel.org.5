Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE58776FF2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHDLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHDLFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:05:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FE9B;
        Fri,  4 Aug 2023 04:05:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373LDbWF012723;
        Fri, 4 Aug 2023 11:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AX+fwYfeJevoen4m5TDDK06Rq80P5VgHXBSCkpNNyhU=;
 b=VqxsS3qCbOFJGao9H5tXLMFOuokX02b45B83skcI9IBonW4vvth8u6W2URPXw/PYjbNd
 URbXiUWnKttLdtCm4w+ZcszWvdqOtZC46yybVOH8hjdrhuoK0mtxdg40wI6ligg+v8nA
 b5hY46aolAT7w7VyTLT/1ahGo5t7DRpajGWQsHrgg5J3231IxncEDuN4CZxgPyWh+9WY
 Cbfxk9/ZOL/QuNo27p7u0sF/6Oa/UGfnX+8NltmfETouJZ6KSIR7BkaigjAhMVfVbNES
 IN0brr7tncKyt8E7/F+FsYm86Re/WmoG7Mgj2A2CFOd4N+aBgNBd3uT1nS1vBdSGywFQ 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttdbnrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 11:05:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3748iYUa029322;
        Fri, 4 Aug 2023 11:05:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m28vnxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 11:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF1BhRKVKsaMeFiZPdAPd0OZ4T3gMbkOuvLv3VDifQndHaLVOBiznufqDrBcLcmqpnLOZVQGnA251N9BQSJMSAD0tlQDgw+GuCtyqz611FX3t68Rw9Nbi9VD8bZyfLrnj7rUdeg9Xzj6GkedOPwgIrNxxYUgmV1DVrmIg/5iF0TuWJtIQhw0FPo6ip5NjXG/LjNnHxlZw6BclK0/3UuNyi0hutcWvsmQ8ObAYaANQZwUI5hsGxrweNWiKiNU4sC4neDFMtf2QlnE9gHHFo6cQUOyX82+4tQkIYwhSVnpdnrk/YCfQj1WNYEuSb9XJuWG9ada2lpnCyZXFFdr8Fefbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX+fwYfeJevoen4m5TDDK06Rq80P5VgHXBSCkpNNyhU=;
 b=QJtKyUJvaHB5U6LRZIhjjpnBOqer+aHlu71A/CVMh8/I13gb8smEYOk5YSrMFrZ+VIySbWmfNChNejVWiEHp/otiWiebHnrvFOzTsXYYDENjnD4+JkQV7lIFds2D5I52cBuxWONI6q7jbA/vNzIzX2KkqILuYSqE6ddFlVhHbPHKsp86cc9lXIIswUoCzaQ1R2+/XsV2JWsAMZV5Gml1X14Pd+v44o3hLrGmCGsj6dSSyeRRi+9Awrrie+bsRjV60K8WJeFsvAMV9Ts/L7sEG4la3KbSdOiMnxWD2l9SFksW1iIqb+YFo0XsgjeVHauRh6zcVeLzkauCHyecsUnN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX+fwYfeJevoen4m5TDDK06Rq80P5VgHXBSCkpNNyhU=;
 b=E6MnEhCZpl2cDPLY9HpREfAZgHbQLdnIeLiHAyWdFtAz5WOjsjVFktppBDEj00svoTMbXVtMbjBDXuzSfLHBlZReN3+yKOWfxTuOiEEDWhL17alXYSkEBFr9vjoXK3AZAMHbtwfeYEt66EBJX2AWr4GlSuFvNZCDG2jxojBByHc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 11:05:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 11:05:21 +0000
Message-ID: <b690cae6-ee9c-2c6b-a19e-60088cb8cb19@oracle.com>
Date:   Fri, 4 Aug 2023 12:05:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] perf vendor events arm64: AmpereOne: Mark affected
 STALL_* events impacted by errata
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
 <20230803211331.140553-3-ilkka@os.amperecomputing.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230803211331.140553-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ca0070-29e7-4f76-d516-08db94dab1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCgzjKy2EFDY/Ovum1jTGkdD0fDy/Ew2AQt9vk05LUJYVH+K0Wo/tNbBCnvkZxy/8T7oI84ZDS3kjfb3MqjNWVjBf/vQ9xZbj/C4K/7tiR7dWbMD0r3B8zJ+vsTEH9iRvaUaQ7/rQWGhbJC4yP6c+a5STvYRLSkWHqYEYx9TXq71GAPUcfCxvu1khnQ/zdk7fs6UviqsvJ1YReFsa5xTRBDZynJX12U3Cof5IuMkOQg2tU8unEdWijhxFr/ivosqbBOKYqwK7ppQvgVj44n4hR9Dtz/IA2lWmHRVrG0JSbSxiLQooEjHVFtrXQZXQOqZx77wvILPOz6sdtXSpxovse6GcYm0RowzX0a5TnlwEbJmO4YVXw12GdnKxnUlT1nSo+Ke/VBMEbttcRULB4wjJBXsV7t8cOt8MBh+o38VGGfSblpJ/1lGxuYko/W5hCBG82gqLaZhs7/dyM0Hca4OoO/zVuViJ5iAQ8/18MlZfT7yjhn6KozHb5iPaIqP+6OwweSWEQNYnfwSyMsGnV19p3x5PEAhmxTfGGjnBDah74m95+oTxdaLAihdrhOqHpzDIQUK+tyHXyMSzCO634JPXcRrXiLiCbQ1iRAdo3Lzuf3ZESG73qMC4bcmxRuqF9A+RXPLH1RAqFPnKfy1kRTaBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(53546011)(6506007)(107886003)(86362001)(26005)(2616005)(31696002)(38100700002)(316002)(6512007)(6666004)(110136005)(36916002)(478600001)(6486002)(54906003)(36756003)(4326008)(31686004)(2906002)(66476007)(5660300002)(66946007)(66556008)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VEOEEydU1KN2hKZ3V4cGpwNGEwN3VqNitQU1dUajlMYTAxdlNWbHJ2UGxC?=
 =?utf-8?B?Z0NrRVdyd05nS1oxM3ptaFNZbmE1ZmROT3RXL0NzL0pIMExkcTRETVgvcTJO?=
 =?utf-8?B?MU5kSy93M2JqQkRNQ1FUVnNIc2E3M2huY1Z2K045S0NoQ25ETzVDVzJBWUEz?=
 =?utf-8?B?RzFHK1R6K2xHdkxON2Y3amI1SjIyWE9qTm45OXNaNTdCVjlSNlZ4Mzcra2Nm?=
 =?utf-8?B?WlhWQzN3QmptbytqQnB1RnBtMDd2ZXZWcWRmMS9SQVdlV2NYUnJJYnFZcW1V?=
 =?utf-8?B?Qno0Zk95a2orTHZuVmxsUXZUMk5RQ1FQZWtqTytYS2JCL0FCcmJpT2V4NUNX?=
 =?utf-8?B?dE10L1kwcWdRVEkwT0p3cUR2elNoa0ZWZ3VhdDVVejFVWmZqL0JnZlhDUFlU?=
 =?utf-8?B?cEhDdVdKN1o0SVdEdlRXcklFVUlsWk1KRGZ3RkFUUXYwZHV3WFNrVmFBSzFa?=
 =?utf-8?B?Q2laUklqcVNPSllHRnluUm1BTkdOcG9iNk5Nb0ZneGZ6MDQ4UDlSYUVXNU1U?=
 =?utf-8?B?MlpXVmhnK2JpNWlwZTJCbkNFT0VITmpPK3hDTVVZeitWRDEzZzVVVUFxc3Y0?=
 =?utf-8?B?THVaRGNyUlJaK2dqRHlKeFJkS2w0MlBCUWZ2R3hUUzVzeEZwUXNRUFluSTdv?=
 =?utf-8?B?RHhaUy9ERkhhS1dYVTA4MytYa1grU3Q2bmtoYWRHWlk5NVZXTEt0RENTNmVK?=
 =?utf-8?B?QzJUMlZyR1NJVU1tRUVUczh0WmF0SFIvcXpBdGt3YkZhRXlOTGFScUQ3TnIx?=
 =?utf-8?B?WWFpcFQvUDJqVDhydjdlNUtvZ2xUeXh6Nys3K0tjaExIWndxcHVrSWhZUGFQ?=
 =?utf-8?B?RDBIbTBzNTZ4b0JWY0tlK01zRnAxb2M5WFdjcGdhc0EzNk9BNzlkMnlhbTFj?=
 =?utf-8?B?MjJNWll4MGhqbm9mYzRHVHVrTXFxb1BDSTlaeWhzVFZyTGNKMmxQZFVKS2pK?=
 =?utf-8?B?c1NoZit2RExWeGRGSU10aFRhdStxUmVJaGhhMEY3c2pzWXhsSVQwM0pVell1?=
 =?utf-8?B?eEtGdGtydis5Y3RobW5KOFN4Vis4N1VDR05hbkxCRFFRRkpFTHU4WWpzeXFt?=
 =?utf-8?B?TjRZNGRIaVNTQXdUN2hFT1BZNmxENEhtUzRRS0FZb1Zqa1RhQWhjc1Mvek9B?=
 =?utf-8?B?Qk53cnNUdUZoYVdtZEw1RXVkdnNSZ0tnUG1ia01Qa3oxTFNjd3lvNTVuS2xu?=
 =?utf-8?B?QkEyZEZVMmk4YjRkNFpOU1M5aWNhNVVSV2ZyOFVVODNjL00xdmdJcVVwNmVa?=
 =?utf-8?B?TmoxY0t5Sm9LN1dFanZjNE9YdjlVd3lTQjNzNmtBdm85UVVhWnZ4QW1qT1dY?=
 =?utf-8?B?T2djMmFaVXl6a1pFNzgyNENuVVZHNGJmR3ZnaWZteVE2dzNHemJmV2FmQ3pN?=
 =?utf-8?B?SVhLVFZ1QmxJd3JXTEVydTA1UG9mc1A2WWw5Q0tzUEhsNDMrcXQ3NzVOUlFW?=
 =?utf-8?B?UkZSd29JVWZDS2hzemQzZXYyc2pqdGpnQ3R2a0oyWkhXdklKMmRsTzNvZzk1?=
 =?utf-8?B?bkowNXZCVXRHaHhYc1drM0MwYjN2WEZ3NUpPSG41djJDRnRCbkxjMHVvTWlR?=
 =?utf-8?B?MURpaHB1VTVQejhocjIvM1lXK0k0d0FTQzJTcDlTMFNzelVGbDZFbldqcmd4?=
 =?utf-8?B?dDNFOElLYnNFZjl6VHFqaThsYUhlMFo5d25aY1lHQVdENTdQakRjRE9oNTUv?=
 =?utf-8?B?ck5oeDU2VnNDT1V0Mkp1Zlp4a0pjUWU3UG9ReEJJeDlOVnhBT3U5WGxjekhV?=
 =?utf-8?B?WmhiTGNtaWh4ZEIvNTVnNW9EWW5JazJkMTlmL256bmVBVWhDSEd6aDhWcnp2?=
 =?utf-8?B?TDRHNGhOVkUzSzVJZGpMRWhlVnRURm00OEtVU3pnb1RTRmltMThDU2hPM2U1?=
 =?utf-8?B?VUZtYU5VcUdnS3IxSk9KcE8wWHNVQlVSWG54eVZYbFVrb0g2N1BQUkhiMkRX?=
 =?utf-8?B?SWxNbWduL2VsbmhIUi96MGJqZzhGUTlzRDNmQVkwVE1uRWdJdHExUFk4YzZm?=
 =?utf-8?B?OFl3eFFqTmtkUXNZSEt6WjhzMExmQzFidU9Jc0d3cGpNTGRHQnBFeHhsOU5O?=
 =?utf-8?B?YUZaN0JxZlRmZ1dkajg1WjJ5UDZxOU00cS9PVUxldFlzNm9IRmZhZ25pMHBr?=
 =?utf-8?B?clNCaDV1bU54cEM2YUhCQUxNMkUwaFp6ZDZQYnBUSlFsbmFEQUNhWjJvMDh6?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?STVEUnJVZFVkQUdyRDA4L1g1dVg4OUZpTHZXQjl0L2w0T2ZGZGVDa2lWZG0x?=
 =?utf-8?B?bzdiNkY2aE9qVUF1cFpjNFphKzZpclgzWjNLWjdGM1BFTFdKT3FaV2ZRTHky?=
 =?utf-8?B?d0NvajBpUHBBU1pYK3l2YVN1UUNWaGhKV205d0JrRDBobHBsL0JwNWVKK04r?=
 =?utf-8?B?L1VJcGZGSkhmZTA1TkFEMnRMdkxLdXhlUkNOTlFDQzlZOFNPUklzemo3SUJU?=
 =?utf-8?B?Y1hlVC9nUjBQb0pWaHRQN2JPRzBtRVY4WmtDeUpCc2xISHRCYXBaTzNkajYx?=
 =?utf-8?B?VVJ6QWRXc3pWRWN1TlRNTDAzTVRVbDViOU5oVVlsVkd6S1JwWTM0RnZYMFd3?=
 =?utf-8?B?RkNIM3d6eXFING5lSWZNNDVZNGxpZElUcENTcHlGWDBtTTVZQjlVcHd5dUVp?=
 =?utf-8?B?WENrVzhuWEVabGorajdESzB4dm5xOCt1bGlyY3FZdFRBNE4xUVZNSWJwTldZ?=
 =?utf-8?B?elhFWm1PSWk1LzhRRmdVU0ZJSVFMdjN4QzFvc0t1eHBpRWFSUlZaeEtGc3dW?=
 =?utf-8?B?dmc1aXlobjZXUkYwaFRXZGhEaS9TSGl2SnZxejRwdERjWmtraVBMZ2pReTdS?=
 =?utf-8?B?TDNFWDdsNWJFZUhkZWRqRDVLVG43SUpSRzFsZ3U5eTgyQ1dYWGtxUUlRblgx?=
 =?utf-8?B?bW9oYUc1cWpuZHJ4Umc5WStZOUVIYUpvUlprZERlTzFUSXZJWU5yRE0zZXFp?=
 =?utf-8?B?WHFDVnljMDRZZnZZUkg1bEJBNzZnWWYzYURxR3dkdXI1RXFEWjBHWHdyajNG?=
 =?utf-8?B?b1JZdXh1YllzS3M3UE1ISStvOXdpZEEyUlNRaXJBc2pndk8vYVg5WHVVeU0r?=
 =?utf-8?B?cEwxNG10NytPZldoRGk1OERSMkhXakFKTHdmT2s3K254UVNSOE1qOEFwUTBx?=
 =?utf-8?B?VE1wN3VvQi93T2lUYVBOelBEUlJZNjRzVU1xNks0RHQ1ZEtSY0p6cHF2ejNB?=
 =?utf-8?B?ZzJBK3FtOGVZSmRIdTJSaCsrNU1QRFduWmFQbmo0VXd2MnJYclI1M1o2YjRu?=
 =?utf-8?B?VlpzYjZOeFZMSVg0THpVeTZ2VWVySm45WEdTSGtjRlNyQkdnZFNvRlhkeHVy?=
 =?utf-8?B?UU0vVXNkdkQ4ZkpwU1E3b1FvT290SndGQlBSTmhaYWk5eWsyWmhhUy9KclVu?=
 =?utf-8?B?YmtNTGZtcWwvSmhrZ01GZVpueTY5VmxENnB6OUZNc2UrSVJNTmZKM25FUXlo?=
 =?utf-8?B?Tk4vUHRlYVdIWm0wV0djREdkWWZBeGJ6ZnROWGplZkMzVko4cVdLUUM2anRH?=
 =?utf-8?B?K0pYTnljQUdtNjhrKzNvWTh2a0ZEeCtDalhldzNidVJyMTFGY0ZJNEYwdlJu?=
 =?utf-8?B?M1ZDb254RCtBR0wxbi9ZZXA4bHgyYm83bmVxVGRZTVVNRFhPcDFXY3NPSTRE?=
 =?utf-8?B?UEp5VjhDMDhKVERSODVrRUhybzEzc0lMU0lGYXl2TVRLckliV0ZwdXE5NVhP?=
 =?utf-8?B?UDZmS3Axa3lHRU82S05FbTJqekk1Yys4bjhkVVdhKzNWZ01xcVpBOG0xL3NK?=
 =?utf-8?Q?mwrQA8LHhKdcQ8rwmCb429ssTRA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ca0070-29e7-4f76-d516-08db94dab1d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 11:05:21.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMt3amuZA+OMCaegHIpjLM7MAF8sFwUP75TpuBNLVOimhaY71z7xfi5MiajXHuzp+hyFfrrD5KYsx1HlzLBJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040097
X-Proofpoint-GUID: 62KgAQbnT26ZzgETrt3_6CcLC8-bNYIT
X-Proofpoint-ORIG-GUID: 62KgAQbnT26ZzgETrt3_6CcLC8-bNYIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 22:13, Ilkka Koskinen wrote:
> Per errata AC03_CPU_29, STALL_SLOT_FRONTEND, STALL_FRONTEND, and STALL
> events are not counting as expected. The follow up metrics patch will
> include correct way to calculate the impacted events.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   .../arch/arm64/ampere/ampereone/pipeline.json        | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
> index f9fae15f7555..711028377f3e 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
> @@ -1,18 +1,24 @@
>   [
>       {
> -        "ArchStdEvent": "STALL_FRONTEND"
> +        "ArchStdEvent": "STALL_FRONTEND",
> +        "Errata": "Errata AC03_CPU_29",
> +        "BriefDescription": "Impacted by errata, use metrics instead -"

why end with a '-'?

>       },
>       {
>           "ArchStdEvent": "STALL_BACKEND"
>       },
>       {
> -        "ArchStdEvent": "STALL"
> +        "ArchStdEvent": "STALL",
> +        "Errata": "Errata AC03_CPU_29",
> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>       },
>       {
>           "ArchStdEvent": "STALL_SLOT_BACKEND"
>       },
>       {
> -        "ArchStdEvent": "STALL_SLOT_FRONTEND"
> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
> +        "Errata": "Errata AC03_CPU_29",
> +        "BriefDescription": "Impacted by errata, use metrics instead -"
>       },
>       {
>           "ArchStdEvent": "STALL_SLOT"

