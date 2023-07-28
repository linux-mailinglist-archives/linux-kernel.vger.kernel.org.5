Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF837676F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjG1UZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG1UZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:25:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0375421D;
        Fri, 28 Jul 2023 13:25:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so4287056e87.3;
        Fri, 28 Jul 2023 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690575932; x=1691180732;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5zFoHHbl1khNeaZtgyvQfmr2Eml2xUSE31w1MROj8s=;
        b=Mvp+uZ2ubAXR7fJy2rP/rjMADNJ8iWiCFTmuuQLAUa2cvN9t5ZQKVS/Kvjj5FbuH1o
         SkTTPk0FT2yY4AEEZC/R/ouurPlLpT4t/HOq1wUbB+6YMZeIVmPLZvSzpKxD+9K+flOJ
         frJbPrjnz4NZGqIpnaEB6JoNuvD7Upq0U2EM+kErzKEZA5C6Q9TgUv3ttDhDuBCLs01x
         roY2ooPQKOf58tF6n/XA8RqBQnFoF+e1brkbQOD3oCkbSibtAw7uF3jpgiGa20R5gQp5
         VAw3pFMmOtHwl0yl1snJ1oktiNbEFjM9Umo9Fe4J14Bibt083/bxTLsPhvwIEixwsKvb
         sgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575932; x=1691180732;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5zFoHHbl1khNeaZtgyvQfmr2Eml2xUSE31w1MROj8s=;
        b=E/K4M/FMgf+v0oS658jL6mdxJAXDf4lxCcGYjnebLv9XDnYPZHa17TN7rkENSw6xDI
         y4uKAhRWZHlnOzZpNB+VyimogyfSZvHG2kf0G48afH8QEJ2LZS0LcpiUv3tK87U3aqQH
         Mgt/+iw/6R4JGRwUl3YlvlA1rhMpsOER85FiWKnzGdU61VwSjGr/ZUkP2VpbKieoZg9q
         ofcfgE22CcpIr93wGXZlE7BAops3jkmVXXwmXyz4dkMV56TAI7HSuYJeJLHCobUAd/RN
         0T0ltmhjzkaCjnEybFwYL0731tIHvArXXzeomfs3+EIJOgA8VRDzPJKP05Gy3rRXeErq
         sH0w==
X-Gm-Message-State: ABy/qLbOMAOwghtAAdsihtNoX1QEYHFllRr+r4qZmdrFzTTVOrD/rInp
        zJLgavLoPxrzDKKo8fzmpt4=
X-Google-Smtp-Source: APBJJlGT5wQqKEBo7g6Vlgk7jSYvRDN95uB5jwEuNX9pjmCrlHmNhjuVQwfT9dUq+K8snBX+L9df6g==
X-Received: by 2002:ac2:4e8c:0:b0:4fe:993:2218 with SMTP id o12-20020ac24e8c000000b004fe09932218mr2420186lfr.31.1690575931619;
        Fri, 28 Jul 2023 13:25:31 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id x17-20020ac24891000000b004fe1960dd7csm854139lfc.132.2023.07.28.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 13:25:30 -0700 (PDT)
Date:   Fri, 28 Jul 2023 23:25:30 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
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
Message-ID: <ZMQkOpDzyNx7Y44F@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
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
 <7f4a7739-cb03-bda8-df90-e8eb119b732b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f4a7739-cb03-bda8-df90-e8eb119b732b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-27 15:57, Andre Przywara wrote:
> Hi,
> 
> On 24/07/2023 22:34, Andrey Skvortsov wrote:
> > This patch reserves some memory in the DTS and sets up a
> > pstore device tree node to enable pstore support.
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > 
> > Gbp-Pq: Topic pinephone
> > Gbp-Pq: Name 0161-arm64-dts-pinephone-Add-pstore-support-for-PinePhone.patch
> > ---
> >   .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index 87847116ab6d..84f9410b0b70 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -19,6 +19,22 @@ aliases {
> >   		serial0 = &uart0;
> >   	};
> > +	reserved-memory {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		pstore_mem: ramoops@61000000 {
> > +			compatible = "ramoops";
> > +			reg = <0x61000000 0x100000>;
> 
> So what's the significance of this address? That's 528MB into DRAM, so
> somewhat in the middle of it, fragmenting the physical address space.
> And is there any other firmware component that needs to know about this
> address?

Hi, Andre,

there is nothing special about this address.
Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
later in the boot process.
Ramdisk start address is 0x4FF00000, Mobian initramfs for PinePhone
for kernel with some hacking features and debug info enabled can
take more than 100Mb and final address will be around 0x58000000.
So I've picked address that will most likely not overlap with
that. Probably it can be moved below 512Mb. If you have address
suggestion, I'd happy to check it.

-- 
Best regards,
Andrey Skvortsov
