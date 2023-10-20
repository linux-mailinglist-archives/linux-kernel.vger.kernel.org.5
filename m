Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143EC7D0E67
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbjJTLb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376935AbjJTLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:31:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4106D41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:31:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so108458866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697801483; x=1698406283; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq2xrfNltYx9WSMnF1/a8wXflPx/W1Agx/pfa3OmDS8=;
        b=RHXNqmjaBKZTAcM5cWSGFFK5xghL1oI26DeoGCEFtbVthNIDcTg2ELcd2vLHvvVaaz
         Xmh/8gCaHAr2HsEgV3K6m0rWirq5bHfp/mU7wQlJ6VvjDfREp98Ei1dfXUuE9DiYUupB
         +pqHHUkMwkPiDNfCK4m4100Ob6tErA1krpZWae9F9XQt1fDpuKZhCBPVs4yklwzqvk0b
         k506piHOxXfr9yCopSZ66h7BlDeTjdbZYoDoo1lymXjsti1vPAE+qFbinJYHxuI7U6C/
         CvJE5kkfwYhPiB/Uit5AmFBRXUfbTw4aFC627iaWd5NdraVa00wU40xB44PDT/P2Z7CY
         kYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697801483; x=1698406283;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wq2xrfNltYx9WSMnF1/a8wXflPx/W1Agx/pfa3OmDS8=;
        b=UWoA8vKgHuPl+xcBxpn0eu1uejWnZHYbX1H9qi+SIun3aEFEYKeAEfcxyeHfC8rfhp
         Z5jwG0jVDax5ZygN3K6J9yp5ntevn0z2V/yEQ9vhrGGnKbwBi4CPmDewV+TF7ZqAJ+NK
         Z5tOeVhWql6mQNRT9GE/h0hvds5plr0uEWUcEebJRZwmZUAgammgpX/4HkbgYhGgXZfK
         0kjukNtb/J82ye9Qji2RKLKScy+xrELhFRT3uTqbSGftdwxkXuc9BiJaHKaZXZJDmfI0
         COBumFQP5MTbilsPpXmeJN8cbskKFrLmQrJU03Svv5ctgDM5321huL/FoCENU1gaAqa6
         nThg==
X-Gm-Message-State: AOJu0YzHS9KA4w7lYRZNtTZglboIGV3ar3z1P1WJS2pzAVyuMZuVmf76
        Abe5oJBNsg0ihT3t/z4rclCvXw==
X-Google-Smtp-Source: AGHT+IEoeeFassbx3MNsZzZQpCjvyxQFxuHG8gi+lfJpmHgfzm7BufAONGqis7o9C64A7nCYKhEJSA==
X-Received: by 2002:a17:906:c112:b0:9a5:846d:d81f with SMTP id do18-20020a170906c11200b009a5846dd81fmr1026518ejc.17.1697801483081;
        Fri, 20 Oct 2023 04:31:23 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090611ce00b009b29553b648sm1279266eja.206.2023.10.20.04.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 04:31:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 Oct 2023 13:31:21 +0200
Message-Id: <CWD8E95B0W8L.1UMMGJXJF47D@fairphone.com>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Cc:     <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325
 thermals
X-Mailer: aerc 0.15.2
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
 <20231013-fp5-thermals-v1-4-f14df01922e6@fairphone.com>
 <34da335e-cbcd-4dc2-8a86-f31369db1fcd@linaro.org>
 <4958673.31r3eYUQgx@z3ntu.xyz>
 <5ac0d16a-0303-46c7-a008-31280629cc11@linaro.org>
