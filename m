Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2FC758F06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGSH3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGSH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE7E43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D894D611FC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAEDC433C8;
        Wed, 19 Jul 2023 07:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689751744;
        bh=lrzqSSAIeBRUkDGeNDq4v1MLx2nUcpGhXdVknW1UJLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fd3KtEKj0cK96v8rS559Cq5e0iVXMHOXy1OFx4gld2uISco3MaAOKFVpZVAmLCQ/F
         YZnUQNb/2+w+ffUpxY2bZVQXfwFotMy5Oam08sMMLFN+GHNdYbAk8tl3528fqjJikD
         qXNtgeKMac92QDa1gk9t0rj6Y/dehEBlcFk7h6FkIUf8RU0RW7en0WFPAxOC+/xmmV
         iyU4tYfmIPRGN4dmGNSLgVhtq2KLup97ZmAOG+YyvtJGneuzZHtchrM+a7f02c7ALc
         KPcSbZcEClUg4GACYxkqVS5otRKaQqCxC+8YeRDl+XZjQ2d9Jn6VtSRrjeM8Gtw1ub
         Z1BrY5PrdgNKw==
Date:   Wed, 19 Jul 2023 15:28:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: Drop unused includes
Message-ID: <20230719072854.GK151430@dragon>
References: <20230717225505.3212231-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717225505.3212231-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:55:04PM -0600, Rob Herring wrote:
> Several includes are not needed, so drop them.
> 
> of_platform.h (for now) implicitly includes platform_device.h and of.h, so
> add explicit includes of those as needed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
