Return-Path: <linux-kernel+bounces-145091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D18A4F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2687283B91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332670CAD;
	Mon, 15 Apr 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shJEToUm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8E6FE27
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185215; cv=none; b=CGEU1XyFwPWKPYsPGHuiYNQH68DU89bxxoXfj4l0FWs5QqryRsO0JZtt6evR3ociTC5EKmsXR5wIYTx1FQpo8slk9f15WoRBJhWv6covYM8DIf4ydCs2FhrsHEE03b71TqorrGDB3bqGy2p31mAdMIu9YR6P/Xf5ppT0eOmHbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185215; c=relaxed/simple;
	bh=LZr9b2jjHgXnxRQrIHWuOp1TQFMyAy7pMficXH8VXFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGvGR+iO6pvHgvZamwWx6hf/fqpswfLLahxlOd93HurTZtP9/WZ4FDas+BUpOqjV1QoYBok7LQDtwZmlkiPzXkAvduK76xzNNssfrjQ//OHyEoaSDq1Rjbr3pLBZKQXROLsTd2S2qw/YSHTMlb0EnJQc4X2EpXyuxNs9tmpu2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=shJEToUm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41868bb713cso5378945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185212; x=1713790012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbZUbhG0ov/FwjYBTgroRKws49tP3YZqZ1e9nA++yqQ=;
        b=shJEToUm56T4SyXUqRI9Lfj9MAE3WjgiLsMAstobhhQyUD9ZndUBy6azMFjMFjANfo
         CQMrODslF+6E8HEDOAqsRAOMGGgQFBDkmxQr1kg9h6HK4t/9AapwQ0T7DPiTPYbKo5y6
         oAGi2WaasaxvZRfaKkMb4hPDLG+3fOYlgXTpYFucaZpppH5PBY7PhG4qDIiffvZA47Hj
         geUIBRl+L3em8L0EEf1esoxsXNYuBTrifcEqKJAdkT/JP6UgZABmGr3u8rIC6tVEPEnt
         OGv4JdbrDhJlqUCEUB/K20slZqb++3BCzoUmsqfRoj5Iat0G58Qc5r1GjbEp/YFveXEZ
         LeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185212; x=1713790012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbZUbhG0ov/FwjYBTgroRKws49tP3YZqZ1e9nA++yqQ=;
        b=HaKUedygpq6J8L5z7JhT9DYRIktT4rkx2J62rXBz5pg0kYGS6Jbkhh5R2Ns+GFCoEs
         mis6az1af+kazpjmpXCXmbTdmfzx1s7wDvc2BAE2RH0cbcHCf8v3NGAqomz08THkgaC9
         bP4FsY+aiTwy+s5LgiTDrXYi1L2SMCnTpjTtnKZFMoCou7djRzYvfVB1RZ9Rc47nSHSx
         bPLOjhUWsQmlyjndizIoPm5sSMxk3lltc7FRA6SO39cgR9cpIiFFki+qiYWlt+ka+YUe
         qQ0e375Y2/SpXfeC7gDIYtzanHSs8C/qG3LEmI5RjD2Mnz/12f0Lvg1en6nSbXOwwau+
         OPuw==
X-Forwarded-Encrypted: i=1; AJvYcCVV5l63xKsTyciIS6KsNFfr+mzj3LiaM1v2K+8MRJUa+xk4gEQEzv1AcRO55Rn8QryaNTResde8Ivt506zNPCqyjRSeIi8m6Oekem97
X-Gm-Message-State: AOJu0YyY2jQlPq8DJkoPph1Jf63uLS4q4Ld763VXUmyrUezR6A1+AMzz
	EWrW/TuNAUSgj3mz3Lng3b7ZfzIl6861hY7569O9QqQgnhEYX5gX44bap6LdEoA=
X-Google-Smtp-Source: AGHT+IGhmqnCG1TcWkxS+Zn15K31a+Oo01IPIQuW6ofPPWCyjZuMzPolU6GYhaxMv6ytY7keceZXhg==
X-Received: by 2002:a05:600c:1e21:b0:418:6cda:e95e with SMTP id ay33-20020a05600c1e2100b004186cdae95emr1418529wmb.8.1713185212321;
        Mon, 15 Apr 2024 05:46:52 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b00417e36953a0sm14818200wmo.20.2024.04.15.05.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:46:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:46:49 +0100
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
Subject: Re: [PATCH 01/18] backlight: Constify lcd_ops
Message-ID: <20240415124649.GA222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-1-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-1-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:35:59PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' passed in lcd_device_register() is not modified by core
> backlight code, so it can be made const for code safety.  This allows
> drivers to also define the structure as const.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

