Return-Path: <linux-kernel+bounces-33073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491183641C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17899B27011
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED863D0A6;
	Mon, 22 Jan 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYFOdbuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D63C6B3;
	Mon, 22 Jan 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929006; cv=none; b=S7FpSoehodqe7qf+/CtmNGiCVzQYzvP4SW2KIBl7WqQnPSaPz5ziLQcyFahb1TQspWu+1e9sEQuF1jaxdpTHQHhWdfrYgSHw33lCogTsHnbM/1Lf4JIXwaik7JK1T/OdYGf3r3WJXfru9gMi3gaQbgqjyTv18FRqOZJ42JaLCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929006; c=relaxed/simple;
	bh=Ol96TTNYfOJdyv4nPvv9/24t5Z86jPnPqKam2MbKhfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQeY64b5hUHrxxbdpFg2r/ORw2Oe0bT6RMB3wsz/MgJYHfWYG0kfz2S7Ua6yXaVbIcMVeXa05if8dMZ9auufE/6xTR1Wb0NEmIE8O7qD7eR+6mQcWBGjOb0Zr3c1lQ98hPBX/fXbUVi9ctOjZ3z5IMc+60fXtcvmchGjRPcVVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYFOdbuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2BCC433C7;
	Mon, 22 Jan 2024 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705929006;
	bh=Ol96TTNYfOJdyv4nPvv9/24t5Z86jPnPqKam2MbKhfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYFOdbuyilxaaHOh5qzgYaJE+e7iG2+JYBD9R7IOieiz9dmxiaJLOmHrKgWnhcsTU
	 PkTsXJR437gYgDDHnKeH1bqpl34GUjexQmzCyB018vp68IzEfpYmaWz6t20LrGbtZ1
	 qPQyRsY7sSaPRYgBKY1c1O9DVrSLwhxWlHmxvDafWYd0WhDsn0o4XlQ/LIXNes3zWa
	 i5M5yEtOQTostafqOftsVA0iFEZMzj1CsacfJPur8aLwNAqCUTXHVObSSMM1zgL7xX
	 buKaYThBY/YM8gdm4JJ/+tSRRrQF3TNh4YJdxYtlq8qGzX3nTQoRAwjHIREOlyMj2m
	 TOnGwYy5RHApg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rRu48-0000000083I-261d;
	Mon, 22 Jan 2024 14:10:17 +0100
Date: Mon, 22 Jan 2024 14:10:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ath11k: checking RCU usage
Message-ID: <Za5pOIkQ0SN2XzHr@hovoldconsulting.com>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
 <87o7goxget.fsf@kernel.org>
 <ZTfgJCBxsNv3bVjv@hovoldconsulting.com>
 <87zfx98r6a.fsf_-_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfx98r6a.fsf_-_@kernel.org>

Hi Kalle,

On Sat, Jan 13, 2024 at 12:26:53PM +0200, Kalle Valo wrote:
> (old discussion, changing title)
> 
> Johan Hovold <johan@kernel.org> writes:
> 
> > On Tue, Oct 24, 2023 at 05:07:38PM +0300, Kalle Valo wrote:

> >> Thanks for the fixes. I really like using lockdep_assert_held() to
> >> document if a function requires some lock held, is there anything
> >> similar for RCU?
> >
> > Not really, but the checking is instead built into the primitives like
> > rcu_dereference() and enabled whenever CONFIG_PROVE_RCU is set.
> >
> > For some special cases, we have open-coded checks like:
> >
> > 	RCU_LOCKDEP_WARN(!rcu_read_lock_held());
> >
> > which similarly depend on CONFIG_PROVE_RCU or simply
> >
> > 	WARN_ON_ONCE(!rcu_read_lock_held());
> 
> I just found out that sparse has __must_hold():
> 
> https://lore.kernel.org/linux-wireless/87sf31hhfp.fsf@kernel.org/
> 
> That looks promising, should we start using that in ath11k and ath12k to
> check our RCU usage?

I see that Johannes already commented on this in the thread above.

I'm pretty sure smatch can't be used for this.

Johan

