Return-Path: <linux-kernel+bounces-96476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A19875CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB72B21878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C22C190;
	Fri,  8 Mar 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="IWHT8prZ"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0942206E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868164; cv=none; b=MFnZhKvt4t+VlF30ZFI4SMC2EjVQqisc8vo4C7HU5WOdg/3CYIfKBsn6irhByy0g9Z/jEYlr5HFD8uCfnjNpMpWcrARuLUq5GoGt6kORVUCgdHzFFGyZD8Pg1MhG7aquvN+ouRdBjwCqLrTLIuE5BKtL3jnqXbJP5odHfftTCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868164; c=relaxed/simple;
	bh=N1LcdT9YFlU2zvycug7Dn/0juEHxMXKluboRi+yLDFQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXyphJ4NB+M1LKY4esp/zYya3BKaXwQilgKs9Fwl3jMQaoCysfe7a9LCz2GEbxiKIb7/ZE3ohT4M0JzhX6SSeF2JekUamOjZ/GHJis/lEqOOUpb+HlKvbMrvKVXyFG2UpVoP480WHL8tj0L4f64kvusG5N+DfrlkTjkZDc/QRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=IWHT8prZ; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709867851;
	bh=slXgo+HOlUPrCb1TxJcdKdnvyfK0OpgNKTsBjp23Inc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IWHT8prZjvpzwixelSI4CaSewOFPqhFO3pMoz8034VJonhkt0fLzpO1hB6eYLJ+9+
	 Rh0MY+yLI68CJ91XbMTxWuiSlan2RPDT4NLGh1jbPhkfsA/f3eYeqzmptqsua4r32D
	 +HB2DvoTgyJzKvmf0B0pbau1ObqHtS/ZAfft5rDU=
Received: from localhost ([223.104.61.45])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 2DC1B072; Fri, 08 Mar 2024 11:11:28 +0800
X-QQ-mid: xmsmtpt1709867488tivk0zmnn
Message-ID: <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>
X-QQ-XMAILINFO: MIQUMGBCngpGsHw/U5Dd179VQ3iTXPldXhmUVn2fd3NuVpqyQ3w5KjycopU522
	 v+QSazWVZgjBuhJTsTDEQ89MU1GArIrm5nlGsq3hZecjtWTh44Q7A6JYLhQFYR+3JHsMWYLfJW/c
	 NbikDas75mvZbDPLSKuzGzy57o4M3DuRu9FJ+HRBb+A1viE9W5HRdjJGWOwIJhLj1YRZArpW/z9i
	 vzNBQRFiuVrbYZjJAm+JBU1wdoADfnWNZHzQoqHyCSW5+ioMHLN1Aqvgn9kYSdP1YGNhtF9zIkY0
	 1F4CobcMmXpnTt5dHR4GWanvy5eBGGkru+RkHay4D96G/KQYX4970dkJ18+fa0VVaVS0/eXENcOl
	 wMFfHaP/vK7qgcUbgfa06C0O0KUiz5GwDyezR0R/Fys7e6y3oZAPmi8w77ItRzonAKDnZi2Ytmi6
	 +5yMc5pq9AQ9jywLBPE6JzyWOI2EdJ1JLpom6GFyhuRVowd8X0B53lZ9+QVxdWcNzyI4xQgAoORy
	 YTmj56enXdRoTlnWRvq08V1dH8bOFksLgWBsDsQ2WLbqItaHDXhn5IPhqFNXNAr7wPsygYWK6lVh
	 083r4a3swOgvaY14eLNA/z+6SWnYL8h2uKwNoJ+23VyKTnqMrwef20xRXbl3I6zTlRmLig4jjz4n
	 et/b28rGMEvAJFEElwEJ1BvaC1HgYX2+nm6l/9HZpmLVYxVEEWg6W62kFCAM2SZSzfKh+qXNNpjX
	 uAMM1BdW/bZXQ0pvCFhh3XMhs9i7jhi3rczM+1mbnkKO4goyyaW0Wm5wq8mfc8LOXIlYqc0ZLL5m
	 mD/LW9P4lKPGJFW+JKbxIT1hDxXR6U2HvUP7d5dDp2VYXGV4VsKDvvQYMW+EOKHumDGAFbZ3Y+Li
	 Xh2MTIP4GNhSG9TXBTilmk5WStS34bhchbXmvRzL0GbyRtBUS0tuO9U0GmxrH+Wg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Sender: kenneth-lee-2012@foxmail.com
