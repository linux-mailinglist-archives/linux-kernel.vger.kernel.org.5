Return-Path: <linux-kernel+bounces-58425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298984E660
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FC528272D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24574823A1;
	Thu,  8 Feb 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9zA4kNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6277C0A9;
	Thu,  8 Feb 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412219; cv=none; b=ZTp9KFLFP261yZKTpZaL3VqidDt7kQXFpQgsliyzV6xIdoE5wk0pSOyrUNnwsU5mUrUj4354jBK5Js/Sq3/KPclM9niAUllJb0JNk81Aa8YNGwYgoIWQoNod4ZuyzgVuXTl2KXaaklsNb7gIhq9OfRNKXES+AArrctNHRSe1FoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412219; c=relaxed/simple;
	bh=IOWSzMMlO8YnqPbPdbrgPuZBehBM3plhMgRmZTrstpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz/P2m4VFdpDeqZzCrn01+v0SAKdlgT7PRtC9Ff4/cCcY9FgFZmu/YI1wYp//r8D8QB27JZmJQyZhLrUFMWRSrXk2gs8jQpxStwYDbvCcrV5SN/g0Gju1UNNmvSI0H5NaBdpXE+jk4pKap2XU8x/zBnOiB5Lf8wegsqDFy3t8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9zA4kNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40978C43390;
	Thu,  8 Feb 2024 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707412218;
	bh=IOWSzMMlO8YnqPbPdbrgPuZBehBM3plhMgRmZTrstpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9zA4kNi3LDmXYPGblJeqbGXFB0y4GLSR6Sea/138sxNx07IiIBW8UN4/Qw0OFRJh
	 aYH0IFxoAAaNMQPano/vow2LQnB6QO1ngCB8k/7CadBHz2Kfoz6VZw9ug47zyrtgWS
	 vlv25aHnv33AK3Td76bto+j0HlWjcOF0Pdzh4BJheR7YFaAHqzu1O+GTbEBglNqfPD
	 OaAfCQsfYckoroCZZLweLdWLWJWLYqwhxgp5jU+tXYsBBizx92vDj0Y9C86MIoG2u8
	 VC2Eqz1rMd0ntjeArBMnULFuQ9EXS2ZlhNvrtjVBpJOtJFE/IIQJXCeP4rGVg4hNdI
	 b+Pq4UG0UKXww==
Date: Thu, 8 Feb 2024 17:10:14 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/4] backlight: hx8357: Clean up and make
 OF-independent
Message-ID: <20240208171014.GW689448@google.com>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
 <20240208105304.GI689448@google.com>
 <ZcUKmlbtyktnKhLr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcUKmlbtyktnKhLr@smile.fi.intel.com>

On Thu, 08 Feb 2024, Andy Shevchenko wrote:

> On Thu, Feb 08, 2024 at 10:53:04AM +0000, Lee Jones wrote:
> > On Thu, 01 Feb 2024, Andy Shevchenko wrote:
> 
> ...
> 
> > Someone may wish to address this:
> > 
> > WARNING: DT compatible string "himax,hx8369" appears un-documented -- check ./Documentation/devicetree/bindings/
> > #58: FILE: drivers/video/backlight/hx8357.c:636:
> > +		.compatible = "himax,hx8369",
> 
> I can do it if and when have more time. But apparently it was before this
> series, right?

I'm not sure it's ever been documented.

It doesn't affect your series in any way.

-- 
Lee Jones [李琼斯]

