Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7E7A79D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjITK4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:56:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DFC83;
        Wed, 20 Sep 2023 03:56:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A34C433C7;
        Wed, 20 Sep 2023 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695207365;
        bh=2lvWKZq1kkgMVRjSFXH0qaW7kcSUpEvRXiD7Sam0A3k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R5xkn5o2U3BPYy2wxiFVeX5w2GXFbZkB/MJXKi8G5BTm6PXt1LD6Km50vkV4ufnA3
         i23wKHdkNj/A7OyuhACJf7xtiIlbft3zQjzLUTW6ZyUsuzvNHl/bQyiY20M09QNj/K
         Ii1O9Iz8qFXlcQVoUtC69rzlZzTz9iIiQdGSzh50ddtOMAxafZ43Z9YNn7yTNhn8XT
         9dnScsC5R3JJRJm5ohTOuggAKbNLCGQFjkCVP/cI3PacDHQOhkOyWCIFSk3kqVuyE+
         gpxUxODnFZiUheI3ONDr0ChDQfsf9P8A22QJrNRpcRJaIQMr4Gm8Lvi1omnrojJPcv
         BYCwaQ1zMKZ5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 129DECE03D5; Wed, 20 Sep 2023 03:56:03 -0700 (PDT)
Date:   Wed, 20 Sep 2023 03:56:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist.h: docu: fix wrong function summary
Message-ID: <3b99763c-4380-4550-8c21-66cb8c80cca6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230920092211.11371-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920092211.11371-2-pstanner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:22:12AM +0200, Philipp Stanner wrote:
> The brief summary in the docstring for function list_next_or_null_rcu()
> states that the function is supposed to provide the "first" member of a
> list, whereas in truth it returns the next member.
> 
> Change the docstring so it describes what the function actually does.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  include/linux/rculist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 4837d8892691..fd0ed1550a7c 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -355,7 +355,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>  })
>  
>  /**
> - * list_next_or_null_rcu - get the first element from a list
> + * list_next_or_null_rcu - get the next element from a list
>   * @head:	the head for the list.
>   * @ptr:        the list head to take the next element from.
>   * @type:       the type of the struct this is embedded in.
> -- 
> 2.41.0
> 
