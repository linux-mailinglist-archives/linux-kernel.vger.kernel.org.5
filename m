Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662980279C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjLCUkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 15:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 15:40:01 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290099C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 12:40:06 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 511D314BC1E; Sun,  3 Dec 2023 15:40:05 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Luben Tuikov <ltuikov89@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>
Subject: Re: Radeon regression in 6.6 kernel
In-Reply-To: <CADnq5_Oy6RMyJ52TbsxVjZ=0p=wYJHduE4X8B3DiYnqHYJUAvw@mail.gmail.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net>
 <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
 <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
 <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com>
 <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
 <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com>
 <CADnq5_P0S7Jem0e4K6mG2+bboG8P56nELaGC1p4Pfx-8eV-BjQ@mail.gmail.com>
 <CADnq5_Oy6RMyJ52TbsxVjZ=0p=wYJHduE4X8B3DiYnqHYJUAvw@mail.gmail.com>
Date:   Sun, 03 Dec 2023 15:40:05 -0500
Message-ID: <87edg3koka.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher <alexdeucher@gmail.com> writes:

> Phillip,
>
> Can you test this patch?  I was not able to repro the issue on the
> navi2x card I had handy, but I think it should fix it.

I pulled -rc4 and it still had the problem.  I applied this patch, and
yes, it fixed it!

