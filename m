Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF97F4EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjKVSIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjKVSIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:08:39 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A64D41;
        Wed, 22 Nov 2023 10:08:35 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d7f2058213so44440a34.1;
        Wed, 22 Nov 2023 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700676514; x=1701281314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Dku6pI5yBeQvQzTttR/loYo2QIvWg/tnPjwOl8SQg=;
        b=F8ZHh4aOd4cownmGc5c4Gl8SC4hgNeJGkeJOW1qoYUOb2iTO6e03oiUHXR2IyJVTgq
         ceLiUphYlFhyIwclA5dKWwyvE6JFL812vhEp6Qw1Gz03vD8QMoO8kie7qIW96i10KlFp
         k3oxmq7bIB9C3N2ni5ountZ/P4EqnhI2aoMPVBDr6laMppm35O8jSIg5uwLuUdJik+T4
         KCB7aD0Ra+q89OYnMVAW6JL3fcL17aenTquNovlzUhiFzbyXSWCNGuK8b6JJWWd/jdhv
         rL0P2rwOWWWyieDIVh75/ZeZyZrVOoTG0GbUpMu56Zv+bQCR+qndQG5opc2+WjjzHI0i
         RF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676514; x=1701281314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8Dku6pI5yBeQvQzTttR/loYo2QIvWg/tnPjwOl8SQg=;
        b=na3vRHerVj54Y8HO2/DGUY703x2odaRcOV2QMRU0JOlxWSTSaemG16yAtBESE0Sk7N
         mNgivKBFS+nF8XKr5hyhVaTlLEUgIl/eIlIzfm5XoYeHteES23DMCdcpMx2KtIKkJu1c
         ZOjyQRhXu5J69wlclraXbI7Ef54ONsTdfQXHIsxcDaT2sPOXJw3lNPBJqZHvou8VSQUk
         MRwsGl+Ir82NOr6MKdsp6r9pa/xHs8yPpFXnKyhpHibnISdFSuS/EhfuaBHofCMcGkiw
         853K+Uq+3dyVvBWBfwEDzAlorgYdw0v1XVY7eFncaFWQd7mI+EaGsCyZo1xGG0OQLnkd
         Scyw==
X-Gm-Message-State: AOJu0Yzl3XgrnQRMA/XkRDatS81EnU6cRpslUejmdoS84m5NfauSllqX
        YZt0I+9IJ5V7bBGSNXSfToU=
X-Google-Smtp-Source: AGHT+IEcsrZHbaaDmbm14trm3iRPQ/jMPC+Eq+sgQc2EM7fLbyxc0tHzfuIhRzgwgflQYmX2JeG8Xw==
X-Received: by 2002:a05:6830:1d4d:b0:6b9:3f64:4e8c with SMTP id p13-20020a0568301d4d00b006b93f644e8cmr3801997oth.9.1700676514478;
        Wed, 22 Nov 2023 10:08:34 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q7-20020ad44027000000b00670a8921170sm5073923qvp.112.2023.11.22.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:08:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0B8EA27C0054;
        Wed, 22 Nov 2023 13:08:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Nov 2023 13:08:33 -0500
X-ME-Sender: <xms:n0NeZRgTGjBg0pIFaPYQENHU8-WejmEhr-ha4Wy62lnRUpe0Wa3Plg>
    <xme:n0NeZWDNV5p-lxm_pWz1ZfxW17XRYkJDi5RBjmFY82rVorMf-k7aT_llDoCFdj8lH
    XhE7qOJMHWpla33ew>
X-ME-Received: <xmr:n0NeZREKxyXn24JOyVDqGwzbWTpcHgkpbE2j2qD4jXT6OBT2icpwdzik37M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:n0NeZWT7WTNByJkkQy-Tb4QyojNduQT0t3LNMda79u3uRb_G7yzteQ>
    <xmx:n0NeZeyln2lcoywVlL7F_zO4jhPxOwTmIPE9HrEeg7m-sDVT-0eX-Q>
    <xmx:n0NeZc5JgoZEdypXZCK0ldWeu2KHybgy9iGNTHwsUGUY2lpGS2aE2g>
    <xmx:oUNeZan2_Dd24HQlmKIo2fcYVBtZSbTHbiA1Wa03UEUMdLo0UFP10WMQh4Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:08:30 -0500 (EST)
Date:   Wed, 22 Nov 2023 10:08:06 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [REPOST PATCH] srcu: Use try-lock lockdep annotation for
 NMI-safe access.
Message-ID: <ZV5Dhjcb9Jd_lk0O@boqun-archlinux>
References: <20231121123315.egrgopGN@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121123315.egrgopGN@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:33:15PM +0100, Sebastian Andrzej Siewior wrote:
> It is claimed that srcu_read_lock_nmisafe() NMI-safe. However it
> triggers a lockdep if used from NMI because lockdep expects a deadlock
> since nothing disables NMIs while the lock is acquired.
> 


Thanks for reposting!

I would add a paragraph here explaining why the commit is culprit:

This is because commit f0f44752f5f61 ("rcu: Annotate SRCU's update-side
lockdep dependencies") annotates synchronize_srcu() as a write lock
usage (so that srcu_read_lock(); synchronize_srcu() deadlock can be
found), the side effect is that the lock srcu_struct now has a USED
usage in normal contexts, so it conflicts with a USED_READ usage in NMI.
But this shouldn't cause a real deadlock because the write lock usage
from synchronize_srcu() is a fake one and only used for read/write
deadlock detection.

> Use a try-lock annotation for srcu_read_lock_nmisafe() to avoid lockdep
> complains if used from NMI.
> 
> Fixes: f0f44752f5f61 ("rcu: Annotate SRCU's update-side lockdep dependencies")
> Link: https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This is a repost of
> 	https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de
> 
> Based on the discussion there I *think* this is preferred over the NMI
> check in lock_acquire().
> But then PeterZ also pointed out that he has a problem with
> 	f0f44752f5f61 ("rcu: Annotate SRCU's update-side lockdep dependencies")
> 
> because trace_.*_rcuidle machinery. This looks okay because the _rcuidle
> part is using SRCU and the rcu_dereference_raw() tracepoint_func is
> using RCU + SRCU in its free part.
> 

Yeah, I think we don't have more problems (famous last words).

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  include/linux/rcupdate.h |    6 ++++++
>  include/linux/srcu.h     |    2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -301,6 +301,11 @@ static inline void rcu_lock_acquire(stru
>  	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
>  }
>  
> +static inline void rcu_try_lock_acquire(struct lockdep_map *map)
> +{
> +	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
> +}
> +
>  static inline void rcu_lock_release(struct lockdep_map *map)
>  {
>  	lock_release(map, _THIS_IP_);
> @@ -315,6 +320,7 @@ int rcu_read_lock_any_held(void);
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  # define rcu_lock_acquire(a)		do { } while (0)
> +# define rcu_try_lock_acquire(a)	do { } while (0)
>  # define rcu_lock_release(a)		do { } while (0)
>  
>  static inline int rcu_read_lock_held(void)
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe
>  
>  	srcu_check_nmi_safety(ssp, true);
>  	retval = __srcu_read_lock_nmisafe(ssp);
> -	rcu_lock_acquire(&ssp->dep_map);
> +	rcu_try_lock_acquire(&ssp->dep_map);
>  	return retval;
>  }
>  
