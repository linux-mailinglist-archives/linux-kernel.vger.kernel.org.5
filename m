Return-Path: <linux-kernel+bounces-56596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BB84CC52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDC61F23A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7387A73C;
	Wed,  7 Feb 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV6HDBHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDA7C088;
	Wed,  7 Feb 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314801; cv=none; b=WP3HrCCQDclCRIuug6/nUu0z6cV++PMvrQ22sEmM+TY8nPhu2EsP9vWPtfSLOzVYfCIFZjJ5hjnitrUTimvRsm1oDGiwjzOvUPQusuvKXThEuNZVjKBODjQq256KVNGxBRwo4lNVHIzq683Z6XHh94BRY5oV+7FPCggb75ViABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314801; c=relaxed/simple;
	bh=ZZh2zTyS9CP/+FQ/BuELNpqH1LEwwITFg2cvWsaj4Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL693QFCAvgs+NDTmcSkXNVQb1TuJ7m6QqtyV0Evz4dkK55n4svDmWRIC0QCzuXHfL+ncvzAzwMlMj4z60KR9gUUKYenJRXRoR32d9mkx9Lki0h90z3ggTbwlTJyhteBgCMMD2xP8zr8nvRYjrlS1BCF0Hkjdfb06HTN4iKQdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV6HDBHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5518BC433C7;
	Wed,  7 Feb 2024 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314800;
	bh=ZZh2zTyS9CP/+FQ/BuELNpqH1LEwwITFg2cvWsaj4Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV6HDBHac8FFIrL3H75dbmU7s5Cb6moJ+VkCQLwuVuDS4Fwhp498+Ux4j+8Kx226D
	 +qY4jSwCtZ/D4cwV9kkvxql+cSTOV8vroWLaHBihJicKmifkf8CjyGVBERD6iOxZgo
	 t9snGvsmHq6eX8mqcSbirEf6a7OPzL8aSj0yooJ5FcnTxS4oezRCw5nRndXL3wnNB7
	 W3uhFfNGjGt4WO+CHGzKy5YA36h2d7hnKXzkd4wrfWVBOvv4CPAR+ypTNpl31pS2hj
	 aft8nAneOjptcLMWQO/v+SB0ZuiOHfly7b93WJhWaGzGZkF0EOkbrzOqLwkzFJ3t8i
	 E6yfcU/DCrKlQ==
Date: Wed, 7 Feb 2024 15:06:37 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Algea Cao <algea.cao@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
Message-ID: <ZcOObdUvxmRzdHnE@matsya>
References: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
 <ZcNYlFgT0rXiCGbo@matsya>
 <374f5069-9f3d-4ad2-a6da-b38a143a0c99@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374f5069-9f3d-4ad2-a6da-b38a143a0c99@collabora.com>

On 07-02-24, 14:39, Cristian Ciocaltea wrote:
> On 2/7/24 12:16, Vinod Koul wrote:
> > On 05-02-24, 13:24, Cristian Ciocaltea wrote:

> >> +static u8 hdptx_grf_read(struct rockchip_hdptx_phy *hdptx, u32 reg)
> >> +{
> >> +	u32 val;
> >> +
> >> +	regmap_read(hdptx->grf, reg, &val);
> >> +
> >> +	return val;
> >> +}
> > 
> > why use wrappers, why not call regmap_ apis directly
> 
> Agree, no real benefit, will drop them, except probably
> hdptx_multi_reg_write() for the extra savings.

That one is fine as there is good logic on the helper
 
> So I'd keep using that one if there's no strong reason against.

ok

-- 
~Vinod

