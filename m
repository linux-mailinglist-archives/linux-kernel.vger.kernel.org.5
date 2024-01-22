Return-Path: <linux-kernel+bounces-33980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F2837148
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A9F290C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895413F8F5;
	Mon, 22 Jan 2024 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NUAZbR4Z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0823EA9B;
	Mon, 22 Jan 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947917; cv=none; b=W7HvlwyPn++BM0CjapH+U12GjQgLsBIzL+YfRFsICKfbV8nK4z0HHEjb/5DLGA2J1Pj3CxB/pJdTun6akzHJ+Z2QzmGRgK5XX4Z37mX2kg+6LUOuXngqNtrwwgoTaq8UiXABsJbzfF0VmEk2Hn2j0sxd5GA6QXfH/a1p077vqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947917; c=relaxed/simple;
	bh=bki8OKPCaifZaa0bC+BAoNW93I8ZJcHhhEc/Dz/w0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8yfj2WzYlG7wL/+f3B6ierbS9eFUOI2COIrnaoC2TGW2SwaMVwrGPZGHWjpKBc3tqEWXF1+j9Ms3q5T/iaAlnx6AgZMbf3Wg6AiWHjQZ8+SxFYAip8oezU7XrjFAKNUTHbUbcvWXPRL6xBFHo6YLRlZfvuogC7P+ONYM2aU7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NUAZbR4Z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705947914;
	bh=bki8OKPCaifZaa0bC+BAoNW93I8ZJcHhhEc/Dz/w0UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUAZbR4Z/wMc9SbajwSwp7sgMlJHdeRsauGAF4zt2TxjD3lMp83aPq5owZAX1DT9H
	 luG9GGZJnThtXlDUcHAeLwhoNqxVbRJKvi3XcG464vrigORWQch5njxMHBQiSBIGg9
	 TU4H30azSkQh98/BVxGJ69NPA3TzsUzJ4BKne+sLMrh+fD3PWU/7R0MonWNFWgvStf
	 M0V57dN5BtZe7YWkg8qZQ0RSb2HXmV6+NxVnJGCHtZfeHReWRkIxSFppf+Ks5Fqah/
	 d/XmcxUegDCDb2Mj3Qz2r7abRibWx/kD9tGhgICrgKcaHuSclWriBt2L2uL4IWizKQ
	 At4DamqDXRWpw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B9743782094;
	Mon, 22 Jan 2024 18:25:09 +0000 (UTC)
Date: Mon, 22 Jan 2024 15:24:36 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <1ab1c936-2423-431b-bb54-49983e64fb98@notapiano>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-3-nfraprado@collabora.com>
 <ZaQU_QqGXwkSgU_Y@smile.fi.intel.com>
 <49b42da1-a74b-433c-b018-0742f850f680@notapiano>
 <Za0Q-em5R2_9cX7q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Za0Q-em5R2_9cX7q@smile.fi.intel.com>

On Sun, Jan 21, 2024 at 02:41:29PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 17, 2024 at 09:53:23AM -0300, Nícolas F. R. A. Prado wrote:
> > On Sun, Jan 14, 2024 at 07:08:13PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 11, 2024 at 12:11:47PM -0300, Nícolas F. R. A. Prado wrote:
> > > > Generate aliases for coreboot modules to allow automatic module probing.
> 
> ...
> 
> > > > +/**
> > > > + * struct coreboot_device_id - Identifies a coreboot table entry
> > > > + * @tag: tag ID
> > > > + */
> > > > +struct coreboot_device_id {
> > > > +	__u32 tag;
> > > > +};
> > > 
> > > Don't you want to have a driver data or so associated with this?
> > 
> > There's no need for it currently in any driver. This struct is being created
> > simply to allow auto modprobe. So it seems reasonable to leave it out and add it
> > later when/if needed.
> 
> The problem is that you introduce a kinda ABI here, how do you handle this later?

Sorry, but I don't follow. What ABI is there to guarantee stability for here?
This header is not exported to userspace (not under uapi/). Only kernel code
will make use of this struct and it can be updated whenever this struct is
changed without anything breaking.

Thanks,
Nícolas

