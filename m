Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B359801AE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 06:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjLBF2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 00:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBF2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 00:28:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195C6B3;
        Fri,  1 Dec 2023 21:28:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B258chr022615;
        Sat, 2 Dec 2023 05:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kh07AeTv0q9vBA5CUdZBYrnP7mFxiVeoqOSWupUEU+U=;
 b=PYchB29dm2L9BWAS5dT/6vFbQViwQfQQygyORaC45nvauUw+4RY8nQzvGvL1SM41deh0
 kDawnoAqT+KK6NKrLxUJZBJefAMXqY3HLNu3knVrE8MxhQtZWXE49TzW9HZAsKYwF4Bc
 lAQUpXY7KgkurnYnS1U7Ef7RIMmJvL1FPhH+uVXqahWzO+acGwz2LhpVN8OW2j2fZtzg
 io15fFwJ6yS6k7hLz8IopR/k0ciO/DBPYfXFliQ5SSTEqrIJBFFzF1EsbG7l67VmqK5l
 WXy3sycYeYNhMzcFg9MhgvSdQp8cV1UpOpGLkeeqPfSWUH4TdrCzWioaUu4KfXDKrtaT sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqwmeg21e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Dec 2023 05:27:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B24I6Xx020704;
        Sat, 2 Dec 2023 05:27:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu13d2hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Dec 2023 05:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4xh/MRh3Lqd/ejVmzvEnj/tPVffnrOF/SqBppNvWMoymJ0kKBLtpCfWXOe+BU5+QReYQHXvEO38jtSMbHJoYQWEvii/tqF+0WfWMUL92ylO9w/mE6kBk8Wey0AfyoFScVUm6p3tcplZZKhya82gFf0ryP0SwIRr7HCtHmzYwterdW8GlCEbJJF3Fb2GfIXkBcWIRxtfp9dj95qM0vysxDGrhhpl6CiPwZbwZs/LedYe2+m2fDAIkkrjCNFrJoD2csq9AGewbKt4yrdUah+mctU32qBKiHqitXL7O+9azZxj+4bGIfKzM2Ye7eyHggkOy2gnT0bl76sdpRJGj7tIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh07AeTv0q9vBA5CUdZBYrnP7mFxiVeoqOSWupUEU+U=;
 b=byU7v5/A9wyHh+XZwVMHVM6Ch7xmxbFFOZ27Dps6UiM0wuXeUce5J35qftx9ejK8fLvil1dXlVAexNSvvJmIC53tgE8fBbCloyA9bWoGNslpRKIxH/zjiBekz6emONgz/PxnFCQ1ttQ8yHmiFtIo5ra41yGstf8V1PVNfyP2uL1GAPf33FNMpmA7/W7EjtILh+pBkZxGIzLp6Q2PCyJO44UxOhQKtGt0ioNtxuM3XoV0nlDg0sQZmV+Xo/6dZi6Vbo09kcG2BYQ48rxMaVwzIpYPUSimeT0fe17UAdYEr4sM6qqmFDy6cCaD9hsJfddVn+wro9Vj/xtUcpasbW4I9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh07AeTv0q9vBA5CUdZBYrnP7mFxiVeoqOSWupUEU+U=;
 b=SWnEJrQl9f4viLlh2H6zp39W9t8t2S7nr7hfDtPrv0J55TqCwLQ4EjsAtkscgkRSObYICtKG5SzJPE8dZEO0LN0hcK7kV7HSoIdoW2NbhHqrEAvc0neDYjKWsjfHSXGfyzwvtxqSMn4/zNvszKPoFU2Qv2h3pybtNnNntnM4sYo=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by SJ2PR10MB7759.namprd10.prod.outlook.com (2603:10b6:a03:578::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 05:27:28 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::7295:59ac:ffbc:e40a]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::7295:59ac:ffbc:e40a%7]) with mapi id 15.20.7046.028; Sat, 2 Dec 2023
 05:27:28 +0000
