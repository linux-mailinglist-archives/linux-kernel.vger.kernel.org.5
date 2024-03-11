Return-Path: <linux-kernel+bounces-98435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4AA877A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E451F21E39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD21C33;
	Mon, 11 Mar 2024 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="QiBDC3ez"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695C17D2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128569; cv=none; b=bvCQRLW7O1igA+jsd8ljsYaZA0/G21kTNrDK+6elA7Z8f9wopdB/dQ/H+4oatwyavEZlD+V9S4uAWGCNV4KXRn6PDJ/V+PUvYeiK8zI1dWfWHy90n6FLqVO41CuWnD0mjBECq0400ZPC5UYSUd3Vlvy92g9tTmmhFq2SjCGT9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128569; c=relaxed/simple;
	bh=nTj62qPuEPgCw8J7Jf3n7nB5xucwl9i5v865mvfsmaw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyWpQ7u8q0GSNrckYSqSFFjp0kJqQKa/XRwoRct0za9xOesUB+jZUAUVOOEGzYsym5PX9l9Z5IEFnzc9vFziZwRtbOTFhlGK2uD7t4ioyaVj1EGdWjmiMfF5i0tbC44KcrzFy6ym22tezQL6eAgk1LTKL2qDzbb4CGXCdkIR1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=QiBDC3ez; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710128556;
	bh=4JXa6hLg74UpGshYZU1AguiXPGhfRos4Ba7QkqRukZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QiBDC3ezm11b2Im4aNj21lpmPotKo4kokjq0TVuATxSAnR9akKYFkHxaTUHb3zVXW
	 StmmE4JOhS77ZwnsHVjFNZG+1PbktpCp91KiEW6LrUTi3/7opeCU9Rb7b97HDtk/Z6
	 WWHoV1BQFXuNn1N5gMELmOnqO10G7JkZ0DjErJNs=
Received: from localhost ([223.104.74.172])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id AA2BEEEA; Mon, 11 Mar 2024 11:42:34 +0800
X-QQ-mid: xmsmtpt1710128554tx9slqkvq
Message-ID: <tencent_9C4C2E93BF6E6F9A61B2C8B72B800839BD05@qq.com>
X-QQ-XMAILINFO: OKpEC/bXOl3KoZeQXg/7NFPrZ4XlfQnIMhpOScRXYy1jVk3PhopjBhGbOmp/QW
	 CJTBPYxQuetLW7lc0Rs/1paE99ASBOFRflhS7O/mwg6L48yIYHM7TS6VW5d+hG7u8mXCI1vWNu5I
	 BppiIrXGnN1iZuk2dkpQyKGyZv+kMIrhVItpV4N4zvMUoHI6HiJx0c4YoVom1OZlbmkKg+l36jnl
	 A0VG9mZG+XEdDcnZjkqNG9Kz4hCw7LwBLJsill6HBbr/NXbTsycR1MCn5YI5fVH48SBb4NtSxmCg
	 GdZxM8x+KAHLNRVZJXgGIo9OMV+UOQ5bTeHaZhPmlrAMBcGfn43klkP079uASn/UJQsT2aIGsKE4
	 a/Baksjbjkrobq+g56bBZUyIhye2DudDL76NasSVqo33PQSby60H50pl1I/pT2ejf2aTr46jaURq
	 3yMLP1y+8efqtEM03++UJ3mjVA/Rz8/VPyOH6KwfwYqhyzoJh0efgV+y82QHIE8ntN8Pn5iiEt1m
	 KQYM5xZBtd6TwczxzmeKiAJ2bIyTxCB+TXGBEvwfdGlnFWP05VeinbRSgEOzwRwGNwDhB6e15MpD
	 dD/OAwOzwwArFyovw59N0+GYsHqdscWNhC3Zq5+161y+37cPGmzkoRRUeux8l9rANuNeGIeUQFhV
	 LAiXv+45K8qGfZtWqEDrEifovc1Mozon/Ueyt493Rz85K7xYF0wvA7mwhC/MyLqo1DXIQ7owWb93
	 uGJ7zJy86bs/39RHsfjjticjJwmCIR5Rq6QC/JcUd9BWUx06n8ycJIWfuJRJgzT7DObJ1YFA7fLN
	 bL+c5rSBEL9s5vqqkYBg/hKvpr2voGeCaXHheiaAS4h9SgfbiNhOtExHW2LSbT77CVfejFnKtu4G
	 e9UzBa4nFNa5VuV75/2dKzCKAEStnIdtLUQi4B4F/olaacHm3NJUcN4u5S7Y+31Fut1YR1LcojOs
	 RMZfY/J3DomRACe65IdJ4o2CcyWEvL
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Sender: kenneth-lee-2012@foxmail.com
Date: Mon, 11 Mar 2024 11:41:26 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240311034104.7iffcia4k5rxvgog@kllt01>
References: <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>
 <ZeuFQdk/zcjkILbC@andrea>
 <tencent_454C12FBD6076C20C3955565E6D6354E4F0A@qq.com>
 <Ze0afrfXMe4oJ4ez@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze0afrfXMe4oJ4ez@andrea>

