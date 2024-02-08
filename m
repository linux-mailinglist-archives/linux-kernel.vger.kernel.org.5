Return-Path: <linux-kernel+bounces-58307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE5784E45B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D7528EB8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC97CF23;
	Thu,  8 Feb 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPxKZofX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFD7C092;
	Thu,  8 Feb 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407494; cv=none; b=IVmIveWH+2TnyEYvrbwiiMSfSDQYdsWKizbznlI1eJxmf3KstKIJzl9FpVTG2qx02KHVb/Ov5QVSvkyYNVJvOu6zmodiTkLmyGTCEuB1A+LGsQEgvZ63MTM4uovsT6qZKX96n7aKdFoBRXXRtvuWEYUSlqv8w2tRDryBMsOg0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407494; c=relaxed/simple;
	bh=dY3ivW7oyb3B7jFVkS5ngpYankgTPC7k5Q2CbzlAn7Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ALbdYNYRm3xmisCmrh2laVeqkyo2eV3GkRwsAZZK2zprJ+2wO6gi/kuL06duY0lpWY3TZn666gJ7ej1bag6+yruYRRkgkaLl8KhXH1QIpDBDcTeViVwzk8B0txVUUioUbYDRjdPh7PYylGoQ5tQXVqeqqdY4aJgGnKwRIRHzcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPxKZofX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45694C43390;
	Thu,  8 Feb 2024 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707407493;
	bh=dY3ivW7oyb3B7jFVkS5ngpYankgTPC7k5Q2CbzlAn7Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DPxKZofXQ/J7LPUoKQjbBrGn/h0YFIE1167UfXqQEK7YYfwL96opX+2lSt04xXaDA
	 W6eMYCwHi0ZHUQxt+7pg8c7uVzzlpovziieR5qm3z4ag0ngvFhwtF4bYPspc1UYR1g
	 vbdrclxrmUkNw85mMoVJ0pwuTa5S/fwqMQ01YD8nhJ3mZv0h/9yuCW1tz/Mt87JM3e
	 /c/b6q/n8CJaGZXro1mLAJ0TNeyp1leOx93tLd7dvu/koSg0d6t23Chh8uddPs8a45
	 KdVQyre8Wa+jQPX/3sl/sBt71YJhiKnccT7newpt8O2pM5/GHkRHi+tXqeh/fjEVRP
	 IuB/Ejotwta+g==
Date: Thu, 08 Feb 2024 15:51:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: alexandre.belloni@bootlin.com, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, tglx@linutronix.de, 
 nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org, 
 robh+dt@kernel.org, claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240208092015.263210-1-dharma.b@microchip.com>
References: <20240208092015.263210-1-dharma.b@microchip.com>
Message-Id: <170740748922.3230402.17318224112819715619.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema


On Thu, 08 Feb 2024 14:50:15 +0530, Dharma Balasubiramani wrote:
> Convert the Atmel AIC binding document to DT schema format using
> json-schema.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Note: I get the following warnings on latest kernel but not in 6.7.
> Should I be worried?
> 
> usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR [FILE_OR_DIR ...]]
> yamllint: error: one of the arguments FILE_OR_DIR - is required
> 
>  .../interrupt-controller/atmel,aic.txt        | 43 ---------
>  .../interrupt-controller/atmel,aic.yaml       | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interrupt-controller/atmel,aic.example.dtb: /example-1/dma-controller@ffffec00: failed to match any schema with compatible: ['atmel,at91sam9g45-dma']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240208092015.263210-1-dharma.b@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


