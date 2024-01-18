Return-Path: <linux-kernel+bounces-30559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05ED83207C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EC22853A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3422E656;
	Thu, 18 Jan 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="GcMuP6v/"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E72E63A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609625; cv=none; b=K4gQWU1jF+nLo5QQD1c78y7vLTWA9e4UiW7d6M8/4i8++2Enmp+BEtjRxwXG+cN9Ncqen/8Gmp9dixYGNZZeIGCHORcMI/geZ+xk4JhbvzuOa0VEt3jDd7fg9seYzxexANuokl/DdKjCXPv+keT04iOWkG3GqcjD02BHJ2GAOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609625; c=relaxed/simple;
	bh=2zzLYQkDGYleQ43sy5TztQij3R3Qs5VTOeNThZsU15k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EcPyfCBRIAYvsrI127oyYv2eQkiWp6SpnMuVWKNspkKjfMCqEqqVnz5ULFS7rarvP4E/oU6Q6772Kxi9CemizMqhCzHpDNQQ+gFpmw1QZHqQels+TpxklKqWi/fGBtHxBgmRESBRjZN6ipdVw5/M9dGuNJOw8/dc7dbIRsEHzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=GcMuP6v/; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oniM1tHRWysCpGkdbeyIlaVHtdrTecB+D1XxrJxUmwQ=;
  b=GcMuP6v/mQZS2lVkPP8Lqtmczbc/jyYzEZN+c5PbtZm0I7tRFgbnfO2K
   V0wA7jwC6iRd0hEAZbsSXkYHGSTDa9+RzF6TTkdp0bZZHYUOvJ1MTHXD6
   XlBZ1EHdz6+Rig3IgSBfHWgVFqR3kb3BSoBh6jvZl0T0iSN/ehMFeWAyd
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,203,1701126000"; 
   d="scan'208";a="147468856"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 21:26:59 +0100
Date: Thu, 18 Jan 2024 21:26:59 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
Subject: Re: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
In-Reply-To: <20240116041129.3937800-2-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com> <20240116041129.3937800-2-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 16 Jan 2024, Li Zhijian wrote:

> Update them according to latest Documentation/filesystems/sysfs.rst.
>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> index a28dc061653a..a621e9610479 100644
> --- a/scripts/coccinelle/api/device_attr_show.cocci
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -1,10 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// From Documentation/filesystems/sysfs.rst:
> -///  show() must not use snprintf() when formatting the value to be
> -///  returned to user space. If you can guarantee that an overflow
> -///  will never happen you can use sprintf() otherwise you must use
> -///  scnprintf().
> +/// show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> +/// the value to be returned to user space.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
> @@ -46,10 +44,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit")
>
>  @script: python depends on org@
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit")

Thanks for the suggestion, but it's not really consistent, because the
patch rule still generates a call to scnprintf.  Would it be possible to
fix that up?  Or should it be removed?

thanks,
julia

