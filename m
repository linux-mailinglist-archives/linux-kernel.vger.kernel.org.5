Return-Path: <linux-kernel+bounces-86144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED686C05C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C51F23259
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D72E3BBFA;
	Thu, 29 Feb 2024 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QYO3mbeA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3A3B7A8;
	Thu, 29 Feb 2024 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185211; cv=none; b=PoMNcxXmzpiX2SWezMzZ59Iz+2heyobHJM2tRzEKlli/dmspGtmyfH6s688Xqool1zByIHsuua5fSlw0gH/DldB7h9bj3//eGj/Te5YamtpHJMd3Jh+3NW4PyMtt7909cFAQ2ayqHTeYC2irdhfQElN1cGR1ZIuNu/vfWcV8kpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185211; c=relaxed/simple;
	bh=ofuQ/rOrOCdaNUz6GWFyaVHPD7x9sIVoaHnZMx5ipxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAQWuRfTzmQky8QG2pTO6ywuvxGzrnSn5DKPUInOg+hHRCgPFlH7PDY6tU6Tc8k7lFBfugx8on8SfiJhNxZE32BYrqPU0R2QHmPKEQxAwbYmT5EYRbu2STj22YBN/Z57pSEkBVqyy8hlH8gWwpelJyaFw6qgJRAvCHb1FEOG8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QYO3mbeA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6DmXQrgBzfgVcmNx5gSUwScgFre24GYZRXGswZYJeic=; b=QYO3mbeA+MBcYNBkXjHqlKmib8
	RvZMrkgFRQ3fgQF2spKuXedpO8rcsv9C10GpFPaW6VgoBm3NqYBi3S7VVyvtVA530+arlApsBC0ao
	ykOEmWdqdHxmYvU6wb46exw+r4tUKDa6gkIEcquWG930oClYBqQ0ALRDcEIgPY/ZE7BTLMDkvXnnF
	S//CuusY6ugZMBexpc46bKHmKmISFw3RNdzvFz2HU+TQwU1yk9qG7odSyWvuaWFtjNWZrHbSVIlxr
	fCe8TkbBqyvBkNrgt13BuZQNlYr9Ga1AY1F3EMl3zWekap3Xa8GjOiV7a7wE2CP+O9kYVmG6MVQwJ
	AvFs9E0A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfZ9L-0000000CBk3-0N7D;
	Thu, 29 Feb 2024 05:40:07 +0000
Message-ID: <c1025094-d9aa-4f4c-bb8f-a486f9953bec@infradead.org>
Date: Wed, 28 Feb 2024 21:40:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kconfig: menuconfig: Make hidden options show with
 different color
Content-Language: en-US
To: Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org
Cc: Nicolas Schier <n.schier@avm.de>, Masahiro Yamada <masahiroy@kernel.org>,
 linux-kernel@vger.kernel.org, Jesse Taube <Mr.Bossman075@gmail.com>
References: <20240228060006.13274-1-tfiga@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240228060006.13274-1-tfiga@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/27/24 22:00, Tomasz Figa wrote:
> When hidden options are toggled on (using 'z'), the number of options
> on the screen can be overwhelming and may make it hard to distinguish
> between available and hidden ones. Make them easier to distinguish by
> displaying the hidden one with a different color (COLOR_YELLOW for color
> themes and A_DIM for mono).


> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  scripts/kconfig/lxdialog/dialog.h  |  5 +++++
>  scripts/kconfig/lxdialog/menubox.c | 12 ++++++++----
>  scripts/kconfig/lxdialog/util.c    | 19 +++++++++++++++++++
>  scripts/kconfig/mconf.c            | 18 ++++++++++++++++++
>  4 files changed, 50 insertions(+), 4 deletions(-)


> Changes from v1:
> (https://patchwork.kernel.org/project/linux-kbuild/patch/20231228054630.3595093-1-tfiga@chromium.org/)
>  * Replaced A_DIM for color themes with COLOR_YELLOW, because the former
>    has no effect to black text on some commonly used terminals, e.g.
>    gnome-terminal, foot. Reported by Masahiro Yamada and Nicolas Schier.
>    I ended up with COLOR_YELLOW, as it seems to look comparatively dim
>    with mutliple light and dark color themes in Chromium hterm and
>    gnome-terminal.

I guess COLOR_YELLOW is a relative thing, i.e., it depends on the term's
current color scheme in my testing.

With rxvt (with a beige/khaki background), I do see yellow.

With xfce4-terminal (with amber/orange foreground on black background,
i.e., my default from days of amber monochrome displays ;), the "yellow"
comes out as a faded/washed out/dim orange. But still readable.

Anyway, this looks useful to me.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
#Randy

