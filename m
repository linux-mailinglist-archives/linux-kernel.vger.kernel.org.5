Return-Path: <linux-kernel+bounces-139262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2628A00A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9553B28A557
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F8181CE4;
	Wed, 10 Apr 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUN9iV7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C04181B86;
	Wed, 10 Apr 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777555; cv=none; b=ODU1o0RW9qEFaWeEDc59bgXgivnKjUgwdXCysRb6N0vhwxA4EziEnvPWrBRV/sDroxf9RY9sSMTA0SmzNZx4GIScuvKhIG8U522wSIDxYfFJ9Q1L68nm0V5d1Gj4pWUgL57OG0Tzd7+8I0r5d3nRHjJUMW98INgiSIqhZvb42FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777555; c=relaxed/simple;
	bh=W1pe4p0h/ujYmBzxMk5Ld9IBc7vdbm9CU60zRdoevJs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=N9OTPkv+LmrF6q19SQsENJIczxce3IGRPHnm8Xt9vBuWSErzLOv7Tg+3sEvoOKg1fu/jm0CEkGU3EbRD7zijVhIHrhHaB+1O0Y2xv2xKaEx76imGBP7iGL31PHoZKGx9oFDtsDbRsQTLXUqndGCftMWO1mT1NoHYn/+L6Dz7d8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUN9iV7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F294BC43390;
	Wed, 10 Apr 2024 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712777555;
	bh=W1pe4p0h/ujYmBzxMk5Ld9IBc7vdbm9CU60zRdoevJs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QUN9iV7j3hJdbVToMFjz25UtvJhH+Pc1R2x/Q1OIjFLOMNd94JMAD7yp/7b3Z8U1y
	 lQaiFwONOFH4Wi5NnNQc78Adk0vKaRY3s/BlQ7bs7NRYtdNzOekErCHgjAf98IJEcO
	 yNo4EgSvlOVdHo/uZ85QJHhUKqGHnBt/iyKNqogR7CwkXQyDIHivlsSDFsoapzRNqH
	 Kh4md4TI5vef4sb+eXMV7W1IfLfSva3aJ1+Y1F2CQWDxZVa6b4p+bmjFCVu6r9oaGF
	 QVeAl97FnGX8LVsvUo2R6uifLuRmv/l7R/uEHz3eW4zBRsgZfCDFdLreiOdQziC0yD
	 MArqcIFTChYYA==
Date: Wed, 10 Apr 2024 14:32:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, Min Li <min.li.xe@renesas.com>, 
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 netdev@vger.kernel.org
In-Reply-To: 
 <LV3P220MB1202BACF71E85F949FC09A29A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
References: 
 <LV3P220MB1202BACF71E85F949FC09A29A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Message-Id: <171277755055.1212793.1486171322736151590.robh@kernel.org>
Subject: Re: [PATCH net-next 1/1] dt-bindings: ptp: Add device tree binding
 for IDT FemtoClock


On Wed, 10 Apr 2024 14:41:47 -0400, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> Add device tree binding doc for the IDT FemtoClock Frequency
> Clock Synthesizers.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  .../devicetree/bindings/ptp/ptp-idtfc3.yaml   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml:43:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/ptp/ptp-idtfc3.example.dts'
Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml:43:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/ptp/ptp-idtfc3.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml:43:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ptp/ptp-idtfc3.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/LV3P220MB1202BACF71E85F949FC09A29A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


