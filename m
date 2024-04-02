Return-Path: <linux-kernel+bounces-128388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F2895A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CB1F23B62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D715E5C8;
	Tue,  2 Apr 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWxNLNJQ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667C15AAB7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076424; cv=none; b=BKznkjDyw/jOTzruVLNPmbdtgdD2wKFoW/ks5j6C7thHGhP8nzQ6xndJP5WNh3Kujw/68E1GB5LeS5rF5k2JSqQMhPKpZ2nFv1HCBrnOYq39zSH420xWlRpbvJZZPeD54DAACXIIuQyFgnsm5LO98RVCIMOmDLGTBPPJL7pPvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076424; c=relaxed/simple;
	bh=wueQqgHgNfobgMl7ngnx77rJxYOAca9buPv+PhcY45A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUqWsoa/4sIZy0QskeWKPmWTCV53mW3l5kNioO4JdTQw2Dge9X/tgpCeAUDnAIYbELSzYKXjrogNSdh8pw/SJOQ5fakAC1bhkXmPCVDhzHbOEOeBkZu1oDxgCPo9nIgTIy5RUA1TlPBhgGDxEFEL2FyedQYERMnifCbSjwvt5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWxNLNJQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56dfb52d10cso328542a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712076421; x=1712681221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgRCLxVPL6foOssar2VbNFyHEq1eN153oN+Bgv5BRW0=;
        b=WWxNLNJQxYUF+kOo4phobOc1IUh8y+fcIOKL+x6oQds2MkQv1D0XzmsJhZY0bI6Vj+
         1VfPVWo7YENSoZggkXvDxqwRyDP08yMwG/Chtx4E/KF+Z7c1k7Z0NOxgVUp1CICbEDWC
         K23qLvGrgSYEXq/f4YiniASvNDy79d/gLD/Xn4MGr+Im41QKv+ui8b2P/Q4KJ4N+hYg3
         CrNJcssrYi3wBV1JaObF9Cb13WWQfXaOmBn90d5scYcB7inhQItKijV8ync6eAmAtr09
         clEUTI2kkH8YHblvca1lSYBPiQCVA03A+s1buoMsuRLVt/GXDBJBCFJQ+IwNeFuPDMeQ
         zQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076421; x=1712681221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgRCLxVPL6foOssar2VbNFyHEq1eN153oN+Bgv5BRW0=;
        b=wBqH2M1I9xRRr1CXwyb0PmrrF+AvwWkgdGb1/++GajsURNwFOykmpgeZlXoj5ENEX1
         abDoRfoAOJ7ZOoHcACbwDKUJ1Avz9t59U/sUzYJOsxv0Xr5coP+y76YakCEXavBu8amY
         VTbffRO6mDBT5Vc07fCxVR+TThRibaBOiX9e/wZ5+g5O4YGjjTOd3JiVHuCPGEBlALm9
         eGMQohBXmq/63AzPG6WIiU1KxqX9vIzFiEjSwmgCdPFgHGlIAIVMzpjpa5zPHXQ/vYBF
         vnJuPkNGj78Ok7wyxfX3iUtXlB31hq8118V+Wfo26YDtmi+PGIqWhiuxeF0DU+vuoOXj
         ajdA==
X-Forwarded-Encrypted: i=1; AJvYcCWWxWEl2jm9FotPEies9tU/gUQXh10iaalYbBahVqmZwypVG5OrqbtSv0PNQG58kHvCtK5SqP6FLnGuGrj7UwGR/iq+LwpXcLO38re4
X-Gm-Message-State: AOJu0Ywk08Xfua4r0kRkNd8XvBspDAVOr7sV/4co+AI8eoJR2m0rIAnp
	6M9T1i+xKd4OWySZxfEGM0Zptuy3RMzi1bVhVemQGqko3QHqqHw5R/NaYqtRcOg=
X-Google-Smtp-Source: AGHT+IGekWANLpkZC1FyGzuPjK1/7OE3EWko5UnsSDR83c1+sNGh3cSBNrv0Gf8ykz8Q1y1BRVVhOg==
X-Received: by 2002:a17:906:d9cc:b0:a4e:109f:7b4b with SMTP id qk12-20020a170906d9cc00b00a4e109f7b4bmr8891710ejb.41.1712076421210;
        Tue, 02 Apr 2024 09:47:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qf31-20020a1709077f1f00b00a4df4243473sm6683790ejc.4.2024.04.02.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:47:00 -0700 (PDT)
Date: Tue, 2 Apr 2024 19:46:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] staging: pi433: Remove duplicated code using the
 "goto" error recovery scheme.
Message-ID: <068f3705-9f9b-4d61-be50-a131b9598703@moroto.mountain>
References: <20240402111414.871089-1-ikobh7@gmail.com>
 <20240402111414.871089-6-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402111414.871089-6-ikobh7@gmail.com>

On Tue, Apr 02, 2024 at 02:14:13PM +0300, Shahar Avidar wrote:
> pi433_init had "unregister_chrdev" called twice.
> Remove it using goto statements.
> 
> Signed-off-by: Shahar Avidar <ikobh7@gmail.com>

Your commit message needs to mention all the other changes you made,
especially the bug fix.  I feel like you're doing too many changes
really.  Just use the gotos to clean up but don't re-order the calls.

You need to add a Fixes tag.

> ---
> v2->v1:
> Followed by Dan Carpenter's <dan.carpenter@linaro.org> comments:
>         - Remove empty "fail" goto tag.
>         - Reorder pi433 init & exit calls so they have reverse order.

Keep the init calls the same.  Re-order the exit calls.  It's a bit of
a gray area if you can re-order the exit calls in this same patch.  Do
it in a separate patch just to be safe.

>         - Add "unreg_spi_drv" goto tag.
>         - Check "debugfs_create_dir" return value.

No.  This is wrong.  Debugfs function are not supposed to be checked.
https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

>         - Update "if" statments for consistency.

I like this cleanup, but it's not worth the effort.  Just leave it
as-is unless you really really need to change it.  Do it in a separate
patch.

What qualifies as One Thing Per Patch is a bit of gray area.  Greg tends
to want things split up into tiny patches.  You have to know your
maintainer.

regards,
dan carpenter


