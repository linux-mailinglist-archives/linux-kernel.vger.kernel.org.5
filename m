Return-Path: <linux-kernel+bounces-104986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169687D74C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F361F22606
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58935A4D8;
	Fri, 15 Mar 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVbH5fRe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08359B7C;
	Fri, 15 Mar 2024 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544791; cv=none; b=avMcd0IL2N2KPWV750XaP6YkkJiwg1cB6ffw4zFcVduRRJSn/Lx45JInbJ1ccMejh7i+xgw733oFLxQR2O/T6o9V3a34gm5rJnFKw/MWPOB2Obe5EUbf01A4zfPnsVbLjeH96bgn4BUwWlnrJBRDwlmchZ30g/q8F3ZkUIjHcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544791; c=relaxed/simple;
	bh=jBWgkYqvqhVvrT8m7OLF+JmN106sgWSvhxbbqyPfUDI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=e7ejf0F+DM36TGyUbuwCharOWMLtGXVJLCZF8tXcQQr28vp3tjtPw3SovVPrXF/t6t4MfrIZ+law2DT7Jdxqyys7AC08xXGCgYsAcBtBX7kzV2o5KpWrGJkx/VWeRCZZB45ZHhPJahqlSdwm0CUW+b6DuVE/eTr7j0K8j85gLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVbH5fRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D366C433F1;
	Fri, 15 Mar 2024 23:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710544790;
	bh=jBWgkYqvqhVvrT8m7OLF+JmN106sgWSvhxbbqyPfUDI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CVbH5fRerXnTKiVloaqImqoEZu0gtZV5dhBTBtdVFe7IITRZnp3YH3Nm265Meyl6b
	 Hq0gD6iGzKSezqxwEXCyokTEUjRxFzFba/ooq9hRIgIfvWtTa/8Zspfoubyu/6+lIr
	 DdZZIyf0o271jpS8VO8TjXCnzIawIzZJaUPgUm0F7VlCw8hFS76TuE8OINHwPXneZf
	 rQ79E8HCSodoBeIF8tKehqrVyX2uFbR7Y40g2I988ZMJgw9Wg1840a8Ebj1H142ZbW
	 2l2mwlCE9t4WbaxJ8YOQ9xhlQmE9IGl0GLYWVHCFQJQ958tdnrTE4gTSQ4jTb0FYvM
	 QJ9OwANVCIeng==
Date: Fri, 15 Mar 2024 17:19:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Eric Dumazet <edumazet@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Shenwei Wang <shenwei.wang@nxp.com>, Matthias Brugger <mbrugger@suse.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, 
 Johannes Zink <j.zink@pengutronix.de>, linux-clk@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Andrew Halaney <ahalaney@redhat.com>, Jose Abreu <joabreu@synopsys.com>, 
 Swee Leong Ching <leong.ching.swee@intel.com>, 
 Chester Lin <chester62515@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Paolo Abeni <pabeni@redhat.com>, NXP S32 Linux Team <s32@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20240315222754.22366-4-wafgo01@gmail.com>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-4-wafgo01@gmail.com>
Message-Id: <171054478795.2084826.7994527965167081853.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: net: add schema for NXP S32 dwmac
 glue driver


On Fri, 15 Mar 2024 23:27:49 +0100, Wadim Mueller wrote:
> Add DT binding schema documentation for the NXP S32 dwmac glue driver. This documentation is based on the patchset originally provided by Chester Lin [1]. This commit is a re-send of [2] and [3].
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20221031101052.14956-6-clin@suse.com/#25068228
> [2] https://lore.kernel.org/lkml/20221031101052.14956-1-clin@suse.com/T/#me96c28bd0536de276dee941469ea084d51b42244
> [3] https://lore.kernel.org/lkml/20221031101052.14956-1-clin@suse.com/T/#m887a1b34e612f8dc0d5b718e4d6834c083f1e245
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  .../bindings/net/nxp,s32-dwmac.yaml           | 130 ++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
>  2 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml:5:10: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240315222754.22366-4-wafgo01@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


