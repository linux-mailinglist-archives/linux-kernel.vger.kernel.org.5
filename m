Return-Path: <linux-kernel+bounces-1188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD463814B76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD31F21460
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F3C3A8DB;
	Fri, 15 Dec 2023 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPhVSq6T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD83C471;
	Fri, 15 Dec 2023 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33646dbedc9so663740f8f.3;
        Fri, 15 Dec 2023 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702653204; x=1703258004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brYOzG3g23wL22CEoDTu8T5IzltVcQQgzthieH5Rn74=;
        b=mPhVSq6TOcznDbqFf/FCmcrpcEXIJC2ewo8P8xGcFXLN3metR8HgNasaBE2chVsufs
         lFDK22DsKDMi1ki0w9TYfUbRKP4180WKRIWISwwxlcRFhNN1Q2nowhMmBJW+mIN2GYJB
         CSvlYlUfNmrM9r7PhP/OjGJsH048+QzwlZZYTKWC7muTGYRRs2TDlswqulA6xrS5BJqw
         MU2IMzDIDED0o5Hcmhd31+t0dBpkpzRWO/u/XTxrd/Wpf6aBPiXzH0CQlJAXhlDM09CC
         E91ZNoN9wu5GtylKERyED1yAnIxQNzgQ+V8YmyWBl0bGVxOJSZbFI1cFu+0BR5XBnLJk
         yvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653204; x=1703258004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brYOzG3g23wL22CEoDTu8T5IzltVcQQgzthieH5Rn74=;
        b=jN0icT0rWxUQdDRGwLcVgRf9NdsR6bfT+Uec6Fwy3dxIo5DaA/JLpGm82qqRfL8yeT
         Gv41s75ZzTHF2dvzhsJExJszXxYZAwFnMtUDTws235ucaWczPzstJqPAWUm8W1yVF+5E
         vh17LaKO+m0dUdj1xg78st6wUToUAb9TPPecwIQCseYMJtazCBV3tqTLIbBntzKBmsv8
         2TuVsQSko241/kwRdFfWPGp6MxmKhrHOWaEcTPt93n3g356s7/P0vrjSQ01vMN+BC8n9
         ZI/kok3n/tQcSzkaIdPdhfMHbcqupT8XshAZH7Trl/DFDa3mDnLwJ8Hu4kTn0oIbgeAh
         1pRA==
X-Gm-Message-State: AOJu0YzdytIoY0/B1DR8XCub6N/s2vy/pXKDeISLZbnBfYROKutcvxUc
	o29OvDJoPL+abjvj84sbD3Q=
X-Google-Smtp-Source: AGHT+IG6xfZAKkoFs/nB1j6orGlhGJ6P+tWaOcp0B83WVeZzCcdiugIKJlUguBz4lJNFDEAwHhhOIg==
X-Received: by 2002:adf:f050:0:b0:336:3538:6636 with SMTP id t16-20020adff050000000b0033635386636mr3854305wro.86.1702653203715;
        Fri, 15 Dec 2023 07:13:23 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.212])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00336421f1818sm6600631wrv.112.2023.12.15.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:13:22 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: viresh.kumar@linaro.org
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	fusibrandon13@gmail.com,
	jernej.skrabec@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	rafael@kernel.org,
	robh+dt@kernel.org,
	samuel@sholland.org,
	tiny.windzz@gmail.com,
	wens@csie.org
Subject: Re: [PATCH 1/5] riscv: dts: allwinner: Update opp table to allow CPU frequency scaling
Date: Fri, 15 Dec 2023 16:12:09 +0100
Message-Id: <20231215151209.46221-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214111446.camz2krqanaieybh@vireshk-i7>
References: <20231214111446.camz2krqanaieybh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 14, 2023 at 12:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> > Two OPPs are currently defined for the D1/D1s; one at 408MHz and
> > another at 1.08GHz. Switching between these can be done with the
> > "sun50i-cpufreq-nvmem" driver. This patch populates the opp table
> > appropriately, with inspiration from
> > https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi
> >
> > The supply voltages are PWM-controlled, but support for that IP
> > is still in the works. So stick to a fixed 0.9V vdd-cpu supply,
> > which seems to be the default on most D1 boards.
> >
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > index 64c3c2e6c..e211fe4c7 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > @@ -39,16 +39,22 @@ cpu0_intc: interrupt-controller {
> >       };
> >
> >       opp_table_cpu: opp-table-cpu {
> > -             compatible = "operating-points-v2";
> > +             compatible = "allwinner,sun20i-d1-operating-points",
>
> I don't think you should add a new compatible for every SoC that needs
> to be supported by a DT bindings and cpufreq driver. Maybe you should
> just reuse "allwinner,sun50i-h6-operating-points" and it will work
> fine for you ?
>
> Rob ?
>
> > +                              "allwinner,sun50i-h6-operating-points";
> > +             nvmem-cells = <&cpu_speed_grade>;
> > +             nvmem-cell-names = "speed";
> > +             opp-shared;
> >
> >               opp-408000000 {
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> >                       opp-hz = /bits/ 64 <408000000>;
> > -                     opp-microvolt = <900000 900000 1100000>;
> > +                     opp-microvolt-speed0 = <900000>;
>
> The separate property name thing was required when you could have
> different values for different SoC instances, which can be read from
> efuses, like in your case.
>
> But all I see is speed0 here, why don't you always set opp-microvolt
> then ?
>

Setting opp-microvolt would be ok, but opp-microvolt-speed0 was chosen for
consistency with the driver bindings here
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml#L52 

> Also why degrade from min/max/target type to just target ?
>

This is a mistake on my part as I thought requesting non default voltages
was going to be a problem with lack of PWM support. Will be reverted in v2.

> >               };
> >
> >               opp-1080000000 {
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> >                       opp-hz = /bits/ 64 <1008000000>;
> > -                     opp-microvolt = <900000 900000 1100000>;
> > +                     opp-microvolt-speed0 = <900000>;
> >               };
> >       };
> >
> > @@ -115,3 +121,8 @@ pmu {
> >                       <0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
> >       };
> >  };
> > +
> > +&sid {
> > +     cpu_speed_grade: cpu-speed-grade@0 {
> > +             reg = <0x00 0x2>;
> > +     };
> > +};
> > --
> > 2.30.2
>
> --
> viresh

Thank you for reviewing.
Brandon.

