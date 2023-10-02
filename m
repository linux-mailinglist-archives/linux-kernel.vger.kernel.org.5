Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3217B5B38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbjJBTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjJBTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:20:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64976B0;
        Mon,  2 Oct 2023 12:20:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4195fddd6d7so694721cf.0;
        Mon, 02 Oct 2023 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696274401; x=1696879201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds6VTt0w8PY6LpzSqGG11xF1/RVNxL0JohTRt+pMTII=;
        b=Y/S8TP0yFclFtprmwqcasgOyr+2egpR8ch8IvWTyFtFcDOfsFYQ9JCoWABuJG+QQL4
         UZneCKLoFyf0ORS2hIayCCNFjMUdYRj8tGFzb4v1SOv1aj+2RpxN4fMKro/LpeFkMxkG
         GlwNUAdb9gAIPyOENjqvOly/7Sq/+QNrVo0LsZsbZckcar5MKWC9afZqhpdhXdeBDugc
         DrDQ9W9hW/V511LYgHWTB/NdtGHHvgh3O87JakkZtfTVK5OD5jKEt0/zWSspFXQFX0Tw
         zt29YItP1sl6OUCZGqYE9gD7+olDEwTm7LTt7rZOyGdVlHWxlhXnsbd5r3ZhDL9Y6kAi
         FXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274401; x=1696879201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds6VTt0w8PY6LpzSqGG11xF1/RVNxL0JohTRt+pMTII=;
        b=evsoAlUTQtPz+QhtwIXBf8/jq60Q+6EbGCCwo1Uuem5EInUEUIj3UwKHyMVZobagt1
         r16Mts45jaw1rV++QLpMGkqVWWa+dFSsTeNWMwjEHlUeSm7s7WPNkbH3rDOxPm2JC2dl
         s9I2kjH1DV+H6Xne6dUOMuCuvRtZSkd9/ZwUgv/Z4lCeKIyUszm8GlGS8FRjqXbgUovV
         gI75UT9iOUJcV2nuTX2NQslr3Kg4G4bOeZdk0Qf22xyAClimtt4VKqDwmikDLSLIwxFs
         MKkMs09R9qIuTIHJ95C2zSabOmYYIlDom3B9+6iXTUF4K2JNWyZA8+IZigvq8z3QHzLg
         TP/A==
X-Gm-Message-State: AOJu0Yx/wrqIJe8KKmc7kXhbAenpz8XVfNDMVxKc82Q0FKbe+eA3g2WB
        4RTol+RBwjadgwWIDtoGUY8=
X-Google-Smtp-Source: AGHT+IGo6yeaGgco1DFJeiDGQXKNDcXfNT0WDByiIGMzDo4ZxvNVsqXi0hPLiGLZWFxsvV17yl+ifg==
X-Received: by 2002:ac8:588f:0:b0:408:392e:2aa5 with SMTP id t15-20020ac8588f000000b00408392e2aa5mr546193qta.20.1696274401317;
        Mon, 02 Oct 2023 12:20:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b10-20020ac86bca000000b004198ac8be74sm1728335qtt.65.2023.10.02.12.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:20:00 -0700 (PDT)
Message-ID: <5293ccd0-cb88-a196-fa26-aa6fe1e3a52a@gmail.com>
Date:   Mon, 2 Oct 2023 12:19:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 net-next 02/15] phy: introduce the PHY_MODE_ETHTOOL
 mode for phy_set_mode_ext()
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-3-vladimir.oltean@nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230923134904.3627402-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/23 06:48, Vladimir Oltean wrote:
> In networking, we have 2 distinct data types:
> 
> - phy_interface_t describes the link between a MAC (or MAC-side PCS) and
>    an attached PHY or SFP cage
> 
> - enum ethtool_link_mode_bit_indices describes the link between a local
>    PHY and a remote PHY (for example, gigabit RJ45 twisted copper pairs)
> 
> Currently, phy_set_mode_ext(PHY_MODE_ETHERNET) takes arguments of the
> phy_interface_t type, and there is no way to pass an argument of the
> enum ethtool_link_mode_bit_indices type. The new PHY_MODE_ETHTOOL
> intends to address that.
> 
> It is true that there is currently some overlap between these data
> types, namely:
> 
>   phy_interface_t                enum ethtool_link_mode_bit_indices
>   -----------------------------------------------------------------
>   PHY_INTERFACE_MODE_10GKR       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT
>   PHY_INTERFACE_MODE_1000BASEKX  ETHTOOL_LINK_MODE_1000baseKX_Full_BIT
> 
> but those overlaps were deemed to be mistakes, and PHY-to-PHY link modes
> should only be added to ethtool_link_mode_bit_indices going forward.
> Thus, I believe that the distinction is necessary, rather than hacking
> more improper PHY modes. Some of the PHY-to-PHY link modes which may be
> added in the future (to ethtool_link_mode_bit_indices and not to
> phy_interface_t) are:
> 
> 	ETHTOOL_LINK_MODE_100000baseKP4_Full_BIT
> 	ETHTOOL_LINK_MODE_100000baseCR10_Full_BIT
> 	ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT
> 	ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT
> 
> One user of PHY_MODE_ETHTOOL will be the MTIP backplane AN/LT + Lynx
> SerDes PHY combo, where the backplane autoneg protocol (IEEE 802.3
> clause 73) selects the operating PHY-to-PHY link mode.
> 
> There are electrical differences between the PHY-to-PHY backplane link
> modes (like ETHTOOL_LINK_MODE_10000baseKR_Full_BIT) and their
> non-backplane counterparts (like PHY_INTERFACE_MODE_10GBASER), namely
> the number of TX signal equalization taps and their configurability.
> This further justifies distinguishing between them in the generic PHY
> API.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: rename PHY_MODE_ETHERNET_PHY to PHY_MODE_ETHTOOL at Russell's
> suggestion
> 
>   include/linux/phy/phy.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 6be348f1fa0e..72ef4afcda81 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -39,6 +39,7 @@ enum phy_mode {
>   	PHY_MODE_UFS_HS_B,
>   	PHY_MODE_PCIE,
>   	PHY_MODE_ETHERNET,
> +	PHY_MODE_ETHTOOL,

Not feeling very comfortable with using ETHTOOL here because that is a 
Linux sub-subsystem name as opposed to the other enumeration values 
which are electrical modes of operation and/or industry standards names.

How about PHY_MODE_ETHERNET_EXPLICIT or PHY_MODE_ETHERNET_LINKMODE?
-- 
Florian

