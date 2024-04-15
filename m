Return-Path: <linux-kernel+bounces-145124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18A8A4FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB63F28420D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CA71730;
	Mon, 15 Apr 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGs1PQ9h"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45E84DE2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185398; cv=none; b=K1dABCk+xz9tuh/XkAbhNk52nB0bT1hEv7CPNq7mFdpk7HIbE8IvvflpXEXJ1gpVI5jg1niBRnRL4nbCls3frgFAntyvvU97iVxZjzN2/PALkhOft2z6UnU686hpEdOBSvpDcwka7B0RjI4GJozw0aX80/zVbzhf8DJxnL7VgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185398; c=relaxed/simple;
	bh=YQTOMiU6gYM5FdXLFvC0kzpvxWDYETwVK1r4K+Qq21U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drgQPjLsYT/naTkYtZ6376PCDA5fRZy8OFAutcqVyBeDWBbQKf3io9jRGjPt/qSN1Bmg6P49accL75ycyyO0jReWhLK+pqtwA6NWYaP51R4IABtIA5793nvqCFrwjG+y/TNdyTJmebO93NUPStCUDH90nK2h5FFx18ZcjpxiAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGs1PQ9h; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4187d5f0812so1803775e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185394; x=1713790194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQTOMiU6gYM5FdXLFvC0kzpvxWDYETwVK1r4K+Qq21U=;
        b=EGs1PQ9h0Kx1LlOLzDvkY+m+xg9w2PKNa1RIWrGVlWEWlfaE0LZeSuWAGliuR4JeJl
         OrBCoMEFEIfu9bTHqoZ+VHbd/5ZlYywwce/h8shEpn2sYo98h9xp+VTOMwo/g1dRohk3
         dJaW9xsA3e7fJl3UifiGyuwzE/4kEqjHlMDi17bPfxabqEqNJwkQVeG+KRPzRmuOCUBY
         SrqnLXZBUYSfoze4kA+3OPasjSkOvtKhQiZkY3g95oFlzoQYtxHv8pGX4Wkqe16hb+RK
         ElbBK/kceKwMnY4TG/mmelyj1DBfu/vFH8F1QG6eacEih/TEXkiCoFvgxgnAHuW6GIhm
         bhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185394; x=1713790194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQTOMiU6gYM5FdXLFvC0kzpvxWDYETwVK1r4K+Qq21U=;
        b=c2OzJyZSsHxCzhEmzHG26LimmP2wqKItBpzzpoQQXBofF1nmhisb1tDknX3xNJUdI4
         hjUc0/yP7HsjcTLru3eK1g2p8FKi1MqcJnP+sV1FAtKOsP9pJOEr4Y9tiCp92XMoEfvS
         KJEpnTWdHsUrLA9yzGKLO/MDhD14HAM3/44GK0veo0cnWOt9pmVFgOoTqSNXgLugg70m
         y6EGkFz3Frx1NDoVaJv2HXAAUocbp6UfFBPcIsPlvnLx26GVFmpJcXZM7gh0IiQ7TMRS
         KhTQ2hJRC9+HTnehEtOklJPktggfHCh4gqdVLDit5yLohVenxg6LKWOs/Z2hCm4RD24F
         uiqA==
X-Forwarded-Encrypted: i=1; AJvYcCV5MXPVPANL6SJ6RbNmx5+SQldGF81XBoTpVVVbNfojpCxUstNJz3eNlySzcE/CPGbKDxQnMBLof4yLjzPSoKSyOBRFs+BE0LrsWZHP
X-Gm-Message-State: AOJu0YyHhupTgTj3irzG+dhGLgdQnRpV2WciyRBVD1rb/T61XtAagpn1
	lCW7Ml8rrXgQYT2D5MYKbaDmZzGoyWj7bwowkOTL8aYtXPeJly8Xmxn1Ld3WG6A=
X-Google-Smtp-Source: AGHT+IE0jfEg8j9eNQ32UlJgwwRwcJBMnq8mxk2glq1rj3pDzq37W/GBcRUB+mKPUDxRmuZRlave7w==
X-Received: by 2002:a05:600c:458d:b0:416:b74d:eb94 with SMTP id r13-20020a05600c458d00b00416b74deb94mr7708786wmo.1.1713185394484;
        Mon, 15 Apr 2024 05:49:54 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b004182b87aaacsm8741388wms.14.2024.04.15.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:49:54 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:49:52 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 06/18] backlight: ili9320: Constify lcd_ops
Message-ID: <20240415124952.GF222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-6-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-6-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:04PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

