Return-Path: <linux-kernel+bounces-5529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD4818BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAB428757A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C91D143;
	Tue, 19 Dec 2023 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6qp/rYy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935661CF8D;
	Tue, 19 Dec 2023 16:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BCEC433C8;
	Tue, 19 Dec 2023 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001625;
	bh=6OAazItlXZJb2RxR9H3/uVNW6w630Htp7mI9+DI1Y+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6qp/rYyRU+mlbN7Gwg5AiRzgx1Rbk2cEcW7os7DvgtbRVUSVD5jwYfKeOFo7d6lj
	 xkJeHhmYXgq4qBejzL6PbgBTptUlC3dxXs43BarrIUonCkHTUt+QY4Au/UJTm0fuz8
	 TuOQQHW0N0hk1Km2RVCIdp6zAvaYrWaqvE/pjMXHOrWHH4TJf1E1D0pDrXLA557Qnm
	 oaHm0qvDwOGaLPe4BoFRFGYLMk754Amrp/MlqYcwqmBoYWGYb+JAtruBTy4Oz7dISQ
	 aFj/FE7GffOZKKKRcl28kEEoW81aJbB6fW6/Nr/hiAZfQ2GVt65u9L5A4U/Si89vEQ
	 ZVsDeiBHfIHOg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFcW6-0008KD-0D;
	Tue, 19 Dec 2023 17:00:22 +0100
Date: Tue, 19 Dec 2023 17:00:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: clean up example
Message-ID: <ZYG-Fr9FfIQUup_r@hovoldconsulting.com>
References: <20231130172834.12653-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130172834.12653-1-johan+linaro@kernel.org>

Hi Linus,

On Thu, Nov 30, 2023 at 06:28:34PM +0100, Johan Hovold wrote:
> The Multi-Purpose Pin controller block is part of an SPMI PMIC (which in
> turns sits on an SPMI bus) and uses a single value for the register
> property that corresponds to its base address.
> 
> Clean up the example by adding a parent PMIC node with proper
> '#address-cells' and '#size-cells' properties, dropping the incorrect
> second register value, adding some newline separators and increasing the
> indentation to four spaces.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Can you pick this one up for 6.8?

Johan

