Return-Path: <linux-kernel+bounces-30824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A158324B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EF71F23415
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D00DDAE;
	Fri, 19 Jan 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6r31cZu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFAD529
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646084; cv=none; b=FvKUkgtGDPXy/B5lDE3xd/U3r7tY/2EKYtMVjtywoZL3T37/hjBL49uiuYTDSFI6qIzUIUG1Wa44SSpkVyaoP2aPzG/NAWJxcxIKMR7RYwOLSBJlamPU/rrgyS2iU+uVxsPNZS9Oot0a6VAe8/Y+Tmjdaot90PUR8PsfLU9QGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646084; c=relaxed/simple;
	bh=czFEItumKs/Ql1F8ROJWVp584UYw/u4AcB9xLP6NpPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogLaVZXO1OXQq/cYByUIrf71O0HoCnWq9RnsrbfeyVm7lqA0iNJQoozpOnLFbSmgtxaULh76Yejv+jpWUWfqik1kdy5emqOwKtsGUYy0CMJbrI78vtRjfAxhQkahoAeklHyM9k6lkw5HZQir4ijuSJo/aPa5gc6bVSIO9bgUqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6r31cZu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso4722095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705646080; x=1706250880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AI/YvbK1h3/SNepllsob4xFvx7VdU/1j8XDeKZp5lW8=;
        b=p6r31cZubnU+ZfQdFMDwRwsGZbrTy0IUYeKWepIuQXXB83zRZaeVjdKVCIevC/swcr
         WhJYOZ9vVrbCwh656pVMBw6ToW4XmMHy0nj5SbSfk2B8HHBPsTRozrPHC2dnocaRkAsT
         atJvU7lSM9zFQrZck2E8rP3RhzyS32l5m71eb9UmCsrE0grK0erKeaBong1VWG8q4yng
         hYbmH3MCz4QeZ3Em1QaGkDa2Cx8V6VaNRzlRnNyw5AyQ8QSddoSIUC9nV2BppRvFha31
         8+I90bVrdqrhR7aOWBDoLaCKKB5KE+igMq6nCLaD03u6KpWK0m+zy20wSbsBV+nhbkcV
         xTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705646080; x=1706250880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI/YvbK1h3/SNepllsob4xFvx7VdU/1j8XDeKZp5lW8=;
        b=JnmpO0QMqrjsUO5CmuBrMp6JXTQzE3w+rH1of1p0vWGgRaiwPk0hjlbzkCuYy287IZ
         CWcLkzJTh2QXHyWHX0yqFAGerEW8UyTVejuyFu+Xq5fO3vQ/5hxAI7YRE2m9OsgwUTKO
         7BtuiLOcW3bLwQJ5MKYvSmiw8JKEMyY7pjLCXaq0ojRgIueD/MtB8pkY+mUQa7pJQU93
         tvCI2cVs25LOZBAqfGBqbf3uuZLSJjJ2U79E+MGGwYo6c/Z8bzuuRvdtdfyOi8ERuoHG
         D6j0VdQuiN8nDus7wRk+idoEcq3ao5CLL/FFfwbKPLe6hp+VbRITj2fLVKqTvtOplAtE
         DIlg==
X-Gm-Message-State: AOJu0YwK3tfjY/IgXE7Kd+HYgwGOEw7xcTH/hD9LJf1n47J0bszs9n2T
	VBkpwNfvjIWAA1AzI/gruhH8Y6aoj3rTFvjYmOvAYUGtut7thwtD0ie2ZIg4z+huHUJOR3Zojdd
	oBTA=
X-Google-Smtp-Source: AGHT+IH1zeD+F4bB4awX7E3dtMhK0bDboWC2n5deVeGd6wbwCHadWQeKHuEZRf9ss3Fzl5vurrWpcQ==
X-Received: by 2002:a7b:c303:0:b0:40e:65d1:5aeb with SMTP id k3-20020a7bc303000000b0040e65d15aebmr1327841wmj.137.1705646079630;
        Thu, 18 Jan 2024 22:34:39 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b0040d91fa270fsm28086952wmb.36.2024.01.18.22.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:34:39 -0800 (PST)
Date: Fri, 19 Jan 2024 09:34:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Message-ID: <ce1d6680-a7f5-4939-a47c-3079e7136c28@moroto.mountain>
References: <20240118191703.89535-1-jklott.git@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118191703.89535-1-jklott.git@gmail.com>

On Thu, Jan 18, 2024 at 02:17:04PM -0500, Jacob Lott wrote:
> The current help text is short and triggers a
> warning from checkpatch.pl. This patch adds more
> details to the help text which should provide better
> information for whether or not to enable the driver.
> 
> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
> ---
> v2 -> v3: Fixed spacing and newline in text

The commit message is still not line wrapped correctly at 72-75
characters.  It should have been:

The current help text is short and triggers a warning from checkpatch.pl.
This patch adds more details to the help text which should provide better
information for whether or not to enable the driver.

Or:

The current help text is short and triggers a warning from
checkpatch.pl. This patch adds more details to the help text which
should provide better information for whether or not to enable the
driver.


> v1 -> v2: Corrected line spacing based off feedback
> 
>  drivers/staging/rts5208/Kconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
> index b864023d3ccb..c4664a26ba3b 100644
> --- a/drivers/staging/rts5208/Kconfig
> +++ b/drivers/staging/rts5208/Kconfig
> @@ -3,7 +3,11 @@ config RTS5208
>  	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>  	depends on PCI && SCSI
>  	help
> -	  Say Y here to include driver code to support the Realtek
> -	  PCI-E card reader rts5208/rts5288.
> +	  Choose Y here to enable support for the Realtek PCI-E card reader
> +	  RTS5208/5288. This driver facilitates communication between the Linux
> +	  kernel and the Realtek PCI-E card reader.
>  
> -	  If this driver is compiled as a module, it will be named rts5208.
> +	  If you opt to compile this driver as a module, it will be named rts5208.
> +	  Selecting N will exclude this driver from the kernel build. Choose option
> +	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
> +	  When in doubt, it is generally safe to select N.


In the original code there were three lines of help text.

1)         Say Y here to include driver code to support the Realtek
2)         PCI-E card reader rts5208/rts5288.
3)         If this driver is compiled as a module, it will be named rts5208.

The minimum that checkpatch wants is 4 lines.

However, I feel like nothing you're adding here is useful information.
Some of it is just confusing like, "This driver facilitates
communication between the Linux kernel and the Realtek PCI-E card
reader."  That line feels like information, but when you think about it,
it doesn't actually mean anything.  The second paragraph is just
repeated information so it's kind of a waste of time.

Don't just obey checkpatch for the sake of obeying, if we can't think
of anything else useful to say then three lines is enough.

regards,
dan carpenter