Date: Fri, 8 Mar 2024 11:10:21 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240308031001.gumudf4xcixxuued@kllt01>
References: <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoQvj3l6moF9KdQ@andrea>

On Thu, Mar 07, 2024 at 08:08:46PM +0100, Andrea Parri wrote:
> Date: Thu, 7 Mar 2024 20:08:46 +0100
> From: Andrea Parri <parri.andrea@gmail.com>
> To: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
>  paulmck@kernel.org
> Subject: Re: Question about PB rule of LKMM
> 
> > > I'd disagree with these premises: certain instructions can and do execute
> > > at the same time.
> > 
> > Can you give an example?
> 
> I think I'm starting to see where this is going..., but to address the
> question: really any example where the LKMM doesn't know better, say
> 
> C test
> 
> {}
> 
> P0(int *x)
> {
> 	*x = 1;
> }
> 
> P1(int *x)
> {
> 	*x = 2;
> }
> 

TBH, the concept "execute-before" gave me a lot of trouble when I read
explanation.txt at the very beginning. The name hints an absolute and
global timeline over everything. But that makes no sense because no one
can observe that order at all. So till now, I still need to translate
the concept to an order by particular observer , such as a CPU or the
memory system, for further understanding.

And speaking of example, can I ask another question?: 

In the "THE HAPPENS-BEFORE RELATION: hb" section of explanation.txt,
it uses the following example to explain the prop relation:

	P0()
	{
		int r1;

		WRITE_ONCE(x, 1);
		r1 = READ_ONCE(x);
	}

	P1()
	{
		WRITE_ONCE(x, 8);
	}

if r1 = 8, we can deduce P0:Wx1 ->coe P1:Wx8 ->rfe P0:Rx, this can be
explained with the operational model. But according to the definition of
prop,

  let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ; [Marked] ; rfe? ; [Marked]

The link should contain a cumul-fence, which doesn't exist in the
example.

This also makes me confuse on what explanation.txt explains: the
dependable rule/link deduced from operational model, or the physical
meaning of the concepts used in the cat definition?

Alan's discussion make feel the answer is former. If it is, my question is
closed. But I feel it should be latter. In this case, I think we cannot
just explain "it can be explained in the operational model";)

(CC Alan: I couldn't receive your previous email in this topic, I think
it is because I'm not a subscriber of lkml. I would be very grateful if
you could cc me in the follow-up email)

> 
> > >  FWIW, in the formal model, it is not that difficult to
> > > provide examples of "(not F ->xb E) and (not E ->xb F)".
> > 
> > That's because the xb relation in the formal model does not fully 
> > capture our intuitive notion of "executes at the same time" in the 
> > informal operational model.
> > 
> > Also, it's important to distinguish between:
> > 
> > (1)	Two instructions that are forced (say by a dependency) or known 
> > 	(say by an rfe link) to execute in a particular order; versus
> > 
> > (2)	Two instructions that may execute in either order but do execute
> > 	in some particular order during a given run of the program.
> > 
> > The formal xb relation corresponds more to (1), whereas the informal 
> > notion corresponds more to (2).
> 
> This appears to be the key observation.  For if, in the operational model,
> (not F ->xb E) implies (E ->xb F) then I'll apologize for the noise.  :-)
> 
> 
> > > > The new text says the same thing as the original, just in a more 
> > > > condensed way.  It skips the detailed explanation of why E must execute 
> > > > before W propagates to E's CPU, merely saying that it is because "W is 
> > > > coherence-later than E".  I'm not sure this is an improvement; the 
> > > > reader might want to know exactly how this reasoning goes.
> > > 
> > > The current text relies on an argument by contradiction.  A contradiction
> > > is reached by "forcing" (F ->xb E), hence all it can be concluded is that
> > > (not F ->xb E).  Again, AFAICS, this doesn't match the claim in the text.
> > 
> > That's why I suggested adding an extra sentence to the paragraph (which 
> > you did not quote in your reply).  That sentence gave a direct argument.
> 
> Well, I read that sentence but stopped at "These contradictions show that"
> for the reason I detailed above.
> 
>   Andrea

-- 
			-Kenneth Lee (Hisilicon)


