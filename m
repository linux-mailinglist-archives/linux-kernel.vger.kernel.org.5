Return-Path: <linux-kernel+bounces-130457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA64897872
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCBF1C25C38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131D15443A;
	Wed,  3 Apr 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JH409wzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y2A6FpDN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435113FB14;
	Wed,  3 Apr 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169844; cv=none; b=SepR2Jc2g65vYRpfKvWlKXFhIp/cPokF30IZ7V3nHfKAAQ/HqqTUK7H4yOm+eF4z9ZSQNa4Nh/Qq2JnS2HQAY6QgeHrfL2cTRCzmkjrBazCHSGtiDzROgSjyH0mOG7r1GcdYNVY7e5YpLdinwyHoeWj4GdpuA7jBf/FgbKLaX6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169844; c=relaxed/simple;
	bh=fAa1IfaVvOBUH6OY5hvcTNTUFB4e4lHih47ib1dVbSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfAT2x/Gm8pJIZxMmZnu3829klF2ytJhAfjwn+xolxXKVqEBzSobkB7LN1WLvicRnz8+XtLMr1w4pKiwJ6U6KAzZUB5AV1a2hrbMKBAhploNRNgm6RQoNi4BxraKHAJgBuNttJBJ/1oxAzYDMtnWQ5GWYr00N931CNL+qzJvZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JH409wzB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y2A6FpDN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51E2B5D020;
	Wed,  3 Apr 2024 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712169840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfPpMb/YshBeYL3g/DsV8plhBen10ssrnkWSdmViQnk=;
	b=JH409wzB4Ad9htZ0DoMCeqlklpXfjNYE2Ug1VODKYHfzqtWgSmpx7f7FGjfm1JdkTuxbeQ
	/aet5VYvj/JdNWVOMgsVkM+dtykqvpP+HX5qkLsEUljlAZZJk/xWJrWzoU//B8Tku7btln
	IEeUxT2CpjvLmdVhzQAzJ2J9vxnwHZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712169840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfPpMb/YshBeYL3g/DsV8plhBen10ssrnkWSdmViQnk=;
	b=y2A6FpDNrbr+bE90Vyhef4TaSLaSbSYliWyqzuZU7sgDlNa+Ulwlb8zfurRiE3/K+/gc6K
	2cAGBJcWl3yON8Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F60613357;
	Wed,  3 Apr 2024 18:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2vyGDG+jDWZaMAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 03 Apr 2024 18:43:59 +0000
Date: Wed, 3 Apr 2024 20:43:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexander Reimelt <alexander.reimelt@posteo.de>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add basic support for LG G4 (H815)
Message-ID: <20240403184353.GC462665@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
 <20240403104415.30636-3-alexander.reimelt@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403104415.30636-3-alexander.reimelt@posteo.de>
X-Rspamd-Queue-Id: 51E2B5D020
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	R_DKIM_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO

Hi,

> To make it easier for downstream projects and avoid duplication of work.
> Makes the device bootable and enables all buttons, most regulators, hall sensor, eMMC and SD-Card.

> Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts | 422 +++++++++++++++++++
>  2 files changed, 423 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts

> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..5b7f8741006f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-h815.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-xiaomi-libra.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-huawei-angler-rev-101.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> new file mode 100644
> index 000000000000..b7fa48337e25
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * MSM8992 LG G4 (h815) device tree.
> + *
> + * Copyright (c) 2024, Alexander Reimelt <alexander.reimelt@posteo.de>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8992.dtsi"
> +#include "pm8994.dtsi"
> +#include "pmi8994.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/* different mapping */
> +/delete-node/ &cont_splash_mem;
> +
> +/* disabled downstream */
> +/delete-node/ &dfps_data_mem;
> +
> +&CPU0 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU1 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU2 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU3 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU4 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU5 {
> +	enable-method = "spin-table";
> +};
> +
> +/ {
> +	model = "LG G4 (International)";
I'm not sure if " (International)" shouldn't be dropped.
I guess maintainers will know.

> +	compatible = "lg,h815", "qcom,msm8992";
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <251 0>;
> +	qcom,pmic-id = <0x10009 0x1000a 0x00 0x00>;
> +	qcom,board-id = <0xb64 0>;
> +
> +	/* psci is broken */
> +	/delete-node/ psci;
> +
> +	chosen {
> +		bootargs = "earlycon=tty0 console=tty0";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		spin-table@6000000 {
> +			reg = <0 0x6000000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		ramoops@ff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xff00000 0x0 0x100000>;
> +			console-size = <0x20000>;
> +			pmsg-size = <0x20000>;
> +			record-size = <0x10000>;
> +			ecc-size = <0x10>;
> +		};
> +
> +		cont_splash_mem: fb@3400000 {
> +			compatible = "framebuffer";
> +			reg = <0 0x3400000 0 0xc00000>;
> +			no-map;
> +		};
> +
> +		crash_fb_mem: crash_fb@4000000 {
> +			reg = <0 0x4000000 0 0xc00000>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio-hall-sensor {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&hall_sensor_default>;
> +		pinctrl-names = "default";
> +
> +		label = "Hall Effect Sensor";
> +
> +		event-hall-sensor {
> +			gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
> +			label = "hall effect sensor";
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-vol-up {
> +			label = "volume up";
> +			gpios = <&pm8994_gpios 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +		};
> +	};
> +};
> +
> +&pm8994_spmi_regulators {
> +	vdd_s8-supply = <&vph_pwr>;
> +	vdd_s11-supply = <&vph_pwr>;
> +
> +	pm8994_s8: s8 {
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1180000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	pm8994_s11: s11 {
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1225000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&rpm_requests {
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm8994-regulators";
> +
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s5-supply = <&vph_pwr>;
> +		vdd_s7-supply = <&vph_pwr>;
> +		vdd_l1-supply = <&pmi8994_s1>;
> +		vdd_l2_26_28-supply = <&pm8994_s3>;
> +		vdd_l3_11-supply = <&pm8994_s3>;
> +		vdd_l4_27_31-supply = <&pm8994_s3>;
> +		vdd_l5_7-supply = <&pm8994_s5>;
> +		vdd_l6_12_32-supply = <&pm8994_s5>;
> +		vdd_l8_16_30-supply = <&vph_pwr>;
> +		vdd_l9_10_18_22-supply = <&pmi8994_bby>;
> +		vdd_l13_19_23_24-supply = <&pmi8994_bby>;
> +		vdd_l14_15-supply = <&pm8994_s5>;
> +		vdd_l17_29-supply = <&pmi8994_bby>;
> +		vdd_l20_21-supply = <&pmi8994_bby>;
> +		vdd_l25-supply = <&pm8994_s5>;
> +		vdd_lvs1_2-supply = <&pm8994_s4>;
> +
> +		pm8994_s3: s3 {
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1300000>;
> +		};
> +
> +		/* sdhc1 vqmmc and bcm */
> +		pm8994_s4: s4 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-system-load = <325000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		pm8994_s5: s5 {
> +			regulator-min-microvolt = <2150000>;
> +			regulator-max-microvolt = <2150000>;
> +		};
> +
> +		pm8994_s7: s7 {
There are several unused regulators.

I remember Bjorn back at the time suggested [1] me to add only regulators which
are actually needed.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-arm-msm/20230407165730.jfupmfiul6qb7yl3@ripper/

> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm8994_l1: l1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm8994_l2: l2 {
> +			regulator-min-microvolt = <1250000>;
> +			regulator-max-microvolt = <1250000>;
> +			regulator-system-load = <10000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* camera */
> +		pm8994_l3: l3 {
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		pm8994_l4: l4 {
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +
> +		/* L5 is inaccessible from RPM */
> +
> +		pm8994_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		/* L7 is inaccessible from RPM */
> +
> +		pm8994_l8: l8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8994_l9: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		/* touch  */
> +		pm8994_l10: l10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8994_l11: l11 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pm8994_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-system-load = <10000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* sdhc2 vqmmc */
> +		pm8994_l13: l13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-system-load = <22000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* camera */
> +		pm8994_l14: l14 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-system-load = <10000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		pm8994_l15: l15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8994_l16: l16 {
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <2700000>;
> +		};
> +
> +		/* camera */
> +		pm8994_l17: l17 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		pm8994_l18: l18 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		/* LCD */
> +		pm8994_l19: l19 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +		};
> +
> +		/* sdhc1 vmmc */
> +		pm8994_l20: l20 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-system-load = <570000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* sdhc2 vmmc */
> +		pm8994_l21: l21 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-system-load = <800000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* touch */
> +		pm8994_l22: l22 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +		};
> +
> +		/* camera */
> +		pm8994_l23: l23 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		pm8994_l24: l24 {
> +			regulator-min-microvolt = <3075000>;
> +			regulator-max-microvolt = <3150000>;
> +		};
> +
> +		/* IRRC */
> +		pm8994_l25: l25 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm8994_l26: l26 {
> +			regulator-min-microvolt = <987500>;
> +			regulator-max-microvolt = <987500>;
> +		};
> +
> +		/* hdmi */
> +		pm8994_l27: l27 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm8994_l28: l28 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-system-load = <10000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* camera */
> +		pm8994_l29: l29 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		/* camera */
> +		pm8994_l30: l30 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8994_l31: l31 {
> +			regulator-min-microvolt = <1262500>;
> +			regulator-max-microvolt = <1262500>;
> +		};
> +
> +		pm8994_l32: l32 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8994_lvs1: lvs1 {};
> +
> +		pm8994_lvs2: lvs2 {};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,rpm-pmi8994-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_bst_byp-supply = <&vph_pwr>;
> +
> +		pmi8994_s1: s1 {
> +			regulator-min-microvolt = <1025000>;
> +			regulator-max-microvolt = <1025000>;
> +		};
> +
> +		/* S2 & S3 - VDD_GFX */
> +
> +		pmi8994_bby: boost-bypass {
> +			regulator-min-microvolt = <3150000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +	};
> +};
> +
> +&pm8994_resin {
> +	status = "okay";
> +	linux,code = <KEY_VOLUMEDOWN>;
> +};
> +
> +&sdhc1 {
> +	status = "okay";
> +	mmc-hs400-1_8v;
> +	vmmc-supply = <&pm8994_l20>;
> +	vqmmc-supply = <&pm8994_s4>;
> +	non-removable;
> +};
> +
> +&sdhc2 {
> +	status = "okay";
> +	vmmc-supply = <&pm8994_l21>;
> +	vqmmc-supply = <&pm8994_l13>;
> +	cd-gpios = <&pm8994_gpios 8 GPIO_ACTIVE_LOW>;
> +};
> +
> +&tlmm {
> +	hall_sensor_default: hall-sensor-default-state {
> +		pins = "gpio75";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};

