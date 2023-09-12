Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BB79D56C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjILPzc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 11:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:55:31 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED010DE;
        Tue, 12 Sep 2023 08:55:27 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-590685a3be5so56206727b3.0;
        Tue, 12 Sep 2023 08:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534126; x=1695138926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PFSfKLAM1gCAYkgRSEmmAAf6iQtA8HoP13Hb3Irmy0=;
        b=KNEE/pJ6PChjuPMhn62+LhOvw2w2PZMF2UyUZosTza2ZFxylDQsY2nLTfNshAER/L5
         aw6kFM4nvYYa1aON3mcjdscPociapHmhvnnRtXN+zV1pBwOW0hSNzyuXxXWYVVAJD97F
         I01t3DdfInz3h/2UTt1ZSoOyBoI78N0bWY/v1IdwP2xdh2ZUXp6aOXmaWVwcsuUUF7Jy
         5RZ4YnKOkGiLROjymIiM4WkzYXdCCP06E45SnRLAt281zRwPypRqta2w6/DIwLUFcyNP
         1kVGYfMSPI/TgqfPL66q64mJw+QAWP2UVZ15CvuGRbDNu3MFK6T/Yhg4/1ZTZyLesiHl
         xMoA==
X-Gm-Message-State: AOJu0YxR9dnF2UIh6xuIydIzuxZzo6QbJRbzupfF7JkClpzW3oOs+ITu
        mFC3xMl0GKlT4+q4C6odj9MBIQexvZje1A==
X-Google-Smtp-Source: AGHT+IF0Sf9dPZUoRjhnjq7yeit6zrU+DYd0t2Q0yUUrO6PglU2FcmNwxjlRerKzT1anHD2Dc7jJbQ==
X-Received: by 2002:a81:4705:0:b0:599:b59f:5280 with SMTP id u5-20020a814705000000b00599b59f5280mr13576685ywa.28.1694534124937;
        Tue, 12 Sep 2023 08:55:24 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o189-20020a0dfec6000000b0059a34cfa2a8sm2584895ywf.62.2023.09.12.08.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 08:55:24 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d7e741729a2so5415117276.2;
        Tue, 12 Sep 2023 08:55:24 -0700 (PDT)
X-Received: by 2002:a25:c016:0:b0:d78:cb14:d395 with SMTP id
 c22-20020a25c016000000b00d78cb14d395mr12784586ybf.34.1694534123948; Tue, 12
 Sep 2023 08:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
 <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
 <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com>
 <06327197-9b17-481f-8ecc-3f9c5ba3e391@kadam.mountain> <CAL_JsqKZuG4dK2ThuTaFKk9b9HtGcvmuJMgZFMeVw7ADg2+_kQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKZuG4dK2ThuTaFKk9b9HtGcvmuJMgZFMeVw7ADg2+_kQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 17:55:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX9xi5S3LGLoO7+pyAmX=h5_0KFQ5xfFrC7_Z1GV1TGfA@mail.gmail.com>
Message-ID: <CAMuHMdX9xi5S3LGLoO7+pyAmX=h5_0KFQ5xfFrC7_Z1GV1TGfA@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in of_changeset_action()
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Sep 12, 2023 at 5:32 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 8, 2023 at 11:14 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > On Fri, Sep 08, 2023 at 05:34:53PM +0200, Geert Uytterhoeven wrote:
> > > > > Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
> > > >
> > > > Despite what that says, it was never reported to me. IOW, the added TO
> > > > and CC lines don't seem to have any effect.
> > >
> > > The copy I received did list you in the "To"-header, though.
>
> Are you sure that's the header and not in the body?

Yes:

    Date: Thu, 7 Sep 2023 13:52:48 +0300
    From: Dan Carpenter <dan.carpenter@linaro.org>
    To: oe-kbuild@lists.linux.dev, Rob Herring <robh@kernel.org>
    Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
linux-kernel@vger.kernel.org, Geert Uytterhoeven
<geert+renesas@glider.be>
    Subject: drivers/of/dynamic.c:935 of_changeset_action() warn:
possible memory leak of 'ce'
    Message-ID: <eaa86211-436d-445b-80bd-84cea5745b5a@kadam.mountain>

> > > Fall-out of the issues seen with Gmail lately?
> > > I do miss lots of email, too :-(
> >
> > My gmail account dropped a whole lot of mail too in the last week of
> > August.  I was out of office that week so I didn't investigate.  I was
> > assuming it was an issue with vger...
>
> I don't think it's related to those issues. If I search lore including
> my email[1], then it doesn't find it either. Lore only has it in
> oe-kbuild. Not LKML or oe-kbuild-all. It really just looks like the
> git-send-email style of extracting emails from tags in the body is not
> happening.

Oh, looks like there were two emails, one from lkp, and one from Dan:
https://lore.kernel.org/all/eaa86211-436d-445b-80bd-84cea5745b5a@kadam.mountain

I was referring to the one from Dan, which is not the one in Closes:.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
