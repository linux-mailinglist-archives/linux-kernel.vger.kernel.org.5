Return-Path: <linux-kernel+bounces-11654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06DC81E973
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A7283392
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2002103;
	Tue, 26 Dec 2023 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXLYEEMc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255401847;
	Tue, 26 Dec 2023 19:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE982C433C7;
	Tue, 26 Dec 2023 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703619605;
	bh=7eOCwMWMp60Sk5Eub3yMixQjr7ZQQLze9px5lV0JgFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UXLYEEMcv97Ac6XHYg1XpK+t5gPhNKQ+XH2LT3KegrrXu0SN8utYxnjqIxihPSfLm
	 RhqUjFPNq/kC9s63o9JjBi84mHmlFkZJVGSztGmM0Dpsiz56/Wa1BXiHqla8nBq/xg
	 wqeIolUuageDp1kof2BPHmcPJbkPNDjjcsw8mgNhJtslQtYC62nyivHKegHmW2b6B5
	 KG1F09iJJ5M1Q6iNHNVvZUYQJnpmn9ZGGpxe8+qJai66bwcBK9hGMoVupwnk3QWkCZ
	 YKkUYsSvwCJXBnqNqCqN5cj45uxdA7wKe9LdKTpuYbI9xaUxg6abX/RpeKIBXumszG
	 FvdVuXbAWgiYg==
Received: (nullmailer pid 2887135 invoked by uid 1000);
	Tue, 26 Dec 2023 19:40:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Gregory Clement <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-2-fd1ac2d6bf2e@solid-run.com>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
 <20231226-support-clearfog-gtr-l8-sfp-v3-2-fd1ac2d6bf2e@solid-run.com>
Message-Id: <170361960294.2887071.7965045689667974977.robh@kernel.org>
Subject: Re: [PATCH v3 2/8] dt-bindings: marvell: a38x: add solidrun armada
 385 clearfog gtr boards
Date: Tue, 26 Dec 2023 13:40:03 -0600


On Tue, 26 Dec 2023 19:11:33 +0100, Josua Mayer wrote:
> Add DT compatible for SolidRun Armada-385 based Clearfog GTR L8 and S4
> boards.
> 
> Despite similar name these two boards are designed differently from the
> armada 388 clearfog base and pro, they only share a name and general use
> case.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml:36:14: [warning] wrong indentation: expected 14 but found 13 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231226-support-clearfog-gtr-l8-sfp-v3-2-fd1ac2d6bf2e@solid-run.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


