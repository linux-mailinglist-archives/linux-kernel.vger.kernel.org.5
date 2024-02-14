Return-Path: <linux-kernel+bounces-64685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB8854177
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB41F29244
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB378F6D;
	Wed, 14 Feb 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOvlzN6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95817465;
	Wed, 14 Feb 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707877313; cv=none; b=c7DmoVHoinjKdgWs2AwPOLxRRYeSwoyL67wOw7H0DnNG4JUdxvJ2unVXp0h0fRui9/4aspTx1v6fOATyuXtlhSKecykopkYurDwmfg6Oxl4WDcyW/UiSbskn5yIgz4yzvpXxz7H9+XNkcFQF6qx7QsDSzeT2C4I6hUZq9C8xjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707877313; c=relaxed/simple;
	bh=oGA8Zybm6NlRQ7jaj1sY+qjLjdoZy0Kj7v2TUM0bTpw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GJgTvRekAMWO8Grc2TXIu9vsYXHzWDAW2uZSr7eEHZTbTcZjZ298oXyEERZWIPDtz7VktIJoJazq7s/0ftvtPpF0GdL/mKKmRX5Y8ohEsdf+lDdY7P3Gxx7G0IVrjG2Q+6Jv1CA8/zjpIdHJ+3E5hMAnNsLtH/8qFty9fkb9hjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOvlzN6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA38C433C7;
	Wed, 14 Feb 2024 02:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707877313;
	bh=oGA8Zybm6NlRQ7jaj1sY+qjLjdoZy0Kj7v2TUM0bTpw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eOvlzN6DaLNwBvUZauy7PAast2Pw+KkeEEirwWhSXY0EDNlpEO0rVTUTY3j5UNaWc
	 J1P35mCN6WmtgY0IyLWgbgmPUjuKQZhDCLu8YowvFHUCWSMZaaXH9J32yOu1Vqx5Hq
	 MlM1yrp0DHNz1BbXXOr/rf8I/1cuMCMFNa83g9zHDha/OTuXtrh+6Clj2M9rYYo83w
	 fzk21WFTPuOCmAQDnZnnfIZR6sXz+GtH/9iL8G+brHky32DqIjEXlLhqhiF1Kwvn8n
	 SPG373QnH5vfTprzTF2PRXpTjuqvgxGtoKIyr2BBYz4RzPZ702c6aDAZfhpYdXKxt2
	 t1n2qwWBLpzgg==
Date: Tue, 13 Feb 2024 20:21:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
 dlan@gentoo.org, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
 Liu Gui <kenneth.liu@sophgo.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Chao Wei <chao.wei@sophgo.com>, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: 
 <IA1PR20MB4953DA1000B825CA29E3BD11BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D95E8657A480813767FCBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DA1000B825CA29E3BD11BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Message-Id: <170787731083.3026929.8244516804059249825.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: sophgo: Add top misc
 controller of CV18XX/SG200X series SoC


On Wed, 14 Feb 2024 09:35:54 +0800, Inochi Amaoto wrote:
> CV18XX/SG200X series SoCs have a special top misc system controller,
> which provides register access for several devices. In addition to
> register access, this system controller also contains some subdevices
> (such as dmamux).
> 
> Add bindings for top misc controller of CV18XX/SG200X series SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml:35:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dts'
Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml:35:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml:35:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/IA1PR20MB4953DA1000B825CA29E3BD11BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


