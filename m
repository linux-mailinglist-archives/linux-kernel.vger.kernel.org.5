Return-Path: <linux-kernel+bounces-163395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E138B6A36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DC21F2125F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C503179BE;
	Tue, 30 Apr 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMVhJCWr"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098A6FB1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457510; cv=none; b=b14WKnNag5F+UbvF5UsuJ9dV1aV9f2/0ZFp5xjAJexzqhR0Kw3vCi4s+h3ZcSU2hVtyI3bz1WbiicBTs08I6tq/SNPpiS4gjdZNPiBSQzAkFEkXlq+BODLWJ7reDsKD44fR49UD/Ot5/WyGjhwjcghjp7wUX1gxx/YiDZa/VHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457510; c=relaxed/simple;
	bh=psg9Kpeg6qV+BBr+fxz/JG1CvxbYdrB+PuGi+plXzOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9ExiIIruRieUcCNB90juelhXVwQa78RBDf6wxTXH/L0kKs5/jhbYyd5LbyuyGsVlemY8sJtrFWza1m4vMcUV/XvCMR9EkIOIgpsCXaj2Sa41fFWjCkkwy5GvuJDfuDR34P36n6EKlGHOzTPOeAFl+hJrrqQK+FqzBrndkOXCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMVhJCWr; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ebddef73b5so698595a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714457508; x=1715062308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdlhGpDQ/fVaiM+yhWQ/BVMI6K7d3d/5VJV5GnOrrmU=;
        b=ZMVhJCWrXatAu9mnUZe38dX+9Kc3pp5W/ZAQtPiYX34YNALFZtdw4AISf2NLOkEQV3
         gUH4KnAei8ZMJEmeHsVaAFxhXC1iUV9GKmQTJZ2sghLVFwPtmh1Qj744CM3Gj8+Yv1UV
         E0Y8VAsRYf2n0d8z1AA6VnhWZ9NS6ZJZAP6F3m9bpvljmkoiQxmTMSGH3Go36b37cW+A
         +OUjy5bjZSaNvWjN0kH1DbWh5Sp9jsqu/P8llcqRPyD6udvMFMUZQdKDh6KDifOLWFyD
         hZYvBHGryatN23yTX/OY361lzokzDMdtrrX5CBIDJvfyX7iEUAFMSvd5/EBpr41S11HP
         1eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714457508; x=1715062308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdlhGpDQ/fVaiM+yhWQ/BVMI6K7d3d/5VJV5GnOrrmU=;
        b=nu0wCXr4Wh8mfbBLaHC079Q7z3CXbgmth8cQGZDwTq+1UULKnR3SIJciaoZ/3fXiQB
         OBSiSFX9xJHFuOxTCLqPiGO0Z3za+S6HQ21tk5WLHDHtVycGVmHqo/5LmiXI1tseODib
         7+ghmOlB0WdmyhKeTp9MIateVp4IAV+mCmfWNigsF9W/VVYpCB+ANbhryJsaDvHbPfg+
         1eJaLlcAle2qibdTn4eumdV/fBmCWEFi160qm0d6ipWYPempvMmXKjmSILIispRGUz+f
         bVHJQ5HSqDutj8UgQsJ5R+fGWvbYDI5s+uxG8SRR7Up9erHCuczpwPMO/XRGXfBMs2d0
         Nj6A==
X-Forwarded-Encrypted: i=1; AJvYcCUKuOdQxy8BA9lj+r4LgW0OXulCyhrZ305yF3K7K91C14hzc9Z608j0GkvOnzZMLCYWERhO0O2xw6zmxiN5kqDgABqSWoHYujPAL3jv
X-Gm-Message-State: AOJu0YzoWJkSZO7CWP7kJf1Dr9qXTBXappWKq5/a8Iccd/Yi1chhdriK
	Truptkl5kIKoptD4dTT72ZGYRBEsoVWrH6ZB95U7WNedXmzqjKY9
X-Google-Smtp-Source: AGHT+IEqJGULwIsbmh3QLq4pnKmO5kpbIw9oXzoBKlS6olHb2Emg4rIgj1yS7bE+MEWT5t60DZB4fQ==
X-Received: by 2002:a05:6830:100f:b0:6ee:29b2:c2c5 with SMTP id a15-20020a056830100f00b006ee29b2c2c5mr5963096otp.1.1714457508264;
        Mon, 29 Apr 2024 23:11:48 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id m191-20020a633fc8000000b005f751c18d0esm20180088pga.86.2024.04.29.23.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:11:47 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:11:45 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org, yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] bitops: Optimize fns() for improved performance
Message-ID: <ZjCLoeFE6xoNaRWt@visitorckw-System-Product-Name>
References: <20240430054912.124237-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430054912.124237-1-visitorckw@gmail.com>

On Tue, Apr 30, 2024 at 01:49:10PM +0800, Kuan-Wei Chiu wrote:
> Hello,
> 
> This patch series optimizes the fns() function by avoiding repeated
> calls to __ffs(). Additionally, tests for fns() have been added in
> lib/find_bit_benchmark.c.
> 
> Changes in v2:
> - Add benchmark test for fns() in lib/find_bit_benchmark.c.
> - Change the loop in fns() by counting down from n to 0.
> - Add find_bit benchmark result for find_nth_bit in commit message.
> 
> Link to v1: https://lkml.kernel.org/20240406235532.613696-1-visitorckw@gmail.com

Sorry for pasting the wrong link, the link to v1 should be:
https://lkml.kernel.org/20240426035152.956702-1-visitorckw@gmail.com

Regards,
Kuan-Wei
> 
> Kuan-Wei Chiu (2):
>   lib/find_bit_benchmark: Add benchmark test for fns()
>   bitops: Optimize fns() for improved performance
> 
>  include/linux/bitops.h   | 12 +++---------
>  lib/find_bit_benchmark.c | 25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1
> 

