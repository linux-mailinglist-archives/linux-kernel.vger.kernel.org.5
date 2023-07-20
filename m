Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93E75B254
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGTPTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGTPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348E5132;
        Thu, 20 Jul 2023 08:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD0F61B1D;
        Thu, 20 Jul 2023 15:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5B1C433C8;
        Thu, 20 Jul 2023 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866387;
        bh=VzuQfdcXhmSoUTwM4i0KWcI991yn6l0smL1PiDgs5tI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dwTRKEfMnIzLYa1RIKer17DnIERMlzp9u+gvqtr9ZX3/WlEQoaXy/pbLGp0vPd9iW
         9kOjlGCoAMjHtC0Zbj39/PzO0jeVY3gZwcoEvybwMo9BVzl3nFsJB+Ao74J9gLrU6T
         H2kHCHebrP/o/bo2mRz5waMdHKoHJM/wKoleBoXwBLl3TOLVpOnonEIbKI5XNuC3iS
         RC50QLDYzPV48o1iZbUEbHq696V4GJtCLosVcz3/ZLTBaj1lg53l8lmRxv+Z216RLN
         Sw442+1rCzgfOTuxBXl9R4WxvQDfBv2v/TVsuzqvMsCkiUrHm1LxDsvcftdJQKdO4c
         11NFS7RoMreiw==
Date:   Thu, 20 Jul 2023 08:19:45 -0700
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
Message-ID: <20230720081945.5cf783f0@kernel.org>
In-Reply-To: <20230720064636.5l45ad64kwwgd2iw@pengutronix.de>
References: <20230718132049.3028341-1-m.felsch@pengutronix.de>
        <20230718132049.3028341-2-m.felsch@pengutronix.de>
        <20230719211235.1758bbc0@kernel.org>
        <20230720064636.5l45ad64kwwgd2iw@pengutronix.de>
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

On Thu, 20 Jul 2023 08:46:36 +0200 Marco Felsch wrote:
> > Please fix and rebase because the current version does not apply to
> > net-next/main.  
> 
> Sure, I thought the changelog should be part of the commit message in
> net-dev therefore I included it.

Old rules, I think. Since started adding lore links to all patches you
can put the changelog in the cut-off section. Adding a link to the
previous revision there is highly encouraged, too!
  
There's a sample of the preferred format at:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested
