Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C79803AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjLDQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjLDQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:55:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFBDB9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:55:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a18b478e4e9so596889466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701708930; x=1702313730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8E333mX0LWpYdsutAHYgoOIGzA9DDLQh7glRXD1fJM=;
        b=RyjS1e+YkaBeYwwFoTigfRidtkzDcXcqRRJ3bhA85bHnoGNM+Z6YLLQ33svl39LRmI
         RhGwzPTVXHGK8VyP477BpY/QGWNCQokZtJBFR1mUgyu9oxKHOqeubhrzW0elVCSTfaiX
         ibtXu8BOzND2hKqI2p8ulT1TNGwlaawoXLjhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708930; x=1702313730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8E333mX0LWpYdsutAHYgoOIGzA9DDLQh7glRXD1fJM=;
        b=uNwP4VkpXgs4IaqPH13vgS9A/0Veqg4SM8sOqteKoaq3cWCKOPe8qnRcxR++Cr7kMK
         l7Cb90TjMhGdwwcMCDCtIHJBA7h1qLBWT7v2MGUxGTfumkYOqFBGB7XDT/KERvzjhEE2
         LXDX2Jto9sjsjf2Dxsvcx5XtkdBJTlx+wDQy/D37MmQj3vZWxxN/B0dgCrzNJNf9z8i7
         V5g9CduoP1RlsttDU/sd1mhvdTfLYKCxsdnvSIBJWZn5t6v3OUf1Mp3Gb5ro8wiOt/wZ
         mLApNXW66UwzpA+TEMnsZ70dANCc68acqixNGT+5C998PmXwU6e0pQlpZGfDg6dHFpFY
         QvxA==
X-Gm-Message-State: AOJu0Yw0DbYlsud8FkQG888r4yycSfd/inbIl2q/n0ciYUVZZ/wsLWlv
        Ml8BpfchQeuohLbleAEGdxe6c60x9kzfp4nwbc7923nH
X-Google-Smtp-Source: AGHT+IGAszBgw9VeIX5JN70bKXu+3YLHC4Q0I1X78wf38qAhiWBMlQKVFkTxitT57NsiTrkKleQoxw==
X-Received: by 2002:a17:906:51c7:b0:9e0:2319:16d4 with SMTP id v7-20020a17090651c700b009e0231916d4mr2954601ejk.40.1701708930192;
        Mon, 04 Dec 2023 08:55:30 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709060e8e00b00a0173cfaab6sm5406295ejf.44.2023.12.04.08.55.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:55:30 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b422a274dso116375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:55:30 -0800 (PST)
X-Received: by 2002:a05:600c:5247:b0:405:320a:44f9 with SMTP id
 fc7-20020a05600c524700b00405320a44f9mr414355wmb.5.1701708616473; Mon, 04 Dec
 2023 08:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-5-wenst@chromium.org>
 <CAD=FV=W01gfxV6RN2o6CVS7jjf8qgKP-jUy9Bp94d2hWzVC48A@mail.gmail.com> <CAGXv+5E+R292XsOFSL-j0KJMmVJjWtxMRgCK8besP7mo6NDOWA@mail.gmail.com>
In-Reply-To: <CAGXv+5E+R292XsOFSL-j0KJMmVJjWtxMRgCK8besP7mo6NDOWA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Dec 2023 08:50:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQkAjgMuR85cPikNtCxsODWPWs7cibOcOoNGdjSSvF8Q@mail.gmail.com>
Message-ID: <CAD=FV=UQkAjgMuR85cPikNtCxsODWPWs7cibOcOoNGdjSSvF8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
To:     Chen-Yu Tsai <wenst@chromium.org>
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

Hi,

On Sun, Dec 3, 2023 at 10:59=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Sat, Dec 2, 2023 at 8:58=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> > >
> > > @@ -44,6 +46,7 @@ trackpad2: trackpad@2c {
> > >                 reg =3D <0x2c>;
> > >                 hid-descr-addr =3D <0x0020>;
> > >                 wakeup-source;
> > > +               status =3D "fail-needs-probe";
> >
> > While doing this, you could also remove the hack where the trackpad
> > IRQ pinctrl is listed under i2c4.
>
> Sure. I do think we can do away with it though. According to at least one
> schematic, the interrupt line has pull-ups on both sides of the voltage
> shifter.
>
> BTW, The touchscreen doesn't have pinctrl entries. This has pull-ups on
> both sides of the voltage shifter as well.

I dunno if the convention is different on Mediatek boards, but at
least on boards I've been involved with in the past we've always put
pinctrl entries just to make things explicit. This meant that we
didn't rely on the firmware/bootrom/defaults to leave pulls in any
particular state. ...otherwise those external pull-ups could be
fighting with internal pull-downs, right?

-Doug
