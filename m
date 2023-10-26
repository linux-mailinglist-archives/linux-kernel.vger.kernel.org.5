Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA417D833D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjJZNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:00:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4512A;
        Thu, 26 Oct 2023 06:00:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507cd62472dso2330116e87.0;
        Thu, 26 Oct 2023 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698325229; x=1698930029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1FJ+d0g9WKmWzmLDpzY4/SwDygYny0dVwrh16DQQLso=;
        b=ErXOM6BSslu9If+SeJBGMGDgxDMSmolOMAQE8sUqkLzPgv/ZzxAV4RJE3gUDYA9L/F
         tvq9Qz/WdTO3nbZe86jYuExEBJu6jV9VXMrjOQUzY5pvElBwLgOJUfTzvPtyQ192xXcU
         rl/AoIvD3yBPDWohydlj14mpSAlN7/OpJfg5lZjgn7kd2k35KiHlq5LEZh7BrQGAfZyq
         HVqpmK5/pGQdGzDD5lUST6HcFKqFMAxB8rbrH4eeW6j9oq5v3ARpS0kIIs5TXycKl9su
         gUAV1TmvNuF1UK+QBtOV+MAaf3G2pJFdfjA3rSRz1k+B4DuQpxV6nNWFnx1Y9qz5N1r8
         65Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698325229; x=1698930029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FJ+d0g9WKmWzmLDpzY4/SwDygYny0dVwrh16DQQLso=;
        b=JOTg0IJcoW3z7RlhSJZJZRs1C4IHBivW7ySy3LLlkPOzmlsplFpYAAbf3FP6NSQ3+M
         sCBmYgArOcyNdJCmN7Mvz/MEWMZTML70zrRCLyNNZv0sAZ2ZdH6UC6GhKA0S1vAtgUsT
         JMvGo3dfrECbeYt4zP1ChXID/8JLRg8CZFvMDVAvdesggH3vkJ42c6gRMg1ZTmD3qwoH
         b0lgESTuhnVWL9u+Wiwa+KU5XK1yFun7VekM0b/XFde27Xj2DEKG5umj9v61YE+oDPmn
         g+ZlGVYcuUvsE4KPAWZax7aPIaoibRsy5V2Ro/Jo26oX8AZuBQi1unRktSrnlKV5Yx2c
         D/GA==
X-Gm-Message-State: AOJu0YxKQqk4ApncJHghvdpFqLZ8ADn0PzjVzSGlr6jcXhkJb+1Kf7z2
        2dGX354wRrRkIPrTXhKt6lQ=
X-Google-Smtp-Source: AGHT+IGBIofRmeNzSWP4ypEAoHZp8jMWkD7Nd93LrAtANLqerrDEELi2L8AwGzU64g7eOsa9+YTF0g==
X-Received: by 2002:ac2:47ec:0:b0:507:9a87:289b with SMTP id b12-20020ac247ec000000b005079a87289bmr938808lfp.10.1698325228460;
        Thu, 26 Oct 2023 06:00:28 -0700 (PDT)
Received: from pc636 (host-90-235-24-197.mobileonline.telia.com. [90.235.24.197])
        by smtp.gmail.com with ESMTPSA id t10-20020a19910a000000b005079fe27ec8sm3025800lfd.85.2023.10.26.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:00:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 26 Oct 2023 15:00:25 +0200
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTpi6diP4h84PtWE@pc636>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTkwl0bzTTCy8g5N@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTkwl0bzTTCy8g5N@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:13:27PM +0200, Frederic Weisbecker wrote:
> Le Wed, Oct 25, 2023 at 04:09:13PM +0200, Uladzislau Rezki (Sony) a écrit :
> > +/*
> > + * Helper function for rcu_gp_cleanup().
> > + */
> > +static void rcu_sr_normal_gp_cleanup(void)
> > +{
> > +	struct llist_node *head, *tail, *pos;
> > +	int i = 0;
> > +
> > +	tail = READ_ONCE(sr.wait_tail);
> > +	head = llist_del_all(&sr.wait);
> 
> This could be llist_empty() first to do a quick
> cheap check. And then __llist_del_all() here because
> it appears nothing else than gp kthread can touch sr.wait.
> 
No problem i can fix it. Initially i had a check first!

> > +
> > +	llist_for_each_safe(pos, head, head) {
> 
> Two times head intended here? There should be some
> temporary storage in the middle.
> 
Yes. It is intentially done. The head is updated, i.e. shifted to a next,
because we directly process users from a GP. The number is limited to 5
all the rest is deferred.

> > +		rcu_sr_normal_complete(pos);
> > +
> > +		if (++i == MAX_SR_WAKE_FROM_GP) {
> > +			/* If last, process it also. */
> > +			if (head && !head->next)
> > +				continue;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (head) {
> > +		/* Can be not empty. */
> > +		llist_add_batch(head, tail, &sr.done);
> > +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> 
> So you can have:
> 
> * Queue to sr.curr is atomic fully ordered
> * Check and move from sr.curr to sr.wait is atomic fully ordered
> * Check from sr.wait can have a quick unatomic unordered
>   llist_empty() check. Then extract unatomic unordered as well.
> * If too many, move atomic/ordered to sr.done.
> 
> Am I missing something?
>
If too many move to done and kick the helper. The sr.wait can not
be touched until the rcu_sr_normal_gp_cleanup() is completed, i.e.:

<snip>
GP-kthread(same and one task context):
    rcu_sr_normal_gp_cleanup();
    wait for a grace period;
    rcu_sr_normal_gp_cleanup();
<snip>

Am i missing your point?

--
Uladzislau Rezki
