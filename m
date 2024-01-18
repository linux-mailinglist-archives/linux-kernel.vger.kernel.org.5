Return-Path: <linux-kernel+bounces-30011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087558316B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE5A1C21EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8720B1F;
	Thu, 18 Jan 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiwIEf+s"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65522033C;
	Thu, 18 Jan 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574238; cv=none; b=kJDLh80rPjDdujqN/qovrCD7s7XPyND36jwZjB0sooCIGcaVvNlYuhr4B98KsZ5ZXgNsy/VqmUHl+vgvSyZEHiedI0KyW08G7VQCdlcsvCcQUk+GcYKi1i3TjxVvSqXwZhJ9WVJIC4vttWjv280ol13ZG2YwT3HJx5nlJBKGJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574238; c=relaxed/simple;
	bh=RJ4L71AXZx+xhM6BQtxN0J2s4OHf6poSNuVUQ6oqgck=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=e09sdgjSLbsyD3Tls69D0WKP+gRfTG9ZlPf6E+37lY2gwxXt470pOLhqxZE5gJJ0E3xAWZpIpbQjtEkOuStSSCIS4SAMOA8j1WojKj0cyKMsHMVSCb1Vmb1rIxbFiSqSDjdOeQFXucdKY93fiSYEyx6UQKaAOHZNzKoKh9MB3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiwIEf+s; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so14725835e87.0;
        Thu, 18 Jan 2024 02:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705574235; x=1706179035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFraLko0Sunles8rE+veYeEajynN3b2IofKXL2TxPzM=;
        b=CiwIEf+sfzHHyPumXgIbl2gYONHQn/+LjPavYTIDf2EJra036MWtWRDCmcPSdJlnWY
         i73OIx79GJWrvHc3/+ZXcfq4paT3CIxNsbkJNYXzmzPFgUldrULwGhMvp3i7mB+NYp5j
         dLoz6ebBclCUmhMR05bPV2hLLYFJXqwsu2HrCns2XpULBWCjfvbzaZuW+AvbWVho784R
         eCZHLYqFoE+SGKufX162QhGL9FxFpQXi+qbZDk4oH0BsDq9yqptpCmjlUH23nVl6DOma
         xbEehzssWCbd6f0T8lSTpTtIIk+EtwnxRgPDgrEoWHd9h1aQSFuuHUQTUd0AbRf+Qrqm
         pIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705574235; x=1706179035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFraLko0Sunles8rE+veYeEajynN3b2IofKXL2TxPzM=;
        b=GqOnF2jmvUaBY1V1FX/uNymiksgDFlCOXwUxxxcvBF5jK1VkmwW+KNTgq5p0ktqTXQ
         CnYfhYYJlLJRvc+LbghfBEuJ5D5E3yzKI+WjzappAZ+mIoLAyLA8JqaNqzdnb4kJvVvY
         zNzB1FVNZfOcuh/BKmNaXKbWrLsvAsA0LVXujCptiwqWwSDArElozGNhQ9v5BTvez8q7
         m8sipiTdsnvW/91nX0wUCayQDE005cGiRKlzZHxhuPQYJSpHYTFUpSVEBcGpJyFm6WKj
         Z9huTuKyHd1ZfKBJVAJj+z19GXDHknDmFAFPvfTpObe33SVp6d7FL/FZJJjZNbayGQGZ
         LYQg==
X-Gm-Message-State: AOJu0Yx/STzLePLEQaGvD3Mdb8DuVTLU+DI3B4ddAM9NbKnXs0aa0wy3
	J3kDe2mJCE81uZ0X9shUI20jfy9rAKeKNkaL8BGkLDC/rYgXHFM0
X-Google-Smtp-Source: AGHT+IGztuqXWrg30hrZfO2olrqNs7VCjF+rYVLphMtpPYdpBGJVF7g0KOxH1eK3rpZyM9tMbah56Q==
X-Received: by 2002:a05:6512:3081:b0:50e:bd4d:9e2a with SMTP id z1-20020a056512308100b0050ebd4d9e2amr226676lfd.96.1705574234582;
        Thu, 18 Jan 2024 02:37:14 -0800 (PST)
Received: from pc636 (host-90-235-20-191.mobileonline.telia.com. [90.235.20.191])
        by smtp.gmail.com with ESMTPSA id b5-20020a056512060500b0050e6bf65b2asm590662lfe.288.2024.01.18.02.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 02:37:14 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 18 Jan 2024 11:37:11 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zaj_Vw8B5E28TqZ2@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
 <ZaHGv3wMYP4LDCxG@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaHGv3wMYP4LDCxG@localhost.localdomain>

