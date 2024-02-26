Return-Path: <linux-kernel+bounces-80719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC270866BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC4B1C21CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4631C692;
	Mon, 26 Feb 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgto7MOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203531C290
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934588; cv=none; b=rreuCPjvz4Bk2o8qHf2Nbfa6uPYg9roFZ07OrO+ybMi4AQRMzK6B25SxZe0ixi/nBxPaXHB656K//G0+KsduHIki/TqJhOE/6VoEguMZdDhqjcR8rL5aWrS0t+6WroxW4yP2p72KEiiWuTgISxid8dgu3OF1ppGHnl2GgaFaWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934588; c=relaxed/simple;
	bh=BeTOLJtP9AdrBcyMBpzL9OYFKJ9cR8nzGWdiyS7Gj+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCd80ScxAUS7cpUG0OmLW48WdEj71K/b9crjJii2qLJf/kt54aKd9OUxeonhAk2J2GUdy0fpqVJ1D5NPRnU6QRsJRQ0n0iU9RtxTLTn1MDOVJfLt7nU6ey0zsxfW960irgUMoqWcQLf7Fv+pOhfrp0h5D5Q0oZKCKhMk9VI+UZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgto7MOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55353C433C7;
	Mon, 26 Feb 2024 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934587;
	bh=BeTOLJtP9AdrBcyMBpzL9OYFKJ9cR8nzGWdiyS7Gj+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgto7MOSPftYRs/CvdQZe0jlNQ0kX07dEjimQFDf87NFbLUPSxHE+zvNRJmt5BYxd
	 ia0kX3UbVJyF5JLmyACNQ7oeCtdDoFP0pv05gp39NHtbTU9YxbBotuDfHJrIQ695BM
	 31W17sEYfpVhaRn+u41BkRoauj7CIDoyNdih2UUW5ziRj4QC70BEizlNnUScGfGIa4
	 dm4aUUEHrCfrvYwapscD73+vRN1TXRPWL2+Ugb7F5aFBEMoZD+oyghpzWWfgtkra9e
	 B/n1ytflWFv1ObGUoz3EQnDtk3wQuoVSe8AG2TMPLmh77tQydQxDP34px7rmzIva3e
	 uV44/lD/UjrXw==
Date: Mon, 26 Feb 2024 10:03:02 +0200
From: Oded Gabbay <ogabbay@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] accel: constify the struct device_type usage
Message-ID: <ZdxFtvl6C/k71nbZ@ogabbay-vm-u22.habana-labs.com>
References: <20240219-device_cleanup-accel-v1-1-5031e5046cff@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-device_cleanup-accel-v1-1-5031e5046cff@marliere.net>

On Mon, Feb 19, 2024 at 04:48:28PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> accel_sysfs_device_minor variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/accel/drm_accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
> index 24cac4c0274b..16c3edb8c46e 100644
> --- a/drivers/accel/drm_accel.c
> +++ b/drivers/accel/drm_accel.c
> @@ -23,7 +23,7 @@ static struct idr accel_minors_idr;
>  
>  static struct dentry *accel_debugfs_root;
>  
> -static struct device_type accel_sysfs_device_minor = {
> +static const struct device_type accel_sysfs_device_minor = {
>  	.name = "accel_minor"
>  };
>  
> 
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240219-device_cleanup-accel-a990dc3bfbc1
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 
Applied to -next.
Thanks,
Oded


