Return-Path: <linux-kernel+bounces-106461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B187EEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076231F21D03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F255E54;
	Mon, 18 Mar 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM2Ecen0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049D52F8C;
	Mon, 18 Mar 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783185; cv=none; b=D+EslKEnzlue0ax4hhjlD1k4IowJ17s+WRZuCXkbyT80B3LrUh+cgkuKxNVaIZGnW1mja3AI39OSdKO/nOgu94XpssdT7ofwYmeDJpROBI7xLMOIcyI8tYFzPiDIlhfxyIVmCa+oDvtb02KzaaOrAW3pcYZAHBfNkL0/JexBGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783185; c=relaxed/simple;
	bh=ENRY4RVP0h54nhmVNDQhGHTYt8HGJlRWH34eD47ylM0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=fLS/0JowjFfJ/EK6v/Dk1NC536A2pDbWLxaFl07/Pt1S9DRnVjIrFsr3qZskhkTRZC5aL4KUybO9RObV5om625DiMKWNbfI06gJQfw3YNmB1ht07hsy6sLb8tvIKeEw1TpzVSfs0FY8l05QH6j8D8jMxCGiYeZzTGR/bAi6lIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM2Ecen0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93517C433C7;
	Mon, 18 Mar 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783184;
	bh=ENRY4RVP0h54nhmVNDQhGHTYt8HGJlRWH34eD47ylM0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KM2Ecen0KMGLaB7wkuNqD7lgDCgEniJcA1B1VjgHVUXbnB/M39nKgoS8Hp2+BaUg3
	 /82P1e4FwmtyfxCm5laIuGpxtwkj3cZKpPn4ZSBqgHbyyxOmv+dg+gZs3RDYK9zpqk
	 Ds1NPT7X1X/qozRslRav+C1tpQkUnAZHSsRD4apQipLxfNcTYdRfpwWUbZOHHmNjPU
	 bZ+iHzoo7ONWYMG381TULtoGTz6zYXAMS9COdKCcOPECQB8N8yDaSwHuUMiMKzGIlc
	 zbmt0ES7v467/unObcqnC4A3YlsKvY0v4pQYapqom9ZuDrX2eaiogLmk5QfWx86PeL
	 ztfJRIKfl6cLw==
Date: Mon, 18 Mar 2024 12:33:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Naushir Patuck <naush@raspberrypi.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 linux-rpi-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
In-Reply-To: <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
Message-Id: <171078318246.167654.12048961258592577365.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for
 raspberrypi,rp1-cfe


On Mon, 18 Mar 2024 17:49:57 +0200, Tomi Valkeinen wrote:
> Add DT bindings for raspberrypi,rp1-cfe.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../bindings/media/raspberrypi,rp1-cfe.yaml        | 103 +++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.example.dts:24:18: fatal error: dt-bindings/clock/rp1.h: No such file or directory
   24 |         #include <dt-bindings/clock/rp1.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


