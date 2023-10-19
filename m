Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90337D0536
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbjJSW6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJSW6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:58:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42298
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:58:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKuMCO011372;
        Thu, 19 Oct 2023 22:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yC7V6Bm49LU7n/q14Eyh+n6v8nhuMYiHVlkV1WWfnCI=;
 b=xrPyD/vN8/moL/NExQorRAwT1fYNl85rrtfY0rfwQ6ZeM1jpTd0ob/O7kMM2W92IfbWd
 252YUKVX6VSBzb/SudcHURadQ7/NjU7JKUwFxd0f3P+zS5UckB2/SVRDP6ZfI/AGeSdX
 lN5EKy1JJyEyCpuB/E+lfE1s/1KGCbUU5xNorfKiiH+qHsh+5L+VfbuQDsNUcmsNOQlE
 Jt+sAvbZXta/4nVFK9i95IAxyH9kNG+jobFpH2Uz7kAZAyxTIqdXZ2c0G5lq1x6uCvvX
 pHP/ApqhBXLuqbhhigBmcf7RuZxihVnFnFTcD5w3TfTZvAU8VrFMoLirREVyQoWKv5CD yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubw8053p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 22:57:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKrqOO013509;
        Thu, 19 Oct 2023 22:57:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw5bmrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 22:57:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrhxIa4cmhWz1dCCKG/b0ICcRY8YCBSeJZrRDhaHJonpFpxXsvUmDxNNnfaVcnCKE8mw3AneKgVXzHYanjMNHnoMI8p7nrFNoi22eBBZquLl60fbeS0PvQ2qqnxoxV4RKj+2CqnvvOpwZn879K0g+v2jS4U5zzAKRBdM348j5NZeHtS6IicFBJeai+8DFjDvNqQuxfMfuSb0Ion/riiyJY/gS/k04hQi8Q/aZrPbBmKz6806ByFiqdLh3hltwJ0zz97jPIUaB5QZQ0GtBH1mKn0ZQ5Qdm4rANSkcvKFkHfusFXTz6HGMhU8FE7IqooOVCnFFA15ivknbs4sPJlnKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC7V6Bm49LU7n/q14Eyh+n6v8nhuMYiHVlkV1WWfnCI=;
 b=Ide2hOHPqCwXP4L86hYjPFjjZtE4o0TD/mqCpbcS8yXk0kbgKNEE3LtCO7IjfKS+33Ac5D1G+1tb9RbiTQXfCOZBRAFWm4/T7/xHQS8b2Ba7+jdRpSZ2rDkIVVmMaqZR9slcyruLOXO0opCPfxskT25MEGQE5mb9Zo1I1z6kLa6QQCB2G34hXrBTok41YOeQNYk/1R8dzLzdRSMR3egSoFIeZT9rE9pocm+qoWKHHJhdMaQw2MOc0OZcJnZunZtEDn8UsS42mwsSmAjNhppspjpq+njc9Ko0DUqlCNLtwP32ADy9whSPRfO5KM1uddcMmgdE5UwVCdtAFcqqaZvbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC7V6Bm49LU7n/q14Eyh+n6v8nhuMYiHVlkV1WWfnCI=;
 b=aGj0DsMohpfoZM1p1uyx8ni1/qfeY5PDMeGjwwrYtBWOF1Ugk8a0w9izP4m0LPsWxUAsS4s034EKLPwTSXKepPmbQAR+6v/oiI0LOIcunsZi2SL6H0DCwZL+lIclC0A0NH5ip9ceCK/KduYyS701/fUoyJIY+Cz3xUHcMAbbMak=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB7079.namprd10.prod.outlook.com (2603:10b6:510:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 22:57:55 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 22:57:55 +0000
Message-ID: <695670fd-6762-42d3-b38c-fb347c8beb1d@oracle.com>
Date:   Thu, 19 Oct 2023 15:57:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::39) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3e31f1-bd02-4b1b-1501-08dbd0f6d43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JVX3oEToHp9PDRGTeUHLHI2BYaCTAQ6NyPOG/03kj3GgfxqbYDfe8tavb7z0ZHTaSYiT9t6DnE5FCTOcZWy1rrkI0SmnhZm+CsMsSfJzmkRQerzr5o5jgB6vfCkKi/Amj1KLT5I9OzdGH5HjLTv3Q/Zp28ev99IniMS4Kir8rd6nadfwbyK125DDzl6gz9xVEyFPnywsR37JenMwhEE6rVGFVr4PqClJONmF4EIpSqY1F+OlzMnb/X42tHx3KCA4y8lDNepr3D3oRBbqdRjRHEivsHzBYaRrUEg1cQlm/DqMxpdfFa5YxB27doFRXF23aAjZCeLKtil9wlW74WCvSIadQOSUu4szwcJkknsU6+J43Cf8fjBhQxA9PWX7fsvPAW58c3k7j02lRc7YUReSMid9SBEykdDZZuOd6yf6eLrmu3cIifsscaBCmydxHoPs68/NCValApZyshTAVfI9uuOTqYmd3hrdRrCqvK9YLiAhAycurfnYef+Gm6qtHlxhHIiGic2xqTVbf1S98GO9l2x+vbT+L+IVJPTJ4zn3OmIthELq9rAlk7W4qYncSn7BOgxqJgkNQ8774w+7A+dF5Hb0gKH4XzJsrgWPkLWNznTJOwXcxrxwSEm1Pr1TLvLky/AFXP+ufdYFm0+LW0pm+p3F4uKHuhxiJlSBrrfVc9iwssAaInZM+OwxFUkwu+e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(38100700002)(66556008)(8676002)(478600001)(6486002)(5660300002)(66946007)(66476007)(6506007)(4326008)(6666004)(86362001)(41300700001)(31696002)(36916002)(2906002)(53546011)(316002)(6512007)(6916009)(8936002)(2616005)(26005)(36756003)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDVTWUcwM1lVUGpOTHVNYTMyUTRkQVU1WDdONkdVMGtpMFNnWVRRTVo0WU16?=
 =?utf-8?B?cXgzSzZrSjVTTXQyQWY4encvWTBjeTA0Y3hZRk8xMnd1K1NLVC9vVTk3ZHpp?=
 =?utf-8?B?OTlNS1puTHVOYlAvRTBIMU5hUHN1ZS9SQXg1YnNwMFlJY3BqZENyaEpaOUp3?=
 =?utf-8?B?bklxRjNjOFE1TWR5MUxESHo5ek1CSWNCL2F6VGd1aExkM2d5b01YRDBDUFJG?=
 =?utf-8?B?d2pHcWJmdjJ2TU1jZjl0UzdzVGZ4OWUvOXN5QTZ0ZjUwMmtNMzQ5MmpxWkgx?=
 =?utf-8?B?ZGQ0M0ZQeXFleThPb3JnV1dYQnM0TGt3TmZOSTBFYjBMK0kySG9GOHhwV0Mr?=
 =?utf-8?B?REE2S1I0T0g2SGN1U1Y3dHAxMHF1WC9nVjM1T2tuemgxblFIZjF2QW5TZzlt?=
 =?utf-8?B?ZHhaOG9vRmdLK01lSU9uQUlCQVBDK3hkdkNUZEEzS1dWbnhhTmRWR0o0Kyt3?=
 =?utf-8?B?Mm15aFRMb2xpWHBNUHZIVzhpeE55MVdhVTlZQmNtTWxSc2hsNTMrZHJobjhY?=
 =?utf-8?B?SlFCZmp6dVc4ZHJOZy9Ya2ZMd1U4V3lXWkwwa08vUGt5V0JwWHJ0cTdoM2Jx?=
 =?utf-8?B?bUhCblR6dzBXT1FSQlh1WStZck5oR24vWThwaUZXYnVQWGVWZXJBNTA1L3Y4?=
 =?utf-8?B?YVVXNGY3Mno4d243TWpJRTlTbldoR1k1VVVqSlYyb3d2dzJONnN2REdWa0R3?=
 =?utf-8?B?L1Z4emdnMFRFTzlScjQ4ZkFwY25NSWYwNWJmcmNrTG1MZ2NNeHpsVW9JU1NY?=
 =?utf-8?B?cm9tT3pHL2FlTThOaXZKbVJqSHlmemQxcUFtZXZpdXk0UTJzQ21pRDNhN2hr?=
 =?utf-8?B?NUJWNjlUSS95QTUyV283UDRNTGZGU3A3OHd2NWpsMys5Q0tjZXd6ZG9xbzgw?=
 =?utf-8?B?dTYwNTFKVkZQdWNjSDBkb0hFNG9LLytQK1ZybTl5bnd3S0JJMFhvMlo3N09R?=
 =?utf-8?B?VlJTN0pmM3JoVHBLTUNva2hzZm5XRzVzemkxVitoVXlsRzZFN3VtZ0szSVky?=
 =?utf-8?B?Sk5rS2xETDV4VTVnTWlXcXhaWWY3YWZ3alVVa0c2V2lFdmtsMHRQYkYxdmNn?=
 =?utf-8?B?REg3T3laRG91SEtITVQwT3pGaG8zRW1hUVFXSEhEQ3RvUWx5bE5wMk5QZjFC?=
 =?utf-8?B?d1crY2xaTWc1dWZ0Sk92QVZXMTQwRVJPUWwrNkZrS0UxRXllZlI2UW1TVEV5?=
 =?utf-8?B?NzVkZDRsRWo3V2Q2QjE2dGg5ak9YQVhTNmlXVEN4UmxVOHd1RDlwVHRXVXNB?=
 =?utf-8?B?MEhXRlZxQ09YcUttL3NnTGVzbDdZQzJ4ZUVyNm9OSSs2ak95WnhTcFQrK1d5?=
 =?utf-8?B?M1ZOa0xrNlgzMThqWFlxWE9ySERYN2QrQXNJOGxmaTF1QWxBMmxNRW9qT3p5?=
 =?utf-8?B?SXlKOExSekFqQkxPMlR0dldoblJkRy8rc1FodEVIRTkwK0ttdE1KNUp5alpU?=
 =?utf-8?B?Y1FFcHdKNjBneW9iM0FWTmp4Z3ZuNGlxak5ZMHZ5STVSK3dYUkdjL2Zhb1lr?=
 =?utf-8?B?K2ZvYTQ0TmszU2VJRUxGdVI3dXZPTmpTM0Uxc2YvRDFOUkhQM1dGZUx5UmFS?=
 =?utf-8?B?U0ZNeSt3UnhJdG5UbUFHVjU1WXBQYmorK3JnZGNxQ3NwRnZaenROdXB2Yi9j?=
 =?utf-8?B?cXU1TmcyVm92ai9XUCs0Z3FKN3VWODN1TytEdUZWQmZieVpieWZrUzR4a3g0?=
 =?utf-8?B?V09HZE1DanBOSXBIYUtJeFFEeWlFUHhOc3cwVEJEODEzd3pFWDhINlc2NVBD?=
 =?utf-8?B?dDdYaHpjdXk1M0FMYkFFYWxZY3N6QnpTRjhqU203OGdXV1hhb3diZ2c0NHY2?=
 =?utf-8?B?VmpmYkNZL3VoUHN1Rk0wOVp5bzJtc1ErZ1pHa1BnTkhMOW4zY2kwWDRoZEhu?=
 =?utf-8?B?UmpJSWhSN2tVZ2NKekdyYllPVDBXSjFvbE9FWk5sZkhiRnJrZkJEOG9ycUc3?=
 =?utf-8?B?akpzMkl4Wnp2YkVWSzEzY3I3UjZTcHI2cytLanZ4MTZOM2xNT3pqZnZWaDc0?=
 =?utf-8?B?QlprVmlFZW1lbXdmYmFiQzRXRlFyMmJSUEhCZmRtemFkSkJDQnpLakU1NU9a?=
 =?utf-8?B?U21CeUNCamliVkVueFlRVStUUmZ1UENxRysyYlVudmRYTW1QY2tyK2NRaUVt?=
 =?utf-8?Q?eknhuyadQZgNVLCikMZsV11xp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Uy9zdXFRd2VnVDJQQjJpL3E2eStYZ0MyelYxY044eDBvdHZZaFVIOEk1R2hs?=
 =?utf-8?B?K0xiRU1RdjJpU2pUbTRNaUQvV3d4ZGJiOHZwZ240cGk5VzBjY0FyVWVkYU5Z?=
 =?utf-8?B?SHZRajF5MWJCR3c3RGROS2tvM0ZMdDN3bVdicjl5MENPWXRtZFRDcW01Nm8x?=
 =?utf-8?B?YjZEdUhwUW5Qbm5WbWo1blVQU01HakFNbU5xaThXVkpJV1hBMVd1Ym1FWXVa?=
 =?utf-8?B?MFgxSjJXZ3dhMFBOQVhPelJBSEsvYWFKb0pHNFd6cHc1OVhTV3RDNlBCdnoz?=
 =?utf-8?B?Yms4M1ZiVHZOeFZsOWswb3hzTU1KYVNVSjYzeTdhSEVLVThWMXF6Tmp6TVNU?=
 =?utf-8?B?RTFJR20vMjlxRkxPODludzhEUkxIMFJxZXIzU1FYUTdiRllGMUtrb1lwVFUx?=
 =?utf-8?B?TWlpU3AxUTQzSmdKNnR4Z241c1JZUU9SMzYvM2lvZjVqY1V5TFBvTnl0R3l5?=
 =?utf-8?B?MjdTRFEyOVgxcjVmSlZHcnNrQXNxeGdBQm5ZRFA0aDdHamFPR3hFa3JvNTUx?=
 =?utf-8?B?eE9wQ2dubks5S3NsN0d2Z2xlelVMZGQwZUVnNjAvN1V1SXJZVHFJZTdVVzB6?=
 =?utf-8?B?eWVvamszRDMrMU40TmhRcENUMHRUM1doTGo1STRkSTBwZkxpbDY1emRHcFlt?=
 =?utf-8?B?eWN2aHRQTVdPS0ttcTVFOVFjb2hmRjJHd0xodndHc0dkSVJwSFpjRWdzc0xm?=
 =?utf-8?B?MXdJbzI1dW45RGFqZUt1OVRWcUVMR1FSck43aHZhbGJ6WXZsNTBxR0h3Nyt3?=
 =?utf-8?B?b2V4dFZyWXlvMTdIWUZXSS93MGNCQ3p2R0xLclhPY0d6bWpHK1B1ejRwNVNV?=
 =?utf-8?B?Ym9ubVJXZGJPeTJJVjNIdG9kUWpyUVRHVkhxMWNXSmtIZW01bENLZnMzajk2?=
 =?utf-8?B?SzByYTVNRjgzd1J6aXY4bXRFQlY3Qjcya3N1UXVPYXUzWGhzY29EUDlkUlZN?=
 =?utf-8?B?cUd2K2VXbEoybzJCekhCWlgvVFJPYS9WZCtMenVERVZKRkNwOVNpdTRPb2t6?=
 =?utf-8?B?eFBscGYxTUNlZnBDSnNGYTZTdVJFU1BIZTE0WVQ5ekE1UnJJRHlWMzNUMlZ1?=
 =?utf-8?B?dXJDTEdvdERCMVFjTHA1ZjJ1YlIraWtqWnRTS0djUG1pQU5ycjZRbkpkdCsr?=
 =?utf-8?B?QW9LbFNvTWh6ZWlnVUxhT1QzTlZoYlVCWkQrallxbXZNSGRBZzlpRkRsV0Jy?=
 =?utf-8?B?NzFobDJXUUQ1b3FzTmt1cXA3TGlrVkUvZFIvN0puUVN5YUVXOGlOV3Y3MEZ6?=
 =?utf-8?Q?46LF0DF9ocxgvXR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3e31f1-bd02-4b1b-1501-08dbd0f6d43a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:57:55.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l14ZHHD1F5wsFQKJR8Y0xARbT6s6sEPHuzrbwEhEI0eAz5gi//2pHMlB9Zfyv1YVTj/j+USv1KCE8OJrTwRl4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=836 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310190194
