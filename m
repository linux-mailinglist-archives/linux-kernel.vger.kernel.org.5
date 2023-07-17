Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169A756658
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGQOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:30:01 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2168.outbound.protection.outlook.com [40.92.62.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF4BC0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbP72IGzkGDOuOto7V5IViy705BNc8kDqpSKsVJZvtui7RAAtHIkCQJZ+DpqpBfqnpCVXVYhxA8Y+uPMdQ1PKtBIgnim405Z8o1ZiQen7+V0cEAmbxDmZV0dC0fvlO+5odMZB6vgto3YGZMf4J4oKAmN1kuP9pQIh/lwHW5kA62WdAP5gnJAgxx53nsVTBci2We0GOfDX44pcNxHcNMozICTNx0WlNAnhNaN5cY8vsor0ZvDtGcoFgmDj7nLNepp4qvSOuhXyU8EyGcjbtY4kfjv/LP3JZ1wE34n9u4gHP68ZAPPZWHkJ068wGXgeY4l2/LbIRj2muJb7pGrAAGJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNutQxeykakhsApaqiQIxLaH4ug2Q7LWEYAUrTQxLpg=;
 b=Zyncv0H8o2FCSYG4o4M0iVnJ4V97eNi6AZO6xGyi+k9fgcvugw3YmxmyjBoJVNWKD+43uiT6HRixlAHF/y1/WsNtyPwFl7Q1MIXsG3wTOu5gATeRHVUvMEQ+ALAmXQDH6k9g+8ZiD7M3V49gSkrxxqqcVhLQ3y4w/P6GROKgfuhGAmfM21kbGPBZ4GscOvJCe8jDoFUc0mnkfdGx42Os+uAbfjh0RILlJkE0b1wmT7kZ0psbeNj6sr7mKucdliTsKIcYmIWZqYzFFkLGbDUk/AZFzaccx9R6q9WlVgqOQvVnYF9G7lnnGZ4T828KndkZ9BOlXmF7NR+oUVlbVxpVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNutQxeykakhsApaqiQIxLaH4ug2Q7LWEYAUrTQxLpg=;
 b=RziVVtCCpaxpGlZ1Ahq8KvTjlRXoUI2j+s/9raNIJZDXn84hsT1EecdQtysw07+8hQtQ1sYLUH84reUrE3w7o+qgbU0S2FkfFl/M+RtJCxX9vcuOp++dO12kXIynFPG8pWwj6dMLtpLasmHrvkgO9IcA64ej4qrUK8g6u3X33Wq0ARfDvuqyVikpKPyXu/hyJy8B/kR/Ca/lxBs0EcWpfq6x2D8oDUOuzJXiuGItbxYMgnx97b/mDZmAsx06paenjPsIjB+8Mco3vBvgREUPBBiQzYhZo4NcHx6axcUyR9KAq4MGujA9zl73FHBA699co8TNDFQvMlKFyQrPdnwrUQ==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 ME3P282MB3307.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:134::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Mon, 17 Jul 2023 14:29:53 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::42d9:eaab:e6bf:1f81]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::42d9:eaab:e6bf:1f81%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:29:53 +0000
From:   David Xu <xuwd1@hotmail.com>
To:     stuarth@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, andy.chi@canonical.com,
        david.rhodes@cirrus.com, james.schulman@cirrus.com,
        kasper93@gmail.com, linux-kernel@vger.kernel.org, luke@ljones.dev,
        p.jungkamp@gmx.net, patches@opensource.cirrus.com, perex@perex.cz,
        rf@opensource.cirrus.com, ruinairas1992@gmail.com,
        sbinding@opensource.cirrus.com, tcrawford@system76.com,
        tiwai@suse.com, tiwai@suse.de, xuwd1@hotmail.com,
        yangyingliang@huawei.com, yangyuchi66@gmail.com
