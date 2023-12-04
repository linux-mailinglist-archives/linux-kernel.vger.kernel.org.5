Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553B802C80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjLDHzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjLDHzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:55:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC882722
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:53:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf32c0140so910389e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 23:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701676423; x=1702281223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SzWfC6WDG0HEDP8yk1dI76L7Vjoulwh6flVXPbKqmw=;
        b=G1gmXNprbCprtMygGCN3TP+iUIH45Nhj5aH5ytMuBnhD4sYtRVa9bgvHZwHLStsUl3
         5nxZ2yBAzaYFot27FHzpvORKMtOK6RcoVFrRe0tDMVSjhYjyaUuZvw3B+C18WHWmIzC4
         Rqu9/Jcq/bJu306I6WCfqZROzwFqQwyxegI+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701676423; x=1702281223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SzWfC6WDG0HEDP8yk1dI76L7Vjoulwh6flVXPbKqmw=;
        b=RmEeZ3chD9AyJUXxaJJ60rRhqjvkaOxjHMdA+oTNk3iBXZ6F7Pgz2w4XpKkZnzb4nl
         L1tB87IsARU/mTJSrIG+MmitAb1v7RBZ2dyyaR437mTxLadZ4npaIUSUxYzgIwx0Tprm
         lwj2ZE+J3Qucj2pql7Y2wxPX2JQQNrLtYhhrMA9E68P2oAgP89YnNC3Rw5YXpT52x0OR
         dYa8yzhoIBtasCLcIOLA9TLuzIIrCA+osfsOTNatPY+jeqfAwotF5ONQEV9Tfhgq6yUe
         dlMN6ynbfCHT4OMFxV1gSZEkNJICLXM0hpQAK3jfwCP4vNd3Z85K4/W9Xqv88xnOLHba
         yPQg==
X-Gm-Message-State: AOJu0YxVY3H2s/Vf9jNyr2lnSjUs0NOIJcowjEzzWRgdqtLWvzoHUsPp
        f6QWXC/Io2ZAxUoKV0+SgJWHgg1R0dHYAEOcVSOh6w==
X-Google-Smtp-Source: AGHT+IGrPmPXLIsd+pzC6dzwBwPyO8KWCO9Fyx9YUVOkHlF5xJpwelZzOKlQkT88eTqzfYlBmWVj2CBHMAJkZ8Aj9xw=
X-Received: by 2002:a05:6512:3088:b0:50b:d764:64a7 with SMTP id
 z8-20020a056512308800b0050bd76464a7mr2985712lfd.92.1701676422869; Sun, 03 Dec
 2023 23:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-4-wenst@chromium.org>
 <CAD=FV=XV0+G=uFBE_n6WFGVW2szGcKToZgCNTdSrNf3LVk9MOQ@mail.gmail.com> <CAGXv+5Hz3wfjCRa2AiOQgOv7zo8bzAmtG=a=jWJhO2MZNrFtpw@mail.gmail.com>
In-Reply-To: <CAGXv+5Hz3wfjCRa2AiOQgOv7zo8bzAmtG=a=jWJhO2MZNrFtpw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 4 Dec 2023 15:53:31 +0800
Message-ID: <CAGXv+5HQeXPyRVFXaPKwX6GDoeMVM0Sneqk4CJx1AWGYT-mAEg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] platform/chrome: Introduce device tree
 hardware prober
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wolfram Sang <wsa@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:24=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> On Sat, Dec 2, 2023 at 8:58=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> > >
> > > @@ -61,6 +61,17 @@ config CHROMEOS_TBMC
> > >           To compile this driver as a module, choose M here: the
> > >           module will be called chromeos_tbmc.
> > >
> > > +config CHROMEOS_OF_HW_PROBER
> > > +       bool "ChromeOS Device Tree Hardware Prober"
> >
> > Any reason that it can't be a module?
>
> No technical one. However if it's a module, the user has to manually load
> it. So I think it's more of a usability thing.

We could probably manually add module aliases. I thought about aliases
against the machine compatibles, but there doesn't seem to be a device
for it to trigger. Or target something common to ChromeOS devices like
the EC? It's really hacky though.

ChenYu

> OOTH I think this needs to be a module if I2C is built as a module.
> Somehow I had thought of it at one point but then it slipped my mind.
>
> > > +       depends on OF
> > > +       depends on I2C
> > > +       select OF_DYNAMIC
> > > +       default OF
> >
> > You probably don't want "default OF". This means that everyone will
> > automatically get this new driver enabled which is unlikely to be
> > right.
>
> I thought this whole section was guarded behind KCONFIG_CHROME_PLATFORMS.
> So if the user has CHROME_PLATFORMS enabled and has OF enabled, they
> likely need the prober.
>
> > > +static int chromeos_of_hw_prober_probe(struct platform_device *pdev)
> > > +{
> > > +       for (size_t i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++=
)
> > > +               if (of_machine_is_compatible(hw_prober_platforms[i].c=
ompatible)) {
> > > +                       int ret;
> > > +
> > > +                       ret =3D hw_prober_platforms[i].prober(&pdev->=
dev,
> > > +                                                           hw_prober=
_platforms[i].data);
> > > +                       if (ret)
> >
> > Should it only check for -EPROBE_DEFER here? ...and then maybe warn
> > for other cases and go through the loop? If there's some error
> > enabling the touchscreen I'd still want the trackpad to probe...
>
> Makes sense. However there's no extra information to give in the
> warning though.
>
> > > +                               return ret;
> > > +               }
> > > +
> > > +       return 0;
> >
> > Random thought: once we get here, the driver is useless / just wasting
> > memory. Any way to have it freed? ;-)
>
> I don't think there is a good way to do that, except maybe marking all
> the functions as __init? But that likely doesn't work in combination
> with deferred probing (say the i2c driver is a module).
>
> ChenYu
