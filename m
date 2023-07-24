Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2A75FC20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGXQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGXQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014110F4;
        Mon, 24 Jul 2023 09:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3707F6127C;
        Mon, 24 Jul 2023 16:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11618C433C8;
        Mon, 24 Jul 2023 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216198;
        bh=kHsqQGwqkfmWjHn8GEpIEHLdAILQRCi33uBk6s7s6xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqB7OoggifxtxjEpotnXcmkx+cNl9EkRrpfUfPvpPBAuszd2b+pfpE0CdQg0i5Ajy
         FGggvYu2mHut3HS1DxfpxAlHHzIU1TOipDRsSMoMI3mmSLVQUMZ18t2d/JJpSwTTiY
         x0T13OVcJOnCII1R7selmVwoYWw4O1/TwGxKTHvpR2YDnsKXS91vI1Mr8jZl4O0Leg
         NDiGqHYxo343zyk4nF54DsLtVh0KcYzBE4YX9bmpSM8K3jJP2HPVTTO6ZJ7qGvwPQ1
         wSqb80jXjO8T+xQU+4vtATYxBUJ0gYr/VlyCphJGBBVonoHBHSSRgeplOARs0fZLtS
         NPRcWNzhVH/ig==
Received: (nullmailer pid 3791217 invoked by uid 1000);
        Mon, 24 Jul 2023 16:29:57 -0000
Date:   Mon, 24 Jul 2023 10:29:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: maxim,max77693: Add USB connector
Message-ID: <169021619665.3791156.3601593811066785076.robh@kernel.org>
References: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 16:28:42 +0200, Krzysztof Kozlowski wrote:
> Add micro-USB connector under "muic" node to properly represent the
> hardware.  Deprecate also the old "max77693-muic" in favor of generic
> "muic" (this is max77693, so there is no need to state it in its child
> nodes).  This "muic" node is used only to instantiate MUIC driver by
> compatible, thus actual Linux driver changes are needed.  Extend the
> example with this new code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Put connector node in the muic node (Henrik).
> 2. Rename max77693-muic -> muic.
> 3. Extend example.
> 
> DTS change using this:
> https://lore.kernel.org/linux-samsung-soc/20230723142417.97734-1-krzysztof.kozlowski@linaro.org/T/#u
> ---
>  .../bindings/mfd/maxim,max77693.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

