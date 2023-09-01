Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4E78FF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbjIAO2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343522AbjIAO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:28:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1AB9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:27:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a21b6d105cso245969466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693578474; x=1694183274; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEyh/swy7SSq80cvkD8Ou9qWCXNx2KRhHBoyBHAptPo=;
        b=0R3e9ICKhKNJS/iJ9j7O52ReWKyd0kKZi3ClpctBmj3YKR6NdCqo/sWNJZgk/HLrjm
         vVkObw5hJHuAGO8BirB6oWwg9VcDM4auE0TgSMbcMWSemvotcdgpqCf4j69cKVA4zouH
         aQKsaYlcBR/EKGVKSfSsi7UxbCk++dLsVvPibqhnwmWSAqeuKXYHPSYf0KlkYWBTU/+G
         hNDpPQPBQSsdC/JzNFUWYd8Ec/rFxzaI2UOhzwekFM5zB76sUQzzqy/7yu41ioqjMlEX
         grCYLlZon22Qj1yhrkZ7P1C0+aq62AJwY/Fiy83BSTmxYnkLS085VRIODNx1Q44g9mXH
         9WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578474; x=1694183274;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEyh/swy7SSq80cvkD8Ou9qWCXNx2KRhHBoyBHAptPo=;
        b=UUBfbgAfhyXAqBFUtnIsnNNjNWLQ4j2VSXRmrFssVJfxEk2MUPqshHsjw2rVZG+X7N
         Srz17nAwCQ0npsf/lfEEkNeXQ5LSFx/LIuQyafBpzQdwNKErvm8rBiZRVOSAQM3b4Pii
         ekIZLaQ4FCWDij/tOKdNaScdBo+mBxKqdCHHRDwhoy9zSwQZfEQFu/0Oz5p/P97OTAhg
         hAIJ8MLhVyRT7xdC39ILC5fQ6cAc74GV8w+U3YlKgoLdpx0aJqaNBIvRChkrahRvjzeY
         emDNliz9VttmdAvdOROwzev/8TxGwqaE+UFh3D9S/jw2i6WuE88Kn1POKYJoU590D9g9
         wjrQ==
X-Gm-Message-State: AOJu0Yw7sPa0zNt9+ISCt1QQyNo4DeZCjlu5BVXG0k7kWm8UTmEfwaKZ
        nFqrbjueRSG0i4VdGGZYAZ+eYA==
X-Google-Smtp-Source: AGHT+IELTYphsKmoa8uElxOgpt0BvTXKmP3twY/vRn2bptNKZ/qbTpEogtbv4BH6+FLnvY95r/VDOA==
X-Received: by 2002:a17:907:7847:b0:99d:101b:8403 with SMTP id lb7-20020a170907784700b0099d101b8403mr1928742ejc.36.1693578474415;
        Fri, 01 Sep 2023 07:27:54 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id mc24-20020a170906eb5800b00997e99a662bsm2033443ejb.20.2023.09.01.07.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:27:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 01 Sep 2023 16:27:53 +0200
