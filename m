Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F567B579D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbjJBPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbjJBPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:52:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892CCA4;
        Mon,  2 Oct 2023 08:52:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2950AC433C7;
        Mon,  2 Oct 2023 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261973;
        bh=BLn9k0L62+HGyPFeeEZoLWnsVu0FYOcMpCWCctqTOCo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HAHJdZPwRrkPtZrhxb2JtnbIyWwVtenYCeeIVV1vJubJa3vjW4dJKFPiMevXNBOTm
         2YeT+78d1HHv+AS7MmeIiRXR7/Km4jnvdaQ1w+yPhQ7p8290Pg2xTSYw4nOk9O+TiG
         yW8Bw+Frx69pioCCIXjsT7gnYR6LgeIW8PTQTey34/y8FWQQr9H1ILMrx7KVl1a3ZM
         WfeV324HjCspmNSjaJjtWCABoz2H1mhGoQTGHcVOFcFtWjrHDfMLl+ZIyAAB2f3Y9g
         zUbSo9iJCt2fSdK/P8z9mLUtxoYWWLkyg/PYRwbSVLopd6JEQdiOGjoDkPWLfvN3V0
         5Mg+Jmxipl8EQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4AF5CE0CCF; Mon,  2 Oct 2023 08:52:52 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:52:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 09/10] rcu: Remove references to rcu_migrate_callbacks()
 from diagrams
Message-ID: <bbae8cc2-5c9f-4772-870c-be81748500e0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-10-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-10-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:36:02PM +0200, Frederic Weisbecker wrote:
> This function is gone since:
> 
> 	53b46303da84 (rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends)
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  .../Design/Memory-Ordering/TreeRCU-callback-registry.svg | 9 ---------
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg  | 9 ---------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
> index 7ac6f9269806..63eff867175a 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
> @@ -564,15 +564,6 @@
>         font-size="192"
>         id="text202-7-9-6"
>         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcutree_migrate_callbacks()</text>
> -    <text
> -       xml:space="preserve"
> -       x="8335.4873"
> -       y="5357.1006"
> -       font-style="normal"
> -       font-weight="bold"
> -       font-size="192"
> -       id="text202-7-9-6-0"
> -       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_migrate_callbacks()</text>
>      <text
>         xml:space="preserve"
>         x="8768.4678"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> index 6e690a3be161..53e0dc2a2c79 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> @@ -1446,15 +1446,6 @@
>         font-size="192"
>         id="text202-7-9-6"
>         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcutree_migrate_callbacks()</text>
> -    <text
> -       xml:space="preserve"
> -       x="8335.4873"
> -       y="5357.1006"
> -       font-style="normal"
> -       font-weight="bold"
> -       font-size="192"
> -       id="text202-7-9-6-0"
> -       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_migrate_callbacks()</text>
>      <text
>         xml:space="preserve"
>         x="8768.4678"
> -- 
> 2.41.0
> 
