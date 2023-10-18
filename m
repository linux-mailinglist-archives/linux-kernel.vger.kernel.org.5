Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B847CDA29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjJRLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:20:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6DFFE;
        Wed, 18 Oct 2023 04:20:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507bd19eac8so2644808e87.0;
        Wed, 18 Oct 2023 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697628054; x=1698232854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EFlZnkY8EyRaraggjyEL1zoEKFY3JKxuG/ppBJQPfU0=;
        b=eM6ralUlmYRFxk2BVmNlpEuFQqSvJ/wY+f4QQ1PpjVGWN4fSoMKrSwbrfJzupmZlll
         vZ5hSGm66mOZfYvGG2TkZqYbPHAK5Ay5bzVHpL3QM7YwSHcfmPExZLRoKswQTO9ZlY8d
         oopLFA5ftJ69KFG+UiZA2jEGpAQny7K7YAFz9MoArkIrMPyBPps8dqr/Y12wICXk2CZz
         /KpbiK4NzlNLc+Vnaq+vwHY/46coMQd3kkUYFoH79pmVpKJUwbNYMcbgrgDzqxnpckn7
         HVlbYqeijB+92d0rKAL6RjfLZHdtl8QJDNe3pXz4zknlb4q87IjXQh+vjHdWil+Y9dix
         XLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628054; x=1698232854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFlZnkY8EyRaraggjyEL1zoEKFY3JKxuG/ppBJQPfU0=;
        b=GyIy6f3aZf3kfK+n7qZ1HeEhbLTe8R60ydUJmzdxasyFmbcBFpK1Ykwb5J1eefPV18
         9CJhJAOX8la43Xn7ndyW4WX1F34/ax5iGcM957jpqIMUxDsVKux1NMxP5Z5TSS+/GuX0
         UqB7R4/a3Of/9AUYpgkvhku353Um/aLmTEZGzcL4Q7SKB1jEn1hxNAyMKh73yhZWd2Ux
         M12C/ay01KzemCRnH5UNyJ5mcKFvdGTrG18qnhktM1rkQjzOLzTWfJc381PeY20ibmEg
         YFT8JYiSX11WLKMpUDafxbzuZ3FxLM4B4/nl76SgD8T2DiWYj1rz0nRtpasTAviiOScX
         kwPw==
X-Gm-Message-State: AOJu0YxOuwz1gZBR0TUlpP1HKgcCq4RD9Eq3ESAKLC5xGcbJCxApvO+e
        9+EVeoCTzLXFVK7WYdYoKlE=
X-Google-Smtp-Source: AGHT+IHh3+9KweyjmVombTCOuVdab7HEBQSDmeB5ANwbP4i5Ak6vqjonnASPe2EVvcZcilZ7fXbyOQ==
X-Received: by 2002:a05:6512:3da3:b0:507:9784:644c with SMTP id k35-20020a0565123da300b005079784644cmr5100200lfv.26.1697628053532;
        Wed, 18 Oct 2023 04:20:53 -0700 (PDT)
Received: from pc636 (host-90-233-215-212.mobileonline.telia.com. [90.233.215.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a05651236cf00b005068d6de988sm662657lfs.226.2023.10.18.04.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:20:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 18 Oct 2023 13:20:49 +0200
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/1] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZS-_kS0vr8G-k0pp@pc636>
References: <20231016173004.14148-1-urezki@gmail.com>
 <20231017103342.1879-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017103342.1879-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Hillf!

> Hi Ulad
> 
> Good work with a nit.
> 
Thank you :)

> On Mon, Oct 16, 2023 at 1:30 PM Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> > +static void rcu_sr_normal_gp_init(void)
> > +{
> > +	struct llist_node *llnode, *rcu;
> > +	int ret;
> > +
> > +	if (llist_empty(&sr.curr))
> > +		return;
> 
> This empty check erases the curr_tail race below instead of
> atomic_inc_return(&sr.active), because llist_add() will never return true
> after this check.
>
I use "active" counter to guarantee that a tail was updated in the
rcu_sr_normal_add_req(), i.e. the list might be not empty whereas the
tail updating might be in progress. llist_add() success and the task gets
preemted as an example.

Or i miss your point? If so, i appreciate if you clarify it in more
detail.

> > +
> > +	/*
> > +	 * A waiting list of GP should be empty on this step,
> > +	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > +	 * rolls it over. If not, it is a BUG, warn a user.
> > +	 */
> > +	WARN_ON_ONCE(!llist_empty(&sr.wait));
> > +
> > +	/*
> > +	 * Obtain a tail of current active users. It is guaranteed
> > +	 * that if we are only one active user and the list is not
> > +	 * empty, the tail has already been updated.
> > +	 */
> > +	ret = atomic_inc_return(&sr.active);
> 
> Replacing atomic_inc_return() with smp_mb() cuts sr.active off.
> 
But here we would like to know that we were only one user + not
empty list gurantees that a tail is ready.

Thank you for your comments!

--
Uladzislau Rezki
