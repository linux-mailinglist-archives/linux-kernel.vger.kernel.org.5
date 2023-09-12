Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7A79D5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjILQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjILQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:02:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120221704;
        Tue, 12 Sep 2023 09:02:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED07C433C7;
        Tue, 12 Sep 2023 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534548;
        bh=9M8FAOyXY6Aot0630XJdXidY28/lh6QhrDiuvkNZzUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTRmRxun5LSp7iD3J1UyiqTLEzKIXAjpktZfJY1IV7t/Nqkr7KUnG+FcGp7/J8h5I
         W9kNGIpicuXD9+Mp1EzuTLhBo3wb+bfOGjzzPshR7jbqsRMZrsHGupcXimUgFipkcX
         slpZknB/KUJ8fE1QzY4GwpX3Xg7P5UfNWgG3OEQWhij5CfDumDPvtllKyFKDOly3Ys
         IY1UBaOXU+Yg50OnuI8qP5mTV1HMi+dgmqmkLRG4Cto1zSzERyNsc+OC4OA33cOTYL
         tv8QJBADr2Hd4xH2+FVOTb/r+dUSucvWgYcpkYKAbfu+HJ9+C8AJr6YwtJnUWtSsG5
         iGr3G1/U1aqKQ==
Received: (nullmailer pid 864509 invoked by uid 1000);
        Tue, 12 Sep 2023 16:02:23 -0000
Date:   Tue, 12 Sep 2023 11:02:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     ulf.hansson@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org,
        robh+dt@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        nfraprado@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, neil.armstrong@linaro.org,
        rafal@milecki.pl, linux-arm-kernel@lists.infradead.org,
        conor+dt@kernel.org, mturquette@baylibre.com,
        biju.das.jz@bp.renesas.com, linux-serial@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        magnus.damm@gmail.com, sboyd@kernel.org, quic_bjorande@quicinc.com,
        catalin.marinas@arm.com, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        will@kernel.org, geert+renesas@glider.be, jirislaby@kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 20/37] dt-bindings: clock: renesas,rzg2l-cpg: document
 RZ/G3S SoC
Message-ID: <169453454306.864438.17337946061239259164.robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-21-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-21-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 07:51:40 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add documentation for RZ/G3S CPG. RZ/G3S CPG module is almost identical
> with the one available in RZ/G2{L, UL} the exception being some core
> clocks as follows:
> - SD clock is composed by a mux and a divider and the divider
>   has some limitation (div = 1 cannot be set if mux rate is 800MHz).
> - there are 3 SD clocks
> - OCTA and TSU clocks are specific to RZ/G3S
> - PLL1/4/6 are specific to RZ/G3S with its own computation formula
> Even with this RZ/G3S could use the same bindings as RZ/G2L.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