X-Proofpoint-GUID: bdV3YFrx4B3-RoRiGoPODBiefyjW0dVp
X-Proofpoint-ORIG-GUID: bdV3YFrx4B3-RoRiGoPODBiefyjW0dVp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 10:27 PM, Jason Wang wrote:
>>>    If we do
>>> this without a negotiation, IOTLB will not be clear but the Qemu will
>>> try to re-program the IOTLB after reset. Which will break?
>>>
>>> 1) stick the exact old behaviour with just one line of check
>> It's not just one line of check here, the old behavior emulation has to
>> be done as Eugenio illustrated in the other email.
> For vhost-vDPA it's just
>
> if (IOTLB_PERSIST is acked by userspace)
>      reset_map()
... and this reset_map in vhost_vdpa_cleanup can't be negotiable 
depending on IOTLB_PERSIST. Consider the case where user switches to 
virtio-vdpa after an older userspace using vhost-vdpa finished running. 
Even with buggy_virtio_reset_map in place it's unwarranted the vendor 
IOMMU can get back to the default state, e.g. ending with 1:1 
passthrough mapping. If not doing this unconditionally it will get a big 
chance to break userspace.

-Siwei

>
> For parent, it's somehow similar:
>
> during .reset()
>
> if (IOTLB_PERSIST is not acked by userspace)
>          reset_vendor_mappings()
>
> Anything I missed here?

