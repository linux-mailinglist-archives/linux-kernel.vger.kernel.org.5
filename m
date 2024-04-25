Return-Path: <linux-kernel+bounces-158884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FBD8B263B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA93DB27E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844A14D458;
	Thu, 25 Apr 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+Bn3vDq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2D14D43E;
	Thu, 25 Apr 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062033; cv=none; b=XrgyvBD7Dwq7hrgkeDbaC64HUpcLxx3CelS8e+Ep0mS0wyJiR+uXXBWI/rT27+oMIxIx6d4Uhbowp/qQnhpFzzxROUEcfWklm6DqlO2R0CfVJeEpeWXMw235xKI0YXZi8tFMQfGb7iTPDQreVgRkEQmRPmmEXYmEFicOgM7ncHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062033; c=relaxed/simple;
	bh=uLkBKfw7eQnYUcwKax1KNhK6XlsKjLGnhdtOnQ/r9rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Saqenwwvs2wnwW72zf+INTl97ejSwAjVhhEuHY54itAHcHfPDUNRdd0UlC8LXv6er1tMGMR/dV76duWrSbrKjJ5ZYClsXVHyL12B1WRREB5DqLPdeSgJWVpVlpCWvGa2/cXfBcqKn/XvEX/d9qAx0RSoKWCX9dASjiyxtxQPwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+Bn3vDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEF4C113CE;
	Thu, 25 Apr 2024 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062033;
	bh=uLkBKfw7eQnYUcwKax1KNhK6XlsKjLGnhdtOnQ/r9rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+Bn3vDqx3gWSmBWV5QrMQ31X68bNm9I82sFXSz6E5YkY7B+0Ycl4ai9g06QQDcEy
	 MB6lYsd+YOOMrX5b5hpjMiIiMMEjz26BLholiosYWj1I2sWkok5G5nVrrCNiXYpmcy
	 dV7G0xHxSDc0XCgNfKB6cuKzWm4FoRhIXMwOHshJg0AMcOzZ43hSvpXF5ZxP/7ycjc
	 pfQU1WMBKI1/rYjG9G9eil23Xmi2HlbmGqb1KFYzizef8/DqHr5O1td2ITBWb1mdRk
	 Pfjc+5CQbovrh+QrsoOO8dJ0aHT/0rjHKNwojj8fbF6vFfjbxVUal0pHciqRvqfSA5
	 AcNfCa1WG2Bww==
Date: Thu, 25 Apr 2024 11:20:31 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, shengjiu.wang@gmail.com,
	krzk+dt@kernel.org
Subject: Re: [PATCH v3] ASoC: dt-bindings: fsl,ssi: Convert to YAML
Message-ID: <171406200022.2782837.7403181680404872625.robh@kernel.org>
References: <1714026906-16723-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714026906-16723-1-git-send-email-shengjiu.wang@nxp.com>


On Thu, 25 Apr 2024 14:35:06 +0800, Shengjiu Wang wrote:
> Convert the fsl,ssi binding to YAML.
> 
> Add below compatible strings which were not listed
> in document:
> 
> fsl,imx50-ssi
> fsl,imx53-ssi
> fsl,imx25-ssi
> fsl,imx27-ssi
> fsl,imx6q-ssi
> fsl,imx6sl-ssi
> fsl,imx6sx-ssi
> 
> Add below fsl,mode strings which were not listed.
> 
> i2s-slave
> i2s-master
> lj-slave
> lj-master
> rj-slave
> rj-master
> 
> Add 'ac97-gpios' property which were not listed.
> Then dtbs_check can pass.
> 
> And remove the 'codec' description which should be
> in the 'codec' binding doc.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v3:
> - change fallback string to const
> - split fallback for imx21 and imx51
> - update orders of properties
> - add constraint for fsl,fifo-depth
> - minor change for example
> 
> changes in v2:
> - change fallback string to const.
> - add dai-common.yaml
> - add ac97-gpios property
> 
>  .../devicetree/bindings/sound/fsl,ssi.txt     |  87 --------
>  .../devicetree/bindings/sound/fsl,ssi.yaml    | 194 ++++++++++++++++++
>  2 files changed, 194 insertions(+), 87 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


