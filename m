Return-Path: <linux-kernel+bounces-152634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0258AC1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5031C208A1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23F502BC;
	Sun, 21 Apr 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT9pSU3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8608502A2;
	Sun, 21 Apr 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738585; cv=none; b=CnLQ5zsMbym1aOZIkl7U7HCmJSeTowirwFziT1P82OXmMJfDOY4v5emZ3k9T3tvxwwdtaCa9S5qL/VDtzP47/RuNQlI69LWUpyqgtbNKHPkdDPLetxXHHVu4CX5G3mnPg+wxk+ZqHTu6fvIGd8+4LM67jwvzLtPkm6iMWbEZVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738585; c=relaxed/simple;
	bh=Icxr00eu7phRmjhceitMWHQ47bKw4KMtmpSLr+rgzbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M27KxzMslErmI6R4wNpAIRUfFbID3gYiltdxG6SGLMJVl+G/sGqugyCQcfnw+eoygORq3titCYqqHtzrsjIQzyzfTKokO67eBRKZEFOJu2CqiAcJroCw5KLJk5JCdxnWXJzJdkUAuBoZIRn1dJYDLaOc3fFSH2lCug/v6LJv/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT9pSU3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7CEC32782;
	Sun, 21 Apr 2024 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738585;
	bh=Icxr00eu7phRmjhceitMWHQ47bKw4KMtmpSLr+rgzbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jT9pSU3VCyxvNADkWNW8Nzgxr0WTXORPt/9Y3RFK86501vYqYVFWQon/jsX42hFRG
	 LM83r2a6UYSTjkGb5QE9b14aXSVMmlJkR2PA0nPSOh7k7RG2q4xJmKjYzknSwUEMyg
	 TTUmnHmJ3wBsEUBmCqFiaKYU/IrYW+wzRTAI5xsWi6TDrkOIE8x9GvthQhIoLqFZp3
	 EoGekpaaXldjGTIXx2rnN+hMdkLHBnE+BA72JUR++ZyX3EDBFWUVY97Tiz/0jJz/+f
	 knMLRGShIWbWRiI03PAFDqz11Sp0znceuEkhXkFHxiJF4FoGXEyb7s+8WYvx4c9Y/K
	 0X2BrCMrvHWHg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH v2 00/21] Add PCIe bridge node in DT for Qcom SoCs
Date: Sun, 21 Apr 2024 17:29:19 -0500
Message-ID: <171373856771.1196479.2864036969713172935.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 16:46:20 +0530, Manivannan Sadhasivam wrote:
> On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
> for each controller instance. Hence, this series adds a DT node for the
> PCIe bridges across all SoCs.
> 
> There is no functionality change with this series, but the PCIe bridge
> representation in DT will be necessary to add the DT node for the client
> devices like the one proposed in power sequencing series [1].
> 
> [...]

Applied, thanks!

[17/21] ARM: dts: qcom: ipq8064: Add PCIe bridge node
        commit: 0c4d19b125401957123989a25094972cf0e77670
[18/21] ARM: dts: qcom: ipq4019: Add PCIe bridge node
        commit: ed9b196418d4e2fa4f6c27b61a92c2038e1ba04d
[19/21] ARM: dts: qcom: apq8064: Add PCIe bridge node
        commit: 27cb9eccf94cb163f9bf3b945f249ab7c42861db
[20/21] ARM: dts: qcom: sdx55: Add PCIe bridge node
        commit: 669841a2eff4c0132841dea3ae40d9148a36f257

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

