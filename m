Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0697480F5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjLLSsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjLLSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:48:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638CD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:48:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A6C433C8;
        Tue, 12 Dec 2023 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702406895;
        bh=UQ8sRE4qQ4n3OeWeQ/x2EijHj4zYvZuf5iO56KaYMYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USdyD2jjP4yLtkFomWlwuqeB16OP1NFH0y8en3wYXly3blUxasIjop5aSKBQClcMy
         7TEHzV1KpNlBCEXV5OyJ2IeSSYgMtwZioUQczT+/Ki2WC+urZD4zn03bLxXaaLHTW9
         IZhZIqGFUsdvnAawqVuuVFK7wS71SnwP+LmNWYOxSid5xLQrEVK71TvyRgkhThsY28
         INaElF8vnTYJPDMifK73H9UtxGnB9YqgzHCT6rhmrhpsaZGwQSfe9/DseSbPPKoFJb
         jEHA/jemjJMx1/hTgoPRf4uUdN43QstmbUE6ks4X/o0MtQSJiTPU/HbzrWlwYgUgvn
         cyRaw9O+rUbxg==
Date:   Tue, 12 Dec 2023 18:48:09 +0000
From:   Simon Horman <horms@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <20231212184809.GA5817@kernel.org>
References: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:31:17PM -0600, Andrew Halaney wrote:
> Many hardware configurations have the MDIO bus disabled, and are instead
> using some other MDIO bus to talk to the MAC's phy.
> 
> of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> gracefully instead of failing to probe the MAC.
> 
> Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")

nit: the tag above is malformed, there is a '"' missing before 'net:'.

  Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")


> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

...
