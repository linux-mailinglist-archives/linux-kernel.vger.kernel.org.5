Return-Path: <linux-kernel+bounces-123464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F78908FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62ED91C27962
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F01384A4;
	Thu, 28 Mar 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho1w3mPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21D137C31;
	Thu, 28 Mar 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653559; cv=none; b=X03vk0Zq2DaV/6IlJV1QIY6rhGZCnTWsAygSuujuX6SY4ZNIN14S9gfQfv7pdiEBeM5jTK/Ssn/p53eCaMssbtfzfZ0P+faHv4COXzyci1R7pNk/MAet3CIdZspjfMkfXjM1aR+MfJhJW0PhljnxqW2oX7Fnbh+MAVF+zYDAly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653559; c=relaxed/simple;
	bh=DMJGH/uzvLHpdyQp8bAx813mggvP9W/91i5vYKleDCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z3vTVrDvhvt5w6/hQr8zXk9/Dn+YMesXbe/yAoSVg6weSpK46BX3nSuaoAyyPh0isBCbvEa+dHWGDb3bo8FMIcPOvUmhdC3EkKRSfrGBFAhWPuDohZiCuVlUBHbGXp0lZujOaQLBQxjUC6P9RN5wpcOJ1ojTO6jWhgBru80cjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho1w3mPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C905C433F1;
	Thu, 28 Mar 2024 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711653558;
	bh=DMJGH/uzvLHpdyQp8bAx813mggvP9W/91i5vYKleDCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ho1w3mPsyO2jwlK8SvUXLnbn/aa5FWGFIkf9w2Ecygsn/DM+rM5OcNcR/+25W14z4
	 D6+/dlshJ4jo1z8xhRUc4Vu+DRPHtjUOIPqpGTCxrEv31Z1Fkn1eBVLMOChTOGD5vP
	 +P9hq0VPTPAZvedawyqyJHzp/Y1GdpBc4u7+7ZHjQYF+upna/IhAkg2w4p9wzYP/Xr
	 7Bmz7qJMDTiMJQ5P0ag6ZhTvjBKlRd0+6xcKv89A2xTP+x/BCJwmmsCoQKKHCq1RGf
	 Nr6FDQk6gELz0lQmv5er4eLoK277tyO3gptTtYMz+sEjs0PTBOjBlNwd89Ksf8tUtK
	 bBMF2ByiaHrsw==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240220-phy-qualcomm-eusb2-repeater-smb2360-v2-0-213338ca1d5f@linaro.org>
References: <20240220-phy-qualcomm-eusb2-repeater-smb2360-v2-0-213338ca1d5f@linaro.org>
Subject: Re: [PATCH v2 0/2] phy: qcom: eusb2-repeater: Add support for
 SMB2360
Message-Id: <171165355397.152390.11176206543554297500.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 00:49:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 20 Feb 2024 21:41:58 +0200, Abel Vesa wrote:
> This patchset adds support for the eUSB2 repeater provided
> by the SMB2360 PMICs.
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for SMB2360
      commit: f8d27a7e0ae36c204bffe4992043b2bb42ca8580
[2/2] phy: qualcomm: phy-qcom-eusb2-repeater: Add support for SMB2360
      commit: 67076749e093ffb3c82ba6225d41c88f8c816472

Best regards,
-- 
~Vinod



