Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78978B6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjH1Rnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjH1Rnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3C124;
        Mon, 28 Aug 2023 10:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7352F636D6;
        Mon, 28 Aug 2023 17:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F8C433C8;
        Mon, 28 Aug 2023 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244611;
        bh=aHcFYtQpngg3LqSi/BhFPGGd785+nQNWxFuOmswrDr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u/1eZD9VDh/CcUJokYdHI+bAAL1baWL2glSUMvrSSxEMP8SUTFdnix6/31adUhEnF
         A3qQshqKnqpmWOKnITOOaU6eAAUbPDThaudZV9YAhK7F+nlKd8jMH/y3X/bMhRQklt
         27JPHl3dwg16lIkybeSJUaC5G1A4l2pLR35jQT4KOLnKnaGMnvYHtpSoMu+1Y84wZQ
         KL8Rct2OPWbv5Zw7Rec2Knfx1iNdYGH6kN9kZUhV0TgX4Lb16RfVeRQX50jbnWak6E
         SDhtdhMIMlKxqcnM+9e66x7oLF+YiMgP1LS438K8MuMukHjAXoOZf40dfohDUSXIPI
         iacEmemfFEMCg==
Date:   Mon, 28 Aug 2023 18:43:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: adc: add AD717X
Message-ID: <20230828184347.009f3236@jic23-huawei>
In-Reply-To: <20230810093322.593259-1-mitrutzceclan@gmail.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  adi,temp-channel:
> +    description:
> +      Enables temperature reading channel

Why not always enable it?

> +    type: boolean
> +
> +  dependencies:
