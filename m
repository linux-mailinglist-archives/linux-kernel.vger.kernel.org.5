Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B655771D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHGJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHGJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:22:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0AAE6F;
        Mon,  7 Aug 2023 02:22:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376KuO6N007787;
        Mon, 7 Aug 2023 09:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=svxyhZNXkohUbBkg8ehgnZlZclhV1uBTwghVnQFTvoA=;
 b=MswQnR4YPI8NM3xI0Q+Ohbwdt2gu1ggGmTg95l2VTx2zgqoRvJRcVgsJWVlOcdU2xZrB
 39YyieroWBr+m6FYmudTXRqFF1YGSmjmxuXNkM4Q+7P4AedMU5SB4rSXKTsBMZZUzcfP
 QYLE4rFAIsk/5+BqJfe7jztCGBnW3bBuz42GnPqnqAvmkbktHA2yhD9Mf1/C/8pFP3Mq
 1hlKTWLxhX/VAcT3lXQqM5fgfy3Nisiz1VdT92Qf0iN94nRdFb535jM+lQhCbk78acmo
 vtkvlt6VQsmWyCETZPqAw0v8gyIyX6aZt4AnaJMeyDpeAEHY5XXRh0fUzDQfyghAixeg Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u2b1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:22:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3777FLUs030518;
        Mon, 7 Aug 2023 09:22:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva8sxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSCZdvt7Q0dG6Qfq7KIaIgIBqGJEeFjyQITlUpRDdnU+Qo6ebXCydC8KpwW9/PyDDUxhcgJRCjjN0C5xLHGJVKmm9yaACq5wpX5TkSE371ytAdYQ1OHnN0zGpbpt5dljdOK2FFDI01aSyq9kefzs3I6Xv7j6xlZXBZcFDOGZ3hHLafS4IKMO5Maa7LNIPygJWQUYxl1rN0yfH0vPTAYQP38HCbg2gf5zz3FsMhLxPlDjiwYQzWLW+L69ruPo5VJpceqVsXdZx4pA5ebAmXBj9a5P8+ni6PzcSIMcsZmyU5aVQD5DHPDfAHIdxQzitN2eqK6z7eZKlqV6T3shAALT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svxyhZNXkohUbBkg8ehgnZlZclhV1uBTwghVnQFTvoA=;
 b=j+0AJ8MSqPij718jOR2nhC5Kh9afA7njLsLkcczt7Gnq+BGAUZn8sqU+KM/tmB3Y9R1OskOa3SxMTzA6zXjLg7OIgyuTj8xU4GfUPFR/BGoehDMbw0L6BHSNtqxh7HjSwmVZGiapf+whalAompN1RtxizMIl3VAblVmne8mZfYJo2zZAfRWwLqjvRHZr6IvXpvvZV4u9HKhLXrtlTF/uiVyqfhpBIPrMgT/PmSyMUMYfHYs3RsTgNAoDjRq4601SnmjoylllLuQcveiCRCzzdw3LrNb6kuegz9oLiydqtzpoMQ1d23Kn3e1fDPVad9e4eySU1gskHW3Dpif9WZp5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svxyhZNXkohUbBkg8ehgnZlZclhV1uBTwghVnQFTvoA=;
 b=ywEw/DE20W/XTp9nCfYm4wBQnMuZyCb7vq8J8Eb6+It/QP0qbN4ZjJA3GhgSIBKeKX8nf2KISX58mFeSGA6PhHE0wnAgy2rIAZH81wUj39/n10wIztISRhBuQqDvPm8V9IazdfuMLkusRZNzaLB07oRzYdU3A47ellP+LGX3sGY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 09:22:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:22:01 +0000
