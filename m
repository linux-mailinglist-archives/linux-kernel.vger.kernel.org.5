Return-Path: <linux-kernel+bounces-146177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA488A61B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1EA1C20BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277CF1AACC;
	Tue, 16 Apr 2024 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKvQde2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4611C92;
	Tue, 16 Apr 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238268; cv=none; b=Ubnmd61Ep16391USb+rsEEpJOJbu2DZM9aDdYX0whmdOtOelSE0ilgY2buMR7gaVxVQHmvISs4cMLi/soVxQRtnRwR7Vq1Ort6OU3DO5olY79XIyXgYg2aWnoAzY+LyzkHI2ZArwFKIzZEdFtEcTTsfe/DBxPYD8j9rPwmaclMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238268; c=relaxed/simple;
	bh=a3rUP++5Bv6oCHr5Ncb6/p4PNJQiXGJ9THHHsW7MB4Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qDehjeIwBHdy0jQ0ihdHtOhpjVrhIzUx5u6kJE0WNDzCupKC/Z6Y64A0QJDAEW18vLCf/bVSUgNGqPOykj4QNW9ViasAsDjafsR8k74zcqmxNaR6ral22Zfo8xs37JVs8JdBviyhz0Hje1u7Lx2FA5cz/7Ij4mMYNREwoXAf8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKvQde2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2231C113CE;
	Tue, 16 Apr 2024 03:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713238267;
	bh=a3rUP++5Bv6oCHr5Ncb6/p4PNJQiXGJ9THHHsW7MB4Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oKvQde2fTTl4ezaTt7W17XKY2gPVYyatVLwcLP50yzzgH8y8zem9ouASl6Z3UsMmJ
	 LG2hjXElS6d9t2S+ocPDQp9AzVh/bit3pHuJN399eys8c1K9eLFVyZ0ehWKnUR8JGo
	 dsw6Fle2uKgAGzOtYTc683KI32xGCIUIjQOB0EgQP0+qk1F91g6XkJ8ZIKfi2sicJ+
	 mR0N5qWHHVGGBt5O0iiqBZdyPIdxaemYn05PbV7OIJNN5zgXtlApTAWPOw1jTDxobL
	 JGA4rv2TJa+VWFfD6gyjesGMf8MTTunE2XXZWbjUq2d7CQby1qPRWwnP4X5IrOrQsp
	 pdctBb+/+L7PQ==
Date: Mon, 15 Apr 2024 22:31:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Allen_Lin <allencl_lin@hotmail.com>
Cc: benjamin.tissoires@redhat.com, krzysztof.kozlowski+dt@linaro.org, 
 jikos@kernel.org, linux-input@vger.kernel.org, conor@kernel.org, 
 dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: 
 <TY0PR06MB56112682F500F8761F76DBA99E082@TY0PR06MB5611.apcprd06.prod.outlook.com>
References: <20240416021228.1092678-1-allencl_lin@hotmail.com>
 <TY0PR06MB56112682F500F8761F76DBA99E082@TY0PR06MB5611.apcprd06.prod.outlook.com>
Message-Id: <171323826551.687221.15997746992976614579.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: Add Himax HX83102J
 touchscreen


On Tue, 16 Apr 2024 10:12:25 +0800, Allen_Lin wrote:
> Add the HX83102j touchscreen device tree bindings documents.
> HX83102j is a Himax TDDI touchscreen controller.
> It's power sequence should be bound with a lcm driver, thus it
> needs to be a panel follower. Others are the same as normal SPI
> touchscreen controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> ---
>  .../input/touchscreen/himax,hx83102j.yaml     | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml:93:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/TY0PR06MB56112682F500F8761F76DBA99E082@TY0PR06MB5611.apcprd06.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


