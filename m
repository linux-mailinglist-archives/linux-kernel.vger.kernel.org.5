Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C21C7B66A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjJCKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJCKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C16B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08610C433C8;
        Tue,  3 Oct 2023 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696329891;
        bh=qXnD6pzcI1FwgXP0GfEI9XgrjQyk4vcg/50PoYtUKH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkGH2UoN9EZPNQGovmd77/YXDupulAqwmwkNSrlhfdWkS+oI/PRdOOzWqujwxCXfw
         FKihICWqmxs3eDF6EBVgb0gvszvF6Zo265l71dEjXrblEgiqsWpkC1K9Qljofbihvj
         KQ6xyPSCHu5kCIOPAKWyc4UyT8Y4gASTkbafjpEzeW49IyPJBi8C6VuEHVnfiOyn2q
         9bMsIDrld+m6goRci86YUkXBEMaE5zFtVSSBcTFAOesLYZOPinVyTw0IC624A8HBEX
         kqMLI6BnspTjRrA7pIFzCn/ApTnsMQ9JGiqCSPxy9N/e9L/aL0k0JP2ihf07g3Mrsf
         /QZAFnZwsHUqg==
Date:   Tue, 3 Oct 2023 12:44:47 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: skbuff: fix kernel-doc typos
Message-ID: <ZRvwn8lTaFxJ83X/@kernel.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
 <20231001003846.29541-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001003846.29541-2-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 05:38:46PM -0700, Randy Dunlap wrote:
> Correct punctuation.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  include/linux/skbuff.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/include/linux/skbuff.h b/include/linux/skbuff.h
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1309,7 +1309,7 @@ struct sk_buff_fclones {
>   *
>   * Returns true if skb is a fast clone, and its clone is not freed.
>   * Some drivers call skb_orphan() in their ndo_start_xmit(),
> - * so we also check that this didnt happen.
> + * so we also check that this didn't happen.

At the risk of bikeshedding (let's not) perhaps "this" can be dropped
from the line above?

In any case, I agree that this patch improves the documentation.

Reviewed-by: Simon Horman <horms@kernel.org>

>   */
>  static inline bool skb_fclone_busy(const struct sock *sk,
>  				   const struct sk_buff *skb)
> @@ -2016,7 +2016,7 @@ static inline struct sk_buff *skb_share_
>   *	Copy shared buffers into a new sk_buff. We effectively do COW on
>   *	packets to handle cases where we have a local reader and forward
>   *	and a couple of other messy ones. The normal one is tcpdumping
> - *	a packet thats being forwarded.
> + *	a packet that's being forwarded.
>   */
>  
>  /**
> 
