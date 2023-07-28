Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A776668D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjG1IMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjG1ILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:11:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BE3598;
        Fri, 28 Jul 2023 01:11:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1b3Ja002137;
        Fri, 28 Jul 2023 08:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=c6WjCQ4wS/daarjmRUjq57VmuOMS/QwKOlJDxOie9vs=;
 b=VytpUhsGnZuDU3zptTjBep6B5s/KcBgZSQiBgiuWK6EJwtU0kzc0CrFIjji8jGF9Jhkl
 8Wqi1wm9Ak9ExCvaZvAcwDFNIi73UlS2Bci2MyZAJ6B5ipfwrK63/pJsntTK9lqLH9hv
 Uc5iKNuBs0oDrQ00QEEmj2HcMEH9EjFd7awHms2OZ7UntPHe20Rg7OnhYZ5u55azWEs+
 C7BsCJcRTUNuFkvo6KR76uZiWSdUZkp7zs6BRBdsL2L2FCin6sMB2sei0Lm1B1q5Czk8
 ogTiCLCuTeBrS9JxRElpyKao7TFVMhXrXmBrVNRrjZc/AyIHtVAOOFc368sBs9iJHfNA eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061cbfvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:11:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S6Jduf030405;
        Fri, 28 Jul 2023 08:11:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jf1btc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5C6rJ9zzUTk8slLVvD6INyTkHPtVAk+tMS3ompKZ9GeTE/cYivKsRBfrQ2pOF1xmAoQj5gZkCWtEAZDy7G9o0J5HhCfEJy5f0SiS1TwWIQpL/oEiM2BoWOZIrDdRjDgHaFt1SDDhYVEJdRuvZ9boC+mVktxl4vbekwhhv48igHhTV0Z+CbeM3vxf88SbTkHdVYqQZx+Idpgi3Pj5447dgbkxRZ+UMvMgM23cadKTHHUWuVKXnDsyQ2s8vCvJjKx5qey21gyVSUjydJJeUKG/5axIOpG+qW6LHmAOhXVogUBgiaqxlmOZ5VVSCFM1qE2OP2wLmkvD/DdpXfeOVLBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6WjCQ4wS/daarjmRUjq57VmuOMS/QwKOlJDxOie9vs=;
 b=T/Vth2UpcChXU0Q/czJFYEKErYiPPUVbia0xKZNec9WZ6ER9ugr2vWjI0HTCUtM6d5DFJ8334TUgtJZLtoYY6dB7XoJSPWBs5g/sNAwpFB5+SnUF95HNxnAnOXWSJ4ERWhEvLheCxqNkJGreGslddODNRVas1jeYidzj3OKnZujArSfvCYxgUliFX8JHOlkvQUX2EBBTYIJiInli3phiHS/X4op0oBsrqM/unxuRUC549E8mbe3dQ7ihKPF53Q2gvEOnI5VW3ZfBAN0mSKPlYlAxnMBXFnLKSeTD6FR22jIQyObg9TeY+v/KVwzmrr2w4/Jh0G5vqggxwIh+XnINnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6WjCQ4wS/daarjmRUjq57VmuOMS/QwKOlJDxOie9vs=;
 b=B9LVoyAT8NyxG7Q9f+v0V+lkoE9use7TGVbjoYz1e3qB8BgsYLOiBzGwz6C4Ukhm/5gQT2ZODIZd7I+HYALvv6vMO/QhMiibzKc1Ctv0iH+2rPD9CefKjafGR0nwkMagrc3s5VHYCfqlVKkFLsphWO6qU1wL+ipcN9G2mHSPZqM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:11:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:11:04 +0000
