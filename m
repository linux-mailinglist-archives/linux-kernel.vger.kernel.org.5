Return-Path: <linux-kernel+bounces-29385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C4830D97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398B21F25EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694124B22;
	Wed, 17 Jan 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b="OtPPLGUi"
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com [198.54.127.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEA24A00;
	Wed, 17 Jan 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521626; cv=none; b=AEPpO1juVRQUxOeQWYoF9yi+WG8vw54J8CWj47X0Oo42/m8L/wolPIhQuqj+G4uCAqjuBxiF/+sfK9k1WgGcE5K+W9V2Al0U8IMIUjPFN9UWTQg/j2uoGjWPwRJavh1Yht7v13TZS81zAVHrT2mNTwwm9Xup8F1Wi4iA7Hc7TUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521626; c=relaxed/simple;
	bh=YVcIYhmkjZDzczcsw0If+iQoXd/UI9stcIz62mPaVPg=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Virus-Scanned; b=W3mesiM9EKZ3Y2H/o4jJ3uhrzvjs7Na3+yCBzleL7M67VnmeQp1WghPfaMDTfEaLwPw0MF/nlNfjOfYzgjtHZ7E4wzlfRIuhLGbnrZRNeWALTo6nbKnYVwKAFthouGeqYMAd/EHj67QBIq20Kk1B1zsA31wVylLa2jpfiJi0MkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com; spf=pass smtp.mailfrom=pappasbrent.com; dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b=OtPPLGUi; arc=none smtp.client-ip=198.54.127.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pappasbrent.com
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 736051800046;
	Wed, 17 Jan 2024 15:00:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
	s=default; t=1705521616;
	bh=YVcIYhmkjZDzczcsw0If+iQoXd/UI9stcIz62mPaVPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtPPLGUi2sxy5zPEQ45+tx8wpT2Kyjm8lc4idSwuV1jaXN3PLxOKr1uRndAw2QN4n
	 +Mp3v2BT4i1+77NusW+08hG7LRXDdaPVdGWgpLcqRbw3N9CNhszYvIlRIQb/jm2buS
	 j+onlQY5XNkHOWtUTyBsh4SF+BCA/xw61ETYbypLwcgtwAdBVo7jrc0kBxgdlhW0/N
	 WHuJJogZmUGptz+SuqBVjUMNIIx8hJsBtiMF3wHQCUFgeoiAp7XlCTHSXM9//vPPSm
	 lw/zN5TO22JTrpiQ1Z26+nS15QCSxpD87o0ae9So87/QdF0qZbhDL5CkZLBjZq4XHS
	 i2+sGnuVWVUTA==
Received: from pappasbrent.com (050-088-208-203.res.spectrum.com [50.88.208.203])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Wed, 17 Jan 2024 15:00:06 -0500 (EST)
Date: Wed, 17 Jan 2024 15:00:03 -0500
From: Brent Pappas <bpappas@pappasbrent.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: tx: Add __must_hold() annotation
Message-ID: <Zagxwx40ja4JRUQ2@pappasbrent.com>
References: <20240113011145.10888-2-bpappas@pappasbrent.com>
 <87sf31hhfp.fsf@kernel.org>
 <26d364547d3bbb04800877e899cfebe0e1ec4dc0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26d364547d3bbb04800877e899cfebe0e1ec4dc0.camel@sipsolutions.net>
X-Virus-Scanned: ClamAV using ClamSMTP

Thanks for the feedback Johannes. As I mentioned in my original email, I'm still
learning the RCU API, so I appreciate the insight from someone more
knowledgeable.

> Much better to put something lockdep_assert_held() or similar into the right
> places.

I'm not committed to using __must_hold(); would you be willing to accept this
patch if I change it to use lockdep_assert_held() instead?

> The function ieee80211_set_beacon_cntdwn() is called from a number of places
> in this file, some of which acquire RCU critical section, and some of which
> acquire no locks nor RCU critical section at all.

Grepping through tx.c, I see ieee80211_set_beacon_cntdwn() is invoked in three
places:

- Line 5285: Inside the definition of ieee80211_beacon_get_ap(), which is only
  invoked in critical sections (both directly and in another nested call).
- Line 5439: Directly inside a critical section.
- Line 5471: Directly inside a critical section (same as previous).

> I tried to fix this in sparse many years ago, some code even got merged (and
> then reverted), and if the experience tells me anything then that it's pretty
> much not fixable.

I'm sorry to hear that; a solution to this problem sounds very useful. I'm
currently working on making my own static analyzer for performing more checks
than what sparse currently provides. Since you've worked on this problem and
have deeper insight into than I do, what sort of checks would you like to see
added to a tool like sparse (besides checking whether specific locks are held)?

Thank you,
Brent

The 01/15/2024 14:13, Johannes Berg wrote:
> On Sat, 2024-01-13 at 08:32 +0200, Kalle Valo wrote:
> > 
> > >  static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
> > >  					struct beacon_data *beacon,
> > >  					struct ieee80211_link_data *link)
> > > +	__must_hold(link)
> > 
> > Oh, never seen __must_hold() before and looks very useful. So does this
> > work with RCU, mutexes and spinlocks?
> > 
> > In case others are interested, here's the documentation I was able to find:
> > 
> > https://docs.kernel.org/dev-tools/sparse.html#using-sparse-for-lock-checking
> > 
> 
> Except it's not actually useful, and looks more useful than it is. IMHO
> it's actually more harmful than anything else.
> 
> One might even consider this patch a good example! The function
> ieee80211_set_beacon_cntdwn() is called from a number of places in this
> file, some of which acquire RCU critical section, and some of which
> acquire no locks nor RCU critical section at all. Most of them nest and
> are called in RCU.
> 
> However, there's basically no way to get sparse to warn on this. Even
> inserting a function
> 
> void test(void);
> void test(void)
> {
>         ieee80211_set_beacon_cntdwn(NULL, NULL, NULL);
> }
> 
> will not cause sparse to complain, where this *clearly* doesn't hold an
> locks.
> 
> 
> Also, as we (should) all know, the argument to __acquires(),
> __releases() and __must_check() is pretty much ignored. I tried to fix
> this in sparse many years ago, some code even got merged (and then
> reverted), and if the experience tells me anything then that it's pretty
> much not fixable.
> 
> __acquires() and __releases() at least are useful for tracking that you
> don't have a mismatch, e.g. a function that __acquires() but then takes
> a lock in most paths but forgot one, for example. With __must_hold(),
> this really isn't the case.
> 
> And then we could argue that at least it has a documentation effect, but
> ... what does it even mean to "hold 'link'"? There isn't even a lock,
> mutex or otherwise, in the link. You can't "own" a reference to it, or
> anything like that. The closest thing in current kernels would be to
> maybe see if you have the wiphy mutex, but that's likely not the case in
> these paths and RCU was used to get to the link struct ...
> 
> 
> IOW, I find this lacking from an implementation/validation point of
> view, and lacking if not outright confusing from a documentation point
> of view. Much better to put something lockdep_assert_held() or similar
> into the right places.
> 
> As for your comment about RCU in ath11k (which points back to this
> thread): I don't find
> 
> 	RCU_LOCKDEP_WARN(!rcu_read_lock_held());
> or
> 	WARN_ON_ONCE(!rcu_read_lock_held());
> 
> very persuasive, it's much better to have it checked with
> rcu_dereference_protected(), rcu_dereference_check(), the condition
> argument to list_for_each_rcu(), or (in the case of wiphy) our wrappers
> around these like wiphy_dereference(). I cannot think of any case where
> you'd want to ensure that some code is in an RCU critical section
> without it actually using RCU - and if it does you have
> rcu_dereference() and all those things that (a) check anyway, and also
> (b) serve as their own documentation.
> 
> 
> Anyway, long story short: I don't see value in this patch and won't be
> applying it unless somebody here can convince me otherwise, ideally
> addressing the concerns stated above.
> 
> johannes

