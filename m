Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5427AF41D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjIZT1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:27:02 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF7C193;
        Tue, 26 Sep 2023 12:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695756407; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j5vO5Z+d6AFqtgPF9hbTxSr4Q3zdMvZRGY1iXWQonVYkA1/Rb1OY+k13PF1q/p/Kvt
    1K0D/gC3uHbv3T86wYJ7PAPfotnOVV5M9AUT4H3qthMprVaovWoP9Xbn+ZZuonm/ECeN
    L/MChnYb9bEgdgEZEXIVOVQwt/+uECm7tJ1JuUGU49n+KdBt1TrwghnUGoRPvsauNdaZ
    s9LL2JVQl1152Sk3N0x3buCGRqSJF35EwGEDdxB1gr7cf8OfaJVd0yoBqpZ+yeTuDhdR
    TdX8gTb/upFJSfYSYsP3fSsLsxHui8WCTxmafhUETzc8xCUI//Gnw9UCIJNLr46vc/F6
    7Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695756407;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4FqenWm85bgQFUJF4ZZgZ9PH37olU8MqKVaaTd8hPqA=;
    b=VFHaRYwEZJkKVLbdcHc1H0qVElP5DEzDepnkJM3M7fiO0HaQHhmevFxqO147adRgRZ
    i+/mvaOzQQqHOB8q/nDLQWEpj9sRxQn9NxzJYoNRQtgnTXff1+R3DSrbk/TWah7LscHJ
    YzhsuLhuLfUQuZ4Yj0XBqRaxCpyUjOsv/EmFCgKzJcuJzy8OH28Q9BE0DlZFclB4mAxM
    vnwI2fQ0XisuZ4iyz5QdaUV5dlWB9a8TYpucBAjYDBDZk7uzqQJwz9A4byjKRObGWLm+
    /WCzWWukhgZiThK8DU/nl/D3XvxRm5q83qdnr1emtSKtn7ZRlByg7LFOPVCSvL4Qmu7d
    8q4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695756407;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4FqenWm85bgQFUJF4ZZgZ9PH37olU8MqKVaaTd8hPqA=;
    b=etilVRUji3m4T5WC/XndJD950mA0M9HOjWthkIUzuuiYW2CZ9VBnZQIgJMFEz/d+dD
    1dKoxji1hFqaju/mJwj+6iS//3M4GgjsgNCs9JU9GeCMu5vOMGxvsKFNf/EtLJWiBZcX
    n7IhbZSMdgS+/97YECjP4jlFEiRf0gkIBb+Cv3ytMSHiT7xP0T2iCue5+xeK1C6zllEP
    jX17CMM9ZvEDfc79LApmovV328g2Ec59fzRKEEki+1Hp6Z648XfyZHdizWmmQcIr7lza
    CWlMDpPklHQW55kStE5H3Fk/RR8R+LnOIz85LKFP9YXtxEqpahqVkoJrBK/1mxIRqr8f
    ebgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695756406;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4FqenWm85bgQFUJF4ZZgZ9PH37olU8MqKVaaTd8hPqA=;
    b=KuQRe1o4T2S0QWo8poFQyef4A941Cw5r9nCA8MP3Rtow7B28xuGkSjmvpYy99fY4tT
    0/03smhxUjc89nVa80BA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QJQkgM9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 21:26:46 +0200 (CEST)
Date:   Tue, 26 Sep 2023 21:26:45 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH 04/13] arm64: dts: qcom: msm8916-samsung-a2015: Add sound
 and modem
Message-ID: <ZRMwdRo9hAm4BO5E@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-4-398eec74bac9@gerhold.net>
 <2c9eda54-a90e-483a-abc2-865d82854b80@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9eda54-a90e-483a-abc2-865d82854b80@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:54:29PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > Enable sound and modem for the Samsung A2015 based devices (A3, A5, E5,
> > E7, Grand Max). The setup is similar to most MSM8916 devices, i.e.:
> > 
> >  - QDSP6 audio
> >  - Earpiece/headphones/microphones via digital/analog codec in
> >    MSM8916/PM8916
> >  - WWAN Internet via BAM-DMUX
> > 
> > except:
> > 
> >  - NXP TFA9895 codec for speaker on Quaternary MI2S
> >  - Samsung-specific audio jack detection (not supported yet)
> > 
> > [Lin: Add e2015 and grandmax]
> > Co-developed-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> > Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 55 ++++++++++++++++++++++
> >  .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |  4 ++
> >  .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |  4 ++
> >  3 files changed, 63 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> > index 0b29132b74e1..f71b18d89bf9 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> > @@ -1,10 +1,13 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  
> >  #include "msm8916-pm8916.dtsi"
> > +#include "msm8916-modem-qdsp6.dtsi"
> > +
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +#include <dt-bindings/sound/apq8016-lpass.h>
> >  
> >  / {
> >  	aliases {
> > @@ -196,6 +199,18 @@ vibrator: vibrator {
> >  	};
> >  };
> >  
> > +&blsp_i2c1 {
> > +	status = "okay";
> > +
> > +	speaker_codec: audio-codec@34 {
> > +		compatible = "nxp,tfa9895";
> > +		reg = <0x34>;
> > +		vddd-supply = <&pm8916_l5>;
> > +		sound-name-prefix = "Speaker";
> > +		#sound-dai-cells = <0>;
> > +	};
> > +};
> > +
> >  &blsp_i2c2 {
> >  	status = "okay";
> >  
> > @@ -243,6 +258,13 @@ &gpu {
> >  	status = "okay";
> >  };
> >  
> > +&lpass {
> > +	dai-link@3 {
> > +		reg = <MI2S_QUATERNARY>;
> > +		qcom,playback-sd-lines = <1>;
> > +	};
> > +};
> Is that not status = reserved?
> 

Correct. This is here to simplify switching to the modem-bypass audio
routing if someone does not need (or want) the modem. The direct audio
path with the LPASS drivers tends to be more reliable and configurable
(especially wrt bit formats, sampling rates, latency, channels etc).
I know that at some point this helped someone who tried to use an old
phone as some kind of portable musical instrument / synthesizer.

It's not too obvious that these definitions would be needed when making
those changes (because devices using the standard SD lines (i.e <0>) do
not need it). If you forget about this you get non-functional audio with
no error or any hint what could be wrong.

To simplify switching between the different audio routing options, the
lk2nd bootloader actually has an option to do this transformation in the
DTB automagically during boot. It's sort of like a DTB overlay that
disables the QDSP6 audio path and enables this node instead. The DAI
links are also adjusted where necessary.

Do you think a comment would help here?

Thanks,
Stephan
