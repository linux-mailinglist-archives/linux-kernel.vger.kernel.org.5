Return-Path: <linux-kernel+bounces-50472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF9847988
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D1A284499
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A362839FB;
	Fri,  2 Feb 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uifkYLOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940881732;
	Fri,  2 Feb 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901331; cv=none; b=bY6Xn48x0/Vyym6CsxNdWx6Yh1HBoj20rc1txQ7h2gqn/adAwUKB9BG+7FezcNBLGtbs3sGYl5aT5lUS9ki/WII0M7iCPZBEgWxepLqDcPvdCxlnGfhVohV0WqM8Adzv24ObxJbgvLjGYQSZLpUAPQ68nAwPK3TNhJFUoy3bqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901331; c=relaxed/simple;
	bh=a+pc0m5kqTWpI/aJb1aTHt+V0f2EIaLSkUCe+GD8fv8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kpONp5HtI853ni+z15pRtE85VP9AYnOjZ8EAKKMc8i9a6SqeKQKM/UIgb1n1V1B4jyI394p3VI3OEqNgO58QDQhVeuRNnQptlhLKMSjP1cA4BTQLO4NwA37T0ANE2yXtXB5Fn0PA2UKSLlgwyjcKRz323YOYug6sj/3DE6YXHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uifkYLOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0A3C433F1;
	Fri,  2 Feb 2024 19:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901330;
	bh=a+pc0m5kqTWpI/aJb1aTHt+V0f2EIaLSkUCe+GD8fv8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uifkYLOif5Xph+fk8N49wkdWAMPM/Kwnt839/2bRtFuoRinBFWQX2RprJMQ1Dd0RG
	 IKmkuMlgiHYxfOqCqoLjklhGtZGZ10njGsOOATStM7nmOJzd8dOnCsniGuYXV8d959
	 avQ2BxuT4vGpH0h2osonWaR5jAKoITiNccmAqfZHH8J7HHiXKq+rTx1Mz1hac8ZBbX
	 SaqbxXKf+EZZU8C2DHhrHFio472xQdg+dIuoLzKMgg14ekQfjtmt8FHfR5gmqXVnGr
	 PUiY/53Lsl89lgU7lgjgPY1ntIRpGKlkE6uneihES1T5D0Z+kQV/17k70L53STJSWW
	 z7wnKlAFadmng==
Date: Fri, 02 Feb 2024 13:15:29 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Hari Nagalla <hnagalla@ti.com>
Cc: linux-remoteproc@vger.kernel.org, nm@ti.com, kristo@kernel.org, 
 p.zabel@pengutronix.de, martyn.welch@collabora.com, 
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org, 
 vigneshr@ti.com, devicetree@vger.kernel.org, andersson@kernel.org, 
 linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, robh+dt@kernel.org
In-Reply-To: <20240202175538.1705-2-hnagalla@ti.com>
References: <20240202175538.1705-1-hnagalla@ti.com>
 <20240202175538.1705-2-hnagalla@ti.com>
Message-Id: <170690132805.611395.5930395618284837775.robh@kernel.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x
 SoCs


On Fri, 02 Feb 2024 11:55:34 -0600, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks
> 
> Changes since v2:
>  - Missed spelling correction to commit message
> 
> Changes since v3:
>  - Removed unnecessary descriptions and used generic memory region names
>  - Made mboxes and memory-region optional
>  - Removed unrelated items from examples
> 
> Changes since v4:
>  - Rebased to the latest kernel-next tree
>  - Added optional sram memory region for m4f device node
> 
> Changes since v5:
>  - None
> 
> Changes since v6:
>  - Removed blank line, fixed type for firm-ware property and binding check
>    errors.
> 
> link to v6:
>   https://lore.kernel.org/all/20230913111644.29889-2-hnagalla@ti.com/
> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240202175538.1705-2-hnagalla@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


