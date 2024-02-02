Return-Path: <linux-kernel+bounces-49085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B088465BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807C11F25E76
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE4AD4F;
	Fri,  2 Feb 2024 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oasoUsml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086BBA4C;
	Fri,  2 Feb 2024 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840464; cv=none; b=gM52u69wq8cvDAwlCbmSHuGxENNL9KRsmNxpJA0aF7CDvZOt32RNAIn31faTXJcF6Q+sOge4+V6E0+1f29RQUBG8ju3zCN682LhhfDW9+duDjNd0oE8jhp27hLnxpzItR67JVn+tGo1mB8JZuKx407DZeWqEJwY4dV2CdGH6dXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840464; c=relaxed/simple;
	bh=caSt1K8X7wTfsDubxjLdVYfUEcr45wgSDgC/mtyZAUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAyobS7BugA/kn/n6kX8sSErbTo5Orr1xghiplxyZZTV3ME4e52FbEZD+vpPtFX7QbE/NJT9+UUW2LTGDCzfKKGdcBJtkbEGVUVijPKIwZa6umbyYC1WTZcG/E9fl+eNjrzL5/Q0lzisJCbaOVTKS72hOvF7pCn0mym+lN88wlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oasoUsml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDFEC433F1;
	Fri,  2 Feb 2024 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706840464;
	bh=caSt1K8X7wTfsDubxjLdVYfUEcr45wgSDgC/mtyZAUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oasoUsml1+uLAFVUGaQaKVrDvLeAA4/u3sJZm5Xz/4sTaHALvPZdO7EBtOrR7EXLG
	 hEYO1rPOjmVEpMfSXOpWQKsKKw8AZNbkKTu/2eVeKy8CJCt5vlZSKWrh/4XbZuSnEX
	 iMnsZNOgmlr2vZV5PPxlHgO1PInXuK3tTQvc5/Vw=
Date: Thu, 1 Feb 2024 18:21:03 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <2024020105-dash-antiquity-a56b@gregkh>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
 <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
 <ZbA4VthTMPT7BSRo@google.com>
 <2024013059-poison-equation-81d1@gregkh>
 <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>
 <2024013012-gully-goofy-2a55@gregkh>
 <679fa364-28d0-4faa-b46e-805faf56ae53@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <679fa364-28d0-4faa-b46e-805faf56ae53@notapiano>

On Thu, Feb 01, 2024 at 05:45:19PM -0500, Nícolas F. R. A. Prado wrote:
> On Tue, Jan 30, 2024 at 04:23:02PM -0800, Greg Kroah-Hartman wrote:
> > On Tue, Jan 30, 2024 at 04:01:57PM -0800, Brian Norris wrote:
> > > On Tue, Jan 30, 2024 at 3:51 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Tue, Jan 23, 2024 at 02:06:14PM -0800, Brian Norris wrote:
> > > > > "Don't you want to have a driver data or so associated with this?"
> > > ...
> > > > But why limit yourself to 32bits now?  Why not make it 64?  It is going
> > > > to be sent to userspace, so you have to be very careful about it.
> > > 
> > > Is that question related to the question I pasted/replied to, about
> > > driver data? Or a new topic? Sorry if I'm misunderstanding.
> > 
> > Same question, driver data, you make it 32 bits.
> > 
> > > Anyway, for the size of the tag field: I don't have a strong opinion.
> > > But FWIW, they're coming from this project:
> > > 
> > > https://review.coreboot.org/plugins/gitiles/coreboot/+/269b23280f928510bcadd23182294e5b9dad11ec/payloads/libpayload/include/coreboot_tables.h#36
> > > 
> > > As you can see there, we're extremely far from exhausting 16 bits, let alone 32.
> > 
> > We've run into running out of bits in other subsystems before, it's
> > "free" now, just be safe and make it 64 like I think Andy is suggesting.
> 
> Either you and Andy are suggesting different things, or I still don't quite get
> what you mean.
> 
> Andy was suggesting we added a driver_data field, that is:
> 
> struct coreboot_device_id {
> 	__u32 tag;
> 	kernel_ulong_t driver_data;
> };
> 
> You're suggesting we make the tag 64 bits long:
> 
> struct coreboot_device_id {
> 	__u64 tag;
> };

Yeah, I'm confused, sorry.

Yes, add some driver_data, and if you are SURE your tag will NEVER be
larger than 32 bits, stick with that, but really, you are using the
space in empty padding anyway, so just make it 64bits please.

thanks,

greg k-h

