Return-Path: <linux-kernel+bounces-97782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCF876F58
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE82A1C20C9C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164134545;
	Sat,  9 Mar 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OCykpqa9"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902B1E4BF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709963400; cv=none; b=scvvHqjFhR2P3YZtPe42ky503h1Ichezwx4EcUn6+eDs2+CQzbzR2yKQzheR7zCq/rFVBaF+PAJw95eO4K0PH6uGsgPBSsvwqkkY5tmi+Kn4IE2Ra39JY0CfTXEA0miSKIOCr/9dzTMXXVKyqWwYjnawN92VB4PpGjVZ+51w6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709963400; c=relaxed/simple;
	bh=Sf01tby/HsI0x6djHx9YKGING5/ChXguT5bMR/VsmFI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmR1NE009FmhK4BBV307z/EOYHd21o8MKlxoL8jcTZYfkp1HeuxFK15yUbn+2Zqrc0w60Fj9TJlx/c7UkwNU2V4CBDw+LAIMDMB82qLJ4J3A1cW4Di1RD9AxUaFz6MTx+IRPVEduDMpuK5QQOxMGMWG2YIH3XdH67OjOPomXcmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=OCykpqa9; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709963090;
	bh=pCLjBaeiPVFwIzRBB35XWHwHENyvOQLiNixCS1/03hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OCykpqa9V5//aeyyebI1EkUcn1wR01CJlMgh5i+LmA5Lo8vSdzSLXPT5hDkcfh7Ml
	 HKVhNZp4igqoKxfd77xTTXHNR8YrTgAIg+GcG6apn0XlyNWpQIbUCsJotUB5d3YvkD
	 tjp6oFV0733lKTkoz39c8hqUuhgYsGJqJUZlLKuY=
Received: from localhost ([124.240.57.156])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id B313CCA0; Sat, 09 Mar 2024 13:44:49 +0800
X-QQ-mid: xmsmtpt1709963089tpq18eyb7
Message-ID: <tencent_454C12FBD6076C20C3955565E6D6354E4F0A@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1j1j9H9bNeiVdK2EQnxlnDGFZTXzqEmJbmdF6EckqrYj2hq2lLR7
	 /ghc8++F+/puNc1UZTVpXonuIIeDpewGcgIQijv7iE9u4z5arUR1oCP9vyw8L0g1UKC9ZSgnVvVJ
	 jbViqRNTETEyP0/GRmG/YiETZnZDk1tG2MqS4Y2AtKvrGQ9AlxsyG6thbHlwJIuphgxXEUJYUXJ0
	 bk4rFXZSEEYmRcAHfFMdsSCRmbd8Bq3TzaW7/pst93ZmduBp2Tdd4BzxcsRu7irt2lO4vtuJutbe
	 F6dLxS1do7R2oBgI8JBhyfqOkoNRGcRK1SEHpzzkSl3eTcpT/vywd1899qIXzAd1CsPssOGGNyMc
	 1IC87NUfvIiSRUOrWEiQmd1YjpHDxjJIsIMcqVCEOrSjMw/g+900yBhOdlwZn56iA4Arbb+DB91q
	 SguQUtPKJvuN0rUA6W5VxGtMVd1Aw31s/XgLe78vJUxiRUdQQoTaRqRbcM56JNCV0SNlDbaBMLQV
	 oz6mvUAfNv3f8orewd66OitXwJRFe93/+/FCk5zlWrhfB+/Z9TFmTodDAaFnrOBNQqn/Pz/KT/Xc
	 uZqRvXrhK0mbmZ6iRQQuSgQweFuSvxyMusNBdvjjEX/urBWcTDMHF41pCW3giZZrgDwzZfJafOA1
	 au2B/qLux9MZNNBDvkBUBMvUCeoapoqtAiH67wXrrO9o8RiS5O7Br8x/hX5uQAyIPitarmQrSucx
	 nr8a1Gj2Mr7fYrp5Q/oCn+Es13pY/Xk2vWs+ND/SvLevvbQsCeRLhMxG3UeDHIlv79q+oh0GXXUp
	 0mryKnlxOPe87tgIPAfMA1ooJF7LiP9nn52R36ccKc65WAI4gTWRSG8qC3Ab+D4GsUzB6UpD6orj
	 duSLR2Tq/8usYQCyvy2TLa6ziLdXxH//sQGNSABjgyTE5woOGF3HmtY2X72BU9QSodnX9PKOriRA
	 HmrAdB+nNovpzaQUWQTela4Ka2BKD+
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Sender: kenneth-lee-2012@foxmail.com
Date: Sat, 9 Mar 2024 13:43:41 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240309054341.kjypsfuyosqpvvr3@kllt01>
References: <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>
 <ZeuFQdk/zcjkILbC@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeuFQdk/zcjkILbC@andrea>

