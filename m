Return-Path: <linux-kernel+bounces-90930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C458706ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECDB1F214B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C34C61B;
	Mon,  4 Mar 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvkna4Cn"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1A4AECA;
	Mon,  4 Mar 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569399; cv=none; b=g9EwRVU83iV7cKDAGnleAycAdI50+oDGdYIceIlHBor+4VMjIF++u6Qv3pB+4A2gKCxUlXygL/9mOCeZQ8mc2AqhSBMtGazK3PCx0yxqSGUd39fQ1WFpjfgiSo+I9W6UzozlUOfnMrbmXmLw1mrMiE6qi6KJUy3b9u4yTT6/k4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569399; c=relaxed/simple;
	bh=bhcQm9IVnLXYy1OPeiOKUbtZ95U8nYVEeR2LEzd9vU4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siR4UEubsh/QrliXrGLUYZLWfx92qafiCwGW2E7+jlOs5sE4dw8IrjeoCcCyOQmeweuoAIdkRnkQ5xFRipzi1p44eLJs+bMpP5mMz0Sdg500d9iskc+oPcLctL7dL97moE3U9SApv5BVZnyrQGxvqYRLeD3LblwlCjFiUE5PUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvkna4Cn; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so54569121fa.0;
        Mon, 04 Mar 2024 08:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709569396; x=1710174196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LnSBxJC80Vj6IkqExQ+493ms5K7qx9z96ku+5T01XSU=;
        b=Gvkna4CnpQB+z3aoYqIQh4FdyBn+VsSHAnYRql3W7YMdHzZHNlajXHkHHziFgGIdOw
         WMwKxERySTYkM8jRFKtFbSB9WVuIuGRx8AgZMh2T4W/0haZ97wpL8hiWsPEcGV42A/FN
         DyfsazquwOeoAqUX2gYMhmFC0qBS5AZkBNCvVG2nadnBN03VTs8aS3zIS7eLEbMjml6g
         xqsOhYk4g4ZCjc1mfhkGg+SUdEkJTbCftnwfabBbf5SA1fIRMrrqZm/MOM24yfjXOJaG
         2unqKn5bnTiNhHcl7jkEkwPxGOY7+oOWpXTtnIfMAmvBOLxr92cT9j/TG0ZdtcP2hkil
         vSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569396; x=1710174196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnSBxJC80Vj6IkqExQ+493ms5K7qx9z96ku+5T01XSU=;
        b=vnzw+DZ9Nu9zoh1rXSbkRjpx3aZPDUnEo7MLPPZa9tZuDIJecSxQ1i0C5zI+tdZuEj
         kiQXeilawNTyEB1lGptxKUOxCOlthaRarLlh+C3szuhwaLAO/sI9jnLlAJtak1DpcxzM
         lqyMBiLwSh/W7o7MoohM7usA4+spbqRR2zKOdATNEjYL306ECOK9ihPecAsheUFmZNtV
         P5ZZ4585H01bNUWWHcqRcD9pEMHVzTOsJ1zBHyxzww5toWxonl9AGf7tCd6/TnU+9kw8
         X49kJOuLQOAnUf936/QBZtxoHfQxC9OLxr5Akvrez8HeFWEsDrhbY8jJoPmO/P1eRVCd
         idlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/eLb3V4Cyj8gsexbho4xF/5x1GcXh0P8FsDzvj/ayPCmUB60a4yIL3NSmnUirG5HrvPyf98Elhp/NQuykXDXUIKv3Lr7dgYG1AULgXeFxhnGEc5wyyb9nh7E2PwFnlJym
X-Gm-Message-State: AOJu0Yz9HBDq3H8w3YYhFiHjBKXOskOLTsbFuX51j/iD038JQnwkMjU1
	58F45eVlwYxY+vq2qOWDyt/ngF/LQwOswORnGbLG4MeGqHHY4+EW
X-Google-Smtp-Source: AGHT+IFlseYM9/Av3AeeMEWulX49lWqH5kgRVbhEM3OC0mBUVqyUY4xyyyWmucu/ME7DjRgpmB9W3A==
X-Received: by 2002:a2e:94d7:0:b0:2d3:a45c:4390 with SMTP id r23-20020a2e94d7000000b002d3a45c4390mr1410745ljh.5.1709569395624;
        Mon, 04 Mar 2024 08:23:15 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id e20-20020a2eb1d4000000b002d292191b10sm1773244lja.36.2024.03.04.08.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:23:15 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Mon, 4 Mar 2024 17:23:13 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZeX1cXWKv2kirDXg@pc638.lan>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
 <ZeW2w08WZo4yapQp@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeW2w08WZo4yapQp@localhost.localdomain>

