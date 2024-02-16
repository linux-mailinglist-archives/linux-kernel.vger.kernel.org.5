Return-Path: <linux-kernel+bounces-68572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A1857C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035161C2432E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F280059;
	Fri, 16 Feb 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erDse+vF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B918003D;
	Fri, 16 Feb 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086661; cv=none; b=WIwEtGUpvENRYIXjp74ACltMBbpZ9G6tPFp9SJalwOXQMPGoTJufNMVSNgjMkHBbLb6hEZ7ZAYZRuwZP8JleR8M4RcHFsQ1RCUSlNjwegTOPy0mzRqKscIv/KgYwPkbTwe2W7CQ3ndRDmfTjdSB+FlTp/CVzZVhlZPHvD/2NZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086661; c=relaxed/simple;
	bh=88DxhLbMcCH4vgAsEIaB8KqnemjBPFZ5zz0ub/QPlws=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=l1YY/GnGoCt03x/CsImD7BO56E1i9b6Q8b8f6HtRBbRkE4lwYXGZlvF332BMUWlbYpoUmGpofeGpOBCLfwMBc9JcrBcfYQLIVTGxNn+OPUyIjviCuSIVIykwLnfyJN+6lkydoODilqMT5VBH/TD89fqSqB/eV8uOYfFjJ/de+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erDse+vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E8BC433C7;
	Fri, 16 Feb 2024 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086661;
	bh=88DxhLbMcCH4vgAsEIaB8KqnemjBPFZ5zz0ub/QPlws=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=erDse+vFiPDundjlx427/1jpZicDSQzZE8xABBaE1b30o5GcaxlGCYJlFHZvvm90W
	 LrfSvE/e5YCRLLMObDgPt4uzRU04JbiR2f99JfkpGrUSWbRQ2/7cSaSU0sLeFVu887
	 oQya+dlYXpMllfnF5NrbpD1a+SkOl9seiIfba6rAZmBIr3ELJXti/TqbhdRRW5TCa1
	 T6W3KHlPduzyz1WKGlr2m6iHHw0qY95CVOXG+t6z6mnEUYtbNk1PKFXxNZrxMJsg+N
	 v/zLCna12zEBwAsMoPMOSaqPNAPUTeiYISLxoOPt5qzsVqx5vPeYOZQm8+NwIn6RsS
	 E/8v+zRX+eanA==
Date: Fri, 16 Feb 2024 06:30:59 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
 David Yang <mmyangfl@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v2-3-010d63e6a1d5@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v2-3-010d63e6a1d5@outlook.com>
Message-Id: <170808665743.2530210.6606449482846682736.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: dw-mshc-hi3798cv200: convert
 to YAML


On Fri, 16 Feb 2024 18:38:01 +0800, Yang Xiwen wrote:
> convert the legacy txt binding to modern YAML and rename to
> hisilicon,hi3798cv200-dw-mshc.yaml. No semantic change.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ------------
>  .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         | 73 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 40 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml: properties:clock-names:items: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'ciu'}, {'const': 'biu'}, {'const': 'ciu-sample', 'description': 'card output sampling phase clock'}, {'const': 'ciu-drive', 'description': 'card input driving phase clock'}] is not of type 'object'
	Additional properties are not allowed ('description' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-b4-mmc-hi3798mv200-v2-3-010d63e6a1d5@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


