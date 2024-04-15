Return-Path: <linux-kernel+bounces-145926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B58A5CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5995F1C217A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53BA157A45;
	Mon, 15 Apr 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP7ITOKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AE157474;
	Mon, 15 Apr 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216027; cv=none; b=AG1P9jaBQYGYFhuJnFyeCouqRQfiQgMrGojqdQf0+fS/lwqO94JSgm93ipeMGmbEvAtMkis3xBes39K4QctMdfDJopMJrkObT4X0QeAwUx2PTdK6vhWKmLplWf/3jkM2Ex/FXyfMxSS0Kk55+g39LWvHx1dZhndsWSuIr8zPLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216027; c=relaxed/simple;
	bh=+afJiuXG3cF9tk3eLeJnRhRaoDpNXZkN7pxBI2RmPBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcmEZm9z7fXJkX7hHEcwuD4oYITDAOJf0mOXCt9us4+zMfatDBJlw9bKmgWugaAylW66hLcJBlTs/RFcLXcS6r3YWusZSsLGLTfECgqUIQLjFP18txAOFmASux0mLC5RMzhiHS2dwjliO7Yhy7Q5J/R1q67q2Spv+d7MaCDITO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP7ITOKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C59EC113CC;
	Mon, 15 Apr 2024 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713216026;
	bh=+afJiuXG3cF9tk3eLeJnRhRaoDpNXZkN7pxBI2RmPBw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qP7ITOKI6F96cNfzf6FwHg7no4R9lLwhCMnlTazhM2wAoGeCm+tt9X6fNvcLIJQB+
	 0hLXEf8mUFqxHLR544EVU0etsy0kIbj2WtwQyoGe8BmS6h/SnDRE2z5LowAUeGYZ14
	 arizQaAV59LiNOVEFjzObNCh25ygrUGZSHJBOE/6w8PlQY7V3oEiVOcykF0cEIHehe
	 MqQw0i2oq2jwfV8RwxyfxP3ujMvbspTFnyzLW70iVygvZt4N6/4fGAujJZHUvdQ1Kc
	 3m8+HWZ0K6fFurfgQsfskVClStrPSZI9pC7vHEZ0uAK4rkh/X9W3GlPiwRYFkCJQ6+
	 tjGiE0mLBh8nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2AD67CE0445; Mon, 15 Apr 2024 14:20:24 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:20:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>,
	leobras@redhat.com, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, yujie.liu@intel.com
Subject: Re: linux-next: manual merge of the rcu tree with the risc-v tree
Message-ID: <605ad410-19cf-4e13-8594-fc7f5ecc2e39@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b147ca95-c0e2-4729-b670-a1ee605369d2@paulmck-laptop>
 <mhng-4dd659ce-865c-48c8-bf51-397804035d60@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-4dd659ce-865c-48c8-bf51-397804035d60@palmer-ri-x1c9a>

On Mon, Apr 15, 2024 at 11:20:00AM -0700, Palmer Dabbelt wrote:
> On Sun, 14 Apr 2024 21:44:10 PDT (-0700), paulmck@kernel.org wrote:
> > On Mon, Apr 15, 2024 at 12:32:47PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the rcu tree got a conflict in:
> > > 
> > >   arch/riscv/include/asm/cmpxchg.h
> > > 
> > > between commits:
> > > 
> > >   07a0a41cb77d ("riscv/cmpxchg: Deduplicate cmpxchg() asm and macros")
> > >   54280ca64626 ("riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2")
> > > 
> > > from the risc-v tree and commit:
> > > 
> > >   b5e49f1af563 ("riscv: Emulate one-byte cmpxchg")
> > > 
> > > from the rcu tree.
> > > 
> > > I fixed it up (I just used the former as the latter seems to no longer be
> > > needed - I also undid the change to arch/riscv/Kconfig from the latter)
> > > and can carry the fix as necessary. This is now fixed as far as linux-next
> > > is concerned, but any non trivial conflicts should be mentioned to your
> > > upstream maintainer when your tree is submitted for merging.  You may
> > > also want to consider cooperating with the maintainer of the conflicting
> > > tree to minimise any particularly complex conflicts.
> > 
> > Agreed, it looks to me like I should drop my RISC-V change in favor of
> > the native support.  Please let me know if I am mistaken.
> > 
> > If I do not hear otherwise, I will pull my commit out of -next in favor
> > of those two on my next rebase.
> 
> Sorry I forgot to send the shared tag.  We can pre-merge if you want, I'm
> fine either way just let me know.

Not a problem!  I will just keep it in -rcu for my testing, but such
that it does not go to -next.

							Thanx, Paul

