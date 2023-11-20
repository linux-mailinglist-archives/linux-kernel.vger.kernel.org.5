Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFA7F1DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjKTUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTUP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:15:27 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DFC8;
        Mon, 20 Nov 2023 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JznYf3WwK2ea80O29WWc1jrp4vT2fXc+cuKeytbFeKE=; b=XOJgjdCCfmr8LYhyR6y2QLGjiI
        jNSPz3w8oBz7kr7v3PA2TyUDWtVP7sM2dHQglVtug6mHRl9a2QqP4QmALdE4IzXAPSQaeZ7EyXq9K
        dMLQEVqh9lMtTu6HwSRbbwVoE80GjYy8Xafcxep2ngc6pjehMOXe27wov2DrCj1miVaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5Afg-000gaj-G4; Mon, 20 Nov 2023 21:15:04 +0100
Date:   Mon, 20 Nov 2023 21:15:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Message-ID: <14c3900f-8f2e-4614-8317-f85763d1d953@lunn.ch>
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Naming and Valid Characters
> +---------------------------
> +
> +1. Node and property names are allowed to use only:
> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * dash: -
> +
> +2. Labels are allowed to use only:
> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * underscore: _
> +
> +3. Unit addresses should use lowercase hex, without leading zeros (padding).
> +
> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
> +   part can be padded with leading zeros.
> +
> +Example::
> +
> +	gpi_dma2: dma-controller@800000 {
> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
> +		reg = <0x0 0x00800000 0x0 0x60000>;
> +	}

Hi Krzysztof

What i like about the Linux Coding Style is that most sections have a
Rationale. I like the way it explains the 'Why?'. It makes it feel
less arbitrary. When it does not seem arbitrary, but reasoned, i find
it easier to follow.

Could you add rationale like the Coding Style?

      Andrew
