Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2477DE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbjHPKRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbjHPKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:16:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58380FE;
        Wed, 16 Aug 2023 03:16:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FNOeA8020087;
        Wed, 16 Aug 2023 10:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=o5plB0p+vDHcjuIfY3h1ytDzMaxPwfuUvMnJ+jtdcws=;
 b=jdD+HEFMvLmEW4BJlpHzbvLCeIhcNrov4CeLoPhFK64Jq6dkIPm2pS4K6eQiPnpauVJS
 7t6MPIpKpgH4XE1/8M6oNDhKPg5FS8KViSwV1b+WPJsdVqbj2Wyv51qRJcSUehJ7Ykyu
 Q9Zya1aPl7HMDP2LXKwA0mMpL+9XeCQIuM3Wh0HLLrMy0LNpKf6PX7j0tSVyLMMRNhev
 bQVcJccgNoE9jocmbLRYIiot8/RsrSQ4Bw0rC0P2ogcnEVn9yOl5cAAcdgLYftPipk0P
 Z5gQO+qJmRQ0MB6G5dpnSI5/1At5yPJKIhIOaT0OWRZmODD2nCZrLDQj3c0uu1oo1CwA CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5xq6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 10:16:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37G95Ipm039510;
        Wed, 16 Aug 2023 10:16:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey7185e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 10:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcOqnF1YuuopX4ZAW7SahOPOZZcRMKwSRJ5pNLLd2BnunhDkPULT1dow8aTkpy5iWCxbBbbYqcClfR71kexNtKHn7FNXjEoUyjCjJUqBi+IlICp7UN+6v3qq+4md1bUN1NT5C7Jh5oMnAIY+iVDrVrlvZ0ejjUCzJIgJEeGbOAN8JQw7wI0hL5Pemn97rGdxllt7PuxTFz3Ni7UBAGAfOSzHMytaaPTl9TbB/qC6/wDcg9gv8ej+5odT+IwKM5b3G279SEYH2LBWcwbLY+zj67vtVGDPeM1QD8WxtC1XISdl/KcUdZS/5qtTLk4Sj5oR5BjUxm0LZrz8aWps0K7ypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5plB0p+vDHcjuIfY3h1ytDzMaxPwfuUvMnJ+jtdcws=;
 b=JS83R1BK8NT0oe2nDhst/Gr1roep7bym68En4KtP25hAlRHosz4E06uk0dujosdVD3LyrKBftu3ppqSGnjNgZBlcwtU4ajLfNa3EJglJ3UgzJzN+1BIDyjY758/oo1b2NdEuwKc8EgOCtu8kSJMljZvPn7h9EeMzIp/ZNhYZmwb2fGR8KmMD7SuzCjdVttk71sJkCM7N3QgGpXE4/g1LJxaFPv9aIlGnIXn2VpiLx9tEgQ/9+Ll+yNRqoB1/3KWOf5Xstj+h2vfO8eb45PhonFr/dPo2L/4k8ymQrzTj/OAWAdn+JuJHnEVnpX1OKk/AbRAYVUUBanEYAYL0iSxIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5plB0p+vDHcjuIfY3h1ytDzMaxPwfuUvMnJ+jtdcws=;
 b=s8yg752UAIwf9C2GecmyRwSz+lV5Jr4XSi4w99KicuMWuwOMGyaxn6smXmUc1rbHD/CYTki82QCsh0g99ChdNnFRWIc7g9J2Biutey4nBfmdG78GsnHq3i1SS0UUaRgMGdAC+2cRZKZcTrbWXkfHk2nxZ3Ogv+h6h94b1AYLty0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5770.namprd10.prod.outlook.com (2603:10b6:510:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 10:16:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:16:00 +0000
Message-ID: <e1b9b766-c439-8bbf-0249-105113663cec@oracle.com>
Date:   Wed, 16 Aug 2023 11:15:54 +0100
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
 <d6b702fa-0b7b-63d4-cd84-eed4387663a7@oracle.com>
 <a82cc9a8-7700-fe71-cb0f-dc65eefcc22f@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a82cc9a8-7700-fe71-cb0f-dc65eefcc22f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0039.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 36796df2-402c-4b08-0d24-08db9e41c9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKtqRZWJ37WWqdiwNf7VkDcTXc8lMlPHqvq04ZXTAMOMTGTjosrt5t3bSavw74ED6/L366TRzS8EpneEWJT5RJeWar9qvj4sMKEljG1vyg4S7/Ce3B358FLohizeQsH3lRaLFl9XSgD036xPAQZU1pNIhHO73gtfkWmpVPNK035viNxFJICAIRSgPa9zIQantbuHjLv/z1IusTCKwLCb23r6aVNzEB0bSkd5JDLloqFkbZ6mTcoDBFoLSvGg0g0+M0O1YBkVc711UrG1nRxHqBddgmru3nqBAcIfNn9q5J9JM/w3htFu4yrRrc9eB9gpXAhmEOWlbxJymnHjz4/bXVkpttzO8w8TdKY9YzTsTLr7Eb73Qbn/7Qz/yW4ZZYHtoFutZ97yHlhkgyrE85lUlerDKzQwVb145Qd9aO+ZOxfgwj1Pd9Iw28ARkz7eYUmfQbopWORFdSazfsgWvV3nFJcLAiJtuN9kB1N8K8W5xex+v9vrMFQzspQB+fdUdT3UbBBQYIWK/3Ywq+CX5bPtsqwhh+8LWGaZpLsLci1TD5D1nMXbhcqaLxKWzMTdq6l0wr/d0ZBdo7ivrKo5kelo+dvZya0jJyuNXOAemeMqvZU+5FOgVLV/KkBEtibz+s4q0fyL0siv9HG5TnG6wW8GxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(31696002)(6506007)(36756003)(36916002)(6486002)(2616005)(6666004)(6512007)(53546011)(26005)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkQ3bWlWL0ZVM21vNzJEOFdOZ25KQ2xsUHhLb29oVllTUmVwWitJTUZ0UjBY?=
 =?utf-8?B?djEzaDcwLy9Ebjg3blllb2Faa09JSm9qajRpeVZib2lQSTJybG90OERYazd6?=
 =?utf-8?B?UXNnME0yU3VJUUlYTWZiY1ZnQTNMVXNjSlFGVGM5OTd4bitTeWNOMmVHd0ZU?=
 =?utf-8?B?WlBCQkdVSVVuekF2L1FkQ3hSSzNUZFJRKzc5bU5wYldrUHVhL2I0ZUVzK3VK?=
 =?utf-8?B?bFFSenBaV2RzRHNpK3JOeWFWUnBIUlE4ZnF2bjZGYUJIaTZlQXlhb21EYnZ6?=
 =?utf-8?B?UEM5U1pjeWxPWUtzZGZJWnExcXhFWDZKYVJ1UEpJY3pVbDRKNk02aldKNzJj?=
 =?utf-8?B?djRJa2d1aHp1NkFuOURPdjJqQnJ1K0ppdWtGU1BLZFZ1ck5hVUhJQkx4cnlH?=
 =?utf-8?B?aXBWT2hHVU0rRjBQcHo4ZDd4dVl6R0RORzdVTHVVd05tdWJQSExnQzg2elRo?=
 =?utf-8?B?bG5DdUZMNkxQVTJTWGNLTUw1QThzMWtTRkFQcWxOdW9idUFnVzFrd1FDN2V5?=
 =?utf-8?B?em81ekdsK0NhbjFLRkk1UXBBdlF1ZjBKU1RFQXFZdGoxblFOeU9LT3NkazIv?=
 =?utf-8?B?OGNWbGFTSkYrdERyeldiZDVMdHVmejMvZmU3RTV4NTJTbmpWeDdVZng3RUpx?=
 =?utf-8?B?Zll4Yk9sSzZFMzNBd0x1TkFqRC84RlFUUS9BWlE1N3RTSzZvbC9hQTlYWUpa?=
 =?utf-8?B?QWRzc1pvcGJrbTV3TjlwcHBpNHBpT2FIYkkxdXRuZUg3Z2xDTmJKbnJNTWRw?=
 =?utf-8?B?WDJ0Q0RJSytjcjV5SEFWTytNQm02Z1ArRFl1emI3R1I0QkxqYnJHOUJpL1Ez?=
 =?utf-8?B?cEk5M3BWdWpqWUt4Qlh2eWlsR3NVNlhoM0VUMEkrTFpPbERzRjdnaGtwUFJQ?=
 =?utf-8?B?cWlHL3RDVzlwUExwN0U0eFY3anc3THljczY4aisyMm9rYnhVMTJFTW5PaUNn?=
 =?utf-8?B?ZjNQNm5uS0d1OUYxUTRtcTJlRVRhTm4zeXphYkEzQnhiL281R2ZvTUI3QS9n?=
 =?utf-8?B?bWJpMWJQRHBwZE5pQlhzSTNETXV1M09JNlZueE5UNmpXQ2FvNStzSlB5am9n?=
 =?utf-8?B?dW1kMS9lcnptamlEejhJamhKdUhQeXdINGR4dVIrUVZyRWNTMEN0cUVBaUJ1?=
 =?utf-8?B?RU5IYzNscTRBY09qekNiTnRybURjRXdPcGg2eUdTNzlES1VMcnZwSlBNRnB4?=
 =?utf-8?B?c0NTbXVBWnZGOWZRSzRaM0hBVmpLUU04RVRSb1d5dVBvVGN6MmRDYzRMcjFM?=
 =?utf-8?B?dVdaQXNoVTN0NVFjVXI5YTJPcWdLWkxnZG85NkxDUkxXQnBzWXVaMHRiTUM5?=
 =?utf-8?B?eG5rU3loMlVtcVk3cHVKWWI0UEZRclRNMXZ0YlFrMUp1WnBhZEFyVTdweHFD?=
 =?utf-8?B?M29Uek14TFU3MCtoRU9ZQi9Tc0NqSTRqQW5MazRaY3ludGFMT2t6S3FzUXUv?=
 =?utf-8?B?T1dDTDdVblpkd0ZkaW95Y1d1ZHRIZE5VYlEzTHpEbk9IVHlxZEFxdWJwV0JU?=
 =?utf-8?B?QmE1NGI3d3c5eHZtWHV5cGlGTHJ3V28rYmV1OFFBSzhGZE9XV3FEL2pxa09M?=
 =?utf-8?B?SjhIVmZ0cTIyWCt0WERNbE0yb1E4ODY2dVYrdVRNSTdPT0szR0ZkUWJpMERG?=
 =?utf-8?B?dm9ENkIyOVBkVWZRRzlFS2pXOTdQWUU1WDhGM3EyM2EvZTdRNzVIT2xyV2RM?=
 =?utf-8?B?VXRPMk5SV2FPYXZiVDlSMEUzY2ZjQXordmE0NG5TMGFtODRkaVJUS0hDSXpv?=
 =?utf-8?B?cmV4YXFpc3VxZzA5ODl3VjcvOUlRMGVlMGM3VDB0bzFzQ0xLcXF3Z2dUbll3?=
 =?utf-8?B?WmtOak4vaHJFV1FTMzNkbnBGZGh3aFp0TlJkak5DbWtvdis2Rzg2Y3loZWhu?=
 =?utf-8?B?RzVaSE5FWnZzVS8wdC9JMlBiMC9KM3ZDWHRhM1VHUGdWd0lzeEtGWFBxSzFW?=
 =?utf-8?B?VXkvNEtWNm93UzRrdlUyUnNvY093Y2NmMWNsSWI3TVJtdkErYTJiZjJMYU96?=
 =?utf-8?B?LzRxTk5oQWVQck5sM3FBaXFtMGp6WXZpS0NPMVQrWHFGK2gyQ0pOaFpLdzE5?=
 =?utf-8?B?TFZkeHd3eDd2WHpEZGJ3Ti9lQkM4NitFL3JiUXZZQWRJQzF6QS9acE94NGgw?=
 =?utf-8?B?VHdwS0JDSTlKZlBtdU8vRnR0TVg1dit3RmYwbjVRNGJSVklTWjMxa3VXS0I0?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MkI2Q2J2dUZIUVRYd1F2Mk5kblJVNERESTR6aTJIMDJJUGFRMFNWaGx2OU5T?=
 =?utf-8?B?MnlOWW9yc3VTTlM2QkVSdkdJY0tLa2tWd3hoa2xueEZlR1BqTFNOc2p5dk5J?=
 =?utf-8?B?dTdRcFJWTXlkQVkwL1hPWGk3cGRmZTVBR2pQUDlZS3hVUW16cVo1TndZdHZB?=
 =?utf-8?B?NS9GdksrWU9QVlZxWDZVc3YxbXNBVjBoMVRmZzdESkJzWmxQaGpGQlhiYVQv?=
 =?utf-8?B?TmR2RWhUUFJxRHl3OE9NemQyeWlUNzZsODZFUEJnQjlBUURnMWxFZTltZGQz?=
 =?utf-8?B?YVJXMWM0QUdZWXVMcEpHQ2wwWEROZ0NCQlZkRkhSZEQ3ak8yMnBvTWhTNk5q?=
 =?utf-8?B?MGVzWmlhWTRFdG90cTNjRTlhbjN1Z1k1NmpPNnpiaUZsdys1bXNWYmYzemh2?=
 =?utf-8?B?OWVjQklBcU9UMTlhdjVPV3hqV1U5UEwzNXh5eU9iTlY3RXp4ajJYenNIM29V?=
 =?utf-8?B?NWlsbDA2VHpvZHdKeko5cVMrNkhOeVJReHZja2xEcUlqTVNUQVo0OFpMTzZr?=
 =?utf-8?B?cEE0UmdXdWN5bEhCemZPa2JsbGtDVTRtZEcwcy8zUm5JdUV2bWl0d3RoNlFl?=
 =?utf-8?B?Q0puOWg5YUZqYzd5VENTb1lBUEhTNE14bXJrdGkyNjhBamVieU14YXNZRTBi?=
 =?utf-8?B?MkpnSStZcWhnQXM2Vm1qZGYxd1I1a3VYWnh4Y0xaOWp0K1hEbUFSSnBiSVo4?=
 =?utf-8?B?MUEyY2hwVU5yajdRanhMODYyK3ZTNklsVVJhcFRBcUpFU1Z2OCtrVDFsb1lh?=
 =?utf-8?B?ZTZTSEVMc2M5c0tvTUFxbnZwTDlRekZFYlR5ajJMYzBqVmdZRVcra1g3SDZP?=
 =?utf-8?B?Z1hoemlzOEMzbkY3MFZadGJFTTRyaURPWnRWaGFtMXorelNmNDlVTXFSZXAz?=
 =?utf-8?B?dkExdVRTWGVHNjkyQjF1M3hGR2JhbFV5TXh4MXQyeW5EbmxEc01Pb3J1ZjQx?=
 =?utf-8?B?VXNkRFJFNCt4VEs5NDdjTHdvZXNabXR4VHQyVXRxeS9lazhoMVE1MjN3WFUv?=
 =?utf-8?B?R2ZLbWJuVytNOFZaTXNrQ1ZHL0JrQnJxRnhlOHh5SWw4Sk9sUWxFUUFxeHo2?=
 =?utf-8?B?OHhKeVlGdkRwcXZ1cHJ1RndEcHU5dmpmcFUwOGNwRy9UeU95QXJ5cStQNlBW?=
 =?utf-8?B?TkNBUFNPV1dXMjNsazh4bTNwdnNhREkzSDNyUHFqaXByUEE1ZEc4RlRWYlNo?=
 =?utf-8?B?YUNzUEJZTmVVRkptdlozZlBMbjEyeGVUazVHSnFBbzRWeHJ0a1dhcDM3NlBX?=
 =?utf-8?B?K1puc3kwbHYzWHlzb3NhTkplSnEzK1lFV29aVm5GSXZacVVQcGRqM3lxa0Zj?=
 =?utf-8?B?a01oTm9zcmROM2tPMmU1NmFCd0dsWmV4azdmZURuRDZ0MmdadWZhK2tzdlJs?=
 =?utf-8?B?NzM4dE1RR0U0MXNHMHlpV2NEem1ya3lZaERNbkpYSEk4WWJsTGtvUWZHd2tP?=
 =?utf-8?B?NkNEd0Q0MC95L0graUZ0YVV3TnpNUHlLYUtqZG41MHJBYVp0WnlMYmZ5ZDlw?=
 =?utf-8?B?OW5oZTNQRXZyajlIN0pTcTkvcHFuTzE2TUpKdmJFVkJJZE1xS2wzZTlqa3FG?=
 =?utf-8?B?UUU5QWpmeUE0NkdxQUZwVVZlZGp2S3FpNldoSDVSSS9EcUsrY1Y1TGl4dW1i?=
 =?utf-8?B?aFUwekh5cFdoSTNZKy93RndDUFZJQnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36796df2-402c-4b08-0d24-08db9e41c9da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:16:00.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RU9AQd5WdFyu02Z3dibDKkKXOqOCvValpTTpXSRBLaeMtzCJft99wt9fRm7P1H8fOE4KK6+8KUrb2eesvz3Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_09,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160091
X-Proofpoint-ORIG-GUID: kd8Ni_rtbrWpyTf6asaHoxvWQcVBlWsb
X-Proofpoint-GUID: kd8Ni_rtbrWpyTf6asaHoxvWQcVBlWsb
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10:12, James Clark wrote:
> 
> 
> On 15/08/2023 10:35, John Garry wrote:
>> On 11/08/2023 15:39, James Clark wrote:
>>> Currently variant and revision fields are masked out of the MIDR so
>>> it's not possible to compare different versions of the same CPU.
>>> In a later commit a workaround will be removed just for N2 r0p3, so
>>> enable comparisons on version.
>>>
>>> This has the side effect of changing the MIDR stored in the header of
>>> the perf.data file to no longer have masked version fields. It also
>>> affects the lookups in mapfile.csv, but as that currently only has
>>> zeroed version fields, it has no actual effect. The mapfile.csv
>>> documentation also states to zero the version fields, so unless this
>>> isn't done it will continue to have no effect.
>>>
>>
>> This looks ok apart from a couple of comments, below.
>>
>> Thanks,
>> John
>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>    tools/perf/arch/arm64/util/header.c | 64 ++++++++++++++++++++++-------
>>>    1 file changed, 50 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/arm64/util/header.c
>>> b/tools/perf/arch/arm64/util/header.c
>>> index 80b9f6287fe2..8f74e801e1ab 100644
>>> --- a/tools/perf/arch/arm64/util/header.c
>>> +++ b/tools/perf/arch/arm64/util/header.c
>>> @@ -1,3 +1,6 @@
>>> +#include <linux/kernel.h>
>>> +#include <linux/bits.h>
>>> +#include <linux/bitfield.h>
>>>    #include <stdio.h>
>>>    #include <stdlib.h>
>>>    #include <perf/cpumap.h>
>>> @@ -10,14 +13,12 @@
>>>      #define MIDR "/regs/identification/midr_el1"
>>>    #define MIDR_SIZE 19
>>> -#define MIDR_REVISION_MASK      0xf
>>> -#define MIDR_VARIANT_SHIFT      20
>>> -#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
>>> +#define MIDR_REVISION_MASK      GENMASK(3, 0)
>>> +#define MIDR_VARIANT_MASK    GENMASK(23, 20)
>>>      static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map
>>> *cpus)
>>>    {
>>>        const char *sysfs = sysfs__mountpoint();
>>> -    u64 midr = 0;
>>>        int cpu;
>>>          if (!sysfs || sz < MIDR_SIZE)
>>> @@ -44,21 +45,11 @@ static int _get_cpuid(char *buf, size_t sz, struct
>>> perf_cpu_map *cpus)
>>>            }
>>>            fclose(file);
>>>    -        /* Ignore/clear Variant[23:20] and
>>> -         * Revision[3:0] of MIDR
>>> -         */
>>> -        midr = strtoul(buf, NULL, 16);
>>> -        midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
>>> -        scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>>>            /* got midr break loop */
>>>            break;
>>>        }
>>>          perf_cpu_map__put(cpus);
>>> -
>>> -    if (!midr)
>>> -        return EINVAL;
>>
>> Is there a reason to drop this check?
>>
>> As I see, it is still checked in perf_pmu__getcpudid() ->
>> get_cpuid_str() -> _get_cpuid(), and we don't zero the buf allocated in
>> _get_cpuid()
>>
> 
> Ah yes, now if all the files fail to open or read then buf will be
> uninitialized. I make it so that it will return EINVAL unless the
> fgets() succeeds, but I don't think we need to add the strtoul() back in?

