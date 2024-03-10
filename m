Return-Path: <linux-kernel+bounces-98106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19535877536
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2A31C2137E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3810A26;
	Sun, 10 Mar 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gLbazWrr"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFF101D0
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710040008; cv=none; b=kegTJhiyq19LGXT/CtuiQQsBMuwUNQiHKg1P3WdmAx9S5xEmY+CF+Vvc+1BztNjaM/T4euEeXFW4QftR9mfsCM2cOySzw3GrEesBhe2YVhVBFjqp5hzNvpfA1AbyeEzLqLVAZBubF/isAJQg+kDxpnOiHDyRhxpIzj34Sc9WDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710040008; c=relaxed/simple;
	bh=wizKxLTJMNNQfFox+kFF6DFybaHbVVZA5bl4Ma2FMoI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXX1Aleyix5uyqWpDkf1sr7afS1DVveDT6tJ+yPSUmwfSx/9ZnYFkw+kk84ouCpGsFOjQUhLqHVOSMmWlKZCqn/x7VsfYlow9kvaYFO79acthJV2d+OM48IehOHuqALHZe2Fe1JJHnccfM5QQ2u4Y+7Ttr3VtDKbwZBHZSIlzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gLbazWrr; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710040002;
	bh=AZgBleopdyDumfg6slYODc2H2MaeKhMLqaENR12d8HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gLbazWrrDbzdbMxbvYQZ8ecHupun/t8voC0WO9cCyv0ZUELoCK9fnrml2BvYnrnDZ
	 HF+mQuglyWODqlANlTs93MmrpoH95WfdNkf+pFGXzI53dZ+59kKds8IkYCWGmQfbEs
	 rdgZmoXCIKS4nE3tboiZcn6XmMC2ClBcg2jFnlyA=
Received: from localhost ([14.216.39.146])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id D5C34C41; Sun, 10 Mar 2024 10:53:28 +0800
X-QQ-mid: xmsmtpt1710039208twophpu22
Message-ID: <tencent_6175BDD3A69360BE460116C8CE650E992108@qq.com>
X-QQ-XMAILINFO: Ma+X2EIxQOjIwxExvD5jNSAESq47IVp64bo1SIbcwONW6byWlRSBW41e2pTaZX
	 8MSxYRUu4xzau9l8n7FbFDbx63ciV/CKj+789r14Tc70HDO4n0p/hVv4p0qh423d6VD+7JTIExi4
	 XtYZsuDNg6o9PLkFPEcX9jrhXys3X/KBvrvaXF6djKGykenxIF6ClI1qSuV1/ZWNbvklPUrHQUbo
	 tTlSomIBVkK5HF1D3wJiW1o+JzkAg63RHwUrIXv895xj3EEh+FGnxXNxbXa4T0RT1NkWUxNwiSoS
	 HvWOhp1j1KoFpG1tK6QeBbQgODhQWcs+wPoKaatDqtsudRPjDUM/tFv3Seb1yfpzgqKYHi2VhVi/
	 E/8j268ZCP2Yv43aJ9D7cTmwJh7t+BbCviDhtzAfL5evI1g34pGEhpeTfkasmA/SzsiDXDYUo++G
	 0idnZ4OpwxE3U4RjLJPB6+MuLYj9YmrHbf79nZYopmOcMGJJUkBaAOBApG9jxkWCkyQ3HzwuTzWQ
	 hnklrXpiF3aphP1yv+MDasAWXTmsv/6pCRMJDUfrG7i6twu2NlMraz7S8RfFqBLwJrvYrlggr60D
	 ARaX9r41ZzGgsUk0o034XD7S/pDqv45oyYHhCnjeviAcjYhwuHxumxuXn+HgQ66daAZb9mUA2hYe
	 o8Z8k6QB7s7d4qptlMtSt11FQqeG7LE6rWaZdgKIHTduzkeWz+xv/WBFjry0ULxumet3+XZkfMYu
	 2rFv8VsNcBCZv/E3Uspyni4IML3mBiBTkpq9HCKRL1GdI3RatUecDB+c8aKHkfngYLfTOX5ErK5q
	 Nfydo1IoYoP0y1iuTHzI9zyFahY3MlA5OzKFTjeD9OQlFxhENVQYsBPpzIaT9vKAn9LXnJGZIu8+
	 Vd80kqdEfDkd5K093lluzT0+PvStwPf/DRtkKVoBPQsHxQT/9h6oParCUQG0dhDSgouhPxIQPM2P
	 0KVWliAtHu2I1h8had+HwM35L0NV/y
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Sender: kenneth-lee-2012@foxmail.com
Date: Sun, 10 Mar 2024 10:52:20 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240310025220.2v6f66c2r67bjmb4@kllt01>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Ah, thank you very much for the link. The information is even not in the
herd7 manual. That's way I following the understanding from some mathematical
text such as: "The reflexive transitive closure of R is denoted R∗, and
is defined as the reflexive closure of the transitive closure of R".
It doesn't rely the total event set (S).

I will spend more time to try the herd itself. Thanks.

-Kenneth

>   Andrea


