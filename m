Return-Path: <linux-kernel+bounces-36782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4AF83A67C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42A41F21FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97E18659;
	Wed, 24 Jan 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="XLYvistR";
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="F4MMYTza"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8B1862E;
	Wed, 24 Jan 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091348; cv=none; b=KSqOR47UN/drNpGko9zdipSU0S9aWPzxjuIXhxU+N6YQmeE6lLhvAftjCIlw7XkY3cBnp0qIZrrlKBhfNMI9WurYJ3ZlrV3yg8Cd1ShwScRneAYT2AFnyndHQi7HPWHYdMgkN4DHZ+c2RIhnpKDIDMcp99ocExz3UN0JecFgQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091348; c=relaxed/simple;
	bh=3KQWhQUwONwsinXPwABZKJVj6BEl9WSweJhnvwfsGh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTlnb8H0w5edhmP2xf4rMdu232PZ/RmJSzoLKNao4lmI+WWsUgfQ4L2L4mYevreN/TUMwgDiz7pSepnHCmb7pJIiPKPnWzkeLQl4wYc4TM2njxEd/IjvTnnFhLVRYmMijlAAY+/V3tgcZpLri8gsAf5/cjswQ3Zwm8z4tavaIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b=XLYvistR; dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b=F4MMYTza; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso7691351e87.1;
        Wed, 24 Jan 2024 02:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706091343; x=1706696143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbXSTzcz0OzwsQ3PjuvIo0Y6PD8ojggK6PR8Fzfjhyk=;
        b=jBSKWEH0nlnk8VDa5sykj0C5mH6sXcv6KQGCsPnzSyhBM/3yPFBViZRMlvJ52bz236
         Os499g7ysODi9Tgw6POKJnf22g5vkQw6WHVwO7QiGKZubaAUDfvm58VtLtIOIjql7P7p
         37OqYEaTNW5QjtnzUPxE+v1xj9/NJNu8WdPQoGncaNAv7W8UXOiQLb2lnQ35mMTeWUP4
         dMLu+bLdnHApXsYwQOJUByr0K0UpHgxPCda8WoSLKVIeqLCz2+d0MjQAPy4px2OWVKaS
         zKBxjzJFwnec/5yEc7q9RU9/08Chyve0yMctjethafFn1arTLmfYpzhd805i8ojWEH6h
         STBA==
X-Gm-Message-State: AOJu0Yx1vQEIA5+n9JxtEAy0BKEDboTc8J5+fopKTiXLbmUdLjE6l6g5
	tQ0y1sN3yxqLiHuzk0AOenDxjs/rCGrcvDJ39AFwjkxVz1IhDHHqMfdZQGvo
X-Google-Smtp-Source: AGHT+IGsJaXYmPUorVt7J4tg5m+HTLbXtsk6tye6awVYomNPZ+EnkCA/UbobJmIHY/EGIvDrsC334g==
X-Received: by 2002:a05:6512:717:b0:50e:262d:4834 with SMTP id b23-20020a056512071700b0050e262d4834mr2935512lfs.135.1706091343340;
        Wed, 24 Jan 2024 02:15:43 -0800 (PST)
Received: from flawful.org (c-06f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.6])
        by smtp.gmail.com with ESMTPSA id l13-20020a056512110d00b0050e9e1cb265sm2523848lfg.112.2024.01.24.02.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 02:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1706091341; bh=3KQWhQUwONwsinXPwABZKJVj6BEl9WSweJhnvwfsGh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLYvistRAGw+5aG4kznXKYAp0gDE4/Rr5v0wAk2vO7ZjzJ5/HXtz3cd6B5NpJVdLh
	 rK972LNvVTUke5DfcmhOBuRmG5VSw/xhwNSBzD+tyJx6z12prxin/lrayYirUWyZkJ
	 E0jMPh6vjCo+wAB3chWDKGI8VwxYQufk0X6FumEo=
Received: by flawful.org (Postfix, from userid 112)
	id 2CE80375; Wed, 24 Jan 2024 11:15:40 +0100 (CET)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1706091328; bh=3KQWhQUwONwsinXPwABZKJVj6BEl9WSweJhnvwfsGh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4MMYTza4x1N5d1+CZ/0LlC6pXCXigKisI7Obtr1LcoagHLrIq+jBiBMD8r4YlRv1
	 pW0yvZcq2cE+DKHsXDYa6ZvL1jHWVJX6L9wsTyTNEiwPzwulJq5idiGqS8Boy3Qa92
	 OD4Ju6rd1TYVMrCJ6mPw3NZ9K4ANiQvsI+Pknj1E=
