Return-Path: <linux-kernel+bounces-166070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353D8B9588
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C79B222D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724536B1C;
	Thu,  2 May 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V/ZI+t0O"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549E2869A;
	Thu,  2 May 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636065; cv=none; b=BhJC+4WbB8DEVNcEVt/5x7TrGLgAGBJt+p5jX7KkAGj1o03LXN3D0UWfdK9ewiHdSafI/ib3NVP+/oiurTEVH6k8cT5sy481YROc94XmRlYs3vz01uYSB/FAQAD6RgOgPrtgHxJvnhiIFgZ2g36UZhaJsMOnav3+TTptZb/lH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636065; c=relaxed/simple;
	bh=0pGourV7blE9H0c2oiuQNQvm2fp+4EfYQghN+fM42kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mo+FYU/UNhr7HfXpqnKyQSuDXbl0Nje8/3ivCAQh77C1eNgsR/kZrvOGscfYk+EJH7TZRkJyQO1uWBOypL/QA4uDrviuv7ThDY2jqVdkHYmamRMvHzw6s1vlqbILeRFD8xejkHIPI9nVVd4WqP73wjm0dzfH2RrN/fG+V0WfrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V/ZI+t0O; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C012CFF802;
	Thu,  2 May 2024 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714636060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl4f2gTcxSpdt9aNsQkLAMEx3yFNLiblqv3A5NbuTPQ=;
	b=V/ZI+t0OamjlUxNgd7Hs9zCPwvWCm5aoomKRH11nPihuCcrPMHbe8LaZbuzs4GTx+ComAm
	wRIJgZnO+2vY8iARc7N3BjCIa3Q9ciTeJtPtnIBx8pPTENzJHKE4qYO5SxowU5IBW7WeVJ
	by7tfYEkcesU17vpJzPxSTgMPpwMIfdjA7nYm8Fhu1ErEIH3Pakp8BrA8q9XZEdhLH0Iqj
	RGTL2M68bCza7EYNLpq/rt2sjaoTOT00iR/LcLcsTsMz5cMFF4iHdPWagzKARFwfFqWhPf
	xHLgd5/YBlvxNEyJfOsN0xOBUCauJKDivRUiBNW60NRg88d0pJci6Wo8Oludfg==
Message-ID: <588fb903-e5ca-43af-9258-c14aaab6c732@bootlin.com>
Date: Thu, 2 May 2024 09:47:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/4] clk: thead: Add support for TH1520 AP_SUBSYS
 clock controller
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
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 4/27/24 2:10 AM, Drew Fustini wrote:
> This series adds support for the AP sub-system clock controller in the
> T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
> 2023 [2]. Jisheng made additional improvements and then passed on the
> work in progress to me.
> 
> Changes I made from the original series:
>   - corrected the npu_clk enable bit
>   - deduplicated CLK_NPU and CLK_NPU_AXI number in header
>   - fixed c910_i0_clk reg typo
>   - fixed checkpatch and dt_binding_check warnings
>   - rebased on v6.9-rc5
>   - revised commit descriptions
> 
> Changes since my RFC v1 [4]:
>   - squash the header file patch into the DT schema patch
>   - describe the changes I made to original series in the cover letter
>     instead of the individual patches
>   - fix my typo in my email address
> 
> TODO:
> I am again marking this as an RFC because there is feedback from v1 that
> I have not yet addressed. I am posting what I currently have as other
> patch series like the TH1520 I2C driver [4] could use the clk driver.
> 
> Emil commented that the input predivider is not handled correctly in
> ccu_mdiv_recalc_rate(). The PLL multiplies the input frequency and
> outputs "Foutvco". This is followed by a post divider to produce
> "Foutpostdiv". However, some clocks derive directly from the "Foutvco"
> Emil suggested this should really be modeled as two different clocks.
> 
> Emil aslo suggested that the rest of the clocks in this driver seem to
> be generic gate and mux implementations that should probably be replaced
> with devm_clk_hw_register_gate*() and devm_clk_hw_register_mux*().
> 
> I'll look to address the above issues in the next revision.
> 
> Thank you,
> Drew
> 
> [1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> [2] https://lore.kernel.org/linux-riscv/20230515054402.27633-1-frank.li@vivo.com/
> [3] https://lore.kernel.org/lkml/20240110-clk-th1520-v1-0-8b0682567984@tenstorrent.com/
> [4] https://lore.kernel.org/linux-riscv/20240425082138.374445-1-thomas.bonnefille@bootlin.com/

Thank you ! It works on the Beagle-V Ahead :)

Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

