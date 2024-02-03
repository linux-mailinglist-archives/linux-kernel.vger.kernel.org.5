Return-Path: <linux-kernel+bounces-51177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B8848758
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CB22840FE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F65F57C;
	Sat,  3 Feb 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnYmcDof"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415E5F54F;
	Sat,  3 Feb 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706976522; cv=none; b=ZhYfNPkiU7NeDEMQLzqlsWViR9x/VMLoh0CUQ07v/IGrjZ+ETpogh5obQWy5XRl3VHqTxwNMXEVfLUHI4a4B2/wtjDF0Gmi+Tn3IPM2k/ukes98ddxjqQPWqzGgAjX4XEoSlLVIQ9Uncmc1GYMgbklRJQRjGm4ViJRASSSAzhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706976522; c=relaxed/simple;
	bh=TvfqkaY1z7E/EzEJYealS3QK6K6eb9XPzrgRJHOGDws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OafEAy5LI+mcYj0GR6jfdW+vLAzbyWPd9Ba6MlUVjH69K+Zw+3Qcv9m+lmugT956Suav0uqk19eDrq6v1M4XKprvZWnwJbUAyDlilZJVmZR4oCmA9/qYUsUYv9CBwn3xMDKsm2LlbZzKlFoufwLEJlYty3dtpbtZBA/Ari/7Ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnYmcDof; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a350bfcc621so369408066b.0;
        Sat, 03 Feb 2024 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706976519; x=1707581319; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yqxR1EvTMHsgAyMYGoVPWKfZjLT0ZE/JNwoz1peXESY=;
        b=QnYmcDoftHqKZzNoPNwh2VkVR0jtM85MEE8DINca2l3LMcdxOG4b134q08xtRLVnHJ
         +JnQDQaXZJ3gr8ungnS8nEaE+z2A9gn9wZElvGIAqBfPa4UXXhSviWqlGvy1C6ekPXkt
         jxuNyFpuUWE2Bae7YoxFPDAV6ZMFLLJb6izevBLh/i0UPBK1r/oj+9wjqffHI8ofn2ER
         H4bNzMl9QCU4X1obKiWB1Ape3KMK+DK27lUnec3l8Iya+669XGoHPwHjr2P/SR/ujFpk
         enJQLFs/bKJWh8YaCja1a5IX2SCJEzm7IkeFW3jgW4kqsD2jQokSR3pyq4eDGPNrLOUm
         0sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706976519; x=1707581319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqxR1EvTMHsgAyMYGoVPWKfZjLT0ZE/JNwoz1peXESY=;
        b=ZfvgOA80KUn0xbSv/DS6PxwG4JIKBl4sMl6CrJXUCBdLqRUh3NgqSWHIX/bLTkJpkn
         +pKoGtFGRseU0Bblfy6rcCHGElwVBP9o1qms12IQ4Zi5Uf2AVeDCE6/WjMhJvFOYwQ62
         Ko0fzRoHDCAPFursL4RpmoXIAWa2TLugT5DH1ePceG+0TAitaUckyXGLgtXhgB/qEB/N
         LE6lZSJ4DMKeJZyIEGDMmI3H9q7PMeSrOi7xr3TvCVB2M8M5ktGF0Ap3SW0TVeAyjr0+
         6N/G74VTwFvxZIpDnhrHu8oshKkU4+vbQVLbE7tP8cuomdgMnQ9e23a0GCvlCjDxObA4
         jI/Q==
X-Gm-Message-State: AOJu0YzVPpztst6lrj2nqs+rlH2WCNOO8p93bg3viADZT6mJMjvhsfzp
	ORZoWj/10D9GNtP49Uq2F//6FAdCbW5YISu57IzKiYlnqqsrPdjw
X-Google-Smtp-Source: AGHT+IEV7d2FsfRSLMK6a7dxjQNk/sLxnViRxBq5OTzJ2O7LLiHkXev+oosUiHbOyA2opP7IX/dtEA==
X-Received: by 2002:a17:906:a90:b0:a36:7c3b:8489 with SMTP id y16-20020a1709060a9000b00a367c3b8489mr3918471ejf.42.1706976519228;
        Sat, 03 Feb 2024 08:08:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUuHUp6KK7TLw+ODD5dqWW3j2sdAOJuk0nRArfTl1DCEeSfbYkeJAEyuR4JXQAgXI5LCNM4e5NycB9epZvUukXotFR29/IwESGGDLKTB6RbiSWZotfFi7ANVip5YtK2QvAAkvIEezBh2cyyoOfyapL9i4ZNtUXmp2BUvQwfl+oG1d5dmRKp+wU0Yb8=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id hd34-20020a17090796a200b00a36f314daa6sm2132144ejc.46.2024.02.03.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:08:38 -0800 (PST)
Date: Sat, 3 Feb 2024 17:08:36 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240203160836.GA21281@debian>
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
 <1eb2034f-b1ef-474d-91f6-c562a5768bfd@gmail.com>
 <20240203144205.GA3727@debian>
 <871e7e7a-c987-4926-957e-5dfdb46d0740@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871e7e7a-c987-4926-957e-5dfdb46d0740@gmail.com>

Am Sat, Feb 03, 2024 at 04:53:33PM +0100 schrieb Javier Carrasco:
> On 03.02.24 15:42, Dimitri Fedrau wrote:
> > Am Sat, Feb 03, 2024 at 10:30:09AM +0100 schrieb Javier Carrasco:
> >> Hi Dimitri,
> >>
> > Hi Javier,
> > 
> >>> +	/* Supported temperature range is from –40 to 125 degree celsius */
> >> Should that not be val < -40?
> > yes, you are right. Will fix it.
> >>> +	if (val < -45 || val > 125)
> >>> +		return -EINVAL;
> >>> +
> > 
> > Best regards,
> > Dimitri
> 
> When at it, could you please rename the hdc3020_id variable you added to
> the probe function? It shadows the i2c_device_id global variable (it is
> not used in the probe function, but there is no need to use the exact
> same name), and given that it is in the hdc3020_probe function,
> mentioning the device name again is kind of redundant. Something like
> just "id" or "dev_id" would suffice.
>
Sure.

Best regards,
Dimitri

