Return-Path: <linux-kernel+bounces-66975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9107856441
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C79284664
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F6130ACA;
	Thu, 15 Feb 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSDhS1YO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2112BF06;
	Thu, 15 Feb 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003497; cv=none; b=uLpW4XhDjfV68xXMvVFpol8MkDGSCL/GIkvir3xDrFvEfQ8JDrYmhq4Ot+Yh4zBrGHAsE50HMNUtZWioYx4Kqa/0ikLuZ+GiXeczUy8i1qTwVBZxK+UAKZdnRXKCmLmMjhsxKA6lM2WvhoDgDgu2xfT7v2XZPLc/EUmSyafv/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003497; c=relaxed/simple;
	bh=dVWZ7XC8Bsa4pc+c3+j3S7F3I3R6y7tOlISgXML4etM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2wgaca03yT7FZYAt519fDCrCQfhTPiGsGWa3wCmMndoXrPzsRNq6B0Je+L6F/KTzIWkIu6g2gJQjWL6lZpWn7gImNNU3sxaEpunOc+WWrM1hMQ4tDlWxAY+KTKhmV9JGccQVJ+ClealpD1E/y7GQyAiQAcbMHInx7kApXJp6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSDhS1YO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so10162541fa.3;
        Thu, 15 Feb 2024 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708003494; x=1708608294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBFzk9n9e8hP3AO0PW5gELJtQWfG/R8SgLTxadaovn0=;
        b=gSDhS1YOU67Yfk0E4Tj/dSj0goL/XfJdk8R0dDu2ggErxleFlhdJC5zOFfiJe9gPD5
         7jiW/2BXcIH1cG4TFlPPYEHzLdM3oP/D6t26CC0frnxWmGltRLZf5RmyVECk44dGHuhc
         /nBdNMCG9V9NQ0gqCzpcqlzGiNB3mNKif+mpcl6zWkY4fOdga6D+HZzLJPuUiBWBl/8Y
         wjbW1P5/5lcd9934bZrqrG9weCeoJ/V+5t0SdewWV3pLmRA6IlmEUtrXljmuqq2T7PHp
         8RzzNLDiNklrsx0SqiCm6iioyKmw3vD6l/i+4iWkGcq7RbveLcK6ZlOT+VlnAj2XoKWI
         /NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003494; x=1708608294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBFzk9n9e8hP3AO0PW5gELJtQWfG/R8SgLTxadaovn0=;
        b=AzUdItp1q47dyPu8oCqZOBhoBHLGdhjG8ummGkW/BGPgDvcTlqli90s6KQtW0z54Ge
         4oVRMSBV9cHZaImFm992+KYAJpfldnHhJw6ciEaIxudNq1N9y4TXBTtLm57/T8cYsh/V
         clFlOxh9P6s+sEbysyAGzemSIjQyN293HRPpXeIaF48K4MjVdp4CwT04mnjJnfAVPDg9
         R7R0rlwhwy7OjFeUilhZgkaVb6vjko0LHhPMoEvplczaZrvcxJXiURXbY/oQy8mjJryD
         Y+zi7aMsjXOrTc+8M4NQNxFV1xq35s/jUV1gmGEbxCU//9yP8lKU1uQutZGwdmCdMdcw
         wE1g==
X-Forwarded-Encrypted: i=1; AJvYcCXGHP6NM7CGhQOPFLj8XGheY6TkgSIQFqGygsjRNPoiRwib6SkfkKgl+n4Wd6vz7mU+Dke6vJfPMez88KN9Bb2C26NBr6PJRRgMFeXdP8eyiOnesWKoW4tZPBzf4tTxu02DFC78dhzc5A==
X-Gm-Message-State: AOJu0YycR8jxUcdEhBhXgZLXNeeVAnS9yROh3ZDrN9NaRtCbe9vgiU6A
	VOBBvIxkHCSvwjjjWY4clpvhahthukE7f9HOGCF2YI8ndg1mwYZg
X-Google-Smtp-Source: AGHT+IFafSl81GHTEXkSCceHreMy6tyg/yG/6dTdaKL7VhusoVES06RNV6U6QcEIjfK2OhJTbEw4hQ==
X-Received: by 2002:a05:6512:3e16:b0:511:79ac:2d78 with SMTP id i22-20020a0565123e1600b0051179ac2d78mr1711649lfv.39.1708003493896;
        Thu, 15 Feb 2024 05:24:53 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t20-20020ac243b4000000b0051197ffb6easm236919lfl.122.2024.02.15.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:24:53 -0800 (PST)
Date: Thu, 15 Feb 2024 16:24:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mips: bus: make mips_cdmm_bustype const
Message-ID: <guhq6wbnkeoblg447jcr2poq3bqzhf3jmwofgcd5ixbd4f7pjd@ig5potko2a2u>
References: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>

Hi Ricardo

On Tue, Feb 13, 2024 at 11:49:24AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mips_cdmm_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.

Thanks for the patch.

Tested-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  arch/mips/include/asm/cdmm.h | 2 +-
>  drivers/bus/mips_cdmm.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cdmm.h b/arch/mips/include/asm/cdmm.h
> index c06dbf8ba937..81fa99084178 100644
> --- a/arch/mips/include/asm/cdmm.h
> +++ b/arch/mips/include/asm/cdmm.h
> @@ -63,7 +63,7 @@ struct mips_cdmm_driver {
>   */
>  phys_addr_t mips_cdmm_phys_base(void);
>  
> -extern struct bus_type mips_cdmm_bustype;
> +extern const struct bus_type mips_cdmm_bustype;
>  void __iomem *mips_cdmm_early_probe(unsigned int dev_type);
>  
>  #define to_mips_cdmm_device(d)	container_of(d, struct mips_cdmm_device, dev)
> diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
> index 554e1992edd4..8baf14bd5eff 100644
> --- a/drivers/bus/mips_cdmm.c
> +++ b/drivers/bus/mips_cdmm.c
> @@ -118,7 +118,7 @@ static struct attribute *mips_cdmm_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(mips_cdmm_dev);
>  
> -struct bus_type mips_cdmm_bustype = {
> +const struct bus_type mips_cdmm_bustype = {
>  	.name		= "cdmm",
>  	.dev_groups	= mips_cdmm_dev_groups,
>  	.match		= mips_cdmm_match,
> 
> ---
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> change-id: 20240213-bus_cleanup-mips2-434cc6d8f7bd
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

