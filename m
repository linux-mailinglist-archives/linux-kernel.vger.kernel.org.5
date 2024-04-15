Return-Path: <linux-kernel+bounces-145188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29C8A5094
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7821F2155C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A524823B5;
	Mon, 15 Apr 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lg3x65O8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5182484
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185619; cv=none; b=J3BMfu/PhjcUSNwmSm4rO/ytefI4eKMJuV6Arr1d5Swl1G6S2ZQljQrgDoItyBbGq3N8nlzD/yKMlXzb2+YAI2KTmT2b+kHLxKpdGkzGLeuJlYr2wMLbuApeO0vzNc03sPFbNeAcO4chsBp/8XRmKfKjP2BpSmnoBC80W2a2bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185619; c=relaxed/simple;
	bh=mHsCAGKbKeVfl1gaf61CGCnVc92+Gj0VNSeDerofu3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT8gYbiFksNBEzA8hAdSHRzeIAo4N+5wJFy8ofQz9S+vQXoTWRQYIL0Q0STbvH/KTr5dzufNnr1yXKTEUuh2odGEZkOx9KkkEZ98plcmtzfW0OX3mn4TMIHatXdusIbSvPSQ0RKiMD5jhLXbiygkRu+iia1KDC9YjgtTr6EtfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lg3x65O8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4155819f710so21284835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185616; x=1713790416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHsCAGKbKeVfl1gaf61CGCnVc92+Gj0VNSeDerofu3E=;
        b=Lg3x65O8jqJXNBm2NS8j1qNs6jfUj5+ehqF6DIe4JKTzGtGfGnoDCacBuT6iDP2RtL
         d3n2ZzWIiit3WlwlmoVe5zHoA4JZDUVDtjU4HvQmpUjSvBzoYPzRJ13ickiIAkG/pJu8
         QCbujb2CgrOOjehcsi4+9pmbSQnT9Bd/E414P1Eu2dIrkrL8g6xrMkjKk8R67dMfqUuJ
         4DSKLkTULYIBxW9k7rRmjWtGv7YMemzb5FzbuLM6Efdr2LJSo4i7M8nyu6ko+pL8w99w
         TVe1PqygWWXE55VEhDLhQ5zlxmLLD7vjzIhMILgBIiM8gXyNW1TeT9wvKthBC9CEJEth
         fY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185616; x=1713790416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHsCAGKbKeVfl1gaf61CGCnVc92+Gj0VNSeDerofu3E=;
        b=GU8giGOIEj2FD0Tz/rzSoEO65n44//5alvQjPL0sY3o5zPM3ymttOKoko5XyrTnlR7
         utMnUr6EuCZgW2lNeWt6CW5h46H76baFJN63KHdcHes/5I+Cfw5qjGdVs9v6B1OI1lm/
         0yOakxUCpaq7OrkGTHLQjePkxT+Z9gVuu3RJHf2SkbvW38AylGKOpykwoAEABxUZbY5x
         Mah+zF9OhvzgVU8sKeP+wTzzAGwApMe7ytn7K/ytz9mWTcowcEPL9k2CvVVaQRgRwYBX
         3ypQGk2FbVN5GrbzisiL45z50ktMxzfEW20OTOBAyk4foLL0fCw/AsADwoEvioIK82jS
         q89g==
X-Forwarded-Encrypted: i=1; AJvYcCVpATnO2rXzzyHXUUqQFQP389P6zDaqlNcOrIvmSa9uu2I8AXJ/eUgwDNBFDW7LFrAWoQooYIDGdx7wDfh+lsLyfvnp6vxICQDgj/0N
X-Gm-Message-State: AOJu0YwNroQSoFCRACh6zaFJPuuUGF+S856iwjnYPTfJJtpB2CD5V7/T
	TlKovbTLU3E00IyafOc+RRDJHLv38w71cxc/PvcohNNCMNVHFCRHn4Mg+rTT3yw=
X-Google-Smtp-Source: AGHT+IEN14JC4aKAm6IoQEiJFrZ1mUtV2GIjZnWInAUAurGR00ImSNVfIpNW8YhhEhxbJzeTLcDKvw==
X-Received: by 2002:a05:600c:5114:b0:416:605b:584d with SMTP id o20-20020a05600c511400b00416605b584dmr7777987wms.3.1713185615753;
        Mon, 15 Apr 2024 05:53:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bh11-20020a05600c3d0b00b004187e71bcd9sm681454wmb.30.2024.04.15.05.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:53:35 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:53:33 +0100
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
Subject: Re: [PATCH 08/18] backlight: l4f00242t03: Constify lcd_ops
Message-ID: <20240415125333.GH222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-8-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-8-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:06PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

