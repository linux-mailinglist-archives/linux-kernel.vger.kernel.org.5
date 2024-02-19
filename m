Return-Path: <linux-kernel+bounces-71066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C954285A036
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B161C20F10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98E25611;
	Mon, 19 Feb 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QHVceFGW"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356424214;
	Mon, 19 Feb 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336339; cv=none; b=PYADhfB7G2P29153kDmYMvmzNv6JERmpBHlFrh8KRYyHLUX4h2788QRlbUXAu2fYuBQzIAC4rY4DgvOMmBXRMZaY1S7U0n0TvvcAXqMxvwbZ2cOI1tesHG5ApCVpfXiR/1NAqx2t0DMiBkRZ90kHx3mYwkN4KRNif2rj9xm87iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336339; c=relaxed/simple;
	bh=0r8rtyYqubTWd+IgpH65h5Wl/vnfwGH6qcCT7Pfn7r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWP3n0o2hChkkKfjDSY7F7UZrI8EWKOlv0pMyDnlvkxYy8jp9XYWZnwGJSkBHuOqqUCDyljpS30CjVAEO0zMqn7/jukNy8mEmX85k8OGHsygA3ngCgPpitXtcXdf/AePrwhFu9vpoFnhixhRijXs4aSGDTpLREk73pb69jz7344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QHVceFGW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SAEbIdpnxZJOic0yg9YQ6ZUXZebSJ8Li6l2q0fhYTfo=; b=QHVceFGW6VtzeR2rM64t7MpGEC
	nyRWXzKzrKRue662A60xIZBsslQ+JApOwbvWHUg7ulSp9I7uxkwLdqVnlWsn0EJdScLJqTAAe4j9p
	ZhJR5TlYD2mMj8G5Hp9jbpRsZF2+jDo+7k8+/EKc6qDVxuAQlCOtlIgAWzIWl4e/sIxezwFCbZkr7
	hYiN5p9GpfE0L9qOaknDySdeQ7PwNKZL2osMiPnx6jF8tnkfP6ONDp7GsUispu5WgqVlPJh/WXVWZ
	h4OBL9qSSVRyRHrGEH+PLW84VCetw8Vuk3rR5Ux7KuXyKCJmIjwSFW5IsPVbTYxC8JD7nS3PSHgO+
	7cMJhiCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34404)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rc0Jl-00062S-39;
	Mon, 19 Feb 2024 09:52:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rc0Jk-0008GW-Gj; Mon, 19 Feb 2024 09:52:08 +0000
Date: Mon, 19 Feb 2024 09:52:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Calvin Owens <jcalvinowens@gmail.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <ZdMkyPX/h9s8xht5@shell.armlinux.org.uk>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
 <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
 <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xs2splnjhlj257uca5yae64fp4solc4ugbxrkczoyd75n42r66@42boyzdcmyj4>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 19, 2024 at 04:40:00AM -0500, Kent Overstreet wrote:
> On Mon, Feb 19, 2024 at 09:26:51AM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
> > > I think these should be addressed in bcachefs instead.
> > > While it's not the fault of bcachefs that the calling
> > > convention changed between gcc versions, have a look at
> > > the actual structure layout:
> > > 
> > > struct bch_val {
> > >         __u64           __nothing[0];
> > > };
> > > struct bpos {
> > >         /*
> > >          * Word order matches machine byte order - btree code treats a bpos as a
> > >          * single large integer, for search/comparison purposes
> > >          *
> > >          * Note that wherever a bpos is embedded in another on disk data
> > >          * structure, it has to be byte swabbed when reading in metadata that
> > >          * wasn't written in native endian order:
> > >          */
> > > #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > >         __u32           snapshot;
> > >         __u64           offset;
> > >         __u64           inode;
> > > #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> > >         __u64           inode;
> > >         __u64           offset;         /* Points to end of extent - sectors */
> > >         __u32           snapshot;
> > > #else
> > > #error edit for your odd byteorder.
> > > #endif
> > > } __packed
> > > struct bch_backpointer {
> > >         struct bch_val          v;
> > >         __u8                    btree_id;
> > >         __u8                    level;
> > >         __u8                    data_type;
> > >         __u64                   bucket_offset:40;
> > >         __u32                   bucket_len;
> > >         struct bpos             pos;
> > > } __packed __aligned(8);
> > > 
> > > This is not something that should ever be passed by value
> > > into a function.
> > 
> > +1 - bcachefs definitely needs fixing. Passing all that as an argument
> > not only means that it has to be read into registers, but also when
> > accessing members, it has to be extracted from those registers as well.
> > 
> > Passing that by argument is utterly insane.
> 
> If the compiler people can't figure out a vaguely efficient way to pass
> a small struct by value, that's their problem - from the way you
> describe it, I have to wonder at what insanity is going on there.

It sounds like you have a personal cruisade here.

Passing structures on through function arguments is never efficient.
The entire thing _has_ to be loaded from memory at function call and
either placed onto the stack (creating an effective memcpy() on every
function call) or into registers. Fundamentally. It's not something
compiler people can mess around with.

Sorry but it's bcachefs that's the problem here, and well done to the
compiler people for pointing out stupid code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

