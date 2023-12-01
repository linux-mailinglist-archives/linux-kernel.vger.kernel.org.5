Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445B8003E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377474AbjLAGbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjLAGbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:31:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655871721;
        Thu, 30 Nov 2023 22:31:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B16U3bj007304;
        Fri, 1 Dec 2023 06:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LBRL0u/Q2DiKO6o+WTqkzFZSDVzD37A99NcFraozqU4=;
 b=ejnWVEIuRgUe0fTnBHdLWC0o0a+Ci6ayqVglRn7K5Gnb7+JhloQbYxaWJupfhfWgAS7Z
 pnqZ79J86AKoApef2dSOslndyS7ss57N7rCtpSMdCYL55pdNitirxTPKL6KvNb4vAXDg
 oQKO8oljGA5Rers+mN95muKonBmrdEDpSPkxuWYVmOeAAPhrA6en7OKAFydI1OKM/Rur
 G3Pyns/tvWP2dZdoeNDQaQ/GTu0r3l/IvET/yTEUT0QkuSnUzyVPYVY4CM5UOU7Px59l
 yUo4tVR7/Qh7OBTmBBav2DmYIl7z7I2t0L/3SSkVvSRAPakVtXkjWd+cufE9i9eDESQo Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqa0tr0yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Dec 2023 06:31:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B157ghA012747;
        Fri, 1 Dec 2023 06:31:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7chbxk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Dec 2023 06:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyVqVbukdaapoNo9HqczONE+SahrOQghjFgVuw0+pGxlj/Nsu/xO04somn/tfeZ0b76OPEWPtxoC+kqQ0s0j2780snhuB+VAy63UYfVrC8RNBhjDfySYOHDod78aZBB3vxMkPGyC2jHUDhjP7Jnod98+hbFxnmSfOV1p7oIemHFWN1P/o9RYHvc0uI+ztNMzrOYJoYfjQ8xG3vs5xnGsmSqfZ0ImwJfEF4NfQGqeBJ4g3+RL/ot5+uqY0G+PmoiLFzyxB3Ty57TzkhJ5Mu4wUN/EzU4op6Hg7d5C4JYssmXIYMlqRMNtKLPkFfB8IqWQPSvuTvNTIpnDwzUWXQOcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBRL0u/Q2DiKO6o+WTqkzFZSDVzD37A99NcFraozqU4=;
 b=W0uAKc01ud2yaCPT4MrPIh78f8k//e+KsJfGM0etqJwgF/8z5otkEuGOZ7rsCDhCljkIHw3uaDgU0Aj8FkRzN6SSAuk/DbDSkiL/+MBTQgMByj5duY8zr8IDgTA2exFR4Gbg2ISrka4v7slc0YnixtDuc5B+WMl9lXISZ0RwelHE1U5IZDThVLr7O8dOxiW8f2eIicCfHbql0uspJD4QPZp02EH3uiNkADgJMBa5IY7ydV6+FlUC5kfJIiyAHAJHV69VS2LwzYCs9o6f5G5y0Bg25r5Sl+U7FaAeheNvOECt+w14xZGMDXN97n9g75l/qaL/I7fdoDBCZ2j7zxibsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBRL0u/Q2DiKO6o+WTqkzFZSDVzD37A99NcFraozqU4=;
 b=e1E5cWczZsQ2aiYpnU+3o3qY7p2WUcnzeiLo4HWzA/+MgFqPWFanrPN7qjM/rmQggChqMCx8j68H9IGJRwKU2yMPXJ49dczmLxkBW4KDmbuibO9V8D8YMoKy829f/E3YMcqqQSYCTXeW6pj8gPM2gEzG7T2WFGZuHwhqmwzBHY0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 06:31:13 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 06:31:12 +0000
