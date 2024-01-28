Return-Path: <linux-kernel+bounces-41505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0683F2EE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F89282BEC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9461D524;
	Sun, 28 Jan 2024 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STPu8luq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E1DF6C;
	Sun, 28 Jan 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408256; cv=none; b=IbgHzGL07yiy01qdeT9PzlZnOcRp+8MqnSOgoDuBFUZ9V5sE/vQ+Ttb6rJKWvbLAKzCojfiAIKfYQ3SdnFROGg8qcPqb/+NoyOhhGZLQOYbtWkJFiFPUIMHOArgg8VF2Z93bP9XI3nvrxBAJIstNxOy+8Wdr6z7+1X95Swuhm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408256; c=relaxed/simple;
	bh=OuAFKNujzmRVftjnUxxa1bJozS1U6HlOp+aYQi+hXfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKqJhnRA7/Qskk9Yjp1Zgqc8Y9Ao1ODsKu3UdCOQl10gb2Eolvpy8LkcW+y1ouU+siFYCDqd3+kDaAz/7AqnAwBmd+uQWfGen2DyYGEhaA1cAYuwe18cWFGIlXETTTe4UNYQAWx4DPpq9iAYNOTWz3RG248LUCFSQkYhjaRdHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STPu8luq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6F5C433F1;
	Sun, 28 Jan 2024 02:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408256;
	bh=OuAFKNujzmRVftjnUxxa1bJozS1U6HlOp+aYQi+hXfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STPu8luqHd2lzOEoss1ibrjn2Xl4MGEChFTO8yt1mE4cYTjHHD+L9KCwcTu/5LNdT
	 36aG9kJla3mKKIl+KhSFfFLhj5DVnHqEfHHp/AAmwmD2PJp1Io0gq04StqGkyAB3NO
	 k7AIUW1Iu4xjDKCf32gh1OHyyHzDMiNhbk+IwdZoaNdFJZsPkk7q6cNOHb9BxVvLsz
	 lj6mwCoeyMo5Qd6RnMbxdOQJ693RiSiLhntHINXYBx/42Mokg5Cke/cYxZiCb3XMhg
	 r+oElCJ/FBrIUjEtAZUrQI7OcH5HzxyivfAk5xXsPfeWQrO2VMNX4G4/TC2pNgzDzC
	 2veBQHLBxYb4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/2] arm64: qcom: sm8550: add support for the SM8550-HDK board
Date: Sat, 27 Jan 2024 20:17:22 -0600
Message-ID: <170640822834.30820.7929773072144035739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125-topic-sm8550-upstream-hdk8550-v3-0-73bb5ef11cf8@linaro.org>
References: <20240125-topic-sm8550-upstream-hdk8550-v3-0-73bb5ef11cf8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 09:13:33 +0100, Neil Armstrong wrote:
> The SM8550-HDK is an embedded development platforms for the
> Snapdragon 8 Gen 2 SoC aka SM8550, with the following features:
> - Qualcomm SM8550 SoC
> - 16GiB On-board LPDDR5
> - On-board WiFi 7 + Bluetooth 5.3/BLE
> - On-board UFS4.0
> - M.2 Key B+M Gen3x2 PCIe Slot
> - HDMI Output
> - USB-C Connector with DP Almode & Audio Accessory mode
> - Micro-SDCard Slot
> - Audio Jack with Playback and Microphone
> - 2 On-board Analog microphones
> - 2 On-board Speakers
> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
> - For Camera, Sensors and external Display cards
> - Compatible with the Linaro Debug board [2]
> - SIM Slot for Modem
> - Debug connectors
> - 6x On-Board LEDs
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document the HDK8550 board
      commit: 507cad6e0f0ea64d33f9d7902520d7c72fc8c0ca
[2/2] arm64: dts: qcom: sm8550: add support for the SM8550-HDK board
      commit: b5e25ded2721ad75456eac21acb5b2fc6fa5d2bb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

