Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC23791331
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352525AbjIDIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjIDITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:19:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF96106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:19:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a1de3417acso441699566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693815590; x=1694420390; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SqCPlUACmzuR897Jw/2/k1NSEPnLNm8tSMQQYrDWME=;
        b=sCURjlIECG75NChDPAFgJtYUliKIkBlB5lHdZQsZ03Nz7U91Yl93d2PkC76eTQNQk/
         y0slJPkhPVfgWNEAicJ2mbdQB0OnQhmscuPWuv5ky5okEf7xFID7n7oroxJrHDZBO0sq
         3FsW5kDCZHGOb/9qkERTek0aJxrchdLiTtpNQL3rvxN9b9O2xGfZePu1+Jc6RufwuLlR
         DbA1aI0VzXXBXSQjBtLWvcSjhj7kDTNZFpHDoGX2YKkyIs43Wxps+LCXh7azfN0k0Zqr
         qHNbnaC0hiDziup3gy7Oq38fzCrnTcnC7TJyESBQxbhLMtqlj7Kj0IJPDvwzP2V4Ly4B
         n45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693815590; x=1694420390;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4SqCPlUACmzuR897Jw/2/k1NSEPnLNm8tSMQQYrDWME=;
        b=HMq2ivc+gKvXtuxE6rB2toAr5A8X6YH1CJHHT7/EUsrvvWZgOHjwTEPUo+0E7DiEHs
         psf7+RSZ6RhhTUbCOsEUFDedZkEL/B853wyWyFR3ivJ5NsrKIED2+dLG1qkVB609mr3X
         Cw5B585T4vRMPczOY6g0DwAQhzGiyAUWboolJETQjbX0ZbSWY4ON0Emvj1Vnv//Zf995
         a5ODVjWc5fZ6cJSP5KUgXslRM1FouDfdqHT2+4KwQL6lyMUuG3C4V1r/6WmdzIQgkypV
         n8Sg0BsEWJCGZL23UKEprykNXYC/jphuDdAxEjIBCzFMZL98yNMFeXFTCiwlvsYl5Axd
         Nisw==
X-Gm-Message-State: AOJu0YzYMUhzBZfQqlova9mULh7yGAMPWp5KHoI1nKvTpC+D2yZKplgP
        0BrJdxvhB9Ur1bb/Pr/7g7dD+w==
X-Google-Smtp-Source: AGHT+IFdJLo8jZ3klMSQBPs2qIeMjRwZjzw3rOcgPXXM7tKUsmLDAMqJLlkkomMSQn9J8vCqgpfIIg==
X-Received: by 2002:a17:906:76c9:b0:9a1:fc1e:19b8 with SMTP id q9-20020a17090676c900b009a1fc1e19b8mr9748830ejn.29.1693815589734;
        Mon, 04 Sep 2023 01:19:49 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id le18-20020a170906ae1200b0099bcbaa242asm5757648ejb.9.2023.09.04.01.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:19:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 10:19:49 +0200
Message-Id: <CV9ZIJFTEBQE.1035ODUQD2B78@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 11/11] arm64: dts: qcom: qcm6490: Add device-tree for
 Fairphone 5
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-11-5a954519bbad@fairphone.com>
 <72c2fd33-613b-49be-b394-0663f459f0c5@linaro.org>
 <CV7NGPVH4U0W.PN2NOIO19Z7U@otso>
 <5f05c76e-e74e-4954-a729-3ed2a1d33605@linaro.org>
In-Reply-To: <5f05c76e-e74e-4954-a729-3ed2a1d33605@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 2, 2023 at 1:45 PM CEST, Konrad Dybcio wrote:
> On 1.09.2023 16:27, Luca Weiss wrote:
> > On Wed Aug 30, 2023 at 12:45 PM CEST, Konrad Dybcio wrote:
> >> On 30.08.2023 11:58, Luca Weiss wrote:
> >>> Add device tree for the Fairphone 5 smartphone which is based on
> >>> the QCM6490 SoC.
> >>>
> >>> Supported features are, as of now:
> >>> * Bluetooth
> >>> * Debug UART
> >>> * Display via simplefb
> >>> * Flash/torch LED
> >>> * Flip cover sensor
> >>> * Power & volume buttons
> >>> * RTC
> >>> * SD card
> >>> * USB
> >>> * Various plumbing like regulators, i2c, spi, etc
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> [...]
>
> >>> +	panel: panel {
> >>> +		compatible =3D "boe,rm692e5";
> >> Undocumented compatbile
> >=20
> > Not quite sure how to document this properly. This dummy panel node is
> > used for the simplefb/simpledrm so that user space can get panel
> > dimensions already.
> >=20
> > This approach of a separate panel node was apparently preferred when th=
e
> > functionality was upstreamed but of course as can be seen this panel
> > node is very barebones where many properties are not present which woul=
d
> > be needed with the full panel driver (once it's working).
> >=20
> > Also for example for the bindings I think width-mm and height-mm won't
> > be needed anymore since that information will be provided by the driver
> > then.
> >=20
> > Please let me know how/where to document this.
> As discussed offline, the workflow here would be to oneOf: (wink)
>
> - wait until there's a proper driver and create a binding based on
>   what you know (because you have a working driver and can test it)
>   is necessary for it to function
>
> - create the binding for that display panel + driver ic combo in
>   advance and pray that whatever you put there will be enough when
>   you take upon yourself to write the driver
>
> I'd suggest dropping these properties (or keeping them downstream or
> something) for now, the display should not be terribly hard to bring
> up properly, let's hope that can be done soon!

Yeah that sounds like a solution for now.

But for other devices I hope something can be figured out so that these
dummy panels can go into upstream dts. Otherwise the functionality added
in the simplefb driver is kinda useless for pure upstream if noone's
allowed to have incomplete bindings for providing the panel dimensions.

>
> > I'm aware, but will work on this later since it's not useful without
> > USB-C role switching and working audio.
> You can still peek at it in like sysfs or so, but up to you.

Yes, later ;)

Regards
Luca

>
>
> Konrad

