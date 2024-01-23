Return-Path: <linux-kernel+bounces-35748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99048395E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1DF1C25F59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866F7FBA8;
	Tue, 23 Jan 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ+ESHvH"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9B7F7E2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029586; cv=none; b=or8L7R2DmDQhNQ/1PZRpLesC2MFdQZ3gm7mmGvZlDuEUxBnul2sA2Rxim9viOUuOc79palHrinwUoNoEnZ20vAr2QyhB6mUCSF70NinD3ZU8IVfKC3Z2q7t7C3kapa1ADshp9aZL7HtbkO1J0P1rveeJfEYVqw6jxascaqjsUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029586; c=relaxed/simple;
	bh=UJ0Pt5aqaOsboBaO7LRgeYagbfq3NNfzeyAXSshCX9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzy0nLcJTJ6OEcNUCwulHdFSOcLpOIO16THPbwNJQGN0S/HM/f+qwX09RqHtSfG9DsyHmnRSQ/Z0EmPUlfgVHs4jHBSviTsHBpSTfhLKAAzMQPbGziEorBESXG2dw2Ae8hv5wAwKC1Bcf/oB6Pyz0TUFcZ0MXOYNn4k+a8Wryx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJ+ESHvH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2909a632e40so1418442a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706029584; x=1706634384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2xUo3z3s9ab8bN8UwwU8Rlpi/sAJO42Q10D7NQh75U0=;
        b=KJ+ESHvHTDXtK7J3Eul2LAdisHKBY5S/9tMUbedMtLNNAd7IecvdUFQnYlO56a8y48
         EyqhOA/emyZSYW8dXE4y78Cohi3RD5UUIRn5V4VVn9auxF2MlGAU5Tt7/1PfkJ/jKFsO
         O3HJpMu/GcnJ2a+B8wZMtSTxjtz0/u8RsJhKzZYMRu6L2F4hqbRAeFQ3+7cN2mR4TWNH
         BxQcr0sQ8IyKZEhMVvAHGEk4KqZoDvr0drlI4cJY5dNn2J5BLEaTyETFJgtghrGByXWw
         KAQhRa4gPPlcjN7kNg1lTfrU9Q/d+n0OqmBZkDOVWgDPn2lUvS4V4D+EL97so69NC79i
         RiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706029584; x=1706634384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xUo3z3s9ab8bN8UwwU8Rlpi/sAJO42Q10D7NQh75U0=;
        b=l5WoC4VUgQL33zkhIW+bIEo6YZ28isexFf0uXU046ah2HXaWzM8QxqK7PJu60kXHTD
         xJAcslLjhKUKVgSS3hYe/99BVg5coUY2j20zYF3Ib82r6FqzGTovxbYg08yYotXFHSJi
         Kxbr2O7NzMrC5G7LDMFx5W9nCwsnOmBGO89M+8kyT29TkV/nFtO9DqQfDL/7kBy7vM0C
         kt/vYiUrVD23orlwpieG55A8kgCoZUAMzqGZzrnIlQslOpOzoi6ZQJryr+Nt9h21jbVn
         ro87/PwEk14/qY5mM02SjKZ6ll27eyLf5pjC+3epKY/2kKzxDpjLczx8kozXGnDLb7pC
         oFDA==
X-Gm-Message-State: AOJu0YyZzDCLkdYuDAu5QCKMA8zKjXL2BEJj8MwUCAhH6bRfH922TTyI
	C6Ue0q5UwHXkTQ+0HdjBWva14B7CDcGVnfmG/PwwVAvI1aOEr6dWTmRWzXfrHQ==
X-Google-Smtp-Source: AGHT+IGx6IBvBOrQqDuQEkKbQ1DPWZd+eSGrbU9jAEgx49dV2Bs2F/MYIebq5N7ht9Vj6k50cVTjmg==
X-Received: by 2002:a17:90b:3784:b0:28d:dfdd:3f03 with SMTP id mz4-20020a17090b378400b0028ddfdd3f03mr2786558pjb.6.1706029584036;
        Tue, 23 Jan 2024 09:06:24 -0800 (PST)
