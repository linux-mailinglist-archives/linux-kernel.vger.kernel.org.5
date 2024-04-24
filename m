Return-Path: <linux-kernel+bounces-156989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91728B0B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E481F2313A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566615B986;
	Wed, 24 Apr 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvIuJ+ho"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325E15D5DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965952; cv=none; b=HrXMcFb7a0h29EO39VQy4cpyNPbVPyt/bFx9GNcbhm5uu0p3Ew1eg+5BFlfCNnoMxayI4QebXBsa/BbUTCrhWaDwRZvz3LEBaVBXMscW1iANi68KTyb1xXxsEe5RJFYEvShuMUIGyzNa8bZoIaKA7CJ0VDNwOuXqAx5LjbXyB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965952; c=relaxed/simple;
	bh=D9UumX0rfFAl8bODnci2/+e3JYR71o9zPa56jancOjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOPKE1rjNvGnhKcFBr7SAvSJHoN9X/2H2gabnDZV0+5txUVBk591tTyARxdunWRoy52aQVMwNJkHgdjwRcYSG2qVA8Wwn1jFMEjWJr1hXV2PfytAAwb63ukTFexkeHLrrBwnw0F1XN4rgfYLiryk5+nogmiNNzXhm2KDuNmx6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvIuJ+ho; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b2119da94so1864945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713965949; x=1714570749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIDjR8nmsolOxVRznr4LV9PEh0hWdtOUeRoonddM+RQ=;
        b=wvIuJ+hotDgKpgQEaqeldHJkkdwHIUB5oagHQgo0gPAobcnB2oG6+iLLRpW9AEtULP
         t/K1DYrXyMKb0fNsKRSkI3NAWzVsS82sTGfeB3htM5XF4QaPNj9bC90Ezc8Zlz2oKcyE
         w/Qw0D1Qp/bWo3R4qFFG7mu3dCEo5dBAk/59SvFVCpjjDQelsGDFNpJIPU8euODtLiJR
         YgiLfXtz3XP63VZbZAT/N8pvlbQo3hDxHIl8YqjyBRfiIGk7Oe/BzlNnnO1WDkkXkl9+
         yR8LmRpD6rZhzWD3xPEWay99sjPrpBzq7WFLtPImLCFfXIoLS4X7e1ED54shnFnE2uDU
         NpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965949; x=1714570749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIDjR8nmsolOxVRznr4LV9PEh0hWdtOUeRoonddM+RQ=;
        b=JYy5iphMI7rjU5z+/sWpsHA82UMyH+XOtNgjoYPVzRH99R3BzhIRBW7Le53svDXsfx
         MSpqwjLDd0Fo9S219MR4b4NbS/785eMgivNtfvQNZ6GfqwijA4H8UCbKUnDAxDMSbzJw
         E5se4S9kLiDQfiDY2i9hWyK0KqGs4UDLyFG6ayrqkQASy1U4QJYmJovTG4z+BoRynlpt
         scJgs9fGrc8BX5+NPl5lZ0x29DJx6Wbs7bry7/JcuHt3w6WMmgO0xwJ8sM8qeAyTQ+p0
         3sBqektibaODgpLNwFSPPtB7CefpJ7z1RbucC81IMoxhEsmmrrkdCrWGS1lo8ieh9t3T
         MICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqAM7RTpJ4XjeSYTI1S1V21GuL6yymWswt3RQXjmFm3j/KdelqS2Ha4MffE+el8iAmniqAi3U+OBk+cdA1SpZG8gx7NtOnHbei0Pcs
X-Gm-Message-State: AOJu0YzCa18vc1wsLksDdVGcSOjkPT+M3D8YCNEVdVfJE59EphQJD++6
	oIrI6yVjlC+BTEhht+AfniTu0BqItMQKgpTt/o6vZzA2ZyY8H4tyz+v9T+n7bPc=
X-Google-Smtp-Source: AGHT+IGNGlL4K3RRWvrPnAS8pS+Nk+ThgYEusmDN6lyoq8bygca8tJqniABTWOqIDwkwqhh9NtmiVQ==
X-Received: by 2002:a05:600c:1c13:b0:41a:3868:d222 with SMTP id j19-20020a05600c1c1300b0041a3868d222mr1706203wms.0.1713965948935;
        Wed, 24 Apr 2024 06:39:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm27796791wmb.41.2024.04.24.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:39:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:39:03 +0300
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
Message-ID: <d3a49914-65de-492f-9bf4-f3daa0c9f3cb@moroto.mountain>
References: <e5f538ab-ebc8-400b-8104-4642b8089b4f@moroto.mountain>
 <bbc315ed-3482-4abb-b3f6-88c335dcf9d2@amd.com>
 <4a996c51-e101-47a0-8a89-78c6f9f01e0f@moroto.mountain>
 <f3b0e0fe-edb9-420d-b4a1-71c267246875@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3b0e0fe-edb9-420d-b4a1-71c267246875@amd.com>

On Wed, Apr 24, 2024 at 03:33:11PM +0200, Christian König wrote:
> Am 24.04.24 um 15:20 schrieb Dan Carpenter:
> > On Wed, Apr 24, 2024 at 03:11:08PM +0200, Christian König wrote:
> > > Am 24.04.24 um 13:41 schrieb Dan Carpenter:
> > > > These lines are indented too far.  Clean the whitespace.
> > > > 
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > ---
> > > >    drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++----
> > > >    1 file changed, 3 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > > index 8eefba757da4..f64d7229eb6c 100644
> > > > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > > @@ -5043,11 +5043,10 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
> > > >    void dc_power_down_on_boot(struct dc *dc)
> > > >    {
> > > >    	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
> > > > -			dc->hwss.power_down_on_boot) {
> > > > -
> > > > -			if (dc->caps.ips_support)
> > > > -				dc_exit_ips_for_hw_access(dc);
> > > > +	    dc->hwss.power_down_on_boot) {
> > > > +		if (dc->caps.ips_support)
> > > > +			dc_exit_ips_for_hw_access(dc);
> > > Well while at it can't the two ifs be merged here?
> > > 
> > > (I don't know this code to well, but it looks like it).
> > > 
> > I'm sorry, I don't see what you're saying.
> 
> The indentation was so messed up that I though the call to
> power_down_on_boot() was after both ifs, but it is still inside the first.
> 
> So your patch is actually right, sorry for the noise.

Okay, but let me send a v2 anyway to delete the extra blank line.

regards,
dan carpenter


