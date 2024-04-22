Return-Path: <linux-kernel+bounces-153930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB08AD506
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD91F226E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B220155349;
	Mon, 22 Apr 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goZuQyMj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B8155346
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815031; cv=none; b=aDp0GZlTyMPyY6TPeO2In2HZdd3wmdTuFaQvcnyjnzXle89jpetsyxiFAyUYzOveafTre73NqJzMiAguq9TEx4fBIlgbetaMTiRiM7VRpPy6TvwA8qOtJwXudgw0ilgbrixxxEqkzK09+s9Zeob7wN0FIpDHeWYELZaNmoOedY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815031; c=relaxed/simple;
	bh=VJ5gsQjKohl4OTel83tK1x5fN8lYDcKtYI/XPbA72XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkRVJodMTmJtbEt5qdh9BQh1ocaS/BkxS2lONmM/bn5QtCjQgoWx5mWg3uRyehGV0JeNGjiBlYBQw+tPfunCQXI759IIjZmtkr+ynruT8NBoyCPjEkQ4qH/AfHEPur3+MhrWdsh7LMyikGjmc+RzWZTm//WYvqK8JLs/1bQ2m0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=goZuQyMj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d3a470d5so5907428e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713815028; x=1714419828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1ey6L2csyRt+gTq+IESmLKOnnLpd2+PnL3t5tu0kbA=;
        b=goZuQyMjSRunTdWGcATyGIF/FHDPslxTk3LR+nMyIVsZhi3yaCoFcDgWOqUw9M5XBN
         4GvqllmtYa+APDgCzW96HFDFGDg/a7irwR7LNLXoB1IjLT4ZWvO6/6DI6fH67HjqcfeR
         qGOP5Nrgu9dRdnl9naRJ3SUJ1beUklopWNcdItcpZ5/KZtuamoaqkrffdFoYMqwDNXkL
         6PSHdCG4s4xakdQ/REqszmI6h69DuaAA/R2Xjn1eOSOv1PbgO611w2eW4MKNHu6yrwNT
         xQMkdifX/T3dTfkKbXrRdISDd/FjVg3f+35+S30xyI00OoHonPYc6AOankhV9hFEQLi5
         HH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815028; x=1714419828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1ey6L2csyRt+gTq+IESmLKOnnLpd2+PnL3t5tu0kbA=;
        b=MaQ7fvvzfetu1NH4gwKH74ZdGCwu93jYX9wUlFbcbdBkToEak0lRcOATVGnhnxcVkZ
         BWsNNM4ob8ywMItfQ4C8RtHNnzjsLqQlbUEn7CKrJUFF2y1OdLRUIJn8yN5I+3v7EmpV
         lT5j2/pIggsqcape9845E0/8bGQhagfsFRx+Cj8OTm4qNOKlmT5ywmw2oV3dF3Si1OO3
         rj2NEC7TL+7FG6CZyv5dw20s+EGaMpm+I79WpRBMGTUY5MRJdzMt3+IKcdQA88dTHU+s
         NxudgC1f9Jws+NmWhT2PUMFtZkNSIoKYPdj6F+jXVVR7ewUR2O0q9GPYgO+psYhn8eYu
         WGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTgBkDKc1XmxFpqWCf7dYYwwbmW8kSplZDbjnCni3YwTqTiQoVjQOFOFNAPMQvFQ8jTKGt6wsdnE4QzG4neMdyTqmQAGuxkq+uy6UQ
X-Gm-Message-State: AOJu0YwccbcMxJrebu9M1UtnfYkjduUPSdtM5VNsIs9v+bB6QYf+9V5g
	VsqHkJF2zgKs45Q4PwgR4nV92cCab7iKR8xX1yPvGEKv1ToZ6sMtpkT2UtN1yiM=
