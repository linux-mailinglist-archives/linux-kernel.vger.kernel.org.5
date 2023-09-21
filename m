Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2B7A904D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjIUA61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjIUA6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:58:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9803C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:58:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ0L3003969;
        Thu, 21 Sep 2023 00:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/b1aAZuctCXNxudmheQXhpgOGkshvcfeGSomy40UZeI=;
 b=oRR4klzNgzN210+yvOqaOZU7PLAxoQskyxSXN48QF/c3A5CV0bULygnd3Of67/cUiyst
 XCH5xQ3YveVzvrEfliOmUy1spHv0FdRSullXOOhmBLZaCJ3ariXcgZOjf0GfZwWup++G
 2rL5SfmvluZVFiT8MxgiW28Cw1fzBC98JcuwN5bOerBLjDs411gsSrJiVDLtZ723U7c+
 eaTfpeZjf8NrB2QCI6gvPuwNRASTPGdpnLNL76IR+Qt4Q3SsTnRm3ropV3PgQ7C5a9dV
 EsMiser4ECnaAyeOo2rmdUXMqQlTlryUijBGRFjng3mZfguQ/wcAwk4KZM5YdyVCIeTB Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53530p7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:57:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38L08Q6a012031;
        Thu, 21 Sep 2023 00:57:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t83tvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJBc6GveK7Ktv8x816GDAWwqDn7P5CqMNWmHSrwMd47zJOfP4NRiUWN3FQlDG02T3C2hPcA9FodJcnCnmzvhe1P6ux8oay1OKGXOgR9HL35HVo3GBMnxsxmCpjj7s3mGTRnkAMPSY9oGy7OOi+NENJIFyPwUUHg5Hw39f7wRXYF29KUED/sIyX8fCfpEXeXYN0Gksjg9UV4QnuCiTXRfdfzS74SmEE6hIGq0oBfvrPhgsvWMh+0/mOb199Gp1Tb8n6jBnTFWNvJs2vuDN+agozUNWcCOoYrmreuGT4dSjxMjzgjFVgJu4r3vrt+ZN47opp866eMYhz9/tErbe6Gusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b1aAZuctCXNxudmheQXhpgOGkshvcfeGSomy40UZeI=;
 b=gqGkdHUxoQUMbNz6SuGKA19zCmrqXVeQBuu/jM/CD5kczk3wtPR29lxYHodllkK6pLboo4ZQTLbQpdDgNZtQ8W9oibMV3h1Mppk2bXrs0DIB1e33EoPUWOQ4nVERpYZlR9E4U4I+tvao2o7tt4ltCj59+mR2ysvf8Z9LjFIC3gVyUzkIzfPiv0Cj7xS+AVXtbjpZa6yU3sFb9PO+H67fInTvtgc5D6F42H/Dh6oPbVPWEmLDVXqIY+IEih6uHvMB/dT0h0LcJ/LJEGZeUbsDmVne/EtORhXkk23jKl1j5hN1ueHUcIZI9Gmlpy8lb5QEeYcYSjoUDsi2ZBZ1wHCRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b1aAZuctCXNxudmheQXhpgOGkshvcfeGSomy40UZeI=;
 b=Bn7UcKvtlIYtig0kKiDlZ9bl5Ix1ppjB+nQ0zPqHGGFgoPjjlBslAGvnfVgFZem5rSd06C4nMyM5XDslwSD0MocCyBhW66bEt8KkiJzqg9sb51/oLICjYwyu5p335m/1TDXttjyel9GtmeVAxNfehtaLQIDv4U2UthJt/OpgND4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4555.namprd10.prod.outlook.com (2603:10b6:806:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 00:57:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 00:57:16 +0000
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <8734z8v1lo.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <8734z8v1lo.ffs@tglx>
Date:   Wed, 20 Sep 2023 17:57:14 -0700
Message-ID: <87edisibrp.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b351ae-1528-4a1d-7541-08dbba3db316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Syz6kvQKCuQ6Vqkx83IyoE3a2oE2DMKfw3SYgXOWECeQgmmlcrG3fY3KUCoE7gTgEsT+te6r/DUmj1pLHMPaQs6oGZoqmMaNqBZforn7ytCDYI1hLK1PxOMtLsr/50TeROm+D64xDEhpqopcDZ6Y9HedMrsWE2tKbS2vqWKnFAeRWNifzRDdaApcJuqmICihNwzNpncGR5dC9vnK4zTBJcUcbKRvh+SETBgFd6znHnp19JKi2pXqZmjJ2lRSt6W5hnku6kH9BHsy78XXtJMJFtQdXJVkFL/h6WDpqrsVV0niGCuOc6eeV/AhmAXLcIY6eiqYzijrVuWOSM8ZxRocClo0nHLzF8BunG1fFnkliZLzs4CPijjdARs0CuSy7zeI87ENGyF8w2ZMhynOHmCj83m9VmKR2gGXrtmaV8LMTyu2KgF5TD0wJm41dZCOJ3OVNOaAdx4AEMYmsKIn5Wdsm3lTYZQn1hA/9uxpb2j6trspM3MbDe5y1dR989Q+KYPs1Swsvu3LNICtw25xNC3vcIoqzmMMgKzSLPrb3wFnLgMudbTKWPWOXzN0ZWXwjg9X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(83380400001)(2906002)(54906003)(36756003)(6512007)(6506007)(6486002)(6916009)(41300700001)(4326008)(5660300002)(66946007)(66556008)(66476007)(8936002)(8676002)(7416002)(316002)(478600001)(86362001)(38100700002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Oidb+Zm5Djar3LJwtqDJavSfbDeLJjvew25seiFGMXEliaW+DdWrIFBqtT5?=
 =?us-ascii?Q?0uJyl1oBO38a/kkDFwONkEQQ4RHh3pO2P2nSd8njbcVfDEcF2XdGTb0LCcky?=
 =?us-ascii?Q?48YxBm/umlzBR4PNX5fHqKhCZRJQFPUw/Yy7BMUnZeFqURf1WlSFrVNtTNuB?=
 =?us-ascii?Q?BREzYiBnP2KHQQ3PbrOYY9Q/wca+d2urS6NI50ySyQSRSukk6P5x9XcD8Oat?=
 =?us-ascii?Q?ZvmyxF5a4wnkWWWxChiPIe247NFWTo1M+TCn9honr9m2+XE8t3l7Q0ugPadW?=
 =?us-ascii?Q?vp77jQuMjoUFpbdAwkP/pdMnrwYhNmbI3UTZ3Fm0bkICYHYSEUrrf8E8Me0G?=
 =?us-ascii?Q?dVSsnDlljVsyNDyEAKD5He/92cxYCO6KhVNpaKVV+PbomepSk8yOoZtW2tgQ?=
 =?us-ascii?Q?c6y++95jDpsB2H8tDh/Lk/7vK83qoOrXSrH44P1tD3Aq8X1mzgcjr4voLKi9?=
 =?us-ascii?Q?gnv/Jriv3WAwwn5B7JWR4FwqqbdPIThAHbenx8qvi3Z1PF23+Axq0dZQJ1gC?=
 =?us-ascii?Q?itwL5JQKblMGbQ5MUbugWu9YzzZGRDWOO63z5k78F/SLw2PdllDg3WxkoaNL?=
 =?us-ascii?Q?zJ8nOYcEqHmNwKLqE489+6GpDQ47CZIsv463VrIhh8wENzIDMavVzJmkGwz3?=
 =?us-ascii?Q?3AW1GN4JlGcIGRyCk4xN785xsS89Jv3zgu9PNz9X83HM+b3vxPST4vDi0gUY?=
 =?us-ascii?Q?4wriIKkTY6jl2UVji+9vBwSgh5mlasTq2YmiKuwd1Gt8SFFUxklmmS8UgmUZ?=
 =?us-ascii?Q?TvyuoNC4OzjOnwpp4Ad/7JrVSknWhrftzlDhvhdprPFLCdrV5rVsVnJFaUyf?=
 =?us-ascii?Q?eNPNJ3OB5l2Awdu35gHZ8f2Vf79kyNNDcADDy91nzi0UUVo7SjjAqXwcrSXm?=
 =?us-ascii?Q?zbaapYZVcR+UzZ+xBDdcdla4pnet4VXQ8X5SJz+8Q7IT7nsMgUqr2r+Ib91a?=
 =?us-ascii?Q?j3p230kA0/0eJ4+34flPssV58VtFf/CAJ+FzMvI5iraXPgu1eNWPhu4c463F?=
 =?us-ascii?Q?hIsjpsOJVgNT0TBuiUUcpmKkAz1IdDOUpBmmIAs+eeFACF2EdQ0A5jnArd0k?=
 =?us-ascii?Q?WQOW6NVCgUYhm5IZIvo5zp26h0jGP8doyIEETeljUuMM241f3VhtTgHRLtU6?=
 =?us-ascii?Q?c+baLFJGsA0pwNtsHphJPoKEOZ/r02Z41fer+K80qbkCSb/OvAHP3HtBtu/m?=
 =?us-ascii?Q?1b/4K7/Qm0mz6j74h6SsgCqkPJ+Y2aIVktRdPRKx53Vjca0SzD0AHWRtR740?=
 =?us-ascii?Q?85zfyf7RFY4dvnQ7ZRU2FKtLATGXOuWtZq+q0kOwgpXCBZTMxJ3ZtE+JJmYU?=
 =?us-ascii?Q?cv4UG/TXGDI+sj7+U0+UMrv4pYHQLVXdW5yS52FAwJjb44ZeZXX+exPKw1v/?=
 =?us-ascii?Q?UQNgZ1B8nOAcEG8DHTlYyfdLnGzciO7MVM6AOBCmzV1EEtAJgRjY8LTwmK6l?=
 =?us-ascii?Q?/zrZrnkz6++0WUHNI9ohwI/HYUNlJa2T9YgF2rYdcUcwdE73WA/EzCoLzfFF?=
 =?us-ascii?Q?tc+eTLbRmSU/EjCUeTHKMYbmmpiy8LliemFYtMnaK006IQODxPJ4cs4zXACn?=
 =?us-ascii?Q?BcNlrkRAjvQrB/Q9+3eEFesUsdBKBxLNUNaIdeyCSofrgfEFctqlkmxQCpUf?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?v2wxHzMHijCQc1lW8fUxCXdJpfJHuOJbXBHDck/1PRtgRfo6AEvrRYhBhvGU?=
 =?us-ascii?Q?mU1lWtFXJTuwubCsOiIJCqBgN/PuVYPGbti1r4WUOWj7uL5H0AKHRiniPKHB?=
 =?us-ascii?Q?W1EhcwW4GQr/ookBj8pWx7Hg9+LAVvDnEfBR/FLmnscE2iMTdJwWUUHjZXxw?=
 =?us-ascii?Q?cwDNwJnIReIMy6JaVOf8JGVEb4xsXB4rqFJFnOEyudxkzQc+VRjR2SBZDTWc?=
 =?us-ascii?Q?CZDuMhw/nIKOhWNGBLXFjp8Nw3Rq9F1HZR6sa9lO2f2JJpN9rmQWBLCaOW5k?=
 =?us-ascii?Q?46hw4fozg8d8EWgmj/Orv7Q8Td8rXjXmWB5ILn7m2GEtVzUQ1C3tIdgTpaOG?=
 =?us-ascii?Q?s2DbwjUP502yoGTdPEwPJR9QdnB3dx0UIkeD1J5j/ggVxkKkgTmiNIAsL/nG?=
 =?us-ascii?Q?e2+DGfXhA36LAIPl5ylw84YYUZQTlbOY87E/S5xGdHi+Sn++Ow+Qjcu+5Vi5?=
 =?us-ascii?Q?flkuz+0sUAyEPQ7Ytgu3626CSZB6W3ZLFOSVszc0ZkPrEWd0El+bTmGh9ap2?=
 =?us-ascii?Q?9iVMN+ke2K2/D+Y+weom+aBpimyZdGDRh7epXRS1R6iA6IMpCJX2/WjWOzRQ?=
 =?us-ascii?Q?+19MfaA5KHx4qRmjVnSorL+hrZ9yGh3XrlrlxB/t0T1YvzF4SEvRInZtMhw3?=
 =?us-ascii?Q?/fwFr1dtM5NlJRMMeWtIq9q8kXyalSWo4+7+1tztlcD4wmqltlHAYXN9YLr/?=
 =?us-ascii?Q?QwVJ/YcQXyVr8qNMwmaYOppckc4ewNTyRAcB1Xg8u80Ie1Owkk51UsuthLmu?=
 =?us-ascii?Q?VZzFZvP1sud4za+d/2F0m3laqaqmgCD6FxTqJLIHflyZvP3+QV1terptTN6A?=
 =?us-ascii?Q?RJbSjyjA1S8TmlrpVV4JZ3c5/V/kVZjzbujLTjAbcu68pREZTvxCdOveapoR?=
 =?us-ascii?Q?tJZddk2BryOxeQzbOeujvwsX/AXkmsu4JRME7l7HV+cGr5aOfPpr1S5OBrgL?=
 =?us-ascii?Q?atcE019sttu0mK5eOG5fyYGLiS6Y7BgVtlox3T+sZhX8bXjSXYo+Cy36UsgO?=
 =?us-ascii?Q?UFBZG0Z25era7kN6G3GFEaGshhsI1YhgG6EasLljR0vrNKt1MDGDdig74Sp8?=
 =?us-ascii?Q?YyJ9bqzZyao5rstbqgyFdgAA6andLI4518pel5/LshRFUu9ZEDiaPUAF5Dao?=
 =?us-ascii?Q?CpigFZSIW481ohnJqTGZnELPPm4hhgwpeJV7lm8Ac6c74Tx9X3Kec2JQU+PM?=
 =?us-ascii?Q?ocDFYauVj8W6zJSN7386Si2Twxg3gQd7IP92x9SOKESrkqK053joVkm5MVC6?=
 =?us-ascii?Q?TMHp0CRTho4bhqt+j48O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b351ae-1528-4a1d-7541-08dbba3db316
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:57:16.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANEsPcSBzpTEMW3qiVNeiC9z/1MV0XiZdoMrkhwxoE2rfMb/r9yzjPktAN8gHgQ9V0Df7LHXAiaDY4tD7N88BXWXpdzupFDmo9JyCD1i2Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210006
X-Proofpoint-ORIG-GUID: T6PTH-APtC2lGXNIoT-SDUgjHD4cciSB
X-Proofpoint-GUID: T6PTH-APtC2lGXNIoT-SDUgjHD4cciSB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Sep 19 2023 at 14:30, Thomas Gleixner wrote:
>> On Mon, Sep 18 2023 at 18:57, Linus Torvalds wrote:
>>> Anyway, I'm definitely not opposed. We'd get rid of a config option
>>> that is presumably not very widely used, and we'd simplify a lot of
>>> issues, and get rid of all these badly defined "cond_preempt()"
>>> things.
>>
>> Hmm. Didn't I promise a year ago that I won't do further large scale
>> cleanups and simplifications beyond printk.
>>
>> Maybe I get away this time with just suggesting it. :)
>
> Maybe not. As I'm inveterate curious, I sat down and figured out how
> that might look like.
>
> To some extent I really curse my curiosity as the amount of macro maze,
> config options and convoluted mess behind all these preempt mechanisms
> is beyond disgusting.
>
> Find below a PoC which implements that scheme. It's not even close to
> correct, but it builds, boots and survives lightweight testing.

Whew, that was electric. I had barely managed to sort through some of
the config maze.
From a quick look this is pretty much how you described it.

> I did not even try to look into time-slice enforcement, but I really want
> to share this for illustration and for others to experiment.
>
> This keeps all the existing mechanisms in place and introduces a new
> config knob in the preemption model Kconfig switch: PREEMPT_AUTO
>
> If selected it builds a CONFIG_PREEMPT kernel, which disables the
> cond_resched() machinery and switches the fair scheduler class to use
> the NEED_PREEMPT_LAZY bit by default, i.e. it should be pretty close to
> the preempt NONE model except that cond_resched() is a NOOP and I did
> not validate the time-slice enforcement. The latter should be a
> no-brainer to figure out and fix if required.

Yeah, let me try this out.

Thanks
Ankur