Right, I don't think that the strtoul() is required.

> 
>>> -
>>>        return 0;
>>>    }
>>>    @@ -99,3 +90,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
>>>          return buf;
>>>    }
>>> +
>>> +/*
>>> + * Return 0 if idstr is a higher or equal to version of the same part as
>>> + * mapcpuid.
>>
>> And what other values may be returned? If just 0/1, then can we have a
>> bool return value?
>>
> 
> I don't think that's best for consistency. All the other CPU ID
> comparison functions return the strcmp style return values which is the
> reverse of booleans. We could change them all to bool, but it would be a
> big change, and they'd still have strcmp in the name which suggests
> -1/0/1 return values (although -1 is never used here).
> 
> I will add to the comment that 1 is returned for a comparison failure
> thought. That is missing.

ok, fine.

> 
>>> + *
>>> + * Therefore, if mapcpuid has 0 for revision and variant then any
>>> version of
>>> + * idstr will match as long as it's the same CPU type.
>>> + */
>>> +int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)
>>> +{
>>> +    u64 map_id = strtoull(mapcpuid, NULL, 16);
>>> +    char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
>>> +    char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
>>> +    u64 id = strtoull(idstr, NULL, 16);
>>> +    char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
>>> +    char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
>>> +    u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
>>> +
>>> +    /* Compare without version first */
>>> +    if ((map_id & id_fields) != (id & id_fields))
>>> +        return 1;
>>> +
>>> +    /*
>>> +     * ID matches, now compare version.
>>> +     *
>>> +     * Arm revisions (like r0p0) are compared here like two digit semver
>>> +     * values eg. 1.3 < 2.0 < 2.1 < 2.2. The events json file with the
>>> +     * highest matching version is used.
>>> +     *
>>> +     *  r = high value = 'Variant' field in MIDR
>>> +     *  p = low value  = 'Revision' field in MIDR
>>> +     *
>>> +     */
>>> +    if (id_variant > map_id_variant)
>>> +        return 0;
>>> +
>>> +    if (id_variant == map_id_variant && id_revision >= map_id_revision)
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * variant is less than mapfile variant or variants are the same but
>>> +     * the revision doesn't match. Return no match.
>>> +     */
>>> +    return 1;
>>> +}
>>

