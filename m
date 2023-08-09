Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBFF7761CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjHINzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjHINy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:54:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382092110;
        Wed,  9 Aug 2023 06:54:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379CxYFQ016709;
        Wed, 9 Aug 2023 13:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uVqvPJ3jC/VNExBOwA9B0cLLyE7vMv1tifsGLky94Ns=;
 b=Y+8NVZ7ZvsXkU7c2Hsedo73MkUsB94u05zc6/TG5pIcAEcpetyEk8t+ohVSykJTdbBXu
 DvMbhkBLuaNg8QPx+fjqlmGDjsEQN2mRH3O9cRrBcxPMA7fpJcxykaj7AvgyJAX1Fb1p
 VJ4o5LmkaNxLDMyQ5F5CD+PH+4mNznuXZIbNjpJbneU+Fe6oe5iJJSrRLTQXf8OSeVoh
 DMq1OE3hU9t7VK0s0ZcqZUOmHbvh2ljRV9vjnUPVm19u0Aq89EJVXmZio87PqJIbJqi8
 MytsgeXTyo73cpPDwXMxXNY26MdvAV0P0GEURGHHle3hfxQK4Ag8OnYjVcfr1AmGvCYJ WA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9cuernky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 13:54:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379CvoZM021499;
        Wed, 9 Aug 2023 13:54:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv7arw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 13:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiqIxTsCdFTkHKvEOu5P8ZCs1kwJUgipQhZWbwwaFdVH8rXJImjfxr17r8dHUeIj8YM9IqgbDxAJRb/CRd5E5NHiMngCIxJ7HQKYXJVSW52gz+iH2fYZteNO+I3S+chKpYKhhvcv03+M+cdzQPHFH0QHHiPDCqBsM0GrVFY773bGA+WJjszFqCjk8kylSHpTW5IdspwPkUi5xfTdWFOu3Y5G1C1BlFHNgb/7IOy52OhrGM4+GJtFaNxHRArTibYYnQPh1TE40nzwhiBw4ChBO1OX/B19+MFjriOsKOgB5syPflqHr2pjNutq0sfvz5P1em1Q23EHWRleCK/15EwUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVqvPJ3jC/VNExBOwA9B0cLLyE7vMv1tifsGLky94Ns=;
 b=N3ZehYMcJdokhxXzoTSKimruGDpcaJHvXemDBW67GUkKkli9NPPy5aqAswDX74oQBYwQf+vJJHBT1Q0XRq4sb5cdVrzNI0EH2oLdxgi2TTwiDPIZvPsVvKlLKAF1W4BTJC0pzErzB1Bp0nuPNjHAm8IIGpDyXmTzvLAl3j56obLQ+juKuh7QKtZJ/6V3dfWuf/YsIhxqHMujc4mhvloOKd5v9xabuytgf9vQ71Q3LJ5//2feCwxpkKeLVhsWmmm1Q/GqWISEtE0JiuavPcczOVbA4bn8fOSCuqAzDn5nWUWuKklAeZA0oeHEkolkEsF2ofqS3xceQj9WOfRadLZjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVqvPJ3jC/VNExBOwA9B0cLLyE7vMv1tifsGLky94Ns=;
 b=S420eOG4tyGfmSmCPKi8T7/O2S+HKLFmIHNr4EbwrEOyE2bZTZyvnaSFk6/4H8/odkeGMnNQyQkAQqPH/mTHnUdbs/nllQVHx2wvuTsUqxAqN+WdakZRoL2hgz+Nea5eTbD/55vxI742omJ21zMFPuE9x8EBVNlz0ReIRPqnsr0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 13:54:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 13:54:20 +0000
