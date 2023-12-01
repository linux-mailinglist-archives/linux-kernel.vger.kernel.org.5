Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9134C800410
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjLAGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:39:39 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793010F9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU0o29jwH5oIRBwHVBMF61jQfMb/ohLUH0WwgLTEnCApJ9ESZgks1OB+INbB01zljo9VrScowkJzm2ySS9Jkuh+usNV8svla2UxRdFgqpovgkUt40pjB7Jw0QakNYCOwB8odVQ+h0QF1GWvdu/Uf6ZS0RwajTFmRaHCaD3yM/zcbhkaxOOikCdNmZv1Q8ZuLnWB6TJSgUvsAQOzfIxQ3sgn3qms1KiLfGe3Ilt/s3jasukl9qmI3fYBUbk9Gdx5iWCWcdWnigKTWgXHqdNCcHxIpE0xrJMX1r5+pQQSD2gjVimbuWYvUfbZDKTOqc0ffivZUiAsad5dcFThaevrdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6T40/6LGNEbKyKNM6ryi+h8HmtO/Gjk/2eEUx+DdSk=;
 b=PKKnwB/qjkWhZAKs0eSm26eP1R/zeW5xZsrbJBNQLw6xXhTqNCS589ahy/iXOW+fH2amDQOAh2yrHCkXuC6sYyEq+m0UbT5zWsgs9qLPyxtoYt0J2lWnb3cnB9zn+njmNoOoX4/tu5nsYBSgxFXG8UJUiW3+rxCBJgZHUoVaoz3KYLZboLDrQ3eedyPRRvezcZjcENPdJdVnk4vFS0DXf5zfyqobPJdG2vRDbjJ0Fi1K+XEr2ulTWHg7wrMXDE6WIlJ3Losd2/XD4k737WYTyfmeHGTUaXJQcn2mpc/gHhqgkw2cD3IkR/ZLZ9O3gKJfRozn/Dld6vyXsTtiu/iJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6T40/6LGNEbKyKNM6ryi+h8HmtO/Gjk/2eEUx+DdSk=;
 b=2gZT9LL5or+EvN2Zh7QYGjvU2gU30H/dLSuSfMd7qlZLktVZKNSP/mNyjvEjtiZKpsGLlhnjbTuxp3Ec9LNFjeWeMB4BkOXC0qhRWxStLQpk2ohEjlAN7+GlxK6lqucITTiayfL6KB/1NuSnWbvQZAZwTG8IefMWOB2DMGffL/NXm4fB6M/LQg112lS8Y8/QqpCiTvDz8wzIWKQTIVcDdU/tCPxLCNYBINkvuCmLj8tX1FhoP/34fzJJnV54UbviMH2Olut3WNAQv52KCFYzu/ihUTI27NjnnGq++UnDGShL5/yYiFGGVPAZhLLQLaxNaRxwSl4HBsbf6CZixD/dnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Fri, 1 Dec
 2023 06:39:42 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 06:39:42 +0000
Date:   Fri, 1 Dec 2023 01:39:36 -0500
From:   Wei Gao <wegao@suse.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     tglx@linutronix.de, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@redhat.com,
        peterz@infradead.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
Message-ID: <ZWl/qJg2AVH0fe9M@wegao>
References: <20231123053140.16062-1-wegao@suse.com>
 <189e733e-7056-45c4-a5c6-3371f8219b7e@igalia.com>
 <ZWSIfy+QJFyw/zGC@wegao>
 <d35af5a1-12c1-4b5a-8e9e-c4bc5bda4de2@igalia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d35af5a1-12c1-4b5a-8e9e-c4bc5bda4de2@igalia.com>
X-ClientProxiedBy: VI1PR09CA0133.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::17) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bb9a0b-c216-409a-2070-08dbf2384d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGw2C7Sq7eHf10QblXpZKIcXm6czRNtbO3+hy98oNmHHFVSMNt5tbUtZVn+KG9elgNL67sNa0Kqygq10ubapNOaa/ahgWnb1GMcqRXS5qkWFCWN2IVcUoiEz27QCSqZ32JVoxfxc/6ewoc3S8/kXDJekqA8VJ3swaFsxksgDpp78eFLSW8Ciog7I0C2Z7Ll/rZ5mWEfMhPxclVlnIcP5K8tPzE3g85t9YNBssU2ifOvRZ90egSs10H+J2erC8iwBwTqmrYPnv7Az+XCpGGdY8sGq4HHxRqgv/a334/SHGJKtEw6O1gV+HLkG5lW2eoWx4hwGGD6VJUzEjQrqSXtO1uwB2aPdmxBUt6Yjbf/CwnzeK0g3VKYZAEXbOfBc54Ae42pVhwJ/xD+rHqcUKKvBuWZ52B0g1Er0yzNxIhozxrOewXxEX5wUPpF35OZKRksrACIKhnMk1ou2B5/vHxFdAgfPuBlpxvNMFhXxhlkN1kMrP5DOCK1zGnBLkbp+70YgnlSRHfA2VTs1XGtn2cJy2cYp0g94Y6I4Hq63bHa+KMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(8676002)(8936002)(5660300002)(33716001)(66899024)(41300700001)(86362001)(83380400001)(26005)(38100700002)(508600001)(6666004)(966005)(9686003)(6506007)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Bw/ovLD4fEUWGN7oWtwr2Omwe+iQUc/QUJQffCKgPFZ/0fXpU3q/0MV8yU?=
 =?iso-8859-1?Q?wRpDbADEhYpGvQ/a+eWNq6MGrf1R6qWgpI9dDnOh9YAQu32G4AXDuKWtQd?=
 =?iso-8859-1?Q?C4rKmDMCYmTnNr55t7Pxjvs9aBWLmrRuqnECzV2H6uFMHbOZ/remh+RtB+?=
 =?iso-8859-1?Q?s4HKF+EPXd5ytm52Vi0rbTS/JJtYpLvChISy8SGx0EgHB5jguYN4s5SnIK?=
 =?iso-8859-1?Q?TSY0sllS3lcFWuNEsgluLycxeKMepsJoGj8GkRwyLNr5HeHnrvabyLW7Ku?=
 =?iso-8859-1?Q?KgW23SF8MefcK4VvMAN9Eixi5HysiZMJ2Z/3zZfeFOOlPUCwoJNdHS3hoX?=
 =?iso-8859-1?Q?K7YqNjnuEMYHLZZR68m9lGkgCS+z8JZ2IlLuDSDBNoI5zR4r3BsZJCevkp?=
 =?iso-8859-1?Q?wkoRQQeWxii4sGIrHW9rC57ZyqW2sDYfhiTC7f2bhvkMcmgafOpB/Zw6f3?=
 =?iso-8859-1?Q?oQJzVaw/NTRBZQZG6uk/nRO24KcLPnfwB2GasA8E/tw+Zc0wGUroSUNyOO?=
 =?iso-8859-1?Q?nGskUYHnJcOD3ElHcp+yN3s2Ha8z5NV63EKTqSncw3+ONGI+Cv9sxlLfLf?=
 =?iso-8859-1?Q?nCZiXouHOzZ6AzcDy17qspJK2HZaPhYj49hMOThUDh+n0sjklCwbLR5iCg?=
 =?iso-8859-1?Q?09KuvwtQbe7PT/y0r3ntZem18gh9zLvI6d2bvVLzN0R0xwE9ysa/Us8JT4?=
 =?iso-8859-1?Q?Z1lHM4E9rOn6l2s0KaGwoKOOEwRPyYHT32aKoM9/s0Ym1W85rsceSYgBe+?=
 =?iso-8859-1?Q?V60H8YEE1j3i00ecddfID/cxax99CNpSVA1V8/gdvyJc2aA+/Q6oF5phB1?=
 =?iso-8859-1?Q?WlarENuqDnqYVte78wNWaU5XGaglRIK8jLkXvE/7jeT/tW05E60NaD3Ccu?=
 =?iso-8859-1?Q?gDmc/357SiwzouXfojzFFhKnXCxfJKfUQ3LOG7YGn9vs0AxkNKU2TJ3Lsi?=
 =?iso-8859-1?Q?Fx0t1C1duhRurqfCIAxaJKzAvOkZ3AYdIf0C4EmdigCVAXk5mbzCCJBiBa?=
 =?iso-8859-1?Q?30AigGNdqiZXTPW/Mn3MefA9nC6IgHTaRQGbEQyaP0QYEm4j38nKC7By1x?=
 =?iso-8859-1?Q?cKroswDQc7dT3V7nhkv6W8UeKCzpYqn+uAAMWV4e48G3hsvnXBj8ZZjebI?=
 =?iso-8859-1?Q?Vvq6fJEZLUObGvJSVwholvrxsTl6WfUXPfK5knS4KcNCYFQwXtToI1JOGa?=
 =?iso-8859-1?Q?99ZJ8LDjfcKAjF9g0f5845tP4XeDJSW2g5TKFCu9CKHVPbgaztJKDeVSHq?=
 =?iso-8859-1?Q?UocGhIw41xIGYp3pEfdzA8muaSMR8mbYebikD2QwmohlTK8ylGJhiwp1Pz?=
 =?iso-8859-1?Q?6tOxi5q91HBZhT4RHMAGNd3z8x2SvrjvmPbeMdfgL/eSYBtwjz0kxybYO9?=
 =?iso-8859-1?Q?fzIzCJ0HBrmqUw/7bttgpDJP8jEYXdmqxAj8CpKzZoyI6JXfT8TTRExtMm?=
 =?iso-8859-1?Q?iFH+kHqhIiRD6GjpgqcKWK9ucvDZQaG8RxXq7//Z2TBJ44mmiIUjxiE462?=
 =?iso-8859-1?Q?34ztJKTTGJwSpdQbfmECrGfPJTu6Gr8uLjzQFBYrDp7L3SfUwj/NRq9Rkj?=
 =?iso-8859-1?Q?6rCf4yGqTwPUwPJmmHW2SAj35CNzXJrrzHFoJ9ATL/OA4Sy6TngvIhf9Pt?=
 =?iso-8859-1?Q?TI6lav/+qj1lA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bb9a0b-c216-409a-2070-08dbf2384d03
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 06:39:42.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra6RFIn2hA+oK66w/pUiHa5TK51ViG18ojpcZqq4wHhaLkDujfRC5/axHbx2Nrxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:56:12PM -0300, André Almeida wrote:
> Hi Wei,
> 
> Em 27/11/2023 09:15, Wei Gao escreveu:
> > On Thu, Nov 23, 2023 at 01:09:55PM -0300, André Almeida wrote:
> > > [+CC Arnd]
> > > 
> > > Hi Wei,
> > > 
> > > Em 23/11/2023 02:31, Wei Gao escreveu:
> > > > From: wei gao <wegao@suse.com>
> > > > 
> > > > Current implementation lead LTP test case futex_waitv failed when compiled with
> > > > -m32. This patch add new compat_sys_futex_waitv to handle m32 mode syscall.
> > > > 
> > > > The failure reason is futex_waitv in m32 mode will deliver kernel with struct
> > > > old_timespec32 timeout, but this struct type can not directly used by current
> > > > sys_futex_waitv implementation.
> > > > 
> > > > The new function copy main logic of current sys_futex_waitv, just update parameter
> > > > type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
> > > > and use get_old_timespec32 within the new function to get timeout value.
> > > > 
> > > 
> > > From, what I recall, we don't want to add new syscalls with old_timespec32,
> > > giving that they will have a limited lifetime. Instead, userspace should be
> > > able to come up with a 64-bit timespec implementation for -m32.
> > > 
> > > Thanks,
> > > 	André
> > 
> > Just a comment, I have checked the glibc latest code but do not see any implemention(*.c) on
> > futex_waitv syscall. So normally you have to do syscall directly with __NR_futex_waitv from
> > userspace. So i guess glibc-side can not covert this struct correctly currently. Correct me if
> > any misunderstanding.
> > 
> 
> futex() has no syscall wrappers in glibc. Userspace needs to figure out
> everything by themselves, including which struct they should use, and I
> don't think that glibc does any conversion. If you create manually a
> timespec64 that works in -m32, and pass this to sycall(__NR_futex_waitv,
> ..., &timeout, ...), it should work correctly. You can read more about how
> glibc is planning to deal with this at [1]. Please let me know if now it's
> more clear :)
> 
> [1] https://sourceware.org/glibc/wiki/Y2038ProofnessDesign

Thanks a lot for your detail explaination and good learning link, it's more clear to me now : )

> 
> > Thanks
> > Wei Gao
