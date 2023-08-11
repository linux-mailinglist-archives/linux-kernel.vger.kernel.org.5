Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB96779794
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjHKTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961AC2709;
        Fri, 11 Aug 2023 12:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297B1665D8;
        Fri, 11 Aug 2023 19:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96157C433C7;
        Fri, 11 Aug 2023 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691781158;
        bh=jVzy3ed5zrK+W0/TGI4rspWx8gcOBVlaPTtRjlEuPAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDbN7N4OKVJrt6ST0CDhlPncPZnZVq/afcmTZkC6fO4bxbZwpFP2ZTcNa//l5AKwI
         a7FRNyb9axYwj2zLAvickZPG0pcaHKnBKY8LOBb1doUeRa/kPSHdrIG/CGDEuIAGZs
         4zyPG6ynAMDSqVbwDUNEhL7+wD9U32aa5HNNBdXq6aSSCvnxAUi/zbBxM2Qgo7/pPO
         KiGTEzD2/y1Zw5oGNhTyByRe/fp0pDH+HH2SnAudAfgfh5uwV3iRqI5gsLyliXTFkc
         w5cC4ae3Wpe9tDpqynVfRQ4v3oYXZ4ndMWR/pZ/Xf/BKz2eDds1excCmpSZY+QD21N
         vwg5p5bJ6DKbQ==
Received: (nullmailer pid 3960943 invoked by uid 1000);
        Fri, 11 Aug 2023 19:12:36 -0000
Date:   Fri, 11 Aug 2023 13:12:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, spujar@nvidia.com,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        daniel.baluta@gmail.com
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: simple-card: Document new DAI
 flags playback-only/capture-only
Message-ID: <20230811191236.GA3937407-robh@kernel.org>
References: <20230801082433.548206-1-daniel.baluta@oss.nxp.com>
 <20230801082433.548206-3-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801082433.548206-3-daniel.baluta@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:24:33AM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Document new playback-only and capture-only flags which can be used when
> dai link can only support just one direction: playback or capture but
> not both.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index 59ac2d1d1ccf..1bf331f095a4 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -27,6 +27,14 @@ definitions:
>      description: dai-link uses bit clock inversion
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  playback-only:
> +    description: dai-link is used only for playback
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  capture-only:
> +    description: dai-link is used only for capture
> +    $ref: /schemas/types.yaml#/definitions/flag

Wouldn't this be implicit based on limitations in the either the cpu or 
codec DAI?

Rob
