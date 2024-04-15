Return-Path: <linux-kernel+bounces-145191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71858A509A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424921F21947
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73213BC26;
	Mon, 15 Apr 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4Y6Qc15"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6682876
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185650; cv=none; b=rxZrFNjzUpN7dPWsB3sPGwyK+OWgmgAMsKYA+pYevcNLNZ7097YGYk63t+x99lnfCvVn8nUgRwCxFmf5mpC4eTmEgjwknE+rH1C1G9dxg3gVP6FBqfI3i8hd66bG92QxG2I4X2QqXYpgWt4MntdjMRoIsovLIi28Ngf8zjoTybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185650; c=relaxed/simple;
	bh=pAyy9h+w9WL23x4FmjpqsU54I0yw+SnGvko40DICoGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkowQAAZSiUGBdVdwb7HeXLy8SMfO4PBxgkIfURrEbOLL6idQotp6Cjtx2BZGmloFN77iiueykkRdSMb/2Iq5wuoeFmwvUYoxY0eBnJjwNquFFbslZGuXinVQ+jqRLZsIlwMiu7PDLmlOFYY7UCX1yve7gnJtwbMwP9zXl6gyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c4Y6Qc15; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187731a6e1so2865385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185647; x=1713790447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAyy9h+w9WL23x4FmjpqsU54I0yw+SnGvko40DICoGU=;
        b=c4Y6Qc15Ua3QPZulLSkpAdp7KflwXYcbwkqOHwKpBLay0bFlODtEPPKG6Gvsy/zWAa
         Y/tDp+yDJfC3uIr0KPT684us2xsAMbcFxGMzr0qQzh18wSeu6eQun6Kxbq1x5YaywUGR
         kw30P8qb3ULqwacrEemLKAaaGdRxM3uaqUebC6IqCnmzvoQ5r/83TjcWCaX/PJK8ravd
         o0q/PQJq3UPTQkzsriuEq2SsGcC2rwO4MMHp8mPbXPy/Onk+2xv+UWY5TsMM8fs1T3PC
         SDseJRVdlJGUzz6FX9HDtg1Xz1f/swC9NMexJIuAWcFnlIVA/CC7Qgr/Q9Ki5KuoIA0f
         kJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185647; x=1713790447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAyy9h+w9WL23x4FmjpqsU54I0yw+SnGvko40DICoGU=;
        b=nJtxkJiGQSH0+qDIoiRBunn9Mz0UfPvsz3ADRq7H+3H89JXcdbU8ejGAWJuWLlNNDV
         f3W4HU34qnZ57Xo+7p3Tyy6k+dHOv7SSsifc345of0LdS/Yvhez28zCpBXaqtk8AA2E+
         lwdqS+XdmVGxxwO2SNsnyHRQf64eZFCtjaKp4LgLJh1LZSalUPm0G2ufKIUbp3rtFp6e
         WXAfaicd3qeVUknPAUSNiQOPknJ1BnV0/EBpBn6I4Zxtiqngrcr2QlHwkW2T174js2D3
         rBQouT7DR5TtfwSG4SlJqoDUk3d6tYyh9c1XOX7o7Yvdyy6Tk9oI0eOk00EBtpUtFsxn
         pK7w==
X-Forwarded-Encrypted: i=1; AJvYcCWS8GFyufIaklnBjva/RZ7EfhBliRiIFgw60pETXYTHGpgIr0GefTuX8EoQDmOD3AgNonZcYARYgDLE5+2GvulLtYqy0OjypQ8tbzkJ
X-Gm-Message-State: AOJu0YzNZLr4FUvu4f2sUVSosUI/jrsWGYiBpT9iW2ZcaZJeOPnDb7OO
	0ux3LQjOnOqKqzwhixiXg9nsMJAgxtY12BxdpFhAgpaLW0MM//skSoWx/ac0LPY=
X-Google-Smtp-Source: AGHT+IHIAoyrHsHxVmasOdct6/TjYd9/FihqF5G/WDFQfH9WIbSdv5Ii00aYT3qEYuQW6yxLfif82w==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d809 with SMTP id h12-20020a05600c314c00b00417e4add809mr6762933wmo.25.1713185647011;
        Mon, 15 Apr 2024 05:54:07 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b0041876516d91sm1747956wmb.7.2024.04.15.05.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:54:06 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:54:04 +0100
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
Subject: Re: [PATCH 09/18] backlight: lms283gf05: Constify lcd_ops
Message-ID: <20240415125404.GI222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-9-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-9-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:07PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

