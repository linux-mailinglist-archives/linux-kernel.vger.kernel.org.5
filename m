Return-Path: <linux-kernel+bounces-81487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F886768C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4DC1C29671
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C51292E3;
	Mon, 26 Feb 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFLi1UFB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC2127B6E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954119; cv=none; b=VLOV0tkoXeJWfX/Uw9QKxRI7eG+opctDAzRzlpK5x5xBRq+E+SCoUmsyf/bmfQf1JaZSwHtqFmBsVh8kPPjGKMd3LMzVczkxmLW0hFnQVDIuz7ZrQ48LT6G61+xgJpaNdf8K7Y/QsSBRkDM6J5ySuePl1e989z+1FSnH3BgbT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954119; c=relaxed/simple;
	bh=yXkM+FWFBFmBe4sFSk8wmFRMwaL9zCW2zeGfA+FuEAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWmbhXpEQbefzSBSJh3Gghgub52wZbXtai2RB79ZU1uWI4twlWYtVMs8hjcra1CN6ueYibAkS4Gb/kByUAvv70JBHKnV9WzdjxrH6wzILQbKC2HZ3MLy5RCj1CrHtweo1tKKEv2yPRNbwvGgXyGzk14OVSYOOlKntwGA/jvFTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFLi1UFB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a9a61545so492415e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708954115; x=1709558915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lhn3yuivfw5tP705I3AFcDT3Ytd9xli9IjfF23lLdM=;
        b=fFLi1UFBLfg3Iq5ylxr0VaHq/AzdWB9hjjqxGGqWRJUzqxRoJF/HNi8WxQH53EFPZl
         H00kkzzJmjCfG/XUCgRBKjvdWmfWjFFuhb7YqBASd+n5K1LncNefiWwpQcOX/shAsZoc
         xWhghY00d45a5s1AqIsy18Hy/GgJxHtvl4PNv8LoB+sTBR+j3P8JAHGWNnzu6XrIjczE
         uKFm0LfPvTNINxaGuh9feuVjsKsJ+QmGj2lcfKjnSccSZaQovEJWudU1XDZyd3CxK6fc
         vdo19lNLjC2Gs+KI723PsFUdssqQziSa0HX456A6VuZ2XH5rSL8pcxXcDQbMzaVvkxYh
         505A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954115; x=1709558915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lhn3yuivfw5tP705I3AFcDT3Ytd9xli9IjfF23lLdM=;
        b=gZSHWpy+JMF54VDDPG2fw+YLX2p+DXUz75JJYBos848AR2vhNlnmW9l+F0eSyOR+58
         wLWNgrMk1JSR/mUuX2GM+e12/v9821Wonytaj+7xM3Zakaq8Ig2i475I1pc5JHqwLCyu
         TfE/8BJCe+st8WHxK41lZhJIy/ZLNCjoDe7eSDNw2RMDGK3kQ98N/uShjTSDCtyZM0zW
         uvCVjAvdxEtvX0cdvPGagldguDfR+NdxRL8ZNjvHkwXT8XznrwglMGqwhdTT4vgFbsVX
         eR3Yj9LAPacHlS6Iz6J5aWd7qoVvDWBlhCfjgpnKJwnhVwHxf0hgcwxR1WkOOW5qGYHB
         Q8cA==
X-Forwarded-Encrypted: i=1; AJvYcCVoc8KEETCvNaFSpRu2OMmA7mTdn4nDACID5OM+owELXJmgpDQ0sZGRjTBUUBltvhrdNWKK6+O4KHhmsft2EZSZYdmejOjTrceCqdJI
X-Gm-Message-State: AOJu0YwLyTm3ezuF+P4mh2a4CEMiI5fQVUciD3QCLD5HrvXaiF/qHuMK
	Wv3qNrQoOzRSCjp3pvZ44xCZ/rog6NLGL8NABUX7NupMY2023v+7tmhjy6QI1YM=
X-Google-Smtp-Source: AGHT+IEZTpJJFhvQsxYl7evaqNmykLzt9jxs/MJZvSgXDLjpLdVjHzoMEnG3Izus7nCEs8GcydaUqg==
X-Received: by 2002:a05:600c:468f:b0:412:903b:12a5 with SMTP id p15-20020a05600c468f00b00412903b12a5mr4539718wmo.19.1708954115544;
        Mon, 26 Feb 2024 05:28:35 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bj29-20020a0560001e1d00b0033d81d9c44esm8399320wrb.70.2024.02.26.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:28:34 -0800 (PST)
Date: Mon, 26 Feb 2024 16:28:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: meir elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Staging: rtl8723bs: Remove spaces before tabs in
 rtw_set_auth
Message-ID: <e3f9ad3e-1d60-456d-914c-c153d6b0a875@moroto.mountain>
References: <20240226075225.44881-1-meir6264@gmail.com>
 <96ab1a91-7682-4aed-a522-ceaed0dbf56c@moroto.mountain>
 <CAHdEp89HhwiBuQEqTP8nTTy0VPrLr5PKWi8mKLx6wFzeTb9eXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHdEp89HhwiBuQEqTP8nTTy0VPrLr5PKWi8mKLx6wFzeTb9eXw@mail.gmail.com>

On Mon, Feb 26, 2024 at 02:05:19PM +0200, meir elisha wrote:
> Hi Dan
> 
> Thanks for the response.
> Not sure I got the problem here.
> In V2 I removed spaces and deleted dead code. In V3 I just removed
> spaces after tabs (reverting the dead code changes).
> I'll want to create a seperate patch for the dead code deletion later on.
> What am I missing here?

When I'm reviewing patches, I try to be as machine like as possible.
This makes the review process more predictable.  It helps me avoid
decision fatigue.  https://www.google.com/search?q=decision+fatigue
It sucks to constantly be refusing to apply patches because I know it
makes people feel sad, but when it's part of an automatic process then
it's easier.

This patch here is a very mechanical patch which requires very little
thought, either from the person sending the patch or the person
reviewing it.  You've run into one of the common errors where you
cleaned up dead code instead of deleting it and you've recieved the
automatic response back to just delete the dead code instead of cleaning
it up.

If I hadn't responded, Greg would have said the exact same thing.

Even if you sent the patches in the wrong order:
[patch 1] fix white space
[patch 2] delete dead code
I would respond to patch 1 before reading patch 2 so if you fixed the
white space in the dead code it would still trigger an automatic
response.

I don't know why you wouldn't want to delete the dead code before
fixing the white space issues.  If you had just fixed the white space
issues in the alive code and left the dead code alone then I wouldn't
have noticed or complained.  (Best to avoid this option in case someone
*else* complains that there are still checkpatch warnings remaining).

regards,
dan carpenter


