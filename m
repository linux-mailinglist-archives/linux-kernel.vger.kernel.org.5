Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89CD752585
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGMOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGMOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5042273A;
        Thu, 13 Jul 2023 07:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3887561545;
        Thu, 13 Jul 2023 14:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A37C433C8;
        Thu, 13 Jul 2023 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689259797;
        bh=oUeQBue4D+P5RKuXyNTqDYmkvCRh4FYVyWtbLqAKhmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxKgmn1xsOU2pbWpxRsCyKp99xUi09w4uLO1jBoSotyiJJfgPbzmlDjlmVpBsS5Yx
         ncIKrzKTaCItf5d2aokcdPa8m4ykTT8eLxOfOfaM0s0kk5LsbIPsp4OOzWcSmSj2I2
         m2upGxLV5F+Dl4eoKKngsmTR1oinJHxiDWLERc+pK3cC2L/SLbYzEJBh6l+VzgNXy1
         gv2T5CpLDQ/tDZKe3UfKnti5V1QizPVI3MCNRkrb5pmPRMSoOdFjbwbF5nhNvdPrzl
         oOuAQTXH5PDOIdTy7qHbEezRIFzaPM5g7QeOP4kQaOO0fS76lgohHqzxEzRVcl5iWQ
         /HxBJ7XGKXF9Q==
Date:   Thu, 13 Jul 2023 15:49:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] dt-bindings: MFD: Convert STMPE to YAML schema
Message-ID: <20230713144950.GE10768@google.com>
References: <20230709-stmpe-dt-bindings-v5-1-34a3d6ee1e57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230709-stmpe-dt-bindings-v5-1-34a3d6ee1e57@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2023, Linus Walleij wrote:

> This converts the STMPE MFD device tree bindings to the YAML
> schema.
> 
> Reference the existing schema for the ADC, just define the
> other subnode schemas directly in the MFD schema.
> 
> Add two examples so we have examples covering both the simple
> GPIO expander and the more complex with ADC and touchscreen.
> 
> Some in-tree users do not follow the naming conventions for nodes
> so these DTS files need to be augmented to use proper node names
> like "adc", "pwm", "gpio", "keyboard-controller" etc before the
> bindings take effect on them.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This adds the missing GPIO bindings for the STMPE port expander
> and converts the existing MFD binding to YAML.
> 
> I suppose Lee can merge this when he's happy with it.
> ---
> Changes in v5:
> - Rebase on v6.5-rc1 meaning GPIO binding is merged
>   upstream and can be dropped.
> - Link to v4: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v4-0-36fdd53d9919@linaro.org
> 
> Changes in v4:
> - Make the GPIO bindings a conversion: there were some old
>   text bindings for the STMPE GPIO, we now delete them as
>   part of the patch.
> - I expect Lee or the DT binding tree to pick both patches.
> - Link to v3: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org
> 
> Changes in v3:
> - Update to review feedback
> - Collected some ack/review tags
> - Link to v2: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org
> 
> Changes in v2:
> - Split off a separate GPIO binding
> - Updated the MFD binding according to feedback
> ---
> ChangeLog v4->v5:
> - Rebase on v6.5-rc1
> ChangeLog v3->v4:
> - No changes.
> ChangeLog v2->v3:
> - Drop the required pwm properties already required by the
>   template pwm schema.
> - Add the number of PWM cells as const.
> ChangeLog v1->v2:
> - Split off the GPIO bindings to their own schema, as the old
>   bindings didn't even have any GPIO bindings. Put the GPIO
>   schema before this schema so we can use GPIO in the examples.
> - Drop nodename and pattern as STMPE is not a generic name.
> - Add maxItems to the resets.
> - Make wakeup-source just :true, as it is a generic property.
> - Move unevaluatedProperties for subnodes right before properties
>   as requested.
> - Name devices "port-expander" in the examples.
> - Use lowercase hex in line init.
> ---
>  .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
>  .../bindings/input/touchscreen/stmpe.txt           | 108 --------
>  .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
>  4 files changed, 297 insertions(+), 191 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
