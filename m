Return-Path: <linux-kernel+bounces-1623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDD815104
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70570285C25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0F45C16;
	Fri, 15 Dec 2023 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJrzU5Ko"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153845BFE;
	Fri, 15 Dec 2023 20:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D101C433C7;
	Fri, 15 Dec 2023 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702671720;
	bh=pI2fxOT71cP2ivmIh+q5o/w/kpsi6teiRLOD72it0Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJrzU5KoTIW+HShSQYwbkxJPwTWEvjgAHRTYA0oMlaJyRQt9GRF0xRTWx0YfE/w/H
	 QXQOEKIpIPQ02dYda7aFikVE3IViwfZ1Hlgv//o4pvuSgKqYokmm/H8uXa/GzblW8N
	 EHs8qQE/yw78eqw0PhFXmOzSfqnlhhonF8AlCA9/tKzOKPtzAScY1OlnI0b2qn9+WA
	 uMWFf/RIA6qJn1WH+rGi64XeiTt+cGjXLvK1SrQDS+zFcxotPDDZoXLxR7wmkNwpZK
	 UVUYsiXuODjoaQDKaciEW4/Zh1vWwzCdtKKZBZ/Li3lxDkkrQrGwvA2IoQdXScl8gM
	 o2l83j0l4CEYg==
Received: (nullmailer pid 328701 invoked by uid 1000);
	Fri, 15 Dec 2023 20:21:58 -0000
Date: Fri, 15 Dec 2023 14:21:58 -0600
From: Rob Herring <robh@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Fu Wei <wefu@redhat.com>, Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/8] dt-bindings: gpio: dwapb: allow gpio-ranges
Message-ID: <170267171586.328597.4361294916580351710.robh@kernel.org>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-5-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215143906.3651122-5-emil.renner.berthing@canonical.com>


On Fri, 15 Dec 2023 15:39:02 +0100, Emil Renner Berthing wrote:
> Allow the generic gpio-ranges property so GPIOs can be mapped to their
> corresponding pin. This way control of GPIO on pins that are already used
> by other peripherals can be denied and basic pinconf can be done on pin
> controllers that support it.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


