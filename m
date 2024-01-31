Return-Path: <linux-kernel+bounces-46621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651AA84421D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE146B2BA38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854084A2B;
	Wed, 31 Jan 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGMvGKXf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32183CC0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712148; cv=none; b=EE75LMFRkooQK2VtZOATHAFEErQczCIPb6EpbwIIKsZAXt6Ky0OgHGz6vyF4Wntd59FvUbsPOu/xr/+pjdQLqYba8Kb/KKO+g3Gi24ZP4ZFHELMZV8rFe1W6iLKWKVlygpFdOi9FcvyzUbMOKkMOwHxOL3C0kSlUmmlbgeKxA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712148; c=relaxed/simple;
	bh=K31KqT5V5uF5b954ZcpqYJhJ0+aoYbQF+sfNU7Nx2B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM3KhUWV+SuSF9Rm3f7469EZREhsFGWOFPHinorkWxiGH1AaZre1g0cMGk4fiucgghzD7ejjGTGsZBQHC7HKtkizFm32lafIus+wyBnCJdjhHyk2+58RFJ1sDxL5yy1KwbIV258P/HVa85fgDcB5QEYIvValgK5oZKrqT6E7UJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGMvGKXf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so54701125e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706712143; x=1707316943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K31KqT5V5uF5b954ZcpqYJhJ0+aoYbQF+sfNU7Nx2B4=;
        b=NGMvGKXf/NKrrNkwdoYuutjpFtJjxIRGPIYnPTLuINv94uljI+aQXWuKdquwMaGLa8
         PQ/smU3Fgjmh35h2X9SZTaE8nd2Kh/ehv66hjtjUUI2aby1WXIDBC/gyu9FmzM4OZ9An
         RYAojzhysLoc7XFwBt2YISOEoxMh0Xwmg+Dvk1p/eZYcGwFMnfg5LpEXDqkXvxHd0Tll
         i94IbvYeSnhVE0WwUWaRV9+VlkgrevuYYWLWre5J4LLlgjPSbQCbKSw1gbhyja0iMyFp
         dwgoBSS9ki3UOZ1JlCNzK0CAyizixJrglnRNM7A2VCSmL0eyWX2JIyn6yBIqTdh8i9w7
         Sedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712143; x=1707316943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K31KqT5V5uF5b954ZcpqYJhJ0+aoYbQF+sfNU7Nx2B4=;
        b=hHMCO1OmVAzlZEWboh4PwSij4HhKqGA2Si4uvO1l/sopiHFCGsjm7hQJG6QTUDm8qz
         +8RXnL+33YhkSJPGrI9IGbd+UWs+COaFsTUTYtstkb2aUZWDmJ4yRGNPYFIHbEakQp/g
         L/NoAimUOMn57ObkCEnBt/D+eMVLueD3jRGDUP4d5cEEkjMnGLNIYl9UihDw0aZbkxAX
         lWafghrnqDWguFih1TFu8LpuJQ7g+9nF/Hor4dNQfFiXCcZR4RlP3f2Sm+W560ShsB/Z
         GS28gdPL3jWKpxVQVIoEres4ba6PzXng43c/VEWzHiMHnR+wtS6LiiExPUTwVMcntgAQ
         EO5A==
X-Gm-Message-State: AOJu0YxCwPW9dl+97QMtJczPmyo011cViBWW7R7dHNEm8SHmQFQrztwe
	KUTJ+FB4YvC71hnXejTaY86tUrjCDQxbeTLazMSSFCVyI4fmnsZNRddzZTMa1sI=
X-Google-Smtp-Source: AGHT+IHrC/K+xdbE/khLOxKWVe2CNuHMAaEhHqNgScg2QXA2v/u7cDClshre9bUbEaRveSzAwxcppw==
X-Received: by 2002:a05:600c:1386:b0:40e:f5d0:8517 with SMTP id u6-20020a05600c138600b0040ef5d08517mr1321066wmf.33.1706712143446;
        Wed, 31 Jan 2024 06:42:23 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b0040e89ade84bsm1830569wms.4.2024.01.31.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:42:23 -0800 (PST)
Date: Wed, 31 Jan 2024 14:42:21 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sean Young <sean@mess.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] backlight: mp3309c: Use pwm_apply_might_sleep()
Message-ID: <20240131144221.GB5929@aspen.lan>
References: <20240128154905.407302-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128154905.407302-1-sean@mess.org>

On Sun, Jan 28, 2024 at 03:49:04PM +0000, Sean Young wrote:
> pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
> pwm_apply_state() to pwm_apply_might_sleep()"). This is the final user
> in the tree.
>
> Signed-off-by: Sean Young <sean@mess.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

