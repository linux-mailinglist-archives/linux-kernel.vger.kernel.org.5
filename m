Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D567A96E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjIUREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjIURDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:03:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6525199D;
        Thu, 21 Sep 2023 10:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77002C4E66F;
        Thu, 21 Sep 2023 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695302328;
        bh=MQmDcrstvVZY6kP40oKfTwDz3+GADNbB6xrGhKqtNWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6ypGZ2LXHS25WVtSQxLI5ff8jnb4+RBGEIa0dSL+FH9YHplFSwurc1OuT0UjsT63
         RsLHsVQ+l4sPhSAMZKhJZl8yWpEIUgIqScF4g0/U87ecw1zTMgIcRnNQxftsTPbiMv
         9nWpfgWorIWn+V9Qcydb7anewyFKwvi9Bf4voOkSrZ5GE854CJCdJSAEQKbi0Rb8q+
         dT8PU1ixceAAnL0hbaJsKd7TMctC4JMUFgngXx2yQ7EeFgVGj6+NslN8LYM8WwRRGt
         PTXNmAAFotmZjsAmahKs7EcIdOYbsKVGh65/XBirb6R6e11JuQJTOsaGlKBbAVMGZA
         xkun8OAHmZ85A==
Date:   Thu, 21 Sep 2023 14:18:40 +0100
From:   Simon Horman <horms@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sean Anderson <sean.anderson@seco.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: Fix id2_register for tcan4553
Message-ID: <20230921131840.GM224399@kernel.org>
References: <20230919095401.1312259-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919095401.1312259-1-msp@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:54:01AM +0200, Markus Schneider-Pargmann wrote:
> Fix id2_register content for tcan4553. This slipped through my testing.
> 
> Reported-by: Sean Anderson <sean.anderson@seco.com>
> Closes: https://lore.kernel.org/lkml/a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com/
> Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

