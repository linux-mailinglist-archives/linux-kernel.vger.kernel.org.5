Return-Path: <linux-kernel+bounces-132147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C2E899044
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D5C1F213F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023E13D287;
	Thu,  4 Apr 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPQw2N2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1913D268;
	Thu,  4 Apr 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265817; cv=none; b=aQI0vrPbRKTjVFCFVvNRUgiBH/VZ1YlaZi93NCq6HMLAsH0oSE6wQ/mVnBUSRN5xJr6+Mv3b6jCTs4dlBuWCHXRzAXG4i7+JQrCedUlrJEpIWu0HAaakGej2nIZ0Vtuf7mh5MMydB2qnEdHNq3hTvhO27ozWs0to0AtHpzeNkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265817; c=relaxed/simple;
	bh=c5zAjmoJZmt72yR4k8XASOxNoLs2SQoqSwHDS65AUTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXORy2nZXAibhHObOT3CODXv4inURlEBwxsUJVTMlI1lTOjPv2A7wohFOxxVyFvNamA/OsoLtXK+ctT8xlOPJlymlDuiRSeSRCnswCcGE+rjeaTV0WGxbPVJd+bXYHC+Ty+mYkk7LmWAwbAPiVtbcsY+XaP0O5jhYg1GAZk2/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPQw2N2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773D0C433B1;
	Thu,  4 Apr 2024 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265817;
	bh=c5zAjmoJZmt72yR4k8XASOxNoLs2SQoqSwHDS65AUTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPQw2N2DPWrJ6+Ld+p13NFJkLMcZ3PYoIFG5MHtGqFB9WJIFfkcVsgAnDYLAZ7Moc
	 gSAnDufxoFm7D2QAS2F29Lh7qSBB1SfI28j6J6GR44LWtGNhCfw0bhUmAb6UKHqc7o
	 4JdC71yK48Dvs2DwozCb+aLpH4mQb2UKMK61v8/1fdedDxNlwFSBI+e2NYbM+arbAf
	 /kcfYaZwALla7oFpZL545Gmato9khf96L0vRORhPY/DRiGlI7VUcU0TDmfmbdHrjmS
	 2WfSi4OZ31BCmGfR8/EAPZOhrP3cQIpqPYcAX0Sx5l4FAT1AbAWM5cKoSndUZdue4M
	 g9oa5B3FkGsmQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: fix usb interrupts properties
Date: Thu,  4 Apr 2024 16:23:03 -0500
Message-ID: <171226578681.615813.7106670457726286494.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org>
References: <20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Mar 2024 09:53:06 +0100, Neil Armstrong wrote:
> Update the usb interrupts properties to fix the following
> bindings check errors:
> usb@a6f8800: interrupt-names:0: 'pwr_event' was expected
>         from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:1: 'hs_phy_irq' was expected
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:2: 'dp_hs_phy_irq' was expected
>         from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:3: 'dm_hs_phy_irq' was expected
>         from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names: ['hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too short
>         from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: fix usb interrupts properties
      commit: 9f42f7380f6757ce7f0cab5bad56fb350941d32b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

