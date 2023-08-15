Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7C77CA96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjHOJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjHOJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:37:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069D19AD;
        Tue, 15 Aug 2023 02:37:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOAwF020677;
        Tue, 15 Aug 2023 09:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mklwprPkmYwzPWicOapbR1sjuhY0XgLuCHXhQ7/fNwQ=;
 b=3bxN3WlHloSCMHgQWDby9/nleY00NpgEpPrGc8YXfFa4qv5xkArO5GxJ0qMepmWdmLzS
 Im3WKBK/Pq2z8XGAPypHTve3pcrLYaS7kafHmrDj0Sd8/+UlTI23bTxbER7D4a8HIOp/
 7FktGouxUyF6sA8P4BWTjtmlln8K3S+Q1JyQ/fiVNoLXGPVaGKvSonpUBwlcrHWegGeC
 nzBDTzIpDn5Cm6kAyP4Ity7I/ADR+qL/upWDoaJZI0wmDk8NGrg2cc8etSF/F21D9Ctz
 0o1LgvdsjifW5Y2h1aFOVmuYNO+6xB2lRQ0hl2Td2my3MCnZ29lEUOmwgyVbG8wB4zJA 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2vchw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 09:35:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6ftrd027389;
        Tue, 15 Aug 2023 09:35:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rvy7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 09:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StcsduX/oW37qaV71tLU/YCQrRjBt52FAUXe25GBWL131ca8jrFTpgB7uI+ntAJ9SM6JFam3fmRvC0w6dgeBpmViTJutLoKG+xBl2RXS/oo/7giStOPaIOqV+8gaFeK35+21qxclpJ/UXIh03OL9ssMfciv4dA940VhJVLwM6aHka6iTFdJmNwreH4u84Yv6WBLdqyDr39dmGffjp0VmDHZ4XGXLS/esA32rt9HnZ74nKMGJue1Yg5LWLnI7SPwmp3kSocJISwpX0O3RspftX+oSnrxBHOsTuKw+d03vOWpVupnkq+A+GBnkpGUAY/5uuEwP3v5BWktfKSbbeCb/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mklwprPkmYwzPWicOapbR1sjuhY0XgLuCHXhQ7/fNwQ=;
 b=PLefUtUok1E2MwPDMsihNakaaOKXNY22k4puPJmcD25qDzMHkMN7GIdQqiP6l9y8tTqPkxPUnUsLQQcdzuKTSPoEzbNklpNphkP4s+XXWUe70FGU5mEvAOciEv+OkApjgcPo45cQehR8BvQt5d8Kh0LneG7lClwMX4l8/iS3KCcUDef0OyGIFKZ2yLiuM+m9N92HoPV5GgaxtkS03NAMqAYgNsIEXO2VyTVUO8A578evkTJQSJYvsti8LKryIxiLrm6B3G36YXTGoeJ7hSlRbmcD+NN3lYukvAiTzlxpVdn+UebL8xrD8xzV7phpeg7G9qL1cWNZ/i8zNnqtRqAjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mklwprPkmYwzPWicOapbR1sjuhY0XgLuCHXhQ7/fNwQ=;
 b=lnhuCAIR1A1O9iAbDGtqpfSu95MTb4kLE161proevSrSNZ6VfxQibajBF7BjOMmrHla2g46F1Drufq7yh5a+YTeo5RLvtb808Eg4w95S2CmpKeu/NznKloaFQjpIyE/VxQSATwq9nCo7He2x1ncioM2XRyHGIsvNFz4GD3G0HfI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 09:35:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 09:35:15 +0000
