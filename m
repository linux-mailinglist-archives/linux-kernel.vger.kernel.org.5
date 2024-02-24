Return-Path: <linux-kernel+bounces-79364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF7862136
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290C61C246C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0410F2;
	Sat, 24 Feb 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqgJdwNE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876EA55;
	Sat, 24 Feb 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734551; cv=none; b=j6+LzqZacbgkE0bZDoJhINxjEX7qY4PB0LJDaQlZi5NSnycgwq3xmLrEu9jz+wT80hrldDF+RHtiv3FF+UqYpJ2RWsYMBu/f/8+K3hWTAXX/AOgbt0ffLnhMeFICfcg98ETV4/Xqm9tpHHA0LPi4JToQ+RBudpUPZvsbYDyTRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734551; c=relaxed/simple;
	bh=D2Ymr1Fwng5x+vRge2/L1d/O2ki9hen1IPOBEBlpFvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2wErn+xSZEBM3lKfxXzJeWPmXrc7KcRQd/gi6x5k1WZ0p8t87nmMc8Crs/HhQevxM55lUvV1jbjF3sDHFSsdrU7Ko6rNa/vPZ4+IDawei95tHm5PMQ7Z7TGueR2yV285h8m6qcSU1FOppa2Na9fMpFh7y7x09gK1BVArXk2lA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sqgJdwNE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4uXKqvbumEDVF3TL2P92MblTjGuDcJSAWiwkp0vmwGg=; b=sqgJdwNEq94uZLqCwsaLQbZQNg
	XUHWwWW+d+FrT/eqaVjc1+01H+jWWpxKt4UROHPE0I0JQCVFkAD+f3MAuniCKpQJiMVFmjXkxiGSY
	1tBC6jbM1d6tbVrTRz2Smo9eyeWQdnjTiMseymqqTtqA23x63jugZzelC4Roledj1ozBTL3lGgitC
	mm7xiJDyQV+NcCM6vEVDHcVHuNSa4uf/gyunKgA2Fc83ppEL3rd22SHmB/KyYB9khyJ18F8pc6fnk
	QU9iJ5NZjLpQZLCFBKiGJCTw2dbfQk+bABWuRweCDmizZb1DZqeJcev2BR2Cr/wdfa1WQ7QgGtp2U
	LsF520bA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfue-0000000BgUh-2bC8;
	Sat, 24 Feb 2024 00:29:08 +0000
Message-ID: <e6238416-0a4f-4374-ad9a-1f6ce5c34b49@infradead.org>
Date: Fri, 23 Feb 2024 16:29:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] sparc32: Fix build with trapbase
Content-Language: en-US
To: sam@ravnborg.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-2-5c60fd5c9250@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-2-5c60fd5c9250@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 11:36, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Fix the following build errors:
> irq_32.c:258:7: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]
> irq_32.c:271:14: error: assignment to 'struct tt_entry *' from incompatible pointer type 'struct tt_entry (*)[]
> 
> trapbase is a pointer to an array of tt_entry, but the code declared it
> as a pointer so the compiler see a single entry and not an array.
> Fix this by modifyinf the declaration to be an array, and modify all
> users to take the address of the first member.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/sparc/kernel/irq_32.c   | 6 +++---
>  arch/sparc/kernel/kernel.h   | 8 ++++----
>  arch/sparc/kernel/kgdb_32.c  | 4 ++--
>  arch/sparc/kernel/leon_smp.c | 6 +++---
>  arch/sparc/kernel/setup_32.c | 4 ++--
>  5 files changed, 14 insertions(+), 14 deletions(-)
> 


-- 
#Randy

