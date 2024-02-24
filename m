Return-Path: <linux-kernel+bounces-79627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9628624DF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6982821F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA9F3F8FD;
	Sat, 24 Feb 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWvrg9Aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C884250EB;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776620; cv=none; b=jV6Na16lHvE2RbJ0bOyPAlP9aB4XDTGaFyWfmhW0P4mx7Y45aRTrNDhIjWJnIUkSeU1oKyBzQo+PmfCKBRB1UklLA9RzcfZMpDGiuAODX27ivWT/KozAUVSIxbnhcom/AdVsEia5WWtL90A12fUVWta+NJEgqwda3vAdcijGbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776620; c=relaxed/simple;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnJWfMV7ESo084R9GmAmZuL+3Hun4pN0t3l+VL+uJ7H2l2WM+nZJAd2Phvdjg7WecgPrInAkpxhlKmASmHIxZmINWxnojyxSWnx88UBgdGOmS5Jpq6Rd1hvmlewdQM4gNhIbnWnhH2XQoHVS8AdnJfpFlSWF3+0ZCGOz2sjSxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWvrg9Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CA65C43394;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776619;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EWvrg9AjMokq+VLy/BFYvtLkhI/6ddb6MLsipk+S0xFcaIUjj1r88YwWO5HjT+EOA
	 sy0mUJPC0yjYfTA/cEVka7fAuJSKlQ1CNSbZpiWObDgvf2jZOUfQoa/dykRRUkx2Bi
	 22NnyVBKVUTZKBizL2nIZOVnP32/zYy16x27MZUoM8P/1oedyGtrefznbYhL8HK967
	 CP7zyRTWbXH8oz6/jrhFJJhWE2jNfKhYkx6Jom5L01lwzOg8C3bJuZuzkLhm/hTso/
	 mFJ7Y/aIwQAh/oz+QIyZNF62lEMoLeHFUX54WUnH1sCYfEJIthRBFa/u3GmTK1Ki/+
	 mBjrHjJNY1PiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8532BC48BF6;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 20:10:19 +0800
Subject: [PATCH v3 2/2] usb: dwc3: of-simple: Add compatible for
 hi3798mv200 DWC3 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dwc3-v3-2-2535fcee7f08@outlook.com>
References: <20240224-dwc3-v3-0-2535fcee7f08@outlook.com>
In-Reply-To: <20240224-dwc3-v3-0-2535fcee7f08@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708776618; l=809;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=CsDB1ujYdciRCCnGm2g0rfxKORwEFR6rPwogWA69oCs=;
 b=j2N7cQ1V5WBDHUzWL0JnLeMY6RTTIdYVu8/7ruPVo498XQWfAc2G3UH7oRdM/CpMRt5etw0BT
 faUoF7wjnhuAXhYGE8LG+Ko5i6mDqYpfAU5sSmaBz1k5WeaBIxkity0
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Hi3798MV200 uses dwc3 controller with a few more clocks and a dedicated
resets. Use of_simple driver for it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index d1539fc9eabd..158acae08af5 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -173,6 +173,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
 	{ .compatible = "hisilicon,hi3670-dwc3" },
+	{ .compatible = "hisilicon,hi3798mv200-dwc3" },
 	{ .compatible = "intel,keembay-dwc3" },
 	{ /* Sentinel */ }
 };

-- 
2.43.0


