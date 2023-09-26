Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE27AF43A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjIZTiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjIZTh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:37:58 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECDCFC;
        Tue, 26 Sep 2023 12:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695757045; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PzFhlSDazxWtUIhv8D+p4rJGZjG2FvvZo8iULTAM3w1PsNvsjYjXuPStvSeWVkuVNJ
    nt19eoOBbKwnQFCHTVpqLLfKzUkMQ9u8/veSCeonhbgHNck7y3OdzrRsl8+H5s7VRKNk
    9NxCH5c1Z46fENY7u6cNskztzygzmJK1JNDfViOBqykcOkmGBBMIGDeqtb7/SvDl4n9x
    qIwdah5XxwjcZso5N1LMjXnOmPhJJYzDaqyh/lyA18gAa/q7+v8YtmRaIsUTC+tbmO/r
    O0rkQ3jVR/wF21oRNBwtnoLAHGnTIkpaFFTRKMGu7/RfG7c2CyEUbGdzbizo6+vOZkR6
    qcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695757045;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=V9JO3H32BjHUMfYT7D/OSucGSORMhp/WvjBp8dje0LE=;
    b=Eq4P6ks9tem4GBbhp9gtrupOlPsApxSmAl9pmVzL9Koqk3aaaUI7u8ne1K1OCEVzCN
    xT16GhZJhMXCYUQD8vbSk0S8SkzcmT929umEJoYkgBqShACdu9RZVd7QrDHBl1tI1nYV
    bz/G+YOMI4XF6HJM5swOXRtki5pdPg2cE4mXase0xOsQ4ZnFgs3EPqPi8Y5HKMy0wg48
    XKYCqMiiqYeM8vb4aTyM2wsfguTdPpDSOXvyRX2zYiJOO7q2MtisNkz1L3gdbR+/VAAC
    IbWtCFR73LAc9EjomBKEIOiW/idrzgfwr5fZj7aYTkDQzDh2bQ8m5RhAXuhUYsO/3bbu
    3EWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695757045;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=V9JO3H32BjHUMfYT7D/OSucGSORMhp/WvjBp8dje0LE=;
    b=bgr7QK1DS5lsH3hAC+vQCM1fxR+dDLP6c4xO8dlnUgKU0L/d2EZU9P7Q+cEkhD1lsB
    ZwzxTf6s6fTCiYJ2gcfs91l3s4vHctDSr7NYFnVwvCiYTYLj4HJ4CS7aFI/O6YNOlxcD
    ZaT0zbKX1nEOxyvVXBXx2YdFMZJpYNt+7nwhQnKfhxDsEPtBbv+Uy6JhuuWFKw3SIa11
    sUcrdjnTBRd9lAOMa7j5/zgFevMQr4hSRf36qnaL4tAWUqBtAqBW2KmpoNixOS2Jvbn5
    p+2gERP94rUnovk8xfGZYHU4qB7D8TSW9SblJoOW4qICHPztjlTdJgHXZY/lvluQkQbj
    VH9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695757045;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=V9JO3H32BjHUMfYT7D/OSucGSORMhp/WvjBp8dje0LE=;
    b=AThLtZQBDX/9TynlR7zX4grhWuQU/rIR6H4qOFRT4m9IRHrCFY/8UxSjb/ujzh1BEw
    wM6W8Ip1Yk4WBe7WGiBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QJbPgO0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 21:37:25 +0200 (CEST)
Date:   Tue, 26 Sep 2023 21:37:23 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jasper Korten <jja2000@gmail.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 11/13] arm64: dts: qcom: msm8916-samsung-gt5: Add sound
 and modem
Message-ID: <ZRMy83E6QEJUDKAM@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-11-398eec74bac9@gerhold.net>
 <8b4de316-123f-455d-933a-c727daef918b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4de316-123f-455d-933a-c727daef918b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:03:14PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > From: Jasper Korten <jja2000@gmail.com>
> > 
> > Enable sound and modem for the Samsung Galaxy Tab A 2015 tablets.
> > The setup is similar to most MSM8916 devices, i.e.:
> > 
> >  - QDSP6 audio
> >  - Headphones/microphones via digital/analog codec in
> >    MSM8916/PM8916. Earpiece exists on samsung-gt58 only.
> >  - WWAN Internet via BAM-DMUX
> > 
> > except:
> > 
> >  - gt510: Stereo Maxim MAX98357A codecs for speaker on Quaternary MI2S
> >  - gt58: Mono NXP TFA9895 codec for speaker on Quaternary MI2S
> >    - For some reason connected to GPIOs where no hardware I2C
> >      controller is available -> need to use i2c-gpio
> > - Samsung-specific audio jack detection (not supported yet)
> > 
> > Signed-off-by: Jasper Korten <jja2000@gmail.com>
> > Co-developed-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> > Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> > Co-developed-by: Nikita Travkin <nikita@trvn.ru>
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > [Stephan: Add consistent commit message]
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 36 ++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 23 ++++++++++++
> >  arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  | 43 ++++++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> > index 6a16eb5ce07b..396853fcece5 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> > @@ -3,9 +3,12 @@
> >  /dts-v1/;
> >  
> >  #include "msm8916-pm8916.dtsi"
> > +#include "msm8916-modem-qdsp6.dtsi"
> > +
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/sound/apq8016-lpass.h>
> >  
> >  / {
> >  	aliases {
> > @@ -116,6 +119,17 @@ &blsp_uart2 {
> >  	status = "okay";
> >  };
> >  
> > +&lpass {
> > +	dai-link@3 {
> > +		reg = <MI2S_QUATERNARY>;
> > +		qcom,playback-sd-lines = <1>;
> > +	};
> > +};
> status = reserved?
> 

For reference:
https://lore.kernel.org/linux-arm-msm/ZRMwdRo9hAm4BO5E@gerhold.net/

> [...]
> >  
> > +	i2c-amplifier {
> > +		compatible = "i2c-gpio";
> > +		sda-gpios = <&tlmm 55 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> > +		scl-gpios = <&tlmm 56 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> non-msm8916 files have a space around the OR operator, hm
> 

Hm I can add a space if you think it looks better. :D

Thanks,
Stephan
