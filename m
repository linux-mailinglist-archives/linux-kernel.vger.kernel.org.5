Return-Path: <linux-kernel+bounces-57176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F379384D4C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC702830D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7EA1635AF;
	Wed,  7 Feb 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl3hCxpQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEE15DF1D;
	Wed,  7 Feb 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341159; cv=none; b=c4KJODKMHCt7mDBrgiRAULtMsheFtL1pinEJL4n5AEZs8cG/UGOB9278fIhvcJ0ogPDyL02R5upYuOJjUSxAUR2IhdUHtWyi4kvJk7zjsUqAbqs1oKUPXeosFjzOfoa7oXQS0EpzYbJPeh7G42L8GUxHtdaYlIliTvQON29gD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341159; c=relaxed/simple;
	bh=e+Z2YkeWHVp4lNUuM47W5BZGrVfrvL38YMqC+CmljIM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sUHR9DSy2Z77X+8Lb9baipiplf3U/sTHBGk6h+ySO9XLOS38xUOa4qDEoX099C1T8lL9oIDxox9JFCvPe1uOtfA4hEM6EhoVd6ZeVRIrO+S+qsIy27oXYtjzNwx44wPr6Qo1fmDUFWCq72d9ZxS8RdVIdvx7RiaJ6igAj6clhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl3hCxpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EA9C433C7;
	Wed,  7 Feb 2024 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341159;
	bh=e+Z2YkeWHVp4lNUuM47W5BZGrVfrvL38YMqC+CmljIM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hl3hCxpQs3nZiA1Cfh0NDG/eOrfjD5H7qfTLdu8uBoKH62DkZVPbLOFWSJkCqWVDC
	 0NBRSeCa80sfou54B9gt34GlGZX/eL5vgUpGfOL4kIqwo/kz+nqpvLKkrk61p0Awzd
	 4yFlThgspST435hR4UowPVFyg16910/+x+tInsLegxwhlzY/GvCa3e48BEe8OkgxSK
	 lrzM1GB8mb6f6hnK2seoSg+TGObb3ntQEVkwod+rPx7S2ljkSNwfNze4lsXenYPpK6
	 3ubDyh+FJhVhZnP672fLPJ2hINoIN8ZJyRJliOWVVCz0YEJPCdVprpeXlcaGShcVEG
	 tOlDrkGbaalqQ==
Date: Wed, 07 Feb 2024 21:25:57 +0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: Rob Herring <robh+dt@kernel.org>, avandiver@markem-imaje.com, 
 bcody@markem-imaje.com, mdf@kernel.org, linux-fpga@vger.kernel.org, 
 kishore Manne <nava.kishore.manne@amd.com>, devicetree@vger.kernel.org, 
 Wu Hao <hao.wu@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>
In-Reply-To: <20240207180142.79625-5-charles.perry@savoirfairelinux.com>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
 <20240207180142.79625-5-charles.perry@savoirfairelinux.com>
Message-Id: <170734115258.3199432.9793593609172465868.robh@kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema


On Wed, 07 Feb 2024 13:01:27 -0500, Charles Perry wrote:
> Document the SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.example.dtb: /example-0/fpga-mgr@8000000: failed to match any schema with compatible: ['xlnx,fpga-selectmap']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240207180142.79625-5-charles.perry@savoirfairelinux.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


