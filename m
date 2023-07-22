Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB74175D9E6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGVFCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGVFCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101B30F2;
        Fri, 21 Jul 2023 22:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2074260A7C;
        Sat, 22 Jul 2023 05:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF427C433C8;
        Sat, 22 Jul 2023 05:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002136;
        bh=HWaSsOVQFBLjr5TPyQhbtTAD6D4au4p6zE6CDcjznMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=armCxyQCBmqikVEixV71SB3LdGhESYkZKJLZ2/ebE8yQic7a+EZsBlV99hhGJaRgx
         J1ZopmUBbm45Ae5L6nT/O297ZN4nPm11zWRkNaThOkbakm/ni8ePbrTVx/8bhZbPlc
         Kvai4MUVQwp6wDVLnt92pxkytfqQdZoLz8pk9PtV5cd7Y+ADu8ghT74D5twuQIXsdI
         CQHYfwFQC8oCBtem/Z0lt4fdgt9dtlqh+BDF6Su3NshgejPvRoCQXbm/i1WoWQtdph
         2ZIE30QJXK0YTBK/SdbsX6HVtTu/qrjmppT7MD5mEEw75P+3eg1gJhhaVzR8IhD0cw
         Xt1T9rxGq5L0g==
Date:   Fri, 21 Jul 2023 22:05:34 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Message-ID: <kqbkmpnvbl5gf6fti4weiiulasdvupvzdkydlpmk3du3ykc6et@kjfduhclrisq>
References: <cover.1689913334.git.quic_varada@quicinc.com>
 <b9d94f32ae01298c3009286670bba47d74ae28d9.1689913334.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d94f32ae01298c3009286670bba47d74ae28d9.1689913334.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:05:29AM +0530, Varadarajan Narayanan wrote:
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db..a22f340 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -405,6 +405,62 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		usbphy0: usb-phy@7b000 {

s/usb-phy/phy/

> +			compatible = "qcom,ipq5332-usb-hsphy";
> +			reg = <0x0007b000 0x12c>;

Sort your nodes under /soc by their address.

> +
> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +			clock-names = "cfg_ahb";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb2: usb2@8a00000 {

usb@... drop the '2' in the node name (not in the label). Although, why
does usb2 use the phy labeled usb0?

Regards,
Bjorn