Message-ID: <d6b702fa-0b7b-63d4-cd84-eed4387663a7@oracle.com>
Date:   Tue, 15 Aug 2023 10:35:09 +0100
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
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811144017.491628-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8e8a3d-531a-4c8f-aa08-08db9d72ee7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouU117cDJQHfEZAxMrJwbiFY6Rss6luFxH+k17Hu68oyqowTzgZOtoNs74AAEKukKJ6A78UlqV98/7UcAY6qudJhOaGh0o9rcBfKBa6m4gEq8XXLclP4z+JN9ucf5gBVftauGSeqUqNyeJ+saeI/tzgOjyjxBA9LCIYiMvIVWJcIXcPO22J2KHSAvJ9MEYu2XVaMR67Uiz1Ve9WpfqxI/9zSkbUxPEPHE41nbr0D5S+AERIxLQI2wuA/NEnZiBr4AHELicfvSkF6sk9Bnh8LkJIMw9JcfYuKWhs8h/RPF04VdDwdzG+BiC7DhdeeB45PuB5qzeycWaZKvJxBSDe18dmu3j7ZwPugnQYKsHms2GWvUMeo4K6j14b9nAFo0e8pWZkwTatQowZUPD9pPiYBm5knm7mYmFvHgtDp3oFa0t9HxFucYe1166mx6OtcsAUCA9uO6RIngvMJ99SLoz6RtrddbaGDUfZ5CCBG4/VgxNQO4FQ7BXzTHUtSSQgVo3R5mu84cPquF/9/gcJdk6dvVY0C9eBZUhAC8YXCST+lL36/JMLjQn4mBQNgQCjSG1Z3GwNC1r3hpO4t7EahmHStUkbLYiQXguQRfzaFvvKsJ2v1CL5w/RFC9vQ52JMiVP0vMOR0zj4w1189QhMh4Lagww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(1800799006)(186006)(451199021)(31686004)(7416002)(2906002)(36756003)(86362001)(31696002)(5660300002)(38100700002)(4326008)(8676002)(8936002)(41300700001)(316002)(54906003)(66556008)(66476007)(83380400001)(66946007)(2616005)(26005)(6512007)(36916002)(53546011)(6506007)(6486002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWwwM3lmcnY4K1ZUblFQNUZkalh5bTlkRk4yZkxaYUtkYUR1ZGlscFk2MllG?=
 =?utf-8?B?ZnhNNjMzMEtGRnB6dFgrTS8wWUcrM0pVaW9vVTlOUlN3UllvQjJDaGJpWXdl?=
 =?utf-8?B?d0hLTzFlNGtuUkljZlhHaVIxdjNCWnN5UzlldkEybUYxb2NZUENiTEVuWW1P?=
 =?utf-8?B?N1JHZ2lxMVE5d3dZbTdRRUdyNUZBaHcrSFY1MFk5OGw3UTZQeTlXaE5XWDZX?=
 =?utf-8?B?T1FMQjRBTXIzdnRtN2c1WGkvWWxUbnlLdjFwMXRYc1FvMGt2Q09xZUFoZThX?=
 =?utf-8?B?WXF6SmY5ZHZTcC8wS1lHZ1hrclMwOUhqaXBqaUo3Um00c1RFTzdROTVJakdw?=
 =?utf-8?B?cmlVNEp5SVQxelEvK3k1TVdiVWFhdlNrNFhORWt4bXBPVE1ZQk9WUExDaTI5?=
 =?utf-8?B?aHh6SDlJaG1idjBJUk4yb2hyOTh3cWhBYlhmZXBFUE5xdDBvR2l2eHpSdlNW?=
 =?utf-8?B?cUE3RkRJc1JLRXVkZFlnVURWeHBWcjlPM29TdzVHVUNaand5QW54RXhHcU4v?=
 =?utf-8?B?ZGdlOWMxVTI3SUNCTFBuek5ib1g1dzJxNzZhVDdBM1ZnRk9ONU9EWGJTTUQw?=
 =?utf-8?B?ckg2ZmtSc0lsRWVaS1BpdlJiTGlnRWtSc1NOeE1vMVlIQmk2OGRqZDA4SWF4?=
 =?utf-8?B?cDgrS3QzVnhlWFQrQU1TaWk5VjVkbXJTdkZqbU9FZXpXcHRxOG5xVkg2elNR?=
 =?utf-8?B?QmI0cmpXVzlsM2t1Smh2MXhtenA4T2lVV25kVDNVcW5tL2lGd1Zrdk5KUE5I?=
 =?utf-8?B?bHR6cEtIbEI3NWlHVk5vNTZ6RU95ZHNRVEdyVTZadU51aVhrcmNsMDhKbk5K?=
 =?utf-8?B?TVpjY2dEOFQydGIvNjk5MVVjWUorVEkwUHhqWDVJS3pubEdnQk9NL2tlMmR6?=
 =?utf-8?B?bDEzVGZ3Tmg3OWwwNEVkSXdPNlNYaUZOT0syOUt0eFhiL1VNcmIxT3pHbFAy?=
 =?utf-8?B?SmxOMlBxbjNXakZoUXNvTHljVHFZQzFCTWhLblNhTHVNcll2M29Xa2ZMcVBO?=
 =?utf-8?B?eFJrbzVLV3lPZ1BKektVa1JVRHB5RFF1T2RlUitFbXF1VVkwOFl1eWRBK09J?=
 =?utf-8?B?ZzBKZXZ5R0FmRlY1YmExanZtcnpDL3RsRmVMMXdaOHpmb2RlL3ZXc2RlcmhM?=
 =?utf-8?B?ZEQ2Y1AySzNHTncxT0Z3Zm5pN0haQVlsVGFVOEZBSnN5R3JTTXNYK2NEdDVU?=
 =?utf-8?B?TW9obUtXR25aZFJ3NzBVdWV5R29HMlU5a0NpU1o3YUFDREpPZUtONVloS3Jv?=
 =?utf-8?B?RTh1c3ZrLzg4OEZ4dTZBUS9rSDhaR2FpNUpjY21rWG9MZXF5RGhROXZRYStu?=
 =?utf-8?B?ZXVDdWhBTjJ4dzBSLzlLN2oyd01ad2cybkdwTzlDbW5FQlprUFlvVHJZakE2?=
 =?utf-8?B?QmpERXhMdzloQld0Y0I2WkRWVDBENTllMVR4eUFMK0xmeHNwSnBKQzRsaURq?=
 =?utf-8?B?djB0RTRtWE15Vk9LdTQvMU1rczcwdC84M2lEaFM0dTFuUndabTVWS2lrTnll?=
 =?utf-8?B?ZVo3TzFNZTNPNUM2ckU0WE10NVhKUGFhV0o2RC9MT25mZUV0dzRLaG5JV09P?=
 =?utf-8?B?ZHArSmY5MkhpZEgva3lsUDlZbUZmMksyTHN1UzFYN09jS2NNWlpxN0wybDNG?=
 =?utf-8?B?aWhuZkVpTTZZVkZTcEgyRHBQNXhrci9TNlowTW5IbW5vaWd1SmZjTC9yUmdC?=
 =?utf-8?B?MGlDZFBxVUQzYVdSRnVhMmhnejZBN1R3cmJkME1zc0YzU3RmUGpRenhMMnpQ?=
 =?utf-8?B?eGMxbVB0NGJWY1JoamdPT3BrdEFLOGEvTGR3ZG85TDREa3FIWkdmUGwzU0Yr?=
 =?utf-8?B?RXNKd1ZMODRxdE0vWmcvNDg3VnlDUGprM2xMbUtlQXoxQjF2Y0JXelVrM05p?=
 =?utf-8?B?eWQ5T2JQUEdwTndBU3VpaXlubGF3dUhScmgwYVA3OE1tMkVXTDRPeVhKUFZ2?=
 =?utf-8?B?WDlSV1lEZ0dva2t1T2hGMm0xaDhnWVZLK0xBTjRZVC9XSG5pTUVFUVJja1VM?=
 =?utf-8?B?WWI3NThCejVydTAzUWZMaCtFODB1L1UrazZuYytPems0LzUwaHYxS3FLR1J4?=
 =?utf-8?B?M1BFTDY3QzVJckE2MHNmQmNhdnllM1pFOExqbUxPeWlRSUNSaEhrS0lORFRu?=
 =?utf-8?B?MW5NMjMzbjAzbURwM2Fza1Z4S05TMU9aR0dSV215T1ppcTk2SmlUTGFKRmRr?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a0RPV0JxbS8wbnBBK0N0eUZYVUcrd3ZoTmdRNm9qeUtibkxkaHRDcUttZGtY?=
 =?utf-8?B?ZlhJOWxwc2xPTWE0OEUyVElRQXU3ZWt6TUlVRTBPeFNQV3RBOXFxV3ZHVnQv?=
 =?utf-8?B?c3lGc1dHWnBTNHFMWWNUd3RqbFFZMWJiWGJ2bFpKK2JPN3JUSmp0NFZlMDBh?=
 =?utf-8?B?OXBFcUx0WnliaTJEU1VFSGM3cEpPTkdsNVhFRGVuNW8wVHVEaGRIYnBsT1Rr?=
 =?utf-8?B?S2s3MUJMZ1pqMExvR2NrQUptTkNIZVZGM1NLcmxXWnhtNUU0WU9HckRMM3pC?=
 =?utf-8?B?SHgwbTIxZ2k2TURkb2IzalplbnNSaDFObE5WNXFOR1dMSFVFMmVkMEU1YjNa?=
 =?utf-8?B?R1ZENUFSM2lBSDJEZmZ4dEdCT3JzTitEaXBHYW5SZGUwUlAzUFRWUVpPWTd5?=
 =?utf-8?B?ODV3eG1xZmVJQWxvRTJDVi8vYVNqMm40SlBLMFAvd05YVEVlKzNZUitTMzds?=
 =?utf-8?B?VUlPSWxzM0JNVG40Wi9KdmM1ME0yZjJrYi83SjdYVG1OT0pLazlkMzRhYkdl?=
 =?utf-8?B?bjJCdFdqc2MyS0JmcjZnSSsvQkVNY1FGM0dOMzNpMHpaSGt1cXpUQzlvQ0hH?=
 =?utf-8?B?YWwrazMwekRZcFBSVmJIRGtoaG0yamxpaEN3S0tEa05GYTgva2pUbHlwakdh?=
 =?utf-8?B?cDBQSm1LbGVxUzNJbCtJRVR2aGErZXBYaGZQckVkMnQ5R3dTalZyc3NOd2h2?=
 =?utf-8?B?UFZPUEVUa3FDdFpNRDc5azBwWEVVQVVxK1BYZk9PTWZkc05VbXhucFJkQ0Fi?=
 =?utf-8?B?VTliVnJRdnJxYUtEeTErZzlYUTQvSE9NelBab0R3SzVYS0VmUDlobEgrUk9I?=
 =?utf-8?B?L2NSb1Y4eks2aUJWMTZsOXZGaHJkeDU2cEJjZ3VDejdQRVpUYVNvZGk0YmQ2?=
 =?utf-8?B?OFF2SUV6dEt0OWtCemZocHl6NjVMMG10K3VYVS8yb3lJQ2xDUnNUa1ZBalZw?=
 =?utf-8?B?TFdyQWRCUmdGbmV1REVoTmMzRFQydDkwc2dxZHh4dmcrbjNDK0RUbU5yWEpD?=
 =?utf-8?B?MmlSa0NSUUJwb0I5MExOZ1krNWRjSllmTm1rb3hwbkZjQlp1TFBicFdwWE1B?=
 =?utf-8?B?M1lLSmxDa3ZyaEVNWVpOeVlnR2FpMHJzSHJDdjNid2d5eHozSlBjelNnTlFT?=
 =?utf-8?B?MXd3NC9PNFhhMU41WXMrdlMrWEIvWXlzeVEwRFVuZ1BkZ1VSNGRFbHljN2JB?=
 =?utf-8?B?L2RLaU54c2NXQlRzSWg2Y1B5ZTFrRHNNK3pKcXJDU0RidGFmcVJnSDlPaElE?=
 =?utf-8?B?UmdUQWFpUWVsK081WllZSWZmbmlnZ3lvZ3RyWXdlc3VhZEc4VE1Nci9tWjdm?=
 =?utf-8?B?TkxRUm5rRGRGZk1YTWdyK3YzTzZjM0dSbnVTRmp3M0FPRHdHYU9rZmtUNnRJ?=
 =?utf-8?B?WUZBbTZSeWF3dVdLVWV1SjF1cGVodC9yaDd5bTFCWVc2TmVHRmxWa0R2N0ha?=
 =?utf-8?B?ZXZmZFhFMVIrNXJ6VHAvVXErU21OYUFXUXYwVlYvNElWOTBiaEwxTHoxbC9t?=
 =?utf-8?B?Q2dmTTFmNFNkZW5scSsrNld6ell6L3JkOXBuam8vbzQxREE1U2QyRU1YZVFE?=
 =?utf-8?B?ODUxSjh6cHorY2pGdGZhcHJBeXpnQmNDemlTaURxN0NXamtFWmlGS2VZbitr?=
 =?utf-8?B?Ri84UGxOamE1UmRHekw0L0J0SWl4WEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8e8a3d-531a-4c8f-aa08-08db9d72ee7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:35:15.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2uTZIId4zjrBNcKaWxq541lR9lVzn81hv+YT+avPkOviUy9/J35HuCRwl9IVyWi66q857/b6JEiaUF8CGQxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150086
X-Proofpoint-ORIG-GUID: 1sp1d8OKc2Ep8_42RY7Pi97_tbjuDhz3
X-Proofpoint-GUID: 1sp1d8OKc2Ep8_42RY7Pi97_tbjuDhz3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 15:39, James Clark wrote:
> Currently variant and revision fields are masked out of the MIDR so
> it's not possible to compare different versions of the same CPU.
> In a later commit a workaround will be removed just for N2 r0p3, so
> enable comparisons on version.
> 
> This has the side effect of changing the MIDR stored in the header of
> the perf.data file to no longer have masked version fields. It also
> affects the lookups in mapfile.csv, but as that currently only has
> zeroed version fields, it has no actual effect. The mapfile.csv
> documentation also states to zero the version fields, so unless this
> isn't done it will continue to have no effect.
> 

This looks ok apart from a couple of comments, below.

Thanks,
John

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm64/util/header.c | 64 ++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index 80b9f6287fe2..8f74e801e1ab 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -1,3 +1,6 @@
> +#include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <perf/cpumap.h>
> @@ -10,14 +13,12 @@
>   
>   #define MIDR "/regs/identification/midr_el1"
>   #define MIDR_SIZE 19
> -#define MIDR_REVISION_MASK      0xf
> -#define MIDR_VARIANT_SHIFT      20
> -#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
> +#define MIDR_REVISION_MASK      GENMASK(3, 0)
> +#define MIDR_VARIANT_MASK	GENMASK(23, 20)
>   
>   static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>   {
>   	const char *sysfs = sysfs__mountpoint();
> -	u64 midr = 0;
>   	int cpu;
>   
>   	if (!sysfs || sz < MIDR_SIZE)
> @@ -44,21 +45,11 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>   		}
>   		fclose(file);
>   
> -		/* Ignore/clear Variant[23:20] and
> -		 * Revision[3:0] of MIDR
> -		 */
> -		midr = strtoul(buf, NULL, 16);
> -		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
> -		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>   		/* got midr break loop */
>   		break;
>   	}
>   
>   	perf_cpu_map__put(cpus);
> -
> -	if (!midr)
> -		return EINVAL;

