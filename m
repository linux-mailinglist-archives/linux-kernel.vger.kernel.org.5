Return-Path: <linux-kernel+bounces-105005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7987D787
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4FAB216B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A24641;
	Sat, 16 Mar 2024 00:12:56 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB4360;
	Sat, 16 Mar 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547976; cv=none; b=fpDmq9+mNf6knLWzPb3T/y0qexipO4EGse5Q81ih4w3yZbTCZN2EeooaIC5Cb4WKTm7dpA2Z/YBU0K6JlM28ZYQ/X2KA1yGvFNb4LScAnvFurU+IwJmkgsulYU11mYiqzJWFX7U0fz07YRGt1qrtdqWwhImqnCEjRhx6JzxPtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547976; c=relaxed/simple;
	bh=FmqiHuj6qYeds+sNkuY+xpNzvV9xKuoPZebxi51Z6dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/uWVdm6SbxUAFaAt5bBgBmELeSiRpx4rwkNs9wKrGbitRZNWdI6oAWQ66/SNbORzV4tOs0050e8I4aoZCckVd+ciok9qvg2lcpGALbwxVqudKAbXi8GVuAPpms1wg7wv6ddoecv2rzefrt0Xpm4RwKlL2BVKj7nYrCRqVY8mWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 85296A02EC;
	Sat, 16 Mar 2024 01:12:52 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zYDEp8X74GRV; Sat, 16 Mar 2024 01:12:52 +0100 (CET)
Received: from begin.home (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 689B9A02DF;
	Sat, 16 Mar 2024 01:12:52 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rlHfQ-0000000CQsO-0E7U;
	Sat, 16 Mar 2024 01:12:52 +0100
Date: Sat, 16 Mar 2024 01:12:52 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbcon: Increase maximum font width x height to 64 x 64
Message-ID: <20240316001251.l3ifu5exkrjmbhoe@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, Alexey Gladkov <legion@kernel.org>,
	Jiry Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
References: <20240313165934.557879-1-samuel.thibault@ens-lyon.org>
 <d7ca4ae3-4bcc-49f0-a819-4ad88907b93c@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ca4ae3-4bcc-49f0-a819-4ad88907b93c@gmx.de>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Hello,

Helge Deller, le ven. 15 mars 2024 10:35:40 +0100, a ecrit:
> You should have marked this patch with "v2"...

The actual changes were exactly the same.

> On 3/13/24 17:59, Samuel Thibault wrote:
> > This remains relatively simple by just enlarging integers.
> 
> I like the patch, but I still see some u32...
> drivers/video/fbdev/vt8623fb.c:         info->pixmap.blit_x = (bpp == 4) ? (1 << (8 - 1)) : (~(u32)0);
> drivers/video/fbdev/arkfb.c:            info->pixmap.blit_x = (bpp == 4) ? (1 << (8 - 1)) : (~(u32)0);
> drivers/video/fbdev/core/fbmem.c:               fb_info->pixmap.blit_x = ~(u32)0;
> drivers/video/fbdev/s3fb.c:             info->pixmap.blit_x = (bpp == 4) ? (1 << (8 - 1)) : (~(u32)0);

Oops, I missed including these modifications indeed.

> > It wouldn't be that simple to get to the console's 64x128 maximum, as it would
> > require 128b integers.
> 
> How realistic are fonts > 64x64 pixels ?

With 4K displays, 64x128 brings 60x16 text console, which is useful for
people with low vision.

> If they are, using the bitmap_xx functions (include/linux/bitmap.h)
> now instead would be better.

Ok, I have now done this in v2. We'll be able to easily increase the
font size when 8K displays get out :)

Samuel

