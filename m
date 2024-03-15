Return-Path: <linux-kernel+bounces-104967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E587D6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D30A1F23943
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1756B65;
	Fri, 15 Mar 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhVlUuzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552A1774E;
	Fri, 15 Mar 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542375; cv=none; b=NctccMrJUYR6qZ5roSxZRRF2uWJQfAWEuWEHBIDyew1Q+7mlvcQkwHp04gKOd12rsiYAeJDFnm9nCZUnFVJFbMWbTCIPPC49xQjBEugqmpjmETVr7nXzvLEKoqUVTJvVeOBaSKAJsM8dbL3dJDDNiPdOhuIGb7gC6gTbhIhY76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542375; c=relaxed/simple;
	bh=7AGoxyZRNwhWGRoTX0vozA4l+C5nDgnZKf/FebfvTaM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sZClRztBrycg7Wn3Eqi3tgA1bMwtyMTaPxuyds4e+sH7bcltFJaDe7SYGC/t+xQlNwLqz1kArUw1ADqIHsqjh3djM3NU9aUXgx3D1aAj7WdN8m3lEOt7G7r8FaLp8xqTEDcZeT/b74q2lQY2P0cKGJgSFzWCdB3NKO08iLm8BOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhVlUuzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28387C433F1;
	Fri, 15 Mar 2024 22:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710542375;
	bh=7AGoxyZRNwhWGRoTX0vozA4l+C5nDgnZKf/FebfvTaM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EhVlUuzJAcqLU0r1H2j4kr9URd7T6xVe8pbRCDtZAKanIlZ0r2DagcWdPI5uqeoqg
	 9cQYNI8hjHYRZyK0m5KrCHu8hR0Lwra7Sclv3UC7lMbG7Xuw31s00jilt07Fm2xoA3
	 BWkr09TCiS+x625sOJKABC6q+IUrp84D/AqlK8vf5GEXR0fMUv8rbebvThQQunjOpZ
	 3bFr96dJ6ZksmJ33F0oJkVZp7aDUTJsiagVdIe6q+GmIr6pyUTvPPYp6WKu5IoJ0bR
	 OH2ksIE5X8P9EBF78g4XZi8CLONMncZW2hMQljMhhix1aPqsT/if2h8GlWFUa5xUzQ
	 AoJBZ5qknUmTg==
Date: Fri, 15 Mar 2024 16:39:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Michael Walle <mwalle@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240315204521.28613-1-sjg@chromium.org>
References: <20240315204521.28613-1-sjg@chromium.org>
Message-Id: <171054237303.2017019.6117263925348911387.robh@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: mtd: fixed-partitions: Add
 alignment properties


On Sat, 16 Mar 2024 09:45:20 +1300, Simon Glass wrote:
> Add three properties for controlling alignment of partitions, aka
> 'entries' in fixed-partition.
> 
> For now there is no explicit mention of hierarchy, so a 'section' is
> just the 'fixed-partitions' node.
> 
> These new properties are inputs to the Binman packaging process, but are
> also needed if the firmware is repacked, to ensure that alignment
> constraints are not violated. Therefore they are provided as part of
> the schema.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v7)
> 
> Changes in v7:
> - Drop patch 'Add binman compatible'
> - Put the alignment properties into the fixed-partition binding
> 
> Changes in v6:
> - Correct schema-validation errors missed due to older dt-schema
>   (enum fix and reg addition)
> 
> Changes in v5:
> - Add value ranges
> - Consistently mention alignment must be power-of-2
> - Mention that alignment refers to bytes
> 
> Changes in v2:
> - Fix 'a' typo in commit message
> 
>  .../bindings/mtd/partitions/partition.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/partitions/partition.example.dtb: /example-0/partitions/partition@100000: failed to match any schema with compatible: ['u-boot']
Documentation/devicetree/bindings/mtd/partitions/partition.example.dtb: /example-0/partitions/partition@200000: failed to match any schema with compatible: ['tfa-bl31']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240315204521.28613-1-sjg@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


