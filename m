Return-Path: <linux-kernel+bounces-98535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDB877B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F036B1F21AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42AC11724;
	Mon, 11 Mar 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xODg88LG"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BE11711
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145301; cv=none; b=sPk+N/zu3N8jzQCFd2tIZEg8lp2HJBcUjUQzMV4xqT9vqVFqCvDbUowF/vL1JThS3lZGNYqo1jJwz3xscCyYzMTLi5VSuwJPmqVAjOAlSfjxyVvTEMVhK4rjzFdEYFEcBgcpUDw6uc80SzOIyhwz0aBg1mhtD6MYrpRtEQaJlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145301; c=relaxed/simple;
	bh=dQvCW975tggGjVquzNRKrqDhtKRUdKE/eqO9gB72/X8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csLuywv403Wg/UbgfXqOvxlawjoiHfvpu+ZBpcDHjrOzse0vTyBWPM2Y6eOykV2xyc5BFTqr3cLvgg9UDUcQlkTHm4u8Zibip3LK/2NLMoKkka3reOd7VZqMjrCEnSpYjgQzgSwg/+PsNT+rscPmJ450UjWoIELgafxS1t9a92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xODg88LG; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710145293;
	bh=qpfWx8/W6N9i9UJX+wQPon+8hnI+AIy92veQM3+qQio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xODg88LG8CgFc1o/c7WWoJ7B0u1ntMUOym3LFVnhu+CJrQ3bh9Aoq7b4+RrAFLKKy
	 ZlRdFcGrn/xXiaCND4UK/OcnJ26Z53b2x5xb2m1yRwwIQzsxHoyQJHMVx3hLzjyrNp
	 7PDbbPKu4T+bi/T4zT2LK9OZHUTfOSEkau53Mw0U=
Received: from localhost ([2409:895a:db44:11aa:5c5:a3b:3e34:9dfb])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 56001CDD; Mon, 11 Mar 2024 16:21:32 +0800
X-QQ-mid: xmsmtpt1710145292t58qkvieq
Message-ID: <tencent_10C974D8A4AAAF4C4009325CD95C264DDD06@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtfEcoTGbJyTK9G7bRuzS5/geGfjEQdS5Nk5yvn+pGUHFnmQ9HO1
	 B1SwQqr5Gv1dkQU86E+2gB6SRAU9Xj+8K+ifC3Rf0yEmJS5n3QxYyjNDw8Wd2eOhEwLRAAhWw3l9
	 fLExfdmMPmIJg0icZDdz5GX3vtrvMkGXkUoseIHsfM0t2LkZcrwu/OmErxqIECSo1A7OhdlskCyl
	 dSbdqpFeidwvtJp2Ea3FmTOOrYHjFcBXKgaqTjvKRVP3TFvCoKqYvJVUS/tBWLW46P0BKBrfLgBJ
	 LwGNdjgpoNctCMGacLZFMW6DthV64bWY3AAfa6uhXnVtw/cL0YfesdWCSuKqvoqhJcShf7esSgt/
	 fpc3ynY1m99dYOGYo8TsEAha5Iu3pQW7Vs+vxAllX/2DHwM+kethLz+pOqk9JpH5GInum58xvATj
	 JMh1BkcjC3fs0l7CxLstLplNtLOAoCMvqBvCkhgH36353r8n5WpRs9980Vhf9n8NMD81D4RQgU7/
	 CzQ6PMKmZVtBx1kYAJizqn1PT5LZ9mdFPYWfm5UZFGzv0QuCkoj4+nJWejRv0hri5EeVtwdFW/tb
	 N8AkwtxQSj+WWLuhPB343iz8Ol2xntuvWKXpA5eoHAS3fJ/hX1LE4DUUV9nqPiZj4CD7MjpFydMP
	 ad5cHelmkpCW5pmhesOMRUfKo/3eKZeE1K9CN7ijv5xwm8RuG27gmnEWUjrQNR2r8TTCq/MAaf7x
	 FMivVDD1ssY+wXkx7dLiwRSotoZNa6nz1wPw2VBrWmYU2aKGdAthDdhMdBFmLmI6Tm0Sek9v1L4J
	 9ecdhG3f3sXfoP7O35ZxuNuI1PR705Ekvyli/P7rEgoMu+MVGXlnM82eOJGeRL/DI/YB0Gu/801r
	 MLWhHsICGVqs7ATQkup5icVv02yFxzxHJ1zqybqAgrWHLQ2pzMJrx/8N5G80JBCAVQe74pcSsFQK
	 JuhSRY17IHxpRf9TXgRvOAPUL3R6qX88pSpE04ncM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Sender: kenneth-lee-2012@foxmail.com
Date: Mon, 11 Mar 2024 16:20:23 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240311082023.u7ddldyzxk7nyefi@kllt01>
References: <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>
 <ZeuFQdk/zcjkILbC@andrea>
 <tencent_454C12FBD6076C20C3955565E6D6354E4F0A@qq.com>
 <Ze0afrfXMe4oJ4ez@andrea>
 <20240311034104.7iffcia4k5rxvgog@kllt01>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311034104.7iffcia4k5rxvgog@kllt01>

