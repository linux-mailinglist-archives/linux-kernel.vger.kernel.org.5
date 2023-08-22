Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE73783CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjHVJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbjHVJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:26:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32F1A5;
        Tue, 22 Aug 2023 02:26:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so6594143e87.0;
        Tue, 22 Aug 2023 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692696375; x=1693301175;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snw1DaEvTLglNmKWe5Qce4LHWKg43CbSW3JkoNbMXJ0=;
        b=XiXIuii02P5pSjXkR+wQ0pKRVSpsQstyOfKddLRnfUJb5HzDpWU0T9Lx/jHH+Qxkt2
         oiBKZt4zdbBdH+qfbeMtvOpLZrTexyrebSfx57iVe94e9r2on2aP8OuwY21/rERQzQno
         TzpqAik5K1Nkx0eiAxq8pkt9a+5Phv5o60UybgQz4bL3+dyFTpqTnXx9drjaCnvoKyVq
         uNvwWoiJk5Msoi0M+Jz2pdqNV1vO3M3UUmn+SpKoCnh3v3vrtr3AoA/yi451f0c9Cxhl
         RenI6d7gS3jTyvilxhrFMvR3iKeHkqZbyrA4VfcKENMamsXDepNeQh/cy+avNyR2gUJR
         8Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696375; x=1693301175;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snw1DaEvTLglNmKWe5Qce4LHWKg43CbSW3JkoNbMXJ0=;
        b=Ol1/qY8FjMnPJ/sUo6UQQhVz73zK6Jm+Xuit+rZ9ZVOtNLq0Ik1QMZagwMci8NWoUm
         d0ZZgPuAlSwZl+XfL1/aAuumrni8OJIizV+UewcqEgY4nr93wBIbWTVmKEgA6fXCedPL
         Arm39CQQYKWyy/MbJSzWByfcDOh2PlffDJhfCBFfLGNodPwFG5K2xC1JJUhe0bzJPuyn
         mGopHGoZuluT7vLDrAJARYCyJr0BI/PJ/QCquTRElREk3uAohhixLvLJIQATs5mHkf4d
         EkHTZX1mO13qUcMQCW2L4Zeat93+HHJV9V4U6Y0kiA6R+eBfkoQ16vUgib53kz/IrX2P
         9y2A==
X-Gm-Message-State: AOJu0Yw1Yq/Eyffaa6MwEU0JG8KqxgVy3zJ1OclrKfBpHDwouXTFInQ+
        L/nAZQeI4CBDKevUWDwE0dc=
X-Google-Smtp-Source: AGHT+IH0eg8a5KtlFVvbBYLuL38D3pN+Vqfg1Lgf5Kl+i/B3hhTqgj1n3Ui4j6vOyIxo6gIttJrKVg==
X-Received: by 2002:ac2:5f0a:0:b0:4fa:ad2d:6c58 with SMTP id 10-20020ac25f0a000000b004faad2d6c58mr5033971lfq.61.1692696374699;
        Tue, 22 Aug 2023 02:26:14 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id l14-20020ac24a8e000000b004ff8a466ed3sm2102918lfp.130.2023.08.22.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:26:14 -0700 (PDT)
Date:   Tue, 22 Aug 2023 12:26:13 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] arm64: dts: pinephone: Add pstore support for PinePhone
 A64
Message-ID: <ZOR/NUuaEOpYMzVJ@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20230724213457.24593-1-andrej.skvortzov@gmail.com>
 <20230821160817.GA2227@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821160817.GA2227@bug>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 23-08-21 18:08, Pavel Machek wrote:
> Hi!
> 
> > This patch reserves some memory in the DTS and sets up a
> > pstore device tree node to enable pstore support.
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > 
> > Gbp-Pq: Topic pinephone
> > Gbp-Pq: Name 0161-arm64-dts-pinephone-Add-pstore-support-for-PinePhone.patch
> > ---
> >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index 87847116ab6d..84f9410b0b70 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -19,6 +19,22 @@ aliases {
> >  		serial0 = &uart0;
> >  	};
> >  
> > +	reserved-memory {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		pstore_mem: ramoops@61000000 {
> > +			compatible = "ramoops";
> > +			reg = <0x61000000 0x100000>;
> > +			record-size = <0x20000>;
> > +			console-size = <0x20000>;
> > +			ftrace-size = <0x20000>;
> > +			pmsg-size = <0x20000>;
> > +			ecc-size = <16>;
> > +		};
> > +	};
> 
> dts is supposed to be for hardware description, but this is really policy decision.
> 
> Should we have something like "any dram is suitable for pstore"....?
Thanks for the review. I'll add into commit message more details why
this address was picked.

-- 
Best regards,
Andrey Skvortsov
