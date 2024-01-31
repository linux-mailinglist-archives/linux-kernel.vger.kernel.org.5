Return-Path: <linux-kernel+bounces-46100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7ED843A53
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D342932DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A106340F;
	Wed, 31 Jan 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW6Lub9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E258137;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691887; cv=none; b=F/a14nbL6umkRNCAUGSKnsBJ1fryPTziSXOWHjgpfBNZblYdKTWRKFLSyp6IvZZ+mMG3aPcaeJCKK/oQCM2xVNiH6DpL8bPfYStDLVAyhzqE1NkO5HrBPHxVMpk7elG3CYmAvVUMFhTGjDnaPrk9j9YmUTpkgVQ6VnBumcd6IMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691887; c=relaxed/simple;
	bh=EuQVvrTQv0qFbBXUXHtzFTv+0FNlC9+gEW6Jz+tkv8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SyrmTgLPK1YKwCxvBjKLqwEqh0wkgcryBvomO/It/nVa+wftfMPjafZkP8WLmGsV5XdpiI5ZjlCaGL+6n/1cYV5TMmwiSdP93FXyx8ry3AM03ior/XLGfF1WWVq9dfr5muz3bqrkTearBr/iL/wo8wdrU15OFOMQgFenlQosT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW6Lub9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D04BC433C7;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706691887;
	bh=EuQVvrTQv0qFbBXUXHtzFTv+0FNlC9+gEW6Jz+tkv8Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pW6Lub9UtEOT+tMcYS1eAEAEqY9VpHJT3uEPJHHpDbUEhsWvncn4MOvxP5pIRM2zr
	 8niSV2VquDECu+HeBtFQti5tI6kRzkMbfz5qu2so3zTYflITumLHz+/ZQi5XxNQDaV
	 x73OuHf7cwrbRaOo2cBzyJmGqxWjGznQW9GJc1ND6VyyBefXrzs1heQ97HZWRfLj3b
	 6brKJDczAG25XTLqz7DnhBgU6khiy+FbQC1VKQjh8sezCIbWoUJKEj60+lHROCAzO+
	 17v0nTMzYCO6YUf6qOaE+XxAREo5rfUFtnj5EvAWGC09pxXbd0Ioz+YShyLO7Zy/GH
	 JVhazoZswDcuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B771C47258;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] Add the mXT224S touchscreen to expressatt
Date: Wed, 31 Jan 2024 01:04:45 -0800
Message-Id:
 <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC4NumUC/42NQQ6CMBBFr0K6tqYdAZWV9zCE4DCFSYSaTiUYw
 t2tnMDl+/l5b1VCgUlUla0q0MzCfkoAh0zh0E49ae4SKzCQGwtXTcsrkEgbYzMuESCXJvo3DoK
 BaNLOurxDY8vyjCpJ0tnxsgfudeKBJfrw2Xuz/a1/q2erjXaPS1EAWTwB3vqx5ecR/ajqbdu+B
 06AiswAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706691886; l=1095;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=EuQVvrTQv0qFbBXUXHtzFTv+0FNlC9+gEW6Jz+tkv8Q=;
 b=XygDxen7AysewD20GDUn9VxaNk5xD1C2SZ+syYyG8tAYDOBYWYcoDln5hhs6++SEfVktT2C7/
 7ECqQAgWDTfChKKaIk00iNaex1fbLKy/ENlSLHtbE9umBvqmkiIgWP8
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
Changes in v2:
- Fix formatting for gsbi3

- Link to v1: https://lore.kernel.org/r/20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com

---
Rudraksha Gupta (2):
      ARM: dts: qcom: msm8960: Add gsbi3 node
      ARM: dts: qcom: msm8960: expressatt: Add mXT224S touchscreen

 arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi      | 21 +++++++++++++++
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 31 +++++++++++++++++++++-
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           | 28 +++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)
---
base-commit: df2fa93a6956fcd03da4c251150aa9cc3c88c74d
change-id: 20240129-expressatt_mxt224s_touchscreen-f1f4dc01667c

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>


