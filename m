Return-Path: <linux-kernel+bounces-53022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D0849F96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AE81F2439E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08C3B19D;
	Mon,  5 Feb 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKo1+Ozy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A03CF4B;
	Mon,  5 Feb 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150933; cv=none; b=oE8TiLvFngdhC2BFGaM7QoZeCINH5y5pYIWvRvovgBGLtPfSb3BTdlQ18NQBTxSgn0N1K/KgPfpQDOI5AxnN89cSD+Kdx3zO2lLgopbWKgJB2oawMzA0na748j4z/fX4hWx+YZIwPcOPiwasW+lSTzNKdgRFGJDC5B6oe8vVdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150933; c=relaxed/simple;
	bh=ZsSX8r4xjSkosOZIBP8AGU9AupuG60/9FbaivTIPBXo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jIlPqedXSUKKlobkhgU6AFMtkZLjd+ElRWHx5/ioQgw79VlKzg6QPOMVpS2i9C7CDU72OmfSxgLDXHrs5kWOL4onG6SgYJUkq46VkoU7JAKpyISbOYWo7iFD/XT4OLrNdFL0hBODR8PJAnV00YkqWPRpTZ/eOrjawv1KXLtf9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKo1+Ozy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D549C433C7;
	Mon,  5 Feb 2024 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707150932;
	bh=ZsSX8r4xjSkosOZIBP8AGU9AupuG60/9FbaivTIPBXo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RKo1+OzyeF3eCfkPynFsfSVttvAUhg2HMIxe2WRlgPStmaJhL+Uco8hegTrgXvdKN
	 icXOgFBqcne+QuYRX/rZocVvqQJaLvLRC3uFyQKjlQrAPwxGAu8OJGJz2/OkNy/AXL
	 99FBGwS7YkeiO9crkUcoziAwjR4AEwu6VX/ao04gxsimTTfrNoVHc24tr4gFuTQOrm
	 /DFJge0Db4rtUFOIfY7UzbBnWhRz25CMxqwXJPmBjgQhk19PfnDX/6gcs5VwQEJPDS
	 vEav11qXHVLXj1i+zN/ztURuvLpXUfWsngsUL0jpa9MhgvaKbbtir8BhjxcFzZzJwp
	 XsKlllFfG7Mvw==
Date: Mon, 05 Feb 2024 16:35:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Rob Herring <robh+dt@kernel.org>, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>
In-Reply-To: <20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-Id: <170715092938.3472105.11395569623578277024.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts


On Mon, 05 Feb 2024 14:44:19 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
> supported by the IRQC block, reflect the same in DT binding doc.
> 
> - R9A07G043U              - RZ/G2UL
> - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> - R9A07G054               - RZ/V2L
> - R9A08G045               - RZ/G3S
> 
> For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into single
> interrupt so we just use the below to represent them:
> - ec7tie1-0
> - ec7tie2-0
> - ec7tiovf-0
> 
> Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
> were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
> SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
> support these interrupts. Therefore, mark the 'interrupt-names' property
> as required for all the SoCs and update the example node in the binding
> document.
> 
> Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
> Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml:143:111: [warning] line too long (114 > 110 characters) (line-length)
/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml:144:111: [warning] line too long (114 > 110 characters) (line-length)
/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml:145:111: [warning] line too long (114 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


