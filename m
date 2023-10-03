Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882C57B68C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjJCMQD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJCMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:15:59 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B008AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:15:52 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f7f46b326so9774307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335351; x=1696940151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlMz0Oi+kuJ548Zt58VQ4VcDGh2ache1586MwysmIBc=;
        b=L3ntQRTIPCaT56PN5qJdJqlFxUTPyAnmpotWJaN3uDcq90VAe+ZQhvCGG/BExg7Iwx
         gGEY2LM8Ha/Nh4dm9hzEcoxhDa6ZvXU+o3/3NeA7ZIJDqCe4w5IgkZozJ6CkrdpP4d2t
         okoi4FkNaCuAVK+9Z0Dce9CFPnevv8bd1rGY69ByFG+B99EBNf5HFVjN3t15rb1FZ4a4
         OMb/YmSjka5q1XLmSt17H8GgIpA/j7btGZO6LcLeHxhAHR9dEilC+bT4w7rYaPIhyFAP
         habLitwk2y60wxgPhkXSJfVl9XHnnqC8Em5kc4NyozgN08eGfMrqPVKFPhgM9bAt6EyI
         8AKQ==
X-Gm-Message-State: AOJu0YwDTglxTXvwTtj3kVoh0CJV28lrvVuWdCQzy5TE84FQ/CzPAcTD
        mJK37wjFUIr5l4d5fXpqCpkPTvVLL+AjdQ==
X-Google-Smtp-Source: AGHT+IE0ERATDkBz6xshF8AIbzZyZQuPU8g5jqODK5hiMHV6A8LnXOfmdrfPsoigahvLv90nxWipVQ==
X-Received: by 2002:a81:9197:0:b0:58d:7599:676a with SMTP id i145-20020a819197000000b0058d7599676amr14600863ywg.37.1696335351424;
        Tue, 03 Oct 2023 05:15:51 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id p189-20020a0de6c6000000b0057399b3bd26sm341140ywe.33.2023.10.03.05.15.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:15:50 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59f4bc88f9fso9580437b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:15:49 -0700 (PDT)
X-Received: by 2002:a81:9250:0:b0:583:d1fa:1fc4 with SMTP id
 j77-20020a819250000000b00583d1fa1fc4mr13656081ywg.26.1696335349579; Tue, 03
 Oct 2023 05:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231002090434.1896-1-shenghao-ding@ti.com> <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
 <79c4d534ad20452c992d8ace138e4384@ti.com>
In-Reply-To: <79c4d534ad20452c992d8ace138e4384@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 14:15:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com>
Message-ID: <CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in m68k
To:     "Ding, Shenghao" <shenghao-ding@ti.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
        "Xu, Baojun" <baojun.xu@ti.com>,
        "thomas.gfeller@q-drop.com" <thomas.gfeller@q-drop.com>,
        "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "tiwai@suse.de" <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

On Tue, Oct 3, 2023 at 12:47 PM Ding, Shenghao <shenghao-ding@ti.com> wrote:
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: Tuesday, October 3, 2023 3:24 AM
> > To: Ding, Shenghao <shenghao-ding@ti.com>
> > Cc: broonie@kernel.org; robh+dt@kernel.org;
> > andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com; perex@perex.cz;
> > pierre-louis.bossart@linux.intel.com; Lu, Kevin <kevin-lu@ti.com>;
> > 13916275206@139.com; alsa-devel@alsa-project.org; linux-
> > kernel@vger.kernel.org; liam.r.girdwood@intel.com; mengdong.lin@intel.com;
> > Xu, Baojun <baojun.xu@ti.com>; thomas.gfeller@q-drop.com; Gupta, Peeyush
> > <peeyush@ti.com>; Navada Kanyana, Mukund <navada@ti.com>;
> > tiwai@suse.de
> > Subject: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in
> > m68k
> >
> > Hi Shenghao,
> >
> > Thanks for your patch!
> >
> > On Mon, Oct 2, 2023 at 4:38 PM Shenghao Ding <shenghao-ding@ti.com>
> > wrote:
> > > fixed m68k compiling issue: mapping table can save code field; storing
> > > the
> >
> > Please replicate the actual error message from the compiler, so it is recorded in
> > the commit description, and easy to find when someone searches for the actual
> > error message
> >
> > From the Reported-by (which is not included in the actual description, as it is
> > below the "---"):
> >
> >        {standard input}: Assembler messages:
> >     >> {standard input}:992: Error: value -148 out of range
> >        {standard input}:992: Error: value of ffffff6c too large for field of 1 byte at
> > 0000045f
> >
> > > dev_idx as a member of block can reduce unnecessary  time and system
> > > resource comsumption of dev_idx mapping every time the block data
> > > writing to the dsp.
> >
> > I am sorry, but I don't understand what this means.
> > Can you please elaborate?
> >
> > Also, can you please explain what the real issue is?
> > (My first guess when seeing the error message before was that a  signed
> > integer is truncated to an unsigned char or so, but I couldn't see  immediately
> > where that is happening)
> Sorry to late feedback. I had been troubled by this issue for several weeks. At first, I also think it would one of variables overflow, according to the compiling error message. However, after investigation, no result came out. In fact, compiler will report the line number where the variable overflow is, if there was risk on the variable overflow. Yet, this compiling error did not report any line number. Finally, I didn’t realize that it would be the code section overflow until that compiling error message magically disappeared, one day I removed some functions in the tas2781-fwlib.c. So, I began to simplify some functions in the code.

I managed to reproduce the issue with the m68k cross-compiler from
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/

    | sound/soc/codecs/tas2781-fmwlib.c:779:            switch (block->type) {
            subq.l #1,%a0       |, tmp56
            moveq #36,%d0       |,
            cmp.l %a0,%d0       | tmp56,
            jcs .L122           |
            move.l %a0,%d0      | tmp56, tmp59
            add.l %d0,%d0       | tmp59
            move.w .L95(%pc,%d0.l),%d0  |, tmp60
    .L125:
    | sound/soc/codecs/tas2781-fmwlib.c:827:            switch (block->type) {
            jmp %pc@(2,%d0:w)   | tmp66
            .balignw 2,0x284c
    .L95:
            .word .L109-.L95
            .word .L113-.L95

            [...]

    | sound/soc/codecs/tas2781-fmwlib.c:827:            switch (block->type) {
            moveq #36,%d0       |,
            cmp.l %a0,%d0       | tmp77,
            jcs .L122           |
            move.l %a0,%d0      | tmp77,
            add.l %d0,%d0       |
            move.l %d0,%a0      |, tmp65
--->        move.w .L95(%pc,%a0.l),%d0  |, tmp66
            jra .L125           |

Looks like the compiler is sharing the jump table at L95 for two
different switch() statements, but the PC-relative offset to refer to
the table is too large when using -m68000.  It works fine with -m68020.

Probably a compiler bug?

> > > Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> > >
> > > ---
> > > Changes in v1:
> > >  - | Reported-by: kernel test robot <lkp@intel.com>
> > >    | Closes:
> > >    | https://lore.kernel.org/oe-kbuild-all/202309222048.RnSqEIK5-lkp@intel.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