Received: from thinkpad ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id dj11-20020a17090ad2cb00b0029051dad730sm9435869pjb.26.2024.01.23.09.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:06:23 -0800 (PST)
Date: Tue, 23 Jan 2024 22:36:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp: Fix PCIe PHY
 power-domains
Message-ID: <20240123170614.GH19029@thinkpad>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-1-13d12b1698ff@linaro.org>
 <ZY6sh8nlEUyEfL0u@hovoldconsulting.com>
 <20231229170334.GA9098@thinkpad>
 <20240122172528.GE3176@thinkpad>
 <Za6ns-xhN3N-cmIr@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Za6ns-xhN3N-cmIr@hovoldconsulting.com>

On Mon, Jan 22, 2024 at 06:36:51PM +0100, Johan Hovold wrote:
> On Mon, Jan 22, 2024 at 10:55:28PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Dec 29, 2023 at 10:33:34PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Dec 29, 2023 at 12:24:55PM +0100, Johan Hovold wrote:
> > > > On Wed, Dec 27, 2023 at 11:28:26PM +0100, Konrad Dybcio wrote:
> > > > > The PCIe GDSCs are only related to the RCs. The PCIe PHYs on the other
> > > > > hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
> > > > 
> > > > No, that does not seem to be entirely correct. I added the power-domains
> > > > here precisely because they were needed to enable the PHYs.
> > > > 
> > > > This is something I stumbled over when trying to figure out how to
> > > > add support for the second lane pair (i.e. four-lane mode), and I just
> > > > went back and confirmed that this is still the case.
> > > > 
> > > > If you try to enable one of these PHYs without the corresponding GDSC
> > > > being enabled, you end up with:
> > > > 
> > > > [   37.709324] ------------[ cut here ]------------
> > > > [   37.718196] gcc_pcie_3b_aux_clk status stuck at 'off'
> > > > [   37.718205] WARNING: CPU: 4 PID: 482 at drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x144/0x15c
> > > > 	
> > > 
> > > Technically this patch is correct. PHYs are backed by MX domain only and not
> > > GDSCs. Only the controllers (PCIe, UFS, USB) are backed by GDSCs. The fact that
> > > you are seeing issue with PCIe Aux clock suggests me that this clock may not be
> > > applicable to the PHY but it needs to be enabled for working of the PHY somehow.
> > > I'll try to find the details on how exactly it is needed.
> > > 
> > > But if I get the answer like, "This clock is also sourced to PHY directly", then
> > > we may need to add dual power domain for PHY (both GDSC and MX).
> > > 
> > 
> > So I answer I got from Qcom is that this clock is only applicable to the PCIe
> > controller and not PHYs. On some platforms, there is a separate PCIE_PHY_AUX_CLK
> > coming from GCC that is used during L1SS state. I think that caused confusion
> > while adding PHY support for followup platforms and folks just used PCIE_AUX_CLK
> > since they couldn't find the actual PCIE_PHY_AUX_CLK.
> 
> Thanks for sorting that out.
> 
> > I've prepared a series to fix this mess, but I want to know how you end up
> > seeing the above "clk status stuck at off" issue. Is there an actual usecase for
> > powering up PHY without controller or you just experimented with it?
> 
> As I mentioned, I ran into this when experimenting with how to enable
> the "companion" PHY for four-lane support. There shouldn't be any use
> case for it (apart from using it to determine that the current
> description of the PHY resources is incomplete or incorrect).
> 

Ok. I tested by enabling the PHY clocks during qmp_pcie_clk_init() without
PCIE_GDSC. It worked for one instance of the PHY which doesn't have
PCIE_PHY_AUX_CLK, but for the PHY instance with this clock, I saw the same "clk
stuck" issue. Then checking the internal documentation revealed that this clock
needs PCIE_GDSC to become functional >.<

So to conclude, PCIE_AUX_CLK belongs to the controller and it needs GDSC. And
PCIE_PHY_AUX_CLK belongs to the PHY and it also needs GDSC.

I will just submit a series to remove the PCIE_AUX_CLK from PHY nodes. Then
in another series, I'll remove the GDSC for PHY instances that do not require
PCIE_PHY_AUX_CLK.

Hope this makes sense.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

