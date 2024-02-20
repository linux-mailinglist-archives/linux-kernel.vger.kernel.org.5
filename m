Return-Path: <linux-kernel+bounces-72490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3A85B42A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13394B24190
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A25BAE3;
	Tue, 20 Feb 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fASrNh/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEE1C2E;
	Tue, 20 Feb 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415089; cv=none; b=IeZeMBsfQzU0SoyL+Sj6fYjAzqJn0dRm2Sv4rP60fmWUyxziuyzjz/WNJC/Ji09q32LOr7wKWi4obILH1cDrvGTReiIdGO4AwnMcZvM3TLS/KLxZpYmS3q6M665oKhKLOM4i/WgqF83TWJOXhTgs+wDO0TxjoIyGKu40py0d+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415089; c=relaxed/simple;
	bh=MzeNzCxDOWh7u70QrPcsPXMVJOMr1p+L/WUmSr8d/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMKP7ocm4pW4Z+nitmYeKD4Jrzl1EQBXqw7j9isomEfoGH0sbDJ5XsINFKTqji9wYLTqadGbbBDlFiZXpnHRL7nsmOwArAgesvL7P7VNmDzNCwKzF4evDrgC0HPzJfg/68L+5cg4VZZT7e1dfDfozLvWbLwlleAbB29Ma5PYqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fASrNh/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F13C433F1;
	Tue, 20 Feb 2024 07:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708415088;
	bh=MzeNzCxDOWh7u70QrPcsPXMVJOMr1p+L/WUmSr8d/wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fASrNh/FGvSKlJLhp6CTvQm/rAKcuiuMYnqCQgHRpOX3Orvystdj06x85XKGKadIe
	 rklEDxVyAk3xK/d1UUK8540dDCqHnSq0OVhOJxI9C05NVVRJPCvAgb6cn5IVN6c8Nz
	 Xv4gFm/U+f32SuRANUQyJm52B98PThMdp0+TtG1LMdYyQHoCWTDgQ4Lybj15McbBvu
	 TAkK2cyGYaStatf1e0FPjEBBItIMAXIBsmbsoqz5LGt4wrjeBAyryK6jecDIrjuSLy
	 XbJyO7jfRlhfcwE9JHpq0qDsLr3t/3ZFMdAWL6NsmF9MECK1/n5B+5+n9J0V/R5pnd
	 LIYgnxEGNhNCw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcKo3-000000002Ey-2PWm;
	Tue, 20 Feb 2024 08:44:47 +0100
Date: Tue, 20 Feb 2024 08:44:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sm8650: Add msi-map-mask for PCIe nodes
Message-ID: <ZdRYbyKxtkIqkpRd@hovoldconsulting.com>
References: <20240216-sm8550-msi-map-fix-v1-1-b66d83ce48b7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-sm8550-msi-map-fix-v1-1-b66d83ce48b7@linaro.org>

On Fri, Feb 16, 2024 at 10:35:21PM +0530, Manivannan Sadhasivam wrote:
> "msi-map-mask" is a required property for all Qcom PCIe controllers as it
> would allow all PCIe devices under a bus to share the same MSI identifier.
> 
> Without this property, each device has to use a separate MSI identifier
> which is not possible due to platform limitations.
> 
> Currently, this is not an issue since only one device is connected to the
> bus on boards making use of this SoC.
> 
> Fixes: a33a532b3b1e ("arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

