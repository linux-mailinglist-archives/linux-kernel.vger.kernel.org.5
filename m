Return-Path: <linux-kernel+bounces-36493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4983A1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D875A1C22D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA9F51A;
	Wed, 24 Jan 2024 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIR0S5Hv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B8E56D;
	Wed, 24 Jan 2024 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075966; cv=none; b=cqUSfgasxmLAA/NpTKJ5yJEAJeREcJ5qe/lpueq0WxDJGhSdA0tTmiDrBBJ1eShKzFtXMzyJg68LFbFBMJApeLV+efe1bXe91QJ7P1deYjHs/1xSBNljbn+MW3eK28bB1xbag7+OEUB+00I2nLcQ3rC7ovq1f/4H6obVrRArMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075966; c=relaxed/simple;
	bh=631HMa6xNAhYwJIfudu1AsAFw9VRD5Ibtmd4lCPDg/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XqEus/lg1g3XP47xmhVfyfg8XJ+84XESb+OtmgpFmLBQtY8Uw9S45PPWbZzN3b5v7nAqawsBKBfWzP+hkd7I8ZH7U/cx6vh3JPHNs1U+i/FLTcqoqucXzIFpj9uD24Wa609CdY4vJzKNw2eixwgkJgyLGMdl4nd8WxsGgti9CRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIR0S5Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C55C433F1;
	Wed, 24 Jan 2024 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706075965;
	bh=631HMa6xNAhYwJIfudu1AsAFw9VRD5Ibtmd4lCPDg/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LIR0S5Hv9vFD7nHnqcmfi6qyNbhB422UTzd9hBM9MKIMpe6tGippqQLeIhOtaAcsc
	 HUrO5GXzKwb3Ve+oUA1ReL9KxN5JqXrlbRPBIKE68aoaSICbI3xKH6ucHB/td/O2Dt
	 iKaJZWOjz022A52TTjDaFwvTd1pFeG6PPks67QJ8udSPy/ATR9kWz8Uy+ZpDEn8Yuc
	 5zEsYGPMFq0OZnWyF8pl78aYrAZr+ffw+NwTLkwLCior520wZVt8lDyDwzDRtkEn2t
	 nTZnoySm4ZQNuqtJb4gqWYyA5jo1aQizjEJU7QgpgfrchhyDP+0zEnwvKXf1YjElw4
	 gCnE/BqUx3Wvg==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Mantas Pucka <mantas@8devices.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1706026160-17520-1-git-send-email-mantas@8devices.com>
References: <1706026160-17520-1-git-send-email-mantas@8devices.com>
Subject: Re: [PATCH 0/2] phy: qcom-qmp-usb: fix ipq8074/ipq6018 USB issues
Message-Id: <170607596328.395031.4364747820297354621.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 11:29:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 23 Jan 2024 18:09:18 +0200, Mantas Pucka wrote:
> Two issues were found in ipq8074/ipq6018 USB support. Sending as series,
> because fixes touch the same code.
> 
> Mantas Pucka (2):
>   phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
>   phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018
> 
> [...]

Applied, thanks!

[1/2] phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
      commit: f74c35b630d40d414ca6b53f7b1b468dd4abf478
[2/2] phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018
      commit: 62a5df451ab911421da96655fcc4d1e269ff6e2f

Best regards,
-- 
~Vinod



