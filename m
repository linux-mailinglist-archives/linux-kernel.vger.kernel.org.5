Return-Path: <linux-kernel+bounces-139229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF08A0023
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865A91F218A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E117F376;
	Wed, 10 Apr 2024 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hovp2kNJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6732E405;
	Wed, 10 Apr 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775431; cv=none; b=c3tCRoHTI4PIbymKQAy65wWl/3Y8bhJyoMFrHPUCur1iy0gvPQWVis/2lwOHVKBwE7yNnWv1QksvLb/gnyOvX8HSK2cFzw9A4yfEteEuALxy3YmM413k0u2R4MvxlZ5vGDOZW2aZzihV+m9UaKRu9THmKNRJU5W+hzruVzsbFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775431; c=relaxed/simple;
	bh=1pr4aMZSU4Lugs+zJr+eQADtuseadL78E1eXv5pdPnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFkfU0SjgVoB1gVY3C7VMrDU5GHbA4GFQRhGbTu4YMUp0A3MZUi8nuv9hacd+6yciVMhkWj8JEGbNaqVgaSKdX/Mn35WbDHEZCx5k8qWzzltdh50qNm11XBRdW3+YTtdpZW5wbWGpPxIaPAkAAKMSVOnynrlPRmgqECKSr5wRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hovp2kNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E824CC433C7;
	Wed, 10 Apr 2024 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712775431;
	bh=1pr4aMZSU4Lugs+zJr+eQADtuseadL78E1eXv5pdPnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hovp2kNJfByBs6PovxEnzv77Oi7dLKzGioqq8cnRVAbWvYammQeTdAZUz7LbSYHJS
	 TQibzE8+e4nkwjZgpqqk45lyZyKh994lb/tBcoe8PDjeGbqM3OR7052ceNgTp4Z49O
	 L/jjrJd615oT7fC9j8wodlmvgT+djN+tcbj0MAWR804lSIV0TPXRHCvenPQPXFzY80
	 jkLAUOZt+hU15V6lHF3+vqOBZcJMuuapmNtBNDse6bZ9/Q4B19ZphBv0NvIRRLPx6m
	 Xme5V4x94QDqXiqtR0Hyw8Zb1Ydqq2ynC9SFEc1ma0x/HSPUobTSYzERBnWQ6WI35u
	 gC5UEGuKQTPZA==
Date: Wed, 10 Apr 2024 13:57:08 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Jacobe Zang <jacobe.zang@wesion.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Neil Armstrong <narmstrong@baylibre.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, quic_jesszhan@quicinc.com,
	sam@ravnborg.org, nick@khadas.com, thierry.reding@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	AML <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: panel-simple-dsi: add New Khadas TS050
 panel bindings
Message-ID: <20240410185708.GA884726-robh@kernel.org>
References: <20240409082641.359627-1-jacobe.zang@wesion.com>
 <3CCAF214-09FE-4580-99CD-AB95E78FFB8F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3CCAF214-09FE-4580-99CD-AB95E78FFB8F@gmail.com>

On Wed, Apr 10, 2024 at 08:22:25AM +0400, Christian Hewitt wrote:
> > On 9 Apr 2024, at 12:26 PM, Jacobe Zang <jacobe.zang@wesion.com> wrote:
> > 
> > This add the bindings for the New Khadas TS050 1080x1920 5" LCD DSI panel
> > designed to work with the Khadas VIM3 and VIM3L Single Board Computers.
> > 
> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > ---
> > .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> > index f9160d7bac3ca..e194309f31b72 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> > @@ -36,6 +36,8 @@ properties:
> >       - jdi,fhd-r63452
> >         # Khadas TS050 5" 1080x1920 LCD panel
> >       - khadas,ts050
> > +        # Khadas NEW TS050 5" 1080x1920 LCD panel
> > +      - khadas,newts050
> 
> Products are only new until they are old. At some future point there will
> inevitably be a third iteration requiring a ‘new new’ name. IMHO it would
> be better to use something like khadas,ts050v2.

I only see patch 1, so the threading is messed up...

In any case, The commit message should say something about how they are 
different? Is the new one not compatible with the old? That's what this 
change tells me. Otherwise, it should have a fallback. 

Rob

