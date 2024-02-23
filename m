Return-Path: <linux-kernel+bounces-77831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EA860ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0897C1C226DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728112B6D;
	Fri, 23 Feb 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMpXSkZb"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB3125B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669381; cv=none; b=arxKUSkaumYXkSqwUNg8gDDWK0nx9oXob/tgvv3NQwYRt05Sno+0TwMYVGyaENOJsi+YHwQljMbZ+o1zWMFdcjw0W7SSoPGA5O0PVORMXI1+Mk+5VRUoS5qbqGb1q6GDaGEr4yiv0zCPJXCBv8KYBBhMNZ3U5do+h58QHZf7UD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669381; c=relaxed/simple;
	bh=AX9oxt6B9wMaBuLFUI8N5oFAyPd6rbG9n52f94vBke0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQVM8xli4qQJCwKwzEIRGwzz2nu0nFauHlP2VD3Oywxs/En/pNwKNV2ky+Fd4UHV62EerPjbJMErQU2MIrKu/eBQWxyOuEwB4pH2xjgFsibqShFPAPSAX5hjqxbzB4Xqn3w9sdzwJV+eQ9l4yR1e+leeeMXERByjuKSI4i78/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMpXSkZb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d094bc2244so7019901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708669377; x=1709274177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=268DV9U7LcwPINqCZdWz9PHiwRjH/TLr0CgKKPfJL0o=;
        b=nMpXSkZbWi7n2taePZ4gWG6l9jgC31xdKgsQXmMbP1o8q7T/NVWNpsGDH2TOY8wKT+
         dILNEiupQvzVPp2ooIM1sr/Qz58ID2tjKcUJnovMtgTJS1lnauouNk5D/scbebIn08HD
         ucpQfArnSLQpDnq1TXT0UUUuYQUhBVDlMtrJr6xI/iew5p2a5Sr63IPQBqM/F3xFl6MF
         yskSvKPBm9tXim0uVS3E7+KOHFAI+90PGUxr//SS26j6400mY4JZ9dQBj3oE2uxgyek3
         Xjot9wikCOAhAN26iXZy9sce07vETI1Nm5Lb+2iDDo4pOeNt5HxdMhQMAqUyx/mcMz8L
         6DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708669377; x=1709274177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=268DV9U7LcwPINqCZdWz9PHiwRjH/TLr0CgKKPfJL0o=;
        b=deP46IYaykqJvG7G7Y5l65CvI5J9jIDN31zy0U96Q526yARLE0VwFgUF0GL9fb5JtY
         FPSBC4UisFm7OTIfPX75ZamiDRp+80TBDJJM72faH0u7vwNM78hxORksnJIcYIHMPEXx
         jktBunJzxS0AGa/oXg6SeGxze/ZA2XUBadDyDxpVAvSyLG5KWhyBa0/HQM/YMmrrSgL9
         YZqDugzKvAAHJno2AdNbESrl13EUNJ3XUQjXeUQxq4HTd5TI6ITwHZYf3k0Ef2ZwW9RS
         cdg2+NOXjvsunqnq+vZrNc72CXe6GnisGtesXH9AcC5dze29nDk1piFgqvEq2mo8fe3m
         XJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCdWmioVQ7iBOaBI43zenE5VnEStLzhOST0DgzBrBwADTd2QTadL0wExDEgPxzi+S7q+VqLy4q9DiW2AlbsAF3UlqyBI2PLxgbhc4A
X-Gm-Message-State: AOJu0Yx/cTzP+KnTlWhDWNy0Ro32v98tllPzgYK6dUHzxyGYnfP1EUKO
	nhsKwTLvebt1Iwb+oLaLYq5NvX4K7wh0jjkzAns7pzbXSzhVd//oahHIvw/ECyA=
X-Google-Smtp-Source: AGHT+IFyTnL0l0ijk9ot6bjJRlJaw4cxX8QzduZn74vp/3O4XImIGhmYsfJkk7NTa9kEBpp3BPQBkQ==
X-Received: by 2002:a2e:2281:0:b0:2d2:6ed8:9f72 with SMTP id i123-20020a2e2281000000b002d26ed89f72mr488285lji.0.1708669377405;
        Thu, 22 Feb 2024 22:22:57 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b0041249ea88b9sm1091968wmb.16.2024.02.22.22.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:22:57 -0800 (PST)
Date: Fri, 23 Feb 2024 09:22:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: hubcap@omnibond.com, martin@omnibond.com, xiyuyang19@fudan.edu.cn,
	cymi20@fudan.edu.cn, tanxin.ctf@gmail.com, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] orangefs: Fix possible NULL deference in orangefs_mount
Message-ID: <c4bf77fb-c289-4f5d-9f20-e0861a543d91@moroto.mountain>
References: <3e4e23ca-5e00-43b3-91a7-690e690279e1@moroto.mountain>
 <dc2d05ab-2a56-bf9d-8500-858466ab68e6@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2d05ab-2a56-bf9d-8500-858466ab68e6@nfschina.com>

On Fri, Feb 23, 2024 at 10:11:03AM +0800, Su Hui wrote:
> On 2024/2/22 18:45, Dan Carpenter wrote:
> 
> > This was already fixed in commit:
> > 9bf93dcfc453 ("Julia Lawall reported this null pointer dereference, this
> > should fix it.")
> > 
> > Amusing subject...  :P
> 
> Oh, really sorry for this. I forgot to check the linux-next git.
> 
> I'm not sure if commit 9bf93dcfc453 will lead to sb refcount leak which was
> previously fixed
> by ac2c63757f4f ("orangefs: Fix sb refcount leak when allocate sb info
> failed.").
> 

Yeah, you're right.  Do you want to re-fix that?

regards,
dan carpenter