On Sun, Mar 10, 2024 at 03:27:10AM +0100, Andrea Parri wrote:
> Date: Sun, 10 Mar 2024 03:27:10 +0100
> From: Andrea Parri <parri.andrea@gmail.com>
> To: Kenneth-Lee-2012@foxmail.com
> Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
>  paulmck@kernel.org
> Subject: Re: Question about PB rule of LKMM
> 
> > > Remark that, in the CAT language, the identity relation ({(e, e) : each event e})
> > > is a subset of R* (the _reflexive_-transitive closure of R) for any relation R.
> > > 
> > > The link at stake, (P0:Wx1, P0:Rx), is the result of the following composition:
> > > 
> > >   [Marked]         ; (overwrite & ext)? ; cumul-fence*     ; [Marked]          ; rfe?            ; [Marked]
> > >   (P0:Wx1, P0:Wx1)   (P0:Wx1, P1:Wx8)     (P1:Wx8, P1:Wx8)   (P1:Wx8, P1:Wx8))   (P1:Wx8, P0:Rx)   (P0:Rx, P0:Rx)
> > > 
> > 
> > So the cumul-fence relation includes the same Store? This is hard to
> > understand, because it is defined as:
> > 
> >   let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> > 	po-unlock-lock-po) ; [Marked] ; rmw-sequence
> > 
> > There is at lease a rmw-sequence in the relation link.
> > 
> > I doubt we have different understanding on the effect of
> > reflexive operator. Let's discuss this with an example. Say we have two
> > relation r1 and r2. r1 have (e1, e2) while r2 have (e2, e3). Then we got
> > (e1, e3) for (r1;r2). The (;) operator joins r1's range to r2's domain.
> > 
> > If we upgrade (r1;r2) to  (r1?;r2), (r1?) become {(m1, m1), (m1, m2), (m2,
> > m2)}, it is r1 plus all identity of all elements used in r1's relations.
> > 
> > So (r1?;r2) is {(m1, m3), (m2, m3)}. If we consider this link:
> > 
> >   e1 ->r1 ->e2 ->r2 e3
> > 
> > A question mark on r1 means both (e1, e3) and (e2, e3) are included in
> > the final definition. The r1 is ignore-able in the definition. The event
> > before or behind the ignore-able relation both belong to the definition.
> > 
> > But this doesn't means r1 is optional. If r1 is empty, (r1?;r2) will
> > become empty, because there is no event element in r1's relations.
> > 
> > So I think the reflexive-transitive operation on cumul-fence cannot make
> > this relation optional. You should first have such link in the code.
> 
> In Cat, r1? is better described by (following your own wording) "r1 plus
> all identity of all elements (i.e. not necessarily in r1)".
> 
> As an example, in the scenario at stake, cumul-fence is empty while both
> cumul-fence? and cumul-fence* match the identity relation on all events.
> 
> Here is a (relatively old, but still accurate AFAICR) article describing
> these and other notions as used in Herd:  (cf. table at the bottom)
> 
>   https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/herd.html
> 
> Said this, I do think the best way to familiarize with these notions and
> check one's understanding is to spend time using the herd tool itself.
> 

Excuse me, May I ask one last question? I tried the herd tool on the
discussed example. But it seems it is not protected by the hb acyclic
rule. I can replace the linux-kernel.cat with lock.cat on the test:

	P0(int *x)
	{
		int r1;
		WRITE_ONCE(*x, 1);
		r1 = READ_ONCE(*x);
	}
	P1(int *x)
	{
		WRITE_ONCE(*x, 8);
	}
	locations[0:r1; x]
	exists (0:r1=8)

It can still ensure the P0:Wx execute before P0:Rx:

	Test test Allowed
	States 3
	0:r1=1; [x]=1;
	0:r1=1; [x]=8;
	0:r1=8; [x]=8;
	Ok
	Witnesses
	Positive: 1 Negative: 2
	Condition exists (0:r1=8)
	Observation test Sometimes 1 2

The example doesn't prove the hb rule is necessary. Is this
understanding correct? Thanks.

>   Andrea

-- 
			-Kenneth Lee


