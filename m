Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4478DA15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjH3SfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245259AbjH3O6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:58:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30352AC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:58:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bfcf4c814so747328566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693407487; x=1694012287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/+k6PD4xwGQdkLa4KX0Kf1ry0F1EIye4pGxjvLn9W4=;
        b=FE97Tt2vSFMwg0aorFk+5wkpNYRog7AbyH36pH6EqP6pU5jjOew0gkpabEciZA8tv8
         vfjv6v6TDjN0bKe8PsdejEy79wcTHZ0mP7At9zz+rA/Cof4ef3sQRrbH7YGWJ+UpofAu
         URjbLwNdW2qzkHkbW8PVZHNTOWAECgS9u2L8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407487; x=1694012287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/+k6PD4xwGQdkLa4KX0Kf1ry0F1EIye4pGxjvLn9W4=;
        b=Qs6gWG9M4F5eBSLCuEJgC9K8L1Vlue4Bl9cRUSGpqhwOTvM6LnIVIGGNYVH8kXKmj7
         ZAOJ/pJ5eOXnOss4QFJGHEOn3F6ZptDuMtlgFMIQIkTNE2fXhISmjZuFeTMXobKGXrv5
         lHQN9BJkdhP9npuvaGdsFmtKqyg5BGokUfvC9W7uEX9nXXxejYORcjmlVheEhJUJ1Wct
         gv5Nt8L/QlxCk+lO4j2t/66xMIonjPIOL8nAFQVBlftJnLlD5oIJxGpLP3tQMq63BDUa
         y6ZPzw6xrXOc10v5ii+bnghq+tzcm/xHv5AATcYGWqmDEfQaBmbGLXjpEj1/X5Ee/2xQ
         7qgg==
X-Gm-Message-State: AOJu0YziPIHvlhAZnMAbeOCH3kzlZScEBAguSB0BCM6DOvCKLVSYz0JQ
        c5LE2vH68Ogu85v1OKjzraQ14MMIsVSEAD8n+EWWzMVh
X-Google-Smtp-Source: AGHT+IFh9ZrX6C0u6ctrDv066BLlE/eoScgNOnETPUmcu+xNlIMDQSvxywxz+Ib7zsAmJlZ+UVTabQ==
X-Received: by 2002:a17:906:109:b0:99b:f820:5d0e with SMTP id 9-20020a170906010900b0099bf8205d0emr1513666eje.25.1693407487488;
        Wed, 30 Aug 2023 07:58:07 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id qc10-20020a170906d8aa00b0099ce188be7fsm7273010ejb.3.2023.08.30.07.58.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:58:06 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso78825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:58:06 -0700 (PDT)
X-Received: by 2002:a05:600c:520e:b0:3fe:eb42:7ec with SMTP id
 fb14-20020a05600c520e00b003feeb4207ecmr336994wmb.1.1693407486198; Wed, 30 Aug
 2023 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com> <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
 <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
In-Reply-To: <CV5YJVXIL8OT.1ZWW3KVCHPTA5@otso>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 07:57:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
Message-ID: <CAD=FV=XhdORH=naTtoc+kCC4A7UdAJKwq=Te6B3qvXNGBwBieg@mail.gmail.com>
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 7:43=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On Wed Aug 30, 2023 at 4:30 PM CEST, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Aug 30, 2023 at 2:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphon=
e.com> wrote:
> > >
> > > On some platforms like sc7280 on non-ChromeOS devices the core clock
> > > cannot be touched by Linux so we cannot provide it. Mark it as option=
al
> > > as accessing qfprom works without it.
> > >
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  drivers/nvmem/qfprom.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Are you actually testing burning fuses from the OS, or are you just
> > using the nvmem in "read-only" mode? From comments in the bindings, if
> > you're trying to burn the fuses then the clock is required. If things
> > are in read-only mode then the clock isn't required.
>
> Hi Doug,
>
> I definitely don't plan on burning any fuses on this phone. Not even
> sure that's allowed by the TZ / boot stack.
>
> >
> > When I compare to the driver, it seems like the driver assumes that if
> > more than one memory region is provided then you must be supporting
> > burning fuses. The bindings agree that having 4 memory regions
> > specified means that the nvmem supports burning and 1 memory region
> > specified means read-only. The extra 3 memory regions in the nvmem are
> > all about fuse burning, I believe.
> >
> > So maybe the right fix here is to just change your dts to specify one
> > memory region?
>
> I got feedback from Konrad that this here would be the preferred
> approach compared to having a different dts for ChromeOS vs non-ChromeOS
> devices. I don't feel strongly to either, for me it's also okay to
> remove the extra memory regions and only have the main one used on
> regular qcom devices.
>
> Let me know what you think.

I don't hate the idea of leaving the extra memory regions in the dts.
They do describe the hardware, after all, even if the main OS can't
actually access those memory regions. ...though the same could also be
said about the clock you've removed. Said another way: if you want to
fully describe the hardware then the dts should have the extra memory
regions and the clock. If you are OK w/ just describing the hardware
in the way that the OS has access to then the dts should not have the
extra memory regions and not have the clock. Does that sound right?

If somehow you do end up with something like your patch, though,
you're still missing a bit. Specifically, you don't want to "enable
writing" a few lines below if you didn't get the clock, right?

-Doug
