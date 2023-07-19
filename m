Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112EF75A214
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGSWjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA411FE1;
        Wed, 19 Jul 2023 15:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8546661867;
        Wed, 19 Jul 2023 22:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1346AC433C8;
        Wed, 19 Jul 2023 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689806390;
        bh=7D7RzRHaJGxKAepbVKlDzJZQhozzOzlVH3Up8dTxW/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNJIjpang2qGoODuNSTGtHART5RZ5YCQpI6rZrVH95dMPqQDAlXivNJ9SP4mV5INb
         yifBacyI/4VjOOBda5zOlJCy+lcS55oq1KhYdpbjLdtwrN8IciuD7G6HCqaEVVsOpf
         YBM+dHOvRl5uQPEQWaMzQwclVYJdLZ9SvHNMNQXN+9dPiDuB2+hX+v7aXTXk8gcGHz
         LXQxFvnAFlr+Sj506GtAvuSbozCblWCfNnIHB2+FstBJxADx8cO5iYc/fL50hdTgo8
         Sf/YDljGqFM5DpfzZZgv4151cjjCrdrR51eHo5sp5nfk1jHeX0dLt/HoiCTUrI7Zfl
         C0v7D3JTEbDaA==
Received: (nullmailer pid 899913 invoked by uid 1000);
        Wed, 19 Jul 2023 22:39:49 -0000
Date:   Wed, 19 Jul 2023 16:39:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ASoC: dt-bindings: wm8904: Convert to dtschema
Message-ID: <168980638831.899860.9131467971421415167.robh@kernel.org>
References: <20230719121918.247397-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719121918.247397-1-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 14:19:18 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Convert the WM8904 audio CODEC bindings to DT schema.
> 
> Compared to the original binding #sound-dai-cells and the missing power
> supplies are added. The latter are all required as described in the
> datasheet.
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 74 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8904.txt      | 33 ---------
>  2 files changed, 74 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

