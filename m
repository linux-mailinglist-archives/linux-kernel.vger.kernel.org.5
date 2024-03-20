Return-Path: <linux-kernel+bounces-109444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDA88193F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866931C2110F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E928614C;
	Wed, 20 Mar 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZvQisZb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC68613F;
	Wed, 20 Mar 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970898; cv=none; b=OKlvm8oAavMkOIqWNWg8ysRUg9iXaZ4gB6NG2MkToRtt23vlyoLtRCh7iw6UENAvuiQnD1d9YV3StEhSQAr/SuSr84LChI2Nru8lePTxZbZSZ4Ug8iaOrnRy8FPa4WmWZ3+cGibMDp1etUiHurgY5NuSCCYq6kAnfrSJqD27BWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970898; c=relaxed/simple;
	bh=XsmAB7EXFsutDSIAv8tlhZP7IVJx0037ZDdYmvdHizE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ttbv+GVEw6s+7cptAZrAJVcfKtxJ4/sXWKfwc4EK8jj5zDO2mW5t82NgPCvkrCAuz8nRkcJJgXJnqu+US05nWnh9nBaDBG86kSxbctpBoU3uhNCUF3zrYq8ZJ9KCTxahyi9WUBSsnU+l2/DcprD0CUNmWX+hpcXBdeUDz2mS9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZvQisZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27C2C433F1;
	Wed, 20 Mar 2024 21:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710970898;
	bh=XsmAB7EXFsutDSIAv8tlhZP7IVJx0037ZDdYmvdHizE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NZvQisZb1fCrQfqweiQ3QTxklIRPVt9kHrKc8gnBYBZSy/OSqLGdujGLHt6Lg+CD5
	 /W3yn4f99IRgB/vkxdfQ8dCps6zTMtkk2mi75aqMYNODArAt92LRt1EA2OZ6h0S5oR
	 BOVE4Cbv1gQv/ylTqkCdwSEPxEsY6S8o1iuLbahTpXZzV+25pc8ecK/zEfx8KxvmuU
	 bu83rn/Hj3zKOe8Rbc7agSRuRvOctkK9WRNJWtz7cVUYa8uxjyI9fBH4j4pe2FPZja
	 aEH9Ou0qeooJX+oLtjn6nf0yF3qRG258tCm3n2QzTW8H8Sy4qJDmNkk7JJOuRuvSxc
	 YFND0xwN3XXKg==
Date: Wed, 20 Mar 2024 16:41:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: kernel@pengutronix.de, jic23@kernel.org, devicetree@vger.kernel.org, 
 haibo.chen@nxp.com, s.hauer@pengutronix.de, linux-iio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, festevam@gmail.com, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, upstream@lists.phytec.de, 
 imx@lists.linux.dev, shawnguo@kernel.org, lars@metafoo.de, 
 krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240320100407.1639082-3-andrej.picej@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240320100407.1639082-3-andrej.picej@norik.com>
Message-Id: <171096725727.717649.376674198278388315.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties


On Wed, 20 Mar 2024 11:04:06 +0100, Andrej Picej wrote:
> Document calibration properties and how to set them.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml: nxp,calib-avg-en: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml: nxp,calib-nr-samples: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml: nxp,calib-t-samples: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240320100407.1639082-3-andrej.picej@norik.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


