Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB677BBE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHNOoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHNOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:44:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DA10C;
        Mon, 14 Aug 2023 07:44:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECi9wA017370;
        Mon, 14 Aug 2023 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=w6DtgrE4+ns7X5jWnkbyGSidD3KJ70DwiV3uMG4/xYg=;
 b=E96Bb/fORCjEH7JxfkG5KXkeB4Q8iyDaDCxz57YflnO2AjRsQxFhcz8xx8nYw4EI3LuT
 Bfd5iE94XsAxpr5LZpxas2M/fm23stPOTAm4zBCZcVfxp0UbBW3it/tUjnocNSUpHLmQ
 bO4GRgzAYmkrj+dRC7jJ28eGZWoJM1JiT9ylEnGdg+7vCYmP3YOf7M1lpLfmXe7+CkNW
 +rmhSiRJcPninLnkgwJGwal8U8Xh8PZ9VdQJqsmKAA4zQu5f9pwlJrc6AOgJ7g4wI6+n
 j4XKSHqjM8HtzRz0iE5Nm3584lDeaCyuVLcZYHdYLy/SZ2rPQdXLfJ3eBh1n3L0Fod/U +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2nup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:43:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDOFIi040098;
        Mon, 14 Aug 2023 14:43:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0pr18v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIA2PEa7Msz4qd2/XK3C+79PIHc5gABA7d7gZruBerSG7ToTNrQFmKNZ/d/Bw2OhvILt5Pvx7C2J6nx0AbGoHxrhxucWT6XKOAHd4G9waaLnKpHogmy+AyDQ3AGKptuqo2N4RqtAX4sscodg1N0/thR5fFruJuOJTX8N7rQ+ZLgX6ISBgHIpf6ImirRXQQoPYRUbXpLZ0inNt+CpOSUCLy9vtd2fEqtDy0rWXZYz+HJ7q1VhKTadqjzuBPd4vEYYfWsQvZYSMf+o4j/Q/CT0jWhYFxvswDqVk0hbiJTomHQ/rOO9Gv/y3YJfPJ3pa+yin7v1wlI4tShjr9EoVxEQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6DtgrE4+ns7X5jWnkbyGSidD3KJ70DwiV3uMG4/xYg=;
 b=FpSrdhbXkiI/rJ19t59VAh8u3FEf7BctbUsPeOejbXRv6XJNne6jIY+iz4kK1M3YXwO/KGAjuq4CP1Q0PgFwUApa6ynq4sZ2S1p5d7CWoZkt1hiWY5wzdqWRXKoBMQeqBhwthCe9o9xJkqJeDqsfxlHIp99E07JkFGnqM7+cMydkh7chXv14LD44YFKmsK4/M3M+08NA3jJA7aVOsitEpmQmsB7FeLE4FBSh7nq4i3WmZ1NeccyMFOXiOvADQEB8IPXJB0VYVfi4ylOBHXp+N7oicW8KcFHzkCqNT47MEmfHORtB0uwXrB9FC+2w2gXddR7XriGJirvrK5bifd5mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6DtgrE4+ns7X5jWnkbyGSidD3KJ70DwiV3uMG4/xYg=;
 b=Jk2ld5ui9DWu+ZIk7W6Ab8UyGf8baAVKlf8yBnefuwB1HPGY0xFiicbDDcMy1DD/GIEfBMmHi1CFhLxzrOwqIDrz2SkwWTGpPVpV6VDx3NQ/w84f9Q0DzxcD0mwkEJ92mRPUc0b2JpmPhnBEVAg15PtpBnlt/ocg6aE8oYTnH6s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6294.namprd10.prod.outlook.com (2603:10b6:806:251::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:43:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:43:55 +0000
Message-ID: <eb23ad55-a46c-4ed7-d2b0-0dcf7d536f89@oracle.com>
Date:   Mon, 14 Aug 2023 15:43:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/6] perf arm64: Allow version comparisons of CPU IDs
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-3-james.clark@arm.com>
 <47a32410-d9ca-627b-e8a3-f64d4a1ea95f@oracle.com>
 <4c6a4729-8331-5c47-a81e-f92915e2e848@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4c6a4729-8331-5c47-a81e-f92915e2e848@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0480.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: b7524673-d63f-404f-dbe0-08db9cd4e269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miPq7RRRw3Qq6Fdj7N+Hia0qYifNLQkh2YwxJ1bWDueE3z9lEAz2dLm6rGFaBbnJMdRCMvdVnmjV7lSrCRTnXthqM6tbzHxfXogE/dZzkL3pKP9J91wr4Z3K9E8vGs51kWLFf0hyO3Gq2/TPhAgXinZF3p1iKCw8XOp9/OTf/0B1yvF371NqfcFi9e6xe9xAY2UzHWzypeKSwNst4oEEoPQ0g1XUc+Ym7kBHUJl6P7vkDOR6f9x0izqK9iHAoPvjFS3B4kiNEpU6birhUs9KNiB2lY7GVRH4VdGuMH2xDtq0qzhfogC8VJkMWrZzgUaHFOA3NngXuyYe/vwRsf7QfduTHjx4mGcCx8vYJ6fVkdZ+CVmokeOHgp1CQey2kLVVRQ8fXD5nKx8LdIAzWvhvgmCQyiev3yeF3fYmQLlt7wSVt6Y4MX//LiLDsN3m6sOv6DnkRVrqNsAiQmmz6/PQvSDkzBwwpK6ivGsQJDg3NK2G/I3kmChElhpoFy2gLTuk/8aeKSyb+MJthRPFXVXrkaE+RoBf01crhXwNPrjJ0/TGrTPvBaRbU7n//0yPDTaY8gY8+ULsehRJ4zgb4GYp7YCuYOCYi1GIEzMkwHVZ7b2J+Yag2pBEuFVoaLpjQaevMpppFUnYm16yd8kAKVXLNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(36756003)(5660300002)(7416002)(86362001)(2906002)(31696002)(31686004)(83380400001)(36916002)(66556008)(4326008)(316002)(66946007)(66476007)(54906003)(38100700002)(41300700001)(26005)(6512007)(2616005)(53546011)(6486002)(6506007)(8936002)(8676002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBYT24vOFhuc1hvTXAxU0RUNTIvUUc2MzRMaWU0L3NrU0RYVWN2Y2kzVk9t?=
 =?utf-8?B?MisxSFdWS2VvK0p6UlJIRFozNTFRUkF4MGc2M3crNXlvMUdRa2FyMWR0MkZK?=
 =?utf-8?B?ZXlBSEFTRkV0LzVEMEFEV25QeDVHbDVZcWxNQ1ZwWWI5Q2tFdTRPRlNYNVdO?=
 =?utf-8?B?TFNiblpOcHhobTk1QUk3dXBhOWdIcnJ1UVVoSE9lL0hyNUU3SmsvWjdhQ0RW?=
 =?utf-8?B?VDFvTjlWZHRVOGZNYmZ0MS9TTGhSLzV0Z3JwR09ZK3FVNTFQdmM0YTM1MEQ4?=
 =?utf-8?B?bFRkck1OcDZnbDdmUzdlOGxTS3hzZy96eXhzUCt3QTdONUNsNHhWZVlWaUQw?=
 =?utf-8?B?Y0sxcWpYcS9NNVNGb1NIeGlqVUNEb2VSaStUblJFN09MUE5jWTNSbkRuTHhO?=
 =?utf-8?B?QXpLYjdUR256V2FWaHBpcUtQMm1pT200UlR5NUhFS2FvVlI5MWRaTWZMUFo5?=
 =?utf-8?B?cEg4dkxSNTBVcVArOU5ZUDBJRCtmNXVsaUtNM3NmaTJuTmJTZlM1SStMWE0v?=
 =?utf-8?B?cVhNTlpIVWQ3WlJCaVlvM1JVTS96TUptM3Q4ME5LeTJGU3JPdEZCNW1YNW9L?=
 =?utf-8?B?clBMa0JYUDQ4K1k2MDU5enBXZDQxV0xkaHJqNjhaREE4bmJEdGsvbTZoN1NB?=
 =?utf-8?B?ZWY5bktVbXJVQTdFMGVEaFJHcjFUWCsvT0VLa1dKOXUxUzBiZGNwYTk3OEcr?=
 =?utf-8?B?Q21kVHNKOHRUbE0rdlQrT2hPWWFBVTUwWHJtZmFIK0xRODZGOE50SmZNeG1M?=
 =?utf-8?B?LzhuSktSOWQ1KzNWakpJOTh2RnhvZlRVZnk1YnBWUlgxUkljWSs5SmZBS1Vm?=
 =?utf-8?B?YXBEWGNIL1o2VnZ0d3RPV2ZOU3dhQjBxTCtXTXZETFVlc1ZoUm9TaU9KcmJX?=
 =?utf-8?B?enhzNnlFdFcwUERINktHb3ZseGR2L0F2djBxRldjZ25qeXpraWRzOXk4bkl4?=
 =?utf-8?B?L2VxUGFZVWFKc0Y4K0ZYcFM3MVdIRmdrdnFIdmVWcHFFSG9XVmxaWWZCY2M1?=
 =?utf-8?B?ZFdMSkd3QWpVaWk2YlVJa29ycHlkTEFuMi9JMDQ3emxpVUZ4a3RUWllYUTRG?=
 =?utf-8?B?Y2FNajlSaTJGWVg3UktnVWFzSnpyUjg4VkNXZk5SdzhqRFM0Tk9qSFIvVXpN?=
 =?utf-8?B?NVp3aFFPSkNvN09oQXR4NDNDaEdTL04vRWJZTXYvREkwSnFwWEpySXNob2d4?=
 =?utf-8?B?Z1F0cm1JVWJzdDZSMEdkOFBQNW0rYVl1SzNSZllBN0xzVzBHTVVJY0xYWEpa?=
 =?utf-8?B?cnhSeEJDM1F3VUxlSEYzYWhac1d5b3lKK2tEbWtpYkEvM0RlTjJjNjg5aHlM?=
 =?utf-8?B?UnRRbFl4VVUxZkJidUhmdUp6L1BBL05VYUhYQkYrbms3SEdVSWZsdHQxUk93?=
 =?utf-8?B?dmJYa1hSM1lDckg0aHp0Tzk1eWVSdjdiU01QN3BKRGI1M2pZbUhQMXUraGd1?=
 =?utf-8?B?MW1WUktvdHpkblhrQkNTcHFmUnR6VWNNRDVNNm5kelBzSW94MFBBYTBpa2Fq?=
 =?utf-8?B?RWFpTGFvV1VGVzh0dGdOWTljTDJOdVFjZEROcDh3dE1uN3dTOXNIQkw5UUtE?=
 =?utf-8?B?cDltVmNkWEk0RGxHREY1ZkZyWGRHQjRrd05wUHVXdVgxNDNHOTR6L2s5ZUE4?=
 =?utf-8?B?MWJpZGlxQm81eWRheWxVRTlGc1dEV01jOTJva2tJYWdRWUF4M2NtdExkVkJn?=
 =?utf-8?B?OEt4a0dKaTZRSU5uaC9HdXBCVjljOVdZRnhJWmdDc2dzNExNNUR0OUhldG1p?=
 =?utf-8?B?MG81RHJuT1VCMTduUXBSeUJYRTFUYnpJdTFVZGpYSkZhRHF5d0xkWDhHa2tM?=
 =?utf-8?B?QTVDNWV0bDJ2VlRqZGxaQTdTSXhNTXZQTjROb0xJK3o2NGpCWHRYY29zekpQ?=
 =?utf-8?B?NmYyYTdIUVRTRXZzMC9FZEJWdXE0Q1UwMmttYXp2MXpRTnFhVHBteU1TMGZp?=
 =?utf-8?B?VmpsdHJiaEtxZUU3T0ViTGFEMTZPZlZLTW5zSkZ4ekwrNjcvUDNEVGdGTXVB?=
 =?utf-8?B?T0tuYkVPcHRXWTNpdXBpa25Na0Z2VXpGZDNJTjFYQkpuK1pCKzF1MWVYYkhB?=
 =?utf-8?B?TjI0ejdNaW9zOXZSdzlub1drbERxUnhSa29EbHJsZzJaTkJHZ3VXa2N5V2da?=
 =?utf-8?B?V2VqSXdOVGJweUZoOVlNRy9JcUtpNUFMSjd3dWVaWENPWTVpZGlBU2NWb3FJ?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bnhvVVlPR1dyWUNXbDh1QTV6b2FPQU0zSEx5dnFXeTcrZzR1c3AvT1dRTHd3?=
 =?utf-8?B?QXJHelBnbmxTYVhzWHhBNEtMdGRSdlczOVJVTWxEODlKRmc0aWR0SDMrTits?=
 =?utf-8?B?VWtkdnJSaWdHMi9zaDVZSU45K21HcVEreHF0UUdGZkEwMjRHVm1RZVYva043?=
 =?utf-8?B?NHNnOTFnYXUzanNLS0NvRks3YmlmZWVwM01FTDU4Z2twbUtQaHFyTTRLam1X?=
 =?utf-8?B?MVczc1J0c05aeWJiZlh5bU5RZU5nWXhQQndqNXhIY2tFdUZMYTRVN1grR3RJ?=
 =?utf-8?B?aDBwZDRJR1dLa0o5SG5wT1VQMHcxc2toVWNOM1hSM2dueTVWNERPem9BZGww?=
 =?utf-8?B?Nkt2S0lDcHJGc1M4NlBveG4ybU8wNVFxNFFMeStCOXJsSk1aS0NTTk9lZ1Fi?=
 =?utf-8?B?T3gxRmthWUlTTW1zSTdzSVowTmZiWjIrUWFHS0tTMUdhQW10QkVhVzBqZnda?=
 =?utf-8?B?UzBMcmRCeEVPTEZ2MXRNT29reVBjVmh6WWJJWVpGamdaVmU3ZXpjMnMrOWdR?=
 =?utf-8?B?TEQyOTFiWllsVU9MdWlZQ0Z0TW80bUZJRTcrK3cyQmVYam8yYmd2VDZuY1Jx?=
 =?utf-8?B?S0FldGNkeUxnRnJNVkpDVEV5anIreTU1TWJ5bUF2UkkranE4aHNaT3FmOFVs?=
 =?utf-8?B?RHUzKzc4RGhMdno0djNsSnBXTFZ2cHZxUTZFSXRieUVjWGw3SkpVU0s0aU8v?=
 =?utf-8?B?RFdPZDBFMEVldjRJOU9JSmhNY2M3KzVFT3JLc2p6K25mbmhxUzdza09UV0ZF?=
 =?utf-8?B?TmhRYmlpR0ppS0owL2xRZ0FHYkh3eGdyc1pucUNqblhxdjNMY2dKbkhSeFhv?=
 =?utf-8?B?LzAyWVVLNmdldDVTSmp5dG5MbUlweGErK09LRndISTRJQlk1eUVRMGlCQU5k?=
 =?utf-8?B?UktoM0ZxOUJEZ05wRTlsSDl0NFlIbW5CdEFiNHliWHNKYlMrN3daZzcxeStP?=
 =?utf-8?B?QTFhWWhTMHN4d3dRWjBOajVNaytCUzIxeEFIaHZVWVN4QjZwbzNOWG1HcERl?=
 =?utf-8?B?R0ZXN25JcUJaZ04rS0xVZGtTUDZrdEw3NXY1Ymx3M1B5Slc3bk1rUDdhb1Fl?=
 =?utf-8?B?bk1sSUZOc1Vta3RQdDN5UWlUUG1zc2xaalJoamMvSnVoNW9Ta2ZTUTNrQlRj?=
 =?utf-8?B?TzB1OTJHNDJwSWVqWFhsVkt5R1NPQmNNcUllcTQzTWhOd2M1M2lSazR6eTUy?=
 =?utf-8?B?NEFoYlNWcnA3SmhSbTdSVURQOFEyMkF5WTd5WXcxclBtRlZtQ1ltMXppYTVL?=
 =?utf-8?B?VkRseDgwd2VuczVyWGlyQkU1TnBLbUxQc00xSzFjSnNQbHR4QXhHV2NrRTQy?=
 =?utf-8?B?aE9NY0NuakRuT0hCZkMrWFZwZjNCcklKVzlVbXFqTGFhb29vVzNZR3NGUEJ0?=
 =?utf-8?B?clFqamF1dEJCTFRTcjFXR2VaY2xSNEZZa1hEMHlhTmpQMGhabHVzbmYzc2Rj?=
 =?utf-8?B?RjdMeUw4UkozS05ZdlVHRnc4elJDRmtjbGFZRHZNRi9nejFKcHY1ODBnWWdY?=
 =?utf-8?B?b29IQ3hCQmU4cU1FamZzR3RNS0dsMFhaWEZucmlab0MvYktnTTBPdDNPUmxx?=
 =?utf-8?B?dzlCVkI3RFBrSmFTbENRVFFqd2lydGU4YW10MTJHc2xFQlhET1FKUjh1aWM0?=
 =?utf-8?B?ZWh4QlpkK05iZWJmRXRTbmRVRUpzMUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7524673-d63f-404f-dbe0-08db9cd4e269
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:43:55.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhJvCI0CO6bKzQ7Jp11Kh2beCywi1+ZpleTIrr1acPl4OKCnjlQQRexZtZe0AOL+ow/ZcgiZ5iqq8ZXiFVBXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_11,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140137
X-Proofpoint-GUID: CDxysIntV4yRjHyPCLzm-qvKW7pTavEr
X-Proofpoint-ORIG-GUID: CDxysIntV4yRjHyPCLzm-qvKW7pTavEr
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 15:15, James Clark wrote:
> 
> On 14/08/2023 14:07, John Garry wrote:
>> On 11/08/2023 15:39, James Clark wrote:
>>> Currently variant and revision fields are masked out of the MIDR so
>>> it's not possible to compare different versions of the same CPU.
>>> In a later commit a workaround will be removed just for N2 r0p3, so
>>> enable comparisons on version.
>>>
>>> This has the side effect of changing the MIDR stored in the header of
>>> the perf.data file to no longer have masked version fields.
>> Did you consider adding a raw version of _get_cpuid(), which returns the
>> full MIDR just for the purpose of caller strcmp_cpuid_str()?
> I did, but I thought that seeing as it would only be used in one place,
> and that changing the existing one didn't break anything, that it was
> better to not fragment the CPU ID interface. I thought it might also
> have repercussions for the other architectures as well. It would also
> mean that the MIDR that's stored in the header wouldn't have the version
> information, which if we're starting to do things with that could be bad.
> 
> There are already callers of strcmp_cpuid_str() so it's probably best to
> keep it using the same get_cpuid() string. Unless there is a reason
> _not_  to do it? There isn't really anything that can't be done with it
> accepting/returning the full unmasked MIDR. If you want the old
> behavior, you just set the version fields to 0, which I've also used in
> a later patch and is already done in mapfile.csv
> 

ok, fine, so we seems that we would be following x86 on this in terms of 
using strcmp_cpuid_str(). It would be good to mention that there is 
already a weak version of strcmp_cpuid_str() for !x86 in your commit 
message.

Let me check your code again...

Thanks,
John
