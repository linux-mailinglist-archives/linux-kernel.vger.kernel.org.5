Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9D779134
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjHKOA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKOAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:00:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E01DD7;
        Fri, 11 Aug 2023 07:00:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDWkFP006004;
        Fri, 11 Aug 2023 14:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FmvvvA9QKhrAfGFiF6yAm2+Yz1eJ1tsOWmUrL81a+DM=;
 b=pFwuNVNZlQq2zblYlM0nL3YHPYphmQYYpCvZkb0V5gwynpAmxQsVQKJEmBRg6dizogt4
 /5NIJtUTKhdkDPsKpD377i+GUSRpTuDHiLNP5ksgrfouFi8t7TYU2ZKfA99j08SASuYU
 TcmV2P81ZnCB7saFDydDG1OoxQBaXEnbXDGVQv4HQCCO1/TN+lAconf0nXFjFptGXjRR
 uiaOhxFmDVUyhKrafZbksO791XsP+THu5vyyKu+RxB/0XcA5fvolZL1Gk+Kx5fV5BwSO
 2CJ7rqpDdxuOaOJe08kSVmGV1z6PNwRwQiJfjBLMTImBehEAZfveO2VJevR/kAZKkJzQ mQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y493u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:00:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BCdh4o000391;
        Fri, 11 Aug 2023 14:00:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgbdm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuW9drJiYClgsc7UXu9H6Li8Oa6aKbzEmiZrVcqEAwRxlTre1FwWQ8srVGSzFYLwwM8C45y8wGZ0iLGK/7cO098HZJToQL3LBGn0suqrrPm8ngGkDGTsNiJUNTaHAF466Q5S240KqdpwWgPjFIfQ59MgAr+1FZQstPSKeSSszQTKxVi4PMoM7h8Wt77APmnlSyWj1aCZmnnz5wzbJYWWa7XW+3x3wFL5taGQUQEY2YWvaAysoqW639lWy+EH68T+REWlTGABQck0+UKaMkj/N8/DDUjcQ4gi28EWlgggnrIonlWG1mwrYJv7uC751RemOXwYug5g3TlNeJ2UJ1SUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmvvvA9QKhrAfGFiF6yAm2+Yz1eJ1tsOWmUrL81a+DM=;
 b=Ya7s05OKi6IbxMg3AsUNedx5OwsPs1mvTpFV4UVRWOePUalsunOyDsezv6HHaGOxl6I9qFHRK8GZc1pR8+W71IFABF4IjHxyMSnRqhh/4+nCZ2H/6QS+QBodGVWYdsct+80wpXzCQmW+Jvj3G1rzsPJ5Exh2nXWZNfjdXDpquCiymR4QSog4wI2da2uH3zhgHSvoZsLasNHCNDfEZe6KMpziF1Cgu6+El7+gpnv52EkW79Xiq9Nj068zlHJLOHiktarrZyxP+uFZujqn4xIZXpBoHUTtwd44oZ8M4j9SCm8PQyoqdFmCbFYREDh/tNWRvCDN6LPnvdoki0Nqe43abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmvvvA9QKhrAfGFiF6yAm2+Yz1eJ1tsOWmUrL81a+DM=;
 b=ntCXG/ALNqR2M7OTL+FR8o0CAlHY973+tSLLWxps/tYPXijb5LlhZvzvuEeDrcZx9QwfOYpPr4lEjck5g3fm8sN8e2iSJtCWu4KoJ3HkOJCBaAshnhTkBsLYcfjQlfJ9RS9nFfIRuAThIqE7laUeuCknICbIzTAwxMwAIlXUFNg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 14:00:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 14:00:11 +0000
