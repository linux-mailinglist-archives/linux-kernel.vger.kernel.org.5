Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F578FF82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350078AbjIAOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjIAOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:54:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9710E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:54:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso2649078a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693580051; x=1694184851; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGIf0DvU1nNDMRQMSdHFG62jcR9LpXuu4Dt0E23j3FE=;
        b=Ma8bpEQqH0mof24DOG2yWlhGtezYZJCJ917wD7KEcVFKSgK5dZJ7CWslrzpzSA1pLk
         fmNfSMHwIytkUIYPNi7zpINRizvKhQRQhzVRlFOxsHPKRPBwkZWgLHZcIL++QTL/1Kdm
         sUkNpLjheMwp78TcI4/FdiYt8VJqYsatrrrBGUAUBsuHOVRA48nTo0aCYX/psnyYAM9K
         ZTappGw3+/jV9NlvDIpNOSyJarNfrRetvDbGGp5ZI9rt4bbOagOldBCTiV9+SxVaqskM
         4l2Zqz5zMBxbL0U4r9PMvnHtGmXmrnVLoD3J6jRTiN97K/fZE9rjBgOSUR/CDtNgK6IO
         CG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693580051; x=1694184851;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGIf0DvU1nNDMRQMSdHFG62jcR9LpXuu4Dt0E23j3FE=;
        b=l8Y+OaTjv+7kulIcj+r1L/mrmc2IfwJvqkD4+hdxWKxq3H2EbN2+pjU1BhzsXl+0ko
         z3DZx8YqL/93QOMI53ZwDeKYRSXD4UytdwCNGZ5behiZuXZ6pbJkpRoAUqtzc8azqzsk
         6wAjQhxMTpi5y0QhocgPlaLHPNJH188Igeifnt+RIH5yFl/1gw/QXqzpawWn6fpIXRn/
         Ue+bJIMo1smIJqxamravdhiKLGEOKyeRTKlNhsahGP01oU9Gj7r3/sHTkoj3PMccLc80
         jCy4s+SaWHGfEJio/aWJeXtaVvr1U3uhoECyD5b7mL9v/P+/H84VO6fqi8Fzn4Br4HYc
         S21Q==
X-Gm-Message-State: AOJu0YzSTX1ATiweDvglFO737CF84ewairSVUfrACeLyjGg7nYsJIyWh
        nWNq0hmk/p6JO1eSH+8KLHfjjg==
X-Google-Smtp-Source: AGHT+IH/PKF9WiFbxkACIWEMDcNjmfTt2sIKeCiPxxjLVl4tKzZFX/ZFQnqHbTEEgjwuW8OqCuflFA==
X-Received: by 2002:a17:907:272a:b0:9a1:d67c:b4f3 with SMTP id d10-20020a170907272a00b009a1d67cb4f3mr1798284ejl.77.1693580051449;
        Fri, 01 Sep 2023 07:54:11 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b009887f4e0291sm2052275ejb.27.2023.09.01.07.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:54:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 01 Sep 2023 16:54:09 +0200
Message-Id: <CV7O0TYYEFA8.1Q42JITFSW77Q@otso>
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Doug Anderson" <dianders@chromium.org>
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
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
 <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
 <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
 <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
In-Reply-To: <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 30, 2023 at 4:57 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Wed, Aug 30, 2023 at 7:43=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.=
com> wrote:
> >
> > On Wed Aug 30, 2023 at 4:30 PM CEST, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Aug 30, 2023 at 2:58=E2=80=AFAM Luca Weiss <luca.weiss@fairph=
one.com> wrote:
> > > >
> > > > On some platforms like sc7280 on non-ChromeOS devices the core cloc=
k
> > > > cannot be touched by Linux so we cannot provide it. Mark it as opti=
onal
> > > > as accessing qfprom works without it.
> > > >
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > ---
> > > >  drivers/nvmem/qfprom.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Are you actually testing burning fuses from the OS, or are you just
> > > using the nvmem in "read-only" mode? From comments in the bindings, i=
f
> > > you're trying to burn the fuses then the clock is required. If things
> > > are in read-only mode then the clock isn't required.
> >
> > Hi Doug,
> >
> > I definitely don't plan on burning any fuses on this phone. Not even
> > sure that's allowed by the TZ / boot stack.
> >
> > >
> > > When I compare to the driver, it seems like the driver assumes that i=
f
> > > more than one memory region is provided then you must be supporting
> > > burning fuses. The bindings agree that having 4 memory regions
> > > specified means that the nvmem supports burning and 1 memory region
> > > specified means read-only. The extra 3 memory regions in the nvmem ar=
e
> > > all about fuse burning, I believe.
> > >
> > > So maybe the right fix here is to just change your dts to specify one
> > > memory region?
> >
> > I got feedback from Konrad that this here would be the preferred
> > approach compared to having a different dts for ChromeOS vs non-ChromeO=
S
> > devices. I don't feel strongly to either, for me it's also okay to
> > remove the extra memory regions and only have the main one used on
> > regular qcom devices.
> >
> > Let me know what you think.
>
> I don't hate the idea of leaving the extra memory regions in the dts.
> They do describe the hardware, after all, even if the main OS can't
> actually access those memory regions. ...though the same could also be
> said about the clock you've removed. Said another way: if you want to
> fully describe the hardware then the dts should have the extra memory
> regions and the clock. If you are OK w/ just describing the hardware
> in the way that the OS has access to then the dts should not have the
> extra memory regions and not have the clock. Does that sound right?

Not sure which of those memory regions are actually accessible on this
board, but honestly I don't even want to try accessing it. Blowing fuses
is not my wish there ;)

On downstream the node is just described like the following:

	qfprom: qfprom@780000 {
		compatible =3D "qcom,qfprom";
		reg =3D <0x780000 0x7000>;
		...
	};

So we have 0x780000 - 0x786fff here.

In sc7280.dtsi we have the following:

	qfprom: efuse@784000 {
		compatible =3D "qcom,sc7280-qfprom", "qcom,qfprom";
		reg =3D <0 0x00784000 0 0xa20>,
			  <0 0x00780000 0 0xa20>,
			  <0 0x00782000 0 0x120>,
			  <0 0x00786000 0 0x1fff>;
		...
	};

So I guess this:
* 0x780000 - 0x780a1f
* 0x782000 - 0x78211f
* 0x784000 - 0x784a1f
* 0x786000 - 0x787ffe

So at least the last memory region seems to be partially out of range
according to downstream.

So after reading all of this I tried running this commmand on the phone
and the phone reboots into 900e mode.

  $ cat /sys/devices/platform/soc@0/784000.efuse/qfprom0/nvmem

I guess normally this should work? So if I interpret this correctly, the
Linux driver thinks it can access more than it can/should. But also
should probably try this command on another chipset to see if it works
on any really?

Regards
Luca

>
> If somehow you do end up with something like your patch, though,
> you're still missing a bit. Specifically, you don't want to "enable
> writing" a few lines below if you didn't get the clock, right?
>
> -Doug

