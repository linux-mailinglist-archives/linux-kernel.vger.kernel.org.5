Return-Path: <linux-kernel+bounces-117610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B488AD26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB40E1F28164
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E26E616;
	Mon, 25 Mar 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCwGXHPw"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C06139
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388124; cv=none; b=rxYOAqsjP6bTtaw4nMwhCVsDiRNX9guBKMKh7t+o8SuqXLgC1je253qvGqFkNjREoIi904ShGDkfnfl9jqVOqomfl7uzwT2VhhGQOm3gl1IJkCAPCfmQNtaPfhEQpaW0+Ye7vMRRTULnF//DXPbX7I4GYsC3de3j/kIjjGW2dPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388124; c=relaxed/simple;
	bh=EhHuTIICMiNebrcaKBpJloOK+ZXkPyR3XTExpFvyj6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISHrPbBCkbylDaA1lDyXivmxNfXQ+t1zr0buAHa5XYwQhA1W+iRUk3fp9t6LXXLMMi6bEGSZfiokhUju6opKEuG/Deb/3jC4x/X9/bsypWZVw+xDwcGZpuQWk6iXwITDrO8uPAvzwgho+XADMaH70YPn5RK/DnJ4SQHTTzfkgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCwGXHPw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1746498b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388122; x=1711992922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzF+lgkb0ir28BnAp73sss6tn3/k0jKYv3IBew2dq8E=;
        b=FCwGXHPwSgWyKCKGm4Udlj3ZSVQoNXyOQe68y6HJTO8qKWQSW8w402aslYxKW9Hubr
         MlpO9PFslY5wApVntAQK9eynUbBQeL9ULCWE4cX6roGK9xoCAHgD4YlLOR6rgsT5Wo/3
         x0Z4NmfWXRJ+wP3dK9KSFGDHxIGPxSaFU2TwdZ9NOeFNBfNHPDAi2p5km+MLLhLc0nVX
         lMHZIjw3wcsxTmnpd6YZRZgNWCHOcPJzxMrOA0m12WGVyVWKEcgpFn+ZRdG9C3vYLWER
         cP+cZXy2qpWX9dj0fpyhlLtIZN+8+nFQTzsTWLsqwLaXlaAiFT/VSC9kuO3lAQpt6j5C
         DRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388122; x=1711992922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzF+lgkb0ir28BnAp73sss6tn3/k0jKYv3IBew2dq8E=;
        b=vkDd/Vnp2eT+eLQmZZH+4grN9IQGAYXemaW8qS5CdpHUDzkLQgbqtPpm+tQ0GwjkEl
         of4w40Oz9ouJemVzyVYR96Jgu43ZNhXpO2vHhd4g2pVCF63cPFbJoZuUwq1dIFXjEYOP
         C8o9IjAW6nhgJzKslHhnMDIJDMCCSGpqzPqPaf9zdNAppY/dJwyMUuw1IM5bHmExbjJZ
         NYamkfMxfs4BXAGkPGUQj5qW50Qodu8t/wE0e0oW7uP0j+PuNEpMJTn74lbwQrz6kvA9
         3VKdziH2pYbXiMHUAY122VTK5AdFouDWPFAdUMGwxc/hdLOROHxVBOuQj3KbYiye9vMq
         A5tw==
X-Forwarded-Encrypted: i=1; AJvYcCVPRasu93R/VP+4s9ICCtzVKgNkNDGvRwnNUHfd58DPutQc/zpYpGjch+JxLu4R6U6zB6ZLaxx1hpaSKI9lyGtDGcM2tPcmz3bQD52t
X-Gm-Message-State: AOJu0YzzGs+ox5mY3w78GoVDu1/5HnzeMh7YPnIIY++1+poA+4GT6d2J
	vuEnWsdauPu82S02163JJrvzVWwrvMzHvQur5oJJz/cRJ9Zqf29Y
X-Google-Smtp-Source: AGHT+IEte+NB9U4XeW2eanuOTyUmngFol3kns6MrJGPxJiZ7izDfdDa1LPP9idQCWzhEM9cDvDeoFw==
X-Received: by 2002:a05:6a20:96da:b0:1a3:53e7:16da with SMTP id hq26-20020a056a2096da00b001a353e716damr5778817pzc.15.1711388122306;
        Mon, 25 Mar 2024 10:35:22 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b006e6b3c4e70bsm4711620pfb.171.2024.03.25.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:35:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 07:35:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience
 function
Message-ID: <ZgG12HiYSowiTtTy@slm.duckdns.org>
References: <20240228181850.5895-1-apais@linux.microsoft.com>
 <Zd96XzRHI_jMOCip@slm.duckdns.org>
 <CAOMdWSK9_1LMA-ULLa-iZ26P75UCOrO4gScAqmYvqbrvJi7wSQ@mail.gmail.com>
 <ZfIIUyip4U-hGZ4l@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfIIUyip4U-hGZ4l@slm.duckdns.org>

Hello,

On Wed, Mar 13, 2024 at 10:10:59AM -1000, Tejun Heo wrote:
> > > I'll apply this together with the rest of the series once v6.10-rc1 opens.
> > >
> > 
> >  Could you please let me know once this is applied or point me to the branch.
> > I have all the conversion based on this.

The enable/disable patchset is applied to wq/for-6.10. I was going to apply
the enable_and_queue_work() patch but you wrote that you were gonna update
the documentation but I can't find the updated version. Can you please send
the updated one?

Thanks.

-- 
tejun

