Return-Path: <linux-kernel+bounces-161681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEA8B4F68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1242CB2101A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB101851;
	Mon, 29 Apr 2024 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pojz2P2v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559F7F;
	Mon, 29 Apr 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714357430; cv=none; b=Aa5XQBlPmI2Qk1LFV2Ejb4zeinB5Rd6AwRFHfFggUz1jtOdYiY4oklKq0wJ+oL91i0gXvNH4CwF3bCQpv54UXpCtGyxJBVINZtAuMW4oF16ys+TxP9PXJ2kx0HM6ArBZTTWJ+/oBK5gcIsMSRgvSsNp3sD11yT/etFCgPjrSLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714357430; c=relaxed/simple;
	bh=WYFriNTPWk5Av35BEvQDZ0ykSmc5zyg+ED9bmRoMVrE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=uBtpiRa9JAg1V+F6ZFA6Defk9wZbDDdQnWPweu9DQT4DWbcKqLsTKFsrF8tve6Ed7asPaOACQGT+y0X78n9gRbpUkU4HV0Ofxu+PwiFNq4uZ3NczBF+7jJqF5Ny9+lIxyu1mNzCxTXDvkND2+ypniv7ptXfdDp8V2jxGGjMpC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pojz2P2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486F9C113CC;
	Mon, 29 Apr 2024 02:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714357429;
	bh=WYFriNTPWk5Av35BEvQDZ0ykSmc5zyg+ED9bmRoMVrE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Pojz2P2vRZfzYY4NXQ59bMet2uyQGXEwouqIljiQr/MDQ/yTgV2kgqgP0Eo/2x9Az
	 Aqe4Yp2ZceR2JdWH2Br8vvZqF6YONQ45o/IqfCCZtHbpm7WSrI5PdU0pmVSr06+HlT
	 kUzhwn/+gsw9xfbKVt9ONvhBzhBfIdxWA2ISp4K/Lp/pa6d6phgi5uvd033vIZmulR
	 Yvqw6r23cUfumJGPXKun2wXfK9KiMjfF9CQSaMngUZeLJKtrs/YLF4j2v1STngmgpy
	 apiCxBxJikGMKLqppGtsuUztWrkxsgqXaDhvNIrzvzjSUrlzlNFpPVFyKL2FwDSBeV
	 Bu0S557oOR0Ww==
Date: Sun, 28 Apr 2024 21:23:47 -0500
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
Cc: linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Jean Delvare <jdelvare@suse.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org, 
 Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
In-Reply-To: 
 <IA1PR20MB495302443F9B18EB1A0DDF65BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533CA5A5D0036F373308DBBB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495302443F9B18EB1A0DDF65BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Message-Id: <171435742665.8725.14900976847572107188.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support


On Mon, 29 Apr 2024 08:56:34 +0800, Inochi Amaoto wrote:
> Due to the design, Sophgo SG2042 use an external MCU to provide
> hardware information, thermal information and reset control.
> 
> Add bindings for this monitor device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-hwmon-mcu.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/IA1PR20MB495302443F9B18EB1A0DDF65BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


