Return-Path: <linux-kernel+bounces-9072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683C81BFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A6288B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4227690B;
	Thu, 21 Dec 2023 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3z+8wD2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529676DB3;
	Thu, 21 Dec 2023 21:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3008C433C7;
	Thu, 21 Dec 2023 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703192997;
	bh=MOv2Ps6cE6dmQApM5Rwy2jg3rccLNITICS9IRnMhXiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3z+8wD2mqTIkYTCtx608pczUdMSijGLS9F+KeWgjLDVZMfQMcFcYrOae2STvxjk0
	 HC4DSuqXpyk0LAHxlS/YjGIBqM//J9GNOIZeAo7SuEm3wxokvThk6ezw6vIc+IWOq9
	 BKMkhyRTTZZqjTrhbzfO2psZGghVzz4DHCIClhnNZUVKtJ497UKJSuM155QP/rUBna
	 ntpmZ4cWXusPyJrN+jvsV/Z+6bF6aHziDSEHVZS29rQzKWAV7CUSTSkRCK7J5i9C6L
	 vxtWSK4XgYEypvadURNqgTzwga2DJsAWB0MJmdGzWzrCvGUbzAaCZwDuBCpQf8g5qw
	 ugthze1lpuTBA==
Received: (nullmailer pid 98899 invoked by uid 1000);
	Thu, 21 Dec 2023 21:09:54 -0000
Date: Thu, 21 Dec 2023 15:09:54 -0600
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, Yannick Fertre <yannick.fertre@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, Maxime Ripard <mripard@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, linux-stm32@st-md-mailman.stormreply.com, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, devicetree@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH RESEND v1 1/8] dt-bindings: panel: lvds: Append
 edt,etml0700z9ndha in panel-lvds
Message-ID: <170319299428.98837.13859133240448825226.robh@kernel.org>
References: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com>
 <20231221124339.420119-2-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221124339.420119-2-raphael.gallais-pou@foss.st.com>


On Thu, 21 Dec 2023 13:43:32 +0100, Raphael Gallais-Pou wrote:
> List EDT ETML0700Z9NDHA in the LVDS panel enumeration.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


