Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1C7BDCEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbjJIM6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346551AbjJIM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:58:14 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B8B93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:58:09 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4526a936dcaso1833043137.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696856289; x=1697461089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+gpkzJfNccB5gH7cb9zDfW4Fonw1ieJ8gLDBd6viIU=;
        b=Fk9y18DqDn8Ld4eFa4zdGcWjU0I9ecu1mibrvlxtvAWfQR1o0D9cTy5qamYQjBPPJ1
         nh3XgqdRwcttrDkh52gBnfUvXJs3L2D4FVHHey8Q539kYYVIf0gYQmG4mYSaTcuRCBQL
         0R4hVjs+fMBYcOV+RlglJDXw8BA7vTk2+TFMvWg2oM2skMrS0evfjJmtf1L9ut5rmyln
         Gi8sPPi6ccTRpi3LF/gvejeNIsydCVIpMIuCvcm1B9gRFe4Kw/Aj20C1m8zcWPv9eUD3
         5ghNBuc0aPOYkr/uZc0hvou66wQsQ56yJcogEJC4ddHwhpvcPvDj+rEaj72k0hKVZEEC
         V6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856289; x=1697461089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+gpkzJfNccB5gH7cb9zDfW4Fonw1ieJ8gLDBd6viIU=;
        b=gSNhMq8QtrNprKAlNata1jPvKoZ7WfeBJSqDKOcReOznxyNV4nyXfZjylHwkx/tpfr
         qererHhsibH3rHYVMZoG8NEO71RzlattUcl18NOUpalG3iasj7RZlhqaS3dWsLTX/FiT
         s+0KfgsfsTWDYtAh+KeJRBtwK4LLL2EdP6NdTlHDJzAS3PDtibmkAGHmmmRRdlZVnSZm
         evslcPpzMjqI7dG6l78e3quOJudTE/bOhYmPhTqAGS5tIsH8zW+mp0+UbxE2TlTGfmVB
         wDflf4T99dsF1TqLs85qsfWqfcwwWimIPTkuVALSgWs4YUC9T7H8WHydxsZeIH4+9znm
         RJgQ==
X-Gm-Message-State: AOJu0YwpzbKB93xAh8zbijggl5CFVNP72qf6FE/UN8dPTdPkmuV5zWSu
        jWAfmJ7keLXSglGPu3D4j0qF4C7358YO7Mo3RTxg4g==
X-Google-Smtp-Source: AGHT+IFTAUfR1gTCm3D3XIrQD4F8FLARNjqBeGoPGST/5Xw+zvNixlquzd8Fm22XUFH6FlagNBuFNjaFz/vVg4Z8bjw=
X-Received: by 2002:a67:fdc1:0:b0:454:640e:58cb with SMTP id
 l1-20020a67fdc1000000b00454640e58cbmr14963468vsq.9.1696856289019; Mon, 09 Oct
 2023 05:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
 <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
 <CAMRc=MdY2DU1R5_Ntkhw6UP0Vp+uhyUvti72KChBQqSF1ruWPw@mail.gmail.com> <CACRpkdb9fQUUq5_AOwXewiWfUjmu9r2SHHy-RSjfR_33znLiFQ@mail.gmail.com>
In-Reply-To: <CACRpkdb9fQUUq5_AOwXewiWfUjmu9r2SHHy-RSjfR_33znLiFQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 14:57:58 +0200
Message-ID: <CAMRc=MdKRf5aZt3sYjPD_+CUR-prsN_JTDVP9fDdu5tRzNHvvg@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 9:33=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Mon, Oct 9, 2023 at 9:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > > +#if IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448)
> > > +               { "i2s1-in-sel-gpio1",  NULL,   "mediatek,mt2701-cs42=
448-machine" },
> > > +               { "i2s1-in-sel-gpio2",  NULL,   "mediatek,mt2701-cs42=
448-machine" },
> > > +#endif
> >
> > I suppose this is a run-time dependency only for the other patches?
> > Can I just pick it up into my tree?
>
> You can, I was just thinking about bisectability and the low risk of coll=
isions
> with other patches. (Actually no-one gets hurt if it's applied to both tr=
ees
> either, which IMO is perfectly fine in cases like this.)
>

Nah, Stephen Rothwell will auto-yell at you for that. I'm fine either way.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If we get any conflicts in next, then we'll deal with it with immutable tag=
s.

Bart
