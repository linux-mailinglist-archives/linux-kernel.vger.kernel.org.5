Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA8760F91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjGYJls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjGYJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:41:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B815910C9;
        Tue, 25 Jul 2023 02:41:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7p611001307;
        Tue, 25 Jul 2023 09:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Gn3FaTrU3z5Y1WaHVxIndN3S3E1SQHyS+gg5g4rNtEA=;
 b=HyWBJtRNmODwX/ei2FgyG82GiIWRpb7uzweluvJpDtT1pX9TUWCAcK6hbUKIWHGe8xSh
 wFFu8/yN2CW/DITDXAvTDwL09rlVzETzKfLRms3HEBh6K0hQFfgg3YbsYB32tFVg37kl
 cwclZ74S0MewTdsXcljzMHFZzSaGIR72MlBv7Oi3mXgdjPCnzYpk2YNqrdQba/hJNbMj
 lSYtbyDwU4YnOZggGUdvNwu8NRvRuUr9vOjN4RNzenBpZGLeBs8hyf+BzYdPdS8mwjNl
 qaKMElvrKj5WnABCTURUj4qxUhtjRoB+VlBSfYAP3ktT+OzxCoNFxjMmAdYPMFsRoSwU 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdvnn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 09:41:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7sGgv028695;
        Tue, 25 Jul 2023 09:41:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4s5aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 09:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTFzjilvR6PsIU/jP1pGPc+txTJQC2vCkXmC6xFpzBJEg65vyBB9kY1o5S2calEihO0izVkWLsK8+xnZGvLHSGnkZzHQARrrdsVPqfDxQYA8xrdDQvUMpeMkHMSXPZNp4nOh7/OwDsLkNIDlBQ0tvpFH3qmddB4y3FCJTTzJfRiTRXbG5JuRSs652ASmuQJQBChSlMbFgV4IB7+jKpWXzFCRAlUN3726keHyjuQ3K4kRsbeBwHoied+zTATJYcnkj32Sz1b3IP5bREjZ05P2iNQu7DkKkwLzyiEyVAq6c9lox6jZup8gJLhixPFF1MMld7rPgIhnLNnMii329+L5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn3FaTrU3z5Y1WaHVxIndN3S3E1SQHyS+gg5g4rNtEA=;
 b=XB6z1BrDHa3ACvvbIMoxcAhEqon1yrh/r//f9A/4LvzzI7vIaWJe1yEOrgod4RGMpvQSfs9R95jRCOu9/OLyJzz2tOCektCrvwTV9Hyg0g/TPqbyvAE4UrWQc5lercrd04BjwIP26Dy7vL94uRDTOe3/o/0sji5C2RAIGuIAXtiFzqIOwLUjGN1bYhw6JewB9Gd2xIr/OwACC7EluMsN/q9/9qw0YaLW3eOzgOXgCaQq6USujx80RUoctq1a/iBIImzoMq6ySmiYS2Gshnn3W3NJfhgs+k+J6VO2My7A6SviqIKW0McH9Ce/iBYWUozX8Mp2sTzMVNjP5KwDOPX6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn3FaTrU3z5Y1WaHVxIndN3S3E1SQHyS+gg5g4rNtEA=;
 b=shbGShLGu9WjfgnN/LTm6krb9N5s1sFUr0iU9SqTrBDNoXx+QFuoiOkbxWXvOhwNfCoHVZhNgoVFWLay09Q9NrVDIOWP0ozl/wlz8lMlyMCQ7aFKhrTmQkw7M/kdq8u2h4JY5RJtLW4HK/8W48Bi5bxkWW2QjMV0SwSgVryDpfk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7757.namprd10.prod.outlook.com (2603:10b6:a03:57b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:41:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 09:41:04 +0000
Message-ID: <13cdb7cb-e6c0-5b85-3ccf-adb3b0ed36e0@oracle.com>
Date:   Tue, 25 Jul 2023 10:41:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/4] perf jevents: Support more event fields
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690100513-61165-3-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1690100513-61165-3-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: aa118bc0-c804-4a1a-6a07-08db8cf343a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZiHxA6E1X3wHvbIaWrzyHjNFw/Umoaq8kkA307Knqdk6nJ90WiRGXZkLMNhg4YxkrlkmhCy6mLh3II9isb/UDrAwjQ7EinMEzevPsGnfUdHwKI8Qy8+WqzDU0E+EGVmAVP3OjWXpdO/H0beKvfVRPf08Ymqi829snkC3+r1yZBE+5V+65RuxAG223rpAPPyZhqE5OExG1oBpXmyqZEAFdbzpRA+RnZvG3l3WMr0L4XVG6H6hG+9k1YnUCrjtZQqGanJ74My8i+u6p8g6tF+60TgbKMV+/AB3lXVEJhM3Lyp8OdpV/sPYaNOTKEo1okskTQV2E9rzpXqvbGMUulo8okh4r/YET2yCWyAcr4rXmqLJ3A/ahq9jjAghFUXyVObZSATD+rIbUHUD5yybPYyH8+j+ow5mzdQbQd3w4jGoV8Gyc39AzxZCk6Wwifjw+AyAEboSAsvGanupCXs94Ve7qsdr1gxlYM1qaIcdAQ3HsHyJ+B9Nb5jnRGIrSq2P7aq5oQzY08JzaujFNLrSBbbWaSR5Lrx2JmBcWkA63NYjxzDbmwd7OKk1EyrPdggX6xJOxhu9JMmXBobQ6qV2RZBrv19yOdSPz6BzyIgAo78ZqG4jUgJLMp1z2mIN/zL7Zq/ukaNL6RjDTaT6U0SmX/wkFeipZzcmdTs6W4zEaesFu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(86362001)(31696002)(2906002)(36756003)(7416002)(31686004)(83380400001)(186003)(53546011)(6506007)(26005)(38100700002)(6486002)(6512007)(36916002)(54906003)(110136005)(66946007)(66556008)(66476007)(8676002)(8936002)(2616005)(4326008)(316002)(41300700001)(478600001)(5660300002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGtxSDRyTldraFQvMkh0RzF0QmhkSW4zNmVnSHBGZERieDF2cHpTcTNVdjA4?=
 =?utf-8?B?VnZkSWd5aGlsdFlTMzhTTFJ0czFJSWNhZUYram1sN2JWREJ0ZlU5UHdwbDJx?=
 =?utf-8?B?SC85L2xCNXloZk12Wk4zVWwxd3NnV0hUOXdodURpUis0TURpdUd2REtIV1JY?=
 =?utf-8?B?cFRxZ21hSExhWVJGTHc4MnVoUDRBYWI4L0dYTjRoM24yUERHNzg1OXVkc05z?=
 =?utf-8?B?QUhWUU9ScVE2NU5FMzlmVzJoWDVpelRrQys3dUVUSThFbzFaamhBOGc1Yk1N?=
 =?utf-8?B?WlhaTmRmaVljaHZNQUFOblBrU2hxUWl0WGd0ZHNyMUROaUw4dTJlYVcyajBI?=
 =?utf-8?B?YUF2cWdVR1NiZXpTSndSUHI5S1RFek5iOVFycEswUzZnK2NlWmNWbTdvekN6?=
 =?utf-8?B?MmZ2ekFQRkNMdUh6QmNJTFg1bDlsdENyTWJSNG1GN1ZuRkFnRTZqNHBVTEJq?=
 =?utf-8?B?V3djUElObFlEVTRJMnN5UFJ6Y1dlQkMxVDdJL1p4WVpUNTBpakY4RUVrbWcy?=
 =?utf-8?B?OXRpYnNNamdBS1FGcVNVTUlzQlFDMFRtSFRENTg4aGtsZXprRG5CSTNYUEZW?=
 =?utf-8?B?UTNCdXk1ZStYYXY3KzMwVVQ2bGdyNmVmQ2F5N0pIOUVSVGxZdnVRa2Z3SEM2?=
 =?utf-8?B?QmVWS0F1eDZ5QUZJREdxYXFIRndmTU1TT25JelA3Z2JJTndQS2lVSnJUSlpF?=
 =?utf-8?B?Mk9BQlNTakd3ZDFvNE1TcGp0ZEVpQ3liVTFWbzVNMTYrdDlKOUhOUllwQ0JV?=
 =?utf-8?B?Yk9iR3lkcnFXOTl1VnFpNmw1R2dzRS80dnFCY2c1amtzbkc5Rmo4SktUa2x6?=
 =?utf-8?B?ejVtaGJ4TE51RFdmNm9NcDRjQzY2Ly8yVHc4ZENjZVZVaTVJQWd4NU1RcWZ3?=
 =?utf-8?B?VTMvMFJsbHhWc0RyYnlaUzNVc2hsbEVqUDl0MHRhdFlPcXF1YVdNN20vbkJP?=
 =?utf-8?B?OGVnNUFtRHFORDhPSEM4NE96VGZDSndaWXJ0dWFTZWVpUGxVSkNFcWRDdUc3?=
 =?utf-8?B?V0VCcGcveC82N1dzV0FITDE3WmQ4bUlSdUtEVGpNaitTT2lkekU2a0QwSStZ?=
 =?utf-8?B?ZVcwL0FnZXF2N0J4U0ZFbFVMeDhWV2VIeFhTL2VRUjlKZmRQb04wMmttWUxr?=
 =?utf-8?B?N1RQeWMxOVhLMHFFdzBGQU9uVVpldURBdUgvV29CeXF3S0FYYVJqZEtMWi9x?=
 =?utf-8?B?WHhvK1lxRG8rZjE2TE1DL3dPWjBKSDh0VmQ5NUpNdmFjK25WVEEwcmNoeGtJ?=
 =?utf-8?B?ZjBpWVdlU1pZMDJvSXBFa29wUE9mREMyMnpQR0hXNy96Q2hiamJNZHRCZko1?=
 =?utf-8?B?WVVSY2hNSjRuSXJaZHVOeWJDMC9VdnZobFh3dmxEOGt2dzRsSTVMNXpxVmVR?=
 =?utf-8?B?WnJ4UnJvYWFvVVRDakhEN21sUHdUc09oN2ZEa1psTHpKMFNzdjFzMHJNSUZV?=
 =?utf-8?B?c3NZOHNXRld5OHB5VU5wSHdwNzRrTjhqV1NLL1pPTHRNa0VJMG4vek44OUJs?=
 =?utf-8?B?VDlYc2lTU2ZNQXJqMlJQM0ZwSlNWakk5a1hJQ1U4d2lmY1hXT0JDOWwxUzBJ?=
 =?utf-8?B?ZXQ4UzZVaEgrd1RuWUNMUG9MMFhsZ3E5NGJ0MFp4WWpicmJkWGszY21mOUJn?=
 =?utf-8?B?Uys3SjQrSHh1dXZBaEZCaVdBN094bHUwL0ZBUTFVcm1zM0hPMGw0czcrbnhj?=
 =?utf-8?B?YUtYWml5WUZ3Y2lnNVFRVk81QjFuMGRKZ0pmUi9HT2ZiZGg1b1VGaUZsK0hH?=
 =?utf-8?B?SHJGZEIwM3BuQTVqcDdCYzVYcU4ycTlLcmNFWWdsR0twaUZGb3JGek5SNDl6?=
 =?utf-8?B?WWY4Mi9XNjFLMzRoNlNrV29CYjc1L25Cb1FGWStKcjhTMkFvMGtUWDJhTU44?=
 =?utf-8?B?YU8zeUFURHlZbS83WFYxRk5VRDJSdkNyR2IxVElxRkNoK1BDTTg4UkF6cExP?=
 =?utf-8?B?U1FwMEwxMjJqY0ZOZ0lTUEZnckJXR1FDeGFDSHNIRmZOMzhQYldRTGFvbHIx?=
 =?utf-8?B?VHZKbzZZTVdBQlFhRFNKWWY4SUhQcEVyMTEwQXhiWkF5azNwTUNZVGR4RS95?=
 =?utf-8?B?bUJqSWZRNGg5dVVlL2kyQ291S3BwTkhoRENTV0k2RStrMDU4eVpYZEdUbkZM?=
 =?utf-8?Q?jltxDoB9Br95j7OjW+A74nMT2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZFdxREZTME9tS3dqeUtBUEVlYm9MRC9rYVEzY0ozRXhERUJyY0ZEemtDMUZh?=
 =?utf-8?B?elduSE1aay9lR25Ta2hJMjhzcVRoWTd2L1BNNWlSVFhSRFN4YjNQYTNjcUIv?=
 =?utf-8?B?eE4xMkZkNFFkbVZRMmYwaGQ4ZjNJOTB3RWlKdVFEdm9CbnNuekhKY1owbmRL?=
 =?utf-8?B?ditPUnlJU2JPcnY0VFRtbzZEaFhrQXV6VG5ocWpFV2x5emIwMkI5czRBU3Y1?=
 =?utf-8?B?QTNrNXF6MFNyQllTTERqZ2dldFliWk0xL2VzNHl2NFBmRjA2c0NQYTVvR1Q5?=
 =?utf-8?B?VGVQdTV1aXVHbTdVNFJoaW1IM1dlTGcxSlQ5eEYraFRJS25CbFFuSXlBUEg3?=
 =?utf-8?B?L1cvZ2hvMlVHMXJ0UFdVbkdHcWRVeHgyUGRvYXF4R1pINVlodjdWaGJ1TUJB?=
 =?utf-8?B?UzJvNldzYUMyc2VEUys5Q05GdUZoMU9rWitOcFBwT010MzR1NEFpa25hRy96?=
 =?utf-8?B?WEZLbWMxeU1TUmFaZE15RTMwSFUvS21GWHJUMjhzd0tKbEtkcHNHNHd0bDZK?=
 =?utf-8?B?TVhlSW9XMnVLbVJvMDdRMjdORHl5YVFHemdXbnZHNmJrTWlBYlQ4eU5wUUVE?=
 =?utf-8?B?bHFpd2V5NnVsUXI2am9SemtqYy9ENE9PQ2pxYkovZ0VwRW5sWU4vRFk2eXpW?=
 =?utf-8?B?NjU5dEtaWGRrU0N4VVVEMGhrQkFGemZJcGY2TnpSUWVYa2ZSM3o2d3ZaeWJi?=
 =?utf-8?B?Z3J5aWM4dkJWd0pxVHRiWnhVTnd5TU8wSkxnWUhIY1F6Z2piL2pGcEUxVTUv?=
 =?utf-8?B?dXN1TjNCM0N5UU9hVGRGZFBZNTRWWU8zTnFwOHd3aFBjOUFkS2Zob3ZkYXRC?=
 =?utf-8?B?UHlHcnpTdUh0NTJDTDVQck5yNmV5WnF1dWR6a0E4ZjZqbHNlVG43SVFtZnJL?=
 =?utf-8?B?WXd6RWJjSUswYzVYWXBDM0lBNnkrSGJBUTdXWk5DQjR2N21BeFhPVkY5QzdR?=
 =?utf-8?B?TnYrUnpmTjFUTDVCam5hTnpNdkw4RGt0eDVESnd6MWpFcUErc1BjK29QMExK?=
 =?utf-8?B?NjQxeVljRGYwcW1pS2ZFSXltb0J4cllSK1kwdGJMdlpKUWlRLytmK010cjI0?=
 =?utf-8?B?R0pxRC9UaFlBUGM0eHNuSTNPR2lYdDZjL2FsRnRCZzkxM2R6cHQwS2xiTW1B?=
 =?utf-8?B?ZFdOcnJ4RU9QbVFLaEFhRUdIMDlSMTFDY3RXUmlOY1czWExJaml0UkdiOTgr?=
 =?utf-8?B?b09sTC9kTlREbU9RdHRvVmZiSnkyYUoybUh0UkxOUUdJQWZ0b1pXRWlxbU4r?=
 =?utf-8?B?TXhPa3lGL01GT0hPb0s2YjZETEFRblMzcVpTWG5FTG91TG1VR0l2c0crWmlW?=
 =?utf-8?B?bHRTTTdkckhQNG9KSFpYaUJXRkUrNU1ZS0djWFhYRkYvNzdrMjZDOXo2anJw?=
 =?utf-8?B?MkdUR1MxUjVWYngvMklUdCs4UjdMenE5NktOdFRsTURYMjd6N1BaTEVhMnht?=
 =?utf-8?B?VEtYNUx6RjNyZHA3OWNaN1IvVDl4Z3ZmMytxVXloeTRrb1kxQjQyOVVveVZQ?=
 =?utf-8?Q?iB8hbQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa118bc0-c804-4a1a-6a07-08db8cf343a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 09:41:04.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM2Vv14q/I8fWsNyvbc/GDgDNleoEcdrJBellApx2Ze+3rKJyZF3T3fGPlGsSYVikpHFvavlvQyo0eYDg2eEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250083
X-Proofpoint-ORIG-GUID: FbCFMdzLu2akn7002D7bXKsHO0QHK7Eq
X-Proofpoint-GUID: FbCFMdzLu2akn7002D7bXKsHO0QHK7Eq
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 09:21, Jing Zhang wrote:
> The usual event descriptions are "event=xxx" or "config=xxx", while the
> event descriptions of CMN are "type=xxx, eventid=xxx" or more complex.
> 
> $cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_cache_fill
> type=0x5,eventid=0x3
> 
> When adding aliases for events described as "event=xxx" or "config=xxx",
> EventCode or ConfigCode can be used in the JSON files to describe the
> events. But "eventid=xxx, type=xxx" cannot be supported at present.
> 
> If EventCode and ConfigCode is not added in the alias JSON file, the
> event description will add "event=0" by default. So, even if the event
> field is added to supplement "eventid=xxx" and "type=xxx", the final
> parsing result will be "event=0, eventid=xxx, type=xxx".
> 
> Therefore, when EventCode and ConfigCode are missing in JSON, "event=0" is
> no longer added by default. EventidCode and Type are added to the event
> field, and ConfigCode is moved into the event field.

What does "ConfigCode is moved into the event field" mean?

> 

There should be perf tool self-tests cases for this, see 
tests/pmu-events.c and tests/parse-events.c, like "umask" is tested

> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   tools/perf/pmu-events/jevents.py | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 2bcd07c..79c3cfa 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -259,12 +259,6 @@ class JsonEvent:
>         }
>         return table[unit] if unit in table else f'uncore_{unit.lower()}'