Message-ID: <ac57e637-7281-59b8-5658-3195e6d335f5@oracle.com>
Date:   Fri, 11 Aug 2023 14:59:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] perf pmus: Sort pmus by name then suffix
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230810214952.2934029-1-irogers@google.com>
 <20230810214952.2934029-2-irogers@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230810214952.2934029-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfd5609-b971-471d-7f2e-08db9a734729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yj9Z7o/cQq4LqTAnGfSjPDNxo5s1s+qdOgR+95RlKQxFKm/48Ar5hYtb1/qC+rqFTA4iPe/p6r8rwHA9nkw9z+K1OQ7h+9vUlG/Rwtls9LA0C3LAp1oK+yK61EizBzfaqAtpj8cPE6kvFJhAuKenVE5KvOQbqyubIuaSvAppIk/P6cOrBS/BImpndN0YPxamCMbVp/me3q6V61IFhmmKobtXN+c/rxA36hw7Pahxc46Fcvxmso8K2EJuOhlTA2mXdyK0p68LTDOufxxdBYaqZv7+0qomDYYcwVVXJZ0wjFLygLhGBrFRk2sSPwOHqKfq9RHJawe2j1e5FQwX7oq03HieyYhJF2Inh66gWjaU7sgOxP3T5N3pEUsFYGkyPZUCzKM1GbBA2GoZzkekKvj8CApioR2+PDQJpGRvnTVZcygTgl/7fOXAZlqO+Vyts8LbEQv8AfqwervCsNsYHEdCM1nCHIjz93ZMZAwq/wiRD5vxI8kYpGk8gZJ+fzZ5yWH8yDUnF/0jCuVN2LOksNb/MnCz/mAD3zpUDgz2fGxAEUMmiEU7d2VHL0T3+JDaNGSLrZGkVJxEyyWwU9ngUdGgLnVmzRqbwTi5kYTUyAg4jdDfDrdCeZinB9izedhQVJF8QiLENJALj6pTaXA8Y0rfmW0R6+97A1ZlwiwtbI8b1yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(1800799006)(451199021)(186006)(31686004)(6512007)(36916002)(36756003)(31696002)(86362001)(921005)(38100700002)(6506007)(53546011)(26005)(83380400001)(2616005)(478600001)(110136005)(6666004)(6486002)(2906002)(316002)(41300700001)(8936002)(8676002)(66556008)(7416002)(66946007)(5660300002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDcwNVpaMCtUcERYMGtWTjc2TGNjOC9vL3ZzOVZjUm9hRkJaZ1U0RGlHUzNk?=
 =?utf-8?B?bXIzaVJBcUtIbGlRbmNzeUR1RHQ0UTZBMS8vU25kZ3B6akdrTFlobnZvWUNL?=
 =?utf-8?B?dkZuS0xKSGMrUi9CdmlZb0pBL21QcFNhUVhmOTRtUTlyQit1NXJKWWVLdmRj?=
 =?utf-8?B?am9tOFZTdThTeFYxK2hjWFhLRTl0Y1RTVVo1Tm1uQTlYdnhBajBXY01WWkVz?=
 =?utf-8?B?ZVhKeUQ2dC94ejFYa29Vd2hDc01yUEFjeVNlbnh2Mnc1cWtOTklzaFk2cTEv?=
 =?utf-8?B?QTNRRmdvOGZOaWRESVgxaEFyNTRxWCs3VkRqZVhaMlI5Z0xGb083b2JPOTNT?=
 =?utf-8?B?ZEpnUjZLd0lwWno1SFByYVBwaTc1Y1ZJQzg5OWZOUTNzeTJhcVJkTGtkenBH?=
 =?utf-8?B?bVNJWW5zVWZLemt1Z1ZUZ0Uvb2ZEWmdUcGUwOXRBNXdrb0FwYnovM3pzZTFa?=
 =?utf-8?B?YnBRNVFZM0xiR205OEVUdVZyOC9laEFMN21pQ1AxdVJuWmZZWmtPRnRPaWw2?=
 =?utf-8?B?THlUVTRnSDhoL2hrQ2hZZS9BcFpLMFNuN2cxSmZsK1R4aE96Y3ArMWc0NFBH?=
 =?utf-8?B?dWg1cDlKM3QyRUVUUXZrbHloNTg3UXRYTys4NnVRTFM5UVBWOUh2aVVHT21D?=
 =?utf-8?B?Nmh2WmdoTDQ0bmx0eHIxSlB2Rm45SjJhKzRwbkpvaWl2Rm01YTdQMGhzdDdy?=
 =?utf-8?B?TXBoK3NZbFpJN0hTbFNSRUdRdis0WmFkUEt4Z2pBVmx1TDBWZlZTZTJQV080?=
 =?utf-8?B?MkpOeHFueUsyRHl2dDd2dkFCemJQSFlZS0NhcmRLR2l6UkQ5S2VkTmhsSkJj?=
 =?utf-8?B?MDJZUEtRTjdTTEUxWkRaU3U4YURUM2xTMGQ1bWZJUDNseVF3cVhzanRiR2xq?=
 =?utf-8?B?UFR1ZGxMSjlXY2lXSGEzNExYcGdiZUpGWGFmak5WaHo0dUEyOXRYLzY4Y2do?=
 =?utf-8?B?TXd0eVR3UEhKOHMzZDRDMFZNOVJ0dC9OZkl3WWFrK3JkSmRCcC9DdlBqWUVr?=
 =?utf-8?B?MnE4ZHNYSDA3YTdiV05IdXRWb0Q1VkgrekZ6TXhxOUljNHJEbUJxMlp1OEZH?=
 =?utf-8?B?SU5PQ2JERmNiVFQwa2J5SUlwUWxEZE02Z0xHcE1hZjdOWmVlTUZ2ZjgrUGNL?=
 =?utf-8?B?bWRPcGpUVzhoUFNIVFRObWZKbVNlbFVyaWFzSGtQTkcrUW8xazQ4dUVhcnVQ?=
 =?utf-8?B?WUJNc21WZkxaSlVUWkpwRnlPVHlmdjVEUUtEKzRScSsyWWZtb1gwcDhON2s2?=
 =?utf-8?B?bExtM1BYcW1CZjZ5R1drMTBmOHVMamJieEdxV1JROXBDY25CeURDaFY0cmp0?=
 =?utf-8?B?eEc0Z3EwY3l2UWZIbVFSSy9tZWJmb3E3SVZqRHd4eXo1Y1NpY0dXS1VtOGRV?=
 =?utf-8?B?Q0pJMnFQSWQ4am9BN0wwaWFwbTRyd0kvakYrOEpOMFVnM0lYSmw4RXBZN1Ni?=
 =?utf-8?B?MVRlTk5IZzl0ZE9LKzFVZjVUd2FKMUtuUFN5ODBHdi9FM1l5M3poWlNsTjhl?=
 =?utf-8?B?d2Z2MEV5S3V1aUNGNlNQZFc5bWlLeDBSWnowdmRxMHRyTGZlRzFHcVo0eXlD?=
 =?utf-8?B?NmlVL2o2UXlmOS9wb29LYW1IdytCanBaNnFJS05FemE0OVJQUk4wK2NxYXBI?=
 =?utf-8?B?TWhvcTQzVWlyc3hNcFo4dnJEMk1LUXZ4MjdhNmRZQlVkdlhJSGtMSWFQVTE0?=
 =?utf-8?B?OEdoNXFhUU1QM2pOVlR4QkFya0xBcjc1SXRCbUtTMGF5em9yOUdreUZ2SUNI?=
 =?utf-8?B?RENVdStKMjhyMVl4NlJBNDFESldVNmx4Y1BnOEZQb1RDWHhxVGxWK1VNbld6?=
 =?utf-8?B?SWx0NG40eFVIWitqZStEN1NRSks3VitTRjNFUTU2OWo3eXZyQ282NzZPZHZl?=
 =?utf-8?B?Q3JMc3ZnekxWMEhpc1lmV25SanppM2NtM1ZlNUJiOCtES0x0a1ZDOURnbFl1?=
 =?utf-8?B?Zm5nN0Qvb25wUmpGWTh0T3hVUmQ5eWRFZ1BBR3NPSDdsQUQ5ZHBVTG1pUTVh?=
 =?utf-8?B?RmhvQUV3T0JKYjI4Nk1mV0VCZlpwRENKTEVJd2NKc3Qyd0p0RGlIWHUrdjhZ?=
 =?utf-8?B?TEcwYWt2M0xoTWRCTnhJYk8ySjdaZHh0VG5xZWRjb2hIaWllaWFaK0p2aWg5?=
 =?utf-8?Q?A++6hHP24bzgDdJQm+26zDzlN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y3JmS2FoOUpOSzZKOW5sSlhOR210YUpGSS83TDBCWUJHZ05sMjJKcW14UWg0?=
 =?utf-8?B?SWtlcEcybTZ6QjY5Vi9BR1BDNnpCUkU2SW5icTVrZE9oL2pLaitleGdOOUta?=
 =?utf-8?B?b3A0WUJDSXFIQWdhNk1wSDZ1dG5IalJxSEVvdlUrQW05bERiWFI2cURIWlBx?=
 =?utf-8?B?VG0xTkJjdHlma2VXOHVoMmZXcDhpSmtuNGRjUkxDdWtLdTNWdjJRYmhaeTJS?=
 =?utf-8?B?TE9IdDJPVVdQb3hKQzlMZVpWNDZXeCtLRW1RYXhrVlZXYmVVYlJoa0Q3Umxa?=
 =?utf-8?B?REIyRlJHaGx4bDBZQ21ONUFabk5Yb0xDQWlyZEkzUDlYNkwvY2Jha2lQendV?=
 =?utf-8?B?Y3pFVFNnK2ViN2l0QTFWRUp0UUJneExZVmpacC9xNlpMRXA4TExmdUVJWEkr?=
 =?utf-8?B?em9jbHRhWTBiMFBoTVVKWTBwdTdyMjlBd2p4Z243SjBzcmdQYm5nbzhsdHQ0?=
 =?utf-8?B?QVZ5eFhjK3hDZW9MdDRwUWtNU0NQdlFPb3c4bTRLNDFDTUpsN1h4MUZkNDVa?=
 =?utf-8?B?Vnp0Q3ZYTlJYVHdrTlhrSXJ6SGtVMVArSlFFbVFJUXhoOUdNdjlHUnZBQy9t?=
 =?utf-8?B?YUhydGkrK1ZpRXFEYmY5eUxmaXlvUUdVYldVR1JWak1qZyt4OGUvQ2VOUkdT?=
 =?utf-8?B?REJLV3VRTDdhdzdGZ3h1TGNTOE5tR3RpdTM2cDBiN3NiT1hYZ1NCTWNKS0Zq?=
 =?utf-8?B?emViNmlYWldzdWpaa0NIRExucStJcFRlbjZGaDZTYlFjamVQSXFJeGxpd0V0?=
 =?utf-8?B?djJwVmFOaUJNdER4UGdLNHpsc3FrYmVxcTI3Qko0K1hLVzhwc0YzM1JYTEZM?=
 =?utf-8?B?RXJCTGp6anhtME9tNTVKS0R2azNNRmRYOCtFVklLdVZPaml1dUdPNmlvcEdX?=
 =?utf-8?B?RGxMeFRDNDVyZE5zSnIxcnp1NXd0RWVFb21EVVJ6K3ZMeGp2Vy9XU25Gc0di?=
 =?utf-8?B?RDVnYXVJeUNsZEpLY0lYSTIxQVlpZVlPVGwzSjgyK29HMmk1R1d4TThOaG1Y?=
 =?utf-8?B?LzhZQ1ZnMUVweHBCOVRoUjRzdTlHYms4VGpsSlMyL3B5OTQ5OEgzcnVQRGEz?=
 =?utf-8?B?ZXNqSGFnTlU5REd5ckNUSEw0eHZqeVlzbjcyT0VyeStmWE9nTzFuMStlUVVa?=
 =?utf-8?B?WXp3TDNSaGJoZGE2SndWbyszTHhqRTNFLzYrS3hHc2VzTW5YeDZqMm13d0hy?=
 =?utf-8?B?dFlFMEJHZWlQc3VsdkxTWmw4VUQyL1lzSFJwSkE2cTR5TGVkcjBUcmN3Ymx6?=
 =?utf-8?B?RHZFanNsVTRPMytPVGllcXJFUXN3dkdWNEpJUHl2MTN5RXZPOWoya3lRY0pV?=
 =?utf-8?B?VE1XRllqcTRsQnpEdkptdTdUVTZIQjBEaC9qRHIyemtPTU84cTFxTndmZTlP?=
 =?utf-8?Q?3GKrcFhPtb0A4huD5PwGnThwHkaPcyW8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfd5609-b971-471d-7f2e-08db9a734729
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:00:11.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpGO09ND68pIKKyVO5kRTR5yvb4B5GBy7ItpvnqFhE54OzJSlWhhaYxKUTIwD52FLE6ZeVtj7a59oJLnFNVabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110128
X-Proofpoint-GUID: uu8TwBJgjZLzJRi2HXNfJa-v-cISN_1l
X-Proofpoint-ORIG-GUID: uu8TwBJgjZLzJRi2HXNfJa-v-cISN_1l
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 22:49, Ian Rogers wrote:
> Sort PMUs by name. If two PMUs have the same name but differ by
> suffix

I think that the wording here can be improved. If they have the same 
name, then they cannot differ. I think that you mean that two PMUs have 
the same name apart from a difference in suffix.

> , sort the suffixes numerically.

I don't know how this will affect some hisi pmus which have special 
naming formats, like hisi_l3c_sscl1_4

> For example, "breakpoint" comes
> before "cpu", "uncore_imc_free_running_0" comes before
> "uncore_imc_free_running_1".
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index c58ba9fb6a36..3581710667b0 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -1,8 +1,10 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/list.h>
> +#include <linux/list_sort.h>
>   #include <linux/zalloc.h>
>   #include <subcmd/pager.h>
>   #include <sys/types.h>
> +#include <ctype.h>
>   #include <dirent.h>
>   #include <pthread.h>
>   #include <string.h>
> @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
>   static bool read_sysfs_core_pmus;
>   static bool read_sysfs_all_pmus;
>   
> +static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> +{
> +	int orig_len, len;
> +
> +	orig_len = len = strlen(str);
> +
> +	/* Non-uncore PMUs have their full length, for example, i915. */
> +	if (strncmp(str, "uncore_", 7))
> +		return len;
> +
> +	/*
> +	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
> +	 * the full length.
> +	 */
> +	while (len > 0 && isdigit(str[len - 1]))
> +		len--;
> +
> +	if (len > 0 && len != orig_len && str[len - 1] == '_') {
> +		if (num)
> +			*num = strtoul(&str[len], NULL, 10);
> +		return len - 1;
> +	}
> +	return orig_len;
> +}
> +
>   void perf_pmus__destroy(void)
>   {
>   	struct perf_pmu *pmu, *tmp;
> @@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>   	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
>   }
>   
> +static int pmus_cmp(void *priv __maybe_unused,
> +		    const struct list_head *lhs, const struct list_head *rhs)
> +{
> +	unsigned long lhs_num, rhs_num;
> +	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
> +	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
> +	const char *lhs_pmu_name = lhs_pmu->name ?: "";
> +	const char *rhs_pmu_name = rhs_pmu->name ?: "";
> +	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
> +	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);


This is a bit of a monster... at least it should have a comment on what 
it is doing. Do you consider your own version of strncmp which can 
handle numbers in the suffix as another solution?

> +	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> +			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);

Could min(lhs_pmu_name_len, rhs_pmu_name_len) be used here?

> +
> +	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> +		return ret;
> +
> +	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);

double ternary operator on same line ain't great - can this be changed 
into multiple return statements and also commented.

> +}
> +
>   /* Add all pmus in sysfs to pmu list: */
>   static void pmu_read_sysfs(bool core_only)
>   {
> @@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
>   		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
>   			pr_err("Failure to set up any core PMUs\n");
>   	}
> +	list_sort(NULL, &core_pmus, pmus_cmp);
> +	list_sort(NULL, &other_pmus, pmus_cmp);
>   	if (!list_empty(&core_pmus)) {
>   		read_sysfs_core_pmus = true;
>   		if (!core_only)

