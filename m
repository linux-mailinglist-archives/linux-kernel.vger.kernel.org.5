Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60887FDF31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjK2SSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2SSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:18:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E87A3;
        Wed, 29 Nov 2023 10:18:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so7474466b.3;
        Wed, 29 Nov 2023 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701281927; x=1701886727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oxFI2xDlsJXdq2twNcWIhhbiyZKz5nGCnvY004qL9Y=;
        b=jCngQQxbrJ/tnNdZNeiFS6J3A8ITLbAbQ4eAg9O6doogvNeTjSZaTJ7BJytEZGKYkW
         apFyuxWA3uynA0fjVHhVz+jDxLguRoAzsGIaA01QCEkjeXUZtmxmrJhhmWOcC3bJAZzq
         YjyorhBr5Pl5aITlL3N6MW42oGvOi8Y4rBH+eILYT6Lu2wH35G4fWkQZlIYJLTzMdtnI
         C9PEbcqS2UnsuopE35AjXh8LZHDLW5TtCSNldXI4ChQgIaUhteOzTY9/VkSAMatSg/Z0
         vCkfAbk/u8LoRB+m6sJ1XhXMqXTaDo7rZ+9EV2kVHjbjbg+E4u1Lmyv0aVb3lC/G5zZw
         1HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281927; x=1701886727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oxFI2xDlsJXdq2twNcWIhhbiyZKz5nGCnvY004qL9Y=;
        b=N1k849lZyuqYZxrHb3NcqJmS0F77G8mvcw0vt+vMnsOpO1/wQ8e9UUjk0+DKNeVWnS
         CWhL6akRbWwS3DkoKqM+H3xiHfW95tt3Tf7C/pQHPKXxVCRefBYb5maIAHKYlIUuMxMr
         BCxhrCRuNya1sZ/EBaln5mQPUQUG/4T/3Hl25u+jNSrZEJZ5PxdHehyUW5NysOuqRYmR
         6SAtYW+zBsJaJbOLoK198eU+HunBdLAMJeRw7XGMJtjQ9tAgrGQ73K/6jiFIEC7WrrRE
         oeij9OYqm/WZWtPT7c3oURwOL67eSUFBTgktTHYu2Hc3DlunajooscgU018eRNOIQ4f5
         3Kcw==
X-Gm-Message-State: AOJu0YzCPpXqIAUFMp3BVpPNM5m1EJFgTI6fuQ5G4XZqRtCvfPr9u1g+
        XEN0zfIsXCcyFchXCTuEyGY=
X-Google-Smtp-Source: AGHT+IGiIg549aZpIYoA3pve4OmRttOCyYE1U0jSAOSKby4WAR65DFIaa5YMrWhY6o6QqTauDVhqOw==
X-Received: by 2002:a17:906:b248:b0:a04:cc0e:ff3b with SMTP id ce8-20020a170906b24800b00a04cc0eff3bmr14594160ejb.27.1701281926915;
        Wed, 29 Nov 2023 10:18:46 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id u25-20020a17090657d900b0098ec690e6d7sm8119082ejr.73.2023.11.29.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:18:45 -0800 (PST)
Date:   Wed, 29 Nov 2023 20:18:42 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v8 5/9] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231129181842.74zihcd642lx5zgo@skbuf>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-5-50688741691b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-5-50688741691b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:36:00AM +0100, Linus Walleij wrote:
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 9eab2bb22134..66cd98b67744 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -304,7 +304,13 @@ phy1: ethernet-phy@1 {
>  		reg = <1>;
>  	};
>  
> -	/* switch nodes are enabled by U-Boot if modules are present */
> +	/*
> +	 * NOTE: switch nodes are enabled by U-Boot if modules are present
> +	 * DO NOT change this node name (switch0@10) even if it is not following
> +	 * conventions! Deployed U-Boot binaries are explicitly looking for
> +	 * this node in order to augment the device tree!
> +	 * Also do not touch the "ports" or "port@n" nodes. These are also ABI.
> +	 */
>  	switch0@10 {
>  		compatible = "marvell,mv88e6190";
>  		reg = <0x10>;
> @@ -430,6 +436,7 @@ port-sfp@a {
>  		};
>  	};
>  
> +	/* NOTE: this node name is ABI, don't change it! */
>  	switch0@2 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;
> @@ -497,6 +504,7 @@ port@5 {
>  		};
>  	};
>  
> +	/* NOTE: this node name is ABI, don't change it! */
>  	switch1@11 {
>  		compatible = "marvell,mv88e6190";
>  		reg = <0x11>;
> @@ -622,6 +630,7 @@ port-sfp@a {
>  		};
>  	};
>  
> +	/* NOTE: this node name is ABI, don't change it! */
>  	switch1@2 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;
> @@ -689,6 +698,7 @@ port@5 {
>  		};
>  	};
>  
> +	/* NOTE: this node name is ABI, don't change it! */
>  	switch2@12 {
>  		compatible = "marvell,mv88e6190";
>  		reg = <0x12>;
> @@ -805,6 +815,7 @@ port-sfp@a {
>  		};
>  	};
>  
> +	/* NOTE: this node name is ABI, don't change it! */
>  	switch2@2 {
>  		compatible = "marvell,mv88e6085";
>  		reg = <0x2>;

I wouldn't spam the device tree with all these comments; doing so gives
a false sense of completeness. Code inspection shows that the "port-sfp@a"
node name is also established ABI, but there isn't any explicit comment
to point that out. I think a single comment that uses plural to refer to
all nodes should be enough.

Also, doesn't the comment go better along with the patch that changes
the switch compatible strings, rather than with the patch that actually
fixes what can be fixed (ethernet-phy node names)?
