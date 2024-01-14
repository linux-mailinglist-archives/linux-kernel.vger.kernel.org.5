Return-Path: <linux-kernel+bounces-25388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1B82CF7F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 03:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153AE2828F1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 02:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899917CA;
	Sun, 14 Jan 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYQ9wy7Z"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455B1841;
	Sun, 14 Jan 2024 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28cf491b197so4030858a91.1;
        Sat, 13 Jan 2024 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705200450; x=1705805250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acrPW8OvbjUOMzGnpFcr76/YgfSNPscL/aqWaQEyhVY=;
        b=MYQ9wy7ZIH5kA3hkm7EID/05nOyuIOtJSYx3ZQI1KBthvLMAYtpsg//WSiVnfdTIfS
         JUs0s2a1REHp6cirB8b0vPjLtWkHzkWCh/Jr1sv6ZH0LCq1HDdpqMUAyX8jN4iXJpXyQ
         kfgeREEhyihzblbJC0dO3HXJ6VYlB1RMZCKT2I1abWIgRSFBSVpYBXyT70dKK5N36PH0
         kdUV6Ji27KHmRg6sVy5jW42G7N9f32R/BdfddYKXhibJ4b+txbR06u/88NH5TNpSF7xW
         8VcqfuUUrnGbPJEveOhG0AHSVfSwg2KgYuPk6j3ltTIyteo4PW9tTKtWS8cUyhGpE4Os
         gsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705200450; x=1705805250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acrPW8OvbjUOMzGnpFcr76/YgfSNPscL/aqWaQEyhVY=;
        b=psfmpwQLeBwudCKLXHsLkWMs8NPjaKe0Q6NVDR5zLsgCUZp6EE+glI/VEh/EUHb5/L
         8eJg9zWetb1PWRggTaVb+5zs7BRPpkssCQ/AwgNv6qM4I60qQPljYljCpLtzX/LA3RWO
         Bo6BIrDoayA8P4UxPHL1nrLW+pHxx9oMwDi1wsYcpimhw0shbPJrcVfX40YZrZlkdH5A
         wj5+WiwkAOX6NJh8lzh0TdhI+6Gkgbf/yDEXxd86gG2SI91zJSY5GHcvLhrCuG5+45bv
         qrXKFBG6LD+ufHcLqDZpbQZCu9oRYZ2ISQL9cQHyMsMogIvuzXd8gAKPqWLzXd3sAS/x
         0ZdQ==
X-Gm-Message-State: AOJu0YyTRMDfz7heVDj5o2NW7MMWCzowjpw3SEAvm8wfejGHH+8i25Hn
	/hPHiGwHDP2nH02h8oIskkqUvchqlOpdMw==
X-Google-Smtp-Source: AGHT+IG30UwpcVT1o4w9oGoIDDwLMHS3PA2qlDIRg9kXw2x0c3NQ61x2xfY5d8GDmOCmfd6myZdhpQ==
X-Received: by 2002:a17:902:e5ce:b0:1d5:b948:8e4e with SMTP id u14-20020a170902e5ce00b001d5b9488e4emr276142plf.91.1705200450083;
        Sat, 13 Jan 2024 18:47:30 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001d3ecbccb52sm5400163ple.213.2024.01.13.18.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 18:47:29 -0800 (PST)
Date: Sun, 14 Jan 2024 10:47:24 +0800
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
Message-ID: <20240114024724.GA20870@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109135952.77458-1-warthog618@gmail.com>

On Tue, Jan 09, 2024 at 09:59:45PM +0800, Kent Gibson wrote:
> My new year's resolution was to improve the documentation of the
> character device API and gpio in general, so here we are.
>

>
> Patch 2 relocates the sysfs API doc to stress its deprecation by
> moving it to a new deprecated section, again in userspace-api but
> with a similar section in the admin-guide. The deprecated section
> also provides a placeholder for subsequent changes.
>

While preparing the v2 version of this series, I'm now wondering
if this should be changed to "obsolete" rather than "deprecated", to
better fit with the interface lifecycle, to indicate there is an
alternative, and to emphasise that it is scheduled for removal.
i.e. from a userspace perspective "obsolete" is the clearer term.

Is that a change worth making?

Cheers,
Kent.

