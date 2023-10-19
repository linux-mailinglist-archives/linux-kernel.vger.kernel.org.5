Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238E7CFE87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbjJSPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbjJSPoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:44:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B2CF;
        Thu, 19 Oct 2023 08:44:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507975d34e8so9352033e87.1;
        Thu, 19 Oct 2023 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697730266; x=1698335066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lzyb9HhILSpSqLDZBMxdIS8vjxJNKRCRjnSgEpJ9ho=;
        b=HUQe34vFukWmm9aqjIU0In75m9jk/qiszyOHDSGjo13NjNSyb5SrbmL2xG3+lKirrn
         GpChI7K/0CtyGd20vW8hqW/ye5Hd281sjkAf5Dxjq8BZK/x8V5p0Dl0eJEyxAAkZQZxg
         BKc1eIH0bsXEKOC+Do7DA27g3YfXX4uC6sd3ehLoaYWSsy59cDQyUbLWrru6zDAnX7NV
         gOiGWQltHyv/G0x3ucrN+qGc5EiZRvt7M+9X16s1hnWdln5vJPslN6irRG1IXrsZ16mb
         KcqwKLZZJCRPe/2s7EnvosrGUqSZfeqWVptUCnjy0TL3lONWgi6VdVW5muqRyruf3RTE
         6iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730266; x=1698335066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lzyb9HhILSpSqLDZBMxdIS8vjxJNKRCRjnSgEpJ9ho=;
        b=qVdrN99yET4QNmBzwOVc2eh7ZRVkO290tUYshI5eCWJqmrbOIbebh5YYaV5wn0bdKX
         WXLmBVZ1atk2/+ec/vz9QW7THG7IFOyfaoXm49j3Ag5eFzKAlE2jLAv96ZlJQCpZcOfm
         vVgBF6RyRDCKDZUWxisGuY/Q0Z8f8S9/BdB0ukJooDhe8HKrf115Ql3YPCjRKJMNDDbc
         j3Lce2FyJppkyZCgXpgbNKRUi5B7xbkD6xpCUpND/41gQUn1B0ZJ3oGa3dRUYYzua7IK
         29Wc1XDS4p1EqC1o9gjy5YvvZd/sgBmihzLr24zixFR90H12uHzLwsie2E7w65nPua5Y
         wPrA==
X-Gm-Message-State: AOJu0YxCngs1ShRdEwSCGMiHQ4cjmk4Ovhsrvt02L1lySUi9T70t/w2N
        wp9d5GGVup3HESVTx3ODDwI=
X-Google-Smtp-Source: AGHT+IExC+rIp4XxnVYza4TfoIbLsC9KNHNg0FpjftaRHsBYrPV8ytvDZrvoiCjPUZWhJShjoRRmmw==
X-Received: by 2002:a05:6512:15a6:b0:507:b90a:7a5d with SMTP id bp38-20020a05651215a600b00507b90a7a5dmr2242093lfb.10.1697730266157;
        Thu, 19 Oct 2023 08:44:26 -0700 (PDT)
Received: from pc636 (host-90-233-215-212.mobileonline.telia.com. [90.233.215.212])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b00507a68e637bsm1140783lfh.205.2023.10.19.08.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:44:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 19 Oct 2023 17:44:23 +0200
To:     Hillf Danton <hdanton@sina.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/1] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTFO17eNKvDNokpe@pc636>
References: <20231016173004.14148-1-urezki@gmail.com>
 <20231017103342.1879-1-hdanton@sina.com>
 <20231019114432.1995-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019114432.1995-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:44:32PM +0800, Hillf Danton wrote:
> On Wed, 18 Oct 2023 13:20:49 +0200 Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> > > On Mon, Oct 16, 2023 at 1:30 PM Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> > > > +static void rcu_sr_normal_gp_init(void)
> > > > +{
> > > > +	struct llist_node *llnode, *rcu;
> > > > +	int ret;
> > > > +
> > > > +	if (llist_empty(&sr.curr))
> > > > +		return;
> > > 
> > > This empty check erases the curr_tail race below instead of
> > > atomic_inc_return(&sr.active), because llist_add() will never return true
> > > after this check.
> > >
> > I use "active" counter to guarantee that a tail was updated in the
> > rcu_sr_normal_add_req(), i.e. the list might be not empty whereas the
> > tail updating might be in progress. llist_add() success and the task gets
> > preemted as an example.
> 
> You are right - the preempt is what I missed.
> 
> Then another question rising - the adding order of sync requests is changed
> at wakeup time, as shown by the two functions below with sr.curr_tail and
> sr.active cut off.
> 
> static void rcu_sr_normal_gp_init(void)
> {
> 	struct llist_node *llnode, *rcu;
> 
> 	llnode = llist_del_all(&sr.curr);
> 	rcu = llist_reverse_order(llnode);
> 	if (!rcu)
> 		return;
> 	/*
> 	 * A waiting list of GP should be empty on this step,
> 	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> 	 * rolls it over. If not, it is a BUG, warn a user.
> 	 */
> 	WARN_ON_ONCE(!llist_empty(&sr.wait));
> 
> 	WRITE_ONCE(sr.wait_tail, llnode);
> 
> 	llist_add_batch(rcu, llnode, &sr.wait);
> }
> 
> static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> {
> 	llist_add((struct llist_node *) &rs->head, &sr.curr);
> }
>
This is what i was thinking of in the beginning but i had decided
to make it more complex and maintain the current tail. We will get
a slight penalty in performance on a synthetic test but i have compared
it and this is negligible in fact.

Another good thing with it is we process users in a reverse order,
i.e. the most waiting users to less ones, this is from a waiting time
point of view.

I like it better and it is more simple. Anyway we can improve it
further.

Thank you for the proposal!

--
Uladzislau Rezki
