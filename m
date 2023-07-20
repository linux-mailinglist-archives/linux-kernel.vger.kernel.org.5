Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0878875A4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGTEMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGTEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7082118;
        Wed, 19 Jul 2023 21:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C8E615B2;
        Thu, 20 Jul 2023 04:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A6C433C7;
        Thu, 20 Jul 2023 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689826357;
        bh=3AHdDFL2C0BAHYVyKANj1zL7AGecfNpV115jPkuHkwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCpndoyA8eGRaZwEAIZ5eAIvWa1UeWuwHoS8+lWLp7Or7/SKZsbhFOBSgobJo0rJL
         MAhkyCABXiwnAJGHJIxevi8/sd+j+nNXbDZBW1ReYpK3kVjNe9aNcWMtgFWxgs15Ld
         PiTvWapDgxWT1hKwb65i8shckyB9ULl8Y7lRAajvc31XUrxRnhJnB35XYnRv793Ti6
         gqwZpyFe+A9XhecDDAbpOsKcrRhXSC+b5etDY8PhHsVu71Cu2cKcX0lnLQ2abD0uOO
         1/CmuVYMV0aehFssABrVcqyaWJ0C5zCDqz7XX3ebEopddshNbgzn9ST18Oo+vHdpzb
         eRJlJ2uFD+b0g==
Date:   Wed, 19 Jul 2023 21:12:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230719211235.1758bbc0@kernel.org>
In-Reply-To: <20230718132049.3028341-2-m.felsch@pengutronix.de>
References: <20230718132049.3028341-1-m.felsch@pengutronix.de>
        <20230718132049.3028341-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 15:20:49 +0200 Marco Felsch wrote:
> Add generic phy-supply handling support to control the phy regulator to
> avoid handling it within the glue code. Use the generic stmmac_platform
> code to register a possible phy-supply and the stmmac_main code to
> handle the power on/off.
> 
> Changelog
> ---
> 
> v2:
> - adapt stmmac_phy_power
> - move power-on/off into stmmac_main to handle WOL
> - adapt commit message
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Format should be:

Bla bla bla

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog

v2:
 bla bla bla


Please fix and rebase because the current version does not apply to
net-next/main.
-- 
pw-bot: cr