Subject: Re: [PATCH 0/2] Fix CSC3551 speaker sound problem for machines without a valid ACPI _DSD
Date:   Mon, 17 Jul 2023 22:29:37 +0800
Message-ID: <SY4P282MB183569D8139CA53D7BB3B29DE03BA@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <6a5d7b94-4762-5e71-dc39-c9f10ee98c6f@opensource.cirrus.com>
References: <6a5d7b94-4762-5e71-dc39-c9f10ee98c6f@opensource.cirrus.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [h5LFkkV86jcuiZwddhsHfEOgV2BeiB+L]
X-ClientProxiedBy: SG2PR02CA0105.apcprd02.prod.outlook.com
 (2603:1096:4:92::21) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230717142937.164744-1-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|ME3P282MB3307:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e46f65-eee2-41b2-6c01-08db86d24933
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWYnBBcTvvGLleK17hkRWRiEi7TiiQqLg0D6R9JLKbnMz/FILM+omj+ZPvVuaXe5lSNadSwbxY3s6gqPnH+u2qSLcihDiFBtfTtUNitAH8cMdqhV9+fpJRr0QqUktZxMA1l9grSLuI8INR57gcJCVdxIwbXqJLs6vYvMG4kTdkroOAm0XStoFF2sf4Fd/hcbGEKJ99KqDYQe6LIvvhE7R8j1wOewQ1iZj9zQXJDr2Uee0ZxWiCscWVvA2Gj21Fl5kzr+yc3BR6vRVulmmQK75ZftcF/9RBjFatmtVjYHr8x+XCT7Mg0Oi+mxnPqNtvoQjHFrMjRpSgBLk6q8WhZFJetWAy1ztLf4g4pmGM2v4hhhdApKVZDQcuujzBMU6Qbl5LMbqDSltBxeQ5QaT0iCu/n3pzGWpKcQloHQUYncgbM61dHCEUOvqpJECQSmXC1mBUfn+tDFLZKbjOyiG22o3NwzScI1NRlgYqGUGQDJ5ghttfo/ZsKBmMWJFZW/l1fYouUumrS90lAYmgmuh040VgpOU+zPoIsIomdR/l1T9cpm27/msOaoyP11OYhOarWVTY8HABJtqty9amapA0V13u6d8f4yUiTs+wv7BtvN70XDFObB7xJYrolqaf3/IN83e/TK33nWybnepNq27OAR1TIFhJKroaiyKVyYJYWWx6O/hHJOMYIAmpFS1vzHUpChZE66sGguMLXeK569If7JyoF7pGJCzdHXsX4e9SGb7xW5LJD/8QRp3Wp5rVmAWi0ttMJKHADhP2DRejjzbgU2laYOJP8irAivVE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hr1RV5t9vso6elpd/8Yd3RBdrSiOSz29c/j+R0fdX9QveHNAVCeWI/HI/6B6rCNyIVZliYbkxsDLM7TFn+e388I92j4tGFhSnzOWkfucuTI2JbcQ1picooPzrmNqwEvUEdNqTNK3zWbtdEsOoU60U1fXw7Ax5/1KsFkXNDIfvjg9Z9D8ufS7hGWwubLQwmG1q4TKP9ZmcblfjWCXsDzbwrkv7bPy/6Et1uytFzcKYNKL2Arwyew+s8dOkSi9Np4ZAqnDDkoZHB2TDF1U3VieDIKyyXDC8flkEc32fbHY/CKzjsmapnQHPb51UMr9C/kMBjQ5FCnkOFPiKkZ+68JX7No134GIyUtCKQhtA++YprJDqmiQOpt+daUqzF5EpUAKyZk8QTOqPN8dTvSpkik1qrDM4Lw2HVhdvKS4LkyZk41en/MVHJP3jGFyguwerghtNhKe/DOj0F8Gag7u8whwkmq7qCgFmEvWLAw3HuL8Oq71FsLLBvytShDz5DGnOKmE7lrwcDhd1dgpje/qeo1F5v8XGPA2ljDgGAjYs/Lg5+0stp2wCZ/ioQ3f5VQKXmMt3Q6stX5O5gWw8iekU0ObmLWnSliKQGZnxHBsJ1Vn6Clau9m4qucK9VkrwrCZPwmE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2AH5y0WznlSixmo5wPFaJuIXSrDPF7/jxE83zTgEyRWiavmcWZ6uB3T/OrD?=
 =?us-ascii?Q?XdgnYlhan/9YvduiOG2rHRkPMFCussPqOG8QFCIzszSsjyOjRbjHAjgD+8Xh?=
 =?us-ascii?Q?aEZxV2DqgldihPqOzMGqoKr3wvFF8r23MD/3VFs739NVlKmcbjQdDuHSkMMW?=
 =?us-ascii?Q?3lk4xIF6Q5bYk2fiUnSxM9akQnRO5GnHapg+Ii0ZkoWcbv1gCWc1zolwKtHV?=
 =?us-ascii?Q?H62iuOtmPUwzS7CaORdjBCchnG7or286W73EqCqfJ7J1vwBMBf1MA+KaMnE+?=
 =?us-ascii?Q?nmv4beNBrWek9OKkjk5aBAJ2gC9kLu21lBFwwRo0tlx4mf9nJVdfSG3RIrVb?=
 =?us-ascii?Q?xjNOycakxvZOtMpl7mVDBDSAUldExJoV4VDTP8+5cVeH27EeEwK4YpS7QjFf?=
 =?us-ascii?Q?E9fYgVA8h7nHGwRy8Xybb9iKkUqFzlcQIzYLkXXJdTNlDuOFg5+Z3CcXJR32?=
 =?us-ascii?Q?x/fRNIY1hL+Z4MrQzL1hbmvutf6iJsS47cZb8pUJGVv1zwC0LMuWIO2dfbE9?=
 =?us-ascii?Q?+n+vMWHn6iVr/FW1RAltjezeZjPuTvJ5a0aBu/+tLisf8f7JJ6gvs98dibEL?=
 =?us-ascii?Q?tLmD1UYxEPm898PumcMSzbjcMa2KoqISyn6G1OFB+GUSJd3arMqLzdzPHD3e?=
 =?us-ascii?Q?JggBzv5HMLRB9TlXInCsOjbndXptHF+MxGByWmj5pR92687EaS0jJqGd0udh?=
 =?us-ascii?Q?YL9FeYQz7BU2RnAbizIdd8SvARGYqFxkXTVHPUXwWVdziy7ArhdHSk8tne6K?=
 =?us-ascii?Q?wY4m7/Vtn4gcXHwyOoPNEApYPiqxLlXUz/0jVRqRCfD/gnAk4hunBwZ+balu?=
 =?us-ascii?Q?13NMVUypW/V8ibLVz9ukeOWFPVniGQTOmSixY2unnBQeY75LMMb9FHi8nPzn?=
 =?us-ascii?Q?Xn0QJc6eOP/LqfRry6l3NhsMTf9qbLYsrZT7db1v0hMlnHtSF53mCedNa39y?=
 =?us-ascii?Q?HSOvEYjrg7/o3UsT6X+7G0h/JF3pF+8C4cITo33IUGJeXZtW+Rkd6v4YYJHm?=
 =?us-ascii?Q?VeHR73lBomi5jWHSwe5IW49yHHAZnGlfJLpm9MYjE2iKQLtgQUJ3UDLGYNTy?=
 =?us-ascii?Q?QWJEk7YWp2zNsxPMpfgcMsMSeX4GS6GcqI1xaRqHeUDj99+YQFbakyepnD/X?=
 =?us-ascii?Q?7GILTtkNQ08jH5Ju4tFGir8VvWzLqzjOyc/4SGIb2rQdKLHl76gK1Mp7eya+?=
 =?us-ascii?Q?gUcoDWGJ2AKe0AVpmrsCM5IbjtiTDEwOcvD3Sg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e46f65-eee2-41b2-6c01-08db86d24933
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:29:53.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3307
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 13:48:28 +0100, Stuart Henderson wrote:
> On 16/07/2023 13:49, Takashi Iwai wrote:
> > On Thu, 13 Jul 2023 18:29:53 +0200,
> > David Xu wrote:
> >>
> >> As the comments added in commit 4d4c4bff4f8ed79d95e05 ("ALSA: hda:
> >> cs35l41: Clarify support for CSC3551 without _DSD Properties"), CSC3551
> >> requires a valid _DSD to work and the current implementation just
> >> fails when no _DSD can be found for CSC3551. However it is a fact
> >> that many OEMs hardcoded the configurations needed by CSC3551 into their
> >> proprietary software for various 2022 and later laptop models,
> >> and this makes the Linux installations on these models cannot make
> >> any speaker sound. Meanwhile, at this point of time, we see no hope
> >> that these OEMs would ever fix this problem via a BIOS update.
> >>
> >> To address the problem, this patch series contains two patches:
> >>
> >> Patch 1 for cs35l41 hda driver: a fixup mechanism is introduced that
> >> when the driver found there is no valid _DSD that contains the
> >> configurations, a fixup function would try to find a fixup entry that
> >> contains a proper cs35l41 configuration from a pre-defined fixup table
> >> by matching the CSC3551 ACPI _SUB id. If found, the fixup function
> >> would apply the cs35l41 configurations retrived from the entry.
> >> In this patch the fixup table only contains some entries for three
> >> Lenovo laptop models: namely 16IAH7, 16IAX7 and 16ARHA7. However
> >> as is known, several other laptop models from ASUS and HP also suffer
> >> from this no valid _DSD problem and could have it addressed with this
> >> fixup mechanism when proper fixup entries are inserted.
> >>
> >>
> >> Patch 2 for realtek hda driver: add quirks for Lenovo 16IAH7, 16IAX7
> >> and 16ARHA7 so that cs35l41 playback hook could be registered. Please
> >> note that for these quirks to work patch 1 has to be applied.
> > Thanks for the patches.
> >
> > I've seen the lots of pains with CS35L41 codec stuff on the recent
> > machines.  But, first of all, it still needs to be agreed by Cirrus
> > people whether this approach is acceptable.  Judging from the current
> > situation, such workaround appears inevitable, but we need a
> > consensus.
> >
> > So, Cirrus people, please check this.
> >
> >
> > Also, some ideas about the current patch set:
> >
> > - Do we need yet another listing and check of each ID in another
> >    place?  The existing entry in the SSID quirk table is already unique
> >    enough to identify which configuration is taken, I suppose.
> >
> > - The quirk entries can be gathered in patch_realtek.c, and the hw_cfg
> >    and other items are overwritten in cs35l41_no_acpi_dsd() when no
> >    _DSD is found.  In that way, we can avoid fixing two places for each
> >    update.
> >
> > - The workaround is a workaround, and it's fundamentally dangerous.
> >    We should warn it in a kernel message.
> >
> >
> > Takashi
> 
> Hi David, Takashi,
> We're looking into supporting some of these older devices at the moment, 
> and have a patch chain in development at the moment.
> The approach we've taken is a lot closer to the one taken by the github 
> Luke links through to elsewhere in this chain, which we think might be a 
> cleaner approach.  We do have concerns about the current approach of 
> identifying the SPI device though, as we've seen "spi1" become "spi2" as 
> additional devices become supported in the kernel and more SPI 
> controllers come into use.  We'll look into this more and hopefully get 
> a patch chain up in the coming weeks.
> This patch chain looks like it might also be missing support for 
> different boost configurations.
> I wouldn't recommend this patch be merged.
> Thanks,
> Stu

Hi Stuart,

Thank you for replying. I am looking forward to your work for fixing
this problem and hopefully I could see it in the following weeks. In 
addtion I'd like to justify this lack of support for boost configurations
as without a valid _DSD, it is nearly impossible for us users to know the 
correct and safe configuartion for internal boosting. The current situation
is that without this boosting config, we indeed get a quite low speaker
sound. It would be much appreciated if you could also solve this problem. 

Regards,

David
