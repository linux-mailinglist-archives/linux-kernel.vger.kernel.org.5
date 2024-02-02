Return-Path: <linux-kernel+bounces-49900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612B84712F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E0F1F233D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCD46551;
	Fri,  2 Feb 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A06cgDmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DCE46448;
	Fri,  2 Feb 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880632; cv=none; b=DfZhxaDqNbldsUuwOPWEmmtwSf166PtMt2zUMJTKZCeBMqX3Rrk0fLPK1i8gDD/43vpGvYTom8Ov7AjagYk6AsLHVxAPvICjBYTyrvoeme3BzuZAZofULn5f/YdjcNe3Fa9BszzXrdANY2xqgzGz/1EJm2vsUPOsWNeBz3DC1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880632; c=relaxed/simple;
	bh=Up+XWB/zKXHCgm15f7dpGbvm8vMJ0y4JyEQDRIXfhYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4rdLhxHnGbCacvDMiuB5GxNQ5jj2J3zWlUygT9f5n13sk8jEl5kjRvsTxG+0c1NWkrd8i0vcJ/KiKlSVq4BJGzn11B7HgUjiRdF3SM3kzyYFN38yIhbN6wCJtE05ILCRDW61wIFcP0HXOtuvWv58nn/IAnRLt3icxw6ZiTjPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A06cgDmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038C7C433F1;
	Fri,  2 Feb 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706880632;
	bh=Up+XWB/zKXHCgm15f7dpGbvm8vMJ0y4JyEQDRIXfhYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A06cgDmQ7djvvPlJx4PMgdYm/JURfxYGRcmQ9WJkAmcnyTjmidvA9ZmxIH9Z+S/xc
	 4atlDQNGJvLQnMIDSYsiciEfC1cMdes3bQc66f7zKbC2ivh+xHpQOKrZmIQoTqQ394
	 CQlJAt3A/jcRbpZnVS3aozv1KIiR1boXTo4WmYmmJPXyZ6jkyIwD7DVrnMNUzssHKy
	 2kjAJ79hkWXLsl7Eln2410KwwXUQnylp50ic544POdsbvibJyRkTRZvgDgefvFZFnZ
	 QQQKWHOHIGsmNij40PKNIM7HpioViNaKQMtxGDxP7bY09Wt637hqlIj+AyxN+LDcun
	 c5mDsxBRLNYAw==
Date: Fri, 2 Feb 2024 14:30:27 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH 1/1] media: v4l: Fix link frequency helper's kernel-doc
Message-ID: <20240202143027.21fe3f5b@coco.lan>
In-Reply-To: <20240202064007.50545-1-sakari.ailus@linux.intel.com>
References: <20240202145412.336db5b2@canb.auug.org.au>
	<20240202064007.50545-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri,  2 Feb 2024 08:40:07 +0200
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> Fix kernel-doc indentation for v4l2_link_freq_to_bitmap().
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: a68e88e2cf9e ("media: v4l: Add a helper for setting up link-frequencies control")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Thanks for reporting this, Stephen.
> 
>  include/media/v4l2-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
> index cd2163f24f8a..602738f7741e 100644
> --- a/include/media/v4l2-common.h
> +++ b/include/media/v4l2-common.h
> @@ -563,7 +563,7 @@ u32 v4l2_fraction_to_interval(u32 numerator, u32 denominator);
>   * Return values:
>   *	0: Success
>   *	-ENOENT: No match found between driver-supported link frequencies and
> - *		 those available in firmware.
> + *	those available in firmware.
>   *	-ENODATA: No link frequencies were specified in firmware.
>   */
>  int v4l2_link_freq_to_bitmap(struct device *dev, const u64 *fw_link_freqs,

This won't do what's expected at documentation, as Sphinx will just
fold everything into a single paragraph, like:

	"0: Success -ENOENT: No match found between driver-supported link frequencies and those available in firmware. -ENODATA: No link frequencies were specified in firmware."

Maybe you could try using (untested):


	* Return values:
        *
	* * 0: success
	* * -ENOENT: No match found between driver-supported link frequencies and
	*     those available in firmware.
        * * - ENODATA: No link frequencies were specified in firmware.

Please test it and see if the "make htmldocs" output will be what it would
be expected.

Regards,
Mauro

