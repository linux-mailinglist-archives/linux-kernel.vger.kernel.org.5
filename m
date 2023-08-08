Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82D77423B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjHHRhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjHHRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:37:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF815BC23;
        Tue,  8 Aug 2023 09:16:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3788R3iP021784;
        Tue, 8 Aug 2023 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wCnQQJwCvEvw1ih75ARrbjTfay3p4r4GLsLhGEngHsI=;
 b=G9MoJZBZvDsBIuRJ5tu/f6La5HlSbWw4RxcXCkMQLKZINpR9jfB2z/d+uE9Tfa7pL2YR
 OFz3+F2FJB8SoKl7R4m8iGUJJzgqXhzJvAiFcO1Z2WtHtuomtQv/Oge/CIcAuzM+1NDJ
 6AGBp/++Oq3LbLn9ILoslrVzzp9N1v4JUVY0n6B1rHkNBluiae/P14Q7lM/omX3Dkhug
 dkhIk8a1t6RJIv0lc9SYUmqrBUTOW0WFkOI1W36g2TIjlu41+Dl71tNcJt0+PTo+SLro
 JLuovc+VYEn4WeehSVZy+qldML8RiBKOeoolw5fxlElkQQYKyB8IIAEK8MjIOUdfW1LF vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d12cp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 08:46:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3787rPRO027674;
        Tue, 8 Aug 2023 08:46:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv5gd10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 08:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr6rG00ArlckSUci8zTS+mJcvhoIPHn+M4/vyhNQnktP8MLHF4MHEUPpHSnLgSZqMJJtQRs0/veCe/wwMVuKr8fW15BFCzly3R2k0R7cgTmBkyfexZSSDKWoF/NbTik7V6TYorDzatm8lHAFIhLTdX/+fJeSh29zy3pcmkPF22n1Lk7pk7iw48Vwj5Y0/ttwBSjrgVvHO1J8ScVf5iZuOua6ank3Z9eoEKATOSN0+N7czL9wvlg0me2JubjaMio/0qTB65OA1sRqeBj5KXuTxBEZlk5NBPSf3EEIOtKJDW1NZgz4ocxiE9rjS4hMnwMH0G8jDzBRjRVGa42PgOIB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCnQQJwCvEvw1ih75ARrbjTfay3p4r4GLsLhGEngHsI=;
 b=BmlEKeIHWcnG0WuSa/9oYqdN1dsGLDgcolUvb77A+6eWs5BRmPS00UQovBpw9HPlAT3JckMagGTnFWioOjz1CBG28cQBW3Wa9Bi43t/l3TNbDT0eHx2YOmwrsEqgmBE/pkqH6gu1PCEqiyoe59rLB9hU8T1dE7aljk8fndLoN9iSZtoC7KZbeDU49H7dSuwrp6r436gPC9CZN8YZs+t965V4R7snNUdTf7RvWj3Z4f8X4/lHukPnVygWpAzuravBvUxDeTORRSnUFAXVwqnPiaVJk6XSFmY61njdI4oZzEyItxbu7NweQ8edLuDytDMZGxagOVv5mHEIAXbT3Cxhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCnQQJwCvEvw1ih75ARrbjTfay3p4r4GLsLhGEngHsI=;
 b=NjF1P/A1jh10p1zIsjUsc5tOHFdVWX3GZStR44hxvpswPeAkZOOTLbl0xFtD6BnwrjzhW1Nc+Bjw/szNJfujdFin6j4rx/Yk8Uy1FviFpw4o1NOZuud2NLwnzQe6zei5HET39Z87MyRd7IsBXxyt6vNPDKlotemkakHl6chMBSU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB6983.namprd10.prod.outlook.com (2603:10b6:510:286::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Tue, 8 Aug
 2023 08:46:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:46:46 +0000
Message-ID: <6c8c46f0-b567-68c8-2ce7-3d1a8a21569b@oracle.com>
Date:   Tue, 8 Aug 2023 09:46:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/6] perf vendor events arm64: Update scale units and
 descriptions of common topdown metrics
