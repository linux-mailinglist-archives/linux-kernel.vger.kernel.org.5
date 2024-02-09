Return-Path: <linux-kernel+bounces-59091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D684F116
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E627B1F22F11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2265BBF;
	Fri,  9 Feb 2024 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLK4L/AZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70465BB5;
	Fri,  9 Feb 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465293; cv=none; b=TLMjmV1Pwdv3j/k14lZk6wqFHepDMXnH+A98v/S3PZfarb07roE/RKWtuZgw68uYEqqKHkIQlg1zByQDgu8sH2LSbTT/r/+Udky+OqQ34+AA2wukglU2PeIA8eei9XUE4pk5tQXdmZyfSu03a/ymTCwZLlvnCbSIGePCLbb8om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465293; c=relaxed/simple;
	bh=uea/SUE9zxpAMSQg4UhoAlPttpgNpN2dVO157l/Z6Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFWOhFabTZwJceUKL2ei8ILVlpitRE+MjJKsogJZTO2B6J/09aCoSew/bpHPOsRH5tuPHIvf7h38bA/Omu08zsiyfzubzpKQqIBLjpfftF2Xjbo30K+ZdEYkgM7Nb5ZPg1VV//c29f/wc8tCp/7lbzu6I6yKEY+tTXvKbAirz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLK4L/AZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F14C433F1;
	Fri,  9 Feb 2024 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465292;
	bh=uea/SUE9zxpAMSQg4UhoAlPttpgNpN2dVO157l/Z6Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLK4L/AZANA7cB40pNOTkyaTAUBur1mtsh8clAHNSfCdaxV0T9TiSgs7nYdov6kFG
	 9D5JA6KnKUwM04aTWD9fxLxcFoc+3Akg31TEeXNIBv9S3EHfCJ9mADXx7X826fPUOD
	 0k3K3CdAlZBFqwQ4XQwyCjNdji0EA2m9nhrkujI5LTd+FuMohOkBZlVwZ0g1A+0rf/
	 HazxtyEuAGvzQzI66y5GT30MvaIBnywABD16DG1gNEgwYFIX5SBxzArBI3wktOKgB6
	 CExTIVLVLLdAD8BjEsP6PMGeReZPBB3miajBhI9O5SqYyMZxnbPNzfRfMCerVpciDm
	 6ZY6adqeIRZDw==
Date: Fri, 9 Feb 2024 07:54:49 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mfd: tmio: remove obsolete io accessors
Message-ID: <20240209075449.GD689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <20240209015817.14627-10-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209015817.14627-10-wsa+renesas@sang-engineering.com>

On Fri, 09 Feb 2024, Wolfram Sang wrote:

> Since commit 568494db6809 ("mtd: remove tmio_nand driver") and commit
> aceae7848624 ("fbdev: remove tmiofb driver"), these accessors have no
> users anymore. Remove them.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/mfd/tmio.h | 25 -------------------------
>  1 file changed, 25 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index bc53323293a3..4223315d2b2a 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -10,31 +10,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  
> -#define tmio_ioread8(addr) readb(addr)
> -#define tmio_ioread16(addr) readw(addr)
> -#define tmio_ioread16_rep(r, b, l) readsw(r, b, l)
> -#define tmio_ioread32(addr) \
> -	(((u32)readw((addr))) | (((u32)readw((addr) + 2)) << 16))
> -
> -#define tmio_iowrite8(val, addr) writeb((val), (addr))
> -#define tmio_iowrite16(val, addr) writew((val), (addr))
> -#define tmio_iowrite16_rep(r, b, l) writesw(r, b, l)
> -#define tmio_iowrite32(val, addr) \
> -	do { \
> -		writew((val),       (addr)); \
> -		writew((val) >> 16, (addr) + 2); \
> -	} while (0)
> -
> -#define sd_config_write8(base, shift, reg, val) \
> -	tmio_iowrite8((val), (base) + ((reg) << (shift)))
> -#define sd_config_write16(base, shift, reg, val) \
> -	tmio_iowrite16((val), (base) + ((reg) << (shift)))
> -#define sd_config_write32(base, shift, reg, val) \
> -	do { \
> -		tmio_iowrite16((val), (base) + ((reg) << (shift)));   \
> -		tmio_iowrite16((val) >> 16, (base) + ((reg + 2) << (shift))); \
> -	} while (0)
> -
>  /* tmio MMC platform flags */
>  /*
>   * Some controllers can support a 2-byte block size when the bus width
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

