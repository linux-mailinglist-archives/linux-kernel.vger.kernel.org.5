Return-Path: <linux-kernel+bounces-13159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA3F82007F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD71282834
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB8125D8;
	Fri, 29 Dec 2023 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG+bQGKy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C6125BD;
	Fri, 29 Dec 2023 16:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE461C433C7;
	Fri, 29 Dec 2023 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703866886;
	bh=ARSKX5W0g0Zwila4O/VGjKHV4IBWlDQhdUmnu1kpDFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kG+bQGKy7qgSnrhI+i8k1pU2PmuDAmSvcyZfXu9BpqeztJUNlnu0LDbAVnjh5t48Y
	 j1/TD+e6B1L8niAUkngRnpdSlVlf8b6Evme+JNjZ4K2v1uzmMdZc3z4Wjp9AeC3iIj
	 l9GJ6IzeZE6LkVKy2tiNPjWhdS1+lRqww1LQk1izBw57+uvGhD2yAmhHM7QzUCIjB7
	 +KvjrIO9a4M0eqFTknVEEmsWUiGylsxaHxDWofsalLhyW82I2FMZYT1Pj8Zhdha9VY
	 xSDXCTCu6XKhRdYPBEWbxp83Ql/M1zypcKTR/NhUKgq2g+Z2TSnmPaJdIKCyDqpbJP
	 csfer7KUGYvbQ==
Received: (nullmailer pid 110405 invoked by uid 1000);
	Fri, 29 Dec 2023 16:21:20 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, David Airlie <airlied@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-amarula@amarulasolutions.com, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231229135154.675946-6-dario.binacchi@amarulasolutions.com>
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
 <20231229135154.675946-6-dario.binacchi@amarulasolutions.com>
Message-Id: <170386688086.110201.17529837792970249585.robh@kernel.org>
Subject: Re: [PATCH 5/8] dt-bindings: nt35510: add compatible for FRIDA
 FRD400B25025-A-CTK
Date: Fri, 29 Dec 2023 09:21:20 -0700


On Fri, 29 Dec 2023 14:51:20 +0100, Dario Binacchi wrote:
> The patch adds the FRIDA FRD400B25025-A-CTK panel, which belongs to the
> Novatek NT35510-based panel family.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  .../display/panel/novatek,nt35510.yaml        | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml:21:7: [error] duplication of key "items" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/display/panel/novatek,nt35510.example.dts'
Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml:21:7: found duplicate key "items" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/panel/novatek,nt35510.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml:21:7: found duplicate key "items" with value "[]" (original value: "[]")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231229135154.675946-6-dario.binacchi@amarulasolutions.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


