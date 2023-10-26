Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF47D8795
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjJZRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:32:10 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF6B9;
        Thu, 26 Oct 2023 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SmHx3jkl1z1Z5WNyZ0jqXx1N6p/MHLa5cPZwrRRH/XA=; b=R+HFFvzodLije/BLIFZLopOoVf
        Rp3kMh5BdeSEJ5iH1IOZnJ5WIaOMhXfwYGYdbuJ9XEDo+AUXwMTG5gLJEqfw7hLXFgo2twpKrd3sZ
        Vyk2uQ7c1ffibVdPcjrodNXTiZC+7Qd9HWwagc/aYcENpFGmrF6BZKP1ydilbu9RyKC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qw4DA-000Goq-FI; Thu, 26 Oct 2023 19:32:00 +0200
Date:   Thu, 26 Oct 2023 19:32:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cyuval@marvell.com
Subject: Re: [PATCH v3 1/3] arm64: dts: cn913x: add device trees for COM
 Express boards
Message-ID: <2f7ab700-cd87-42f2-870d-950a4c75b17d@lunn.ch>
References: <20231026084735.3595944-1-enachman@marvell.com>
 <20231026084735.3595944-2-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026084735.3595944-2-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include "cn9131-db-comexpress.dtsi"
> +
> +/ {
> +	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board";
> +	compatible = "marvell,ac5x_rd_carrier", "marvell,cn9131", "marvell,cn9130",
> +		     "marvell,armada-ap807-quad", "marvell,armada-ap807";

This is really a question to the DT Maintainers. This is a carrier
board for a standardised Com express type 7 board. In theory, you
should be able to plug any Com Express module into it, not just
Marvells. So should the compatible list just have a compatible for the
carrier itself? Not the module which would normally be mounted in it?

Should the carrier have a .dtsi file describing it? And then we have a
.dts file which combines the module .dtsi and the carrier .dtsi?

Sorry i did not ask this earlier, i was thinking more about SolidRuns
systems, which tend to have custom SOMs and customs carriers, so you
can only really mount one particular SOM into one particular
carrier. But that is not true here.

	 Andrew
