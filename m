Return-Path: <linux-kernel+bounces-129686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C077896E66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4CB1C26CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973014386F;
	Wed,  3 Apr 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG3oDw8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B616134CCA;
	Wed,  3 Apr 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144595; cv=none; b=dfdF6r4VYQHfIW6hhdlSAxagmbkDnMzlp9c4G00C8MdFmDg4JP0rG6m7rg18u083r0Ej2vE6HgS7IUD2p/2tZL0vV1nkZCUrdUSY5ed2vuvG2e5Jxi5i6g6prdAlNJS38bxPebMAQy5ffKF3BcNALCne+A/l+kklNmaaVK1dEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144595; c=relaxed/simple;
	bh=uUHgwO0eFmALyzsBaJSjObTbbmjZmMw7iBv8Z6hkKtw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=moTL9iqIKCGFFHbHTC5Z1dcKkO8FpVN7xskwQim8hyIjJA6bbYHxlnr0nQAzVClkEoCCpXUE4goFR0Pb45FcfVyEjR85lvfSJzjKO7jEfeUYa/L8Z6fNpSOCszVwI9DTzz5KYRtn1OyA90zczGl5jof6+qe7p6gbo6wvj1i+/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG3oDw8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FFDC433C7;
	Wed,  3 Apr 2024 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144594;
	bh=uUHgwO0eFmALyzsBaJSjObTbbmjZmMw7iBv8Z6hkKtw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RG3oDw8ySAE5dM+cSAA0ris3Tj6dPYKvg0w1ScmsbSKyBWAgkCtvHku6Vy/0Z2ar4
	 T2DN8ENe9NPXgT9aTfgI/ounBnDrAoxtq74TPAidMEpr8SGE82Rbq8rN9z4vQ3wSG9
	 XoRvD52h1tcP8d7avJdAoN8VSE+HAQ1YEsj/ezXNaUyrH05GC3J/MHuAoK/Ny/kH8S
	 EvZfwycYEnVR7CKQcB8X6iKz4QMTzbpfhZqh9G2cX1D4rwLNkt7mGXJFyWUqP37Q6B
	 RheIaI8B8lLi1REp9a/tGk/f7LCr4WYk3BE7vFcXYzGufqdEjYtRTuN9deslSeCWOk
	 LaGzHKDF4woPA==
Date: Wed, 03 Apr 2024 06:43:13 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Shawn Sung <shawn.sung@mediatek.com>
Cc: CK Hu <ck.hu@mediatek.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 "Jason-JH . Lin" <jason-jh.lin@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Houlong Wei <houlong.wei@mediatek.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20240403102602.32155-3-shawn.sung@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
 <20240403102602.32155-3-shawn.sung@mediatek.com>
Message-Id: <171214459243.3102045.9648792488984765455.robh@kernel.org>
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver


On Wed, 03 Apr 2024 18:25:54 +0800, Shawn Sung wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Add mboxes to define a GCE loopping thread as a secure irq handler.
> This property is only required if CMDQ secure driver is supported.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../bindings/mailbox/mediatek,gce-mailbox.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml:
Unresolvable JSON pointer: 'definitions/uint32-arrayi'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240403102602.32155-3-shawn.sung@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


