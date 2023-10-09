Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AC7BD463
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbjJIHd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345419AbjJIHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:33:54 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3994
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:33:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a2379a8b69so51038467b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696836832; x=1697441632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP7xqMhAKNqUEZKvD5L9l4hvT2pSYO7u42JTWvOuPhA=;
        b=tx76o7HjafmaALkPkeM7HUnnelXdpVAVjKNwu2MdnPT6oQ7oAoBve9+U6PA5XT1ssi
         1cKVI68oVHT336hm9IIIZhL0YsiCYfiT7CYv0nDmIuLvcRAZo2WSzclDlm2P2oTabfvi
         VcwrCzTA6oes58DwdXRYU9SpTYj8+lYL5GPePnKT7j3uTsyIK6NFE+sHWtI9dGAbPcQd
         4Zlkt7f3aaVq7Co9jixfdT4ZSiU/qabFGADlzxue2ahq5sj1+gt2dfBkurToxGMoIalU
         XabOYkKGAmgzGRN1nOAgcHVx+drVd/xSFzgH4HOozMLEOqgxgfN/l8rgjWZuhtZgAoFl
         VFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696836832; x=1697441632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP7xqMhAKNqUEZKvD5L9l4hvT2pSYO7u42JTWvOuPhA=;
        b=bOY39w75Qr18ajuMOZOTZNZE9/EEceahbbxgAqGPCsSH4nRetpQRE/tRrak6oFjhRh
         Vjg4Dd0kqLXHtTu593oUnzpA4XYjJv0nvqdUIglRj681t8df8Ya6BSsBLvWbdDCACIlv
         s6JNDrWt25MqX1lMAmj95TPowPw7qBzNuV9Z2JaoDR0pvsdCx4v7l40Yy5REd8ZWdH5T
         R2GpcgYjmrXrKGYlw0bGtJPpamyn5QMjdC2gTXACCukQAL93L+DAi1XScL2RRQww7xoj
         5w4J2Q03JxmVysujuV8HqYWgyW+V1YkGC97fQsy2YLQjPtj/UDjBytt7dm0/s65WnhHM
         UvSA==
X-Gm-Message-State: AOJu0Yxs5wvTKp3a2HcNKKQbH7n9gPiHK1QtGEz2HraRuF2XlfR32OpH
        F9jF1ym9wtXI41PGxn/reeyx6DPv+q31l+4+PcKH9A==
X-Google-Smtp-Source: AGHT+IEDf+tWdei5nh9+KrKswBou7fmYuReydda8UjjPzL2odlFWlTYW4DCNoTjmggrOubAGLysy56eT9xq/AxYA+4k=
X-Received: by 2002:a81:840e:0:b0:589:ca07:c963 with SMTP id
 u14-20020a81840e000000b00589ca07c963mr15807832ywf.42.1696836831997; Mon, 09
 Oct 2023 00:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
 <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org> <CAMRc=MdY2DU1R5_Ntkhw6UP0Vp+uhyUvti72KChBQqSF1ruWPw@mail.gmail.com>
In-Reply-To: <CAMRc=MdY2DU1R5_Ntkhw6UP0Vp+uhyUvti72KChBQqSF1ruWPw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Oct 2023 09:33:40 +0200
Message-ID: <CACRpkdb9fQUUq5_AOwXewiWfUjmu9r2SHHy-RSjfR_33znLiFQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 9:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> > +#if IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448)
> > +               { "i2s1-in-sel-gpio1",  NULL,   "mediatek,mt2701-cs4244=
8-machine" },
> > +               { "i2s1-in-sel-gpio2",  NULL,   "mediatek,mt2701-cs4244=
8-machine" },
> > +#endif
>
> I suppose this is a run-time dependency only for the other patches?
> Can I just pick it up into my tree?

You can, I was just thinking about bisectability and the low risk of collis=
ions
with other patches. (Actually no-one gets hurt if it's applied to both tree=
s
either, which IMO is perfectly fine in cases like this.)

Yours,
Linus Walleij
