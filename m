Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89B75BCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGUDLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGUDLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3B2D50;
        Thu, 20 Jul 2023 20:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7929F61CE3;
        Fri, 21 Jul 2023 03:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4870DC433C8;
        Fri, 21 Jul 2023 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689909093;
        bh=Pq/Uyc4eped6jMU42cvi7k4WYaZlbwcGo8MIhkmhssA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IdcWhLUERbQ0UoanBhSRVkQHJNHwuWctu0603avFZSV2CPkyQmFln54oHsoTVwPfA
         utcAoCCENB92dWcGAyoF8NxtlSwlbU7SJS2rURAt60n0VlkKX+60t3uQ+bWO/tzE9G
         qkm/1TT881Y4S0msDZz/p7P7q34XSjgHqaBEKLhawpH6opKaRVR/DxVTI+PrURDZYw
         zx1bItni2S5VO3a6MF1QdwfTSOqziQx1yLKwNE5ad7yY4xs7LU+MeoWmGRsUUWUE8Q
         jAm/xzR2z5AEZFgx2lhVkreiYnfW2wWQ5/IHIXMhoIRS1nLAYbwFdO+r+x9Euq3lLO
         SN5bNvbW6ezKg==
Date:   Thu, 20 Jul 2023 20:11:32 -0700
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
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230720201132.6c6a4c54@kernel.org>
In-Reply-To: <20230720072304.3358701-2-m.felsch@pengutronix.de>
References: <20230720072304.3358701-1-m.felsch@pengutronix.de>
        <20230720072304.3358701-2-m.felsch@pengutronix.de>
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

On Thu, 20 Jul 2023 09:23:04 +0200 Marco Felsch wrote:
> Add generic phy-supply handling support to control the phy regulator to
> avoid handling it within the glue code. Use the generic stmmac_platform
> code to register a possible phy-supply and the stmmac_main code to
> handle the power on/off.

Please rebase on latest net-next/master.
Bartosz converted the use_phy_wol bool to a flag a few weeks back.
-- 
pw-bot: cr