Message-Id: <CV7NGPVH4U0W.PN2NOIO19Z7U@otso>
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
In-Reply-To: <72c2fd33-613b-49be-b394-0663f459f0c5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 30, 2023 at 12:45 PM CEST, Konrad Dybcio wrote:
> On 30.08.2023 11:58, Luca Weiss wrote:
> > Add device tree for the Fairphone 5 smartphone which is based on
> > the QCM6490 SoC.
> >=20
> > Supported features are, as of now:
> > * Bluetooth
> > * Debug UART
> > * Display via simplefb
> > * Flash/torch LED
> > * Flip cover sensor
> > * Power & volume buttons
> > * RTC
> > * SD card
> > * USB
> > * Various plumbing like regulators, i2c, spi, etc
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
> >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 659 +++++++++++++=
++++++++
> >  2 files changed, 660 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qc=
om/Makefile
> > index 2cca20563a1d..73c3be0f8872 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+=3D msm8998-sony-xperia-yosh=
ino-lilac.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+=3D msm8998-sony-xperia-yoshino-maple.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+=3D msm8998-sony-xperia-yoshino-poplar.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+=3D msm8998-xiaomi-sagit.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)	+=3D qcm6490-fairphone-fp5.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+=3D qcs404-evb-1000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+=3D qcs404-evb-4000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+=3D qdu1000-idp.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/=
arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > new file mode 100644
> > index 000000000000..572b254d3af2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > @@ -0,0 +1,659 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Luca Weiss <luca.weiss@fairphone.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/* PM7250B is configured to use SID8/9 instead of SID2/3 */
> > +#define PM7250B_SID 8
> > +#define PM7250B_SID1 9
> > +
> > +#include <dt-bindings/arm/qcom,ids.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include "sc7280.dtsi"
> > +#include "pm7250b.dtsi"
> > +#include "pm7325.dtsi"
> > +#include "pm8350c.dtsi" /* PM7350C */
> > +#include "pmk8350.dtsi" /* PMK7325 */
> > +
> > +/ {
> > +	model =3D "Fairphone 5";
> > +	compatible =3D "fairphone,fp5", "qcom,qcm6490";
> > +	chassis-type =3D "handset";
> > +
> > +	/* required for bootloader to select correct board */
> > +	qcom,msm-id =3D <QCOM_ID_QCM6490 0x10000>;
> > +	qcom,board-id =3D <34 0>;
> Try [1], it worked for me on a picky device.

Yes, that works! Thanks!

>
> > +
> > +	aliases {
> > +		serial0 =3D &uart5;
> > +		serial1 =3D &uart7;
> > +	};
> > +
> > +	chosen {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +
> > +		framebuffer0: framebuffer@a000000 {
> > +			compatible =3D "simple-framebuffer";
> > +			reg =3D <0 0xe1000000 0 (2700 * 1224 * 4)>;
> 0x0?

Ack

>
> > +			width =3D <1224>;
> > +			height =3D <2700>;
> > +			stride =3D <(1224 * 4)>;
> > +			format =3D "a8r8g8b8";
> > +			panel =3D <&panel>;
> > +			clocks =3D <&gcc GCC_DISP_HF_AXI_CLK>;
> > +		};
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible =3D "gpio-keys";
> > +
> > +		pinctrl-0 =3D <&volume_down_default>, <&hall_sensor_default>;
> > +		pinctrl-names =3D "default";
> > +
> > +		key-volume-up {
> > +			label =3D "Volume up";
> > +			gpios =3D <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> > +			linux,code =3D <KEY_VOLUMEUP>;
> > +		};
> > +
> > +		/* Hall sensor uses vreg_l8c as VDD, it's being enabled using
> > +		 * always-on on the regulator
> > +		 */
> /* Powered by the always-on vreg_l8c */ - fits in a single line

Ack

>
> > +		event-hall-sensor {
> > +			label =3D "Hall Effect Sensor";
> > +			gpios =3D <&tlmm 155 GPIO_ACTIVE_LOW>;
> > +			linux,input-type =3D <EV_SW>;
> > +			linux,code =3D <SW_LID>;
> > +			linux,can-disable;
> > +			wakeup-source;
> > +		};
> > +	};
> > +
> > +	panel: panel {
> > +		compatible =3D "boe,rm692e5";
> Undocumented compatbile

Not quite sure how to document this properly. This dummy panel node is
used for the simplefb/simpledrm so that user space can get panel
dimensions already.

This approach of a separate panel node was apparently preferred when the
functionality was upstreamed but of course as can be seen this panel
node is very barebones where many properties are not present which would
be needed with the full panel driver (once it's working).

Also for example for the bindings I think width-mm and height-mm won't
be needed anymore since that information will be provided by the driver
then.

Please let me know how/where to document this.

>
> > +
> > +		width-mm =3D <68>;
> > +		height-mm =3D <150>;
> > +	};
> > +
> > +	reserved-memory {
> > +		cont_splash_mem: cont-splash@e1000000 {
> > +			reg =3D <0 0xe1000000 0 0x2300000>;
> 0x0

Ack

>
> [...]
>
> > +		vreg_s1b: smps1 {
> > +			regulator-min-microvolt =3D <1840000>;
> > +			regulator-max-microvolt =3D <2040000>;
> No regulator-initial-mode on this pmic?

This specific regulator doesn't have one downstream, but it seems other
pm7325 regulators do have this downstream so I'll add it in v2.

>
> [...]
>
> > +
> > +	/* PM8008 PMIC @ 8 and 9 */
> > +	/* Pixelworks @ 26 */
> > +	/* FSA4480 USB audio switch @ 42 */
> There's a driver for the fsa4480, you may wanna include a node here

I'm aware, but will work on this later since it's not useful without
USB-C role switching and working audio.

>
> > +	/* AW86927FCR haptics @ 5a */
> > +};
> [...]
>
> > +
> > +	led-0 {
> > +		function =3D LED_FUNCTION_FLASH;
> No dual-tone stuff?

Nope.

>
> > +		color =3D <LED_COLOR_ID_WHITE>;
> > +		led-sources =3D <1>, <4>;
> > +		led-max-microamp =3D <500000>;
> > +		flash-max-microamp =3D <1500000>;
> > +		flash-max-timeout-us =3D <1280000>;
> > +	};
> > +};
> > +
> > +&pmk8350_rtc {
> > +	status =3D "okay";
> > +};
> > +
> > +&pon_pwrkey {
> > +	status =3D "okay";
> > +};
> > +
> > +&pon_resin {
> > +	status =3D "okay";
> > +	linux,code =3D <KEY_VOLUMEDOWN>;
> status last

Ack

>
> [...]
>
> > +&rmtfs_mem {
> > +	qcom,vmid =3D <QCOM_SCM_VMID_MSS_MSA>, <QCOM_SCM_VMID_NAV>;
> > +	reg =3D <0x0 0xf8500000 0x0 0x600000>;
> > +};
> /delete-node/ + redefinition would probably be cleaner-looking

Ack, looks better.

>
> [...]
>
> > +&uart7 {
> > +	/delete-property/interrupts;
> > +	interrupts-extended =3D <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> > +			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +	pinctrl-names =3D "default", "sleep";
> > +	pinctrl-1 =3D <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_u=
art7_sleep_tx>, <&qup_uart7_sleep_rx>;
> property-n
> property-names

Ack

>
> > +
> > +	status =3D "okay";
> > +
> > +	bluetooth: bluetooth {
> > +		compatible =3D "qcom,wcn6750-bt";
> > +
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&bluetooth_enable_default>, <&sw_ctrl_default>;
> property-n
> property-names

Ack

Regards
Luca

>
> Konrad
>
> [1] https://lore.kernel.org/linux-arm-msm/9db02015-2c41-40d6-bf35-69ef277=
e9ce4@linaro.org/