On Sat, Jan 13, 2024 at 12:09:51AM +0100, Frederic Weisbecker wrote:
> Le Thu, Jan 04, 2024 at 05:25:07PM +0100, Uladzislau Rezki (Sony) a écrit :
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 9b0b52e1836f..4812c6249185 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -168,4 +168,16 @@ config RCU_STRICT_GRACE_PERIOD
> >  	  when looking for certain types of RCU usage bugs, for example,
> >  	  too-short RCU read-side critical sections.
> >  
> > +config RCU_SR_NORMAL_DEBUG_GP
> > +	bool "Debug synchronize_rcu() callers for a grace period completion"
> > +	depends on DEBUG_KERNEL && RCU_EXPERT
> > +	default n
> > +	help
> > +	  This option enables additional debugging for detecting a grace
> > +	  period incompletion for synchronize_rcu() users. If a GP is not
> > +	  fully passed for any user, the warning message is emitted.
> > +
> > +	  Say Y here if you want to enable such debugging
> > +	  Say N if you are unsure.
> 
> How about just reuse CONFIG_PROVE_RCU instead?
> 
Less extra CONFIG_* configuration we have the better approach is. I do
not mind, so we can reuse it. Thanks for this point :)

I see in some places indeed it is used as a debugging peace.

> > +
> >  endmenu # "RCU Debugging"
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 499803234176..b756c40e4960 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1422,6 +1422,106 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  }
> >  
> > +/*
> > + * There are three lists for handling synchronize_rcu() users.
> > + * A first list corresponds to new coming users, second for users
> > + * which wait for a grace period and third is for which a grace
> > + * period is passed.
> > + */
> > +static struct sr_normal_state {
> > +	struct llist_head srs_next;	/* request a GP users. */
> > +	struct llist_head srs_wait;	/* wait for GP users. */
> > +	struct llist_head srs_done;	/* ready for GP users. */
> > +
> > +	/*
> > +	 * In order to add a batch of nodes to already
> > +	 * existing srs-done-list, a tail of srs-wait-list
> > +	 * is maintained.
> > +	 */
> > +	struct llist_node *srs_wait_tail;
> > +} sr;
> 
> "sr" is good enough for a function scope variable but not for a file scope one.
> 
> At least "sr_state" would be better. Or maybe you don't even need to name that
> struct and make instead:
> 
> struct {
>     ...
>     ...
> } sr_normal_state;
> 
It is moved by the following patch in the series under the "rcu_state" struct variable.

> 
> > +
> > +/* Disabled by default. */
> > +static int rcu_normal_wake_from_gp;
> > +module_param(rcu_normal_wake_from_gp, int, 0644);
> > +
> > +static void rcu_sr_normal_complete(struct llist_node *node)
> > +{
> > +	struct rcu_synchronize *rs = container_of(
> > +		(struct rcu_head *) node, struct rcu_synchronize, head);
> 
> Should there be some union in struct rcu_synchronize between struct rcu_head
> and struct llist_node?
> 
> Anyway it's stack allocated, they could even be separate fields.
> 
> > +	unsigned long oldstate = (unsigned long) rs->head.func;
> 
> Luckily struct callback_head layout allows such magic but if rcu_head
> and llist_node were separate, reviewers would be less hurt.
> 
> If stack space really matters, something like the below?
> 
> struct rcu_synchronize {
> 	union {
> 		struct rcu_head head;
> 		struct {
> 			struct llist_node node;
> 			unsigned long seq;
> 		}
> 	}
> 	struct completion completion;
> };
> 
> 
We can do that. I am not sure if should be a separate patch or as a big
change. I tend to separate it.

> > +
> > +	WARN_ONCE(IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP) &&
> > +		!poll_state_synchronize_rcu(oldstate),
> > +		"A full grace period is not passed yet: %lu",
> > +		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> > +
> > +	/* Finally. */
> > +	complete(&rs->completion);
> > +}
> > +
> [...]
> > +
> > +/*
> > + * Helper function for rcu_gp_cleanup().
> > + */
> > +static void rcu_sr_normal_gp_cleanup(void)
> > +{
> > +	struct llist_node *head, *tail;
> > +
> > +	if (llist_empty(&sr.srs_wait))
> > +		return;
> > +
> > +	tail = READ_ONCE(sr.srs_wait_tail);
> 
> Is the READ_ONCE() needed?
> 
> A part from those boring details:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
Appreciate for the review. I will fix all the comments.

Thanks!

--
Uladzislau Rezki

