Return-Path: <linux-kernel+bounces-145198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE298A50B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0ACB233CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446483CDB;
	Mon, 15 Apr 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7nr8UoE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204213C8E8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185694; cv=none; b=Mtm2dmHsMvaPPQV6vRex0JnTfZOeak5g2ZY/vA3GuiXt7S+iSOyzpI1O4n2Xr51RwLE9G81k8pjVfdpHiFk/KiPOPMwFefPm6xkT9X3vU69pj7mZmHax8Li2o/naH2V7Ts8HX3bybK7zj85wLmaUMymaZxmxyDyRR//ulAW5dJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185694; c=relaxed/simple;
	bh=59f281dHkUN3AP2oLzzLuo3JgEJxzPeKM9+dan+z5jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE+FAkagBdVmcI4Brd7TKZo9tA6jyEvBbmEhn3nMOmt6Tq2F3eWn9dFOMvyPov0/jnkCzVFT28Ndtjm4IMbYNUv3RjeijsU3FbwD1bRjViJIvkFto+e0sr+XhuZnSJTYGY4vd2ChJ14ASHyUwq1ozY3Yc5Br+wBg1Vk2N+pDolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7nr8UoE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so35256861fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185690; x=1713790490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=59f281dHkUN3AP2oLzzLuo3JgEJxzPeKM9+dan+z5jg=;
        b=X7nr8UoEfEg3Qg4YFYijfa51ZKZyUZOAjv94DkMctu8hYaeaweV7/Lv5gNgSV/p16t
         0pNFvWxvNoXnmrhouw+FXs9M7vmvSxLxagt9OED/OWJ20Gp1LoRIASHC/9ytLNVbgGgI
         7B1JW8Zt37oUwt0dvo0DL8rHisVVIuYCX4lMgsvr64URauVYUGDGWdwYsKm1RF+ZPVuv
         W4OWBXImeYPeYb7MGhBMcxyuQ7x6zeS/zbxriMyra9Vj0aeJIHv9xy+dlVv4IMUosBkA
         5ozpTGuwPzqeF59NNLzdWnMFu970nrX69FndoCgOm7irJnOcbc9KQZ9PizCt0HRM3C8X
         yGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185690; x=1713790490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59f281dHkUN3AP2oLzzLuo3JgEJxzPeKM9+dan+z5jg=;
        b=NH2WfytQ+4pgxZGl7nJyooTtmER00G4mDcB9gTBwmn/aHo3KCDCQCWjdrM9GVtDI1b
         y+P2qwb+iZM3psN0Go0XBSQ1z0oivUX7Ukpar2RPRC+EUL4EFLKL3G1bkcFsIMWip1Jb
         jp4pWHK7tYcMPslqu39o8OA+7fLxfJvtvB92R69pRB3tDhW+IG+7boFbrDVClHDdxbRT
         +XfsOf4aXsmUgbgh1WXWxqcZ28TBdkGz5GGl98214pu/CYaliVQ9TMdMbk+AT1wEtYSS
         CEYNnucGZMpTAW/v3Yo1MngGMsVq+dSDGq7dSFAOgvC1v+GZMKEjIErXULutuPZmzQRt
         kokQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh/kzeUMMg4zTETQ8oX1GB+hT7vwIfrrd6o0Y2JZrUw4ZSMLPXjqcCojjo6xUOE1IodPCsp9pjRxlTD6l0cpfrlgYw7T1OIcMuE8B6
X-Gm-Message-State: AOJu0YwYi9k5ewk5RJ8LnXyBHhedI93gc4Q7LlZGW6t9+hrCDDos/Ibr
	5x1y2UZYDLDZVGf/E4Z7jM87cEbz2WPeCpROobYJJzQFGntzN0MCKu7WxVyIZ3s=
X-Google-Smtp-Source: AGHT+IFrtoNRAy8uJsV4JsI0aS0ZrMcXBvUk3IjrcXoc1WAmiqGm9I5p36WylWsaC96BOzcw3ftNXA==
X-Received: by 2002:a2e:97c5:0:b0:2d8:abb1:b311 with SMTP id m5-20020a2e97c5000000b002d8abb1b311mr5397736ljj.44.1713185689650;
        Mon, 15 Apr 2024 05:54:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b004187ccbca8dsm941622wmq.42.2024.04.15.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:54:49 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:54:47 +0100
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
Subject: Re: [PATCH 12/18] backlight: otm3225a: Constify lcd_ops
Message-ID: <20240415125447.GL222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-12-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-12-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:10PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

