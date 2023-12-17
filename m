Return-Path: <linux-kernel+bounces-2431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF03815D04
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0871F22508
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848717F8;
	Sun, 17 Dec 2023 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaBty1lR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FBB1374;
	Sun, 17 Dec 2023 01:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B2BC433CA;
	Sun, 17 Dec 2023 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702776175;
	bh=FpOC4bwyd89s4G39nq7CQqxq/3M8hUupFE+Z+PJBTfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LaBty1lRMQV2vNS915TYttaXZ2DeWEKZebRhiP1V6eNzJrgGlHT5kEVwVcEpvY5hG
	 hIkbV2EoKQTNb5GmEPV5vsP96c1QSOqxzZ/XH9sDkMfot4ksOBOD8QDpHemn/S6E9B
	 1P/aibZcFeT5wsj2+RoAKpNzo1ECl0o86E5AqSmnIoBXf7ccTh51ePLkOoBmVlr9v3
	 UAfF0+27xR1kJiMkk6ukOqz23FL5/CWz8aynWR/qqRDqgcYZKRjbAH7ll+r21pAOTW
	 Ch/OCeoR/AkNjQQVEBm0uubz6A4m6PZKQOIe0ELTS/VbIQ51ajlP907TiWSZ8VD0O5
	 MI/YCJlGgOwxg==
Received: (nullmailer pid 3635222 invoked by uid 1000);
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
Cc: Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <de0bd3647ed2560074aa3528716c203b8939fe1d.1702770711.git.daniel@makrotopia.org>
References: <cover.1702770711.git.daniel@makrotopia.org>
 <de0bd3647ed2560074aa3528716c203b8939fe1d.1702770711.git.daniel@makrotopia.org>
Message-Id: <170277617078.3635202.15310156602338483620.robh@kernel.org>
Subject: Re: [PATCH v5 2/7] dt-bindings: mtd: ubi-volume: allow UBI volumes
 to provide NVMEM
Date: Sat, 16 Dec 2023 19:22:50 -0600


On Sun, 17 Dec 2023 00:09:41 +0000, Daniel Golle wrote:
> UBI volumes may be used to contain NVMEM bits, typically device MAC
> addresses or wireless radio calibration data.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/partitions/linux,ubi.yaml  | 10 ++++++++++
>  .../devicetree/bindings/mtd/partitions/ubi-volume.yaml |  5 +++++
>  2 files changed, 15 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:34:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:37:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/de0bd3647ed2560074aa3528716c203b8939fe1d.1702770711.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


