Return-Path: <linux-kernel+bounces-35873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9F8397D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41C7B2450C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54782D69;
	Tue, 23 Jan 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGDOh7Y7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61D7FBB4;
	Tue, 23 Jan 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035053; cv=none; b=OxXMQ/oEcGX8vvHaDPUSZ+iOzV6CL0BpkBK1K8+CapUmqRnHaNcXVUdNS7MW/gPpO9sDUNCdsarcgWYg9shiZyPJBwyGgv3iq52Qvk/9sZgC4NYmtGVyQNdQ26CLydfzM1AerND0oU5MzwmAnTr5eI1rg/khGOSrTWoEa1Cicq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035053; c=relaxed/simple;
	bh=43X4Ckx7mjbikvmv9Y1ubNYOub49RqEzKd4SNTW3MJQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lmnj/iNeLCCX2gYYPxHrazGAcdMcpN5ZKG+d51cDrtWHLRNyipq7ls92gmveT2IiHoYISL/Br/UnR5eVBkPvWn/FUnzSB7Xip9WMpD32wkrpk1VgJSNb7eJN3KBCIIKXS6X3mnDlR36ewK+M50oXH8m5GPeAbCMkQKAP74Byg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGDOh7Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7861C433C7;
	Tue, 23 Jan 2024 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035053;
	bh=43X4Ckx7mjbikvmv9Y1ubNYOub49RqEzKd4SNTW3MJQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vGDOh7Y764Fs/5GJoP32TnLS+PIAT/zHtQ2otJ4NkEqYbVvS3IabOIMFwn14UnlDu
	 UfrBvTs0c6M80SPMmTR59aUBocMxdz8IxbdwRBPWjc2rR/sLWYpFxglaSps9BwDA30
	 NUvatVAIJLAgNbAVObNJJ8ZQx2M8lxeiF0m5tvVLTt/hFaB8RlWn7a2tCPl14cg3jD
	 0wf56rM8JLx2ye/zD7IpmFI0ZXiNJ3uqY4AWJiCoG2KJDEBikN9MTJrzA6u6mqoI0I
	 iRCaH5rysgXgJCU9np1MrS+5cHtXfRyrkSzvzPIjhzx4YGKcja+RULE3q/AuzGPIFs
	 8pNRhBs1M7dvA==
Date: Tue, 23 Jan 2024 12:37:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com, khilman@baylibre.com, 
 davem@davemloft.net, linux-crypto@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@salutedevices.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, 
 herbert@gondor.apana.org.au, jbrunet@baylibre.com, 
 martin.blumenstingl@googlemail.com, krzysztof.kozlowski+dt@linaro.org, 
 robh+dt@kernel.org
In-Reply-To: <20240123165831.970023-17-avromanov@salutedevices.com>
References: <20240123165831.970023-1-avromanov@salutedevices.com>
 <20240123165831.970023-17-avromanov@salutedevices.com>
Message-Id: <170603505021.1430814.1860868774735102384.robh@kernel.org>
Subject: Re: [PATCH v2 16/20] dt-bindings: crypto: meson: add new
 compatibles


On Tue, 23 Jan 2024 19:58:27 +0300, Alexey Romanov wrote:
> Now we can use crypto driver at G12A/G12B/S4/A1/SM1/AXG.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../bindings/crypto/amlogic,gxl-crypto.yaml   | 31 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.example.dtb: crypto-engine@c883e000: compatible: 'oneOf' conditional failed, one must be fixed:
	['amlogic,gxl-crypto'] is too short
	'amlogic,gxl-crypto' is not one of ['amlogic,g12a-crypto', 'amlogic,s4-crypto', 'amlogic,a1-crypto']
	from schema $id: http://devicetree.org/schemas/crypto/amlogic,gxl-crypto.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240123165831.970023-17-avromanov@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


