Return-Path: <linux-kernel+bounces-8830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2681BCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1B21C25EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CA64AAA;
	Thu, 21 Dec 2023 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd4eOicP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7E64AA6;
	Thu, 21 Dec 2023 17:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180C3C433A9;
	Thu, 21 Dec 2023 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178977;
	bh=GiGjWiCFjhYD3COXF7UOcoSeBaRUyyIV4TEwJQY0BoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dd4eOicPTjyKWE5Y7eHNki5GqNBHqoB7XQGi+Z7rv3DgxZZwIWIbvGULCgA5ieKU+
	 XeRWI6ZYdDgr+QkgyZEr2H6A3x3ctfAqsAQyO2/IPaeQVQH3eAg9AxCngSV86MCw6A
	 kSaUxHLKzpnYig2RdnvomB2+FUsz7NvdptMfI451GJLlYFYXhNu0PvZYjW8gmtqDHD
	 NDNPJBQRBtpOkpwJH9MqOWQg6I0Qyh1Zmne+wsIoOomz1g3aF4LcgPPx7Qjgc7fjsl
	 4zLLXGUtmpnqSujBZ2FdCZmac2/haOTYQIsG/xIHEmFM8n/HcYQ1/vkvTBKYoMzMXD
	 b2fPpluog7iyA==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v3-0-273814c300f8@linaro.org>
References: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v3-0-273814c300f8@linaro.org>
Subject: Re: [PATCH v3 0/2] phy: qcom: qmp-usb: Add support for X1E80100
 USB3 PHY
Message-Id: <170317897267.712473.15138229989572768698.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:46:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 07 Dec 2023 14:34:10 +0200, Abel Vesa wrote:
> This patchset adds support for USB3 PHYs instances found on X1E80100.
> It depends on the v7 register offsets added by the following patchset:
> 
> https://lore.kernel.org/all/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org/
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add X1E80100 USB PHY binding
      commit: c5ffffd714373e7c6b39d3b005dbfbaadbbb4d2d
[2/2] phy: qcom-qmp-usb: Add Qualcomm X1E80100 USB3 PHY support
      commit: 2daa9555ba9858c29b9734b3a104c338b718feab

Best regards,
-- 
~Vinod