Message-ID: <268b3891-be4b-5f63-eff3-7b6d83e906e9@oracle.com>
Date:   Fri, 28 Jul 2023 09:11:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] perf metric: Event "Compat" value supports
 matching multiple identifiers
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 35247caa-85a1-4aeb-4744-08db8f423065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewfZKcKAm6hLeWcdIZdui08l+QjUm7Z1TKcoBk3QGDEDBq8s2BmYk6vUKt6nYmwi9qD2WyblxAMQ0hVEhuqCWYkzWJ5CxKG5pPGMZFrurknfGZLZk9j/bg7TznieW106xzV21fROflxZJl8T/xJATVTiORe9TyjRAInKHuOKO6QFoEA2354kA1ybRUAHO8XNfvBLheor1Z7K5jpmDtw97Gw/RXXWE7NbpR0kEUD2d9fdCdmK6AMoSjOwGLFmGIj5UjC4rGSnnTC190h4Q4hX/ge80egFr7t2550ZAXF30KzqvnwqgAZ6vqeyQveZu49HaW/DMJ/mBwiIcLla5VVmM9w/oJU82pneMUR30l054XtPISmTNSPhpnPBj69rkjUz70VMFrXpGrH0fzalvLu6qwwmK+WwVwwfhz3mecnZ+ozxOl/UvDIO2+WMQ4DTuBPsj/WJk5annuO+rnFohN9LnWwVCzFx21/df75eAQoLTDJTSEHuV59+WAArLVAtyf3KS6ZlFm3iCgzwUKgqtKso66G0fWxWnzMjLypLMuvqDsXw+r1bS9/8rdF5aS0DIKeTIzrKAX4FLt65ph1j++Tv0ijEdfclMiHu1yGMKh1FXCWnPi9/0oHl8ibU8Nu05QwtZzRvgcoFsNES9uZh3LYxxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(54906003)(110136005)(6666004)(36916002)(38100700002)(2906002)(6486002)(478600001)(7416002)(316002)(8936002)(8676002)(5660300002)(41300700001)(36756003)(4326008)(66476007)(66556008)(53546011)(66946007)(31696002)(186003)(86362001)(6506007)(26005)(2616005)(31686004)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NBSkJiSHpxWVVPcVpqUEVDd2s4RWt1M09BTHFaN2xaaTNsVnZXUHNiMVhh?=
 =?utf-8?B?MU1JamVXZFluYzhxUlhnSlpWUmIzQVFTd2RPeFI3c09qdFlyR2xOTWpGaWpZ?=
 =?utf-8?B?czRsSzJUbzhaQ3BNLzBJRjliZVN2OFg4NCtaU25YT0ZZRW8ySUJaaWlUTkk0?=
 =?utf-8?B?UDdvVDE5U2R3dk12c0lwQzh0WlR1cWpCY3BCTWF5b2NnVDV0MzZUU09NdHhT?=
 =?utf-8?B?SHpUWFhmaE5lQkY0RmtpZy82SmR3RUlHaDBrT2RWaXp4aDFqMjdvSjR1RHpm?=
 =?utf-8?B?YUx5QzJiSjhXOGR0M2pRNnFKeUQxbVdFaEJQU2habmZEUFgwYmV4UFRxMytk?=
 =?utf-8?B?aHUxOExhVm5mZG14RnV6THZSMFdieXV3NHJPNExnQTJMdmhQM1UxRXBpUW41?=
 =?utf-8?B?WTBZSUdCZHpHYnpqbGVuVkttUW9way90YnFSb1dPZURoZDZyN0RzeFgrWTZW?=
 =?utf-8?B?cDYxS3gzRkhTSmpKRmRHMzVrUDJBRVozcXFDZTdrWlhLZ1l0Y2M3U3U3bGhB?=
 =?utf-8?B?WTVHWkRaTjFlQ0IwbEFqdzdka0t2N2VvL1BjQlhBU3VHQ3I1NGRnR0tsMHl2?=
 =?utf-8?B?d1lJUjgzWFBPTTI3Q2ppZUJRR0YvRjl5cHNrT1AzODQ4WjlGQ0FNZGJWUmUy?=
 =?utf-8?B?bFFhQTQzcFoydk9mWUFuSUpsZ3hSTWlCaDg2aTNickptQW01czdIRmt6RTFR?=
 =?utf-8?B?NGx5VGNXeVpuN21DNTlGczIrWU5XMVdYTXVXRnVZK0x5MGpPMzJnTnUwUW9I?=
 =?utf-8?B?eHJNVW5KbkdJSlBvaDJSamlmYy9ZZDNRdlc1S1BMbXZaWW8xTERoRHZGUTB0?=
 =?utf-8?B?aGcyYkhpclBlS3g5dERsZTh1ZWlINTdDcFlTRnBYS0ZYMHJOQjdna21jWG9k?=
 =?utf-8?B?T0w0RWYvOVNBZ3ZvS2hna214a3VuU1o5d0RLdzV1dHJrUm1pVWJkdnpoUTd6?=
 =?utf-8?B?eDMxOXpSYmpUeEdrNWRibFN2bjUwZnlBUG9OQ0huQmpqRU1mamRJUTdCeFMx?=
 =?utf-8?B?OHR2NkVETW9KQ000b3YvY29YcGZVT0pTKzFpOU55ZG02dERCbVlpS0ZTOCt3?=
 =?utf-8?B?cjRCbkZVSXAyclNsOVRNVUZEM0Z3WDVITW9zRVJRZE9PRUZJVGp5YjYzWU8z?=
 =?utf-8?B?YndLVC83czBvSndZajh5akQ4RjRYK09kZ3crazdMcGFJTjI2c3NZd01wVUhW?=
 =?utf-8?B?ZURaeWhrQ29SS2d0clRGeHZRQ3AvTXNDZ1ZtWUtRTVFpcXhNNGdKZmxHZ1U4?=
 =?utf-8?B?S0hQNVZMc0hoeStBaTFiaERYNERFUlYydlBySUdLUUpBT3lQbCtGbmVBa3I1?=
 =?utf-8?B?QnJZdU5MQndpRHhzVEVRSWVHYjZWaHlpajRhZmwvU3FUMUwxeTljdGZYeElR?=
 =?utf-8?B?anA4VVc4b0hXSDNBeDBrMmFjbjFLclRyNkZ4UEJoRFVKb3hsbWhnT2pNYTVH?=
 =?utf-8?B?VzMxMW05OUFTNUhveVViVmpKcGJFa29pZjMyc3ZTUlE5eXFMaHpSOGtJUUtY?=
 =?utf-8?B?RjJKZ29TbXhydVFIeitVcDIvVGJEREdEcEJwQUJBTi8xUUtSTzdhV3FPYjFq?=
 =?utf-8?B?T0lhYmJ2WW5xb2dzMFRVTGFsT1RESkRZaERrSDE4T2g0eWh6UFNjc0pjRnkw?=
 =?utf-8?B?OHVoQWpZMGtTVXVGZHVvRVI0amxEeDJWUGdLYWFuOFRGdSt6cE1FWk9pa1pl?=
 =?utf-8?B?KzU0NjN1eTlsVkRwcG1xS2xBR2NOaFBZdnU3VXZISWcwZWpMNzZNMHhxVGVn?=
 =?utf-8?B?ak5aSU5DNHRaR1Y0ZWl1TmYrRWVTTk5Ec3VzN2Rxc3o2RUlmenk0VjFjTjI4?=
 =?utf-8?B?aStoMHdvUWRtU2RpN3AzRTcvTmpaMFdiVFBHMjN5Z29ySmdseEg0R1loQUd3?=
 =?utf-8?B?U1o4T1kyWE9oUkhLV1E4WkxIb0FBQ3Y3bk1uNTZ1eGJ4WkY5REswdW1Oazk2?=
 =?utf-8?B?OFdrTG5OZEpEaHJiZFRYVWxSMHFKekVNMmg0em53cFFqRGNreklWSG9Nbm5X?=
 =?utf-8?B?Q3BKdCtlaktpeHpCeHdMMURWK0ZzRkRnSXpZeWJIdGU5U2c3Mm0rTXdMUVRN?=
 =?utf-8?B?NEVqalcrNkNnZG1KeXBJTzFsaFBjN2EyZW9wbHBkK2xSam9Ed3NKY1IrOGpR?=
 =?utf-8?Q?VfR/qHtORRnpZD06UEqDHxemV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bEsyc1Z2M1RrRHN3cWlpcEVENHJlZUNOOHAza3RmbjArYnR4ZFJWNzlYbGhj?=
 =?utf-8?B?VXhFZUNvbThFT0xZU0tuNjJ2NU5SdlE2VjcyMHk4SE0xc0pYY3c1ZXU4UDY2?=
 =?utf-8?B?RnhwZy9pRE5ZSG5XOXlqb2p6OWF5d2pLNDgycTdRT2RNaXF6QUNkSlJXcWk5?=
 =?utf-8?B?OHdzRDZnalRYVURzSnIwdCtMZDBUTUZIV2ZrdURyVS90dEdDK3NxRjBmRjlv?=
 =?utf-8?B?Smg1Tmt6NzhyQlU5NUV2VTBtWTB1QjNXVE51MkVyN25MZ25YenVnQ0NPRkNo?=
 =?utf-8?B?bkpSLzJ6VncvOEgyS0RQUHFSMjFiNkF1M3FaWDFmS1pwWFlERVhWWWQxanlN?=
 =?utf-8?B?am5RK21WS0VISVA0QmF6WTJrcU5hRTdpQ0drQ3hnL1E1MGt1ZDU3WDNFQ1d3?=
 =?utf-8?B?WHJBZGswdjlVdlRMaTk4bmRDSldQdC9WakkrRDZoY0xJT0hMd041a0pLb2tw?=
 =?utf-8?B?a215UUsrWmhBT0lPd3o1eDVBWXAva2Q2SXBzWG5MRktYNnJNVEo5cGM1S2Fu?=
 =?utf-8?B?RmsrSjZDY1NjVUlyYmdIVEtzTDR4UEhkSUV6MHMyVWl0aUo2WEhxNnRsdTVy?=
 =?utf-8?B?WktoWWhDSkhlM1lvL2oxc2xlbUxJczBKSGhBcEQvQmZBOXRSZEt6VkhTL3pR?=
 =?utf-8?B?endPZ3VDMFVzYnVHTllvVzZwd0ZFUWdPenpjdlVPa2hteURYUURieGdSTXRn?=
 =?utf-8?B?TXN5dXcrS1hid3VVSC95VjhkZnJlZTdDb25ycWh1Q1hQUXdxYW5GakNPQXpN?=
 =?utf-8?B?bWFBU2FGYUpzS1dLYmZXWllKOEtTK3dLS3A4aGRGaUNnakxyek14U0lFRjM2?=
 =?utf-8?B?RnVzSG1xQXh3N29RSzEybDkrdElFaTE4ZnAzcDBFUXE0TFA5TGt5U29ETEl6?=
 =?utf-8?B?cG11LzhvN3BpOGFJR2tPcEgxS1ZpeHNiL2t6cFNIT0xpV3Bkbm5aNHZIbWhy?=
 =?utf-8?B?V0ZiMEpHZXNHaEFEOGJOK0hPWHoreG5UNXhNbnFYVDZpbks5M0lvcWtzT3NW?=
 =?utf-8?B?blZhVnBmajVTUUFpTzNaLzVhWmg5RnB0MFY5WWVrak16V0Z6cjdBbmdxSE5L?=
 =?utf-8?B?eHd2Q2ZGL25WT08zaHdBS2U5OWEyM29qN2ZkTDdBRFR2Q3ZleG5lNjNNUE96?=
 =?utf-8?B?cVBoSjdvTGhZMXRRZ3VjWlBGRDQ5Mm5uWjZ3R1FOWTVMNUFzK3NhTzlBQnY4?=
 =?utf-8?B?azFZQ1pQZnVaMncwMVloRTVoeGRtaFdDT3VtZGMwMlNFL3hBRy9IaWc5RXF6?=
 =?utf-8?B?TWlaRHU4ZFIvOWowNkViSGJmb2w3TjJ1djE4bG5hcU01bjBSNC8wOVhDZ05E?=
 =?utf-8?Q?sDd92B4eLWeu49flRfoNyuLSjPfvCYqkbJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35247caa-85a1-4aeb-4744-08db8f423065
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:11:04.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx9sl3q4vAL2fMckjt7u2pFqtSlkfOkJ2KrQFhkD0kFAiHt80KHWv58p+/LS1HHIq6kkYhuKsrTzJPRibnRBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280073
X-Proofpoint-ORIG-GUID: aGUBtptaCIkM_1O3PxrRcuIKlyJpoxrZ
X-Proofpoint-GUID: aGUBtptaCIkM_1O3PxrRcuIKlyJpoxrZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 07:17, Jing Zhang wrote:
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
> 
> The same PMU driver has different PMU identifiers due to different hardware
> versions and types, but they may have some common PMU event/metric. Since a
> Compat value can only match one identifier, when adding the same event
> alias and metric to PMUs with different identifiers, each identifier needs
> to be defined once, which is not streamlined enough.
> 
> So let "Compat" value supports matching multiple identifiers. For example,
> the Compat value {abcde;123*}
why not use a comma-separated list? that is more common

