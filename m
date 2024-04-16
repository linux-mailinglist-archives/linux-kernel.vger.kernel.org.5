Return-Path: <linux-kernel+bounces-147518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5818A758B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDDD1F23857
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468DF13A253;
	Tue, 16 Apr 2024 20:28:34 +0000 (UTC)
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1380137905;
	Tue, 16 Apr 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299313; cv=none; b=GlNRmi8EmX8ua9AI3L8TpJIDU30gcPOaF7bdf9zu94v2zKuexi9LzgsUfqOlNrj42MWbpkJfE5QFdBWo37i31nqBOEPt+su1N4/UA5oyDAUt6TutQeXOXrwUqQqV3o79EAset9PqC+iK7cfbZANuGN5ixjszi2MxYD5yaFSzBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299313; c=relaxed/simple;
	bh=Jf3GFSgQq8PdR/zavIuEzjphkugs0D4gKD2oJXptHhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ521bNVYFQCB90LLDtLadxKUAx0qz+BE0q8rCew0taDSaxm7A5GPzyQyzL2+bd8Bs7s1tLOiWsxb0MAE4wiDzfTAOCJT+nelE/8mpPzFV1KkU5T2li4HMyhNEkosfe4hyVz6yJywVZAMfSrK78w7dFsUk0j5fGPYSukbWSVorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6CFBF3FC93;
	Tue, 16 Apr 2024 22:22:35 +0200 (CEST)
Date: Tue, 16 Apr 2024 22:22:34 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: David Wronek <david@mainlining.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
Message-ID: <e2jkc4gs74pe365danyiq22f7s7wqxvj27jrjlzehgsgigf2dd@gai76zslxr7o>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, David Wronek <david@mainlining.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
 <20240415-raydium-rm69380-driver-v2-2-524216461306@mainlining.org>
 <yccnqb63gp5svx76rudfnphecpatkpwgp2wlfenojebulrigma@xfztf3ox6q7d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yccnqb63gp5svx76rudfnphecpatkpwgp2wlfenojebulrigma@xfztf3ox6q7d>

On 2024-04-15 19:50:49, Dmitry Baryshkov wrote:
> On Mon, Apr 15, 20
[...]
> > +static int rm69380_on(struct rm69380_panel *ctx)
[...]
> ret = mipi_dsi_dcs_set_display_brightness_large(dsi, 0x7ff);

Downstream may send this here, but why?  As far as I've observed, update_status
also sets &backlight_properties.brightness which you configure below.

Try removing this line and maybe also set the initial brightness lower to the
benefit of users' eyes and OLED lifetime?

[...]
> > +
> > +	if (dsi_sec) {
> > +		dev_dbg(dev, "Using Dual-DSI\n");
> > +
> > +		const struct mipi_dsi_device_info info = { "RM69380", 0,

Personally I'm never really sure what to put in the name here, maybe something
that signifies the second DSI interface of the panel?

> > +							   dsi_sec };
> > +
> > +		dev_dbg(dev, "Found second DSI `%s`\n", dsi_sec->name);
> > +
> > +		dsi_sec_host = of_find_mipi_dsi_host_by_node(dsi_sec);
> > +		of_node_put(dsi_sec);
> > +		if (!dsi_sec_host) {
> > +			return dev_err_probe(dev, -EPROBE_DEFER,
> > +					     "Cannot get secondary DSI host\n");
> > +		}
> > +
> > +		ctx->dsi[1] =
> > +			mipi_dsi_device_register_full(dsi_sec_host, &info);
> 
> Either you should be using devm_mipi_dsi_device_register_full() here or
> you should call mipi_dsi_device_unregister() in the error and remove
> paths. I'd suggest the former.

There is also devm_mipi_dsi_attach() which may solve inadequate cleanup handling
in the error paths below, as pointed out by Christophe.

> 
> > +		if (IS_ERR(ctx->dsi[1])) {
> > +			return dev_err_probe(dev, PTR_ERR(ctx->dsi[1]),
> > +					     "Cannot get secondary DSI node\n");
> > +		}
> > +
> > +		dev_dbg(dev, "Second DSI name `%s`\n", ctx->dsi[1]->name);

It looks like you inerited /all/ my debug logging when copy-pasting this setup
from my in-progress dual-DSI dual-DSC Samsung ANA6707 panel driver.  Since it's
all working now, I suggest to remove mostly-useless debug lines like this.

I'll continue the review on v3, as I mainly wanted to extend the initial devm_
suggestion from Dmitry done on v2.

- Marijn

