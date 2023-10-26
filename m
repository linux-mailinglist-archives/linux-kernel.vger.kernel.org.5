Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014947D8282
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjJZMU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjJZMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:20:47 -0400
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486AB116;
        Thu, 26 Oct 2023 05:20:45 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-6ce322b62aeso474245a34.3;
        Thu, 26 Oct 2023 05:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322844; x=1698927644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwfH/fI/oq7RyoHmXtZ7J/iC1NW7ZB+6I+gOPXF7UYQ=;
        b=SWpPbSesxpT4s8OQXSPZgnsVJ7i7uObJtGGpfCcZMuE4xdybDB3WT9AN5B1qZuW7Rr
         Ke7nOT+Z1pBm6919l7IhDkyGayYAbovSCoMN2Sdlfs/1owSNDDOeLl0+mDEMfC2BFJBx
         5PBeCmkpIason5ujTMiI001XtIntkF1zdy+JpvRBiiZqRY66jrniV9blpyNgDsIcla2q
         TR51OU/y3rBTuMgvS044a4sdqt+p3nvZkoKIPCbj0SKJiz4wcqRhrXP8pU/DIa5PFrNo
         xC+4cqvMFeoS+51MoseoQOUR3M9iyCo01M0TBHccPqabQ3FxWfT/0wU7HylCqMmrsEhV
         8jJQ==
X-Gm-Message-State: AOJu0YwqA7QMTwCHMvpIamOkbIhcsNLDxV8xPXgPqH5cBNFu+YBYGRw7
        7DYdYwnFssRdou2nfL7M4YF7uGxQwm2Xq8wo
X-Google-Smtp-Source: AGHT+IGptDwl41gUQ/bkDbV9wZgRJKx5mnDR8dxNnO8m3ssskGl5XISLS2YYdgdzYF/hjRPae4JjEw==
X-Received: by 2002:a05:6870:1081:b0:1d6:5133:2f37 with SMTP id 1-20020a056870108100b001d651332f37mr16817789oaq.48.1698322844518;
        Thu, 26 Oct 2023 05:20:44 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id w64-20020a0dd443000000b00577269ba9e9sm5955996ywd.86.2023.10.26.05.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 05:20:44 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7dd65052aso6709797b3.0;
        Thu, 26 Oct 2023 05:20:44 -0700 (PDT)
X-Received: by 2002:a5b:608:0:b0:d9a:e947:447b with SMTP id
 d8-20020a5b0608000000b00d9ae947447bmr18024321ybq.14.1698322843939; Thu, 26
 Oct 2023 05:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130126.697995596@linuxfoundation.org> <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz> <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
 <ZSU+GHl1q7T/TBp5@duo.ucw.cz> <ZSWg1fv3gOyV5t+h@shikoro> <2023101057-runny-pellet-8952@gregkh>
 <ZTgZa1ic1iFbdaTM@duo.ucw.cz> <CAMuHMdXQApuOPfU1zNKcHKN5=fCuLBSDiLtF06U7e4Tx0+noyA@mail.gmail.com>
 <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
 <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
 <CAMuHMdXvpiGQ7jqAG69Zo=10wV-E0bioC9AYUHwwhRGmLXygWA@mail.gmail.com>
 <7d7a5a15-3349-adce-02cd-82b6cb4bebde@roeck-us.net> <CAMuHMdXbPZ0uz0NnE1xhUD=QtaAq+TinSW-PrWPMpGe4h=7Spg@mail.gmail.com>
 <CAMuHMdXNjopzEFCFBxxuYNCFMmj4SvMQ2PmZ4hZDHLGZGUHf=w@mail.gmail.com> <CAMuHMdU7-5R4NkwMdbLxovBY4=ePtPDs2SYXjWeGc_Yz3JcjPg@mail.gmail.com>
In-Reply-To: <CAMuHMdU7-5R4NkwMdbLxovBY4=ePtPDs2SYXjWeGc_Yz3JcjPg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 14:20:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=O=gYEA_qOh7Unr8ovtnKJi12qxWb447KxvkhqyRshw@mail.gmail.com>
Message-ID: <CAMuHMdU=O=gYEA_qOh7Unr8ovtnKJi12qxWb447KxvkhqyRshw@mail.gmail.com>
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10 000/226]
 5.10.198-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Pavel Machek <pavel@denx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 2:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> The solution is to backport commit 9f12cac1bb88e329 ("mmc: renesas_sdhi:
> use custom mask for TMIO_MASK_ALL") in v5.13.
> As this doesn't backport cleanly, I'll submit a (tested) patch.

https://lore.kernel.org/r/1b9fda30f2d86fab50341a947d17b5206a2c7507.1698321354.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
