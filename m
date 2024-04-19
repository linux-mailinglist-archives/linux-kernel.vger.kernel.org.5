Return-Path: <linux-kernel+bounces-151358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B88AAD81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB27E1F22078
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF981729;
	Fri, 19 Apr 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTcH+okm"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC77F49A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525380; cv=none; b=SuamDvP23+9fZGYPbhbgqVmSGU04w/UUFGY/pDgRpqvy4zumRHHktfFg2sDT5B5pa/4vVnDFwf1kmlWvvUGVHDH753jPi97hlGpohF2r6WMrGfIeoUPJbUDTRATXBzEHMM7pMqxp57qEX6C1q/LRy72S+/tudHpE1pn6QcM3Tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525380; c=relaxed/simple;
	bh=grKm/2J6jIM4KK7Si4oFqiL6awWeyiiCJE+GsmPyCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc/eOQ8eBf0kaP6u2rj3tdpjST5TMUqjtKUgVZATfaaftDKuH7a5rjSnL20tUQbjYRcZgO29HnA+6icbufNMsO442F30zSmjU/eS5DvskZpa6MIxbjcd9iAq/9c6x1UupcwR08ebxJSl3QiTg4k/7Eg7t1s0/DHUSCB2r2TxrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTcH+okm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-344047ac7e4so1838799f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713525376; x=1714130176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJd9Cm2U697LnBlhHhSEj5YlaO4Yzmz+HEeo9KmF9JU=;
        b=qTcH+okmNS24VZcre1N0NdobWTfz0QYhWyYYwbF63tyCPf7o+tyRXhmV/9Auz1MXbi
         W9I/IEaoQhASgRyD2EQQWz0QT+aaIhrKSJoR92cbvURZtiEz2Z9QPq6/xl3XIzbmYJ6b
         eYGxAIj4v5q9HURtlYGABf7JNEKkwimIgxy5ByI05MjWtEAbl72+jTMK8zNourMPPH5p
         SxPPDFJXTghhes/1cL4kkkLD1PkPR3werliMVUSPtc6u5eh+sZ2UD1jhgdgMxOD+Ept4
         940a3Czjgqulfd+QTfVMyew8VjFAphYjbhGr82Y0TP06SRdEyCD5c8euAPD1OzlM07tE
         O0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713525376; x=1714130176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJd9Cm2U697LnBlhHhSEj5YlaO4Yzmz+HEeo9KmF9JU=;
        b=fvkeWfO++nRMjdObq+9gbl5ASP7so5dCaRjNG7JrtASLB5NuetP0wn1MiHF/nDp6I9
         /sqwf8xb/thy6D46gsIyMjZN5UirRQ5B5tchh1eapdUJIj6z4nwTQZhTkxjag+Ose9be
         NWec85rN5wvWvq61e/GUO6iOuFfApAI21SDQ/YNcTu0PzHTOfISrLiNygxiiLbpY7p+z
         g6qJbfxN8A8tAepJvHRkAaM0poWRxFW50ENx+5zQcNMnD11GvsrdhfV2tqAwuOjq0p/F
         n3/nz4hrvknVsVqjhAjLCG1ZHZjM3Q9YbdxkcC+nvJixTeOt/Hq5iKfb0cLGKYvY3A9b
         vfIA==
X-Forwarded-Encrypted: i=1; AJvYcCWpc6DdIud2jlFTOvvt8cKWS2kBEntdzeyp+/2pvrK/xq+TZOHDVd/jXZjWLpgNrrWTFRC8dJkMMb7fNoDeoppvzSNL0z4LHCYy4vQy
X-Gm-Message-State: AOJu0YwYD9mmO+KMMjUdLq+kGm8T25LreSvVTnOuQ3U8AjBIY+XiC9G9
	mCiLC9AXKbzy37X+lZz6p5pRsvzauGaI51pkxf7jA8pw/eO1edwxo6YnlxHvBCQ=
X-Google-Smtp-Source: AGHT+IE1a4qRWYhPeu0QdfH0dU1eOD7zKO7WosHykWSQF41QV8m8arLjW2fak04Hrze4DKigl/GWSA==
X-Received: by 2002:adf:f447:0:b0:343:d23a:c977 with SMTP id f7-20020adff447000000b00343d23ac977mr4117664wrp.1.1713525375627;
        Fri, 19 Apr 2024 04:16:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600001cb00b0034a21842accsm3473127wrx.86.2024.04.19.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:16:15 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:16:13 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH][next] drivers: video: Simplify device_node cleanup using
 __free
Message-ID: <20240419111613.GA12884@aspen.lan>
References: <20240418194302.1466-1-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418194302.1466-1-shresthprasad7@gmail.com>

^^^

Please fix the subject line to be "backlight: <driver>: ...". I came
very close to deleting this patch without reading it ;-) .


On Fri, Apr 19, 2024 at 01:13:02AM +0530, Shresth Prasad wrote:
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index eb18c6eb0ff0..3c5d8125080c 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -182,7 +182,7 @@ static const struct attribute_group sky81452_bl_attr_group = {
>  static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  							struct device *dev)
>  {
> -	struct device_node *np = of_node_get(dev->of_node);
> +	struct device_node *np __free(device_node) = of_node_get(dev->of_node);


Do we need to get dev->of_node at all? The device, which we are
borrowing, already owns a reference to the node so I don't see
any point in this function taking an extra one.

So why not simply make this:

	struct device_node *np = dev->of_node;


Daniel.

