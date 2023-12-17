Return-Path: <linux-kernel+bounces-2430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C5815D01
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFBF1F22469
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70272A47;
	Sun, 17 Dec 2023 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvS92Ok4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D44C60;
	Sun, 17 Dec 2023 01:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F09C433C7;
	Sun, 17 Dec 2023 01:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702776173;
	bh=x82aK+1Jdjbd8v4bEai4Qz9MoFSVQ3P7VWc3+Wr/b48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MvS92Ok4nGTYn323Wjj1TkzHiSXxTtSLsLp3mTTkE/P5gp6fAE8y0fkCaOuEQ8bLK
	 nZY84vVkC9JLeT1yKDu89Lo4jh2d2vrV85wPqQoPVzOovOPVQW9fAAwe7RSsSxGpQF
	 MQKktDK1WpmVKjhWC3OFGftY82IejMnoggHpShp4kRZSEvbs3FeXK2lFsPbz6AvEWf
	 8MDpG7t/H3sDrqhqJPPeQ5rSwdHEJdyyOUerk6o9cM0cISGIVET3QOMzF7HwtdfR2+
	 yDubgTq2ykQWlQuA09hqpEBcGEECtXg8oGrP1RliAJPXgRJju1oJq92XdoydP6P2gM
	 FsFzyqAKWX4lQ==
Received: (nullmailer pid 3635219 invoked by uid 1000);
	Sun, 17 Dec 2023 01:22:50 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <a9c12b8cc183b103af421a4a350ae6ef1ec173c8.1702770711.git.daniel@makrotopia.org>
References: <cover.1702770711.git.daniel@makrotopia.org>
 <a9c12b8cc183b103af421a4a350ae6ef1ec173c8.1702770711.git.daniel@makrotopia.org>
Message-Id: <170277617017.3635158.15840964425194306798.robh@kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: mtd: add basic bindings for UBI
Date: Sat, 16 Dec 2023 19:22:50 -0600


On Sun, 17 Dec 2023 00:09:30 +0000, Daniel Golle wrote:
> Add basic bindings for UBI devices and volumes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mtd/partitions/linux,ubi.yaml    | 65 +++++++++++++++++++
>  .../bindings/mtd/partitions/ubi-volume.yaml   | 35 ++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:18:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:23:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:29:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:32:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/a9c12b8cc183b103af421a4a350ae6ef1ec173c8.1702770711.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


