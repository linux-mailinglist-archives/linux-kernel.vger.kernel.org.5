Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62576FF39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHDLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHDLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:10:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E818EA;
        Fri,  4 Aug 2023 04:10:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373LDodk021497;
        Fri, 4 Aug 2023 11:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=s7p9rKK2bh9kHLCEfv52+kAWZetPv9hiLW4n+iAHNnQ=;
 b=FK9vC29UTpWEzChxpRkwHPDnrfL5BmKUwRenDgw7Zge2C51GYrk+F9S0S8FJgef3V3Ks
 EryoWm4h1gIRhBIiIgqdupPiwqDmWhJEPTuDlTZMBDWerdYQFOWnvyuXQjcvkRoL49rc
 /n07Anph5m9/Fr8OJwTOaSZUMTaMwNxjTIw2+nho2MRl77Sq5FJ2Xrs12PC1QyGvFpaR
 zYVvP3ypnoBUx/wd6bQBMiItToVdEItVA/My/FWhF5yUSZMK/0mp9buNEAoAtS7glMPo
 R0x1Lu7kKXp/55nYO26DVeGpAwJrfeaRFczDgWKuCCMnhKPhc1sAMeFhZ4xIoHbQUZQF Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbkjnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 11:10:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374B2PV3011554;
        Fri, 4 Aug 2023 11:09:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2rmrus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 11:09:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrpkytIuERwVWuMwmD7Yicp//Ysle9nsB2rv7I1zmcqBihFS4XtPl11jGEdmn94N5ZP79PAokOxlEEzvGPu9jdM6mhwb3g7ndlkKa6B8dC9lTIRJSTvhzF1lBLItO9uqsAwnMQobfXPwMWQ6KmeFZF8s+AlPZTCRSgEJHaP7ZHU2bjfJuefSFvdYiEUoXgmvpWHywQmAp6eITjsVXQAOeXdYgn5wsHNhcja0+MRaFlepYMeJuwZKEzrpnPq2KamAsp4V3j6QoP2JSUJM1t5gdrngNHyYWVVQpW/eDFmxPGt7s6G3bpBod9GHJqCsDPDwCWZY6p95HM+HMzdrmEcpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7p9rKK2bh9kHLCEfv52+kAWZetPv9hiLW4n+iAHNnQ=;
 b=S9QSgbYArb8g923xOZKmpjvVnhp47TNEy0wdKBCJuxx6pLvDy5IOMLcXtaM/Kvh+fMlzVkRbzvl/fJTFQEJgZdmmfhK2TZuW6BOTu/PggaB61aKTivG1gdL/6VewjrMNJ0bGqGAFkM3VGjRiiZ8xj/KFQm/q66NnYuX/Q2c1xniU88r4rT62nwSNbHBZLdisLUJE13hyGAcodIDIJauj5d4R7AkPSLEiN7QeFCGLgIJAvznruFl7JOnorygKorPwznphaA8+mt8XrCcAVFbYjQMTUcdCJraSxEiCbDGykakfGEVx5tzsbSb8pOyuvkaPUASsqnkDTvjWuHtNn0gnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7p9rKK2bh9kHLCEfv52+kAWZetPv9hiLW4n+iAHNnQ=;
 b=rTb7spnvs0oeI/UpLQQOe6SQiILoTeKa2XioUX6iK2D85TQUU1JXYXjQrWKWxYT16xLI+S0w887yEs5QX16rtrpfqO8TV6qpLRzUG5TyCn7446tN7F+r2cmj8irH+C+sUEEag3lbNdfGZQH0Tb4mFwH7aOeGuKkH2RqSG2Y3IAM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 11:09:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 11:09:41 +0000