On Fri, Mar 08, 2024 at 10:38:09PM +0100, Andrea Parri wrote:
> Date: Fri, 8 Mar 2024 22:38:09 +0100
> From: Andrea Parri <parri.andrea@gmail.com>
> To: Kenneth-Lee-2012@foxmail.com
> Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
>  paulmck@kernel.org
> Subject: Re: Question about PB rule of LKMM
> 
> > In the "THE HAPPENS-BEFORE RELATION: hb" section of explanation.txt,
> > it uses the following example to explain the prop relation:
> > 
> > 	P0()
> > 	{
> > 		int r1;
> > 
> > 		WRITE_ONCE(x, 1);
> > 		r1 = READ_ONCE(x);
> > 	}
> > 
> > 	P1()
> > 	{
> > 		WRITE_ONCE(x, 8);
> > 	}
> > 
> > if r1 = 8, we can deduce P0:Wx1 ->coe P1:Wx8 ->rfe P0:Rx, this can be
> > explained with the operational model. But according to the definition of
> > prop,
> > 
> >   let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ; [Marked] ; rfe? ; [Marked]
> > 
> > The link should contain a cumul-fence, which doesn't exist in the
> > example.
> 
> Remark that, in the CAT language, the identity relation ({(e, e) : each event e})
> is a subset of R* (the _reflexive_-transitive closure of R) for any relation R.
> 
> The link at stake, (P0:Wx1, P0:Rx), is the result of the following composition:
> 
>   [Marked]         ; (overwrite & ext)? ; cumul-fence*     ; [Marked]          ; rfe?            ; [Marked]
>   (P0:Wx1, P0:Wx1)   (P0:Wx1, P1:Wx8)     (P1:Wx8, P1:Wx8)   (P1:Wx8, P1:Wx8))   (P1:Wx8, P0:Rx)   (P0:Rx, P0:Rx)
> 

So the cumul-fence relation includes the same Store? This is hard to
understand, because it is defined as:

  let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
	po-unlock-lock-po) ; [Marked] ; rmw-sequence

There is at lease a rmw-sequence in the relation link.

I doubt we have different understanding on the effect of
reflexive operator. Let's discuss this with an example. Say we have two
relation r1 and r2. r1 have (e1, e2) while r2 have (e2, e3). Then we got
(e1, e3) for (r1;r2). The (;) operator joins r1's range to r2's domain.

If we upgrade (r1;r2) to  (r1?;r2), (r1?) become {(m1, m1), (m1, m2), (m2,
m2)}, it is r1 plus all identity of all elements used in r1's relations.

So (r1?;r2) is {(m1, m3), (m2, m3)}. If we consider this link:

  e1 ->r1 ->e2 ->r2 e3

A question mark on r1 means both (e1, e3) and (e2, e3) are included in
the final definition. The r1 is ignore-able in the definition. The event
before or behind the ignore-able relation both belong to the definition.

But this doesn't means r1 is optional. If r1 is empty, (r1?;r2) will
become empty, because there is no event element in r1's relations.

So I think the reflexive-transitive operation on cumul-fence cannot make
this relation optional. You should first have such link in the code.

-Kenneth

>   Andrea


