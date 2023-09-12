Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28179D606
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjILQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjILQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:16:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD0710D;
        Tue, 12 Sep 2023 09:16:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331ADC433C8;
        Tue, 12 Sep 2023 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535403;
        bh=XJ20fqCAIZFahLPeIZzANxdPqeX/EQDnZkmAGUFSzJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqD799N31jhUtf4RlgwSUSgaJfAh0b85tmPL8IrsDeApARDCRkUarrIFZMW7E/1Hh
         XwNy07oZkRIdLZ+IZDd4/lcmprbo5QxYEd5KXIulc+PICxnRszzsUEftxrcB0zyD9l
         91eKppD9G3K/102Xo6LKPhW3hWZsGc9F9Kx9AqNBReAdT0jsP2NWt4+q+90XCSUCi1
         fR0NSFKX+B6NcB1LoOZ3N0s8CncVncouO1E1QAVt6Xyj9pEjIU6YAXebjZdqk+o7DS
         BtdnSRUVOOokJzgrUNVpIdwSkkMxWCSOtNyDRwvHY8BOKkN+6H0bMmGoBc6tT7jwOb
         YR8fuPSgubNtg==
Received: (nullmailer pid 879975 invoked by uid 1000);
        Tue, 12 Sep 2023 16:16:35 -0000
Date:   Tue, 12 Sep 2023 11:16:35 -0500
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
Subject: Re: [PATCH 35/37] dt-bindings: arm: renesas: document SMARC
 Carrier-II EVK
Message-ID: <20230912161635.GA877089-robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-36-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-36-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:51:55AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Document Renesas SMARC Carrier-II EVK board which is based on RZ/G3S
> (R9A08G045) SoC. The SMARC Carrier-II EVK consists of RZ/G3S SoM module and
> SMARC Carrier-II carrier board, the SoM module sits on top of carrier
> board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index 822faf081e84..f4964445e5ab 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -476,6 +476,8 @@ properties:
>  
>        - description: RZ/G3S (R9A08G045)
>          items:
> +          - enum:
> +              - renesas,smarc2-evk # SMARC Carrier-II EVK

You just changed the existing binding...

>            - enum:
>                - renesas,r9a08g045s33 # PCIe support

This is the SoM module? You either need to squash this change or add 
another case with 3 entries and maintain the 2 entry case. (there's no 
way to express any entry at the beginning or middle can be optional)

>            - const: renesas,r9a08g045
> -- 
> 2.39.2
> 
