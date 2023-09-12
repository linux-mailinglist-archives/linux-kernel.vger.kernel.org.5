Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA679D5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjILQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjILQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:03:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33D1711;
        Tue, 12 Sep 2023 09:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F51C433C8;
        Tue, 12 Sep 2023 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534614;
        bh=jhQZ1CmXtmQWO+Zqfid8byzhjX8dmJ/fY3+CMaBl+js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhNgVPNthdM4cQM2e4oKGXVNinoAs+E8303SoK+GZ7VunwZ2Axsk3oCAxGOrDcxKT
         8Ycjmrel1KVtlgv8HrYzzCBkmLW1yj0fgEHYvLV1TFyrC6TVwS39FsHB6hKyqlfkJp
         105YzRenWiRl8eHK/piM79ojhTh3leSWrBUubJisln9I2Tw462imd/dLY+64gc7ztA
         LE+b9lY6FAi6Vgu9z6A4vjT6FhiuOZlyXt43dWio53Nz0/pQFTAWqLL72SoTPTQLjG
         AkZQuudvhS7omknoGMIgyTfRzEoDmKl4RoNn+9FYhJLk3EEjlIaLslYDcfOz1Nqhff
         96ZvYGPjtR1Vw==
Received: (nullmailer pid 865941 invoked by uid 1000);
        Tue, 12 Sep 2023 16:03:30 -0000
Date:   Tue, 12 Sep 2023 11:03:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and
 resets definitions
Message-ID: <20230912160330.GA864606-robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:51:41AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
> clocks and resets.

This is part of the binding, so it can be squashed with the previous 
patch. The ack there still stands.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  include/dt-bindings/clock/r9a08g045-cpg.h | 243 ++++++++++++++++++++++
>  1 file changed, 243 insertions(+)
>  create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

