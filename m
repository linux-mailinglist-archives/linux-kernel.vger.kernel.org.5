Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC19F7DADBB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjJ2Smi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2Smc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:42:32 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C93BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 11:42:28 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39TIfYC2002412;
        Sun, 29 Oct 2023 18:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:content-type:mime-version;
         s=PPS06212021; bh=EDqaGka+ITVEPyR4ERIE8orolru4Frm8kVPjYvwLSiY=; b=
        nPOUjQZwxXJwZVLLA6V0XXQWXnek04xFLLMWZoHE5zPU9DjV1GDxbl5tek0G072Q
        CL1bu5KIPK46y2aeHHaOpa9qZ5AHsH34m8HLyzLnVMFAlkSVCeIF+fqiEsO/KLR1
        bpXQ+BCulvURaK4zZz5YP3v/orP9N8JKQR3yPDhx/eXYnfFxyigzYiZwHCv8qxHn
        et4ozCM9ruufHVx9Y1bgJ2RAB1kL6FqtFn2qE2NnZHDLXvbULwkQIWdzFknYhYre
        ixsR66AoNXgaUYCa140JL6vjJ4oHByLvEw0coLIGCnpc6tESKx7UnQQICNWu1TTh
        x+VIzbvvipANeME57Mh9zg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0qgxsjuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Oct 2023 18:41:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh4BBPlMlfGKyAybZxU6VdSutXs2rjyPet8jy2FQHZoPQ/PdOlhXA8bYa+HRGdbeo9limlbcGqgs/xuhkMRgcz58QWzYRgGUk3iT34YGmkjkRyOfkQN4M1U+JKdxAX88dJZ4bq0QkiAoKvqWXU+vFFYI5ScuApPr2ilwC2hrfSidNSGo/QmgWQZ8FZyjoi9UX2r9574vagdx449Xdnpw8mjC3x0tcUtjhTvywM7jHj6SuFE2YqpbwIXH99qIRpU7MutUSNeuBW/L+jj/dTCsw2vo7Es1YD8SVLIvsdZ1kG8QzVd2Z8BaJa8uOlGjdfyLIaBwagwOomZj9CMkXIZ/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDqaGka+ITVEPyR4ERIE8orolru4Frm8kVPjYvwLSiY=;
 b=mzt8X43nTQ5uVDakDgk8SNSK6MP4NEWK1Q7bEEumUtsjCvNaiAQhnVvLasiMNtYSz85pWTTyJ/GepQmSQq9lMDQAQXJ8ue+iRGcm4sMPFnC6Dv25YAs03R+hrKnEPMdNJKsNjuGprNO0Zw6Ti0nSQ7JuGwVS2Z/VSD6jUWl8Ll+/SF+7vLKeKxptbuUYL3Y+EPxJTO+v5t5UGItltati93KF2w+6puYFYPykpKSkHCWKAR0r5wJAC44Z/HOdkIHWAyFO1fSE/muA1bmRBrUOq+CrZGGwzqMxoP6Fed8sjqQRW7DcBA+HofSl+p6b92ADViUFFT5kzZAcGJSTJp+ubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by CY5PR11MB6342.namprd11.prod.outlook.com (2603:10b6:930:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Sun, 29 Oct
 2023 18:41:50 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.6907.028; Sun, 29 Oct 2023
 18:41:49 +0000
Date:   Sun, 29 Oct 2023 14:41:46 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <ZT6narvE+LxX+7Be@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: YT3PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::13) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|CY5PR11MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e13e102-50bf-4362-59c4-08dbd8aeb62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFakfBbxm5KsMTT68QkGVeBJEV6Q2ltgaX5JeMgIqD8quAkHuCE3XEpN+BixR20v0ejMbds3RFHc1nhLiIREg+s3CrkjpmSRNfQGwDbnbf4NKQaN6MY19vJ1Z2ILM2fPSStpq1tkTj9LOpW48tiJZFCCMNNbq2pkwUoWchM9Rm748ZVCcLb2BORIpAztrjJBSvhSbfBeqnBdghJViv9MGoAu14cAg7h/rxbQjzyb61B1crdDmLFs5UFUrorZUYZZR+3FfyXcjWEXXFqTs9Aue5iHD7qa9CjclNXh+6SF/Q9Ci7B/RhXIX+HmoXIqb+XmOVqimLfu20jaQu3UTq2XnFAwHC2mAjUTzkoYPZsTr9/eemluEmNx/2vjjAqqFiKuYV7hbJC7ZOfrV5ykXzjI5JZQ3v4PcweJpV4oaeFf3gXz316NFmpdgSCIhzPeR/Jk7c7Mg7pwJ0btwYRSRVA9wUOvLhhJOotVJGX8Eh6FEMAspwg9P2AZMGBiE+eiaURIMbWVFyScbb0PKBMUEZpnDLbjTAqmrMu5b6Y2DuMNCbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(54906003)(66476007)(66556008)(66946007)(316002)(38100700002)(966005)(6506007)(26005)(6512007)(6486002)(6666004)(478600001)(110136005)(83380400001)(2616005)(41300700001)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/PHKM9/v5YB0XnCPm4Wpjqwh/iOOUBGdeod9FKawrqtbXtAKCSt4v2haKw8g?=
 =?us-ascii?Q?GDfi6PfCixvwf8Ex6QVurOxUiiDB/tSvzCcQbyHGOksazhP7fL8fc7ZjbLD+?=
 =?us-ascii?Q?dw5doAzY1koez/DdPpgvaa3jfK3QtPu2GWDMhLxY85DHfphLJAnFZP9+qsWH?=
 =?us-ascii?Q?tB251BUoBQ2LSdJFkul/cuqM2ZIlkZOwkYdPjnsHdA4FxPQqrKujrq84gpJG?=
 =?us-ascii?Q?ysc1wPJuoi3uJYmuGgKyxwH7RfVGr4cLCQcYs4FeJgwOCShdbaM0Tc2mYkAB?=
 =?us-ascii?Q?EMLVOwpVDfdwIkU7ixgw8WLI12QstMtfcDr6qyadinN6W7FHCPFGSYaxCyRg?=
 =?us-ascii?Q?BUkdKpVLPKNmRqCOEkwwOdL66RsdX6M92iw22m9b12EFWhpflNUpFJ4krCrk?=
 =?us-ascii?Q?HgUQn61denfVUtvbkV0MFKi1qX4sJExhgbRje1ckGOUu3rIGKF+vfzFIygRY?=
 =?us-ascii?Q?A+5Qq52yHl31VKB1Tuu9Lc0ByH0UypeopQFZxLBs0jMTrHBrWronQBvsiH48?=
 =?us-ascii?Q?a4kQspoQrYE68b16FYV8J9HnedMJVxdhya5vd9ZmUO9e0lYc0gRX1R7byBcV?=
 =?us-ascii?Q?aN5LjMU6cJpvxX8zvKQ/ZC5Zhl5bDJZaC75pfay869svwrPu15BaIkXcEjol?=
 =?us-ascii?Q?ufkwQnvZLDUG3Mv41MxpLf7dXtCvwTEV43Kvz+I8jwIUOnV1dFFbo2e7ybqY?=
 =?us-ascii?Q?ASYlNmafvrI5aGdCiMZCAdKBwxo5mTgvb8852uAIzJMEH4RjofCk56/OnJCj?=
 =?us-ascii?Q?ytJLKM4Zmpnl4m97E+zUKSR2fiaE6XU/AU8a6wpxpirOLq0gxXw5/D8bfMOP?=
 =?us-ascii?Q?ss+D5Eur/r8KAtAbPFf05wYg9Pgr2uFhqujwwKB/M5xx9wl4hFohE+0dD9l/?=
 =?us-ascii?Q?hTsocIxxc9dgqwG3D2Hn2MK/WaDRdvWPqBAdImgzF8l+EoXIhuvq6PhMCQlS?=
 =?us-ascii?Q?bm3fzJtwmwNIQrgy7ppCHfCSVIRPuBfF9c7tXETnxgLOiYgcPd/PWthRdu7c?=
 =?us-ascii?Q?ikBHaOlb5dxuWhIqF43WqXC8NFX56iS1Nob2yi7VSVHzZdiquYKjyL6WYWof?=
 =?us-ascii?Q?DjkmatcmOLAJq5gTzgqaifSAlOaF230H6vTA1P7tFsL8qSy4IpWl/ETSh9si?=
 =?us-ascii?Q?ammU7AqMORyK+bxxP7KN4fRVvfajQM3jF4Ifzup21vxqYh2I1xBabUuwND6d?=
 =?us-ascii?Q?cqF/nBifGviY+q+KV5KZmw3D6+Wzf0cnXYhU/ZD0TFWwqR/1lk5Q04U0ri3d?=
 =?us-ascii?Q?1ZagiSpELtKWMxoAMCTkYWwQu8rRuslw5WjNjhwlHCDRpzet/gOnNUrpnvzU?=
 =?us-ascii?Q?1zfiv2mWeNaAoS2lQg7oK2oAqFBRfTnBmqSgH8GsTjr8nXOdLj6e2SuX4it5?=
 =?us-ascii?Q?8VCAdeCNlIO/OkYvmL2ORpyU1uhc+OeitLR575AWRPn+MpmCmavWSry+4drl?=
 =?us-ascii?Q?6pU1Wqk8f3KYTIRfRmFmxwSzguHYqD5f+CP/yqCgkIuhSyMpydcHrqe2t7/i?=
 =?us-ascii?Q?8Dg3KkP5izCS1NkO3YsmSX8XwlNkzLjhaTfC8vTlRT0J3lnXl6EpKMrQgq9t?=
 =?us-ascii?Q?+/wCJ2PM8yLCuXxtMCol+9WBnnbQKDBwRXGIzrBHl1FvHf4mFZGs7YJDvU8a?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e13e102-50bf-4362-59c4-08dbd8aeb62a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 18:41:49.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiU9/wABlM+x7NhkNIohtCQDBwPTy21p5EH/HXvo7LNPdx/T7NXUlqn8BqDI8yeFEp1AtoEBMO5WwKn5AHNZrUy63R9HxllNUc0Kr8RUGeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-Proofpoint-GUID: gJaPUvYNxAbYzX_x-HtF0MPmNNWW-zLI
