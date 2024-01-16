Return-Path: <linux-kernel+bounces-27385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1382EF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538061F24496
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD31BC36;
	Tue, 16 Jan 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nDmo+7CC"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607B1BC2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-559bd483877so307822a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1705408649; x=1706013449; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4mR1emV7e4VKpQPCJz2Hf3qZyAbmUfMxUA9APfw/1A=;
        b=nDmo+7CCW7wTWjA4SG685v+agP9O90TA4sZDtBINVaAnPQ78CHyq6RetuEJlek1HM1
         6wxRtLg+MwXgZjPSNkm8a7/NoW1WT4FSNVajlM9Vz3uhcvIBbhGK8S63b7XkbeMtZWuI
         8Ig1OpYsZUJis6T71iiveTt3GoBwxMM7K2C0AwnY8O+S8UeYt309MbrdOMiT4WVeGxVB
         UkLPdjp8gSlhajm46wZTuPLe09nrp8E9rlFuEm/wZkpnlJ0zK3p85bcyTAs87LobQj2J
         nMCzngu+H+/t679oABVM/aC1NfuWsiNcdpEUJnN3pDRpPhVEc2O7ayUbba0On29a5gpe
         6NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705408649; x=1706013449;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4mR1emV7e4VKpQPCJz2Hf3qZyAbmUfMxUA9APfw/1A=;
        b=Ci30JcyOG2V9/N9Ve3p/qsLw7PWjSPqfzRxF+aZGRhwHo/PF9ugGRTvWNyirf1V40g
         H7cwjFMCNSdNCpgRZhotnkvY/m8Tc+umlibslucNEuuLBN953hnCZNzEzO0GNsALv11n
         RSANOPG/O30aQNjSf7IzrAN2uxUgMYlSWjpQdohqot8yHmqCc7ppjN+veGrsU1Cx8hMK
         ZP2PaLo1Wl4/qbn6pO5q/+XLLD91Cqy0M4pttinaxEmV6JyS+okK+SD9or4gzO0zBPHW
         6+h5dD3tJcidcgg/xVtk/821HgGN168mE8GzlRKLs30LpbVu/pkq8NzNL/Bfs7lalwtq
         jqZw==
X-Gm-Message-State: AOJu0YzAqQXJsLfJQZ1/Ytl9utJHEIH82yGG0UOECMSI6Etxved/a3+m
	BoHE6srwNhUzEctnWRUZ/hn2V//orIWoLQ==
X-Google-Smtp-Source: AGHT+IE8AuAnz/Y2vI48q1u6S5mFnUhMe9qfL9/aQfgOSuL4n2n1Q6uw/zPO4/FVy4CdLg0KBvQG1Q==
X-Received: by 2002:a05:6402:8d3:b0:559:45ac:6750 with SMTP id d19-20020a05640208d300b0055945ac6750mr1876000edz.23.1705408649241;
        Tue, 16 Jan 2024 04:37:29 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm284504edb.6.2024.01.16.04.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jan 2024 13:37:28 +0100
Message-Id: <CYG4WTCOBTG2.11PA7Q4A3H93H@fairphone.com>
Cc: "Amit Pundir" <amit.pundir@linaro.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "open list:ARM/QUALCOMM SUPPORT"
 <linux-arm-msm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Fix wild reboot during Antutu
 test
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Daniel Lezcano" <daniel.lezcano@linaro.org>, <andersson@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240116115921.804185-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240116115921.804185-1-daniel.lezcano@linaro.org>

On Tue Jan 16, 2024 at 12:59 PM CET, Daniel Lezcano wrote:
> Running an Antutu benchmark makes the board to do a hard reboot.
>
> Cause: it appears the gpu-bottom and gpu-top temperature sensors are show=
ing
> too high temperatures, above 115=C2=B0C.
>
> Out of tree configuratons show the gpu thermal zone is configured to
> be mitigated at 85=C2=B0C with devfreq.
>
> Add the DT snippet to enable the thermal mitigation on the sdm845
> based board.
>
> Fixes: c79800103eb18 ("arm64: dts: sdm845: Add gpu and gmu device nodes")
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

A part of this is already included with this patch:
https://lore.kernel.org/linux-arm-msm/20240102-topic-gpu_cooling-v1-4-fda30=
c57e353@linaro.org/

Maybe rebase on top of that one and add the 85degC trip point or
something?

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 32 ++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index c2244824355a..20fefd6af0f8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4764,6 +4764,8 @@ gpu: gpu@5000000 {
>  			interconnects =3D <&mem_noc MASTER_GFX3D 0 &mem_noc SLAVE_EBI1 0>;
>  			interconnect-names =3D "gfx-mem";
> =20
> +			#cooling-cells =3D <2>;
> +
>  			status =3D "disabled";
> =20
>  			gpu_opp_table: opp-table {
> @@ -5603,12 +5605,25 @@ gpu-top-thermal {
>  			thermal-sensors =3D <&tsens0 11>;
> =20
>  			trips {
> -				gpu1_alert0: trip-point0 {
> +                                gpu1_alert0: trip-point0 {
> +                                        temperature =3D <85000>;
> +                                        hysteresis =3D <2000>;
> +                                        type =3D "passive";
> +                                };
> +

The indentation here should use tabs not spaces.

> +				gpu1_alert1: trip-point1 {
>  					temperature =3D <90000>;
>  					hysteresis =3D <2000>;
>  					type =3D "hot";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&gpu1_alert0>;
> +					cooling-device =3D <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
> =20
>  		gpu-bottom-thermal {
> @@ -5618,12 +5633,25 @@ gpu-bottom-thermal {
>  			thermal-sensors =3D <&tsens0 12>;
> =20
>  			trips {
> -				gpu2_alert0: trip-point0 {
> +                                gpu2_alert0: trip-point0 {
> +                                        temperature =3D <85000>;
> +                                        hysteresis =3D <2000>;
> +                                        type =3D "passive";
> +                                };
> +
> +				gpu2_alert1: trip-point1 {
>  					temperature =3D <90000>;
>  					hysteresis =3D <2000>;
>  					type =3D "hot";
>  				};
>  			};
> +
> +			cooling-maps {
> + 				map0 {
> + 					trip =3D <&gpu2_alert0>;
> +					cooling-device =3D <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                                };
> +                        };
>  		};
> =20
>  		aoss1-thermal {


