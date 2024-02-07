Return-Path: <linux-kernel+bounces-56686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1084CD98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FDC28251B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C617F49F;
	Wed,  7 Feb 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4I3/AT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E425A118;
	Wed,  7 Feb 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318225; cv=none; b=WzKhQsOsuEtQ1Q6Mx4WuhDfjKxXu300C+OiKpV6suRju/bR25N1ZfiagC8RRy9inogCh1Eo4PegzDdCiH7IjcT5kU4pKlCBD8TVO5ntccZ9febQvjAweWAXfSwtvMdda5oqxUmtgp674ySsz2HIOybU6v1JOl5lX8QOq72bhTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318225; c=relaxed/simple;
	bh=HgWvn5bAM4Im/qqGraSiL8Ix3OSmzKgABaZhyzWAiKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBt8NjLKudW/H1QkrN99cBxZhyf+m2OnXsxkdEPOwfIACb1ulHulAuvL7kjx5P/U6UB4mL38CTk7rP35Gv3NLH7/Lb5uxvOeMTYGIyY9kUpDm6F7dydoy7REHGDbTGICtiNk3S7MAsQg8QWbxDbsygxEGGWKK+oTf6azjpd5qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4I3/AT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C766BC433F1;
	Wed,  7 Feb 2024 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318224;
	bh=HgWvn5bAM4Im/qqGraSiL8Ix3OSmzKgABaZhyzWAiKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4I3/AT4d/5kejR4u5TiWh8m1He0YasYGQJiNftNfXfbHjKkuYGUtVpL6iPzskJOQ
	 r5dX6Vfsb0rEERFPG+F+RNbxMrstoUDJURRCTulxaBfnpYES70bWWf747850ptkUou
	 JtjqARFRlU/52AW0t/4rHZWfQfAMCecINeS6OsNteqpx1d29yjOBBmz6DY9mrn1IEF
	 bTByxUceRMOrpgWd5sRsk8RqV+KOuj4f9GnzyG385X0yq46oWSUPBGDHH95tsvbnLY
	 6fHEmH7tiZCzxUMhLEKdIyVwP/+CT/afS0ZRH9v2PASWXpqQX5Ten9/8JOP79fA4wx
	 pc0oMmfXOEa3A==
Date: Wed, 7 Feb 2024 07:03:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Leon Romanovsky <leonro@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>, Aron Silverton
 <aron.silverton@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240207070342.21ad3e51@kernel.org>
In-Reply-To: <20240207072435.14182-1-saeed@kernel.org>
References: <20240207072435.14182-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 23:24:30 -0800 Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Recap from V3 discussion:
> =========================
> 
> LWN has published an article on this series aptly summarizing the debate.
> LINK: https://lwn.net/Articles/955001/
> 
> We continue to think that mlx5ctl is reasonable and aligned with the
> greater kernel community values. People have pointed to the HW RAID
> miscdevices as a good analog. The MD developers did not get to block HW
> RAID configuration on the basis that it undermines their work on the
> software RAID stack. Further, while there is a superficial similarity to
> the DRM/accel debate, that was grounded in a real concern that DRM values
> on open source would be bypassed. That argument does not hold up here as
> this does come with open source userspace and the functionality mlx5ctl
> enables on lockdown has always been available to ConnectX users through
> the non-lockdown PCI sysfs. netdev has been doing just fine despite the
> long standing presence of this tooling and we have continued to work with
> Jakub on building common APIs when appropriate. mlx5 already implements
> a wide range of the netdev common interfaces, many of which were pushed
> forward by our staff - the DPLL configuration netlink being a recent
> example.

I appreciate Jiri's contributions (and you hired Maciej off of Intel at
some point) but don't make it sound like nVidia lead DPLL, or pushed for
a common interface :| Intel posted SyncE support. I asked them make it
a standalone API family:

https://lore.kernel.org/netdev/20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/

Vadim from Meta joined in and helped a lot based on the OCP time card.
Then after some delaying and weird noises y'all started participating.

> mlx5 ConnectX control misc driver:
> ==================================
> 
> The ConnectX HW family supported by the mlx5 drivers uses an architecture
> where a FW component executes "mailbox RPCs" issued by the driver to make
> changes to the device. This results in a complex debugging environment
> where the FW component has information and low level configuration that
> needs to be accessed to userspace for debugging purposes.

You don't explain anywhere why addressing the challenges of using
debugfs in secure environments isn't the way to go.

Also you keep saying debugging purposes but the driver is called
"control misc driver", you need to iron out your narrative just 
a bit more.

> Historically a userspace program was used that accessed the PCI register
> and config space directly through /sys/bus/pci/.../XXX and could operate
> these debugging interfaces in parallel with the running driver.
> This approach is incompatible with secure boot and kernel lockdown so this
> driver provides a secure and restricted interface to that.

[snip]

>     i) mstreg
>       The mlxreg utility allows users to obtain information regarding
>       supported access registers, such as their fields

So the access mstreg gives over this interface is read only? That's
what your description sounds like, but given your complaints about
"inability to add knobs" and "control" in the name of the driver that
must be false.

> Other usecases with umem:
>   - dynamic HW and FW trace monitoring
>   - high frequency diagnostic counters sampling

Ah yes, the high frequency counters. Something that is definitely
impossible to implement in a generic way. You were literally in the
room at netconf when David Ahern described his proposal for this.

Anyway, I don't want to waste any more time arguing with you.
My opinion is that the kernel community is under no obligation to carry
your proprietary gateway interfaces. I may be wrong, but I'm entitled
to my opinion.

Please do me the basic courtesy of carrying my nack on these patches:

Nacked-by: Jakub Kicinski <kuba@kernel.org>

and CC netdev, so I don't have to respond again :|

