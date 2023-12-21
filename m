Return-Path: <linux-kernel+bounces-9117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD181C0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160861F23BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674B77F16;
	Thu, 21 Dec 2023 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlWXWltM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DEB7762A;
	Thu, 21 Dec 2023 22:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11FFC433C8;
	Thu, 21 Dec 2023 22:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703196689;
	bh=Z9hXMKVZ8tlGaA+HpSUiTzTbIZxbbxkEYRG/kNA4kKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlWXWltMmb5ueSr4sMV/rvCCcMB0vsaqeVLlqksmKzu29W2b2D9e4Mkafq87tEL0n
	 cDkazvxzSAMTiK3BJx+VPLtx8sdv50XkDTwCfE+UZzopyuHTaKkypLu5tg2y7icrEz
	 4J8zyW0h8/28JdxFMyX3khoOXa4hLu0w+JzIcZ7b4E1v7eck23ou1TIxBaNPm8a9lU
	 eor1kZyUvKjTVAr+BP51zL7vSdQ7UT9bgnVZSOsNsCdAPKUoH4dNX+WCfJTmPS0FAp
	 qtpnS6y2Xk7/ZRELmhLuEq7Tp2pyM2cg4T4L9IdeV3bPHV7nkdHBT/xCU39Ya0AiY5
	 LC0Uzua1Ua1Cw==
Received: (nullmailer pid 182706 invoked by uid 1000);
	Thu, 21 Dec 2023 22:11:27 -0000
Date: Thu, 21 Dec 2023 16:11:27 -0600
From: Rob Herring <robh@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Robinson <pbrobinson@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: display: ssd132x: Add vendor prefix
 to width and height
Message-ID: <170319668738.182673.3159926797028333161.robh@kernel.org>
References: <20231219203416.2299702-1-javierm@redhat.com>
 <20231219203416.2299702-3-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219203416.2299702-3-javierm@redhat.com>


On Tue, 19 Dec 2023 21:34:07 +0100, Javier Martinez Canillas wrote:
> Commit 2d23e7d6bacb ("dt-bindings: display: Add SSD132x OLED controllers")
> used the wrong properties for width and height, instead of the correct
> "solomon,width" and "solomon,height" properties.
> 
> Fix this by adding the vendor prefix to the width and height properties.
> 
> Fixes: 2d23e7d6bacb ("dt-bindings: display: Add SSD132x OLED controllers")
> Reported-by: Conor Dooley <conor@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20231218-example-envision-b41ca8efa251@spud/
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/display/solomon,ssd132x.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


