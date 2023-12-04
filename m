Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DFC802BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjLDG7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjLDG7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:59:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A21B3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 22:59:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50be10acaf9so2049423e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 22:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701673180; x=1702277980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTNkS8LTnRqCQunaTUOLLsKXlHNWnzfg0xMTKbfGJJg=;
        b=K4cPDqo/LdCnBQ3arJxu73zcZVxTziEBFMdpc3X40hGxTKLwZPWb5T+nOkQGHbHRS5
         Vpd5hYrJuegi7dMayKz+UkVC/Kw5hPgWaUmjLcMEDI04q3qX1u0YSl45k2Toc/SDp/lV
         2N01Nbuw1vJZoqRHE/MYAZNVI/iQ/epx4Olh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701673180; x=1702277980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTNkS8LTnRqCQunaTUOLLsKXlHNWnzfg0xMTKbfGJJg=;
        b=NaJzjgjwqAfZGWYbADVe6ci2RfLkGd/+JC6xhBLyGWMD97Be/9AximuBd9AspNlqzh
         TH3MKYdS08QcDtqFe/CKfwe2AJWNYmIEVy7TiiPsQ6oltMXkV/0x+77tqZMQOzRX6PZ/
         3oF6xno/qsZcYv7CwxX5ijKXCH3+2wDKoewwH7BA6DgvW6pcH/c5jvwcVHgQeCY1mwaB
         Phz4eFLpHDdfM7gEZx1KAPeG1ReoogKYOtAgM1ls4fntoEOJMOpWQFQN7K4BqPGRnTn9
         CnrZhcq5IwBkyr9D/QhrYBU8DMLNhsnALcGorXH2LzvgkmrWFcXU0GsoIG9BbzKnj2Ta
         XsTg==
X-Gm-Message-State: AOJu0Yzl6f6kZQzzkiSs1nu7aa3HuTcdx4n/hYA4GGVYnOEQhIQKMqmC
        jelcfa1wM84J269kRUtfi5R2wzrWJ04YQ5vY3jTJKA==
X-Google-Smtp-Source: AGHT+IHoyWO3QIHEBY5JdBrYFEV7xzgnarDfjr1JxVNq6dHU5EQ6tbsFVJqwEhCrsQ2CBaDRnPGYgwSDkHN9tbdxHX4=
X-Received: by 2002:a05:6512:b9e:b0:50b:ed31:72a4 with SMTP id
 b30-20020a0565120b9e00b0050bed3172a4mr1697429lfv.28.1701673180528; Sun, 03
 Dec 2023 22:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-5-wenst@chromium.org>
 <CAD=FV=W01gfxV6RN2o6CVS7jjf8qgKP-jUy9Bp94d2hWzVC48A@mail.gmail.com>
In-Reply-To: <CAD=FV=W01gfxV6RN2o6CVS7jjf8qgKP-jUy9Bp94d2hWzVC48A@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 4 Dec 2023 14:59:29 +0800
Message-ID: <CAGXv+5E+R292XsOFSL-j0KJMmVJjWtxMRgCK8besP7mo6NDOWA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 8:58=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > @@ -44,6 +46,7 @@ trackpad2: trackpad@2c {
> >                 reg =3D <0x2c>;
> >                 hid-descr-addr =3D <0x0020>;
> >                 wakeup-source;
> > +               status =3D "fail-needs-probe";
>
> While doing this, you could also remove the hack where the trackpad
> IRQ pinctrl is listed under i2c4.

Sure. I do think we can do away with it though. According to at least one
schematic, the interrupt line has pull-ups on both sides of the voltage
shifter.

BTW, The touchscreen doesn't have pinctrl entries. This has pull-ups on
both sides of the voltage shifter as well.

ChenYu
