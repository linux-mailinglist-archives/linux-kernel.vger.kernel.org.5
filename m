Return-Path: <linux-kernel+bounces-39557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E993F83D2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2894C1C23AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22C4AD5C;
	Fri, 26 Jan 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZzlezDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043628F77;
	Fri, 26 Jan 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238136; cv=none; b=rbTqdNbDboKykWGpK/I9vcgPZyXqMdx28w4uOzL4BmcRjdXrT8+AhQA6wn2AY2hqLa/Y7wz5tzaNoA7SuQZOyWpwTMKO5vlYqqrW94Ypl8b8OXBxc7hn9OYjagleTSKNMbq4k7HOxZ1JFY9C6hibBtfkf5yImmyra+n4Pc1IykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238136; c=relaxed/simple;
	bh=GJ7CkH9DB4f6yRUN3yKrBTO9cZaC2If9JB2hPEvgamI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oEZJ+rh1rs2vT0d0W5zJj9SsN5oOuB0C0c8z0mupnhXynfe+UEh2KBdGhfyTBs5l3IK97l1ghHDVEby/sNwnAD7p3P1FmcacvAEivt235cuwDHx+RrwyZ3LzWskEBMIYr71O8SNKrAh/TF3Hh6QmdYAXTLspjWwunRiv9JI5WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZzlezDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18393C433F1;
	Fri, 26 Jan 2024 03:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706238135;
	bh=GJ7CkH9DB4f6yRUN3yKrBTO9cZaC2If9JB2hPEvgamI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nZzlezDaaMQOd65G0n3/0b1XsyY/gxUNwjTF53/nLwWnRaTLL9X01V8bs/FmW8T8s
	 3iO915tzSuO8FAkhWUfLHfrb13vEX+ILVW7LpvZLAk6HTLe7W5O50H+sBqvjwuUpBH
	 8EbKqO/Tw3/5/MCZuW1SoxmamgCfCspm5vmkJxusAhMELsQt2UlQ3hZBj6IP1E1Qq0
	 Wtbxg/d0CxGdzy4ypCiPWHf/pPESyjms6/5kkWaYoWy3lLOx7dOwgv2RFmCsK7G6we
	 W9A4LMOdXRGwDF4uayDaSl7pW0SvVbpfc7CylnoaxOHGLLtFZYGNhdNdZy+y5tepEm
	 NGvgSUQqXgJLg==
Date: Thu, 25 Jan 2024 21:02:13 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Sean Wang <sean.wang@mediatek.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-bluetooth@vger.kernel.org
In-Reply-To: <20240125095240.2308340-2-wenst@chromium.org>
References: <20240125095240.2308340-1-wenst@chromium.org>
 <20240125095240.2308340-2-wenst@chromium.org>
Message-Id: <170623813065.6681.12186645553031730572.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth


On Thu, 25 Jan 2024 17:52:37 +0800, Chen-Yu Tsai wrote:
> The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> SDIO. While the Bluetooth function is fully discoverable, the chip
> has a pin that can reset just the Bluetooth side, as opposed to the
> full chip. This needs to be described in the device tree.
> 
> Add a device tree binding for MT7921S Bluetooth over SDIO specifically
> ot document the reset line.
> 
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.example.dts:25.39-40 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240125095240.2308340-2-wenst@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