Message-ID: <8f7af6d7-083b-4cc8-8f32-cd8ea2fae948@oracle.com>
Date:   Fri, 1 Dec 2023 12:01:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe7-yhmQkr1iK-82+Sc_YpVtWUQhuKoazoXHF_3oP9XTt4Q@mail.gmail.com>
 <e2e50813-79ba-4c84-b6ae-6885cbef54ab@roeck-us.net>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <e2e50813-79ba-4c84-b6ae-6885cbef54ab@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 704e2238-7365-4b1e-0057-08dbf2371cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHVprLlNHeZrVdRTCtjWsKe5l5AL/uCfIrSSiLSXqhH/rCCIKP40XHXYbSkf7+MWk3Y0iN8syEbDGY4KDVD6jm3oHbIz/Xgida1YChSJulXArP8W5zhHn2UAYlxbAEn6wVLDmnR74eTO4k+YkijaTAP/1Dz8i9wCjc/ql7odvEvlszp6y8/l195GSkYxSEFUm8E4FHRBR960LvP2xicbxQeglnMjD1sWZkeuP3blOrkSnuIbTBoFNu+HTCsGRDSwoxby53ss+5uiF1J1cTPL0ona+O3WiD22TcN3hXiCmdA1mhZOdVoDTzAHB0C+5seEBR61lHp1xgfJbEaf9OCS5BeTy2HpUEmV6x0j81/tKaniIZjhuX5ArTSrPJjWzndv8/5B/UnIpKhkrwBLzMVRWvpwFjvfHVIhQf45PBuis4fYhMplTTyjhZgH/d51idMIkPZk//g3lUPotNtRL9O8WxQzgmB2VRa84hmDmdy5yILrL3hAo3fL23FVA1AHbISICbGDA6nG9gb9ZzWAmlIZ7pR3zyqDKdLfhFWeznRYsANfRMg9hFsrC0OPFN1B8qC+/4+YoEb7Az1iaV4d00Zs0kFbqJ+5rIPgAZIrlUYFalFJOq1ToU3W66Xb1Z33n96G8EFRwZfcnzTk5WRSKIKXtor84GWXkMR3M0hIP6ykFo8lfhfCxl2Amwv4+/5pzcaJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(31686004)(26005)(66574015)(107886003)(83380400001)(6512007)(38100700002)(6506007)(53546011)(6666004)(2616005)(6486002)(478600001)(966005)(316002)(110136005)(54906003)(66946007)(36756003)(66476007)(4326008)(8676002)(8936002)(66556008)(31696002)(86362001)(7416002)(5660300002)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1c5Rkh3cUtURE1SZ3lPMGIwNlkyeVY4SjdvK3RKd3oyT29aNU9rOE1RVCtq?=
 =?utf-8?B?RHhvTFpKR1AwaGNpcDAxOE1YVUE5MXI5bU5zOWhhSG81eTdyeUh2K0ZSYTVk?=
 =?utf-8?B?WnAvSHhYa2NXT3JYQXVoUngyQWZtbVRUVGhwblo3aHVrcTcxTXQvRUdHYzNn?=
 =?utf-8?B?bGN3UFQ0VkQyc0ZqM0todTdoY21NdndHVE5WRzFmS1pTMGxqR2hHZUVQVlY2?=
 =?utf-8?B?SjYrYURqQjZrcDFYREJKY01xUGVUbWNQclE5VEMzL3VhcXIxaWVzeTdmWWZ0?=
 =?utf-8?B?UW9ONVBrbktOck9wVEJqaW9nSmVnNWlYWWVNeFFqV0xmZWt1a2NGVGtVVnRv?=
 =?utf-8?B?S01aU242UzltZVNsNzFGc3c2dmF2LzhFSFFlTnJYUHZ2UEtBVjBYYS9YMjhW?=
 =?utf-8?B?VmRndmkzMG43U1I5elZTcTVWV1A3cGFIWXNlcGtLWWJtTmtHU0dZVXNKRlJH?=
 =?utf-8?B?WTlzdzB5UXk5eEQrUUtrdFVqY29UQVkxWGt5T1VmcExGMFVXbGZ4bGhnYUhR?=
 =?utf-8?B?Lzgzek1XbUhiYWtFc1Fjb3dHU3F4d1RHTjNEeEhGRXc5Ly83aytkWkh6V3NC?=
 =?utf-8?B?LzFhNCsxNk94QnBkK1V3bXBZYmdSNXNkMFhINm1EaElEcnhwYmNITWZwdU40?=
 =?utf-8?B?a0VrN0hqa1orT0dmNGtJcVVNMEtpdkZwK2VBUEpkWDRVb0dNS2hpd1o3MnNY?=
 =?utf-8?B?QUJYWndNN0VDZVh2R0N1ejd4RHZkaThXM09CdklWQ1phZnQ2SWVEYm9hUnk3?=
 =?utf-8?B?Wng0OWp3RWFQQXdhUGwxd0UyZ1JhNHZjTEZYZ0xCZUNkYWNEcEtnNFp6dWxU?=
 =?utf-8?B?TG8xTm1Bd1l6TDdHNjBrLzl2eEFxb3ZtMU4rSWNtZHFtOGU5TldKTzNpNVN4?=
 =?utf-8?B?MEZRajY1QjYwUzJpdjI0blNNSWROM2NwY3JqRFo2MURob215YThTaldMaUJa?=
 =?utf-8?B?eThQVmpQa2xXZ3lta1M4T2RISmhWbEM1VGc2alpZMWZDalRhbDM1VFpCWGg1?=
 =?utf-8?B?b2ZHTWROMXFTYWx3SEpxalhXZXFrVHBEM1ZodC9FYTJja1BoY0U4MmoyWTJr?=
 =?utf-8?B?RFAwVjdNeFdmK1IyUzlrVGFrSHZTUFRqb09oaEdXbTB4VU5rYk1mYkozZjdX?=
 =?utf-8?B?ZUxnZ1Z0VEdMY0l3UVFtYXA4dDRUdTNCQTM4V3l5eTloZ2Q1RHl5MXl0b1pp?=
 =?utf-8?B?MjczMUxJR1MwcU9obmhCZFl4cCtvUzNtL0pSeFp3aEJmRDVjODIvVHd5ajBI?=
 =?utf-8?B?WXlSOWg4a2l0NmYvR1J6L2tVZXlLTWJnanRPQnp6dHFMd1RXWVZqUnpkdkhh?=
 =?utf-8?B?dlNtRTcvTzNqclg5bGpnRkNmZXM4UzZWRmFTS1c0Z2NVOEhYUUY1WjE3VENr?=
 =?utf-8?B?bDhKemhLVWtHYmMrTjBwd2pDemZWUERDWXJhSUN5ZE5BM3UvMS83QlhhQWxn?=
 =?utf-8?B?N1lYNVlsK2poaFNlYnJYUk5FMHJDQ1prb1hUWk0vSXdmYWNWYjNiOFdQN21q?=
 =?utf-8?B?eGxod0dEU1JjTVpRVXVidGxVb0NmWmphcERQc3BSb1ZML1VUVHRDOGJLWUs5?=
 =?utf-8?B?L1kxUTA5YUdDY2lpM05IWDk0YmxETnVqRUNlamxuOVl2R281d1pieUNYdVFw?=
 =?utf-8?B?RHlxb01BblJhYXRKdnk1NnJmTm1rck9raDNkWnhVaE0wNDd6Q1JxcXJONGxl?=
 =?utf-8?B?MjU4ck94bWpyNjdpTGkwNm0xWTcxK3BmWk5mVHF5V1lxUXNhbExpRDFuMWZs?=
 =?utf-8?B?S2Y0WnJJNFZyc2QyaG1QSERzOVEvcndDL1prSkphUmxnbVFNRm9HTkhPT1pI?=
 =?utf-8?B?NTZ6V2hlYkRUMU1ESnVPdnVHdW5WanJ5aDFVOEdOM3dLWlRKb0tsQ2MyYUpW?=
 =?utf-8?B?L3NhSGNVZERVK2FaSXJKYlkvbHk2bll3SzhjbXVlQU5MTDNxb0NFM21XK3dK?=
 =?utf-8?B?TkVrUzZTYnFWUXNTc0EwZFgwYlFZWVBXdE42S3NITTVNaXJOU2VzMSswdWNE?=
 =?utf-8?B?bTNuQVFPNElDdGdoZHc3R2tESFhCVFY5SkpoUTJ0b3pPWEpoSnY1Tml1SWtF?=
 =?utf-8?B?VXByb0oxQm1QTHErNFdvU1l6WHZrb0tzemRkMDhHNS9QaElkNG5mNk84aDEz?=
 =?utf-8?B?aHNqazlBdHZwc0sxNDlyZDRvU3pKSzNkY1hLNmcyUWRaZkhHUHJ6TWZqYkFk?=
 =?utf-8?Q?P5zPERLn79hyykQeeDa4xb4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RkN2QUhWaHZKa1hEL2FIVmtoWk1KdHBlZUxRUXVUUDR2Ris5NTd2bTJ1SWwr?=
 =?utf-8?B?TkVoM2wxdkNsd25NNXc4bTd1emZIbTZRV051VjBTR0pIdFp4WHZ3N0pZcDhB?=
 =?utf-8?B?elA1ZzBzR2R2RDZVb2tCdHhxZCtaRmE1TTJNYjVNaU1FS0hUV3RvSFczclQ4?=
 =?utf-8?B?MDdoRXhXTFI5ZUZoclRZRG9RSS8vYjZQK2t3Y1ZudXNtd3VrVmRwSGI1VFB5?=
 =?utf-8?B?L3JlK1R4dVZGUmhvK0pETDc4YnFmQ2licUtQNUdTSElYM0RhcU54RndGU0Z1?=
 =?utf-8?B?eXg0alhuTk51UEczMW9mak1leHllbkVKMUxuVGNVMWIzcFU5NVBDVUF6eXMv?=
 =?utf-8?B?M0c5VTdBeGExS1pIMjZadlN4WkxOdFQ2MTQvWGxwU0s2WVNTTnZOWmFiWjAy?=
 =?utf-8?B?RmlGbitRQWRxaWpvbTkxWEdFZ3lmSGR0UzduMi9hcXVxUWhrVFRhaTNxTWIx?=
 =?utf-8?B?cEF5Smd0MzR3VFZSZmlSMDNSWmhPRlp3ay9zMzJURDFReTUwQk5hdGVWR05z?=
 =?utf-8?B?cHFVNnd3YmppY1hVRTVPQzdHSXNzSzF1dVgzNUtnNkVueEg1ZlJJaVA5TmlD?=
 =?utf-8?B?UmRNbkxpbWFudW5Hb0JwYmQvUHNmRE42Z1lxMFROS2Q5Zm4wMFh1V3RUZWdY?=
 =?utf-8?B?N3ExSmFURUNkQ2VnRXoyb280dzFzZy9hT2ZjUlZPd3MvRVovbWJRMTdKZHY4?=
 =?utf-8?B?VG9RK01UL0ZBMDFMUGdjRUZvMWVkUWIzMGJXMzlxTmhqRE1TallWejV6YWtz?=
 =?utf-8?B?RmN3VzAvbk8vUGNjQ0VkTnpZQ0d5aHF6d2NROHZGSmhZNW9nYjJCTjc0RFRo?=
 =?utf-8?B?dXhBa0xRNk5YVUVJc1oybTI3Qmhac25oZFU2SjNMdWtULzl2T1U3NG5ha0h4?=
 =?utf-8?B?OUk0NTBkbGhrczNMTy8vQks1aGozT0FmbEE4MmJ3QWFSTGVQWUY1NTROa0N2?=
 =?utf-8?B?WHFUbjBlS05uRGpwTUlqOWJwVHVQdEJwbGJ4R3ozNjA0b09zMWhEdk5YRWZn?=
 =?utf-8?B?Zlg1Z3V3dHN6WUpCOUlsRExjbFI2U3hoZ1h3OWllMFJucHp5WlcwUUo0dnVR?=
 =?utf-8?B?clF1Z0J0ZVF6d3lFelR4OHZKdDhucVhsVDF0OXJMM1Q2QXlJSDkwMkNRVFdF?=
 =?utf-8?B?SDdZQkVRU3BudlNvaGtkb3VWdmw3WmUrcWd2U2FkYXNKbkNiZ3YwZ2dVY2FO?=
 =?utf-8?B?NTlULzN2c2ZuTnNLaWhlMlFCOTJrWTJ4ZWdnRDBGY2x5RWlJZTlpekZ3aGoz?=
 =?utf-8?B?N0U2aHZncjlVeU1zL1c3Yi8rZlhjaFBrQ1pzQmFRRUJLYmNHeDZJVTNQRm0w?=
 =?utf-8?B?dG9JaEg1VTUwQk56S3NvQjMvcExyVHRyWVBnRkMwWElDelEwdVFDYytUTkdy?=
 =?utf-8?B?TUxTUy9VVFNiZFhEM2x1SzROaEREUlhuWWk2REM2cExuUy9jcWpZdEUreGdG?=
 =?utf-8?B?NVFKUVptaFRwZnBHN3ZQcS9WUGExZlZuajdvdzFGTjd6UUthOGVLSGRtaTJS?=
 =?utf-8?B?WGR0aGRVMjhRMGp0bW9ZUTlabnh5Tk01ZGdvVjJUci9KbGp5NVZ2Ynd2RlNB?=
 =?utf-8?B?clFZYkVTQ3ZDRnUwb2F2QXhkSExGZTJlNitYV0hoMW5mVVE5aHBtZUY1eTVQ?=
 =?utf-8?Q?rJ3pPcqpFPkFiEgLJ9dRzhvdELDo+kepx7l+vQF/FaIU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704e2238-7365-4b1e-0057-08dbf2371cd9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 06:31:12.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N2BDgM/1IbgdBfvH0lFb7oLoxvqeU73gPA4cG/F2i5VfzsZq5PTqpY1/RPBmKhzhqM4boQjt5vtB7LGKaLMTT/PijB+k7XkO3s00qXYDqcpoKw6wAnyzJhFhaGHR/g5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_04,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010038
