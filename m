Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362F178B3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjH1PDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjH1PDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:03:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD620124;
        Mon, 28 Aug 2023 08:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7934564ACF;
        Mon, 28 Aug 2023 15:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EFDC433C7;
        Mon, 28 Aug 2023 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693235008;
        bh=WCke0F5eyHY4DNrnnCkGIBXzM8zbnzJYKIFi10qfwWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PA+ShH6wwtdQBZAZwEQYYytcMJI/HnNIJcp+WdgsYgPU/N79LMpO47/u5OHQxLoQ/
         SiSg+0kz/FkYJOHkjToqPN4/1wCfahxD/nC6t7GgbwD+IbRWESAzJb8LblD30MMq7c
         DhWVlmtJA60DTefKwMCKmJ30IaUX/fXRZiraQMBxVr7brddnLzO1Ff5h81zWcntNkW
         XDx+FLkqRFo9vY9xF6cu+m81EzNfJs7dXDqhMzjRBtOYoOw9/LOjEo1wxaGiEYujnP
         sHt1yq1RSezW3JG6557eaEoaaKxj9hUP12jNZ1PCUcFJPpiZUwocEzN692GCTJSPck
         SAR2NgPohjSWg==
Received: (nullmailer pid 491243 invoked by uid 1000);
        Mon, 28 Aug 2023 15:03:26 -0000
Date:   Mon, 28 Aug 2023 10:03:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: display: panel: add common dual-link
 schema
Message-ID: <169323500594.491192.1035869173529424762.robh@kernel.org>
References: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2023 14:11:40 +0200, Krzysztof Kozlowski wrote:
> Add schema with common properties shared among dual-link panel ICs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v3:
> 1. Re-phrase description of binding and ports (Laurent)
> v3: https://lore.kernel.org/all/20230823081500.84005-1-krzysztof.kozlowski@linaro.org/
> 
> Changes since v2:
> 1. New Patch
> v2: https://lore.kernel.org/all/20230502120036.47165-1-krzysztof.kozlowski@linaro.org/
> v1: https://lore.kernel.org/all/20230416153929.356330-1-krzysztof.kozlowski@linaro.org/
> ---
>  .../display/panel/panel-common-dual.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

