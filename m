Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014227A28A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbjIOUuA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbjIOUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:49:22 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FA2D51
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:48:53 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1d5a1965a9aso1497662fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694810932; x=1695415732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fe+fqfIjcOfCW6NskWKgMVJO3w4J1C4yBJg4t96fIc=;
        b=pFJQ8QEbZRlKik8HbQ73eUJCFMTDQfDAUx0lVaC7vOE8G+pg2guILt6EZdwh44xJ+f
         Yc0MXqQPY61KyqD1Jd5SAR/JHrbPkvLVDv9w/eYyH90f/Om9ldKY7rdirma2rK6J+84g
         QAn28jnBdX0a+oKbrOl1gwFoWhUvpjcgrzhvPOnTR69saOqgSGqLkna5ZLyJzYQqKEM+
         aLpBKAOD1zI722s34VuF6dLVo4b8vFU9Q0wmu+0Y8sVLRJWCop4NI0v93AmN5dqImpR0
         2Q9GJ+Gmpt7pqjkxfX9cEgQExpDyD/kb+CnGOB0vNPTTsVKx/1t3fqTJ9sjYN4u4GPvb
         NRBA==
X-Gm-Message-State: AOJu0Yxt3jH4/0CD16nXZluOh4WRhV/fsLt4gGqDBwwfInVHZPchRWxH
        /iKSmx2o/ukrF3yjZlZNw3/qVl49rEWqAg==
X-Google-Smtp-Source: AGHT+IEEkIcjQQEXsQxS9sdO8aB8zHKO8xEWRmxxtqEUBRT4soFdQo2sp14meVPDAiF8SpipcKPjzA==
X-Received: by 2002:a05:6870:830e:b0:1d6:3fa2:5b6e with SMTP id p14-20020a056870830e00b001d63fa25b6emr3343551oae.46.1694810932525;
        Fri, 15 Sep 2023 13:48:52 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id h4-20020a815304000000b005928ba6806dsm1056180ywb.97.2023.09.15.13.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 13:48:52 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59bebd5bdadso25883477b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:48:52 -0700 (PDT)
X-Received: by 2002:a25:d883:0:b0:c39:9e09:2c71 with SMTP id
 p125-20020a25d883000000b00c399e092c71mr2809726ybg.41.1694810932065; Fri, 15
 Sep 2023 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230915082416.3949600-1-geert@linux-m68k.org> <CAHk-=witemuuUen2Gr_+uUq1nSWb=MxNVTXS2f2hiTeqfywKrQ@mail.gmail.com>
In-Reply-To: <CAHk-=witemuuUen2Gr_+uUq1nSWb=MxNVTXS2f2hiTeqfywKrQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 22:48:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU07_UtjfAASmVhOxO4zTFQuiS3dGjXKwz+bP6dxJ12Fw@mail.gmail.com>
Message-ID: <CAMuHMdU07_UtjfAASmVhOxO4zTFQuiS3dGjXKwz+bP6dxJ12Fw@mail.gmail.com>
Subject: Re: [GIT PULL] m68k updates for v6.6 (take two)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Sep 15, 2023 at 9:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 15 Sept 2023 at 01:24, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > m68k updates for v6.6 (take two)
> >
> >   - Miscellaneous esthetical improvements for the floating point
> >     emulator,
> >   - Miscellaneous fixes for W=1 builds.
>
> This is not appropriate for a "fixes" pull. It's about an order of
> magnitude bigger than the pull you sent during the merge window, and
> the merge window is closed now.

Fair enough.

Perhaps I should have given more background: Arnd is working on enabling
more warnings from W=1 by default, so I thought I'd rather fix the
remaining issues on m68k sooner rather than later.
Anyway, they can wait...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