X-Proofpoint-ORIG-GUID: caUz8TWwxLjdynHFNv8yDgVxfjIsn93q
X-Proofpoint-GUID: caUz8TWwxLjdynHFNv8yDgVxfjIsn93q
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Some notes below:

On 30/11/23 11:14 pm, Guenter Roeck wrote:
> On 11/30/23 09:21, Daniel Díaz wrote:
>> Hello!
>>
>>    make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=x86_64 SRCARCH=x86
>> CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc'
>> 'HOSTCC=sccache gcc'
>>    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x51:
>> unreachable instruction
>>    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
>> `__trace_kprobe_create':
>>    trace_kprobe.c:(.text+0x2f39): undefined reference to
>> `kallsyms_on_each_symbol'
>>    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
>> `create_local_trace_kprobe':
>>    trace_kprobe.c:(.text+0x384b): undefined reference to
>> `kallsyms_on_each_symbol'
>>    make[1]: *** [/builds/linux/Makefile:1227: vmlinux] Error 1
>>    make[1]: Target '__all' not remade because of errors.
>>    make: *** [Makefile:226: __sub-make] Error 2
>>    make: Target '__all' not remade because of errors.
>> ----->8-----
>>
>> It only affects 5.15. Bisection in progress.
>>
I have seen this too in our testing.
> 
> I guess it will point to
> 
>>> Francis Laniel <flaniel@linux.microsoft.com>
>>>      tracing/kprobes: Return EADDRNOTAVAIL when func matches several 
>>> symbols
>>>

Note:

1. This above commit also have a fix upstream,
926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at 
modules as well")

2. I see the patch causing build failure is also queued in 5.10, 5.4 and 
4.19, 4.14 [1]

Thanks,
Harshit


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-4.14/tracing-kprobes-return-eaddrnotavail-when-func-matches-several-symbols.patch?id=1d4fa85848f798e9f2b141101cd0f9aa6af93395


> 
> Guenter
> 
> 

