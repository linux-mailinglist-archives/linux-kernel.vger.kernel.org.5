Return-Path: <linux-kernel+bounces-166072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886938B958E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8CF1F2202B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A844384;
	Thu,  2 May 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aJW/qp8H"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639063FB94;
	Thu,  2 May 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636070; cv=none; b=TxLVt46p50UCMDxNBk/mge9NkZq0iwCfzjBlqYvZ6yM1HG4U7eMAWaLykibpoNMZiryuSxsni+56QzxJ7DqD+HiE0iBzTRX2rmZtjleVmM3vNDEiKEdQ3dHUDXUfB8OuQhVCp3Gcg743p5i8vZ5oCKf3/etEfQIEkxANFadLdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636070; c=relaxed/simple;
	bh=4fidK45K76RPQVzq6DR8JC/iRRxUfnDxLhJ5XYetRIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RORajjV3OLs1mRbCERRFkiof7Iyn2V0c12L9zJrrN7p8Df/+T+XipGwmko+z0LQNXItWW1EJkhkUtVOWapuCDvgMyexBlIoxU/3NcYr/5t/aJNM3Me8IgG0m+sC7S1BjZ+lUzh/vFH21S/A0aB6NT0sX5rIwEIExf1tgRRfPD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aJW/qp8H; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 842B1FF808;
	Thu,  2 May 2024 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714636066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8SwW+ELJF0Fre9JQp39dmXVDBVpvYrr5lnpvWL62nM=;
	b=aJW/qp8HM5GIcA9zma+Wm/wS7z8pqOauqHzMTapIbt69hXq7W9aTboL+TUAXfFLk6jS1yS
	iRYmFvhicQFh6JLO7Q8himwCobUqRtb8f4XcX13AH9qKj89VT8kx96QLSe27cX/VHEGHdo
	RCS6P2NdXJV088Ay2x0sbC2BYTwsofbZ5G4erAVAQTQ+2nQjfg27fn1WF+cj0MrdRB9ooS
	KB43b7EFfrqGmUAZr1L055xgMJELD9QgTWEm8Ecw3TWZOfCCHrtS/JTQ1Wpng/EWFGdjZJ
	+YQFO+mbqEo2CZ+N7KvTzD/QEQwQaMvW60PjA2pUgrVTCfp8lNjDj7/0R2Efcw==
Message-ID: <9ad3ab76-812f-413e-826d-97545c403138@bootlin.com>
Date: Thu, 2 May 2024 09:47:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/4] clk: thead: Add support for T-Head TH1520
 AP_SUBSYS clocks
To: Drew Fustini <dfustini@tenstorrent.com>,
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
 <20240426-th1520-clk-v2-v2-2-96b829e6fcee@tenstorrent.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240426-th1520-clk-v2-v2-2-96b829e6fcee@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 4/27/24 2:10 AM, Drew Fustini wrote:
> Add support for the AP sub-system clock controller in the T-Head TH1520.
> This include CPU, DPU, GMAC and TEE PLLs.
> 
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> Co-developed-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

> ...

> +void ccu_disable_helper(struct ccu_common *common, u32 gate)
> +{
> +	if (!gate)
> +		return;
> +
> +	regmap_update_bits(common->map, common->reg,
> +			   gate, ~gate);
> +}
> +
> +int ccu_enable_helper(struct ccu_common *common, u32 gate)
> +{
> +	if (!gate)
> +		return 0;
> +
> +	return regmap_update_bits(common->map, common->reg,
> +				  gate, gate);
> +}
> +

Both of those functions are only used in this file, you should probably 
make them static because otherwise, the compilation process will prompt 
a "missing prototype" warning.

Thomas

