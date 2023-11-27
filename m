Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93607FAD7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjK0Wdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjK0Wdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:33:47 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7091AE;
        Mon, 27 Nov 2023 14:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=e7IBp0fCNpY+ZxyoiT0Ekzpy0IonkonmrhfGovOCcGI=; b=1Cm5tU0JAila50h6EVz3Qv5+L0
        io6AzaVO/s2anZnQMzVN4r8Z3G1rtz2633dhZ4QFSKbvggQt/34BJTs8NQkqJItShVdHs9GwQm1gL
        OfnlwtjpDatcnDpRh0yPX5QioA/8+Kp/niXox3wTveoBXekUxrCw5aoopl/6UJsq+vOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7kAg-001OOS-KQ; Mon, 27 Nov 2023 23:33:42 +0100
Date:   Mon, 27 Nov 2023 23:33:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v6 3/3] arm64: dts: cn913x: add device trees for COM
 Express boards
Message-ID: <35f98bc2-dc26-4441-8ed3-1ecce582d0d2@lunn.ch>
References: <20231127190857.1977974-1-enachman@marvell.com>
 <20231127190857.1977974-4-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127190857.1977974-4-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 Marvell International Ltd.
> + *
> + * Device tree for the AC5X RD Type 7 Com Express carrier board,
> + * Utilizing the CN913x COM Express CPU module board.
> + * This specific board only maintains a PCIe link with the CPU CPU module
> + * module, which does not require any special DTS definitions.
> + */
> +
> +#include "cn9131-db-comexpress.dtsi"
> +#include "ac5x-rd-carrier.dtsi"
> +
> +/ {
> +	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board with CN9131 CPU module";
> +	compatible = "marvell,cn9131-ac5x-carrier", "marvell,rd-ac5x-carrier",
> +			"marvell,cn9131-cpu-module", "marvell,cn9131",
> +			"marvell,armada-ap807-quad", "marvell,armada-ap807";

> diff --git a/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
> new file mode 100644
> index 000000000000..fd45d5582233

> +/ {
> +	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board";
> +	compatible = "marvell,rd-ac5x-carrier";

Now i'm confused. What does rd mean?

I would expect RD mean Reference Design, and that is the complete
device in its box.

Yet, here you have RD for the carrier?

The box itself is called cn9131-ac5x-carrier?

This makes no sense to me.

Maybe i'm understanding this all wrong, and its the carrier which you
are producing a reference design for? The CPU module does not really
matter? I could use any off the shelf ComExpress 7 SOM. The bits you
are trying to sell are on the carrier? But since you are Marvell, you
don't want to recommend using an AMD ComExpress board when you happen
to also have CPU module which would work? But the CPU is not really
the point of this, its the carrier?

	Andrew
