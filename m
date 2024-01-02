Return-Path: <linux-kernel+bounces-14167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE48218AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D401C21687
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2963A9;
	Tue,  2 Jan 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDUxrUCm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC325672;
	Tue,  2 Jan 2024 09:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5821C433C8;
	Tue,  2 Jan 2024 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704186360;
	bh=L2uJ+bAvmhIK5Q/e3x9A1mvcDooM9dY7ZfhWFQ8inSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDUxrUCmByrDI8zmdaiiRee5gx5PTGLC2S8azQkvEa9Pg9TgByQ01GjwEi/JTAETj
	 O3g/DgzRr27BysH9R5q06LIWZQqfkj7hBr6qdjhgxjLkZ9+EalR1UDtRUdB+Y4PVsJ
	 blgin1UhmZjTVHgComZEtdkrytNfC+tI3sUtiAod/+zNEVYsDBwVigOrQri7g6ns4n
	 kcL1JUGSywFl/NS8Rl6a9O+qU7AMBgMt0L8pfLvaoRxzlmmlXS8ykjKP+i8D/qj4YK
	 EvxVHhRXJJRNscAfIi2jXnL3NGLNk4ox1IxezApwLDhnIXZG6gS4SxC29jw0p03T7I
	 OmOJ1tSfNxWgA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKaid-00053V-27;
	Tue, 02 Jan 2024 10:05:51 +0100
Date: Tue, 2 Jan 2024 10:05:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <ZZPR793E3SoIplLw@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-1-13d12b1698ff@linaro.org>
 <ZY6sh8nlEUyEfL0u@hovoldconsulting.com>
 <20231229170334.GA9098@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229170334.GA9098@thinkpad>

On Fri, Dec 29, 2023 at 10:33:34PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 29, 2023 at 12:24:55PM +0100, Johan Hovold wrote:
> > On Wed, Dec 27, 2023 at 11:28:26PM +0100, Konrad Dybcio wrote:
> > > The PCIe GDSCs are only related to the RCs. The PCIe PHYs on the other
> > > hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
> > 
> > No, that does not seem to be entirely correct. I added the power-domains
> > here precisely because they were needed to enable the PHYs.
> > 
> > This is something I stumbled over when trying to figure out how to
> > add support for the second lane pair (i.e. four-lane mode), and I just
> > went back and confirmed that this is still the case.
> > 
> > If you try to enable one of these PHYs without the corresponding GDSC
> > being enabled, you end up with:
> > 
> > [   37.709324] ------------[ cut here ]------------
> > [   37.718196] gcc_pcie_3b_aux_clk status stuck at 'off'
> > [   37.718205] WARNING: CPU: 4 PID: 482 at drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x144/0x15c
> > 	
> 
> Technically this patch is correct. PHYs are backed by MX domain only and not
> GDSCs. Only the controllers (PCIe, UFS, USB) are backed by GDSCs. The fact that
> you are seeing issue with PCIe Aux clock suggests me that this clock may not be
> applicable to the PHY but it needs to be enabled for working of the PHY somehow.
> I'll try to find the details on how exactly it is needed.

Sounds good, thanks.

> But if I get the answer like, "This clock is also sourced to PHY directly", then
> we may need to add dual power domain for PHY (both GDSC and MX).

Right.
 
> > Now, you may or may not want to describe the above in the devicetree,
> > but this makes it sound like you're trying to work around an issue with
> > the current Linux implementation.
> > 
> 
> Adding MX domain to PHY in devicetree is definitely not a workaround.

I was referring to the fact that the GDSC domain also appears to be
needed even if that may possible get in the way when trying to implement
suspend.

> It is the
> actual hardware representation. MX is the always on domain, and when CX collapse
> happens during suspend state, it will ensure that all the analog components
> (like PHY) are kept powered on. Otherwise, we will see link down issues.

But if it's an always-on domain as you say, it should not be shut down,
right? Perhaps you still want it described in DT for some other reason.
 
> But, I heard from Qcom that _only_ on this platform, MX is not backing the PCIe
> PHY. I can correlate that with my encounter with PCIe issues after forcing CX
> power collapse.

Ok, but that seems to imply that this patch is definitely *not* correct
(for sc8280xp)?

Johan

