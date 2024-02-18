Return-Path: <linux-kernel+bounces-70198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C468594A0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB1B1F2175C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E244C7C;
	Sun, 18 Feb 2024 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMyCACXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7221368;
	Sun, 18 Feb 2024 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708231038; cv=none; b=j02Ek7pexJZp86fjY7U6N9iG0EJc1ObMS/33D1ypLU7w3Z/+QXa4eDyicgVhL56SvaeM5uYallpcO3wIOYhx7hoaYVtxqpxdKwAZYldURwZAr82Mr3auL3b1T5GDUXsOlkxo0ONhKX7vdkooUHiBECRyIdCN/+uZs1yNUq7mYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708231038; c=relaxed/simple;
	bh=exc6W+a8mXo+2ygkupRksZ9kXb5L+MofMKETRqMMwRw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=pIrI339ZxG+O1uODwxckj2dVUlN/NXKQPi2vTdjE4Pq5fLUqVqU2d1syHcjp/nHO98R+cHra5QRmH5JswJpRRaYT2PE0Y1hU8Nr4WPCKz+g42qS8cEBt10u7Q38pMfTzMuslteik6rHi1rFHK1TVUnVhTJkZeH5yv97iM6chTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMyCACXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D754C433C7;
	Sun, 18 Feb 2024 04:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708231037;
	bh=exc6W+a8mXo+2ygkupRksZ9kXb5L+MofMKETRqMMwRw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JMyCACXYbqQS/qYiI9BVz/gXOYm/kEHgzd2NafDorKoUhOihtdBZM5xDbLmFsEntV
	 Ph/aydKG11WEY9hPdSlIhv6Ntje684ioAiQLgx/TX7mPgMJ1Q4uMVkb92GkRIf239Y
	 e10XglzFdshBgUEU2rms9Wsb8OEBw3Q5xlWIyy3kgOnTpidGZqypW1ru3JV3HWcQDt
	 qBtG29X+mUP1h/EQLWHsCfExROWI4TsNPWP6YqNROhO1n8ZlOkyYDXasUDiLuovxHg
	 yBkrmahy9InxVGPHMqw/J9Pn1S3gaztGbGk296cnQN1oE8UEaVG6LF+goY7wmdsBQl
	 Pk3LrmXzQW4gQ==
Date: Sat, 17 Feb 2024 22:37:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 samuel.holland@sifive.com, krzysztof.kozlowski+dt@linaro.org, 
 inochiama@outlook.com, paul.walmsley@sifive.com, 
 linux-riscv@lists.infradead.org, mturquette@baylibre.com, 
 richardcochran@gmail.com, sboyd@kernel.org, jszhang@kernel.org, 
 aou@eecs.berkeley.edu, xiaoguang.xing@sophgo.com, palmer@dabbelt.com, 
 guoren@kernel.org, conor@kernel.org, robh+dt@kernel.org, 
 Chen Wang <unicorn_wang@outlook.com>, haijiao.liu@sophgo.com, 
 chao.wei@sophgo.com, devicetree@vger.kernel.org
In-Reply-To: <a48dd91d5f9dbb7d25fd6c80ed130dc458ab6769.1708223519.git.unicorn_wang@outlook.com>
References: <cover.1708223519.git.unicorn_wang@outlook.com>
 <a48dd91d5f9dbb7d25fd6c80ed130dc458ab6769.1708223519.git.unicorn_wang@outlook.com>
Message-Id: <170823103355.3760667.6705991834604152271.robh@kernel.org>
Subject: Re: [PATCH v10 2/5] dt-bindings: clock: sophgo: add RP gate clocks
 for SG2042


On Sun, 18 Feb 2024 10:51:19 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 43 ++++++++++++++
>  .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.example.dts:21.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/a48dd91d5f9dbb7d25fd6c80ed130dc458ab6769.1708223519.git.unicorn_wang@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


