Return-Path: <linux-kernel+bounces-85517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273E86B6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE0928594F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5840856;
	Wed, 28 Feb 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNynDODW"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DD79B61
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144169; cv=none; b=NBvZUYFy3BGI0nc1njqCdGsEnOM/UfCWRS5El0rOn2ZfhAlGppOgps+hOrmesMb3RUJGLUgIwoEqDYo6NdQng4jF+v0xnjqe1FMPKj6GQUhQEmK3iqX9kcQRUUplkMq0uXP4v8TlN7V1cRlLjPah+mSwttBHkmDYANBxqZu7BHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144169; c=relaxed/simple;
	bh=1kWaysEbsM70DaSeLNKQutuegUR4y2SpD1yzaZdBcZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHQfDLIxzfw/RcLcKK/wYp9/xyUZGrEpV1DcMgNHMEBVuFmW3+FU2QCgOZEYU6uiN+RURkkJ87c+4Uh8mETsWuhOteX7sGQUnoa3tPP7kXr7QPWk+NGipAmbXGYe+nwQpsj3nkYlpHt8BntcPf1ds/9VNd5etndLMfuIQOvws4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CNynDODW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412ba5ce271so121315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709144166; x=1709748966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RgBQLcrgH3gOWvIgwazhE5Cb5mh+fuN2kUzWGSABzg=;
        b=CNynDODWiBx+yxNlHgWEGN4jdSPZWJceJp6wyQZL6za21GJJcMD35NLt2HLKzRQJmp
         3qIoqu0AKrfVqWhPpULhry1Ph0VwzzIndMDH4+y6a9+MP3cu/jr9ZP+ZgOdhZZes5nLr
         IJVHBypF3Q7VhslGnnfMjgfWjJ8FHZoPRXIPx8q0R4gE9cLVTyBZshiEWeIQGc4+E19F
         z/CrPle+8t0rVR8KtJVKzpcuhDZxP7+D9nQrsTpjuHGcZi30qP/avZUJOEtTfWOR9Jfi
         IJmjyfDo7GAft0AXZ/Bz2omwNFIeKTE/SAG6bc9iM2UMnU2Bxq0dhEEIPTbVKHKJaN38
         qzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144166; x=1709748966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RgBQLcrgH3gOWvIgwazhE5Cb5mh+fuN2kUzWGSABzg=;
        b=fKo19ppKxcdN1MY13ajdFTvhVi39PpKkWgn7wN8q9od9PDbrBVRUNKPJIHDuMduXtZ
         2bZn/LP34rUP0Z9n+mAcmJyTuEdcKP4Ztu3tAT7QVtHIFQG80HSpyrMjGm6OGPiLtev+
         BLwblLxhD0++K4fgA8dFRX+W7D8qOV14BHOM3PS1Ne2A/+8D2oZaIej2h4igC8a8g7hC
         ZIuP6ERS4TtlD4sZ8/E0sOAGQzk7EvpBm2D93iGbyJSQJPrB6Jh+TIPTPIPc7D1JY+In
         /kblfr1U9WPS39QiXNKfOYGKRQzgykBfUXrZb86ZdJUqVBtkAGVwb6T4kIM65jdlTaQP
         qnTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9w+mn6A7NEMDRt+wNiLxd2GAauscx6SbD02pulWOvL044O2zJ4pWt/hIZO0DA2JUk2+HGgJ53Vhxb1HViZJRItv2T8NAddzX2o7+z
X-Gm-Message-State: AOJu0YxAbrq/hPRB2bvwdqqxsbtP/0OlXbB5VTOtitMcWeVvll6YN/XM
	TIo8EZtr2zU0CNngd7e6xgqwrbgbIhn2tnrCldO3onDrW6nwfyqry/VoGNNmIhw=
X-Google-Smtp-Source: AGHT+IGZsW2+DV+RLS5eEUTSzNTy/jmxqTHtHvCRKzCxwdxk8Ibsv3Vpe1wv06Z7qlQn/p0QV+SOnw==
X-Received: by 2002:a05:600c:450c:b0:412:b3bf:8143 with SMTP id t12-20020a05600c450c00b00412b3bf8143mr272467wmo.12.1709144166247;
        Wed, 28 Feb 2024 10:16:06 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a7bc38f000000b004128f1ace2asm2757215wmj.19.2024.02.28.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:16:05 -0800 (PST)
Date: Wed, 28 Feb 2024 21:16:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <67af4fbe-9dc1-45f7-aef2-ed397da733ef@moroto.mountain>
References: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
 <CAJSP0QVYUrkbk6beMB6nW1q9G3jMqeDzGwMagyXh1B1skFdHjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVYUrkbk6beMB6nW1q9G3jMqeDzGwMagyXh1B1skFdHjQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 12:53:28PM -0500, Stefan Hajnoczi wrote:
> On Wed, 28 Feb 2024 at 12:44, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> > vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> > reading one element beyond the end of the array.
> >
> > Add an array_index_nospec() as well to prevent speculation issues.
> >
> > Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: add array_index_nospec().
> 
> Did you forget to update the patch, I don't see array_index_nospec()?
> 
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
                                          ^^^^^
I updated the patch but the thing about vim is that every time you
press a button it does something unexpected.  Vim ate my homework.

regards,
dan carpenter