In-Reply-To: <5ac0d16a-0303-46c7-a008-31280629cc11@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 18, 2023 at 10:28 PM CEST, Konrad Dybcio wrote:
>
>
> On 10/14/23 19:52, Luca Weiss wrote:
> > On Samstag, 14. Oktober 2023 01:13:29 CEST Konrad Dybcio wrote:
> >> On 13.10.2023 10:09, Luca Weiss wrote:
> >>> Configure the thermals for the QUIET_THERM, CAM_FLASH_THERM, MSM_THER=
M
> >>> and RFC_CAM_THERM thermistors connected to PM7325.
> >>>
> >>> With this PMIC the software communication to the ADC is going through
> >>> PMK7325 (=3D PMK8350).
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>>
> >>>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 117
> >>>   +++++++++++++++++++++ 1 file changed, 117 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> >>> b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts index
> >>> 2c01f799a6b2..d0b1e4e507ff 100644
> >>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> >>> @@ -9,6 +9,7 @@
> >>>
> >>>   #define PM7250B_SID 8
> >>>   #define PM7250B_SID1 9
> >>>
> >>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
> >>>
> >>>   #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> >>>   #include <dt-bindings/leds/common.h>
> >>>   #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >>>
> >>> @@ -137,6 +138,20 @@ afvdd_2p8: regulator-afvdd-2p8 {
> >>>
> >>>   	};
> >>>   =09
> >>>   	thermal-zones {
> >>>
> >>> +		camera-thermal {
> >>> +			polling-delay-passive =3D <0>;
> >>> +			polling-delay =3D <0>;
> >>> +			thermal-sensors =3D <&pmk8350_adc_tm 2>;
> >>> +
> >>> +			trips {
> >>> +				active-config0 {
> >>> +					temperature =3D <125000>;
> >>
> >> are
> >>
> >>> +		rear-cam-thermal {
> >>>
> >>> +					temperature =3D <125000>;
> >>
> >> you
> >>
> >>> +		sdm-skin-thermal {
> >>>
> >>> +					temperature =3D <125000>;
> >>
> >> sure
> >>
> >> about these temps?
> >=20
> > (email from my other address, quicker right now)
> >=20
> > Well yes and no.
> >=20
> > Yes as in those are the temps specified in downstream dtb.
> > No as in I'm 99% sure there's user space with definitely lower threshol=
d that
> > actually does something in response to the temps.
> >=20
> > I didn't look too much into this but does the kernel even do something =
when it
> > hits one of these trip points? I assume when there's a cooling device t=
hing
> > specified then it can actually tell the driver to do something, but wit=
hout
> > (and most drivers don't support this?) I'm assuming the kernel can't do=
 much
> > anyways?
> >=20
> > So e.g. when the temperature for the flash led is reached I'm assuming
> > downstream (+Android) either dims the led or turns it off? But I'd have=
 to dig
> > quite a bit into the thermal setup there to check what it's really doin=
g.
> I think reaching "critical" shuts down the platform, unless something
> registering the thermal zone explicitly overrides the behavior.

Should probably be easy to test, especially the camera flash thermal
zone heats up *very* quickly when the flash is on, so should be trivial
to set the trip point down from 125degC to e.g. 45degC and see what
happens.

So I did this and... nothing happened.
I watched /sys/class/thermal/thermal_zone34/temp climb above 45degC and
nothing happened.

I guess trip type being "passive" and no cooling-device makes it not do
anything.

  =3D=3D> /sys/class/thermal/thermal_zone34/trip_point_0_hyst <=3D=3D
  1000
  =3D=3D> /sys/class/thermal/thermal_zone34/trip_point_0_temp <=3D=3D
  45000
  =3D=3D> /sys/class/thermal/thermal_zone34/trip_point_0_type <=3D=3D
  passive

From Documentation/devicetree/bindings/thermal/thermal-zones.yaml:

  - active   # enable active cooling e.g. fans
  - passive  # enable passive cooling e.g. throttling cpu
  - hot      # send notification to driver
  - critical # send notification to driver, trigger shutdown

So unless we want to just shut down the system (with "critical"), I
don't think thermal can't really do anything else right now, since e.g.
leds-qcom-flash.c driver doesn't have any cooling support to lower the
brightness or turn off the LED.

So.. in essence not much we can do right now.

But seems we also cannot remove this (kinda useless) trip since we need
at least one trip point in the dts if I read the bindings yaml
correctly.

>
> >=20
> > But for now I think it's okay to put this current thermal config into d=
ts and
> > we'll improve it later when 1. I understand more and 2. maybe some usef=
ul
> > drivers support the cooling bits?
> Yeah it's better than nothing, but ultimately we should probably move
> the values that userspace daemon operates on here in the dt..

For sure.. I spent a bit of time looking into the proprietary Qualcomm
thermal-daemon sources but didn't really see much interesting things
there for this platform, maybe some of this thermal handling is
somewhere else - or half of these thermal zones aren't even used with
Android.

So.. good to get the current patch upstream or not? :)

Regards
Luca

>
> Konrad

