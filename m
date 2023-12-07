Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980538094D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjLGVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjLGVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:40:23 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A51727;
        Thu,  7 Dec 2023 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cHb2MmXIvwkbnnHzcw6cJDjztQsevODKkzVNn/O3NHA=; b=vKruNvuTa46KQACj0l4AdOG/mB
        ldZrQ4NjSze1gnS+qVrp675Roal2FKEQUijTvsJNd8ppMPx5bTnjvT/QNGKnMD9fGPVOR7nnAsFzQ
        C7ekhMIW5eyucghEIGxLj4mD45QhGQI24jiWRstGJchHbjFj+K0FdUhb76BFt6tnzTQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rBM6d-002MMJ-Jj; Thu, 07 Dec 2023 22:40:27 +0100
Date:   Thu, 7 Dec 2023 22:40:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, srk@ti.com,
        r-gunasekaran@ti.com
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am642-evm: add overlay for icssg1
 2nd port
Message-ID: <fe6499b3-fbda-4e2d-9b5e-92cc60d3a79c@lunn.ch>
References: <20231207081917.340167-1-danishanwar@ti.com>
 <20231207081917.340167-4-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207081917.340167-4-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	mdio-mux-2 {
> +		compatible = "mdio-mux-multiplexer";
> +		mux-controls = <&mdio_mux>;
> +		mdio-parent-bus = <&icssg1_mdio>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mdio@0 {
> +			reg = <0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			icssg1_phy2: ethernet-phy@3 {
> +				reg = <3>;
> +				tx-internal-delay-ps = <250>;
> +				rx-internal-delay-ps = <2000>;
> +			};
> +		};

That looks odd. A mux generally has > 1 mdio bus. Otherwise its not
really a mux.

And this mux hardware exists all the time right? So it should be in
the .dtsi file.

	Andrew
