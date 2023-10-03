Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B27B662F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbjJCKRR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjJCKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:17:15 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01709A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:17:09 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f7f46b326so8589257b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328229; x=1696933029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DZsLBpVAosCAPqQeZ7sGwOoAu9EmebzedDkf2LRpxg=;
        b=NtSKnwbQHbPw5iyqntP3DC0UHbvjk5OiYC3eS3+JYY0DUn1JRwcZ9nQfl+vKIb51qg
         nJAsMroZ9jiMHS9nUw57vOp6/9GtaKu29MDpr5K7Il8EBNa2L/fjXu8SQbZC9yjdCzDZ
         FPHYPsXsLTkPKe2tb2ALXz2pBSSEQD1yKw8jAWFezcBUedPL0nrr1GXRWSx4ojkqAnY6
         iOU41d88WzogNUu+o1efNdq+1dte3EOYDVP5yj9EsszpgFsJzYt4HPTcksxQzOAq/YfO
         OkCj82DyAnaPyZJT704cJByDLtmBonbLSdntVTOR1354B+/kXtsZLI432TrM3833EiXI
         CM1w==
X-Gm-Message-State: AOJu0YwIVRB+UyF8wnfJqDGMAK5u2OPIl/Z3x5/7ZXoHaH0RZV57SION
        5ba3g7RiKE4InMCheNuD6Aw/RehdY/oNKw==
X-Google-Smtp-Source: AGHT+IFk4Vo/ySgTTuZRcZfNz/DaVyX9Uydfz/IoKsegY1j0w9bDDllOBOiYa2E/M7lTS7vMrgpAUg==
X-Received: by 2002:a81:9250:0:b0:583:d1fa:1fc4 with SMTP id j77-20020a819250000000b00583d1fa1fc4mr13388954ywg.26.1696328229047;
        Tue, 03 Oct 2023 03:17:09 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id a74-20020a0dd84d000000b005a20ab8a184sm279774ywe.31.2023.10.03.03.17.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 03:17:08 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59f4f80d084so8443687b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:17:08 -0700 (PDT)
X-Received: by 2002:a05:690c:ecf:b0:59f:4ee0:26e8 with SMTP id
 cs15-20020a05690c0ecf00b0059f4ee026e8mr1857503ywb.21.1696328228270; Tue, 03
 Oct 2023 03:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231002090434.1896-1-shenghao-ding@ti.com> <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
 <ZRvWQQzrvtzkJ/UV@smile.fi.intel.com>
In-Reply-To: <ZRvWQQzrvtzkJ/UV@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 12:16:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0SUJd8wduTcZ6XZjcDvEFSCOgbwc4Fbcu0U3pVH=PRg@mail.gmail.com>
Message-ID: <CAMuHMdU0SUJd8wduTcZ6XZjcDvEFSCOgbwc4Fbcu0U3pVH=PRg@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in m68k
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        tiwai@suse.de
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

Hi Andy,

On Tue, Oct 3, 2023 at 10:52 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Oct 02, 2023 at 09:24:21PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Oct 2, 2023 at 4:38 PM Shenghao Ding <shenghao-ding@ti.com> wrote:
>
> ...

> I believe patch is already in the Mark's tree, so we now ought to live with it.

I know. I would still like to know what is the real cause.
It might resurrect again, here or in other code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
