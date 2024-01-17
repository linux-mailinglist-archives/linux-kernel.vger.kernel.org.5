Return-Path: <linux-kernel+bounces-29034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D90883074A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F1CB244A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F220305;
	Wed, 17 Jan 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mReCdR3y"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7020307;
	Wed, 17 Jan 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499107; cv=none; b=CPXvm05fv7fnPvDUEVkJSFAyouyQkYSEQWKOKL80+spMAXLjD66NZoxwhqClOP2sWxCT0QMBRSIa+JcDBc7QCj6txxFOuoTopWjNC2+443I2Toa8l8bOttMb2I2W/ArpVlr12VECuKE8F4kzHUCotw/Y/oOt//r6mp0ILx251uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499107; c=relaxed/simple;
	bh=fw3EFkSFoNZMhgVVD0KTydnt4Rph+LxXHcYKbBhRCKQ=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=epxWXm9rduZYrLsMwqsWY/ePWmf9g6CulPmLbhSiPNP9QhO9J7rNdFiD1pw0GLwpEkRBcUrknyRFQ80GTp2bB7EmyKUNMdReZB/kl+Z5jBo6tkOv0oJKJLizO+YldsqepawPBGgl91C+3cvzJKyagOaTcUPjnhCJL6otZcEHCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mReCdR3y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4iSN00Bbyzad9qZCJAnMWF+JC2sua8wUcU9A7Wh2GeU=; b=mR
	eCdR3yAGOSjx9JiJmLM2Jgs/tLnJtbU0oO+nRSBqctbyo5Fwg17In7xrPBZWd5CF8uPJor4kfGu4X
	a5JPQh2pbb+iloBCD+6vX/CDvFQKRVgdvvvxgrHZ9obXzoLu/1fEbxsXZKULcmBu/evkjYaTSwHB/
	bQ0qbwjpe6yYaI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQ6De-005PBv-0Z; Wed, 17 Jan 2024 14:44:38 +0100
Date: Wed, 17 Jan 2024 14:44:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, nic_swsd@realtek.com,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down
 fixup
Message-ID: <2c590117-96fa-4e0b-84bd-9e3ea138d93b@lunn.ch>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-21-sashal@kernel.org>
 <20240116174315.2629f21c@kernel.org>
 <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>

On Wed, Jan 17, 2024 at 11:30:53AM +0100, Mirsad Todorovac wrote:
> On 1/17/24 02:43, Jakub Kicinski wrote:
> > On Tue, 16 Jan 2024 14:38:47 -0500 Sasha Levin wrote:
> > > Mirsad proposed a patch to reduce the number of spinlock lock/unlock
> > > operations and the function code size. This can be further improved
> > > because the function sets a consecutive register block.
> > 
> > Clearly a noop and a lot of LoC changed. I vote to drop this from
> > the backport.
> 
> Dear Jakub,
> 
> I will not argue with a senior developer, but please let me plead for the
> cause.
> 
> There are a couple of issues here:
> 
> 1. Heiner's patch generates smaller and faster code, with 100+
> spin_lock_irqsave()/spin_unlock_restore() pairs less.
> 
> According to this table:
> 
> [1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook-1c.2023.06.11a.pdf#table.3.1
> 
> The cost of single lock can be 15.4 - 101.9 ns (for the example CPU),
> so total savings would be 1709 - 11310 ns. But as the event of PHY power
> down is not frequent, this might be a insignificant saving indeed.
> 
> 2. Why I had advertised atomic programming of RTL registers in the first
> place?
> 
> The mac_ocp_lock was introduced recently:
> 
> commit 91c8643578a21e435c412ffbe902bb4b4773e262
> Author: Heiner Kallweit <hkallweit1@gmail.com>
> Date:   Mon Mar 6 22:23:15 2023 +0100
> 
>     r8169: use spinlock to protect mac ocp register access
> 
>     For disabling ASPM during NAPI poll we'll have to access mac ocp
>     registers in atomic context. This could result in races because
>     a mac ocp read consists of a write to register OCPDR, followed
>     by a read from the same register. Therefore add a spinlock to
>     protect access to mac ocp registers.
> 
>     Reviewed-by: Simon Horman <simon.horman@corigine.com>
>     Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>     Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Well, the answer is in the question - the very need for protecting the access
> to RTL_W(8|16|32) with locks comes from the fact that something was accessing
> the RTL card asynchronously.
> 
> Forgive me if this is a stupid question ...
> 
> Now - do we have a guarantee that the card will not be used asynchronously
> half-programmed from something else in that case, leading to another spurious
> lockup?
> 
> IMHO, shouldn't the entire reprogramming of PHY down recovery of the RTL 8411b
> be done atomically, under a single spin_lock_irqsave()/spin_unlock_irqrestore()
> pair?

Hi Mirsad

Please take a read of:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Do you think this patch fulfils these criteria? In particularly, "It
must either fix a real bug that bothers people...".

I agree with Heiner, this appears to be just an optimisation,

     Andrew

