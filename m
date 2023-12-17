Return-Path: <linux-kernel+bounces-2627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26393815FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB06E1F225C7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B844C95;
	Sun, 17 Dec 2023 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diz4mBbC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDB44C7F;
	Sun, 17 Dec 2023 14:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2300C433D9;
	Sun, 17 Dec 2023 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702823087;
	bh=a6KCBlRCq77OBBZrD6RVrWWZcrS/mslm0GyS8oEwpgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=diz4mBbCkP2tZr/hEvAQp07lg+0CPNS5O+rmuMf5OouNEbD6yA5UetsFEvAp+LmVV
	 hITL4YUH179nMRsdlDOUJPLwflLin7ewrrFc7hqNJS296lfTa/EL6RtyXcm9mHGPYi
	 ZjjJUlza99jeavqnqv7POvf4vC2kj/Wah1ObO8gfb+/aGU3xnQSG4Nr2RQfgiNypov
	 dGyly3cJeaTH5ApGBVNKteC0rxsqz+FUHzg2m+wv2KkTUwAtLmr1OsHCr+Xij9kLCI
	 eNBnU7X9Nl9oFRuRKzdbKFaBAN0WX17Elt+B/OYn4vHyMeuNXYFEScA/BgUsAUS4BF
	 Wwo6WWKBWVhig==
Received: (nullmailer pid 876441 invoked by uid 1000);
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
Cc: Conor Dooley <conor+dt@kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, ~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>
In-Reply-To: <20231217131838.7569-4-karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-4-karelb@gimli.ms.mff.cuni.cz>
Message-Id: <170282308207.876381.2939454348396043606.robh@kernel.org>
Subject: Re: [RFC PATCH 3/5] dt-bindings: input: add entry for
 88pm88x-onkey
Date: Sun, 17 Dec 2023 08:24:42 -0600


On Sun, 17 Dec 2023 14:17:01 +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM88X PMICs provide onkey functionality. Document it.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../bindings/input/marvell,88pm88x-onkey.yaml | 30 +++++++++++++++++++
>  .../bindings/mfd/marvell,88pm88x.yaml         |  4 +++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231217131838.7569-4-karelb@gimli.ms.mff.cuni.cz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