Message-ID: <ccce391b-da5e-584c-9c56-1de754df8362@oracle.com>
Date:   Fri, 4 Aug 2023 12:09:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] perf vendor events arm64: Add AmpereOne metrics
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
 <20230803211331.140553-4-ilkka@os.amperecomputing.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230803211331.140553-4-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e840881-7122-41e8-5e40-08db94db4d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBHmCLZEnJlmJI9jhnTzbySWMvt2ztD3b8/hbYmu2CldCDnlCcJa9x7T3fBzIGEIS4ecVWSW4YFG95pIXJutNIkYCNvoD//SamuCml3Vfw76l3xUFDPVe5ExGqxPeQ1nGXCHEYxKN9KQ4q/rZ61mG17DnG0R/Kv6Ow+w/JMiw5S9iM7Vqx/DlbrHPp/Yh3nnr9E45y/Bmc4fzcuYQY/qK1a0SOyXADThLjG8B3C86zAtZLhftZ1soAZzrQHUAetaMDkMak9Wl+PrEhFCjYXo7gCeqfC7WBD8QP4sh1mFX6hYJJP6DGFln4EUH4U8j6kRFBBdjYbdWWUXG3MWBkP4xBNjEg7IKpYHC9EVK35Z+gctTxtJA92qClPhR0dPES5laBllXdE41V0+BWX+wqrptqCJ1qwRTgTOvn3oLN59Cu73DaRhZmd1AumiI2kzxVhgYg11pyEG94lOFnlj/HFGdeXFl0ELV8FlOtEEnUkA/CNty6923Wkca3wxGFOOgjP0CK3oXh/yK8ia/LShAG8fcBMOG0aSoQ+Tj6s4xWqJ4opCk9gjaXxEfyQbW/44LTc1R9CLquWavYTnG21mDqYnjFOC6u+mGUpt6EJVdZB6C7KWmW5zzIyn26wrzd0K/op3ISIq55dCHkPRGRFg7AOjTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(53546011)(6506007)(107886003)(86362001)(26005)(558084003)(2616005)(31696002)(38100700002)(316002)(6512007)(6666004)(110136005)(36916002)(478600001)(6486002)(54906003)(36756003)(4326008)(31686004)(2906002)(66476007)(5660300002)(66946007)(66556008)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDJZZy81VlpKVkFrUEtSV0RpblI5ZzJhaVlmd3RMOUpoczZJTFdLbVJnT29Z?=
 =?utf-8?B?TGhwQmkyNlNJN3VEZGJCTmFrK3ZJb3FvZnV6dnBERVJ2RVprQlNSQmlvMFJm?=
 =?utf-8?B?dmYrcFRTUzNtclNEMWdsV2x0R3l1ay80bEpVdzk1Y1g2RjlSd1l5MlhTSHor?=
 =?utf-8?B?ZHZJcGN0QTlqYnRGa1RwcGllSitrMFV4aWxPUm9VeGswR2tON2xzWFpkZlpP?=
 =?utf-8?B?M1ArRUJwZU1rakp5cVArRjA0NHVsTmQxUFhWb0FKbjNHdHZtS1didHdtTkJL?=
 =?utf-8?B?T2tVVE5qajh5cXNZRXBERzBDVzFEOUd3cTZ1SS9SY2lSQTlCaUNHcUpYNHFF?=
 =?utf-8?B?U1AyWnp6bFNqRlh5Wi83bDVXcWtGaFA0L1BobEE4RHo1T2RCeG90R0wxd1dK?=
 =?utf-8?B?Qko0eGtqRGlmOVFZVTFqVGcrRFVkY2lUeGtwYkdYOFBjbUFFQWpFRmtoeFpp?=
 =?utf-8?B?RGtTZTlXcnBMSlI0eWJBVWhKdGRsRFQxam5YM1pkc0RTVnhTMjhaN0ZhcytJ?=
 =?utf-8?B?Uyt2MmNiTi92NW0ya2lQeXVndGdoK09SRGVMbHdJTnI2eFBpNk9RYXhuWFFG?=
 =?utf-8?B?ZlRlNExJZFdpNFo4WEhEaXNiek1EdGx0OXp2cUdQeTEwc1ZqOE5EMGM1WHhN?=
 =?utf-8?B?ZU02bzZ2L2thTVFTL2d2SVdONmJWbDlBSkhSTWtlajV1Mmpra3dHQWFPK0hO?=
 =?utf-8?B?YVJYNHBNZzZWUk1ybzIzaTFUOTBwSmFtVGxPUXAyaVF3WXVLbWZIWWQ4cFVM?=
 =?utf-8?B?VVV3dmNYaEpoWHNmbzdiSy9nUXNFRU9TcGxFVnM3SXVZRis2dFUxV3ViVWRE?=
 =?utf-8?B?L0x2dTFYL0kzdWNHK2NyVE9VM1JPd1BJcGI5R245dUE0QzFMYzJSRnBvTzkz?=
 =?utf-8?B?U1JMUVBQcS9XekZVN2VZUldRR2M5QWZtWjdWMVJVR3dDWk14WDV2SHdGbmc3?=
 =?utf-8?B?NGRoS2hrQ2VBcHBlWXE1cGZyVGZhdks1RWRXckd4Mnc1dUJrbTlHMDltTzRw?=
 =?utf-8?B?eko3Z3FhTmlrSlZnM2s4WDBtb1RGQkwzRFNWQjU0ek1SZlppUUdmV3ZTaVZK?=
 =?utf-8?B?SFU3ZWorMUd6MW1pelM5Q2hPMEQ5NE5nWE9hajNMNDdhYW0wRmdEb25IS0Ey?=
 =?utf-8?B?WHdpWExpWlQvQm9sNjRRdjJEb25JN2ttak1iN1dGVzBQZzhOL1lLR2phSEpq?=
 =?utf-8?B?eTZ5M0IxRkEyc0FOWC9yaHFiRkhQWU90aExablY2VHU5NldVRnNJeWtPaFJJ?=
 =?utf-8?B?LzFkQ21CV1FXMlJyOFpqSEgwaDYyb3VOSjlWa2szWWZOQWJLYVF1YThJZjlV?=
 =?utf-8?B?WEZzSUlMdE1TaDdqaGJtQzlHTE9UQ2Fobzh1NzhBRDVYaWJIVjdkRzYxZ3Bw?=
 =?utf-8?B?Rkd6M1QvaEtzcUdQQ0hJTlk4Tnc0bE5idUZPWVN4MENMaWMwdC9XVkZQeTJX?=
 =?utf-8?B?NHdlR0JJdHpYYmtnYWlYWVNNNkxuTlA1MEZJOW56VlZSTmx6Vm5WSUNNbFcr?=
 =?utf-8?B?SUVPSTR3Syt2QzhlcCszb09PWlFkMEFMZ1B2SmNrMlNSWncrTkFrK24wb2Fh?=
 =?utf-8?B?SDFVdFlqNVU0Q1NPSmZTbTJZczhOTm1hSWdDdG5xb0R1TVl0WE5GbEVrYTZz?=
 =?utf-8?B?QW9aMWlHcjFabU5wU2prK3p6SitNOFFSeUJjMDFHYi84NWlnaVlzcjR6VCtr?=
 =?utf-8?B?aGtRWEhpYU1OOXdPV2pISDl5VmRSZHNjclZLdytRRmIwVjVydXp5UXNPTmxw?=
 =?utf-8?B?NkhnZFYwc2lJRlRnbVlnK1lITitFSFJ2SkVVSWdSOUxHUkZYcmc3djRYMU9m?=
 =?utf-8?B?bk12TWhyaWhQS2dMc3BxYy9iWDhGN2lMc090bVdGdWdwUUNBZ3hKYnI0OGcy?=
 =?utf-8?B?VlU3VVIvbmw2OWdQV0R5SFBCTFpiR3N6ZTlVL0Q0TnorQ2JpZ2JIcWg2elE4?=
 =?utf-8?B?UWtoU1FNRnc3T1JpeGcrRXRjbXRDK0U2SmE0R2I1SWJXcmw1VDhqSUUxSFo5?=
 =?utf-8?B?MHA0YmpJQnRZYldUOWhYWis0OXlSQm9HTE42MEorai9TL2E1MDZtYVEvYzBa?=
 =?utf-8?B?YUhhNWFtVmNFN3hLNmdCcW1zUkpkMUhNMmFPTzZpdksvL3FNN3FqdW9LQXd4?=
 =?utf-8?Q?PZVnBMG9ppoHKIp62tTLnyNuJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0gzczBEa1lIdnBlcGVVenVRMDhOcjNYK1piNnlJclF0NmVaMWhVcG82UU1w?=
 =?utf-8?B?MzlIeHNSWkZjNGJzS2luaTNBNFczL2w5SlN6ZEhzaHk2cWY3L0lVcG05b0pJ?=
 =?utf-8?B?M3hyU0NpQ3lUUGt3SmFYd25CVjZiRVB2SFcvZ09RaGxDS3dZSFA2ampVQUJD?=
 =?utf-8?B?SXM0NDFsbk9sdjJtaklqNWJsaE54TDFJZTgrV0dETEhBM2trYXN2VENLZ0h0?=
 =?utf-8?B?VWYrWFFaay9ERHE0NHllQlVITWJOeWtucTZzMGdBRGptdlk2dk5NdnpBWm1x?=
 =?utf-8?B?Z3NnUnQxQ2FReFRjUjkwMmNVWHJ3RW9jVlRCSk9Ba0JTMTRwYjZFaUJCNmxx?=
 =?utf-8?B?RDc5Tm5hMGg3Y29pZjRiSGd4UGMxT2Nra1FpbXZWenVaMThWRkdCTy90WGg5?=
 =?utf-8?B?QnNBOWNaR05EaDlvK1pMcGo5MFZwNkxFM2JQN2R2T3BoVFNxSFYvcDBtU1dV?=
 =?utf-8?B?aEVMSkU0ZEZLNm5ubHlMZ2diR2J4eUg0clNkbkRUc1Zaemh2UWw0cFRuVEkz?=
 =?utf-8?B?b0RUSmM4U0lIWmFmVnZ0L014MDA0K09TaDAxazFBdEthSitrM2JKOVFZcGxh?=
 =?utf-8?B?anV2Y0p5TGFIRDQzVlM0c0U4Qnc4Y1czdnhZbFpZWFNaa09uQkZIRWZQU3pW?=
 =?utf-8?B?OXhhU3YrUXAyRzJOVG5qTWVib2J4cWFsRU9LYlV3YjZ4aGhkWDRVSmlqS3hC?=
 =?utf-8?B?WWdBSUVmKzVEZnlIaEovSFc3ek5vYUlUcW0yZStrZ2dkUkI2RHNLeTBRNE5K?=
 =?utf-8?B?VkE2S0NwZCtHdnZSRGgzSE54bG14RHk3TFE4RUJPcURlSnVMOGlWclJydmow?=
 =?utf-8?B?RDdxVVJJbXBocjRrNVFHN3hscXJGTWQ4blB3Z28xUVhMaXpBT1dKWWVjb1ZY?=
 =?utf-8?B?MUcwaUMvOUxjeTl6WFhSWGJ6MnU4K2lDYXVDdmxMdUZYeWdncTVVMG5ibTlG?=
 =?utf-8?B?NXcrcG5EMUtORFdsVm82VEZPZklFQ2RTRGlzenI4dGNNNkY4aHp0eTVMdmlU?=
 =?utf-8?B?S2Z1MEhLVEJ3WlIxMHBXNmV3MS9OU3RTQWtBTFdwTTB6MlM5a0JXU1g5UkFQ?=
 =?utf-8?B?NGNlakNzVm5oM3JFTWVHL0tQSlpKUXZYOFhpMFNLNmR2ZE9VQzlvd1A3Mits?=
 =?utf-8?B?TVVxeDM0SFBtNExqMC9GOFN4TTRPT3B4K0kraWZURVFrcDVCZStMMmtFNlEx?=
 =?utf-8?B?aVN0Njd2bGE2MlRLQWRIcjJFLzJNM1NBRG12VmlXSlNKMHlJRThxeGJwKzh5?=
 =?utf-8?B?SzdwMUI2ZUNjblIzNDlpOHpyc2Q0TkRqLzRRcktOYVp0WThMbkgrazhJNTMy?=
 =?utf-8?B?aTU3cFd1VUpqUEdzOWN5WTM5Vi83RVA0VW1EUUlqUjlLNTFZN3p0UGJrRUxo?=
 =?utf-8?B?bFVpWEszL2p4R0J5SmNocG9nbnY2akl5UlAzK3NVcWJOMEd2WmZqRWIxRER3?=
 =?utf-8?B?bGwxL0xQU05EZEdBVGFLbFJHWFBsTk5CcTN0VTFrVkJhZFB5MzF0bjJrVWF0?=
 =?utf-8?Q?P5sp5+83dekBTtl+6/wav85jnxI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e840881-7122-41e8-5e40-08db94db4d0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 11:09:41.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUp6zqaD2VTO72c/HB9cxCLY+VZ904BCRxqPAnHdwIMQGBhWcIsvr3+XwefkWmm8XYLtZ2NRwop1j/MQOqEN8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040098
X-Proofpoint-ORIG-GUID: XBOvgNMDXZTidVTvaDqO81GCDAPE9teT
X-Proofpoint-GUID: XBOvgNMDXZTidVTvaDqO81GCDAPE9teT
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
> This patch adds AmpereOne metrics. The metrics also work around
> the issue related to some of the events.

Just curious, are these events/metrics described in some 
publically-available document?

> 

