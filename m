Return-Path: <linux-kernel+bounces-142559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F78A2D26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2164EB222F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50153E38;
	Fri, 12 Apr 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVb1Fjbu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC342064;
	Fri, 12 Apr 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920649; cv=none; b=WW6Q7ntxU2rub62n9MAGu8PFmnAw+zifgmoGgweb+72Ya0tErsON6Pqjf406PzmjmJu8+8t0T4F4rGQei42MbV4WDzp8PuOxqc7JCwGegr/rzeOrup+SiYg24bBXkoVzTPbJzW/Yov9ZeVjLYP1bHxo+zkCJ3lEUDY3+luOaR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920649; c=relaxed/simple;
	bh=SvdlhNNtUWHChB5l1joPBSlS4XqFexo2+rAXJJlhAE8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jEt38bIc/XlA4H3h79GI16jW4BUcON7TaKS5jfjgwu+YUeEuC+yZ46Z2FvxM1MQ0DGDMAnbsiTJi/pbOn//F88MYKtlxpQmOXbw2WPQkM1vZD+jzWLoTtes5N8wHN/IC48SZo2zJfOhZz4bBrTKb+HAel8QSY/oE28KyWOXzJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVb1Fjbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7A7C113CC;
	Fri, 12 Apr 2024 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712920649;
	bh=SvdlhNNtUWHChB5l1joPBSlS4XqFexo2+rAXJJlhAE8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FVb1FjbuIh0ACxAJQxzVk9u0EuMVSPdiXpsMhzvNDRhpiVlqEviQ9mzm6ZHvL+uiu
	 LyPSyrh76UCV6BeRqUhXSHsnc73W+rmgc/FT0ya2cAkH+WHBG4tbyl4ds4AoL2lpdq
	 NsBRgUzh8OSTyIuouYRSfCmZROhdqHr1I8zZssb14WoFS1Nv9rCIZUqLZZZNAoTA/T
	 l+niw7ysStJGtIM+leJ/eiMY/oD2in17aYJjMUWf0SEDqEom61jE+lvF64NxoykFg7
	 jaqw8SrgZTCEhL6QXuTiWcfsXOmMqDfUkcVpqt2I4A1y/ZobeVQ242TSVcBvPiucZC
	 jIkpSYOezqtrg==
Date: Fri, 12 Apr 2024 06:17:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, 
 linux-sound@vger.kernel.org, dardar923@gmail.com, 
 devicetree@vger.kernel.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com, 
 krzysztof.kozlowski+dt@linaro.org, KCHSU0@nuvoton.com, perex@perex.cz, 
 SJLIN0@nuvoton.com, scott6986@gmail.com, alsa-devel@alsa-project.org, 
 edson.drosdeck@gmail.com, YHCHuang@nuvoton.com, conor+dt@kernel.org, 
 u.kleine-koenig@pengutronix.de, supercraig0719@gmail.com, tiwai@suse.com
In-Reply-To: <20240412103554.3487290-1-wtli@nuvoton.com>
References: <20240412103554.3487290-1-wtli@nuvoton.com>
Message-Id: <171292064682.1830010.10520655676449462428.robh@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: nau8821: Add delay control for
 ADC


On Fri, 12 Apr 2024 18:35:52 +0800, Seven Lee wrote:
> Change the original fixed delay to the assignment from the property. It
> will make it more flexible to different platforms to avoid pop noise at
> the beginning of recording.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nuvoton,nau8821.example.dtb: codec@1b: Unevaluated properties are not allowed ('nuvoton,nuvoton,adc-delay-ms' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/nuvoton,nau8821.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240412103554.3487290-1-wtli@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


