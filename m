Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398677F3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349464AbjHQJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbjHQJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:54:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8704E52;
        Thu, 17 Aug 2023 02:54:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H9Nxas020563;
        Thu, 17 Aug 2023 09:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4h1BR8s7Ks66fidJsSfHPeTeUcXV+ayCBqo++V8IDL4=;
 b=VP2pz2FJcVQBm0aqNom4aq9bTRPPMUcVbLeXUmPpPgyJ5HJPheS3RL98+gaWfaTyl4/s
 4N7t4gxrfyBYI6T8/CSSrlhk8cj7TTdyouXmKHZhUUDL1PwVO0unzq+XyWRq3ELQcWjF
 vuohIQ/0gTFx/M8a8ECpkwXrZ75LCiZBgWPEHM8TuaKZX7oXRztcjovmr42tbJbLNlXY
 VlUGVxD0E7SxycuGXDCQ3SktkzALpL8nm9OtbLPBJNPGV3sR0Vrt9x8YQPr+emD2PQsn
 cQsswTs/qOig7su5gMe347h8p78HBm6ZfMrfDqj38Q3Bj8y3z8RMFmPuUqNdy/B15stK rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c91w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 09:53:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37H8jsqb040096;
        Thu, 17 Aug 2023 09:53:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0tc5sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 09:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDFWot35mUyueg87xdbRnT1nO4m5DKLa9lf+PNw/3vos64pw6EaIpxejHGiTkh6dWBV28P7uRLHLFpuGM/LXL1rKooMitcOdr0j6AUyffL6VFEr59TfmX594j8cke+TOj8wnQhLFCjQzTGfSA5Vo3nTtwaiV14HnwVRprPCi25yHJVcEYqtuvH8tXSz5dwgIp3kGfl5boR/nf7gW1fR4xEAAeWCn30a9LZFYx3dCVRdo8W/4fbINTBiDGlzq2sY/pOn68fxTh6279toGNJuobU/XRvpqpJfsB5IEbup9kd6yVDmTDrptSl/kAJcuEGUK2+EOR4NVmog6UAsByyLsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h1BR8s7Ks66fidJsSfHPeTeUcXV+ayCBqo++V8IDL4=;
 b=gC2vy+DfV20wvhZEqeSAXn0mFg/YbZGWpNImkEusfmuGO0P9aV+S1mKvZPpLAJewJ7Ib4LOw4YI4M9uuK1NvTwKfP5kU/gm6HyiMIBX7Gyy0XcJDAw6pIgpZ78RgvbtCCqSppBWqALtBzV1s+ktE22oLCRxBRXVDKMhZ05Nnu30ojIgEDrGuVibtO7iGAuQr0ZtsT4K4+frrrLFg+uVMaSW4/kMPjgT1CBy0Q3U/4P0Z2YwLQrVF2AdEwpiTSOf+i7KGI5Fy5JA08KAaDmf07VAJGslD/cYmbx7GnT8VtA4RLX2dxnfQRS4ajyEJn3m0Oz/VdFwQx4X3vsyEvfZYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h1BR8s7Ks66fidJsSfHPeTeUcXV+ayCBqo++V8IDL4=;
 b=QwBKl3xrLfXuq457w+ckvA56Z8/EQ6xtfphOQC7KLNdIwr8SHei7V1HUyI+mYx5YbSfllUpA/tjAZS0Tz0fv8UsqaWRln0lXzKvovZ1NEjXjIGaC1b6JKxv6N+s3Rlc0ol79NHZ8/4SDXZKEtdggZ8uvy/obyu4fENimL9Rz6F0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7956.namprd10.prod.outlook.com (2603:10b6:8:1bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:53:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 09:53:47 +0000
Message-ID: <41140a38-b885-c198-d198-4e9a47de19d7@oracle.com>
Date:   Thu, 17 Aug 2023 10:53:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 4/6] perf jevents: Add a new expression builtin
 strcmp_cpuid_str()
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-5-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230816114841.1679234-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: fbedad18-51ee-4719-1448-08db9f07d9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLTkhHIdNvjzfdrG0CV4c3TVpQgOvOFLg/caEHLR1Nbn+78NkqBYbLZhukpckmTwyt6z/2bcJm031nT/pqfX+JeYIKfIOGwdF+rACRVmx276riYo05BsWVE+pa8yqknQtUygg6XWLEX2bUIeEfiGayAVLP26JVsFsuIprSoiyqu6ePGdsR/7UHY/nGYazVY5J91N6Ihez5vDiibk4xIUSvDLM2sURx2lR6Qz9X4rlYZdp/WNbUtpEpp3ct1ekYeei9xcXZdlx3jNGsD9aEmB+L7H4HSAbRr3D6BkHsf05+MXD/ELPZqMCUuPzT1cN1Hqe2IAaa7WHIHr1kCiN8da3Dbfc4Y3PyKlZ1uXGHcEqnOLy9Rns5DZu49mwUfgxM88VNPgQZBYhjaavAaoawKLR3ihkvBtBSKGtgbE7KRjGzsFkDO5n/tbWASDv/e3caenQrnwk6EwXN3E7s4IfoQs3M81e2kUuWm7oDNcb1MJyVey9T5SEqI8orRLKNRtcTfIr9gT5EqJSYbYDKVPU3eAmQBeEaik3h4buhLdc+bdB1nYZG9X9jNuxzj0fHV6FrF4+DemLXstYQWAK3QeCBx0JOecuLb04fgI6/d8QKuEhk53e6JghB/XxN2/RRAmp7q3DJjcOA4RD1fVR8uo3vaCBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(66556008)(54906003)(66476007)(66946007)(5660300002)(2616005)(41300700001)(4744005)(2906002)(316002)(478600001)(7416002)(8936002)(8676002)(4326008)(31686004)(6512007)(6666004)(6486002)(6506007)(36916002)(53546011)(36756003)(86362001)(26005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azFlZTRvTXVZZDNoaytLOHAyU3A0ZXg1cnZZekZ1QzN6SUY5V0FYbnE1TU1Z?=
 =?utf-8?B?NWQ1dnpZVVRoWE5ITmZuSzNVUVRkMUhrczlOVlprcmprOEEzQnBEc2Jma3N2?=
 =?utf-8?B?bmkzN0FPUi9XK3RsOWlvV3lieDk2TVlWUUJFczUxSjBmY2hQSEp3VGpSY2xR?=
 =?utf-8?B?R0dHN2F6VEtnMHVqZmF4VUVTUUZyQ3kxMXhyQVNOUmF2cGE5NHhuNGRyL1Q2?=
 =?utf-8?B?Q1B1VVFzRWdpT2JWYTRxRGFWSmZwNlJ1Y2lVUjZqcVc4ZlJGR3hFL1JNaGRR?=
 =?utf-8?B?enpTMldDTFJYN1AxOFp1ZXd5bE9tQ2lmUXhZNVlQbnI2UVFqVy9xd0RTVWhZ?=
 =?utf-8?B?THlRUk1ucG1kd0VYSTlnaCtJWFJLYXRqM251aWlxVk1UN29yYmFrTVR2WCtQ?=
 =?utf-8?B?cmtOUTJIZDlZcS9FUUFzRnN3Q1d0Z1ExMXU0V0NmYU12M21kUGN4ZHF1VUVN?=
 =?utf-8?B?WkhNdUtLUmxPLzY4R0w1T0VpR3lENGtPajJxSEcwRWF4dU9vQ0MxVG1aamRI?=
 =?utf-8?B?ZDJFb0Vic1hBT0RVTVg3Y1VTQklRTFI2N2J3eGdPZFdPQmgzNVo3YWZodUlR?=
 =?utf-8?B?MjJvN01ORm1tTXVoazVkNUhZbnFCd3o1Rmh2R0h1VnJNYkc1c2pLVFRwb0l0?=
 =?utf-8?B?ZThhMTF1USs1Q3h3Z2QxTkdxajZydHcxQVN0TE5jcnd5ZFdHZmJGWWducmZ3?=
 =?utf-8?B?dzVLOUpXWm51VDRvZWZ4c1RUZXNHZUlVSmJzOS9sTlB0L1JjR3NDSVRYTUpz?=
 =?utf-8?B?MzBoUGZvcUxBSVYzaE5sK2pGbGZURXFOaVFyN3hwZG0wTnB4cy9wT3BiOXY2?=
 =?utf-8?B?M3dJaDhpTXZSdTVCeEZlMEpCbzRtN3k3K0hHU3J0NnhHVVpZRTQzVFRkaDB6?=
 =?utf-8?B?Wnd0TkhETnEyc1ZrY1M2YVhCcnFZdHhKdWRpUnNXUWhrNTZjUFExeTNBMWZ4?=
 =?utf-8?B?R3hFSUtQdnFEYUZLR1J4c2hvbUZweVJNYk41UHQyU0dVS3J5bmR3ZGVZbVN6?=
 =?utf-8?B?ZWZtdWZVOWZVcXFkamdZUVkycEJzTFBQRUJON25BRHpPKy9NUkVmQS9TU1RW?=
 =?utf-8?B?UUU5cTI4bHZoaEttQXJWM1o0UlA2RVp5bWRXMytWU1hITmxVMndsdTRLOW9q?=
 =?utf-8?B?akg5NGk0dWVPbG90cVBWbnkyemloa3I3SzQ3ckJ5T3FVNzRsVWFORXhEcW9x?=
 =?utf-8?B?M08vN2dBdTNCd0lmV3pjMDhUUERFS3RsUGQ1YkR2bDB5SkRyUVdrL0RHTjc0?=
 =?utf-8?B?OVFtTzQ1Z0xDR2xrY09Za1UxN28yZVd5dEM3WitsMGkzaUZtTmZJaEpKcGl3?=
 =?utf-8?B?ZzVMM3IyN0pvTForQ042RExyVituZUc0MVFaVU5TZnZYR3cvd1crWmd6L2Zv?=
 =?utf-8?B?ZjJYNVdDenR4Qjg5Rnppck9zclVyTWYzYUluYWNVaVRjZlN2SzRvRUVPcngx?=
 =?utf-8?B?VDEwUmh1MWk3b0xPOHByTmFEUEpFaUZlYWs2NjcwK2RJdXFubW02V2tBQktT?=
 =?utf-8?B?MjFDUHBPeitwczRZTG5Oa3MyUUFqbHA4dVhIak1PNng2VGJTSmFHWHp4a3NW?=
 =?utf-8?B?MnBySk1oa1FrRGZJWWdKRUJSdkRpU05OcW1MblNvL0RYbldmSElES1lvMUFr?=
 =?utf-8?B?ZWplQUp2OUd0NC83bTljTDR5RExwN1NCV3YrWVhoMlo2UXBDR0JMZzZma1ho?=
 =?utf-8?B?bnJVMXZaUHljdU9yV0lTL3pncHAvUkxKZlF0cGE5YlpKQk42aW5SYW9QYXJI?=
 =?utf-8?B?eHlDWWNLMm0rMTUxZmluMDJEQ1JWdHlBM1lJdWdrN3p0cGNicFFhKzBlV1pt?=
 =?utf-8?B?dnJ1UjhoMnNOaS9WY1JMNmVLTENnd05DTnN4TU11a0VoaURQQ1dXZVVZU2RN?=
 =?utf-8?B?UGFjYWk4aGNzVFQ4elRSaWxhOGNxSkhQTGhIYU1DSFRaNkVjZmhUVXFyNlF1?=
 =?utf-8?B?ZUwvTGQzdmsvSjh3eVBheDI2UGRtNDk3RkJmampiaVAwSysxYVl3dWl4Zmpl?=
 =?utf-8?B?ZlFNSWRJeS9IbTVoeVhxdDVwU0xXZGtyZ3VWamlZQzZOUzBnNkY3N3A2Zk4w?=
 =?utf-8?B?Q3hvUFJnSjVsYkcrQWxoWHpzLzNxRCtYeHc3NXovdzdtTHpGbnErWm8xUk9U?=
 =?utf-8?Q?DxRWwB4+3UL6HooOgRDERjbSd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UGhSLzJRT2Z2MGhQUVZ3ODUvS1NtamZObGlLbzZpdEdJSnF5dGQ1aTlPUkRh?=
 =?utf-8?B?TzE4b1hyL29nb0IrdFo4Ri9sSFhuTlJDeGNtM1UyV1p5NXY4bDQrMklMNXlP?=
 =?utf-8?B?NngzMEFQYUQxUkwrRVA2dVlUaXlndmV0OGRUcmJxTHFMdTFLbUl4Z0poSXBB?=
 =?utf-8?B?OUtLMnEvWkVGZkxNVW1uU0ZBUnlPODZsSXZ4Z3VNem44WTU3aS9GMjVNU2pt?=
 =?utf-8?B?M2dUd3FyWFlac0VVTUpuaXhmS1Z3MVp2RVRjamZpeENscVNzdHc5MDcrcGVx?=
 =?utf-8?B?dXZaNFNkcHM0V3V6YjJmMHd5UlF1ZkxKa2xiTmY2SzV5dGk3NGd0R3RNSzJV?=
 =?utf-8?B?NTNncmVEMUx4NzFldG9zZXdWZzlKSXNOODQ0blM2bTRDMlRVcEFRWnFVYU51?=
 =?utf-8?B?czVBbi8zQ0FzT2x5UWk1RHIxdDVwS2VEMm5YRVVaNlljRDEwbWllSm1QSU5u?=
 =?utf-8?B?emUrU2FxQ1ozdS9zckxVT01EeEdrVjZRKy9mZDNNNjdoZmpmdUQ2aG5zMkFC?=
 =?utf-8?B?VVBqL3hZUm5iRm91RVExZEJUZzZxQ2xCRTBSUElHdWxIVjJnK2ZESzVzNkJO?=
 =?utf-8?B?b25uUXdKTlFYWnA3NDhDWE12WlUrZVhvLzhzMWt3VGtuUEVwYWpFdWZxazRu?=
 =?utf-8?B?Z0pDUk9tTVZPRTJhMUVVVFZkL25FOXZBeTE0K1RaN2dpSTRmYlhBdjhrMEpR?=
 =?utf-8?B?WFp1VHJFTEswUVliQkFQWHYvZWQ1dUgwVGJuZzBCQ3RPaC9nNFlVWkxJVWY2?=
 =?utf-8?B?SVYxNEhXSU8xdHdrR1IyUU82MVFnQ25hdVN3MkhOWXFhZEh0WStkc1grMGxj?=
 =?utf-8?B?SExHVDF6eVd4QkIzNFdhZ0lPWWxhUVdXc0dYSytVNmxmM2E1TE1RRUs0RkVZ?=
 =?utf-8?B?RUJmeVBLaDNic2dQYzFkT1RGeVlrVkRXT1laUlZWVHdCcHM5dmYxMFVBOGV0?=
 =?utf-8?B?ZWJKMjNyTGc4ck5SM2dGTktJMEo0WHYvQmxyM2YyQzAzZ0F1blhEN2o5SHdn?=
 =?utf-8?B?czNoR3RRZ243YU1xSllVYkhuRjhxcDU1L29IWE1tYXdROWMrbnhSVGdqUnl3?=
 =?utf-8?B?NDFCaExQcHJ1V2xESWk0d0JIYXIyNlZKSFhpYXBHZS80dzllZEdMU3F4OTNi?=
 =?utf-8?B?RzdyUkRaeERUaDhNYkQ4emw0ckhJNVdYcWdMZnFsQjhlMEtGTU5hU0hyaExp?=
 =?utf-8?B?c1RXWEx0SXBycHFQU1pZZDFQdGh3anVpV0Z5OXJ2LzJPRWUzUzRLT2w5RGdJ?=
 =?utf-8?B?S1pNYXFobnlDU0hwQjFpYnh6M2FEc2lFRlkwb0s5QzBOeitBeDkybkZoNWVj?=
 =?utf-8?B?bUtNVDgySHJwRHoyQ0VIQW5id3crNloxVlNUa0h1Q0VzcDZUUlNleTUwVDZZ?=
 =?utf-8?B?eHN2NlJsMkJEQ0dFWjYzMXJna0VEY2pRQ0NhaWs5V3BadWFFM25Kd21QOCtt?=
 =?utf-8?B?WFJMU0J6V1EvaWwrUCszZzEzczEzVEJTZStLc2dxWUZXSEx4ai94Y1VyQ3Vl?=
 =?utf-8?B?elBWT05WVUZEWlhWZi83TithN09hOW9SWE10T0FJRjVMc1VVaEdlWWdodmpn?=
 =?utf-8?Q?9fv30nl5xn9pPyaCdRUmjTF8U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbedad18-51ee-4719-1448-08db9f07d9db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:53:47.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a16pRmI8ofNH4UAOnrE3F4znJxX1gX3scA0jqLTM0sbNwAaSUBcAB1KT3rskLCPOCYLvxwR+XwwZnmnaGwyjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=937 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170089
X-Proofpoint-GUID: 0R-uDlnl9frMRkF9zbGAEeJmxneppyEE
X-Proofpoint-ORIG-GUID: 0R-uDlnl9frMRkF9zbGAEeJmxneppyEE
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 12:47, James Clark wrote:
> This will allow writing formulas that are conditional on a specific
> CPU type or CPU version. It calls through to the existing
> strcmp_cpuid_str() function in Perf which has a default weak version,
> and an arch specific version for x86 and arm64.
> 
> The function takes an 'ID' type value, which is a string. But in this
> case Arm CPU IDs are hex numbers prefixed with '0x'. metric.py
> assumes strings are only used by event names, and that they can't start
> with a number ('0'), so an additional change has to be made to the
> regex to convert hex numbers back to 'ID' types.
> 
> Signed-off-by: James Clark<james.clark@arm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
