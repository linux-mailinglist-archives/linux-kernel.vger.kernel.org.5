Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB67BF347
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442299AbjJJGqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:46:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F69E;
        Mon,  9 Oct 2023 23:46:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-584a761b301so3997977a12.3;
        Mon, 09 Oct 2023 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696920396; x=1697525196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIQ5Aqzrs+/ZfndeHL04d8DJFEaWbrXX5z11jTnUuqw=;
        b=Krzx7F3UWnarFXdch25s+60KRril5Vacoel+aYFVR21jBennHk8AmFtbuey6jruKKX
         Y8eykzJsDqtpoEiJN0pAyRG54JfplpvgOK8grqp/9Eigi8dJDx2Fz7f4CB/mh15MW+Nz
         f/az8B61oXVhtvV91C45PR208vSLTqT+RY4gSdw3utGOgyHs/I9Lz4tfky+F634a2Gd9
         eRNM/IDoDQmxtqVpz9HtpkALkDKON+bZMcw/Xk0E+xaLSBQNN6EJOFrXz4xtOQ7JF3ov
         eztvaNYob0DRovRayWwhdq220bC+F/g0G3cQCUOvzvrKFE5IuHkIuHGhuzt+84qMhtc9
         gq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696920396; x=1697525196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIQ5Aqzrs+/ZfndeHL04d8DJFEaWbrXX5z11jTnUuqw=;
        b=bM+4+Bl4miAnYgVKWMEVi0xGw76mAxB+RmOx0nRRwoIzQ/JOeL7dIlghQmv30f7sv3
         g5Q0kHNrn1fWJS1DpLhdctLaHVQa71CRbTUiVo8dzX8Z95+9n6M2IB/vFeqR0NK1Vn1y
         xYkhvdqctsvHxJysjqRXBIqVwdTvbvPtsCYDHxXkUUcbh/ChWtiDPnF3g4kx4FYNo/in
         cSa0fXBCQO9wnDvWsTaeUb+KurnFJ6Dm4uTluF/QN7TWjErndbmKm0hm8LkQ3oss7/n1
         IqKkpXqfGzDfkUv0vU4OL4GKc2dDXZNQ5qobrgAXAePbjh/VPXTgJBkEiLkfbTQhsNR6
         653g==
X-Gm-Message-State: AOJu0YzyWbtzouJRfJN+dURCgLzgwbMidgiOnNfQKexfvWaBIOPX4slQ
        47C0p044mgguT7ucOeqIGvQ=
X-Google-Smtp-Source: AGHT+IGl9lZn6Seoy30vrb0vHHbDaZ4cyNJ61UCdkTmIVLIqmmehlduoneDc8bAWXdYi7VPayrdlRA==
X-Received: by 2002:a05:6a20:7286:b0:15e:7323:5c0f with SMTP id o6-20020a056a20728600b0015e73235c0fmr21811247pzk.16.1696920395939;
        Mon, 09 Oct 2023 23:46:35 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b00692cb1224casm7504782pfo.183.2023.10.09.23.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 23:46:35 -0700 (PDT)
Message-ID: <5144fd23-e737-f23c-ce66-58d58ba13757@gmail.com>
Date:   Tue, 10 Oct 2023 14:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/5] srcu: Only accelerate on enqueue time
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Yong He <zhuangel570@gmail.com>
References: <20231003232903.7109-1-frederic@kernel.org>
 <20231003232903.7109-3-frederic@kernel.org>
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <20231003232903.7109-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 7:29 am, Frederic Weisbecker wrote:
> Acceleration in SRCU happens on enqueue time for each new callback. This
> operation is expected not to fail and therefore any similar attempt
> from other places shouldn't find any remaining callbacks to accelerate.
> 
> Moreover accelerations performed beyond enqueue time are error prone
> because rcu_seq_snap() then may return the snapshot for a new grace
> period that is not going to be started.
> 
> Remove these dangerous and needless accelerations and introduce instead
> assertions reporting leaking unaccelerated callbacks beyond enqueue
> time.
> 
> Co-developed-by: Yong He <zhuangel570@gmail.com>
> Co-developed-by: Joel Fernandes <joel@joelfernandes.org>
> Co-developed-by: Neeraj upadhyay <neeraj.iitr10@gmail.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/rcu/srcutree.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 9fab9ac36996..560e99ec5333 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -784,8 +784,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
>   	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
>   	rcu_segcblist_advance(&sdp->srcu_cblist,
>   			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
> +	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
>   	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
>   	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
>   	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
> @@ -1721,6 +1720,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>   	ssp = sdp->ssp;
>   	rcu_cblist_init(&ready_cbs);
>   	spin_lock_irq_rcu_node(sdp);
> +	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
>   	rcu_segcblist_advance(&sdp->srcu_cblist,
>   			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
>   	if (sdp->srcu_cblist_invoking ||
> @@ -1750,8 +1750,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>   	 */
>   	spin_lock_irq_rcu_node(sdp);
>   	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));

We did observe such issues at our farm and the same diff was applied,
thus this fix is especially appreciated. Thanks.

Reviewed-by: Like Xu <likexu@tencent.com>

>   	sdp->srcu_cblist_invoking = false;
>   	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
>   	spin_unlock_irq_rcu_node(sdp);
