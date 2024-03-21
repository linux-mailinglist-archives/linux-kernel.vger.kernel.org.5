Return-Path: <linux-kernel+bounces-110037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E37988592A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09305284BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC983CB8;
	Thu, 21 Mar 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IupoIiaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE91CA98;
	Thu, 21 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024476; cv=none; b=SXU7GvvVspwwhZzOkfvyXnZJ0geDcLDEKa52el5gM83TVacFPTwG8kl+Il/ihMsgR3xFsNMxMAFzvDencj29o3/2XRdXSaDyNiQRp2gfk9YK3E3auUSQE6rsFmJNpkF6W4xj4PCcfXdLQm+utu+i1z/6HGwzXHXuFEvs7B2GjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024476; c=relaxed/simple;
	bh=uPi2SyODpiqaI8VmD98/guq+ThG0Mi4w05ogyWV3xJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWPny8evDdfY6VtiiyoqvI3H7eIsc9Uf0Dxn7/+fG99T8lLpZJ6PfTxYwg/Ur22P6cdyVgOpe0SPieUL3nEBT950mNo9grV9R2Q4BOWAnvCrMVCCYu3Y1dJiowJNmjNKo5ZlWj48MpHcA031CRPtcPdaClP6lK9KZiRP94WPWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IupoIiaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA2CC433C7;
	Thu, 21 Mar 2024 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711024475;
	bh=uPi2SyODpiqaI8VmD98/guq+ThG0Mi4w05ogyWV3xJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IupoIiaHXt1bBeWUwRR2h0ZjiSYxXu9kh728RvPTwabwWfDuB7xH3kwqatygCA4Ai
	 Rl+l+jiG+9MEbK2+3kHQ2a/oGHQ4fcHIXvPH0o7a+R8Yf0qvhk2hojF6Iyz2kZPheN
	 JPdhCG0bnpEya4nF1xKjfC1zClkKqYJyXYnjDhpeZeT9fM6quuiP/fYwMDwM8ftbix
	 +ZfKjgwyzsbBYUv1mNfF6oDVaoCfeS0ph9t40fmHitKPuS/HiypF3NLeyy9nk4JX9f
	 XbXESOHjB2BAoW1ZahyOwoX9TOhlwi9O93jcZ9IZZhNCj3wSmghnP7hFEnF0PGVJk1
	 eGsyDxiSNb8VQ==
Date: Thu, 21 Mar 2024 12:34:31 +0000
From: Simon Horman <horms@kernel.org>
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	fabio@redaril.me, linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <20240321123431.GB356367@kernel.org>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
 <20240319120625.GI185808@kernel.org>
 <ZftkmQfna3HIyYal@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZftkmQfna3HIyYal@fedora>

On Wed, Mar 20, 2024 at 11:35:05PM +0100, Francesco Valla wrote:
> 
> Hi Simon,
> 
> On Tue, Mar 19, 2024 at 12:06:25PM +0000, Simon Horman wrote:
> > On Wed, Mar 13, 2024 at 11:34:31PM +0100, Francesco Valla wrote:
> > > Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
> > > 15765-2) stack.
> > > 
> > > Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> > 
> > Hi Francesco,
> > 
> > As it looks like there will be a v2 of this patchset
> > please consider running checkpatch.pl --codespell
> > and addressing the warnings it reports.
> > 
> 
> Will do before v2, thanks for the suggestion.
> 
> > ...
> > 
> > > +Transport protocol and associated frame types
> > > +---------------------------------------------
> > > +
> > > +When transmitting data using the ISO-TP protocol, the payload can either fit
> > > +inside one single CAN message or not, also considering the overhead the protocol
> > > +is generating and the optional extended addressing. In the first case, the data
> > > +is transmitted at once using a so-called Single Frame (SF). In the second case,
> > > +ISO-TP defines a multi-frame protocol, in which the sender asks (through a First
> > > +Frame - FF) to the receiver the maximum supported size of a macro data block
> > > +(``blocksize``) and the minimum time time between the single CAN messages
> > > +composing such block (``stmin``). Once these informations have been received,
> > 
> > nit: Once this information has
> 
> I never grasped the usage of "information" in English, which is not my
> first language. I'll make this correction here.

I can't explain it properly, but my basic understanding
is that in English information is non-countable and thus has no plural.
Water is another example of a non-countable noun.

> > > +the sender starts to send frames containing fragments of the data payload
> > > +(called Consecutive Frames - CF), stopping after every ``blocksize``-sized block
> > > +to wait confirmation from the receiver (which should then send a Flow Control
> > > +frame - FC - to inform the sender about its availability to receive more data).
> > > +
> > 
> > ...
> 
> Thanks for the review!
> 
> Regards,
> Francesco
> 

