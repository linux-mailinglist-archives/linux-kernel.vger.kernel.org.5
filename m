Return-Path: <linux-kernel+bounces-143920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C58A3F93
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2590628165D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CAE59157;
	Sat, 13 Apr 2024 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXJgLXIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B258AB9;
	Sat, 13 Apr 2024 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713050524; cv=none; b=uf4rPKSewPZpGDQmTKxYwxVq7QJp0VSYYErP4DjrMB5VLZFloodSupq/mESXLtgFUkEEmykMfjGeTxFS5DVsM5y0ETKyqqpPTXtSQ4xARSGMWhr6nP5tYAtV4AQD3qLu6SVi6GzJ04XTaToFd+t5qf7RsdhR45i3OOmjFnjAmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713050524; c=relaxed/simple;
	bh=dYwE/utphvFiXMvi6lhwuVBR/u7nokSBYRdoiGMWjzs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nhNw1jwAaeSEDR6D7+RO/kVDl5FItL4A8H40wD//lyge9e9dv6ITUWF574brWNjPSomQwXdkkx+/YGYxB37r7l5bX/eqjK8eFMBHBnNq8jImu3m2C0bukN3to3sR39bkh2sEoIBTGH4R/+m4XqUefWvoZYQXUutZa5vAa5ee4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXJgLXIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF86C113CD;
	Sat, 13 Apr 2024 23:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713050524;
	bh=dYwE/utphvFiXMvi6lhwuVBR/u7nokSBYRdoiGMWjzs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HXJgLXIULVL77T5/GL6EDP6uVplkDrhQw+hr4msoOi7dD5UkaRABK/aZshBcvT8yn
	 YmCHObfoorUX97gQJwXRLktANXDAGGwuRSI9KBQXrHpBh9Jz45g4KxWX5Df7nQseja
	 L554971aCzRhDdm9kE9n6HCZMeNmQdpc4A2pJ0XbDUWzOYvV2l/sJEN+ihh45+rJAW
	 N2d5Lm53iYaZo7Vy0LaJmnDcNeR20WW2H5xqN2p4JWV36ZNNT7A8lQeaghbCqWySZ7
	 QoyLn6BIF4MDEMqXEwVRO2vAaCQU4cSs94Qe9VkRZG/UGy4d2g7nWXV4Yu2kKm7m3X
	 TXdwo/T03EnOg==
Date: Sat, 13 Apr 2024 18:22:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Al Cooper <alcooperx@gmail.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Jonathan Bell <jonathan@raspberrypi.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <ad96fff723675c2d65a5e3328da9b09f2781cbcd.1713036964.git.andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <ad96fff723675c2d65a5e3328da9b09f2781cbcd.1713036964.git.andrea.porta@suse.com>
Message-Id: <171305051934.2374020.7888405372204781496.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: mmc: Add support for BCM2712 SD host
 controller


On Sun, 14 Apr 2024 00:14:24 +0200, Andrea della Porta wrote:
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 51 ++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:91:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:91:17: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ad96fff723675c2d65a5e3328da9b09f2781cbcd.1713036964.git.andrea.porta@suse.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


