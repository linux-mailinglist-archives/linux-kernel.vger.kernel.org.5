Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000A80DAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344666AbjLKTQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344349AbjLKTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:16:23 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A0CF;
        Mon, 11 Dec 2023 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Ex16LPTDyHoEZebn1SZl/KWeMXV5jFFCrSbz7xxNfbE=; b=auGTTiAFc7JI7Fu8KUfhh1DwFS
        EUBfFVkhUpHkaQMCucP81o30rble7GPw4Ec+Hh8ys2ThmuWZYiprX3YSICpzNlXeZv+/H6IjxL2cV
        PwpllUoEDOWN2n3aYPjsaxiIGDkAWA30skgQumB7sKe3yVxufRa77UW9Xu7dXhoC7WaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rCllM-002ec5-QF; Mon, 11 Dec 2023 20:16:20 +0100
Date:   Mon, 11 Dec 2023 20:16:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v8 3/3] arm64: dts: cn913x: add device trees for COM
 Express boards
Message-ID: <9f565a9c-18b1-4e83-905d-27b6585fa800@lunn.ch>
References: <20231211171739.4090179-1-enachman@marvell.com>
 <20231211171739.4090179-4-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211171739.4090179-4-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:17:39PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for CN9130 and CN9131 COM Express Type 7 CPU
> module boards by Marvell.
> Define these COM Express CPU modules as dtsi and
> provide a dtsi file for a carrier board (Marvell AC5X RD
> COM Express type 7 carrier board).
> This Carrier board only utilizes the PCIe link, hence no
> special device / driver support is provided by this dtsi file.
> Finally, provide a dts file for the com express carrier and
> CPU module combination.
> 
> These COM Express boards differ from the existing CN913x DB
> boards by the type of ethernet connection (RGMII),
> the type of voltage regulators (not i2c expander based)
> and the USB phy (not UTMI based).
> Note - PHY + RGMII connector is OOB on CPU module.
> CN9131 COM Express board is basically CN9130 COM Express board
> with an additional CP115 I/O co-processor, which in this case
> provides an additional USB host controller on the board.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
