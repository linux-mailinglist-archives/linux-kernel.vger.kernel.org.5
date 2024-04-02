Return-Path: <linux-kernel+bounces-128327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A089595F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6811C21520
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E040134BE;
	Tue,  2 Apr 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwCOAse1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5114AD35;
	Tue,  2 Apr 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074360; cv=none; b=ZPZRpSO59yR5lU5E118IAxUPxb+TwGp3Pbw4lyo6tjnaxVx4kZvlmBbql2psIhQJMGQX0RTbgVBauoFNvGRRl0iIfYgT8M8XBgGOhl94U5tw9gwo2M1FvJORBx8Nur6FWhaaSBJlW3QCn07hpSTqa+ABD/+gdK18hDSLeVAy/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074360; c=relaxed/simple;
	bh=GoS+A41EcPpbxG16cfUt+KE8yGdbrG9cCPQp1tPUxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNtvqiowS9yrNDJsOaDjmuiVwKyNkP6/52vVSXpsSrawlVzd0lTZHcE9KtCfb/dXmVaCxHJ1y9qvc/HwTA9nz6+PoRQenESC/7jmqkqeF+0fRRAxQkr2t5A24RlmN93i73t7R58U9WlD2E9IskBhD9s/C80hfxF46DgQN/MYFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwCOAse1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D05C433C7;
	Tue,  2 Apr 2024 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074360;
	bh=GoS+A41EcPpbxG16cfUt+KE8yGdbrG9cCPQp1tPUxgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwCOAse1eCh7vo453eDS7eV2SZ28zDshR+MgeZjLK71eFtib4/9LOzRIzQMtS32kk
	 PJn3L1K3mQvDhiPpzt7WDfqXpjIgHnsXX0Y9RCcec3tyIqlQ/4OXbdaFkfsRh1PHX7
	 6zdYVMSJbVIvuvjoljh6mDuKust3BxExigY4j1sVXG4npesIbFliyE5vcEwuhxjV3C
	 bSxdp8fbc9F3ysRt8wupzy4MOMMwZ9P0gU6CUTOfZ9DI/SXowS7t0pcAfEHey4iGoj
	 XcKNxuErxtEgC6Q+mnwsgT6RUIfu8xGXezsCUbaT2eYMs9eXH/NNh70aq7pFV6TrNE
	 YQLrRsqjIAQDQ==
Date: Tue, 2 Apr 2024 11:12:37 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: festevam@gmail.com, shengjiu.wang@gmail.com, shawnguo@kernel.org,
	broonie@kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	imx@lists.linux.dev, s.hauer@pengutronix.de, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, kernel@pengutronix.de,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: fsl-asoc-card: convert to YAML
Message-ID: <171207435593.237814.17122445408696943016.robh@kernel.org>
References: <1711976056-19884-1-git-send-email-shengjiu.wang@nxp.com>
 <1711976056-19884-3-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711976056-19884-3-git-send-email-shengjiu.wang@nxp.com>


On Mon, 01 Apr 2024 20:54:16 +0800, Shengjiu Wang wrote:
> Convert the fsl-asoc-card binding to YAML.
> 
> When testing dtbs_check, found below compatible strings
> are not listed in document:
> 
> fsl,imx-sgtl5000
> fsl,imx53-cpuvo-sgtl5000
> fsl,imx51-babbage-sgtl5000
> fsl,imx53-m53evk-sgtl5000
> fsl,imx53-qsb-sgtl5000
> fsl,imx53-voipac-sgtl5000
> fsl,imx6-armadeus-sgtl5000
> fsl,imx6-rex-sgtl5000
> fsl,imx6-sabreauto-cs42888
> fsl,imx6-wandboard-sgtl5000
> fsl,imx6dl-nit6xlite-sgtl5000
> fsl,imx6q-ba16-sgtl5000
> fsl,imx6q-nitrogen6_max-sgtl5000
> fsl,imx6q-nitrogen6_som2-sgtl5000
> fsl,imx6q-nitrogen6x-sgtl5000
> fsl,imx6q-sabrelite-sgtl5000
> fsl,imx6q-sabresd-wm8962
> fsl,imx6q-udoo-ac97
> fsl,imx6q-ventana-sgtl5000
> fsl,imx6sl-evk-wm8962
> fsl,imx6sx-sdb-mqs
> fsl,imx6sx-sdb-wm8962
> fsl,imx7d-evk-wm8960
> karo,tx53-audio-sgtl5000
> tq,imx53-mba53-sgtl5000
> 
> So add them in yaml file to pass the test.
> 
> Also correct the 'dai-format' to 'format' in document.
> 
> For 'audio-routing', the items are not listed. Because
> this fsl-asoc-card is generic driver, which supports several
> codecs, if list all the items, there will be a long list.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
>  .../bindings/sound/fsl-asoc-card.yaml         | 195 ++++++++++++++++++
>  2 files changed, 195 insertions(+), 117 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


