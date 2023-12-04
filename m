Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2938039D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjLDQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:12:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEB0A9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:12:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00191363c1so642818266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701706329; x=1702311129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fXQC8kMEIVpKhirV/8r5WlQUD6sGUWR7e162LHNTZo=;
        b=JkF1c/+gqmha+kzmylcTB4/fxDTgiC54H+nE6/W8bBOmumeZIN6o2w3+LYujIZoK5F
         J1Q4TJWZ/usECYf/Jgem7UAY4XPjIN69hyEy7Gjw2LYfGX9EI0gRWzyj/qL4y5jiojEj
         PeSpaLFe0EQKuEaDuk1jt/p7FGrb8esrTDxNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706329; x=1702311129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fXQC8kMEIVpKhirV/8r5WlQUD6sGUWR7e162LHNTZo=;
        b=PFsqL2VPwF/IWzDGme4MTBgNuv9UOIm41ruWN40Ui3BpTbL33sOcKqKFY/UAlHKxjr
         xkBZ25Vnas2eSSEvDhvDJQrMFsuRrPpPptdJsjxSrzEWbiTANJXKUEIx4DwUIGCERcnK
         G3LB575xq/sm6t8MtCxoXr+3V/OUHBUsHcb3ets2+RgJAFywMk/KrPjL7nIWJe25Blw1
         hpA9jY8hk2ZN+D2AxWzrdZ0A6VV7dmp6k2AUs6sOk5Dgc83MfIXmmbWtQAjGg3FvKjV7
         6KNaqqqIDsemUfdq1AnVGVhQRJGF2N8rxpcau1H9iKT/zPjz4ftZk3EpqH35IT2F5tH0
         a6iQ==
X-Gm-Message-State: AOJu0YykvRIzrIOooEIv3oMKS2HQ6mK3/73tqsanygd9SXatkqfUp+zT
        7j0/ADFC0UpWoXP8qYkICBM4BBb0pA2uV7D6VyC+ZLDw
X-Google-Smtp-Source: AGHT+IF4CrQNYn9rEOjG8a5UdfVCuGQlnVV0S0t3Tw1G0NglMPKyyXWe6NIuMvJ7UAqFAeQTjxWRJg==
X-Received: by 2002:a17:907:1041:b0:a19:a1ba:bad3 with SMTP id oy1-20020a170907104100b00a19a1babad3mr1697903ejb.121.1701706328583;
        Mon, 04 Dec 2023 08:12:08 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a0f770ae91bsm5378250ejb.89.2023.12.04.08.12.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:12:08 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso13991a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:12:08 -0800 (PST)
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr280850edb.0.1701705841514; Mon, 04 Dec
 2023 08:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-3-wenst@chromium.org>
 <CAD=FV=U_+iQJtV0Wii89DQT1V_fJCeS9wcqA8EJAs-hmmmLLLg@mail.gmail.com> <CAGXv+5EpA531O1tW=h1RvK34+LMvtdve3=cNmfN=2+9t1jL_bA@mail.gmail.com>
In-Reply-To: <CAGXv+5EpA531O1tW=h1RvK34+LMvtdve3=cNmfN=2+9t1jL_bA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Dec 2023 08:03:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WtvPUD+tXv0GghreG3w5yWedeHTYzhk-LNzf94fJ6B_Q@mail.gmail.com>
Message-ID: <CAD=FV=WtvPUD+tXv0GghreG3w5yWedeHTYzhk-LNzf94fJ6B_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] i2c: of: Introduce component probe function
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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

On Mon, Dec 4, 2023 at 1:53=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> > IMO you should prototype how you're going to handle regulators and
> > GPIOs before finalizing the design. I was going to write that you
> > should just document that it was up to the caller to power things up
> > before calling this function, but then I realized that the caller
> > would have to duplicate much of this function in order to do so. In
> > the very least they'd have to find the nodes of the relevant devices
> > so that they could grab regulators and/or GPIOs. In order to avoid
> > this duplication, would the design need to change? Perhaps this would
> > be as simple as adding a callback function here that's called with all
> > of the nodes before probing? If that's right, it would be nice to have
> > that callback from the beginning so we don't need two variants of the
> > function...
>
> So I think I can prototype designs with one GPIO and multiple regulators,
> assuming each node has the same number of both? At least they should if
> they're on the same connector.
>
> More than one GPIO probably means there are some ordering and timing
> constraints, and won't be as generic.

I was hoping to see a prototype of how this could work in the
non-generic case where the board needed a custom function to power
things up. It seems like we'd still want to be able to use your code
for probing.


> > > +       for_each_child_of_node(i2c_node, node) {
> > > +               union i2c_smbus_data data;
> > > +               u32 addr;
> > > +
> > > +               if (!of_node_name_prefix(node, type))
> > > +                       continue;
> > > +               if (of_property_read_u32(node, "reg", &addr))
> > > +                       continue;
> > > +               if (i2c_smbus_xfer(i2c, addr, 0, I2C_SMBUS_READ, 0, I=
2C_SMBUS_BYTE, &data) < 0)
> >
> > I'd be tempted to say that the caller should be able to pass in a
> > function pointer here so they could use an alternative method to probe
> > instead of i2c_smbus_xfer(), though you'd want to make it easy to
> > default to i2c_smbus_xfer(). I could imagine someone might need a
> > different way to probe. For instance if you had two touchscreens both
> > at the same "reg" but that had different "hid-descr-addr" then this
> > could be important.
>
> I'd say the only specific probable type is hid-i2c. And that could be
> generic enough that we could incorporate it here if we wanted. However
> I think we want to keep the initial version a bit simpler.

I don't mind if the initial version is simpler, but I'd love to
understand how this will grow. It doesn't feel terrible to take in a
function pointer that will probe the device and then provide a
function that callers could pass in that simply did the simple
i2c_smbus_xfer().


> > > +                       continue;
> > > +
> >
> > Put the "break" right here. You've found the device and that was the
> > point of the loop.
>
> In its place we'd have an if (node) { <enable node> } block. I guess it
> makes it easier to read still?

...or perhaps an "if (!node) goto exit" block and then you don't need
indentation? Essentially the loop becomes the implementation: "node =3D
find_the_one_that_exists(...)".

-Doug
