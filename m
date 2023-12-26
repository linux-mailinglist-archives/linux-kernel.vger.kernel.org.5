Return-Path: <linux-kernel+bounces-11491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CDD81E726
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8888282D36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421234E61D;
	Tue, 26 Dec 2023 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2pdf+/g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C124E60B;
	Tue, 26 Dec 2023 11:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91884C43397;
	Tue, 26 Dec 2023 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703590744;
	bh=6hDfQYVG9Fe9ilOi+BrWGx19yefCb1Lq90IdKaxzrd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b2pdf+/gADlOuxQQgnTdm3ECWvF9/g/hhjcTg/Bm82tUIdXyWJOgVdt3+ORhlOo4H
	 MLlLLBEBBfsMhC+ZRo0bf3yOlmlF5l8qpJQMrSFOXMr0wJbC4uT4jsUnrFJWQD0MVL
	 xr78raYZfyJNwgTNj78P6cUAWDBJPDZAzV5cbb+eCK3+ouUcVMod/5SLnd6yW3vrMy
	 i005Hkj7zc1xnZKiWLeFWAuTzPgYENk88VtnTeEMiigsIUBKuLHOUu1LCiyXlIZwe5
	 lAd+MSYSOFBrbmvmZnZaiNju/3aPPTY3zI9W3jfxs1SlA5r/XhJXR2QmYK0wx/N3WW
	 Vg/zt1JY/GtCg==
Received: (nullmailer pid 2315540 invoked by uid 1000);
	Tue, 26 Dec 2023 11:38:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, dlan@gentoo.org, conor@kernel.org, paul.walmsley@sifive.com, alexandre.belloni@bootlin.com, palmer@dabbelt.com, unicorn_wang@outlook.com, aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, a.zummo@towertech.it, inochiama@outlook.com, chao.wei@sophgo.com
In-Reply-To: <20231226100431.331616-3-qiujingbao.dlmu@gmail.com>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-3-qiujingbao.dlmu@gmail.com>
Message-Id: <170359073886.2315521.12463957955592185332.robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
Date: Tue, 26 Dec 2023 05:38:58 -0600


On Tue, 26 Dec 2023 18:04:29 +0800, Jingbao Qiu wrote:
> Add devicetree binding for Sophgo CV1800 SoC.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.example.dts:25:18: fatal error: dt-bindings/clock/sophgo,cv1800.h: No such file or directory
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231226100431.331616-3-qiujingbao.dlmu@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