Received: from x1-carbon (OpenWrt.lan [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by flawful.org (Postfix) with ESMTPSA id DA5CF32F;
	Wed, 24 Jan 2024 11:15:12 +0100 (CET)
Date: Wed, 24 Jan 2024 11:15:11 +0100
From: Niklas Cassel <nks@flawful.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZbDjL0TDnUfzknZS@x1-carbon>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org>
 <ZahaKaV1jlHQ0sUx@x1-carbon>
 <ZbAo_LqpbiGMfTtW@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbAo_LqpbiGMfTtW@wantstofly.org>

On Tue, Jan 23, 2024 at 11:00:44PM +0200, Lennert Buytenhek wrote:
> On Wed, Jan 17, 2024 at 11:52:25PM +0100, Niklas Cassel wrote:

(snip)

> This all suggests to me that the ASM1061 drops the upper 21 bits of all
> DMA addresses.  Going back to the original report, on the Asus Pro WS
> WRX80E-SAGE SE WIFI, we also see DMA addresses that seem to have been
> capped to 43 bits:
> 
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> 
> Since in this test the X570 AHCI controller is inside the chipset and
> the ASM1061 in a PCIe slot, this doesn't 100% prove that the ASM1061 is
> at fault (e.g. the upstream IOMMUs for the X570 AHCI controller and the
> ASM1061 could be behaving differently), and to 100% prove this theory I
> would have to find a non-ASM1061 AHCI controller and put it in the same
> PCIe slot as the ASM1061 is currently in, and try to make it DMA to
> address 0xffffffff00000000, and verify that the I/O page faults on the
> host report 0xffffffff00000000 and not 0x7fffff00000 -- but I think that
> the current evidence is perhaps good enough?

It does indeed look like the same issue on the internal ASMedia ASM1061 on
your Asus Pro WS WRX80E-SAGE SE WIFI and the stand alone ASMedia ASM1061
PCI card connected to your other X570 based motherboard.

However, ASMedia ASM1061 seems to be quite common, so I'm surprised that
no one has ever reported this problem before, so what has changed?
Perhaps there is some recent kernel patch that introduced this?

The commit was introduced:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bf7fda4dce22214c70c49960b1b6438e6260b67
was reverted:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3e9579ecfbe1796334bb25a2f0a6437983673a
and was then introduced in a new form:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=791c2b17fb4023f21c3cbf5f268af01d9b8cb7cc

I suppose that these commits might be recent enough that we have not received
any bug reports for ASMedia ASM1061 since then.


If you can find another PCIe card (e.g. a AHCI controller or NVMe controller)
that you can plug in to the same slot on the X570 motherboard,
I agree that it would confirm your theory.


If you don't have any other PCIe card, do you possibly have another system,
with an IOMMU and a free PCIe slot that you can plug your ASMedia ASM1061
PCI card and perform the same test?

(Preferably something that is not AMD, to rule out a amd_iommu issue,
since both Asus Pro WS WRX80E-SAGE SE WIFI and X570 use amd_iommu.)

If we see the same behavior that the device drops the upper 21-bits there
when using the trick in your test patch, that would also confirm your theory.


> 
> There are two ways to handle this -- either set the DMA mask for ASM106x
> parts to 43 bits, or take the lazy route and just use AHCI_HFLAG_32BIT_ONLY
> for these parts.  I feel that the former would be more appropriate, as
> there seem to be plenty of bits beyond bit 31 that do work, but I will
> defer to your judgement on this matter.  What do you think the right way
> to handle this apparent hardware quirk is?

I've seen something similar for NVMe, where some NVMe controllers from
Amazon was violating the spec, and only supported 48-bit DMA addresses,
even though NVMe spec requires you to support 64-bit DMA addresses, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdf260362b3be529d170b04662638fd6dc52241

It is possible that ASMedia ASM1061 has a similar problem (but for AHCI)
and only supports 43-bit DMA addresses, even though it sets AHCI CAP.S64A,
which says "Indicates whether the HBA can access 64-bit data structures.".

I think the best thing is to do a similar quirk, where we set the dma_mask
accordingly.


Kind regards,
Niklas

