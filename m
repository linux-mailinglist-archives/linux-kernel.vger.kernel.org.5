Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3277121C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjHEUZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:25:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317730C0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:25:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso5147973e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691267142; x=1691871942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/suAOSQGI0i2N3TQ0S3FcTenWc2CSU80rhZyaL3wWQ=;
        b=vzJu69AXVlydBjMeUkuoOsvDJvYRRLiVtN3vpYzV7KWnnwNzVoZypW7GzRHN+hCQYS
         OBwgfHGkgBxeehtuNnIih7ti7zDd47ca/m63PBHw8wlLosA/Ok1kRG4El9Q43mPo8F1H
         o1lZZUphOMIBDfDpQeB6Mc6QMb7V5rCzWRCo7hpDF/gkSJkgH5ho+ff1CsDNlmuezW1I
         kpeA8VU6PZQuY5ktaYv50ioKuVBlWnmFp5e13CP58FPPkotFFbysNpclhKPLRaINQE79
         dbMymKfjz7W969iN6RuZcHq13fEcQQ3GCXfQSrbNnYLkoglQQzdbNW/6m5d57KXwmR+t
         Eysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691267142; x=1691871942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/suAOSQGI0i2N3TQ0S3FcTenWc2CSU80rhZyaL3wWQ=;
        b=CHUPn48qNUjKfSONffOr8LDrtOPxClN53ESOct9IeIbtIhQZgXvu87ZxwG2EPrGYNJ
         /t6Svv1kfaV8NFIA+i0OFBIsKV5r6gg4QDDBVFH/v6rOF1kRcSZFbObcB8Neydsmylh8
         J5htMB7QqYdUSTKSCGiDwVLa2T6EIwEbdoAp7Lw2/LX/JdWcXwjK21WfOpwBFVU927nQ
         KzPsDkfSYkeYLtpwPs8OHjLPnkxcul3vD84dUwTM0ZZ6IxDaXe/uFC0UyF2LoHRzXGVU
         NvL7iACi+az/DbFCHsA80hMUh7ivjgFnbPwKHLE1iFqFkdLWr19kSyT8kpfF2oecD6XL
         H9cQ==
X-Gm-Message-State: AOJu0YyTQYafPIzSl/40Bqgk70yEeHmgjd3TQ8pm581ogfp31TRq5f5Q
        9dWaWVxGBBG10lDZ3u3QE6rv1cqkZ2gWCRnZwZXyfw==
X-Google-Smtp-Source: AGHT+IG1fHQr26PowhIL+bVvPOeVUOf1J8ORZz4zxqcjR8Suj7CJa+qKReyYYbylTbh064RiNIq8iVo4LWxVZcGb9/Y=
X-Received: by 2002:a05:6512:32cb:b0:4f8:6dfd:faa0 with SMTP id
 f11-20020a05651232cb00b004f86dfdfaa0mr3894093lfg.2.1691267141788; Sat, 05 Aug
 2023 13:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <20230713202123.231445-2-alex@shruggie.ro>
 <20230714172444.GA4003281-robh@kernel.org> <CAH3L5Qoj+sue=QnR2Lp12x3Hz2t2BNnarZHJiqxL3Gtf6M=bsA@mail.gmail.com>
 <7fa2d457-4ae9-42f5-be73-80549aae558c@lunn.ch>
In-Reply-To: <7fa2d457-4ae9-42f5-be73-80549aae558c@lunn.ch>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sat, 5 Aug 2023 23:25:31 +0300
Message-ID: <CAH3L5Qpd+6740SeQJh+1J8MjC1BjHE=EEReK9AOuJW_Ey3V4mA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 6:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > So, there's the adin.c PHY driver which has a similar functionality
> > with the adin_config_clk_out().
> > Something in the micrel.c PHY driver (with
> > micrel,rmii-reference-clock-select-25-mhz); hopefully I did not
> > misread the code about that one.
> > And the at803x.c PHY driver has a 'qca,clk-out-frequency' property too.
> >
> > Now with the mscc.c driver, there is a common-ality that could use a fr=
amework.
> >
> > @Rob are you suggesting something like registering a clock provider
> > (somewhere in the PHY framework) and let the PHY drivers use it?
> > Usually, these clock signals (once enabled on startup), don't get
> > turned off; but I've worked mostly on reference designs; somewhere
> > down the line some people get different requirements.
> > These clocks get connected back to the MAC (usually), and are usually
> > like a "fixed-clock" driver.
>
> They are not necessarily fixed clocks. The clock you are adding here
> has three frequencies. Two frequencies is common for PHY devices. So
> you need to use something more than clk-fixed-rate.c. Also, mostly
> PHYs allows the clock to be gated.
>
> > In our case, turning off the clock would be needed if the PHY
> > negotiates a non-gigabit link; i.e 100 or 10 Mbps; in that case, the
> > CLKOUT signal is not needed and it can be turned off.
>
> Who does not need it? The PHY, or the MAC? If it is the MAC, it should
> really be the MAC driver which uses the common clock API to turn it
> off. Just watch out for deadlocks with phydev->lock.

The MAC needs the clock in GMII mode, when going in gigabit mode.

>
> > Maybe start out with a hook in 'struct phy_driver'?
> > Like "int (*config_clk_out)(struct phy_device *dev);" or something?
> > And underneath, this delegates to the CLK framework?
>
> Yes, have phy_device.c implement that registration/unregister of the
> clock, deal with locking, and call into the PHY driver to actually
> manipulate the clock. You missed the requested frequency in the
> function prototype. I would also call it refclk. Three is sometimes
> confusion about the different clocks.

Ack.
Then something like:
int (*config_refclk)(struct phy_device *dev, uint32_t frequency);

>
> Traditionally, clk_enable() can be called in atomic context, but that
> is not allowed with phylib, it always assume thread context. I don't
> know if the clock framework has some helpers for that, but i also
> don't see there being a real need for MAC to enable the clock in
> atomic context.
>
>         Andrew
