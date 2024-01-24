Return-Path: <linux-kernel+bounces-36836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1C83A78C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D8B1C27699
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952AB1AAD1;
	Wed, 24 Jan 2024 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQH5kncr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431819472;
	Wed, 24 Jan 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094787; cv=none; b=m4SXm/ks0bk+Fv+pHWCkUqQOfnB7Gj/xOnHGWod8xDmAGG+wmLsOFkanYnHQWH8QHnTVPqxCMybq8QRU8M21NaiVZKjj4rLrz2yssMAzgVKXj0O5l3O6KWK0HQpWiZbF1pcMJDMfCZOI5p2X1lzlN4IqxqOGFkEAjWsNg88BWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094787; c=relaxed/simple;
	bh=NG2X/pe3590tPTglFaejO7feDmgQ1PfQOGwReD2X2hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC4yN0xa9Joo682wFUUSxPkbbsQg5o4jHo5vIoRzSMEHdNwnCFi6W2e8CZ7Gk0J9Kx0iBwathdBzN+NiwBWC4FPjPF+/1WmuI2HjynP2b3Zg2ugggLw7p/texdbPQhAUldzJ60WQWxd+bc2M4VbCkNMJCpD3n3+CZosiNsRdb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQH5kncr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD53FC433F1;
	Wed, 24 Jan 2024 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706094787;
	bh=NG2X/pe3590tPTglFaejO7feDmgQ1PfQOGwReD2X2hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQH5kncrNnbPNZl9Y8orhkGjST0Pe9TGiiMNO6AH1fwTnIMvlEfKAi6n9A3VGUMbD
	 B1THeAxnavSuDQn1IOnNo/WjHMMSpdSdchHwwIFfBPQh9tWmZRmM3QEiW2Px0qNUFK
	 6GIZyHnlFkIvJ66n4LgTgHDoHWohgm7EkYdVxtUsB3KRdPhxCtSbIR3seM8QJpLigO
	 oR4W4OgbfUilcTUv311KSwqV/YNktIDeVwDVxpN54PWpv3f1zfyyYkUXY1tbtH5LXI
	 xA54M0nGcVksjauNUUkEUTpt6KfdJp7qGQvUTNd8QUUpyT4n3bdHQjCoEb/6ODuPx+
	 /Pz8BmtYA+9Yg==
Date: Wed, 24 Jan 2024 12:13:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Baokun Li <libaokun1@huawei.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240124-liquidieren-retten-8b3c65074c33@brauner>
References: <20240123125227.0521c8d9@canb.auug.org.au>
 <20240124122040.04cd2c8a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124122040.04cd2c8a@canb.auug.org.au>

On Wed, Jan 24, 2024 at 12:20:40PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 23 Jan 2024 12:52:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the vfs-brauner tree, today's linux-next build (powerpc
> > allnoconfig) failed like this:
> > 
> > In file included from <command-line>:
> > In function 'i_size_read',
> >     inlined from '__iomap_dio_rw' at fs/iomap/direct-io.c:570:16:
> > include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert_229' declared with attribute error: Need native word sized stores/loads for atomicity.
> >   435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > include/linux/compiler_types.h:416:25: note: in definition of macro '__compiletime_assert'
> >   416 |                         prefix ## suffix();                             \
> >       |                         ^~~~~~
> > include/linux/compiler_types.h:435:9: note: in expansion of macro '_compiletime_assert'
> >   435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > include/linux/compiler_types.h:438:9: note: in expansion of macro 'compiletime_assert'
> >   438 |         compiletime_assert(__native_word(t),                            \
> >       |         ^~~~~~~~~~~~~~~~~~
> > include/asm-generic/barrier.h:206:9: note: in expansion of macro 'compiletime_assert_atomic_type'
> >   206 |         compiletime_assert_atomic_type(*p);                             \
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/fs.h:911:16: note: in expansion of macro 'smp_load_acquire'
> >   911 |         return smp_load_acquire(&inode->i_size);
> >       |                ^~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   4bbd51d0f0ad ("fs: make the i_size_read/write helpers be smp_load_acquire/store_release()")
> > 
> > I have used the vfs-brauner tree from next-20240122 for today.
> 
> Pending a better resolution, today I have reverted that commit and the
> following one.

I had dropped both from vfs.misc yesterday night. Maybe it didn't make
it in time.

