Return-Path: <linux-kernel+bounces-47081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEFF8448E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD52B273BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0813B7BF;
	Wed, 31 Jan 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI1WIFeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B713B793;
	Wed, 31 Jan 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732877; cv=none; b=fk721B9phdL/l87FSp/OBqzM6t8e7omj8sREvhrOfGOqKTzgf8s0kqsvWk2o/e41/bIaAL3zfvaQFFg250t/dzpYsfMpGmHTZe6aBzp7fJ2SMaiHP2+MyJGvEeQKXIgGZ3St4VgajaZ8cxDEPyXd0vGX3gMAd6P5ip2vL5NxCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732877; c=relaxed/simple;
	bh=rRrpAzNPWC0Uc0k4linxzIOnqWxJWK0A8gToje8T8Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py2CSEC7QBVrC5omQdImjrp6Y9yHzWMqyyq2pOMAYh/goEFpv9bbEGNq9GK/5ChLs7VfMCodHZehERLhtpCeQ+iFW4aoED1DAUkL05Reu4viPtbveDa/k64ZXB5nNXccWOntUWSB1xg/w8dBSE7oXSmMsg/RzHPPJxNDUoo4vdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI1WIFeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC52C433C7;
	Wed, 31 Jan 2024 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732876;
	bh=rRrpAzNPWC0Uc0k4linxzIOnqWxJWK0A8gToje8T8Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RI1WIFeA1BRID32Vn6aQlO9JmEGm0zZpPHQ01lEWmaAtZHwLK/KCkl+1PU7PclYWP
	 k5aq04Ark5g8sj9byAMMGF3FQ5bxH2PkC9up/xRDZfs6xPrDmyN51DA9fpPO4y5ASe
	 9cE0AY8T8eRlWYILC1cIGqJpJiRc8tH//1Y8f3vjpp3sJRTSNMbUxIkAt6VO65sWCT
	 R80PrO1I8acir4HwO/73eKIpN2N340cRAlykRpyUqrrO6f8vyiZJgK8PFfKEhI1mOp
	 B878WmpiRPviZH+ztTkhcItCILOy94fmwiKzSMOSMKHfIcFKYtt1Njocmzj4pRJmd+
	 I51eTYaLJ0kFA==
Date: Wed, 31 Jan 2024 14:27:54 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: sboyd@kernel.org, mturquette@baylibre.com,
	krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
	peter.griffin@linaro.org, semen.protsenko@linaro.org,
	conor+dt@kernel.org, kernel-team@android.com, tomasz.figa@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org, alim.akhtar@samsung.com,
	robh+dt@kernel.org, cw00.choi@samsung.com, s.nawrocki@samsung.com,
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	willmcvicker@google.com
Subject: Re: [PATCH v3 4/7] dt-bindings: samsung: exynos-sysreg: gs101-peric1
 requires a clock
Message-ID: <170673287371.2245012.6605138156185654489.robh@kernel.org>
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-5-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129174703.1175426-5-andre.draszik@linaro.org>


On Mon, 29 Jan 2024 17:46:03 +0000, André Draszik wrote:
> Otherwise it won't be accessible.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> 
> ---
> v2: collect Reviewed-by: tags
> ---
>  .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


