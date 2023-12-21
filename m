Return-Path: <linux-kernel+bounces-9116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C879B81C0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C808A1C22664
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CE77F15;
	Thu, 21 Dec 2023 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zub9895/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0076095;
	Thu, 21 Dec 2023 22:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1EDC433C8;
	Thu, 21 Dec 2023 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703196667;
	bh=l/kng9zyEiAwckm6pSVVW08SeFJWGMt/bBmLADFWOo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zub9895/30rjVokS1uM49Mh06/RD8bO32fJbF94+s6N3RUXc2Kj4Gqi4/qn3/W1LA
	 fghTCAjHP/2EdTsbVkejK9PywZhEDRPWZv6Tor5xmfsaJ2tHUarKQn8Gku9hhkZ61K
	 2hRYv4yrNZ3CFlJivWW7Fi4KqDtD172u0aHXTAzN+pusunkxynV9MVJOTr2xEF7tJy
	 0TAr8HW0QvDWZ4pHrUkKXsGXMSzLAp20G2CxOK+ysZfKDAHQNenB9mQEMoKCxhiN81
	 ET5xK4YApjS3EQROSjIlYdE8s99xUa9HRoXQknmg2u+6Zr7iQ0PR8dzWnji1CtmZa8
	 kqf18ykTgVhrg==
Received: (nullmailer pid 182105 invoked by uid 1000);
	Thu, 21 Dec 2023 22:11:05 -0000
Date: Thu, 21 Dec 2023 16:11:05 -0600
From: Rob Herring <robh@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, Conor Dooley <conor@kernel.org>, David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Peter Robinson <pbrobinson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: ssd1307fb: Add vendor
 prefix to width and height
Message-ID: <170319666507.182055.13407104511306194810.robh@kernel.org>
References: <20231219203416.2299702-1-javierm@redhat.com>
 <20231219203416.2299702-2-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219203416.2299702-2-javierm@redhat.com>


On Tue, 19 Dec 2023 21:34:06 +0100, Javier Martinez Canillas wrote:
> The commit 591825fba8a2 ("dt-bindings: display: ssd1307fb: Remove default
> width and height values") used the wrong properties for width and height,
> instead of the correct "solomon,width" and "solomon,height" properties.
> 
> Fix this by adding the vendor prefix to the width and height properties.
> 
> Fixes: 591825fba8a2 ("dt-bindings: display: ssd1307fb: Remove default width and height values")
> Reported-by: Conor Dooley <conor@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20231218-example-envision-b41ca8efa251@spud/
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/display/solomon,ssd1307fb.yaml   | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