Message-ID: <7e0b8965-eb0e-4141-b4ec-32fd688e038f@oracle.com>
Date:   Sat, 2 Dec 2023 10:57:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/68] 5.15.141-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231201082345.123842367@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231201082345.123842367@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::12) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|SJ2PR10MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cebd5c5-35b9-4473-ff21-08dbf2f75f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59y9ZDkm5MUbYn+EAEAUvKg+SUj+TV7o8Huqo95Jba17dv+wTzjgPwSmCjCTCKPtS3mUc9vR0PFeZ2CkK51noaEyCGqb5Vlx+bmAxSMzdSbWD8NOl4650EE0K1wZ19/0bWzKHzSt2vO8oNWBw3guhfFFDMQqIEE4B64XRAX9PCHyujwbzMdOfwMvKrkd1Z15nvD+cED6aYtTVOF/mngKZ8NAMfim4P7P0xVneCz7avNqfmA3ANnRFx+NKCu6hqHkfYGrrkHSpl0PmQUYIqt2I/YAOHIVdtS79te/PosMSCFz0FGWHtsDXkIosm97rBzwPKVFEVOAaYZ7rnxmKlxNI2n8Ay4QKj7FR8n5ZIFD8UsQK+ohmg64m8lXLcbEc2hUQYfSQsuKaSk6I6SyaXzwTkNG42bUBG9Yml+N+vbDTDweVTE/PvY48oYnczWXF/NDaD4i6fSA7C3V+9pmAysQR70dcz86XMwLvQiTez/8Aap3IRl7JJlR1NrzrJUJsRvX0QVfieFmS3HvKjKYEoXdQ+RVR9aHYlcZ2p9rVW2IxLCySf1VZsTVm24iRmrfH7k56e3jGqTPuAXg45UsBm7UxeffWUN7n+pZYx/bDQjPt//35XNbaxNdH0eXN0Cp9yVbu3c1nzjwsopWQO1mtbnJlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(4744005)(31686004)(2906002)(8676002)(8936002)(41300700001)(66556008)(26005)(6666004)(316002)(66946007)(54906003)(66476007)(7416002)(5660300002)(6512007)(107886003)(2616005)(53546011)(6506007)(86362001)(31696002)(966005)(38100700002)(6486002)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUNXY2pIa2Q1bWFuaWdGc051Z0hRSFJOMEVuYnlTMHBKRVhsKzZId2s5aHBV?=
 =?utf-8?B?dTMrZVFqbU1mb3ByS2hYNWd3Tjg3RzQyYSszeDhGYTZTVzFKTVpwaG42VXZj?=
 =?utf-8?B?MjJkRkRqTlJZTWxoUENrSGFBQXZJMFppVHpsdm0yMjN4S1JWTkdhd0Urbksw?=
 =?utf-8?B?LzV2Uk9XMEVNSGxDY0NWRE9BdkhBS2lUc2FFQ0FUL0k5a2tRRDJYWTZ5WWh0?=
 =?utf-8?B?NHl3SnVvcHpjN2ZoY0M1RWw1K2lBTTFYb3hRZ2dpQWZhSHRDbFRjNEp2OHQx?=
 =?utf-8?B?OUVWdVZOKysvTUtHNWZNbmJjWXY0V1YydThXK1poMW0vdkUwQyt5Q1FOQ3ZP?=
 =?utf-8?B?WEw1WVIxZWRleHY4M3Z5L0RYUGpJMmFESVBIcCtlWVJEMVZaTG1CbjJaQXZI?=
 =?utf-8?B?dlJKdUtNQnhwNjd0SGw1cHBIQWpxN2dlMC9UMStyNCt6WjhiY2NmUkxWTVUz?=
 =?utf-8?B?NllCTUVnaExxSVJqMVZ1bXdHbG5PVnQ2L0tzblhhazlWU2xGamJFeEl0L2cw?=
 =?utf-8?B?Q2lyWVVFdlZwR3dkVjVpUDA4d2FUYVFBbm9TejNCemk2TXpuU3VlcEROa3Ru?=
 =?utf-8?B?YWlFbG9vK1Z3dHdKTFBCVFgyQjl0NU9qTkcyZU1ZYjRzakZLNm51SDJRMjFr?=
 =?utf-8?B?OWpyc2hhSjhqKzRUM1EvR3A1UndMZTh2WGJFZVNqUXI2N0Myd1lpQksyUlBu?=
 =?utf-8?B?bmEyNDhQVkdDRWlXaTRYR09JZTJYU3dnSVNuNk4yL0oraFVhWlk5clVZVlFx?=
 =?utf-8?B?VVZJWS9PWTR4V1kwc0QrSTl1QW9RZDRNZFhseWFiRkVZSG9Ic25wZ2Zyei8w?=
 =?utf-8?B?cnFIQmlXWWFHZzhXQ0g4L29FNzhzNXp5V3ZTYTl4L0NDTHNSSDNuR3N3STBM?=
 =?utf-8?B?ZFU0dnMxTDhkSE1KY0YzZVNqUFdPdVJQZXdGc1dmcVVRMW4zdm9ORW5aMUZq?=
 =?utf-8?B?V2xPaENUNlhLT25DczBSU005SUNxTmNvQW14NitYTHF1T1VYcDRhdHBRYkZm?=
 =?utf-8?B?OWhEeGNvUTcrY2swMm9Rd0NncHl5YnRFL0FJNmZ4eUw0VVhCUi9RbUZ3ZWx1?=
 =?utf-8?B?Z2lZZG8yRmI3OHFnd3kxUXhyOGp5bTRpQ0RvM1kvSTNGc1ZXMjFjMzh0TUVS?=
 =?utf-8?B?VVRVb0hOaVNrMHpoalZiYVlnMVhZUzhBVHNQTWUwZCtuTit3Uko1V3hGTklp?=
 =?utf-8?B?K1VwYVhVQjRRWEtNcnI3d3k3WFZ2cFVoSHVyZHpmMjRGQWhPRkVVVE96QStt?=
 =?utf-8?B?cUFMcWUzVitHMHFMdEVNM3phNjgrQjRaNTBqdU4zN2U5QzM4TXM4OU92WnF0?=
 =?utf-8?B?K1p4WTUxU1dLUWJ4UDdSR0RaTXJPMUl0MmdpNXdheVZWZjVTTEF1R2hsSmlT?=
 =?utf-8?B?WFc2WXhXNGFHQ09lNHg4bVZJNFNRcmhsV0gyb2RNOC9YV3luRDMwLzVMMUZ4?=
 =?utf-8?B?OTNjdjVmU1Q3VzF0Vm5sT1pFYnpQbHI2Y2hoSklKRmJlWUpPcU44UDhCejVH?=
 =?utf-8?B?UHpwTFFmL0tlckdRUjk5OGtESzhWM09BZm0xNmNzUG9pYXo2M0RYRy9RZ3VQ?=
 =?utf-8?B?VFVXUXVHK1ZTZk1UNlJoQUJPYjdQNkJNSVBtRVhVcEJCYzJmUDhSWUNXN2U5?=
 =?utf-8?B?dEYzSkhoVE1xeWZDd0lZSHduZGxBMTArWmNlZGlRajlpLzRWRmtEVTUycWRx?=
 =?utf-8?B?aDh3WHIxb0I4TUZ2Q0tQVFJneHl0L3BCVFJtSTZBaW9oWTcyRXdGMUxENzNT?=
 =?utf-8?B?dVh1UVg5Sk9WcERqaEFETytLekRtOFV0d21mU0s0Yk5FTlIxdCtkZE1QMzda?=
 =?utf-8?B?T3QwYVF3QUVaTHZFb0JuOHc5RzJlNHA2azBmaUJNNEhvRVprUFJpK1l2VEY3?=
 =?utf-8?B?RTdvMTEvc1puTjFoMUFvL1dZMHB3ZXM1YUZrb1FBVW9KTE9qZHM3N1RHaGda?=
 =?utf-8?B?VEhzOTkwK2VBK0kxd0Frd1Zla2RITFFOMFZ1eFpGVHZwbjZONUlVMnVST2ZS?=
 =?utf-8?B?ZVk0b1hyLzFRZDBlT1liNEd0NTFLajByTkdhNzF6L0pSM1RteHcraUNHRjBD?=
 =?utf-8?B?RDBHdUNrK213Tno3MWQvVU93V0F5ZmRHcnQ2bHJ3RGQ3R2lsMXBPdE9MRjlD?=
 =?utf-8?B?QnFTUFcyaDRLZnNSRlJ4UDZ1bGJOa2VNdjlvZDk1NENBVDRZdzR2bE13bzdY?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WW4yeURyM0UzZS92NG9wbGRFdWQrbmxzb2dzUldyUDBMK09UZTFlclZLRFVX?=
 =?utf-8?B?Sy9LNnI2ZStSWXRQZEtrNnVCZTcvM0c2Z0paa0tXMGpDWEdMMC9DS1NuZjdF?=
 =?utf-8?B?dnpVeU90NjJkSzN6NUhXTU5tQVFaRXVoSHpCZTZmWGFNN1ZVR2xYTGZQUThv?=
 =?utf-8?B?UEFuSDR6S09VVEx4dHo1eUI1ald5M0tueXJjVS9uaWFuNWdubDdOS1k0UzAy?=
 =?utf-8?B?TzN3N0diNmJURE1zOVV1MHNDNHhnWnlDODU1cHBEcG1tK3N4TFpQSDhncFNu?=
 =?utf-8?B?YU5xVTZlczFzMTJESDltVjZ2Um1XSGlrWG04UE1qZEp1UEF0K2IvL2N6eEQ0?=
 =?utf-8?B?VE1BeVlmL0NrYlczRnVtc0pRb2tSNWRUN1plaGxoWmlMb0FNaitBYmptdStL?=
 =?utf-8?B?cU4yU3o1Y0IzNHdTdm9pZ3VtWlZPVk81WWVsT3MvSFhmdEU3WmFPbDVCdkQ0?=
 =?utf-8?B?ZWkxdFk4UE8zM2gwcTFkNmRRWUNldXg3NFMzN2QzRnlFZFNwVWVCTEx2dGxL?=
 =?utf-8?B?T2UrdzNnZXF0RHhYWERlYVArRkZDNmJ3b01XME9CdCtBbzdPVFkxc3pVaG5s?=
 =?utf-8?B?VVpaNDVMTFNpT2dEbUVEcUxOTFd4b3BnLzllcnRqRXZmSWJzZU4rcmdnMXUw?=
 =?utf-8?B?MG9xbHlnUzZyU1RzMlZxcW5FZXl5WGxhWVZ5VmMrR0R0amV2cVNSM3c2dmRY?=
 =?utf-8?B?UFJjS00zakxBYjNXN3pLWml1eGVodlh4UVQ0RXpOM3dCa1ZBSmF4RmJxYlVv?=
 =?utf-8?B?TGt5VThoTG9xUndRUnJhRGNUbUtVZXpWM0szVzc3cFY3Rm1rU1p3UEFPYnQ2?=
 =?utf-8?B?MEVKWktaVVJ0S0dqSDRrd2FDYThBY1d1VmJZWklaWVdtV3pYcGVkTkx1Yitt?=
 =?utf-8?B?aDNMdDA5YWZIRnk3bUJNazJQOWFLMzc4WUVucGYvakM5WHV5cHFDQmZITU5S?=
 =?utf-8?B?VmMvL1Uza0VjNUtCNnJ5cE50M2xBWno2WHZWaksxVWtTSlhnTWxFL3o4R3I1?=
 =?utf-8?B?YkFOSDltUVNDMkRUYzNuNzBvN1huS0pMcTc0RXJVSVpuNzVycHpKdzBQV3R3?=
 =?utf-8?B?RzNydW5zMUtkcVVYeW9vWDZ0Q2FBTWxPZnQ5aCt1WnowekQ4eHJDU1ovYngr?=
 =?utf-8?B?S3BGdktmQXl0a2pzN3hQcXZWWlFvRERsK2NoQ0JSZGJkTytHL29NdzdSS3Nq?=
 =?utf-8?B?KzAvYlFyR3hrNzJNNXJmbWJSL0JKNHRqc2dJQm1QUmswaVA4VjNXcGZMUVpJ?=
 =?utf-8?B?MjdVOFBNZEVNY1VoM21lZXBzVmQxdE5aN013S011VEhDNWFUMjV0djF4YmNQ?=
 =?utf-8?B?WHh0dmhSUkRzMDZuNEtHemRNMzhKMEhBVG9BUjZDem1BQnFEdmJ1U2o0ekdU?=
 =?utf-8?B?eHJOTTMxZGJXRUMzY1NGZGlmdGtBbkRGNHBGeU1MdjY2ZklIK2l0aWpURHlH?=
 =?utf-8?B?c1pLMVVKSlBJMkJjS1AvWHRXK2NNczdrWGxSVEhZMlFHenR2UGRuMzFEdWFq?=
 =?utf-8?B?bGFLNFQrV0pHT3ZQTFFhTXRDWVZkczJGSWpCc0FUTEoraWg1dHNIUmdZWU5G?=
 =?utf-8?Q?VGGpfIX0ySCf55ulxsubmgOg5HBt58BQrfEw1aXdbY54W9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cebd5c5-35b9-4473-ff21-08dbf2f75f59
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 05:27:28.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC88UpPOzs+9btbZO65mMThEe90Jm3NWjvDp/lVPJeSBS+rVxMiqhTJlar+YzilosvyXMjH60U6eNflniUvwmv0ou/++I3kn17MQ91a/6pCsQ616B/bSnGWqOYDR5Blr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020039
X-Proofpoint-ORIG-GUID: ajXdkdICTgTSjId2QwC77zAyByihynhi
X-Proofpoint-GUID: ajXdkdICTgTSjId2QwC77zAyByihynhi
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

On 01/12/23 1:55 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 Dec 2023 08:23:33 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
