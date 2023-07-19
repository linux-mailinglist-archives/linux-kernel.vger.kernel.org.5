Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5075A216
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGSWkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGSWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2047CB3;
        Wed, 19 Jul 2023 15:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A033461867;
        Wed, 19 Jul 2023 22:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD7DC433C8;
        Wed, 19 Jul 2023 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689806416;
        bh=8UkSiNiVeE9+fz85NbdSbU/eHOWoE2ija6HcvmQcNtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMRIuOmH74tUoEaDWhDjbvBmRBEnTKZDDblR4iDpUHmDPSQHKpZDz2nOFlzicbAhn
         jjlVqftFzcExqQo4sbs59MqC97T/kpXf3/sRYGx8KJbbyO3v8u/WSfA9+k/4+03hmd
         B5BiQlTzxHmNuETowZRx92kNf1Gl+37CraoWN0jlcGlXdyizXqqBUmfhZosFkx2iK8
         VQj910usiJGJGFvyXOSPZVPgbUJGk1hfMmkjrOqLf/1Lh/6BwyCuvfYtSd/DAguny3
         PsM77X/vExgeiu2qBsUMRlzbiwGCYCQ/7zY/N+i10ldze+643KsVYl10EKxEn+1yjd
         TxhS2QN4jvKMg==
Received: (nullmailer pid 900473 invoked by uid 1000);
        Wed, 19 Jul 2023 22:40:14 -0000
Date:   Wed, 19 Jul 2023 16:40:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, CTLIN0@nuvoton.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: nau8822: Add #sound-dai-cells
Message-ID: <168980641364.900412.9978374566695268236.robh@kernel.org>
References: <20230719124752.248898-1-francesco@dolcini.it>
 <20230719124752.248898-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719124752.248898-2-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 14:47:51 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add #sound-dai-cells property and reference dai-common.yaml schema, this
> is required since NAU8822 can be used as a platform DAI link.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8822.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