Is there a reason to drop this check?

As I see, it is still checked in perf_pmu__getcpudid() -> 
get_cpuid_str() -> _get_cpuid(), and we don't zero the buf allocated in 
_get_cpuid()

> -
>   	return 0;
>   }
>   
> @@ -99,3 +90,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
>   
>   	return buf;
>   }
> +
> +/*
> + * Return 0 if idstr is a higher or equal to version of the same part as
> + * mapcpuid.

And what other values may be returned? If just 0/1, then can we have a 
bool return value?

> + *
> + * Therefore, if mapcpuid has 0 for revision and variant then any version of
> + * idstr will match as long as it's the same CPU type.
> + */
> +int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)
> +{
> +	u64 map_id = strtoull(mapcpuid, NULL, 16);
> +	char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
> +	char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
> +	u64 id = strtoull(idstr, NULL, 16);
> +	char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
> +	char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
> +	u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
> +
> +	/* Compare without version first */
> +	if ((map_id & id_fields) != (id & id_fields))
> +		return 1;
> +
> +	/*
> +	 * ID matches, now compare version.
> +	 *
> +	 * Arm revisions (like r0p0) are compared here like two digit semver
> +	 * values eg. 1.3 < 2.0 < 2.1 < 2.2. The events json file with the
> +	 * highest matching version is used.
> +	 *
> +	 *  r = high value = 'Variant' field in MIDR
> +	 *  p = low value  = 'Revision' field in MIDR
> +	 *
> +	 */
> +	if (id_variant > map_id_variant)
> +		return 0;
> +
> +	if (id_variant == map_id_variant && id_revision >= map_id_revision)
> +		return 0;
> +
> +	/*
> +	 * variant is less than mapfile variant or variants are the same but
> +	 * the revision doesn't match. Return no match.
> +	 */
> +	return 1;
> +}

