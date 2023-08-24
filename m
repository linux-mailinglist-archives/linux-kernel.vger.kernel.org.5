Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F67876E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbjHXRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242885AbjHXRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A36E50;
        Thu, 24 Aug 2023 10:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD9167534;
        Thu, 24 Aug 2023 17:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FE2C433C9;
        Thu, 24 Aug 2023 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692897662;
        bh=9yXrtO8fbh1grXof5RIUb0YcKlKXU12c1Zzn5iHyObE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDrX7Rcp83NB2WpIiiMtrECnSTxd6CBscUgoQpV698UNM9zFlxKqt5L+Gee0AtsRP
         cf+kktoQr/cKwzbURzlGdTayHaj9BRS9J6Tp8+aIwahMWAhx/jyKOevssMOHj0xjhT
         w8z3MvJ6sRsdRx4sp+IeBZZ5RWhzzxMsgUtYc0AC85djfMmZYMkB1/MgLmAdQqQ3OR
         /m7uK4g39wqwWaDWg1XN8132lVjfT5SFNwMZUoSBWCUDLTeK38tsP0Ii9ccpzALpAC
         g/68KfAIloBdSqCddFRrUQpbDQFmWrGrqwcDW+Dd6sx+8SaxVa9WXIYlYhh1bs4593
         kcjuR0yppN02A==
Received: (nullmailer pid 1066930 invoked by uid 1000);
        Thu, 24 Aug 2023 17:21:00 -0000
Date:   Thu, 24 Aug 2023 12:21:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: display: novatek,nt36523: define
 ports
Message-ID: <169289765993.1066873.13186532623781949639.robh@kernel.org>
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
 <20230823081500.84005-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823081500.84005-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 10:15:00 +0200, Krzysztof Kozlowski wrote:
> The panel-common schema does not define what "ports" property is, so
> bring the definition by referencing the panel-common-dual.yaml. Panels
> can be single- or dual-link, depending on the compatible, thus add
> if:then:else: block narrowing ports per variant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Use panel-common-dual.
> 2. Add if:then:else:
> 
> Changes since v1:
> 1. Rework to add ports to device schema, not to panel-common.
> ---
>  .../display/panel/novatek,nt36523.yaml        | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

