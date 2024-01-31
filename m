Return-Path: <linux-kernel+bounces-46608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242668441EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8F528FCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419118288C;
	Wed, 31 Jan 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynnVoJSp"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D221DDCE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711648; cv=none; b=fjXYtfCQsLrgSPewnRpv6VhWGNCSoY4Uet9oHmxDd1OWJMNzpDyTmMBgtF1QJdIOdPueLOMxn5BAzq/dvBhDgv1uFZNjmwLfrLO7Hy0h+icQMvDA3r1xcYrXcXm4yMpy3xbwX9U5+RqIoxr2UdRA9rFqHtoxMq9D+WHiiaRe7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711648; c=relaxed/simple;
	bh=pw+U8iahJ0CmhuCN4ZbIgl2mTW7ZjtW2xezbf/dgrRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPvJ5lGzu6SqFLYYP9YB3Kfkfbf2PMKJm6h0/ghUutnLAXQm85YSneQWLOB+WwtovwlLjoyGtJElHgdiEvOgsmO7RDf7SRiyWo3SjUKo/+QpJzMz6ypsKZ7bfdHDj3Bfw/9rvhvXXcTQvrBQU4ER0gE3+kvVLwBh8pGGSdGKDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynnVoJSp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fb0c4bb9fso9896035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706711645; x=1707316445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw+U8iahJ0CmhuCN4ZbIgl2mTW7ZjtW2xezbf/dgrRE=;
        b=ynnVoJSpmN6+EBPst/BcvEzVF9bVaW8nhpB9VqWK4HMFL89VCmAYiUZH4ZxYu80/Bk
         Lop+DxvXDRvzZNwxTcdtDgnI96ikIz1N94fI+SEGzHVOmjBjjZyxjC7VhOVUt3LMavP8
         M45WS++SrDwrDYUL3Vm0ofiYyNg1gAE9q8uvvQ5z7B1OgHt/AtxwmfdjORFUJ2aKyXqj
         T4uq+LUe6Ggl1dC46p7BQuroH9v5K/w3bfYumzR+q6CoRN9eD8z43DrmriKp4L9JvDZA
         c1yq7m0Bioz6f55+1AdxBfYRtr9tw1O1zu/sk20zynYHvDC/O8BetVJk+5GPrAilc8Ii
         1sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711645; x=1707316445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw+U8iahJ0CmhuCN4ZbIgl2mTW7ZjtW2xezbf/dgrRE=;
        b=XAd9cQFTYap2YNpqN1TEeGIvRr8IPiUmHG/pLwgEwSXFItO7ueCJ2F38ty6D+R04vg
         WvHaWRHuqfVWTafAjPUg0nzSn4TXvtff4DITh9LFFehzZWwgoyCr/gOjhQRBe1iFMruZ
         ym5KeILTHryAy+TmmM2jmr26Z2NPbTWzEiLk1ymcQgWJ//uhTykLX5bAOVcaOJEeZ+fB
         SHaiMx9cip2l3qB3Ul5C/j/tetysRHPcWFdZ6NgSaBJvb3yJ5K0jGR+oClvDNP7aYzRq
         3Ec//uFWkeQKK2HyoH0ip0zFtNlPVE8U5t2eYj9wjzoM31eJHqQb9LzusQ61Y8uMj9DD
         KvGQ==
X-Gm-Message-State: AOJu0YxX8XdG4kVg3qjWVUFjxcsbb53SRGdKvzW/Zy+by+YfKwFV1uxg
	R8BH/GVbG/Dg/KfDHygqgJn5MthnEfB5c222pOTeBiaDtuP43ZHfzZvTwO9AhcU=
X-Google-Smtp-Source: AGHT+IGxibPRLhmvYBASqTzPoOPDIA2DlXiwWGSJOIVvDa/pebaIEuqr9bjfmEhnBIEEMlPlSKnUWw==
X-Received: by 2002:a05:6000:1379:b0:33a:ee08:7541 with SMTP id q25-20020a056000137900b0033aee087541mr1386289wrz.35.1706711644956;
        Wed, 31 Jan 2024 06:34:04 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b0033afed6e9desm2888638wrm.98.2024.01.31.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:34:04 -0800 (PST)
Date: Wed, 31 Jan 2024 14:34:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jianhua Lu <lujianhua000@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktz8866: Correct the check for
 of_property_read_u32
Message-ID: <20240131143402.GA5929@aspen.lan>
References: <20240129122829.16248-1-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129122829.16248-1-lujianhua000@gmail.com>

On Mon, Jan 29, 2024 at 08:28:29PM +0800, Jianhua Lu wrote:
> of_property_read_u32 returns 0 when success, so reverse the
> return value to get the true value.
>
> Fixes: f8449c8f7355 ("backlight: ktz8866: Add support for Kinetic KTZ8866 backlight")
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