X-Google-Smtp-Source: AGHT+IG9ElrH/duOxvqcTOK0AesyJ0VjegSyv6v2IqW2JOwhgaQv9K0zAcHZGc9ZxELyif0HeSN2WQ==
X-Received: by 2002:a05:6512:ba0:b0:51a:b955:4014 with SMTP id b32-20020a0565120ba000b0051ab9554014mr9729079lfv.18.1713815027508;
        Mon, 22 Apr 2024 12:43:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id v14-20020ac2558e000000b0051891b7578esm1802167lfg.198.2024.04.22.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:43:47 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:43:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Adolfsson <Johan.Adolfsson@axis.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] drm/panel: panel-simple: Add generic panel-dsi driver
Message-ID: <dn33u6orierkw3skh3mymkc3u77wn2cbpqs7rznyndnku7txr7@2lvvxudsvda7>
References: <20240418-foo-fix-v1-0-461bcc8f5976@axis.com>
 <20240418-foo-fix-v1-1-461bcc8f5976@axis.com>
 <76b46467-6a27-4f07-8a3e-cdd51e2e28bb@linaro.org>
 <PAWPR02MB9281557BDDA960812412E0D59B122@PAWPR02MB9281.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR02MB9281557BDDA960812412E0D59B122@PAWPR02MB9281.eurprd02.prod.outlook.com>

On Mon, Apr 22, 2024 at 02:05:01PM +0000, Johan Adolfsson wrote:
> Hi,
> Sorry for delayed response, still investigating why these mails didn't reach my inbox as expected..
> 
> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 
> Sent: den 19 april 2024 01:06
> To: Johan Adolfsson <Johan.Adolfsson@axis.com>; Neil Armstrong <neil.armstrong@linaro.org>; Jessica Zhang <quic_jesszhan@quicinc.com>; Sam Ravnborg <sam@ravnborg.org>; Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>; David Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Thierry Reding <thierry.reding@gmail.com>
> Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; kernel <kernel@axis.com>
> Subject: Re: [PATCH 1/2] drm/panel: panel-simple: Add generic panel-dsi driver
> 
> On 18/04/2024 16:01, Johan Adolfsson wrote:
> > Add generic panel-dsi panel, similar to panel-dpi that can have it's 
> > timing, lanes and flags overridden by devicetree.
> > Add some dev_err() and dev_warn() calls.
> > 
> 
> ...
> 
> >>  		/* sentinel */
> >>  	}
> >> @@ -4992,17 +5051,28 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
> >>  		return -ENODEV;
> >>  
> >>  	err = panel_simple_probe(&dsi->dev, &desc->desc);
> >> +	if (err)
> >> +		dev_err(&dsi->dev, "%s: err %i\n", __func__, err);
> 
> >This looks like debugging code.
> I added it since you don't really get any good hints on where things fails if they do it.
> Debugging code or not depends on the definition I guess - it helps the user track down a faulty devicetree,
> or as in the case below mismatch with the DSI driver.
> 
> ...
> >>  	dsi->format = desc->format;
> >>  	dsi->lanes = desc->lanes;
> >> +	of_property_read_u32(dsi->dev.of_node, "lanes", &dsi->lanes);
> >
> >Is this defined in the binding?
> 
> Apparently not which I assumed. Other bindings mentions dsi-lanes, but I guess "num-dsi-lanes" would be more correct.

Please use drm_of_get_data_lanes_count() and corresponding property from
the bindings.
> 
> >>  	err = mipi_dsi_attach(dsi);
> >>  	if (err) {
> >>  		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
> >>  
> >> +		dev_err(&dsi->dev, "probe attach err: %i", err);
> >
> >Do not introduce unrelated code changes.
> 
> As before, it helps the user who has a messed up devicetree find out, since we now gets some more configurability using devicetree.
> Would it be acceptable as a separate commit, or should I simply skip this?
> 
> 
> >Best regards,
> >Krzysztof
> 
> Thanks!
> 
> Best regards
> /Johan
> 
> 

-- 
With best wishes
Dmitry

