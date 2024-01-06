Return-Path: <linux-kernel+bounces-18548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C8825F10
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95D6B230D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF763CE;
	Sat,  6 Jan 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVmmIGax"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA263AA;
	Sat,  6 Jan 2024 09:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDD5C433C8;
	Sat,  6 Jan 2024 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704534712;
	bh=a9bpUDKg0i4oaQbSQwd8PEIMaUV1RvH3ujiDlLgX5h8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iVmmIGaxylLEURen//u/q2GCXloOV30pGLe/EN/c7yxmPWM8Ju8WX4RquGn4tD99U
	 9NdAhzF6AjQ0tKdAaeaVKhPB+CJ2PUIr6VSG//ANIaftDZWq/tfNJyZ3+h3fhJIURy
	 ECnC56Dos6PLexpau3jillqhSRWPsSuuFS+gtlB2BRvf8HC1c7IMAVOgbrya5Xa+Gk
	 pGe5Tkku4ccI6vtHhOwCeNSa7jgjSNqjDUs8M5Icf7Nd6XEwZT941HwfOqNCBkAVDx
	 KqspovayBz7Tpqb4TwKXkmn5sLka3ahb8elLfPmfqV3p64dGnj3Z9vVn8PCcSLfJog
	 Uh2AzK33XP6KA==
Received: (nullmailer pid 703195 invoked by uid 1000);
	Sat, 06 Jan 2024 09:51:50 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Petlozu Pravareshwar <petlozup@nvidia.com>
Cc: conor+dt@kernel.org, cai.huoqing@linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de, spatra@nvidia.com, linux-tegra@vger.kernel.org, kkartik@nvidia.com, robh+dt@kernel.org, dmitry.osipenko@collabora.com, jonathanh@nvidia.com
In-Reply-To: <20240106075134.3933491-2-petlozup@nvidia.com>
References: <20240106075134.3933491-1-petlozup@nvidia.com>
 <20240106075134.3933491-2-petlozup@nvidia.com>
Message-Id: <170453471019.703179.18182038720980471680.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Date: Sat, 06 Jan 2024 02:51:50 -0700


On Sat, 06 Jan 2024 07:51:33 +0000, Petlozu Pravareshwar wrote:
> Scratch address space register is used to store reboot reason. For
> some Tegra234 systems, the scratch space is not available to store
> the reboot reason. This is because scratch region on these systems
> is not accessible by the kernel as restricted by the Hypervisor.
> Such systems would delist scratch aperture from PMC DT node.
> 
> Accordingly, this change makes "scratch" as an optional aperture for
> Tegra234 in PMC dt-binding document.
> 
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra186-pmc.yaml        | 83 +++++++++++++------
>  1 file changed, 58 insertions(+), 25 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml:85:12: [warning] wrong indentation: expected 12 but found 11 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240106075134.3933491-2-petlozup@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


