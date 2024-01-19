Return-Path: <linux-kernel+bounces-31553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC6832FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5571F23BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802A5731B;
	Fri, 19 Jan 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcLBk6Rg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF856465;
	Fri, 19 Jan 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697035; cv=none; b=RLm7+i+h3ZZ4T+O2BPIaifB5vyQY/mjMkY2vkSHBhZ65c5RKBxoZXdWgErkgM2kG8sTI6i/txHYgE/UzDnYhawTLNEDQtT/bi5PwCt9zKrjL6YvBfYrghnoZxRLinBd6sIKR/VLUjv8U5A6cT6J1lNvdOdvFxCt9NMrjZzvCR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697035; c=relaxed/simple;
	bh=LxukKcj7E7XnJoK97Icxh0TVEc5zfCjPZPAdllnyToM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWJ8laMjgTF25FUmg/Mpz21kfbcwbEiYonR3oO12UEhaAVez3TcdaaqGa6ZKy8/O1VlyHuRh5EYwvJ7F3QUVYwfSbVGotU9TDfV4uteajnLaxdY+BjveGuk5w+7Xl0N0neUGQ8r3xGK8TQajvcMYj8mRkWjPseNrfzvIzIfOIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcLBk6Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AC2C433C7;
	Fri, 19 Jan 2024 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705697034;
	bh=LxukKcj7E7XnJoK97Icxh0TVEc5zfCjPZPAdllnyToM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcLBk6RgAVlSKSdqY7g8AzLqVIwpaYRkOyCMSIhgyDXQtQez/CqYTzk2i1h3gKG6+
	 kYKuQPFl3UN7kmYRMWH+XXqR9WIkHw+3fpkuHL8BdkcONj29NUVG8UbMCF+VWI/Scx
	 FPNcMxaYbl46Etqae2A7KCfomMVhak+nPthFjf6OHU+9gr4yK/11rK1qGo9aIuTHh2
	 o9SlSObEcBpAquFiVvCVGzre3DdrxiAMAc/U6FrNks5NmDxQAXYZ9Be+R6sIOa/+Vg
	 O8zUJQ+QfF76xhh8oe1mUUqxMkgXVl7lfLLXV8hQdNIcyAA8ds/NPjjMzWyjrMxtGT
	 hkOdUtYLp2Cqw==
Date: Fri, 19 Jan 2024 14:43:52 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
	jarkko@kernel.org, tony.luck@intel.com, jgg@ziepe.ca,
	naresh.solanki@9elements.com, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	bhelgaas@google.com, geert+renesas@glider.be, vincent@vtremblay.dev,
	keescook@chromium.org, peterhuewe@gmx.de, robh+dt@kernel.org,
	joel@jms.id.au, patrick.rudolph@9elements.com,
	peteryin.openbmc@gmail.com, luca.ceresoli@bootlin.com,
	andrew@codeconstruct.com.au, andre.werner@systec-electronic.com,
	conor+dt@kernel.org, linux@roeck-us.net, geissonator@yahoo.com,
	johannes.holland@infineon.com, broonie@kernel.org,
	devicetree@vger.kernel.org, gpiccoli@igalia.com,
	alexander.stein@ew.tq-group.com, lakshmiy@us.ibm.com,
	festevam@denx.de, linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: Add DPS310 as trivial device
Message-ID: <170569701502.1007352.2755613869226739924.robh@kernel.org>
References: <20240116183734.3944028-1-ninad@linux.ibm.com>
 <20240116183734.3944028-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116183734.3944028-3-ninad@linux.ibm.com>


On Tue, 16 Jan 2024 12:37:33 -0600, Ninad Palsule wrote:
> Infineon DPS310 is a barometric pressure and temperature sensor.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


