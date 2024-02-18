Return-Path: <linux-kernel+bounces-70199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123EB8594A3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C096F2843FD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BE611E;
	Sun, 18 Feb 2024 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFoCOLO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E553A7;
	Sun, 18 Feb 2024 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708231041; cv=none; b=KKv0wYSL2YaW8fNoiS+jq/Geab/3rbZoCH2B70d9Cozg+kx+OXrz5sJPjB+GAcVS3XT5hsarLF9ouKsRAJOrQZTy2x+qTJLEbFWqOyTRGRMRlEF9RT4e3yiemGhQ2TFDLdUwIN4qxtdH42SovFkR7qkJtXzL3f99yv3jM6GM9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708231041; c=relaxed/simple;
	bh=h3RWMSFzQ43bwF1fjlbqaQGi2ketXLn+Xpm4l+hTDYQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VyZ7ke7swEEgUIpdgpzLOqTGtroRqcMtwP8EG5zFj2cUoirNLM3ZALsqfzoOsbVj8+s+0HW+QkkPO09oIGufQ7hD8UUzLrxV5e2v4kX03f/cRQDkfaOoubB+KPUrssYX63HWT5JjDTpwWsJOtNhv1hyHNH6mg7Skp4gp62vIsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFoCOLO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C32C433F1;
	Sun, 18 Feb 2024 04:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708231040;
	bh=h3RWMSFzQ43bwF1fjlbqaQGi2ketXLn+Xpm4l+hTDYQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FFoCOLO2nWXkDFaFeqf7iq7bPS6dp4XgkEVvo+CvdSla1wdfuWD7noFAv+b0OyuVu
	 QikzkxPjJWE5YWA/wyUZ1sMziIkiBVhwQ0gRHbdO6zHhlHpyvihh36mIu9JKfO5SEA
	 BTUI9faQJE2Hf9RIPbCrmbwS0jUy9IsIbXPb5Nc7V5JzkOuLl7mOZodNdd7NLtTcQR
	 41xV7GvhgHqblRGyljpZH1t/NAn5/odhhFiTyaag+LDOlQ/ifhAH+sF3Bp9I67bXzm
	 Re2n1TMz26iQ+8fahRp++IhndRe9sIQxU7HENY7Hk3ah2oVz++gYok+fnQ6tnrZ+d3
	 G7/xILvay2+OA==
Date: Sat, 17 Feb 2024 22:37:18 -0600
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
Cc: haijiao.liu@sophgo.com, paul.walmsley@sifive.com, guoren@kernel.org, 
 inochiama@outlook.com, chao.wei@sophgo.com, devicetree@vger.kernel.org, 
 aou@eecs.berkeley.edu, conor@kernel.org, robh+dt@kernel.org, 
 samuel.holland@sifive.com, linux-clk@vger.kernel.org, 
 Chen Wang <unicorn_wang@outlook.com>, jszhang@kernel.org, 
 palmer@dabbelt.com, mturquette@baylibre.com, 
 krzysztof.kozlowski+dt@linaro.org, linux-riscv@lists.infradead.org, 
 sboyd@kernel.org, richardcochran@gmail.com, xiaoguang.xing@sophgo.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <0de0c16b9ff02a1b9c0d013ba0a71199e536387a.1708223519.git.unicorn_wang@outlook.com>
References: <cover.1708223519.git.unicorn_wang@outlook.com>
 <0de0c16b9ff02a1b9c0d013ba0a71199e536387a.1708223519.git.unicorn_wang@outlook.com>
Message-Id: <170823103463.3760729.17194959615041908023.robh@kernel.org>
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: sophgo: add clkgen for
 SG2042


On Sun, 18 Feb 2024 10:51:37 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add bindings for the clock generator of divider/mux and gates working
> for other subsystem than RP subsystem for Sophgo SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  49 ++++++++
>  .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 111 ++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/0de0c16b9ff02a1b9c0d013ba0a71199e536387a.1708223519.git.unicorn_wang@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


