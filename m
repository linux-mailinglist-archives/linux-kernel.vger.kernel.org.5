Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935E2754666
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGOCrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGOCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9735AC;
        Fri, 14 Jul 2023 19:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D05F361E26;
        Sat, 15 Jul 2023 02:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EEFC433C7;
        Sat, 15 Jul 2023 02:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689389249;
        bh=u85/vf6ROEFLRTj+zJXTL4S/kz2IqkicsRjV13SwxbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WeNH8yJolg21n1tVQQVHUeBZAnvLt6lrhqi08lI7fnAAQSpaWSlFUJQif62xNnTPj
         rrsDErxyeXnYu73dOKHYseuMrj8N9hG1qyJTIBsBvlX2/Im8veciZfCPtMLW4dALYI
         CAV1v1GrGepq0lVv87YbScJrHJrUesjWgTXaq8M7UkPSwXJ9TWu0HkVDz8EyTWNkBS
         0s7xU3JIn/rO+Qy5ARWQq8bYv8Bv5qwj0FvFnlrw3fAmblw9eAnkB5MISm2wOdylED
         7G7V484ng2piTFbUhovkSFl4wjOKHbjIL90Q40UCUFPW2SHaBzVIcDNlsXv67oilAC
         9XJRavlfgd6qw==
Received: (nullmailer pid 876115 invoked by uid 1000);
        Sat, 15 Jul 2023 02:47:27 -0000
Date:   Fri, 14 Jul 2023 20:47:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     neil.armstrong@linaro.org, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, brgl@bgdev.pl, andy@kernel.org,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 1/2] dt-bindings: pinctrl: Add compatibles for Amlogic
 C3 SoCs
Message-ID: <20230715024727.GC872287-robh@kernel.org>
References: <20230714122441.3098337-1-huqiang.qin@amlogic.com>
 <20230714122441.3098337-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714122441.3098337-2-huqiang.qin@amlogic.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 20:24:40 +0800, Huqiang Qin wrote:
> Add a new compatible name for Amlogic C3 pin controller, and add
> a new dt-binding header file which document the detail pin names.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
> 
> V1 -> V2:
>   Unchanged.
> V2 -> V3:
>   Updated commit message, and compatible are sorted alphabetically.
> 
>  .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |  1 +
>  include/dt-bindings/gpio/amlogic-c3-gpio.h    | 72 +++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/amlogic-c3-gpio.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