On Mon, Mar 11, 2024 at 11:41:27AM +0800, Kenneth-Lee-2012@foxmail.com wrote:
> Date: Mon, 11 Mar 2024 11:41:27 +0800
> From: Kenneth-Lee-2012@foxmail.com
> To: Andrea Parri <parri.andrea@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
>  paulmck@kernel.org
> Subject: Re: Question about PB rule of LKMM
> 
> On Sun, Mar 10, 2024 at 03:27:10AM +0100, Andrea Parri wrote:
> > Date: Sun, 10 Mar 2024 03:27:10 +0100
> > From: Andrea Parri <parri.andrea@gmail.com>
> > To: Kenneth-Lee-2012@foxmail.com
> > Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
> >  paulmck@kernel.org
> > Subject: Re: Question about PB rule of LKMM
> > 
> > > > Remark that, in the CAT language, the identity relation ({(e, e) : each event e})
> > > > is a subset of R* (the _reflexive_-transitive closure of R) for any relation R.
> > > > 
> > > > The link at stake, (P0:Wx1, P0:Rx), is the result of the following composition:
> > > > 
> > > >   [Marked]         ; (overwrite & ext)? ; cumul-fence*     ; [Marked]          ; rfe?            ; [Marked]
> > > >   (P0:Wx1, P0:Wx1)   (P0:Wx1, P1:Wx8)     (P1:Wx8, P1:Wx8)   (P1:Wx8, P1:Wx8))   (P1:Wx8, P0:Rx)   (P0:Rx, P0:Rx)
> > > > 
> > > 
> > > So the cumul-fence relation includes the same Store? This is hard to
> > > understand, because it is defined as:
> > > 
> > >   let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> > > 	po-unlock-lock-po) ; [Marked] ; rmw-sequence
> > > 
> > > There is at lease a rmw-sequence in the relation link.
> > > 
> > > I doubt we have different understanding on the effect of
> > > reflexive operator. Let's discuss this with an example. Say we have two
> > > relation r1 and r2. r1 have (e1, e2) while r2 have (e2, e3). Then we got
> > > (e1, e3) for (r1;r2). The (;) operator joins r1's range to r2's domain.
> > > 
> > > If we upgrade (r1;r2) to  (r1?;r2), (r1?) become {(m1, m1), (m1, m2), (m2,
> > > m2)}, it is r1 plus all identity of all elements used in r1's relations.
> > > 
> > > So (r1?;r2) is {(m1, m3), (m2, m3)}. If we consider this link:
> > > 
> > >   e1 ->r1 ->e2 ->r2 e3
> > > 
> > > A question mark on r1 means both (e1, e3) and (e2, e3) are included in
> > > the final definition. The r1 is ignore-able in the definition. The event
> > > before or behind the ignore-able relation both belong to the definition.
> > > 
> > > But this doesn't means r1 is optional. If r1 is empty, (r1?;r2) will
> > > become empty, because there is no event element in r1's relations.
> > > 
> > > So I think the reflexive-transitive operation on cumul-fence cannot make
> > > this relation optional. You should first have such link in the code.
> > 
> > In Cat, r1? is better described by (following your own wording) "r1 plus
> > all identity of all elements (i.e. not necessarily in r1)".
> > 
> > As an example, in the scenario at stake, cumul-fence is empty while both
> > cumul-fence? and cumul-fence* match the identity relation on all events.
> > 
> > Here is a (relatively old, but still accurate AFAICR) article describing
> > these and other notions as used in Herd:  (cf. table at the bottom)
> > 
> >   https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/herd.html
> > 
> > Said this, I do think the best way to familiarize with these notions and
> > check one's understanding is to spend time using the herd tool itself.
> > 
> 
> Excuse me, May I ask one last question? I tried the herd tool on the
> discussed example. But it seems it is not protected by the hb acyclic
> rule. I can replace the linux-kernel.cat with lock.cat on the test:
> 
> 	P0(int *x)
> 	{
> 		int r1;
> 		WRITE_ONCE(*x, 1);
> 		r1 = READ_ONCE(*x);
> 	}
> 	P1(int *x)
> 	{
> 		WRITE_ONCE(*x, 8);
> 	}
> 	locations[0:r1; x]
> 	exists (0:r1=8)
> 
> It can still ensure the P0:Wx execute before P0:Rx:
> 
> 	Test test Allowed
> 	States 3
> 	0:r1=1; [x]=1;
> 	0:r1=1; [x]=8;
> 	0:r1=8; [x]=8;
> 	Ok
> 	Witnesses
> 	Positive: 1 Negative: 2
> 	Condition exists (0:r1=8)
> 	Observation test Sometimes 1 2
> 
> The example doesn't prove the hb rule is necessary. Is this
> understanding correct? Thanks.

Sorry for disturb, please ignore this. I think the context just to
explain what is prop, not mean to say it can ensure the order.

> 
> >   Andrea
> 
> -- 
> 			-Kenneth Lee


