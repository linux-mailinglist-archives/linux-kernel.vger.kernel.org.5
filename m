Return-Path: <linux-kernel+bounces-43845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08282841979
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E332898E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FB36B01;
	Tue, 30 Jan 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyij2DUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF7374C2;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582587; cv=none; b=sf9mncfoi/T/giiK077NDQbyfukaT0+VHmmqvLmgPEW8zBtwXxYW1NfhKATuKhwDynNz0hYpn+sZOhzJmCwuBSjQuiBKfjCaRBBoipDrS5/fFTx13ArvBijiui+ZUF4FBUynliSvioMtyzbAibATxXQSaepKH1p8skmoFvnaSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582587; c=relaxed/simple;
	bh=Ec2wu2Eb+SbRpFarJY9POIEuVo7aDUTNt5tJXUsZudo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uj1cGWEozr4flF4UKGwNxHCBv0LLnaPfjVTABLNzBGkLfFJmRD6JxtF9t5KuZMU1cySe8fmxCCtoVJMWGsd48lG/7eKZY1ug1Rz7UBI927ukWR2mvLbWF5IGb1irilvgl2ctoNGylF+SJG90kz056a/LUZtM+PQYKxnxqzi8t4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyij2DUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B65D5C433C7;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582586;
	bh=Ec2wu2Eb+SbRpFarJY9POIEuVo7aDUTNt5tJXUsZudo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eyij2DUUnVXTv3bpBcgl/erFLpOdpJaTMXZM4eoKjEfPDwpz5l9SgbkWTNDtOpQwt
	 H6SunO0qyKnYLoJuMdNmb3l0FEjpD3X4W4dV1K2eh0hsBx4BvrzQgDx1+DbaVVf+Gy
	 ++kBAWOhXKaUWtEqvpVSxa+TXw5M+Riyo5wPDDqBMmYXCTwniSonmtu5Q9csDfUabx
	 RasX3MuOWkWLCxonFcciAkGpb8GRnOgzEFLoKLk8H+VK7TQfGgKZVLTZfJRhqzSpYk
	 QhSeFqRaRgL5hIVGeJ/QUBKfl2HJmdAD+lc0ZQyAdK5/GACnMqY+l1P7ujIRLfgjDx
	 ldRUxq5MjyLpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CCC47DA9;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Subject: [PATCH 0/2] Add the mXT224S touchscreen to expressatt
Date: Mon, 29 Jan 2024 18:43:05 -0800
Message-Id:
 <20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADliuGUC/x2NQQrDIBAAvxL2HEEXSWm+UkoIm7XuoSa4JgiSv
 1d6HBhmGihnYYV5aJD5EpU9dXDjABTX9GEjW2dAi946fBquR2bVtZTlWwui16XsJ0WlzJxMcMF
 vZN00PQh6pMtB6n/wet/3D217oCpwAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706582586; l=938;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=Ec2wu2Eb+SbRpFarJY9POIEuVo7aDUTNt5tJXUsZudo=;
 b=x1r1rsoZWsL3KI6uJy16fmS0CZWmNxiKmzz2HPlKieu65pTlQb9+cyzS2NmNtVxiAXy+kqdDz
 HKBa2Kb1p4uAD5N7fg1Wkt5y1CiUSwIjdM71ghR3F1U00As2tAsn65t
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=RGmug3GRHS4XYTXDcT2VrlTGXlEF2gY4L9/swGIU1ko=
X-Endpoint-Received:
 by B4 Relay for guptarud@gmail.com/20240120 with auth_id=114
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: <guptarud@gmail.com>

Adds support for the Atmel touchscreen to the Samsung Galaxy Express 
SGH-I437. Copies the gsbi3 node from apq8064, which is a similar SoC,
and sets appropriate properties.

Applies successfully on top of my previous patch:
https://lkml.org/lkml/2024/1/20/56

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
Rudraksha Gupta (2):
      ARM: dts: qcom: msm8960: Add gsbi3 node
      ARM: dts: qcom: msm8960: expressatt: Add mXT224S touchscreen

 arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi      | 29 ++++++++++++++++++++
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 31 +++++++++++++++++++++-
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           | 27 +++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
---
base-commit: df2fa93a6956fcd03da4c251150aa9cc3c88c74d
change-id: 20240129-expressatt_mxt224s_touchscreen-f1f4dc01667c

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>


