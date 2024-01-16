Return-Path: <linux-kernel+bounces-28197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5582FB77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB3283E60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B22165F93;
	Tue, 16 Jan 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puEOasrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E264165F7E;
	Tue, 16 Jan 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435427; cv=none; b=HgA7pR4YrnDlG2g9o5rgvpBvhWIqp3WQTLNn/l8cQ/52GT8XxGjuRm6g5XGL+JsZD3l1+YGBFqRQ4HQjm9JN31wKm1o2d1p+8bWAVGHs9YpYz198nuZzQVKR/E1shS3TOqSmHAcDjPzE+dWKkpPr8z4vUxL4ZKRNiypFhOBN8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435427; c=relaxed/simple;
	bh=8/ehuznTU++AsRJCVpF+SUYm0MJaTIV8fq3m1q2TRTs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=iDsb5xq4oKACJymRZI7tmeiEwBIPbONS9iMFTAM29UpzemYK86JeGQHQTh27bwmvj4YEfAzLpeClDuLhPeIwuYLE0DBYpRBAKeB79y5OgQIGmktxcUTfGM42ommohywOr7qjlIO5vtuoc/x0JodQfhJZjhnmhK3+8vVLONr6rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puEOasrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12FDC433F1;
	Tue, 16 Jan 2024 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435426;
	bh=8/ehuznTU++AsRJCVpF+SUYm0MJaTIV8fq3m1q2TRTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puEOasrmcKL7EDzgolCdUSxFH4aZBZTqJBnAVC7TMHt92VmmNR6oA/iovrGGgTiMS
	 BGi9DgsF9o9CC1/st/u71Wh71iNoVwBi4maUNCCum6uv83nKVuDS7UIMCVZYtbA+qR
	 rrwjWoHSVr0bJ5zUfzku3LxUT+2AXuLAYXf/ClzbKHIybHM7AzF67SvH/UNH3La2TN
	 X4m9v/JpYzHcQ0QQySx4fvRMe3C9RPxhuo0TKPWiJ2MOAzBgCz1dtDguwXoEyIsCt/
	 qShExgggEBUD6AblRCCUmBsXX2j/7Arfdlnmqh3zUdBUkULRkDVUCdTloMAaKf7yH7
	 cgQVFPsh7wREw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 17/31] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 15:02:26 -0500
Message-ID: <20240116200310.259340-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 3652f5556b29..eb0dac710044 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: iram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


