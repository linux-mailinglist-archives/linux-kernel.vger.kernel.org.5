Return-Path: <linux-kernel+bounces-57173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0584D4BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C529B1F223C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49515CD66;
	Wed,  7 Feb 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJlCtETy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BF15CB8E;
	Wed,  7 Feb 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341156; cv=none; b=KCYmrsFLIvA3BkikUSwsd0X/gElTmWBixscVg9ADmnN8zd9IbCXs0dtUE8FiHbSn4zXgkOaNpDEiPlcEnbboYyxEl1w77BQwR0U7BbMwpuAXgndVWOwcWUSRMBtshpl4Qcivoo08Ty5qnpWCQifSx9UHvCQypKFSOrpNYUe4hHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341156; c=relaxed/simple;
	bh=o8H4o09pkLeXy0frODGluKudoPi9PzNvii1yKYW0Lj0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=p+g+EA7jiO2bhIAtplg8e2ft8fwifKa0s6rP9AYMyUqPzNWLhHAIsDO3rlZ8Ib1GUUJ/rMJ8hsiQP3q/WauQijA8h6IP4bfsrCWUo6rf7ySLpj0/fXnSGptrC3O1RI2TOzxEg1rot5IU8oDgiYnMKiO+OlDjCxylX5c8CvszE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJlCtETy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779B8C433A6;
	Wed,  7 Feb 2024 21:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341156;
	bh=o8H4o09pkLeXy0frODGluKudoPi9PzNvii1yKYW0Lj0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WJlCtETyglI9CUyxAiNpStKaFOkznG4fLAhkcnYvWPyUx+NxNcee6IJe7iomn2NvO
	 9iOGfbTdAqrj+eGjS0mhBhkmW1h96EqDclNYMHjQT67YbHIaXUOs9HDPEsjpxmxmdx
	 hDkjNALZIPL7j1Ko4fCH3pGL8Yk/rqRECsQd72uxQBWNpgBTCWE0uwYROCvz6QKzxe
	 J7JEC4TzxR/12ND3tr4VOo8XJ/XJe1FgZ5rZxiwZhXO0zxgAaIUeFWN6saFIMgV217
	 dbag2poBlAKhjuMPEzqK9Nivc4AHks2ZlTsll3eyMmrz021A3wFKgJaqgprYBDJz90
	 l1IqlucNJ1Hyw==
Date: Wed, 07 Feb 2024 21:25:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-iio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
In-Reply-To: <20240207074758.4138724-3-dima.fedrau@gmail.com>
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
 <20240207074758.4138724-3-dima.fedrau@gmail.com>
Message-Id: <170734115194.3199410.700483085044705042.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: humidity: hdc3020: add
 interrupt bindings in example


On Wed, 07 Feb 2024 08:47:52 +0100, Dimitri Fedrau wrote:
> Add interrupt bindings in example.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.example.dts:33.34-35 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240207074758.4138724-3-dima.fedrau@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


