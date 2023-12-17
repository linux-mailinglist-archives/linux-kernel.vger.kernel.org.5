Return-Path: <linux-kernel+bounces-2626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C24815FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F004128260C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ADD44C6F;
	Sun, 17 Dec 2023 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+4WDL0m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320A32C6C;
	Sun, 17 Dec 2023 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB586C433C8;
	Sun, 17 Dec 2023 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702823084;
	bh=Z8/lwRis5tILr7LjpCd1oDkaNzTjP6igSnrvdygyoN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X+4WDL0mVWY5IuWWuvqbHt3WQlVMEx8pkRX5YKOqwpdbH9Yps8t14V/O+PSGwSNBW
	 v7jQS6eTONrPZZ602wTjegg2II1WxiOzUD7ItOhVw2W1hTZn1pXPw6HYZa1bbHeLZZ
	 5+gEUr94KBW1u/mwA27SRxmjivXgES9OE/5gHnjc7s0imKj4Vpo/yDxepnv4R0Jaj3
	 ev0sek7uVtGQubfMtIO7hYmVudZhxOrmHPzEkVpJB/4zyUyvILCRd7g/+pfL8Oc/7Q
	 lqmh0/zGALfn9tCCZ+fQQpTxJp2Hc+m6gjxQtDSSSqCHeUpGP7A1TFd8WfUKCp2EiJ
	 vYlXNYgCZwwWw==
Received: (nullmailer pid 876438 invoked by uid 1000);
	Sun, 17 Dec 2023 14:24:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: linux-input@vger.kernel.org, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <20231217131838.7569-2-karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-2-karelb@gimli.ms.mff.cuni.cz>
Message-Id: <170282308150.876352.2264944400902507705.robh@kernel.org>
Subject: Re: [RFC PATCH 1/5] dt-bindings: mfd: add entry for the Marvell
 88PM88X PMICs
Date: Sun, 17 Dec 2023 08:24:42 -0600


On Sun, 17 Dec 2023 14:16:59 +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM880 and 88PM886 are two similar PMICs with mostly matching
> register mapping and subdevices such as onkey, regulators or battery and
> charger. Both seem to come in two revisions which seem to be handled
> slightly differently in some subdevice drivers.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../bindings/mfd/marvell,88pm88x.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mfd/marvell,88pm88x.example.dts:30.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/mfd/marvell,88pm88x.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231217131838.7569-2-karelb@gimli.ms.mff.cuni.cz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


