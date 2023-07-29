Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536FF768286
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjG2WTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2WTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 18:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDEE5F;
        Sat, 29 Jul 2023 15:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C74D60B29;
        Sat, 29 Jul 2023 22:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB17C433C8;
        Sat, 29 Jul 2023 22:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690669158;
        bh=hJ6YsESUwInT54UMXHoGOjcL1xW0mvMKXXRrjA3yRK0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GO0GDSAIgY5+Smpv5YCg9yR0+mOx/9snKdfK+Vnom1wx5sEa0aDtFk6upo3KScKkL
         g6pvbJ44TEz+WcmNU63AOvBaBV8uK2EfLP+JyVG3+QDSTTXqrP/kN28VvlAOrpB0Vd
         yh652SssPFQOEjq3g3yRLPYuc9lvR9XghFHhJCMn6SO+zFb+h3RPHRlt/e34mhFLzJ
         3nBbdO1Dw4MLFYNj45wWavpypyQYWx068OMWMvxbJ+gzpABbB02d1/F0hSfzDoMAio
         HDc281006Qo+Dz8R/duI2KQzOw3qQ3o/+NL3YxQAln1iECIcC1XG+cA6blYmPguhHi
         ZBso+I092jJJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1CCC6CE0BB1; Sat, 29 Jul 2023 15:19:18 -0700 (PDT)
Date:   Sat, 29 Jul 2023 15:19:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 5/5] rcu/tree: Remove superfluous return from void
 call_rcu* functions
Message-ID: <96b57ee8-0dc3-4f07-bb6c-3d7c7556deb9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230729142738.222208-1-joel@joelfernandes.org>
 <20230729142738.222208-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729142738.222208-7-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 02:27:36PM +0000, Joel Fernandes (Google) wrote:
> The return keyword is not needed here.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Odd that this is allowed.  ;-)

I took 1, 2, and 5, thank you!  It would still be good to get Frederic's
eyes on 3 and 4.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cb1caefa8bd0..7c79480bfaa0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2713,7 +2713,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>   */
>  void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
>  {
> -	return __call_rcu_common(head, func, false);
> +	__call_rcu_common(head, func, false);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu_hurry);
>  #endif
> @@ -2764,7 +2764,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> +	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
