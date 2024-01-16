Return-Path: <linux-kernel+bounces-27585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6882F285
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2441F24823
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE131BF28;
	Tue, 16 Jan 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RosJsvoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96581CA80;
	Tue, 16 Jan 2024 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EAFC433F1;
	Tue, 16 Jan 2024 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423201;
	bh=ZbJj5nuP9rttxf9BhEtuz8jE4n341pZWyh0MY1kmfEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RosJsvoRLA5GdJJbyKD2Fn7S55LTEEB42yjdR+spcsbL07xQycjBs48LYaoz4DXg/
	 Mz+pOO7lOOk4RCc+deNkgKJZ3BDF/neIDITpz6t/KFyzanl1Fml/zBf/imSI1gCeYG
	 AkctpitWxGbIM/4depQqBY2zHTMxt6lESIqaAK5HMuY2Vr085RP5KCkmr5SmSyykdp
	 /NHbNorongfBUdNxs0IbuU+m18ZxJdO0re1o9eEawvzrUvoPhTGtFkYnnTafTGlPsN
	 iCDrTzNpA+EIqwA3nKTkwUv+Td3X7EOOxgFiY11gDLcAdH9j7FcaryOo2MWMkRfOmL
	 Oik83o3D86XxA==
Date: Tue, 16 Jan 2024 10:39:59 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: nvmem: add common definition of
 nvmem-cell-cells
Message-ID: <170542319882.93436.3353325004500279691.robh@kernel.org>
References: <20240109213739.558287-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109213739.558287-1-krzysztof.kozlowski@linaro.org>


On Tue, 09 Jan 2024 22:37:39 +0100, Krzysztof Kozlowski wrote:
> Linux kernel NVMEM consumer bindings define phandle to NVMEM cells
> ("nvmem-cells"), thus we also want the common definition of property
> defining number of cells encoding that specifier, so the
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Reported-by: Michael Walle <michael@walle.cc>
> Closes: https://github.com/devicetree-org/dt-schema/pull/89
> Reported-by: Rafał Miłecki <zajec5@gmail.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20221121105830.7411-1-zajec5@gmail.com/#r
> Closes: https://lore.kernel.org/all/bdf7751b-0421-485d-8382-26c084f09d7d@gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/nvmem/nvmem-provider.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