Content-Language: en-US
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
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230807142138.288713-1-james.clark@arm.com>
 <20230807142138.288713-5-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230807142138.288713-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0139.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4481858f-4d9e-42cc-7876-08db97ebff24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QC3C0HmHGADp09HA2NCr2gk7ISZemrzDsub9Mwwx306yV4wbu4Yt01RjNC1H6qS2AiM/ejrtYp668nH+BqrUrvKokq6Pi+99OAqqyft+96Ogyu44YssT0vRWl1W+KunrG4lTN+4VkurvshQ2kbBkw/gp48vS6pDzdhJ2zw9XYjPZjoQUG9NzJeCENJB6ofpcoYGYLE9RQ0jAL9auE0J0J9AGsAoIZ7e5NWOOYk8ZJI6SmvSn2E05VKYyFICE5p+uK7cbC/c4YGf2WG1QO+gv7fwFGsV8Hkg/GhwOparYZnc8b3kKx1GAjL4IVsCen9IM4x5+RO6rr3Rs9A/hQwLS6f3Cxo/74wAgWHmROmSoLX6m+1bSeMjcXeaxXPLXVehCdeWjkyTvF4ptuIuxPAUr+im1nMM5qaFTmYdua3oHhA6qRwyxN7p7RZroUhDcR+OBplsDBwcrbtbH45pIKeZhn0wVeUtn3SvYIaY2LR0VHLbAH6an0RhyV+7bNOpZo42Sl+N0u6Ov+ECaqpGYGuetH/CiyyszHYs+ZfsiE0KVlyd7Rk4r2p95OXLQqej6SJV2Zsl33C4zsgM4zzXYJgxO2TR5p4sflKZBTeZivzBxgy9c4KjcLPXllkK8j7G+zBPfBkI9FwuiA6jEJF5FkoeDuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799003)(451199021)(186006)(8676002)(31686004)(8936002)(36756003)(4326008)(66556008)(66476007)(66946007)(86362001)(2906002)(478600001)(7416002)(5660300002)(31696002)(41300700001)(6666004)(38100700002)(316002)(53546011)(4744005)(54906003)(15650500001)(36916002)(6486002)(6512007)(2616005)(6506007)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW4yWGVYLzc1b3hzeEkrNVJacjZ5TTdiVmV5bUNQTHIwUm40c0U3THg4QUFo?=
 =?utf-8?B?czdFaWFicUhxcU9PVkk2bTErdEtiMWtWTlFNRVFKQWxSZXkwcUFKNERXd2JQ?=
 =?utf-8?B?NzlXNVA4UWE3QVptbE4rN3JsNk9xaFcwQ1FXY1ZJWmxhWExSbHg1R1JyMDNJ?=
 =?utf-8?B?aTBrMS9IOFJkTkdRQ2laK3RQSy96LzVwZS9kR3dXaE1NcXFEcjI1aU91SmJW?=
 =?utf-8?B?dDV1dGpubmZoTm1mOHM4azJiYmZBV2RmMWUvRlpkUkdiVUFPaWtzNjF6U1BS?=
 =?utf-8?B?Y2hBNjFMYU5TNTRDOWFJVDBaQS9BMEYwYktGL2NOSFJCdTJLWlJ0WG9MZmdY?=
 =?utf-8?B?R0U2UXl6MzFXazFYdVJNLzZNU3RibisvRHhGLzR0MlFnMEMvZGd6ZnJHaTg1?=
 =?utf-8?B?WXRjUkxWemJXZzMwL2FsSmRJU1FBQTlsWWlYMlFNcWIyL1FhUm1SUXFFMU9H?=
 =?utf-8?B?bHBGdWlaSEVRM2QzRDRTZUxZVlk5Mkl4QlcvaUdaZ2VDRktTNzd2TnVHWDhH?=
 =?utf-8?B?MlBFTWJ4NjFMc2lueE4wc0l3bU02NlFXVnhzRTBWZHU5Z2pZZVhXZFBTMWlp?=
 =?utf-8?B?UWQ5TXdpcU94Lzd4dC9yRk45R1htb0U0bUtlYnJoYTdwOFZGemd1Y2c4K2cx?=
 =?utf-8?B?ZUhHeWU3QmRVcnI0a1piRS9wd2VRRXRIdzhpSFRlWGMyd3NhdENHR0JaQUR0?=
 =?utf-8?B?L3B6K0RTTHhnaGVKcHcxRUJ6cU5uWHFNd1dmZWRobUgrNkkvazBMMlRCUzRU?=
 =?utf-8?B?bTY4T0gvNGdSVkZvZHZ0dWVnZFFEMk9yNjBWRENBZ3dVeFAyZ3Q5Vjh5QS9G?=
 =?utf-8?B?anUrZEdXL1M3MHhMRW5mOU1wOTNtY1Y0YnM0T2s2NHJOYUljRXBPYTdKczBR?=
 =?utf-8?B?dE5zTEVHTUE4cktwczNXWG9xTGxIT2hwWWMyaEpTWWJPZm1aNDB6TkRWODZO?=
 =?utf-8?B?ZFJZcGNlNGNCS2pLSnRxSjBUNGpaTlJzZld2dHJONUZMR3FSeHNlOTNEMkhq?=
 =?utf-8?B?S0tuVjJaZk51cGxxL1JVUjZBajgxcFIyMVNJbUdtWXJhK2xlVTJ4K3pLSUkx?=
 =?utf-8?B?OFBJMjMwRjRlVWRKeThwTU5xTFgxMlNlekNPNkJyQS9VUXZma21sQTFTMmI4?=
 =?utf-8?B?bTdwcStJcHYzdi9wcWZsbG42OVVhOVR2SjFSYUt4U3JUanV3YlorRCtqS0ZV?=
 =?utf-8?B?VXRHVWZuTFp5bDE3T25NaXVXOWFUQzg1T0VtY2FlUkJHSUlDTXBFNXM0bHNZ?=
 =?utf-8?B?Mml6R1FyT1ZrdUl0RjNFTUVLTVM4N0haRldCeU5qcXVlbWVJcHRTOG1lZUg1?=
 =?utf-8?B?YnJmM0pSR0pkdkx5dDNYTmUvZkwrQ1JqMlgrMURwWDVYOHk2U2ltUjB6dDc0?=
 =?utf-8?B?SitFaXdZZEc2eDBLUHhJQmdLRVl2N0ZoK2ZhUzVtc1FSVFc2SmpaazBUTHdn?=
 =?utf-8?B?ZHVNdkRkSlJ0ZFNXQ045bmMwR1FIdHNDNHlsL1F0YzByU2ZMT3l4YXNxbEh5?=
 =?utf-8?B?elc1S2d1dGZNcDdjS2lGTHlQaVFRZUxCNTU5dFk2T0JKVHdoVS80UW1wNnl5?=
 =?utf-8?B?TUJuUXc1emtTaCtqSVRjOFk1Q2h1NzhPYUJLcnBzbFFwc1c3NldpYXFSYzl3?=
 =?utf-8?B?alRFODUwc2tEVEZzNEZOdmh1d1dkT04rTDlYWnk1Qy9BZDRWbE9zS25kcDBY?=
 =?utf-8?B?ZGtkbFFkeGowelFLZ0dYbDF3NFMzTWtxNjNCWVptd2ROTkVpT3hzNHVMalZy?=
 =?utf-8?B?REFMY3hCSk1aUEZ5Z3JUdnpKZFd1eS9IWnoyQ0NHMS9DQVIzQkt5SStDM2Iz?=
 =?utf-8?B?eWRNQ1pDd0NrN2lBdDlYc1dkU2VRVDlvRWVJN1AreFJOTHZlcjZGWXllL0x5?=
 =?utf-8?B?c2drUGRmcWJOYkh0TjM2MlczZEhwTUpkeWhFOUZGTkV3VDhHMm9QaWF1OXBZ?=
 =?utf-8?B?aUR6WEVybnZMQk5FM2tDQkVrcGxsdStZWDZMUDBBS1l2djBucnJRVkRoenhD?=
 =?utf-8?B?UXI4MnhmR0E4TE5hYU1uZlB1YmR6WjU2c0ZYWlVzNGk3WXFLWkhHMHdTcmx1?=
 =?utf-8?B?S3psRDhUWjdwMDZoM1BKdFJSQm42Q0ZYaFY4VVlOVGZMVkVoYnBtMmRPc2o5?=
 =?utf-8?B?dzlnUTZTZFhITDd0M2Z0dFFySnFmemJ1NURWd0F5S1pxak1XNXlPZzVFQ21w?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dHA2NEJYcW5lY1FiZTJvdHpEd3ZBLzRaTXNJWmxPRzZwb2JWNWgweGVNMWVv?=
 =?utf-8?B?dTlUVDRGcS9xZ0Q1RnNrelpmdDhCd3Q4MmRjRFQ2ZlJXVnJrcExlVHRiUjJH?=
 =?utf-8?B?SHdxeHZnRkhJSTZpTjhJRHpkYVRuUHlpaWVCM1A0RUprYllRNkxrZSsrbmVk?=
 =?utf-8?B?elZKc3VMSERCSnh1bENTajI0dVVGdm5UVnZiVTZDRWZMandwbDJvd0NUM1V1?=
 =?utf-8?B?dmd5TWE5RC80M09SMVdWMHl5RTJ1Z3R5NUVtbDZiUjE5c20yZUlWZTBkMk5y?=
 =?utf-8?B?NzNKRThiOFZQOU5VVzd1RVRsQ2xsb0wwaDB2bEh4NldUUWdFbTJuQkE2Q2hx?=
 =?utf-8?B?cWFRaWtiWllzSWFuREZoc3oyYTNkclFUOE9RRWw0NUpzSjRWdUZIT3VBRVNJ?=
 =?utf-8?B?SW5qUEhDUDdPMk5abWRneFp3NEttZjhYQkR0aXc1VHdEeVBqQUlhQUdGUVhq?=
 =?utf-8?B?eDlRSzBSY2RwUkh3N0E1eEdYcGVlUklSallaZ0xJVGsxcnQ1T0l5enlzWjIv?=
 =?utf-8?B?bTFZbTlDdzNYWnZIb3dsQjI3ZEZVTHREN3Bjc3RJQVNCMS9LNWJ5azY1MEQv?=
 =?utf-8?B?L2tBM1RUTnA2Qy9GRXhrK3lNcXIrTFcvNGxtcHBSVzdtR0dhVmZqam43aUsz?=
 =?utf-8?B?aGk2eGloTXNrZ3MvSVhMd1NRc0xPZVd1OVM1Z2JBbTJlcS9aVGF0aUFZREpV?=
 =?utf-8?B?TWZXWHdvc0lLVC9nRWZzRlU3ekN4TW42YUhiWUpqMWFoa2tPeWhpelhodG51?=
 =?utf-8?B?cXBzdVNja25WKzJzejJBcHNEOHFDYkk0SzFRVEZIdFF3dkJaeEE4TnEwbkZn?=
 =?utf-8?B?di8zUkN5dTVkaUt3TDlnNHk4NEdyY3hxYUtNZ2k2MjJoMG1BVEtZeVQweGVs?=
 =?utf-8?B?L1V0VmdCTSs1S25sejJYNTFkTi9wcklWVkFmemJ2a0VWbmkwQ20yd2U2YWFi?=
 =?utf-8?B?RXM2dlg4K1NBN3Q1WUJhYzcyZjlhTTVOWldGd1oxMGZucUlvR0Vmc1kvQmVT?=
 =?utf-8?B?T0N5RCt2VEZTb2gvY21kZWk3clFjbFpOb0FZM1JiYk92cGhqZFdyeFFLRWFt?=
 =?utf-8?B?TFhObnJWb1FSMEl0K0x5MzVWUStYSUtOV1VTcko3R2dkRXBHTjBXbGNhWTVW?=
 =?utf-8?B?MFVHSU5FZWQ2SzluY0oyZ2toQkJWam5Wa3g3VmNJREM3WHhmaUFYVjUzblFy?=
 =?utf-8?B?c3FuaVBnblpwWEJJUjUwMVVUOHM2eEMrcVkyNEIvL2tnY3k0REVWNmlHQXRz?=
 =?utf-8?B?aG1rOUk5T2YvdllNcVBubmp5OERMSTFiYktSSm9mUUY3dFpaRFNFVllFSWJr?=
 =?utf-8?B?S3p5allDUTh0bldQM2pwcjkwZituNzA3Si9LTzZnT01oV094RFNiQUdEVGVr?=
 =?utf-8?B?V04xL0F1ZmhKWFhIRm5mWnhiak1jQ3hzbEY5aktwdkVYSDM2SFR4MmtZSk4y?=
 =?utf-8?B?N0M5Z1FwNk5jWlBCT2k2MEFISXdCK3o4QlZNZnN0VDlpRXdBMVNBUEJFQlVP?=
 =?utf-8?B?SFYyU1JZR1dTTWs5Lzh3RmpvM2VtbHhQNERpcjgxZyt4VTVuOTJjRWQyaEJZ?=
 =?utf-8?B?ZWJSenp6VlAzWDNSeGtNbjBrYjdobUt2ZmpydHhHVVB0bVNGUUdwWVdhUEFr?=
 =?utf-8?B?WkJ3VCtSOEh5V25lOGZXQ3B5KzhlZHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4481858f-4d9e-42cc-7876-08db97ebff24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:46:45.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Xx6EKcZfoAb09ltk35BrxwocK56nzMix0X8i5bhSu9lVMoMgN+RFBbsQoXosyLMy7M/RiWYfadSC4sZX6Ge5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_07,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080078
X-Proofpoint-GUID: OU-PS-Y-UbJ_u-AJgiN8z7SSv-xkDBPv
X-Proofpoint-ORIG-GUID: OU-PS-Y-UbJ_u-AJgiN8z7SSv-xkDBPv
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 15:20, James Clark wrote:
> Metrics will be published here [1] going forwards, but they have
> slightly different scale units. To allow autogenerated metrics to be
> added more easily, update the scale units to match.
> 
> The more detailed descriptions have also been taken and added to the
> common file.

It's unfortunate that we can't have a concise description - like which 
we have now - and a full description.

> 

Anyway,
Reviewed-by: John Garry <john.g.garry@oracle.com>