Message-ID: <c791e9b5-e459-539b-d9f7-8808486a1aa8@oracle.com>
Date:   Mon, 7 Aug 2023 10:21:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 4/7] perf test: Fix matching_pmu
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-5-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1691394685-61240-5-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0407.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 138ca87a-27e8-4b85-2bda-08db9727c175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wa9NiKysDDYXQTVDmRVq//FVYkY6Co/D9c77hse4ZSIfflRXWIMy3MoSFej2v+NZm/tX16F5vkzGHW05sWLaW0Gyo/w50/m3r5+6AnDc6yC9Vzv990scNu7tilARL10xpqomFc1RuuP/9fuz95Gds0ZkBVFhV1FZ86Hd4ZEMJBA+V5+ehgMQn50PD83+1LD3Z4UWHGyydXUSN/lFbc1i3dZQlBq8C4n2o3hQCPp2YcDaG3oUg/X/YNsNoXp27H5p5fL/SYIzKO82er6UH38sWZOYI2LolwMjP8DMx+DmRExLf3G/K6Za1j6X5X/gsKCub46djId6GYeCSHKfiGUTqGYhmx3Fsed/pgT3VPPofL/ETmKoO4i1fy/kN37YVj4q6jiVR1d+xz+jqpkS4QxOD50JGKN1HU+BK3/QFZzsSeAPn5EnDv94U4yxcCPVSWB31J5EyeyHVC39wz96RneYiLihR7A8PNf8lLWEnXNouisrajbGkbO0gpinSn4dvyt/o9/lO/kTqDrPCqK6erYzqqfybTP4HQt3HIVObBcCRYufgoW9hDnMVdWfojQC6rNAdTjev/8kqOxtp1GMvf8YAfQKOS5Wfntd/r46qck1D7hxG7lPVk0UQb/oZBRPnm8bfVrE3zTRz7KTAgL8NF6Cgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(6666004)(66946007)(36916002)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(8936002)(4744005)(2906002)(7416002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXEwNmJPOFFTejFBdkFvV3NKOUdlTTc5L21tRVRkUHNiVklZWkprbUo1ZFJE?=
 =?utf-8?B?L2RRSTZmc3grWkJJbVRCZThkS242UHh6d2NMYmovcEF4eWhBeE81OEpRamZ0?=
 =?utf-8?B?ODJzTW9NRE1zRGVaUXpFRlVqZkk5QWI2dmdSQ21Mam5Vd1dPZ2VIdVpGOUFp?=
 =?utf-8?B?MVNZRElrd281eU8xdTVmeUlNclNybERzVjJHLzFGcDhZOHorVEFUbDU1bUw1?=
 =?utf-8?B?VWorN0VNK1VMVXdNL0hHNVFKYUJiRHFnQXF5VFRVd3JwbnhpQVZYU1pNdGlJ?=
 =?utf-8?B?SWVrNytheHM0eThtbzhPanBERUVLdTJVZ0ZPYThxTEttMU12YjJkaEtIOXd6?=
 =?utf-8?B?azI2bUJjdkVLVitiaHNYa1h5YXdFNVkxQnJ0OWw3T2tCaWF4dm9IQkpqMG9l?=
 =?utf-8?B?bHR2amlkQ2JsU0tkcXRXcHhCRFprcWRyQkJWb0JtQmtTUklKT2FJL0N2L2RL?=
 =?utf-8?B?SmN3VzVPQldEU1hqNWRzbnBGMWk3RW1BQVgwZ0M0VnpnS0NuSTFqWkhVK2My?=
 =?utf-8?B?TDdwY0l5QTFqVFNQbkFqSXVzK2xMbTk1NkgzNHExUmN3eXRhbXZtTCt4Zzcw?=
 =?utf-8?B?Rmh5UXJKdGNUYzF5SmJjWVlUdUtjVzhBeTRkOXg5NWpReFRQSWxCWUtkSER6?=
 =?utf-8?B?bk93WDIwOTdYaXYyTEpXa21sUkRTNWlUcWl0aFRxbXRjU3l2L09aRlFwcFpF?=
 =?utf-8?B?WWdPWVBDMmVRd2N2aUl0NnFtYzE5RmNyNlo0Yk9vSm5STWErZW1sbjhNdURE?=
 =?utf-8?B?Z2pMZGFSWHN2L0RkWkU1ZHBnS1BCcU53bVRLazIxTDZqKzF3cmZ6RURFM2Rm?=
 =?utf-8?B?ZmRiVmk5TXBXUmNaR0k4clVtM1FUaW1TYTBtc3h0WE1GOUthNTUwU0xSak5Z?=
 =?utf-8?B?ckNaVG5ycDVHRlJ0WHBwMU5SaFBBRkJHUHUwSjZ1SjhoT3BWVUxhZVFoUU5Z?=
 =?utf-8?B?THNGTkRiS1ptWDlEZlZCbFNHQjIzU0tNM0RIcU9IZFVwcHp2UHRObHltTGNQ?=
 =?utf-8?B?MmlVKzJJY1FtZ2Y5U1RBaCtiTUIwWk9RSCtNb21LUVVKcDliM3ExOFVWNHYy?=
 =?utf-8?B?aUdNMnprT1diVGxtVm1nRmc1SmZCSGZWM1M4TjFyT0dwWVhEZU41Q1J2L3pq?=
 =?utf-8?B?WjYwM05wS3FOTGphUW5SSkdvUU41ZEh5WWRNQ2lZbjdtVW9SZUt5WDZ5aFVI?=
 =?utf-8?B?YmdGUUp5Zk1CK1liSk1hUmxaeFlab3o3L0VYc1BIdzNzMDZSNlFBaTNkSVY5?=
 =?utf-8?B?NU1PZmk1N1RDaFdFZ011VkJ4a2c1bHJGNUtzZ2F1cWpuZzk0aS9GOE83U25Q?=
 =?utf-8?B?L1RveE5jdm9uR1hzWlNkUXQva2lqalBKR0JlNGlsTjBQZlRCSjVvdmZ2Y0pY?=
 =?utf-8?B?RUNieVFQb1lWWmQ0SC9ML1ArT0hITkpqK2xBL2o4eTFiUHJFOGUwZzB5dWI3?=
 =?utf-8?B?a3lVMWJoMHZVTHJFQVpJb1gwalRzVEJ0YnlnZXI4cTdKYTR4UHhIckRJcDF3?=
 =?utf-8?B?N2ZlOFVTWVFIVmpSOTNjNDVpMzZiTmpDcnpac0pmYWFRaGdCZE4yTGtCNjQr?=
 =?utf-8?B?MWtYejZVU1E1NzUzdXZMQW40NFFXcitKU3poeDRaQ1d5OGZoQVhhZTUyVDJK?=
 =?utf-8?B?Y3Awa3pTRlA1RWl3M1huUWpQQmxORWlWY1oyTm9TODVpQnJqdTBvVzFJcExv?=
 =?utf-8?B?SEppbW1VeWdtRkZ6QUFKUE81SXhaUVRBVTJqZTg4S1R6V3U4ZUZIMlMvNFF4?=
 =?utf-8?B?eDJ2cDhEbit0SU9ncFUrYXdHdjNERWIrQmRCbXpQenhTUXY5RzV5L2d2TjVi?=
 =?utf-8?B?YlJLUlJvMXdqTEp4Wmg3R3lEUkMyc01wd3B4Z3VxKytPUzBUNmI5UGdhNUJH?=
 =?utf-8?B?WG0rWE83YkI3TzhjNGhxSGRKVGVwaDJrRHlvbjYzU1VZOEhYdC9qWWg2aGVl?=
 =?utf-8?B?bVlrdDJEeVQ0V3dZYXRBUHd1UG5tejhyUDI0ZXdQTm9VbTRQbmsyTmRvaFYx?=
 =?utf-8?B?dUNJOHhrRW5RZllsTURKenNNTEY4OEdWcFRXcmxlQVlFemNMdWdPS2lNTW9Q?=
 =?utf-8?B?dFJVdTJSeERBbUJ4dDhWdk53S3lTWi9XL0szemdoWjR4cVVmdWNnQ2dEUU1Y?=
 =?utf-8?Q?PVatsX8HhbCstp+j7E52suCy7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Vi93Qm9tMTlHSWZ0Z0thVy9aemdWRVFUVWJRT3plVlVwV3I0OFdWV21pQ25T?=
 =?utf-8?B?ME03Q1E4RUVVaGtxenFlUm90NFFSaHhGVVl6RDJ0WFQ1VER2enZySWJwQzUr?=
 =?utf-8?B?YWRGUitYYmR3cWQ3SXBCT2pLclhnSmxsWm9kSzFRRmtXQUQvWEZaOUF4RkRJ?=
 =?utf-8?B?RDBEby9EUENsblJobDNabENjaVREdm01bEc3bUNNSzVFOXV4dE5FY2RxYjc5?=
 =?utf-8?B?dXBoVjMvNzQxYkx5eWVUN1JpaDdrWEhMbk96R21EQ0JhZjRxMmlyZ1J5WHZv?=
 =?utf-8?B?SU92OGpEeHlRT3lhWUJDVDR1SWdrMnRWWjk0aUxITHpHaGloalM5QlR6cmpm?=
 =?utf-8?B?eDN0U3YxM1M5M3RYL1JvTElmNVp3YktxYjVqcU8xSU1PWXFPWVVKQnhKQklR?=
 =?utf-8?B?N3BMUXJkb2JCNDdNSEJWUXVPMHBtTUhZb0ZQYXRXOFVMdVE0ZVNGM04wb080?=
 =?utf-8?B?TWxGck1kTFIrOU0zRk9BS205QmVja1pIT3NqR1QzRVdaSnVOWFcyOHhWQnJK?=
 =?utf-8?B?MTdmazJuQ0tQRXJtSGk2YytTaDJuNmEzQ0swTFVTTFkxOTVOOGFkTzlDUFZK?=
 =?utf-8?B?TENNTFpVclNoOER3OFllUm4wSTRKT0Z6RHBNbS9SNWdVNlFsY3R5Z3N4eWpa?=
 =?utf-8?B?UUhDdnRTYTNFQUg0UVpPMnZFRXY0elV2ZlpGNVlsNmpHYjNoTEZYYzE2ZVEy?=
 =?utf-8?B?Y29yVHNFTlVsd3ZIbjhKWDZlWVo4dFdiL1VMNFF2ZVl1ZHNCd095VVpubnI2?=
 =?utf-8?B?MWtsUkNXU0ppeVNJSHQ2VFcwMkZtT2RvYWVpdlQ5MG94WmpYaUV0cDlpaE4v?=
 =?utf-8?B?Vnl5M0xrM09TOEZ3MklqTUs1TjF2TUUrRzdHUzJBdjk3OFZhZWt5cXYwaktr?=
 =?utf-8?B?ZUJZcUkrOEExMGV6NXR1SGUra25BbDlkNW5OdElBUXZSS3dyY2ZHQzRjUVNs?=
 =?utf-8?B?ZGYyY0FKLzc3WTVqcjJnSkcxekdqL0NiZTFTL0drcUEzM1l4UlQ3M283OEc5?=
 =?utf-8?B?NHgybEl6NTJFcmpKN2VmRVRUQitwRGdmQ0VMeFRpUUxSZ3c1aHE5amR6TDBZ?=
 =?utf-8?B?ckRPUS83Yzg3ZUhtNUJiMURNck55MGJ2UjhkZVI2ckMrTmJjUDNQM1FncG5O?=
 =?utf-8?B?TmQvc1RmWmhLaUlDS29PSXVlQ045ZHJZc1g1NDB3eG1xOTRyM1RtenRUalAy?=
 =?utf-8?B?NDltWDlGeVVGRXdraExpaFJJV0VtdEtxMWowU2o1WG90OG9GTHZqS1haSjdH?=
 =?utf-8?B?UEMwL09GdDJ0RkliM0hVMzc2YU52WWRmSXRBK2VJYW1QcCtCUTFFYW43VFJw?=
 =?utf-8?B?eWp0dVJYc1M3SVhhWW1zR3hGM2pDNDI0QnVQdys4Y2xicHZUOFRWZ1dFTVBx?=
 =?utf-8?B?RC9pMGJVa1dJMXAydldWZWNrZkVKN3pDQ016aFNiZE1yc2JVUFVhSDFTWktP?=
 =?utf-8?B?c3g0enhwVVkzd0pucFlDRksxSGs5OVJZQ2FUc29KNEtpaFF2eU1FbXp2U0dB?=
 =?utf-8?Q?aa79zE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138ca87a-27e8-4b85-2bda-08db9727c175
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:22:01.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79VtvdBNshLu5dmG+SDyA1iWa64jRgrTnAh7itbtZk728LkJF6+jKKKxYSurz3ZxgHLmLGXuiWa8/dwze3dEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070086
X-Proofpoint-GUID: 2GCQjILScb0f6A8mVxKRKxfOrOS8c4oP
X-Proofpoint-ORIG-GUID: 2GCQjILScb0f6A8mVxKRKxfOrOS8c4oP
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 08:51, Jing Zhang wrote:
> The perf_pmu_test_event.matching_pmu didn't work. No matter what its
> value is, it does not affect the test results. So let matching_pmu be
> used for matching perf_pmu_test_pmu.pmu.name.
> 
> Fixes: 5a65c0c8f6fd ("perf test: Re-add pmu-event uncore PMU alias test")

Is this tag correct, as I was not sure if this ever worked?

BTW, I am not sure how useful fixes tags are for self-test anyway...

> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