On Mon, Mar 04, 2024 at 12:55:47PM +0100, Frederic Weisbecker wrote:
> Le Wed, Feb 28, 2024 at 07:04:21PM +0100, Uladzislau Rezki a écrit :
> > On Tue, Feb 27, 2024 at 12:07:32AM +0100, Frederic Weisbecker wrote:
> > > On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > +{
> > > > +	struct llist_node *done, *rcu, *next, *head;
> > > > +
> > > > +	/*
> > > > +	 * This work execution can potentially execute
> > > > +	 * while a new done tail is being updated by
> > > > +	 * grace period kthread in rcu_sr_normal_gp_cleanup().
> > > > +	 * So, read and updates of done tail need to
> > > > +	 * follow acq-rel semantics.
> > > > +	 *
> > > > +	 * Given that wq semantics guarantees that a single work
> > > > +	 * cannot execute concurrently by multiple kworkers,
> > > > +	 * the done tail list manipulations are protected here.
> > > > +	 */
> > > > +	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > +	if (!done)
> > > > +		return;
> > > > +
> > > > +	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > > > +	head = done->next;
> > > > +	done->next = NULL;
> > > 
> > > Can the following race happen?
> > > 
> > > CPU 0                                                   CPU 1
> > > -----                                                   -----
> > > 
> > > // wait_tail == HEAD1
> > > rcu_sr_normal_gp_cleanup() {
> > >     // has passed SR_MAX_USERS_WAKE_FROM_GP
> > >     wait_tail->next = next;
> > >     // done_tail = HEAD1
> > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > >     queue_work() {
> > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > >         __queue_work()
> > >     }
> > > }
> > > 
> > >                                                       set_work_pool_and_clear_pending()
> > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > > // new GP, wait_tail == HEAD2
> > > rcu_sr_normal_gp_cleanup() {
> > >     // executes all completion, but stop at HEAD1
> > >     wait_tail->next = HEAD1;
> > >     // done_tail = HEAD2
> > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > >     queue_work() {
> > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > >         __queue_work()
> > >     }
> > > }
> > >                                                           // done = HEAD2
> > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > >                                                           // head = HEAD1
> > >                                                           head = done->next;
> > >                                                           done->next = NULL;
> > >                                                           llist_for_each_safe() {
> > >                                                               // completes all callbacks, release HEAD1
> > >                                                           }
> > >                                                       }
> > >                                                       // Process second queue
> > >                                                       set_work_pool_and_clear_pending()
> > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > >                                                           // done = HEAD2
> > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > 
> > > // new GP, wait_tail == HEAD3
> > > rcu_sr_normal_gp_cleanup() {
> > >     // Finds HEAD2 with ->next == NULL at the end
> > >     rcu_sr_put_wait_head(HEAD2)
> > >     ...
> > > 
> > > // A few more GPs later
> > > rcu_sr_normal_gp_init() {
> > >      HEAD2 = rcu_sr_get_wait_head();
> > >      llist_add(HEAD2, &rcu_state.srs_next);
> > >                                                           // head == rcu_state.srs_next
> > >                                                           head = done->next;
> > >                                                           done->next = NULL;
> > >                                                           llist_for_each_safe() {
> > >                                                               // EXECUTE CALLBACKS TOO EARLY!!!
> > >                                                           }
> > >                                                       }
> > Looks like that. To address this, we should not release the head in the GP
> > > kthread.
> 
> But then you have to unconditionally schedule the work, right? Otherwise the
> HEADs are not released. And that means dropping this patch (right now I don't
> have a better idea).
>
The easiest way is to drop the patch. To address it we can go with:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31f3a61f9c38..9aa2cd46583e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1661,16 +1661,8 @@ static void rcu_sr_normal_gp_cleanup(void)
 	 * wait-head is released if last. The worker is not kicked.
 	 */
 	llist_for_each_safe(rcu, next, wait_tail->next) {
-		if (rcu_sr_is_wait_head(rcu)) {
-			if (!rcu->next) {
-				rcu_sr_put_wait_head(rcu);
-				wait_tail->next = NULL;
-			} else {
-				wait_tail->next = rcu;
-			}
-
+		if (rcu_sr_is_wait_head(rcu))
 			break;
-		}
 
 		rcu_sr_normal_complete(rcu);
 		// It can be last, update a next on this step.
<snip>

i.e. the process of users from GP is still there. The work is triggered
to perform a final complete(if there are users) + releasing wait-heads
so we do not race anymore.

I am OK with both cases. Dropping the patch will make it more simple
for sure.

--
Uladzislau Rezki


