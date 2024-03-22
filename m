Return-Path: <linux-kernel+bounces-111416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5D886C09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7CE1C21C14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C34087A;
	Fri, 22 Mar 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5rvFFeQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64A171C1;
	Fri, 22 Mar 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110443; cv=none; b=PBb/2PCKloQwkt7l6pJDsbEFr0Rg2EY76N0qklyPfNM6f4RMAkWq5n1HrePYuMOCruoWndlT2t3gIQuVA5Bi7QSukHuWjPd32OyVyRQFXweocVEghRuFM+ZyX2wudoTMtuuuDuFPVXTWuQu+oywQggsgXEYa4/Wt+nPzI/VSj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110443; c=relaxed/simple;
	bh=S35265EL23bQ41tbX9WxNkx34I55BCHyT7kRy9YIqS8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=e3H6luUPFBLvdI127ky/hWdAlg5QDcguSOB5Ji37aZJ1BiNsCfllPOo+67rCO/DwUDd3OzVSn7mbsyQjkE+sh9zzhZNMkhCzoRVr6/rEP58suqWKISnQdiipvn0lUuZKE7KuxC950H5Nvl3IhpZMtbdJzNJWUFXwQDSyLlNAPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5rvFFeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730E6C433C7;
	Fri, 22 Mar 2024 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711110442;
	bh=S35265EL23bQ41tbX9WxNkx34I55BCHyT7kRy9YIqS8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=R5rvFFeQ//A4MUzfunsC/BfguiismgEjp2w5WT1wkI6oU/xmzLv0GJMDcW+3QoEO9
	 u+ObcdSCdXGn25ah0oCA1yDGJgtHxgBM/+fH+RO7V02h4pBDiiNGOlY+/cJnq4a5pJ
	 i5FYelhresQtsZc0GVTOF0NYl1iTa0HzP8WBdUUO34uwuxDQ30hdSw+a1D/G2z78E+
	 WRLBO22wv8YVNS8dN2uAy87rDo/PDylO9QAKjWfal0AtMoDFsIysveIs6y/nAUyqOd
	 Txi9/A2/9PrBzON+u4yPd2z9H4cg30cvvOpmc+Y7A3jKEIV7+wxpCs6bMIUonOSxtT
	 8IL3vNOkXfeEg==
Date: Fri, 22 Mar 2024 07:27:21 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, broonie@kernel.org, 
 linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, 
 robh+dt@kernel.org, kernel@pengutronix.de, conor+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, s.hauer@pengutronix.de, 
 festevam@gmail.com
In-Reply-To: <1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com>
References: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
 <1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com>
Message-Id: <171111044043.703687.6789564632067483039.robh@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl-asoc-card: convert to YAML


On Fri, 22 Mar 2024 18:13:25 +0800, Shengjiu Wang wrote:
> Convert the fsl-asoc-card binding to YAML.
> 
> In order to pass the checking, add some used compatible
> string from devicetree.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
>  .../bindings/sound/fsl-asoc-card.yaml         | 196 ++++++++++++++++++
>  2 files changed, 196 insertions(+), 117 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml: Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