X-Proofpoint-ORIG-GUID: gJaPUvYNxAbYzX_x-HtF0MPmNNWW-zLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-29_07,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=432 clxscore=1011 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310290161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TL;DR is that the Yocto folks encountered a regression in their
automated QA tests (after a move from v6.4 --> v6.5) where non-KVM
enabled boot tests on 32 bit x86 would (with ~2% frequency) splat with:

[0.326235] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[0.326556] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[0.326965] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[0.331789] __common_interrupt: 0.167 No irq handler for vector
[0.331789] __common_interrupt: 0.112 No irq handler for vector
[0.331789] iret exception: 0000 [#1] PREEMPT SMP
[0.331789] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.7-yocto-standard #1
[0.331789] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[0.331789] EIP: 0x60
[0.331789] Code: Unable to access opcode bytes at 0x36.

..or similar - common theme being FPU init and __common_interrupt.

The 2% reproducibility was a problem, so the Yocto folks asked me to
take a look, and keeping with the TL;DR I managed to bisect it to the
tip merge of alternates, and then in turn to the commit within:

6c480f222128 x86/alternative: Rewrite optimize_nops() some

That failed six times in 381 qemu boots.  I've run the commit below it,
14e4ec9c3e91 close to 1500 times (still going) without a fail - since as
we all know at 2%, that bad is bad but good is only statistically proven.

I'm not quite sure where to go next.  Has been nearly 20 years since
I've had to juggle NOP counts for some IMHO broken MIPS pipeline.  So I
figured I best report it at this point.

I've put a bunch of details in the bugzilla of the Yocto folks here:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=15230

Skip ahead to comment 11 and you'll avoid me chasing FPU changes like
tglx's FPU init relocation commits, only to go nowhere.

I've kept kernel build dirs, boot logs, etc for all the commits I've
touched down into for testing, so I can revisit and re-test easily.

Paul.
