Return-Path: <linux-kernel+bounces-13148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB0820053
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F178B1F22167
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688CE125C0;
	Fri, 29 Dec 2023 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFGfPfGe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5BF125AB;
	Fri, 29 Dec 2023 15:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D96C433C7;
	Fri, 29 Dec 2023 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703864626;
	bh=cHBszsE5H32BHTyrznenF9Yp/nF4ekKNzOaOvnlvEqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFGfPfGePCynPG1iwxs8Brzg3+CXnuNzs5/CI7W71aRuI1tmsrzDyx9Ftw6YeIlVR
	 gxDtFcuCbigwwm8jWN7QsxANVQF0J5390xMh1JkrhA3nT1fY9bBlRGRWGCTp1Gbi2V
	 idG6joyQa004AoQd1UfdijsBzEf74iKZvLVVE85nq5Lu5XCPL4e/84t5rheMUoMH22
	 rdwzXhzsfR8U6SgcdoE40+xDCG7I4xuL5Keq1227fzykiIwxiQjYwv1hzAWwPRNp9i
	 Upqh1iH2nodqa0+dHUeZNg8/KO3QNlsKXoL7aXIEZ1fnYD6eTghy90Lod2LrpUH73z
	 mqfTenABoRfkA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJF1N-0005jc-2J;
	Fri, 29 Dec 2023 16:43:38 +0100
Date: Fri, 29 Dec 2023 16:43:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Message-ID: <ZY7pKZ40oMQPIzGh@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
 <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
 <b730bf22-fa3a-4720-9fd1-79d2207d6812@linaro.org>
 <ZY7I1brn0chtOzis@hovoldconsulting.com>
 <11aa0b82-ddab-4b65-8f49-54e15e0ce44e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11aa0b82-ddab-4b65-8f49-54e15e0ce44e@linaro.org>

On Fri, Dec 29, 2023 at 04:05:18PM +0100, Konrad Dybcio wrote:
> On 29.12.2023 14:25, Johan Hovold wrote:

> > On Fri, Dec 29, 2023 at 02:06:26PM +0100, Konrad Dybcio wrote:
> >> On 29.12.2023 14:01, Johan Hovold wrote:
> >>> On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:
> > 
> >>>> Fix the power-domains assignment to stop potentially toggling the GDSC
> >>>> unnecessarily.
> >>>
> >>> Again, there's no additional toggling being done here, but yes, this may
> >>> keep the domains enabled during suspend depending on how the driver is
> >>> implemented.
> > 
> >> No, it can actually happen. (Some) QMP PHYs are referenced by the
> >> DP hardware. If USB is disabled (or suspended), the DP being active
> >> will hold these GDSCs enabled.
> > 
> > That's not a "toggling", is it? Also if the DP controller is a consumer of
> > these PHY's why should it not prevent the PHYs from suspending?
> 
> As far as I'm concerned, "toggling" is the correct word for "switching it
> on".. 

Hmm, this doesn't make sense. The PHY power domain will be disabled when
the PHY is suspended, regardless of the DP controller. But sure, a
system with USB disabled, would end up with the USB GDSC on.

> While the PHYs are indeed useful for getting displayport to work,
> the USB controller itself may not be necessary there, so enabling its
> power line would be a bit of a waste..

Sure, if the PHYs truly don't need the USB PD then fine, this just
doesn't seem to be case for PCIe, or at least the picture isn't as clear
as your previous commit message suggested.

Johan

