Return-Path: <linux-kernel+bounces-9120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C981C0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB381C234D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E077F1C;
	Thu, 21 Dec 2023 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3PgqdPP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81977F09;
	Thu, 21 Dec 2023 22:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F47EC433C7;
	Thu, 21 Dec 2023 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703196867;
	bh=cYS3cTDbw5ZEO4RjMQJxm2bzTbH7s3/S3JHSmNe9LI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3PgqdPPNA0G2/m4c2P6d/DNk03EOFgdBDVbb9yFwFSiYav/aVFEgskn5ffIJmlaL
	 9MF0hK8gDjJY23vJZP0s3MHRqyN8RzoA/MjxHLCJnNCQx3SFKmMLB6uaJf7tMktxdG
	 U0qy7IRnkA47Z0Vl5mvT6vL4d7KQYB95RDWgm+upcaMfDb4Eb8FegPhwwyz21Gzp4f
	 mm70kstEkaMyEcSP2agMqZEB0+iYKB6bEgZq2KiaIUXFfCH1AmwkAENsV0Cucqtiez
	 A3S5y+HfOFoLOv0E//1GYTl5ybtBOt3hz4i3D76jhAdlD8vTr3V8IHZqeOEPmEy8Up
	 hUygrIuwakyaA==
Received: (nullmailer pid 186572 invoked by uid 1000);
	Thu, 21 Dec 2023 22:14:25 -0000
Date: Thu, 21 Dec 2023 16:14:25 -0600
From: Rob Herring <robh@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 3/4] dt-bindings: display: Add SSD133x OLED controllers
Message-ID: <170319686456.186513.13956120421237374815.robh@kernel.org>
References: <20231219203416.2299702-1-javierm@redhat.com>
 <20231219203416.2299702-4-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219203416.2299702-4-javierm@redhat.com>


On Tue, 19 Dec 2023 21:34:08 +0100, Javier Martinez Canillas wrote:
> Add a Device Tree binding schema for the OLED panels based on the
> Solomon SSD133x family of controllers.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v3:
> - Move solomon,ssd-common.yaml ref before the properties section and
>   width/height constraints after the other properties (Conor Dooley).
> 
> Changes in v2:
> - Unconditionally set the width and height constraints (Conor Dooley).
> - Fix indentation in the DTS examples (Krzysztof Kozlowski).
> 
>  .../bindings/display/solomon,ssd133x.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


