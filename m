Return-Path: <linux-kernel+bounces-112243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B526D88775A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A71D1F22E87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57182BE5E;
	Sat, 23 Mar 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="i6jnN+xq";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="cVjUCt3q"
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1F8F6C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711177165; cv=none; b=GBVPTbXEQ3gMkAdzymLJuuhbQoE3a4c3jFjfSnzZt2NrSCd+ZMgQbfL/I1o/Zb0j4iOYrySHtq5D3t8J3t84p68wxOjVjR02ks91CUC0AKMld+El2utKDyC8hyepH0t7KDwQotsZoKI3/YFA47Ct0WZNvOnm9rypAZJq2ug5VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711177165; c=relaxed/simple;
	bh=nRJDueQBDn4xbmbB65HmUo5mxerLOF+EPeE6Yi0Vi9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRdXEqLX3rDq1Oc3UeULC7Ve6wV85f1a/8nCJ0J2vps1ALUN9f3EAUcdnOXjFVdyhmuTZnFk+l/vAkSx9rZWko8h1RK8TXTZPMCTjXtJbMtm8zodD/GXsKMuJpFS6wXfa7YOu8nlOn8J5Jwp2Tyru5nF/RVT09/vT0ehIEecZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=i6jnN+xq; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=cVjUCt3q; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=kHVpvatmACLIHkQBpgUbroXh+MVsVFpq6tArzu/ykOs=;
	b=i6jnN+xq/VdVv+HkVL4ICMSlaFskB+k+43rEVsmWuJAGORLjqZZsVKaV5JWuTtZco2dadtZR3to5y
	 srXJuv/2I75lVQj/mnuN94BytRg6V6uiKXOPWFFdA4OwAUmZdaPlaIbx3lVSxo3DgiMtY/yu/dGrXx
	 Ba6KzApuIu+Tl8OeXqFTIW7Nthk1MHU8XI0ChjY7bWLpFWf7zLLa+yeeCCVqTx4tDVn7Y7mxpjI+nW
	 vy6yFbjPZUVnbgPlarPlipdN16ijfQal4Cm5PAwQSeNbwB+DCIUOUu25XMmn+dQW7F5u7JaXSNAoLe
	 4+YHY7YW1+iQv9YyHkWHGp6O8yIC+UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=kHVpvatmACLIHkQBpgUbroXh+MVsVFpq6tArzu/ykOs=;
	b=cVjUCt3qIpk1zz093kSoT9yNiAJtNN/6tMO6ofj+yw9LAoN5BEKt6xyNp3YuH+U6MZ5+0Xq5QAGoe
	 mPps64CAw==
X-HalOne-ID: b499b8b2-e8e2-11ee-9527-31e85a7fa845
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id b499b8b2-e8e2-11ee-9527-31e85a7fa845;
	Sat, 23 Mar 2024 06:58:10 +0000 (UTC)
Date: Sat, 23 Mar 2024 07:58:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: nbowler@draconx.ca, deller@gmx.de, javierm@redhat.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: Select I/O-memory framebuffer ops for SBus
Message-ID: <20240323065809.GA886373@ravnborg.org>
References: <20240322083005.24269-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322083005.24269-1-tzimmermann@suse.de>

On Fri, Mar 22, 2024 at 09:29:46AM +0100, Thomas Zimmermann wrote:
> Framebuffer I/O on the Sparc Sbus requires read/write helpers for
> I/O memory. Select FB_IOMEM_FOPS accordingly.
> 
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/lkml/5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8813e86f6d82 ("fbdev: Remove default file-I/O implementations")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

