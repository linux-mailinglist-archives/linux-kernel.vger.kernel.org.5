Return-Path: <linux-kernel+bounces-19027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897988266EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462E11F215EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055FEA5;
	Mon,  8 Jan 2024 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nGTGYvft"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66277F;
	Mon,  8 Jan 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0C38FF806;
	Mon,  8 Jan 2024 00:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704673972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ns+/ewTIcw4+stcnWjnPA8rI/Xmuma3lyLlpNthH0Hc=;
	b=nGTGYvftRBWmb20dt0pX26y1iurUCfqvc4u1NxPPXehUI+RWsuSchyJwYmqP9eIeKFUiwr
	gliLlxuoeTQlDsbM41HCdpez5CWvNljsSWTzyLRk+aoCVMNvzMRECki45vEiufQ1ze3Udm
	uNtu84FMZEQXsq9dZHxG1D9cCNaT5mdtD8rqxXcPPcZSv3vox98S1wwK6vUg55yMid8orZ
	wTV15inDLFXVccIE7+OUQhxOHi4bsRXKIoyrNeRF8GQYv2mjqXsF1zGwQoxZIgDRmIiUgJ
	orClUjJOsb6AD3eRBCYUqTVaT5Y+IbSH2Yz1IJaYXB+2zilx1zhfy3mNpMan2w==
Date: Mon, 8 Jan 2024 01:32:51 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
Message-ID: <170467396067.600256.16730322250867568357.b4-ty@bootlin.com>
References: <20231130173223.12794-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130173223.12794-1-johan+linaro@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Thu, 30 Nov 2023 18:32:23 +0100, Johan Hovold wrote:
> The PM8921 is an SSBI PMIC but in the binding example it is described
> as being part of an SPMI PMIC while using an SSBI address.
> 
> Make the example consistent by using the sibling PM8941 SPMI PMIC
> instead.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
      commit: 33f4ac16540509af518580abe730d409e8098aca

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

