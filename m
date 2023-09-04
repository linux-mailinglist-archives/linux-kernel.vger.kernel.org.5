Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17E479131E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352536AbjIDIOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347269AbjIDIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:14:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86126FD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:14:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a2185bd83cso174170666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693815284; x=1694420084; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWMi9FtNgdsDW9Ls5zX1bxJmX9VcD9rhfLYu4eJXCwc=;
        b=xd8Bcb7IDJ5lyj9B7pfTxOZfGpY5+VosjSWfwM9iVg1ZH4nq+N1FBGJUKc+5Vleecb
         r7XZ8aMdUWoidP6SytEJNrO0A3dMsv04pHKMXr8V3IdbmDYhoy9wrMQo3jxH1FmNDsQI
         gxyXnjxSMqPWUAFZU0V3BmbFe5JW0NugZhFPP6hkF+plKCrfJLZ9B0UK01VhH3au/pSu
         wp4W6rlRgX2aCr4/KDPaqWtdizv1OFVvAIL5jAyEM3yyJuu+5A6LppDUy69Bf9RGbVJt
         fNKKxPG6E6TLDXlQk7Mw1/TFd5MDdKC2/AouzGP/0UzBZvhme3GmP38ZQDWrOgDp+kEK
         t8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693815284; x=1694420084;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWMi9FtNgdsDW9Ls5zX1bxJmX9VcD9rhfLYu4eJXCwc=;
        b=d6GeNQg5Q0sdbZ+9gY6vUIUGJEZbVRwRwSsQLPkAEGiboMcJhFXOsIqiJOSrURWXxq
         gIfgaGdYfsQVByQsiUhxLRdIJqVykmJwCwSmXtEAKN2qPL8qHzv+cxatRApucuNWWX4h
         JjmCA2gNu3wgPOwldEqn7/e2xTDaKpdKkzVY6Kcz+ZjKeTLE2NkTGm68H5zACj6FJBWK
         OmH2bZ87OZGHWw1V5Twe/Fs6lU+1V6SjtzHlPDSy4ySUkTFQZBeQTvx2AUuVB1qhw6DE
         VCcPnB6SgOrnpXRkKntxsTB2rHbOZqId1YzjvYUx6HmWiOj/zwMiroMF8DrTA8XB2wvX
         oqnA==
X-Gm-Message-State: AOJu0YzfeGvl44WlSHwxmY2uFUy6jUHB3xbticzgzwLG4K5dn3c5N5zL
        cAVqlCNfBarUp+xNNDubl+CALA==
X-Google-Smtp-Source: AGHT+IHUaOSlrS5L3pk5vdj2p6HRN/GNfjoEP6nrYuWjZ/0Ux6QVQihqo46O6Ejh8hYfgT+s6QlW4w==
X-Received: by 2002:a17:906:20dd:b0:9a1:eef2:a110 with SMTP id c29-20020a17090620dd00b009a1eef2a110mr7175962ejc.19.1693815284020;
        Mon, 04 Sep 2023 01:14:44 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b009920a690cd9sm5787656ejb.59.2023.09.04.01.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:14:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 10:14:42 +0200
Message-Id: <CV9ZEMOTNO1D.378QGW3KMG4E8@otso>
Cc:     <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
 <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
 <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
 <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
 <CV7O0TYYEFA8.1Q42JITFSW77Q@otso>
 <CAD=FV=UG-dFg7wZsn6n=pkejie0fr+G0q3CguNspGYxoC2ZBLw@mail.gmail.com>
In-Reply-To: <CAD=FV=UG-dFg7wZsn6n=pkejie0fr+G0q3CguNspGYxoC2ZBLw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 1, 2023 at 5:08 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Fri, Sep 1, 2023 at 7:54=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.c=
om> wrote:
> >
> > > > > So maybe the right fix here is to just change your dts to specify=
 one
> > > > > memory region?
> > > >
> > > > I got feedback from Konrad that this here would be the preferred
> > > > approach compared to having a different dts for ChromeOS vs non-Chr=
omeOS
> > > > devices. I don't feel strongly to either, for me it's also okay to
> > > > remove the extra memory regions and only have the main one used on
> > > > regular qcom devices.
> > > >
> > > > Let me know what you think.
> > >
> > > I don't hate the idea of leaving the extra memory regions in the dts.
> > > They do describe the hardware, after all, even if the main OS can't
> > > actually access those memory regions. ...though the same could also b=
e
> > > said about the clock you've removed. Said another way: if you want to
> > > fully describe the hardware then the dts should have the extra memory
> > > regions and the clock. If you are OK w/ just describing the hardware
> > > in the way that the OS has access to then the dts should not have the
> > > extra memory regions and not have the clock. Does that sound right?
> >
> > Not sure which of those memory regions are actually accessible on this
> > board, but honestly I don't even want to try accessing it. Blowing fuse=
s
> > is not my wish there ;)
> >
> > On downstream the node is just described like the following:
> >
> >         qfprom: qfprom@780000 {
> >                 compatible =3D "qcom,qfprom";
> >                 reg =3D <0x780000 0x7000>;
> >                 ...
> >         };
> >
> > So we have 0x780000 - 0x786fff here.
> >
> > In sc7280.dtsi we have the following:
> >
> >         qfprom: efuse@784000 {
> >                 compatible =3D "qcom,sc7280-qfprom", "qcom,qfprom";
> >                 reg =3D <0 0x00784000 0 0xa20>,
> >                           <0 0x00780000 0 0xa20>,
> >                           <0 0x00782000 0 0x120>,
> >                           <0 0x00786000 0 0x1fff>;
> >                 ...
> >         };
> >
> > So I guess this:
> > * 0x780000 - 0x780a1f
> > * 0x782000 - 0x78211f
> > * 0x784000 - 0x784a1f
> > * 0x786000 - 0x787ffe
> >
> > So at least the last memory region seems to be partially out of range
> > according to downstream.
>
> From the other discussion, it sounds as if you _can_ leave the clock
> in the device tree and then use "clk_get_optional" here. IMO then, the
> right answer is to use "clk_get_optional" but then also modify the
> check below so that instead of:
>
> /* Only enable writing if we have SoC data. */
> if (priv->soc_data)
>   econfig.reg_write =3D qfprom_reg_write;
>
> It is:
>
> /* Only enable writing if we have SoC data and a valid clock */
> if (priv->soc_data && priv->secclk)
>   econfig.reg_write =3D qfprom_reg_write;
>
>
> Does that work for you?

Thanks Doug, this feels like a good solution. I'll update v2 with that.

>
>
> > So after reading all of this I tried running this commmand on the phone
> > and the phone reboots into 900e mode.
> >
> >   $ cat /sys/devices/platform/soc@0/784000.efuse/qfprom0/nvmem
> >
> > I guess normally this should work? So if I interpret this correctly, th=
e
> > Linux driver thinks it can access more than it can/should. But also
> > should probably try this command on another chipset to see if it works
> > on any really?
>
> Presumably your firmware needs a different "sc7280_qfprom_keepout". If
> that's true then I guess you'll have to undergo negotiations with the
> DT bindings folks and the nvmem maintainer to figure out how to
> specify that your firmware protects different things than the ChromeOS
> firmware?

Right. But based on Konrad's reply here, I think I'll skip this for now
since generally qfprom seems to be fine with the current data, at least
for the purposes it's used for on my device.

Regards
Luca


>
>
> -Doug

