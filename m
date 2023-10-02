Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD17B55EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjJBOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjJBOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:51:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888E694;
        Mon,  2 Oct 2023 07:50:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D86C433C7;
        Mon,  2 Oct 2023 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696258257;
        bh=oCle2xQolRrS//2ZNzGCyX4K5r5ldYzVf098n5iryoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSNx8wAfhzbmf/rAkSYfSy/g8xcgWARkygitgnHKqBk9ZlLNmvkU9oOQwDMnuuISM
         joWE7C6FpMYCmGV6g7WRft+g9fryeTXIaadTKb9XNcYOBz8Vvhpou3M1uVOz2oCr/o
         TQaWKZnmG1YX9g7lEJlB4YOCrOsr33MWRnoPjXxrwTJYf1tw1QS0lGGDlOELUrkNE5
         DSABcVScP8VSVSNlfcsyERWsPEzFHkBac/COj4Dqxpc4WQRsOds9YUhUXuabBvoyWL
         s6uG4f+ojpQx94Z/EAO06S/3U/I4rSC5ub7qsn9JXnt5CBm1ZdbFPTj17CyHX1626Q
         oZdyS6Op+gcIQ==
Received: (nullmailer pid 1694626 invoked by uid 1000);
        Mon, 02 Oct 2023 14:50:52 -0000
Date:   Mon, 2 Oct 2023 09:50:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/28] dt-bindings: pinctrl: renesas: set
 additionalProperties: false
Message-ID: <20231002145052.GA1690001-robh@kernel.org>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-20-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929053915.1530607-20-claudiu.beznea@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 08:39:06AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Set additionalProperties: false.
> 
> Suggested-by: Rob Herring <robh@kernel.org>

I did?

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - this patch is new in v2 and added as suggested by Rob
> 
>  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml     | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index 4782f96feb7e..eb726770f571 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -106,8 +106,7 @@ additionalProperties:
>          line-name: true
>  
>      - type: object
> -      additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +      additionalProperties: false

With no properties defined, this only allows an empty node which is 
probably not what you want. It's the other anyOf entry that needed it, 
but I already sent a fix which Linus applied.

Rob
