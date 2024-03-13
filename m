Return-Path: <linux-kernel+bounces-102022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931887ADAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAB51C229B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D614C600;
	Wed, 13 Mar 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DkRIXAEy"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CD4C601;
	Wed, 13 Mar 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348338; cv=none; b=M6u8f09kZXEZc6iUNsTHBUeE6MGhz15WAkA+qHrK7/RmA2NAu6ar/YxLfHYaalxVMHVvvjOwp9mfP4AB4/spohOOZJ1N6EG9l0tSQwoE4je/ZWU0fmG4ZGuNw4somZC2pltWPh3sDCLKfZ2WxJk2CvRQGPQNVKNfiAXxYOsWDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348338; c=relaxed/simple;
	bh=RCZRlA8JjobyI7uYwn6+TIQ89XFi+Weg06bIukrpTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSVOiCvbhgfuvxvB+Y9GwEX1wsAQi3tDoHCk4zSij6z3yNbidFXrJgXPdIjPAMzHxVu8RMWp9WwltLE2eTEcopdC1xh58sbyPHXo+vVdNRDycpY0jsY2SqEp6q4gUKDL78+qX69JhAKZnxMY6vglLBpYrkTudvUrrWoJwDiWjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DkRIXAEy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39FC71C0008;
	Wed, 13 Mar 2024 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710348334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuQ0UqQl11m0NvvFOq43PqxRfN+fKrgvj7VWFDw8fu8=;
	b=DkRIXAEyUDiUQjQZfqTt26mQA8FYL6PzLpC4AgCnEmDFvlAqW+OPoXDI9PhHHoV0PP5oFl
	cuho564tPB50t6qdDQm97ywWKsVAJVvw/ytOG2N+sNf3MP91DMwN/JxYfr+CTmglUzvByl
	bRU5Y9hNmN5ZsaFgWRG/8wXjVQ53HzvzawOPfKWiH4vX9q5tSGAfm1LSH+pLErftptCpBw
	TXfT0mj5/I9SL09ifeBRTSB5vywWBXDG9isFgnbZQ0UAuvRt9wpmzztTVjgajt98o6gW8I
	ieNOllXoFMT4e8IhbIPcQMMLqnYvgS8MR0tjZT3rVTzP8OoIRcys2hRN1ECokA==
Date: Wed, 13 Mar 2024 17:45:31 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>, Alexey
 Gladkov <legion@kernel.org>, Jiry Slaby <jirislaby@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: Increase maximum font width x height to 64 x 64
Message-ID: <20240313174531.2579df0f@booty>
In-Reply-To: <20240312213902.3zvqaghlopjusv6m@begin>
References: <20240312213902.3zvqaghlopjusv6m@begin>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Samuel,

On Tue, 12 Mar 2024 22:39:02 +0100
Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> This remains relatively simple by just enlarging integers.
> 
> It wouldn't be that simple to get to the console's 64x128 maximum, as it would
> require 128b integers.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Index: linux-6.4/drivers/video/fbdev/core/fbcon.c
> ===================================================================

This patch is clearly not formatted according to the standard format
and it does not apply with 'git am'.

Using 'git format-patch' and 'git send-email' is *very* recommended as
it will take care of all the formatting for you. Maintainers and
anybody interested in your patch will be able to apply it easily.

All the info you need are at
https://docs.kernel.org/process/submitting-patches.html

> --- linux-6.4.orig/drivers/video/fbdev/core/fbcon.c
> +++ linux-6.4/drivers/video/fbdev/core/fbcon.c

Apparently you are not using git to track your changes, so I recommend
using it to have all the git utilities available.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