Message-ID: <80e089f6-12ab-b33c-d299-3f762e3a8d4f@oracle.com>
Date:   Wed, 9 Aug 2023 14:54:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
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
 <20230807142138.288713-6-james.clark@arm.com>
 <6b3d8f28-9a38-d544-e396-706022f2e5f5@oracle.com>
 <a4b93320-cf5d-9622-77fe-f51e1ec7f75b@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a4b93320-cf5d-9622-77fe-f51e1ec7f75b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0395.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 95daf4f4-24bf-4430-95ee-08db98e0217b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2XZUwL5AWhxyuNdr8EqCT7tvEOkai1sk/sJWVh4Oqk60vlxqPnG2mc9y/P8smJXDgJg0moP8S7f7WQCUAk7a3upCcqhrMCCsOViVvEnrIRlgYSwm7IJ5g2rCMW8DtWlj/1k9bnCVvazp17dqUSrkvn7z+8EpUcXS0DjpXIVj2o489qibmQ7xyVEIrfIj7so+nkpikmzVhb1u61C0MZVxpe+jgQbda5gfT5g+UlHNZV4brqcWI0kcg2UAC5UzCbx18KsetsPURoRI4WlfUblO7jjCNVMJc+tppObaLMOvDQgAfWFjCUtkCBXgGCVIMcj8sWYEIk2oGAGgD6gd/oa+Ge4JvJZ+5mUUc3hkrq3Vz6bOmnSB0uTCDfZIEFEuidn+NDXF7NSFaSVm0SfT8NMXgwslghZpwJBLFvy2IVb/h9rgefRLwsKb6/gn/llR7DN+hEZXfvIRUFnfbJQQPLMCR9u+L7vRx7DdkrV4y3L/YgIddd9Sa91HhMmcYINOUU4rDtE8hCQ1ju3i3hY8iyHFLz4PKRC040aHpSv5Mc1IBm290xYo5fiIQuZ4UGzX+7BxfoE4Ht5py+kXba7GJSqaM3wI4dzVLex3POixGTE7TgXM3vIOBO9BSPh+5ddDTvDfMwWqJDfPUNL9qFHxeRQzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(346002)(366004)(1800799006)(451199021)(186006)(2616005)(6666004)(8936002)(86362001)(36916002)(6512007)(31696002)(41300700001)(6486002)(966005)(6506007)(36756003)(26005)(478600001)(53546011)(7416002)(316002)(8676002)(54906003)(38100700002)(5660300002)(2906002)(4326008)(66556008)(66946007)(66476007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWV6aFh2SkU1ckRjUmNlM0lJMkxUOU1PYjE4bUJ2MndlNmxDYWpnckNKbWhQ?=
 =?utf-8?B?NGdaT0l1d3dPTkY1c0dRaVRMd0c5SFdaVkk0bjFsVndhSEVZNzd6K2dBbjla?=
 =?utf-8?B?QWpMZWZYMlB3QS9YL0lKZU9iRzJ4V1ZVcjFvSk9RNzhxY0JyelZBbFhPVmJ4?=
 =?utf-8?B?SmJBTFd6UmpQNm5ub3pUN3J1UlV0dStOWE1UVUwrRGtzWTdGUUtJYzRLQXJ2?=
 =?utf-8?B?MFlMNlF5MGdnU1ZrdVN0Qm5HMktGWjNGWHlHNEdTRWpoVEgxMzRuOXA5enhX?=
 =?utf-8?B?cDJFZGVnTmhTa0NUd2N4THFQdWdxYzB4NFoxUG1qU1h1bUd3ZXh6UmQrYytx?=
 =?utf-8?B?OWZnVzJOZTNWQWc2d3JZRkZ0WFRMeVN0U3hINzlwTmFmdWd4VDdNcndFNjg1?=
 =?utf-8?B?UFBCSHB1VVRMc3FxN0s0VWlSRGYzdTJZM3ZKRFBrK1NTR1p3QS82M05BaHAv?=
 =?utf-8?B?RkZvTDVVb1I4bTg1V1E4RVlCY3lLU0g5M20rRFgrMWVhSDY4ZjFIOHluOC9k?=
 =?utf-8?B?d29DTUhqcUxzTmR4eUxaeDNHcmRnY0pVbDdkdUdMNm1QZ283ZndaRlJncVA5?=
 =?utf-8?B?bitXOElQb3BRNC96WjlVd1Z3NUIvRlhLNHJva0g3cGpZeWZSOTZIdFI0V2RI?=
 =?utf-8?B?RzB0bUQzSzJaMjJ1aHhVNVRhejlScFMvUm80eDF6c2FBWGc3R1RTdnhsRkV1?=
 =?utf-8?B?ODI0S01pWnlDU3JrVWw3WDlDbFNaNk5hRXdseVRYcGoweEVVSGNjQVorRklP?=
 =?utf-8?B?Z0RHVGsvVy85NVJ3OTJEZ25jbTI1UDBRME1ySGlpTTN3YksrM1JudVBiNjZp?=
 =?utf-8?B?WEltaGhDUTZRbHcxTW9Sb1VIck9PQUFMMTNoc1FpTWpFUWp5Yjc2aDdJMTZO?=
 =?utf-8?B?R2VQWWJseWw3RG1OOUlJR0twY0h2dzBCRERneXBlaTVmUUM0MTFDZjU1Y0t2?=
 =?utf-8?B?T0V3UjRBOWlJdE5HQ0FMVldOUTFoOS9YUmQ3YWhmTnk1YnpqUVI5YTB3NEhs?=
 =?utf-8?B?dXVmaWEvVWllSEU1RTdDakhnZGx2VzMzcEx4aCtMVFVBQVJYOE9CcXNXSHlN?=
 =?utf-8?B?bkVYYnNHb1VEWkFscTJXbGFYZVJkKzZWOXhGUHRpKzFrWnowazVrWE9hUktr?=
 =?utf-8?B?WTU1RkZVNms4NzNIK2dlZXFsRGJhSXEzREt4VWdFc1BmYlBiM1ZMWmRCWE9C?=
 =?utf-8?B?VEdlVFIyN2ZDaVc2WGdTSnI3QS9RMi80d1hTK3Y5d2N5NlpadHI0aTR6eG12?=
 =?utf-8?B?dzhQNHVVZEkxS3ZGeDBoVk9DMy90NUdTOG90Q1ROSEUxTEZJSGtMeTd0S09G?=
 =?utf-8?B?Q3YyQm03VUVaTm1RUWh1eXVnM2RxbXJYRFNrWFkxcVJ6Lzlta1d4MTI3UDdM?=
 =?utf-8?B?YnlzRENnd2ltajFSZ1k4cXVwdTFOTU1tcWZYR0ljWXIxUWhCVFR0VC9OQXFN?=
 =?utf-8?B?b1l6M2JQL2J3a2Rrc2VWVm93ZllubVBpSFppcmFEZVQ5VWIzcmRJeEsreVVP?=
 =?utf-8?B?ZmJvTVpqVkxYQU1MTjZDSGxMVjdJcktNYTFaOGpNejF6ZVE3SjcrbVNWMkdk?=
 =?utf-8?B?VVI4eUptTUlrSjlzOWlBMWhpbzc1bE8vYTAxejRiYTk1WjVCWWpwQm1aSHBJ?=
 =?utf-8?B?MUcybU1LZmRjamNvVUR5cm5sRXR4UUhVYUdYaTNacHFOdFF3WTBpRngxdzJC?=
 =?utf-8?B?QTFiWmhPTUVlR3pnUytWYTlGa2xmM2tNMGtmQzcrVmk2K3YyR21mVkpoMU5v?=
 =?utf-8?B?NHNXcmZ1RGF2ajJzMlNVcHE5YW5NY1g1OGliOCtNQU85OFNRTjdJdzJ1aWsv?=
 =?utf-8?B?bE1OOGMrQ3krVWNTREM4NzJxVWlCckljKzFiVVlrcEJDWjN2ZFJsejlnUmdZ?=
 =?utf-8?B?b1VWbGE3eGJjTHAxQzBOOFVXbWRjaWhrQzNaSHVBMUROZW9xUHJhODFtcTlw?=
 =?utf-8?B?TE1pVHFlbjZqbmdSL3l1QnAyK2ZXQ0Y5RzFHT2UxQ1NRMUdIckVrc0dJZjQx?=
 =?utf-8?B?cUdNNjJlWERGOFZEaDFXQXIvOGJFUTRhVHRkN3Iyd1IxTFlibEN0ZCs1dHJH?=
 =?utf-8?B?MUFLbGhFQTZYd1kvenYzK2FzSEtKRzlsWUZsZWQ1QnNMSCt6UmtURlNhWjYx?=
 =?utf-8?Q?NaDKEoO5WbwE8NRJ6P/Fs14KK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cGRvaWdkdU9sQTA1ZkJUeVFKdWhOSHllbmMyVmRveFFFeVFiZGMwbWpxUGVJ?=
 =?utf-8?B?U1psbVBxbjJ1L0pqc1l1THVvZ0xqVXRRL3JzanpEZmtUVmxVTGZXRkswaGxZ?=
 =?utf-8?B?bURxT2VaV0VQbjdIOVNLQk1uUC9sMm9vUjFaNmdQc25DeDVlZGVPeEdZcS9n?=
 =?utf-8?B?dVdzVFFjMEJhOVBMRDJEdGlTYmJ5Z1pjcnRjZ000dWZOTnRranpNZjR2dmxH?=
 =?utf-8?B?NGFadGFtcUdYbzU5T2U3ZkxJRmt4aE91bXBUOFN3cVczUTNiNEZtNmttZHNP?=
 =?utf-8?B?TXBBdmw5QnIwOUZsTUIydnAxQWhZSTZ0aHZpcTRlYmswSE1Ca1dzVkxxUXRu?=
 =?utf-8?B?NXh3UWYwSWxPeENmUTU1Z1pZay93QmR3cE9zOVoxVEx5R1BHUE02Zm1EOWtB?=
 =?utf-8?B?d1R2TkRQTUhxd0NXVEpXeTNzT0hRK1hhTG9TVXBVUitLcGRWZG83NlpQR0JJ?=
 =?utf-8?B?UTdxQUgwdSs2b1U4ekRxeWpXVlRuMzF2RUdIN3U5a3AyOG56OUQ1bG9YbTUv?=
 =?utf-8?B?bEJxbHp0RnVhNUVySmRRcExhc01NOUxneW9iWk9BOUlyNUhYRzJGQkhISVN3?=
 =?utf-8?B?a2tmeGZEbUxxRVhKNjV1NE1CWjFiRXVEV0tzcHVIWm41T3E2eFpUVHVneVpF?=
 =?utf-8?B?YzRvRUZuMXVtd3JMTEhDQmMrSURKa0ViV0JMeXFHRFRoSEpZZVpMZHhRSWZY?=
 =?utf-8?B?aUZ5TG4wN2lJUzhTeElhZDJpTE9ONGc4aUNnV25aazB4cHJhbGxIWkVBS3BN?=
 =?utf-8?B?Q1BCVE94b0l1QlpxWjJFbHZ3MWV2Qk4yQWQvNTNMQzhIUGpwZXZwZG5uNTg0?=
 =?utf-8?B?Q3poUmdWZFA5VmpvS3lDMG9xTVREL0pCbkZZczFaK29kK3VqNmZvcUxJSXNw?=
 =?utf-8?B?djhJdERabGFycTBMU1dpTHNvKzFEN1VmYWp4dDVLdWJVQjI3b09kSkR5UTR2?=
 =?utf-8?B?cm9nQWxnMzNEUHFaV0dqUW1GMURaVjdhZDlJbVdsZmJxR25rNDdkK2ZOVjU5?=
 =?utf-8?B?NXNVcGdtZ3dxWXhTS1hjWlplWWMvN3phNkZTbDJFQWVJakF1eHZTUkJydnFi?=
 =?utf-8?B?UElhQmZVZUNBOU53U1lpaCtkckxocUJ1bExxQ0xqUUdjaGdkdzUwaDVPelVH?=
 =?utf-8?B?SG9rYWNtRDRhVWhVMWtlTGMzbjkzWWQ3dFduakp6OEpRcFgwT0puUmsxUDhS?=
 =?utf-8?B?ZkxRdVdYM0UveFl1eTRldGtJdGdPMmQrTEFtcjJLRjZxY0xBZ2lpcDgydG1N?=
 =?utf-8?B?akFRUFFTMlFTcmcyRlNPekFaZ2hDcUNEcWkyT1E1eFpjamZEUVFrbXpabDVk?=
 =?utf-8?B?M2FkaC85Y1REK2tac1RHblVkS2twYWZlWktrVEQvTEdJcGY4NjJqZWthTGNY?=
 =?utf-8?B?WkhjVUVEZWNMaGpld1NBYXdhWmg0Q1BJUVpQY1phTHltK3l1WXVIODRBNHFZ?=
 =?utf-8?B?NlhsbGdwQXJnQXlTZ0RzbFBPaDVPYVhKM0Rhbk1tV1FHcnh3dzR2dEcvYWxi?=
 =?utf-8?B?RWJhTmVGdVlCbUNQRWJYV25XVkgxQ2N0SzZFOWJGUlZMZmo2MGR2dFdQZ3dk?=
 =?utf-8?B?NXViL0JXOERIZUJjekRKU3pHU0VYWGt4bFdNdkJoRERSeUtlUFhycURJaWIv?=
 =?utf-8?B?RFNWRkgvSkxCb096UUdsdlE2Rk9VRkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95daf4f4-24bf-4430-95ee-08db98e0217b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:54:20.7799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR2MLNxYoItK1wvDcA8xcksSRl4gml2wEojAIDIWy1O8dqdysS5CyzQB2KyYzDsqaMcJRxj8o/q3d7sQRnZHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090123
X-Proofpoint-ORIG-GUID: oI2FQycGmHXLylLI44BXd4LQ_my6mRT8
X-Proofpoint-GUID: oI2FQycGmHXLylLI44BXd4LQ_my6mRT8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 14:06, James Clark wrote:
>> "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if
>> (cpuid_less_than(410fd493)) else (stall_slot - cpu_cycles)) / (#slots *
>> cpu_cycles))"
>>
>> I'm currently figuring out how cpuid_less_than() would be implemented
>> (I'm no great python wrangler), but it would be along the lines of what
>> Ian added for "has_event" in
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@google.com/__;!!ACWV5N9M2RV99hQ!PlOppEWtIj9jDW2Zlon0zRZVpzPTzPvm5Ho5NnRIN0vD78iFcEzMEAtsrW_MrRPiW84XhWpbhc3seQcmLu-BfQ$  
>>
>> Thanks,
>> John
> Yeah it looks like it could be done that way. Also, the way I added it,
> it doesn't have access to the PMU type, it just does a generic
> pmu__find_core_pmu() so won't work very well for heterogeneous systems.

I haven't been keeping a close eye on the hybrid PMU support, but AFAIK 
metrics for hybrid arm64 system, i.e. bL, aren't supported - maybe that 
has changed. The gating for bL support was in pmu__find_core_pmu() 
returning NULL for a hybrid system.

> 
> If we're going to do a deeper modification of the expression parser like
> with has_event() it might be possible to pass in the actual CPU ID that
> the metric is running on which would be better.
> 
> I'll have a look.

Thanks. I was playing with this yesterday, but I was making slow 
progress. I was essentially following the has_event example, but the 
argument type causes an issue, in that has_event expected an event name, 
while we want to pass a hex string.

If you could check this then that would be great.

Thanks,
John

