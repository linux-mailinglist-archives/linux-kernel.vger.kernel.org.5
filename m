Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA37C78A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442934AbjJLVdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442861AbjJLVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:33:22 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F539B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:33:21 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57d086365f7so733941eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697146400; x=1697751200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BYkIIVgUSUDIvsA7oyJJgebrxVB8pqETFUsWWaA5is=;
        b=IOWpv2JCe9JC4JjCyabZyXBCuX684ya0ywTyUwwZcrqk8O3vvY30+ETVxm7RfTCKWc
         aoCoZ98ZWzIhX6kHV/YJaeBRV2QJYKsk0ZM+HrgnPM7YG7xO3WMalImRFmBzJtydwEkn
         Fftj3S8mA4Chbc2ziDJvZEn0jWTyZjoeLrefo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146400; x=1697751200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BYkIIVgUSUDIvsA7oyJJgebrxVB8pqETFUsWWaA5is=;
        b=ksnl4i1LFaqyMm8si3h5Fhzk/nQJGwWb74lJzk7nvC8IfIxeyVywQVHFzFXJk5GlGn
         JGHwEKL73pJe7IZSxmLNOC88CFYg4DIWj9yvrcSU69lELWjDtUvnZSYJapmYT7ueC6OF
         LEOwyZVJJmEou3ByDDgw2uzC3yPRGoMu7U9nEYzCoqzw+M54DPza0lz7JkdAf546qQ8I
         ZWM9oM+KBTkk6GZDY9tC9VykyovyiCtHyytRuNqX/KK2E3xrZT40VR776L5jLnH/bA3P
         B+1R8RUo3fO6NE7tNzme+j6mWrWcMBFBhdi+54CInDFZPYQMkTjDwzmpRbCfaJKRO7rx
         uKuA==
X-Gm-Message-State: AOJu0YxE9JzUhi7YNA4T7Q1BWgJ87AZh+unPIbflSFgIZvemeHM7Kzum
        npl/SLJTVQreNEQUe9IejdsvzA==
X-Google-Smtp-Source: AGHT+IEWHo3wYMQMcz7GsN7HjGYb7tuVwk/HPXskUKjfbq7nnE1N5b1naGdES5Ku76oGH6B7c1F9zA==
X-Received: by 2002:a05:6358:988d:b0:135:b4c:a490 with SMTP id q13-20020a056358988d00b001350b4ca490mr26095712rwa.10.1697146400420;
        Thu, 12 Oct 2023 14:33:20 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0069319bfed42sm12141026pff.79.2023.10.12.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:33:19 -0700 (PDT)
Date:   Fri, 13 Oct 2023 05:33:16 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/4] arm64: dts: mediatek: cherry: Add platform
 thermal configuration
Message-ID: <20231012213316.GA2659196@google.com>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-2-angelogioacchino.delregno@collabora.com>
 <31d1d1e4-2f75-bbbd-3e4b-6c796f2d39d1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d1d1e4-2f75-bbbd-3e4b-6c796f2d39d1@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo

On Tue, Apr 25, 2023 at 01:46:42PM +0200, Alexandre Mergnat wrote:
> On 24/04/2023 13:25, AngeloGioacchino Del Regno wrote:
> > This platform has three auxiliary NTC thermistors, connected to the
> > SoC's ADC pins. Enable the auxadc in order to be able to read the
> > ADC values, add a generic-adc-thermal LUT for each and finally assign
> > them to the SoC's thermal zones.
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 105 ++++++++++++++++++
> >   1 file changed, 105 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > index 8ac80a136c37..4229f4f7dc2f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > @@ -114,6 +114,77 @@ ppvar_sys: regulator-ppvar-sys {
> >   		regulator-boot-on;
> >   	};
> > +	/* Murata NCP03WF104F05RL */
> > +	tboard_thermistor1: thermal-sensor-t1 {
> > +		compatible = "generic-adc-thermal";
> > +		#thermal-sensor-cells = <0>;
> > +		io-channels = <&auxadc 0>;
> > +		io-channel-names = "sensor-channel";
> > +		temperature-lookup-table = <	(-10000) 1553
> > +						(-5000) 1485
> > +						0 1406
> > +						5000 1317
> > +						10000 1219
> > +						15000 1115
> > +						20000 1007
> > +						25000 900
> > +						30000 796
> > +						35000 697
> > +						40000 605
> > +						45000 523
> > +						50000 449
> > +						55000 384
> > +						60000 327
> > +						65000 279
> > +						70000 237
> > +						75000 202
> > +						80000 172
> > +						85000 147
> > +						90000 125
> > +						95000 107
> > +						100000 92
> > +						105000 79
> > +						110000 68
> > +						115000 59
> > +						120000 51
> > +						125000 44>;
> > +	};
> > +
> > +	tboard_thermistor2: thermal-sensor-t2 {
> > +		compatible = "generic-adc-thermal";
> > +		#thermal-sensor-cells = <0>;
> > +		io-channels = <&auxadc 1>;
> > +		io-channel-names = "sensor-channel";
> > +		temperature-lookup-table = <	(-10000) 1553
> > +						(-5000) 1485
> > +						0 1406
> > +						5000 1317
> > +						10000 1219
> > +						15000 1115
> > +						20000 1007
> > +						25000 900
> > +						30000 796
> > +						35000 697
> > +						40000 605
> > +						45000 523
> > +						50000 449
> > +						55000 384
> > +						60000 327
> > +						65000 279
> > +						70000 237
> > +						75000 202
> > +						80000 172
> > +						85000 147
> > +						90000 125
> > +						95000 107
> > +						100000 92
> > +						105000 79
> > +						110000 68
> > +						115000 59
> > +						120000 51
> > +						125000 44>;
> > +	};
> > +
> >   	usb_vbus: regulator-5v0-usb-vbus {
> >   		compatible = "regulator-fixed";
> >   		regulator-name = "usb-vbus";
> > @@ -260,6 +331,10 @@ &gpu {
> >   	mali-supply = <&mt6315_7_vbuck1>;
> >   };
> > +&auxadc {
> 
> Can you put it in alphabetical order please. ?

I believe this patch needs to be respun?

> > +	status = "okay";
> > +};
> > +
> >   &i2c0 {
> >   	status = "okay";
> > @@ -1098,6 +1173,36 @@ mt6315_7_vbuck1: vbuck1 {
> >   	};
> >   };
> > +&thermal_zones {
> > +	soc-area-thermal {
> > +		polling-delay = <1000>;
> > +		polling-delay-passive = <250>;
> > +		thermal-sensors = <&tboard_thermistor1>;
> > +
> > +		trips {
> > +			trip-crit {
> > +				temperature = <84000>;
> > +				hysteresis = <1000>;
> > +				type = "critical";
> > +			};
> > +		};
> > +	};
> > +
> > +	pmic-area-thermal {
> > +		polling-delay = <1000>;
> > +		polling-delay-passive = <0>;
> > +		thermal-sensors = <&tboard_thermistor2>;
> > +
> > +		trips {
> > +			trip-crit {
> > +				temperature = <84000>;
> > +				hysteresis = <1000>;
> > +				type = "critical";
> > +			};
> > +		};
> > +	};
> > +};
> > +
> >   &u3phy0 {
> >   	status = "okay";
> >   };
> 
> After that:
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> Regards,
> Alexandre
> 
