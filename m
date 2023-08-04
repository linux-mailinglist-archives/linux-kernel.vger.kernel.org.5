Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72FC77025B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjHDN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHDNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A231BFA;
        Fri,  4 Aug 2023 06:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 353D662033;
        Fri,  4 Aug 2023 13:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E6FC433C8;
        Fri,  4 Aug 2023 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691157352;
        bh=9hhi/nAWmNyyIHOsEqHH5P6/UucQ37voYn5qRUEJrTw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MAvIWe+xSEWWREX6qoskWG9RP7OQt/HFzW+a279IRKNSam8P7U5jbgvO0nUROQ9dr
         UZXEWdx2zjOR/RwoGhjAos2pIQxbJdwOLaGD6PqylmxmCf5F1qo4Kq8rA49BnhKSOS
         b/sJfBfd9Hhb6dpF1Jz537QPvdIfALJFpJ9vuogRxvpjjpn/Qq94Wmo2gNWCvJgkqG
         cuH3NntMAc8SKGS98nPvwGZ6wanZrfayem7giQDkZerqax2lnUVD3hJKHfPqWg+ZaV
         lEa3P1UJj+/o8B4bR3BVud5Hhrlw6wrY13U5FKy5BQbi9LOLONEm0ZJC4s+n10Xe/S
         coO7RGPl1/rsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2140ECE0299; Fri,  4 Aug 2023 06:55:52 -0700 (PDT)
Date:   Fri, 4 Aug 2023 06:55:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rcu: Remove unused function declaration
 rcu_eqs_special_set()
Message-ID: <a0dff752-4dfd-4bd8-9294-baebd783d32f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230803134919.38832-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134919.38832-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:49:19PM +0800, Yue Haibing wrote:
> Commit a86baa69c2b7 ("rcu: Remove special bit at the bottom of the ->dynticks counter")
> left behind this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Good catch!  Queued and pushed, thank you!

							Thanx, Paul

> ---
>  include/linux/rcutree.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 126f6b418f6a..153cfc7bbffd 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -37,7 +37,6 @@ void synchronize_rcu_expedited(void);
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  
>  void rcu_barrier(void);
> -bool rcu_eqs_special_set(int cpu);
>  void rcu_momentary_dyntick_idle(void);
>  void kfree_rcu_scheduler_running(void);
>  bool rcu_gp_might_be_stalled(void);
> -- 
> 2.34.1
> 
