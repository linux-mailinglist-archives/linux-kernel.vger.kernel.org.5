Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051C7C95CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjJNRx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 13:53:21 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECAEAD;
        Sat, 14 Oct 2023 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697305966; bh=J6E11bWGXsldQJECPuC0snlXP/OiLacD+sKcuNZkyLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LHxU4RsKfzcPKNkWGel5p6xLlzZot7D1l8dhZ9lLIxbaXNCMd4FC1OB/U8Ssf79/n
         MRk5MCU616km8zpjji8NK9FHAeUkHJh5ryfc96F1b2QWlM9UKZf8sK8e8YIMBgRR9u
         1szYjx1LpkM4vHvGmBo9aLbB7BcpbQfyxve76LIo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325 thermals
Date:   Sat, 14 Oct 2023 19:52:45 +0200
Message-ID: <4958673.31r3eYUQgx@z3ntu.xyz>
In-Reply-To: <34da335e-cbcd-4dc2-8a86-f31369db1fcd@linaro.org>
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
 <20231013-fp5-thermals-v1-4-f14df01922e6@fairphone.com>
 <34da335e-cbcd-4dc2-8a86-f31369db1fcd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 14. Oktober 2023 01:13:29 CEST Konrad Dybcio wrote:
> On 13.10.2023 10:09, Luca Weiss wrote:
> > Configure the thermals for the QUIET_THERM, CAM_FLASH_THERM, MSM_THERM
> > and RFC_CAM_THERM thermistors connected to PM7325.
> > 
> > With this PMIC the software communication to the ADC is going through
> > PMK7325 (= PMK8350).
> > 
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > 
> >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 117
> >  +++++++++++++++++++++ 1 file changed, 117 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts index
> > 2c01f799a6b2..d0b1e4e507ff 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > @@ -9,6 +9,7 @@
> > 
> >  #define PM7250B_SID 8
> >  #define PM7250B_SID1 9
> > 
> > +#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
> > 
> >  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> >  #include <dt-bindings/leds/common.h>
> >  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > 
> > @@ -137,6 +138,20 @@ afvdd_2p8: regulator-afvdd-2p8 {
> > 
> >  	};
> >  	
> >  	thermal-zones {
> > 
> > +		camera-thermal {
> > +			polling-delay-passive = <0>;
> > +			polling-delay = <0>;
> > +			thermal-sensors = <&pmk8350_adc_tm 2>;
> > +
> > +			trips {
> > +				active-config0 {
> > +					temperature = <125000>;
> 
> are
> 
> > +		rear-cam-thermal {
> > 
> > +					temperature = <125000>;
> 
> you
> 
> > +		sdm-skin-thermal {
> > 
> > +					temperature = <125000>;
> 
> sure
> 
> about these temps?

(email from my other address, quicker right now)

Well yes and no.

Yes as in those are the temps specified in downstream dtb.
No as in I'm 99% sure there's user space with definitely lower threshold that 
actually does something in response to the temps.

I didn't look too much into this but does the kernel even do something when it 
hits one of these trip points? I assume when there's a cooling device thing 
specified then it can actually tell the driver to do something, but without 
(and most drivers don't support this?) I'm assuming the kernel can't do much 
anyways?

So e.g. when the temperature for the flash led is reached I'm assuming 
downstream (+Android) either dims the led or turns it off? But I'd have to dig 
quite a bit into the thermal setup there to check what it's really doing.

But for now I think it's okay to put this current thermal config into dts and 
we'll improve it later when 1. I understand more and 2. maybe some useful 
drivers support the cooling bits?

Regards
Luca

> 
> Konrad