> can match the PMU identifier "abcde" and the
> the PMU identifier with the prefix "123",

I have to admit that this is not a great example as it does not match an 
expected real-life scenario. I mean, I would not expect a PMU identifier 
for the same PMU to be in either format "abcde" or "123*". I would 
expect to be in only ever one format.

> where "*" is a wildcard.
> Tokens in Unit field are delimited by ';' with no spaces.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   tools/perf/util/metricgroup.c |  2 +-
>   tools/perf/util/pmu.c         | 27 ++++++++++++++++++++++++++-
>   tools/perf/util/pmu.h         |  1 +
>   3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 5e9c657..ff81bc5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -477,7 +477,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>   
>   	while ((pmu = perf_pmu__scan(pmu))) {
>   
> -		if (!pmu->id || strcmp(pmu->id, pm->compat))
> +		if (!pmu->id || !pmu_uncore_identifier_match(pmu->id, pm->compat))
>   			continue;
>   
>   		return d->fn(pm, table, d->data);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ad209c8..3ae249b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -776,6 +776,31 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>   	return res;
>   }
>   
> +bool pmu_uncore_identifier_match(const char *id, const char *compat)
> +{
> +	char *tmp = NULL, *tok, *str;
> +	bool res;
> +	int n;
> +
> +	str = strdup(compat);

why duplicate this? are you modifying something?

> +	if (!str)
> +		return false;
> +
> +	tok = strtok_r(str, ";", &tmp);
> +	for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
> +		n = strlen(tok);
> +		if ((tok[n - 1] == '*' && !strncmp(id, tok, n - 1)) ||
> +		    !strcmp(id, tok)) {
> +			res = true;
> +			goto out;
> +		}
> +	}
> +	res = false;
> +out:
> +	free(str);
> +	return res;
> +}
> +
>   struct pmu_add_cpu_aliases_map_data {
>   	struct list_head *head;
>   	const char *name;
> @@ -847,7 +872,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,

This is not for metrics specifically. You are really doing 2x things 
here. I suggest that you split the patch out into 1st pmu.c change and 
2nd metricgroup.c change

>   	if (!pe->compat || !pe->pmu)
>   		return 0;
>   
> -	if (!strcmp(pmu->id, pe->compat) &&
> +	if (pmu_uncore_identifier_match(pmu->id, pe->compat) &&
>   	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {

nit: let's change order to check alias and then identifier

>   		__perf_pmu__new_alias(idata->head, -1,
>   				      (char *)pe->name,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b9a02de..9d4385d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -241,6 +241,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
>   char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>   const struct pmu_events_table *pmu_events_table__find(void);
>   const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +bool pmu_uncore_identifier_match(const char *id, const char *compat);
>   void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>   
>   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);

Thanks,
John

