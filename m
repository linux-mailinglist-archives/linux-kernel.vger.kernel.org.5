Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92E7DAD9A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjJ2SDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2SDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:03:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55276B7;
        Sun, 29 Oct 2023 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=WyDNXOkQ4R+FvTl5P+Eq1SiMepb+oupfbJGud2IUED4=; b=Q5m6uCVi075sVN2SCbsJtwX5nN
        cGor5wsIsx0f13NqxPbKKLVXdZet1PBCDEnhDZ4WGiw7HGrQC8YUrsOXz8hK1/Vy4287zFU2KXBi7
        CVFu+QoxVBYxBULWCgKYpwiyMwSW7Kl/bf3J7O/+smu/b9BRMhhiXI9lgjSJpz1uokVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxA8A-000SKf-Rg; Sun, 29 Oct 2023 19:03:22 +0100
Date:   Sun, 29 Oct 2023 19:03:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v4 3/3] arm64: dts: cn913x: add device trees for COM
 Express boards
Message-ID: <0c732f04-d1ce-4662-bc99-226784f9fb10@lunn.ch>
References: <20231029174814.559583-1-enachman@marvell.com>
 <20231029174814.559583-4-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029174814.559583-4-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2023 Marvell International Ltd.
> + *
> + * Device tree for the AC5X RD Type 7 Com Express carrier board,
> + * This specific board only maintains a PCIe link with the CPU CPU module
> + * module, which does not require any special DTS definitions.
> + */
> +
> +/ {
> +	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board";
> +	compatible = "marvell,rd-ac5x-carrier", "marvell,cn9131", "marvell,cn9130",
> +		     "marvell,armada-ap807-quad", "marvell,armada-ap807";

This sees wrong to me. Say i mount a congatec Module in it. Its then
is not compatible with marvell,cn9131 etc. I think you should just
list the carrier compatible here.

> +#include "cn9130-db.dtsi"
> +
> +/ {
> +	model = "Marvell Armada CN9130-DB COM EXPRESS type 7 CPU module board";
> +	compatible = "marvell,cn9130-cpu-module", "marvell,cn9130",
> +		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x2 0x00000000>;

Is the memory soldered down, or socketed?

	Andrew
