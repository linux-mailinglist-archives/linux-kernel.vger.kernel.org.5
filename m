Return-Path: <linux-kernel+bounces-145179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD3E8A507A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FEA1F21BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8394413A3EE;
	Mon, 15 Apr 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="opsS8fXE"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E37317D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185543; cv=none; b=MOcvQOPBYRlvIwDBiDKErnWoh+jvT/RnmpLxTmQELgVWOqR+fDRyZuNSTIkkLJf/wV+hVo1mSfNobWjQ9W05nIIkUp3qwySjmsEKPWcsAIq2QWaVpm4pr73DcFAavQWVYbbM0MPTRoHlFmdsk0kaWsvooxY9U++ORL9G6FRSioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185543; c=relaxed/simple;
	bh=01ardidNL+/BeEuWA/146qtH9HDtmPA03ttD6ybAIEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvm3gOYJpzvXAUmR0+btB250oCruxRCUxtGFOzjfaFGDnElBUFAA4gtskqAUgK10xtSoRzjrdptHB4mCXCUduwiNGsXyxBtiBB5S4HJ8TCjsaYy410ghreuFVy61Pp8AoiQYH2yUbB+7inhEAgVEXl55lCfRBdu9Y39S2MKom8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=opsS8fXE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518bad5f598so1656367e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185540; x=1713790340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01ardidNL+/BeEuWA/146qtH9HDtmPA03ttD6ybAIEs=;
        b=opsS8fXE7Mt6mCYmxtKo08IBA20GpvaUNxJzYlfQP4nILCcQWHnGldYevDLj3dSHIc
         PSwXlh3PmAioUneC9zhTcpHf82EX6Ad2hOIh6eIJT+JSqM9E5svnGjTIC6GJhZMqAGNf
         qRZNsNgXU1jJXFyE8KCq5SFLRXl48V0WL12J7A6x/qnequNM9UfAFFe9j0t9CImz8qIs
         ybiN0MORO/EPoPjLNvjZynoKb3WtINFT1IvUkctMC5yg953nBcAkr/hO9lSVgDUtioCk
         Pk9rn48yE2LVB7SA4F7H4PQrEuhgEURU8L06kf27ZWYLkhrbL7ocidsE645Ia10ugtz1
         8+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185541; x=1713790341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01ardidNL+/BeEuWA/146qtH9HDtmPA03ttD6ybAIEs=;
        b=rxQqFbe1Ta+f1e8TOEQDOnzx00kG6Q+abqu5r2DI8HGOAJnG0q4J0hRT1tRUb3mDyy
         vpMOyI0bqq4RSL8vIRrpFxl2KDAgTcR0Zs+VVaufeVmKwbkVjnUItaPIQNlqd2f34oWa
         ojW+bnTYZVwZPZo3dpoV9t5ALC6Sgs7dSupT/HqppIwGvRaA6D0wrWV4o4m2QUQWHxWx
         lfLplqSBd+ZmLZuixE0h9k8mtSEpYkJEC4vwUFuZ0CRMQml/dXinku86nj88O97g876W
         agCNegYzSJGiTE7c4PAyZxFzDvRLEMnEE+NfdTbgjhU9dSgVJI14M7cGxnqiW3UBBt6Y
         cFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6z3nnnB8b3DyH9cqRu3AeqOjwl+81sNlgF4HRp8RC27VfAbESft1M8CDE6VEQ2jySeMFp+HElz68eR3p9cKFERRqhhSdWDOvBn3NX
X-Gm-Message-State: AOJu0YzY3poqMK1j2R94Errk8kRCIMFuaa1Lv0okRE/6LCwnhw0VPE0J
	LNAjjY/mbKjl3BPrP4I9XtOoEJB0poT14QYZ7e2Obk/C/9AFZTIOMQUY0kwihps=
X-Google-Smtp-Source: AGHT+IHu5tfg7Nur6nUM4tRHPyjM2leUDl2jKt9o9nLqolr31cl2B0ZsT4h/TE6rznaVk74mXQEafQ==
X-Received: by 2002:a05:651c:1543:b0:2da:901f:6ebd with SMTP id y3-20020a05651c154300b002da901f6ebdmr1300658ljp.41.1713185540482;
        Mon, 15 Apr 2024 05:52:20 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c139100b0041496734318sm19430320wmf.24.2024.04.15.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:52:20 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:52:18 +0100
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
Subject: Re: [PATCH 07/18] backlight: jornada720_lcd: Constify lcd_ops
Message-ID: <20240415125218.GG222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-7-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-7-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:05PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

