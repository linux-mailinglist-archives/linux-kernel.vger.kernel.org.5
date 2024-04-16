Return-Path: <linux-kernel+bounces-146984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F718A6DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16E2285E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0312DD95;
	Tue, 16 Apr 2024 14:18:22 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335F128805;
	Tue, 16 Apr 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277102; cv=none; b=FNN1V8w8XeKZQwKx8zy0qZq7WQwX25O6wG7MyyeTFt18+yiBWhmSIG4LPcbKekleSdlmezcgBua7o98GdxrZPMda1RSripbL4sP1tHCK+CWqTo7ZqPWjPUbrhFoOevwDaauBnRfMS82PPdWiNfrR9/ydz9+cYy1/2n6v9/Olsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277102; c=relaxed/simple;
	bh=cD37T59aEkLC1V37YKhVxgH6MPLClBUqzyZJEc80Wso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+g3ui6X6nXm4htNdE6BV7V55HSdmmbtP6dwwlTPGIBHW2ysqEMMXwloxZqZSJz+aFEOUa5xkQKKi4uk+EemraQpyW2yL/x6mG746P3K0Bo33HyJldmEljpLzfrMkJ9sCQ7kXaAeZHVo4eS4qizxLYaPv0oVOhOH3WHVV3cmuSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 66AE3E803C0;
	Tue, 16 Apr 2024 16:18:15 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 1B2A81602F7; Tue, 16 Apr 2024 16:18:15 +0200 (CEST)
Date: Tue, 16 Apr 2024 16:18:14 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh6IpqnSfGHXMjVa@gardel-login>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
 <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>

On Di, 09.04.24 09:17, Jens Axboe (axboe@kernel.dk) wrote:

> On 4/9/24 8:15 AM, Christoph Hellwig wrote:
> > On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
> >> All I am looking for is a very simple test that returns me a boolean:
> >> is there kernel-level partition scanning enabled on this device or
> >> not.
> >
> > And we can add a trivial sysfs attribute for that.
>
> And I think we should. I don't know what was being smoked adding a sysfs
> interface that exposed internal flag values - and honestly what was
> being smoked to rely on that, but I think it's fair to say that the
> majority of the fuckup here is on the kernel side.

Yeah, it's a shitty interface, the kernel is rich in that. But it was
excessively well documented, better in fact than almost all other
kernel interfaces:

→ https://www.kernel.org/doc/html/v5.16/block/capability.html ←

If you document something on so much detail in the API docs, how do
you expect this *not* to be relied on by userspace.

Lennart

