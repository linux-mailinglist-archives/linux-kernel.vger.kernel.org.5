Return-Path: <linux-kernel+bounces-156947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567D8B0AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171C21F2349D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005415B977;
	Wed, 24 Apr 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTBfayaM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB52AEFB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964835; cv=none; b=iM2Sb5OkriDb3XidcbAO9ll0fmfnXCHJQ7u0EuIs6SWdIDHRmFRJ7sNx5Jl4L5EIlnTQ59an10GJSp6oPMb4MgHZ1QWF2wTw50qMheYRHe/T3CMGi4/82P2CNuWy7tNdOAhFPu/EsaTXd8X6D5AtRbdeubm0b/F3J1qeSFK6rNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964835; c=relaxed/simple;
	bh=5EpFadq0ZInp1s+VEvsfR5N+7n7nws126mwu9XDnLXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmqjWNmI6Wg9w+wTlazJL8MDzZXUG9N/9TJx4qKez0pf5e6dK/LPLKHhHoQlNVkgWiykhe0l13obJZR/hbPw27VojPH8P/qwZg2PQy585eGG7XEYYw9nBFlPjrFLi3mfxVXIkgeFhyknfRZx/WzAXXZ3ZRBik/OMMaGVzH2PJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTBfayaM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a7ae25d53so23812085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713964832; x=1714569632; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2TyuW/9e9KLJDEWEaZausa76J+1CE2fdIpzJjL72yaU=;
        b=eTBfayaMluyOz2ft47IvZiC/RxNWuj+OgCJnPI9A7xstu+naHkHmPCZ70enTZnL/U/
         R40LFLkhs/1ITUR2JH5E2lfziNeGQEH0pJ1R73f8GyLu4p3h5krhCKkornWYNXk2i22j
         tE/I1jCwnUacBraRfY5gE9A12gvtX0X/7NWGVSMdI408PTnVgD3SxSqX+/cpG+quLxeP
         cxuxx1xMaJqgcyUMH37/sAiYHzPwVoK47cXzJIqlFhtxWQP50jNoRgFn/EaKZiY+xdfY
         yws39nncTZfz6rB6XW6ABYvA5gELfwLJ9pJRSURDOj4QfbqmPxEmCSJbZPXDeAefs7A9
         52+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964832; x=1714569632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TyuW/9e9KLJDEWEaZausa76J+1CE2fdIpzJjL72yaU=;
        b=LdHgknwMXQZ422D8ejdYYhQ+Qi0rbu3q/atdevuCVlzB2zsLyFVCT9trHXph6z6X7e
         JuRPEIRnHGCuB3urHHxfcVGhg2t+J7HydfeYm6uZyA3KnGB21powG6bH7nGdD42jTWLY
         seFunUxCq60luvwOopJVTQXnyR1UizO3PzLsUriLohTY/uEPYszQ4cdPspJLBV7zFzb5
         4b3nKPqsfazejN58BC8jn87VBx8+ZJdlFmLS/87eufsggzj5QZJmzzLTbO5mI0WW6Jqp
         DUff98BePG/ZWNqIxmPRtjCSkSD4w0x80DA668M/bF2p7FvdIi9wfi2KxKsUqfH8nTwc
         Knvg==
X-Forwarded-Encrypted: i=1; AJvYcCVJwUtQM++RKsc9rCIl3fLqRwdXZG3xyVbfVim+Iqutil7YB+DDIMJCn43yGD5hWDGc9amTSC8SaHv9HLRVcXh0MVrw1TdiBvsq4RrG
X-Gm-Message-State: AOJu0Yy8ncmOZq/WGPH1KsORyML+CT+bCHAjdEsj5XU97RIFvRd7zsP9
	MSHpsbZKeaPDT1m+MPJISQKsEj1RyLwDdLXz869Swdy02xqf4S+Wkn04w0lk7+0=
X-Google-Smtp-Source: AGHT+IEqx+6Q5HPT/226uSYOEj4gagY8/ay6pqBgEdYUwvp1rFV97+gPRI8UX0jMy33YgTglYnf6VA==
X-Received: by 2002:adf:ec49:0:b0:34b:e79:2677 with SMTP id w9-20020adfec49000000b0034b0e792677mr1820503wrn.63.1713964832050;
        Wed, 24 Apr 2024 06:20:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0034a44c615ddsm15180075wri.88.2024.04.24.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:20:31 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:20:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Alvin Lee <alvin.lee2@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
	Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: re-indent dc_power_down_on_boot()
Message-ID: <4a996c51-e101-47a0-8a89-78c6f9f01e0f@moroto.mountain>
References: <e5f538ab-ebc8-400b-8104-4642b8089b4f@moroto.mountain>
 <bbc315ed-3482-4abb-b3f6-88c335dcf9d2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbc315ed-3482-4abb-b3f6-88c335dcf9d2@amd.com>

On Wed, Apr 24, 2024 at 03:11:08PM +0200, Christian König wrote:
> Am 24.04.24 um 13:41 schrieb Dan Carpenter:
> > These lines are indented too far.  Clean the whitespace.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 8eefba757da4..f64d7229eb6c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -5043,11 +5043,10 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
> >   void dc_power_down_on_boot(struct dc *dc)
> >   {
> >   	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
> > -			dc->hwss.power_down_on_boot) {
> > -
> > -			if (dc->caps.ips_support)
> > -				dc_exit_ips_for_hw_access(dc);
> > +	    dc->hwss.power_down_on_boot) {
> > +		if (dc->caps.ips_support)
> > +			dc_exit_ips_for_hw_access(dc);
> 
> Well while at it can't the two ifs be merged here?
> 
> (I don't know this code to well, but it looks like it).
> 

I'm sorry, I don't see what you're saying.

I probably should have deleted the other blank line as well, though.
It introduces a checkpatch.pl --strict warning.

regards,
dan carpenter


