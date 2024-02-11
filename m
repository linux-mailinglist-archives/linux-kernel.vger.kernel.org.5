Return-Path: <linux-kernel+bounces-60982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A457A850C24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35063B214B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BF171DC;
	Sun, 11 Feb 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFEiaSVB"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5594171A0;
	Sun, 11 Feb 2024 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693318; cv=none; b=DYOvUXIVBrDQlR/ahsmRpzYfiklWN7zIhAw0bBKa8cr13wGkdjY8YNq36rd4JfT8NZrruhgj4GitoRLfEbmmhrRzkZKA3eo2eSE2uq2KFnDaz76oETNxly25zyPL3YnDlAlKJXs6JajBmVSO47MzOvONLKlTtPIgcScywQttYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693318; c=relaxed/simple;
	bh=AxRTjbv0OiO193wbDxtjkOJsdNgPSP7xlc+8H+NZH8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWsaRM0baEDOiKQXmBLZXLJJHBVyBSmIxjLMtNUM0LqrG/xhjcFi7EhyUOk5PZsnPVo+nndRhvon5QEeeuZSBbAQmoQkGSbWf2aAhrdsgITcW+MLpA/23A6zeA3J0LMk9pD9BFh798YYvWJm2PIq5RMD7bzbXuFkIJI/jA6V/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFEiaSVB; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42c754ddbdbso4547361cf.0;
        Sun, 11 Feb 2024 15:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707693316; x=1708298116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9rb7Vuo0EUaJNM3OE4lE/4ti+cCsniXbuXa8cVO3Qo=;
        b=mFEiaSVBUUqhudesJWNEDHgT/4VQRHc5c6PaPXshMEoW3tWqL/LfYgvY1onzeoVwj4
         t+kacta0vUR9w3PsqNhWn5Zd6rrTYTX/pdN8Xjb1JZjDFtFcnT9N4A7cUc8EbhG0c+jB
         XKqLOemg2Pn1zdC4pS+6a1ephPMTSRP36iUVWvYT9Az2lPZz8lw4iA1ITRoO2n0Y9lLw
         C2GhACAK2eTRqfumo33HCDWkM+mozcQlfqpu+y6kVWa530eZIb4hRCBxBEoSLXSz06uQ
         WiiBpgjn46SdZyy39lgZbTGt8Ozlk2p4w0SLqhyWJHawSUr/Tje+scjUG0zrZEBELd9D
         KfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693316; x=1708298116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9rb7Vuo0EUaJNM3OE4lE/4ti+cCsniXbuXa8cVO3Qo=;
        b=og3MMeerTRX20NrBR3fDJDtEkPtrJ44hQF63/6+NEkoaLu5kYdVK+9V4k3TlRAusDq
         21dg6lINQXjlDDKPo52zrJAwQh2vkeXR/zl6B78vzdk5Pg93iP1UHvGUniH4HjgSBmVl
         m2giormNPzR68kwEDaU9ocqrsFhEF+bjdSoY6KlMaEf2cUvrc7J/U3sB1NJP7UvFnqAm
         YAawNGbd9BIK1Du8d+XqpNSTNQKBkpMNqBUFr4tAYEXhnJybLvl0DAtQO4n09wCD1PJ0
         uYQsROGuihYQhB7DO/LxRtz+9m1b9s2jgSztelEVtK6tgwTJEYQmCjYq19dsC59dPHGu
         rOQA==
X-Gm-Message-State: AOJu0YzH532LsO0jCMHTSF4ATKPmvijvsJdwEXDo5uGLpvOm7OdRCxzb
	6LGj7x+FKChul2aYp8E0Qx+asuLaNiOWOBCcYxzTC0XE7IgTZmVF
X-Google-Smtp-Source: AGHT+IGJ4ZMbGiT5clUunfuBZrUJFNzVdTnqLXFnL/ALXUNFc4DpnjczVSH8tzkNkUEtE9ZwVZAnnA==
X-Received: by 2002:a05:622a:1341:b0:42c:f24:1893 with SMTP id w1-20020a05622a134100b0042c0f241893mr7896892qtk.52.1707693315631;
        Sun, 11 Feb 2024 15:15:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVadT3SJadJYIB5Auk8+YrOhtUifoFH0HG9icPCnV8HbUCiA2Qb+3xxDXIwmI3Ng1c3oU1E9G2Ny3dIeZKk7rVScGnaHOEF24jcmRqg5G2WSeE9dhfr3rNxSuXiBELIvUS3Iz+B1aOIN/A2qqelaGBo0P1tnzz0m6CqQqGEaodhuyA+IFjFSRoV6aHqGnl3P468Jh+kVm6POWcYKDbNvpjr1nJS8SST7bNcfa9jgqBEBmeLlLMCPETO23OafWgjY58sIjblMBLoblqRKpaSxiYlMCnig9jXO6+NBAzDD0RciSfWEr+h2YVr6EuY6T8CIjZ26wK0uoUVTpfeDcjLpNc9rrabbO4ZEDKk6oeI6cqsml8zicqFjpvf4zFMQhbsSJr9Zazr0dfaW4N7sNRnEozSpaW/vDH7AtGh75nxYjd9Rq0zz+dIcTgxdus=
Received: from aford-System-Version.lan ([2601:447:d002:5be:c8c4:8542:9142:2184])
        by smtp.gmail.com with ESMTPSA id e9-20020ac81309000000b0042c7b74e767sm280955qtj.22.2024.02.11.15.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:15 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mn: Slow default video_pll clock rate
Date: Sun, 11 Feb 2024 17:15:08 -0600
Message-ID: <20240211231508.188567-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8208181fe536 ("clk: imx: composite-8m:
Add imx8m_divider_determine_rate") the lcdif controller has
had the ability to set the disp_pixel_clk rate which propagates
up the tree and sets the video_pll rate automatically.

By setting this value low, it will force the recalculation of
video_pll to the lowest rate needed by lcdif instead of
dividing a larger clock down to the desired clock speed. This
has the  advantage of being able to lower the video_pll rate
from 594MHz to 148.5MHz when operating at 1080p. It can go even
lower when operating at lower resolutions and refresh rates.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 136e75c51251..932c8b05c75f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1168,7 +1168,7 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 							 <&clk IMX8MN_SYS_PLL1_800M>;
 				assigned-clock-rates = <266000000>,
 						       <24000000>,
-						       <594000000>,
+						       <24000000>,
 						       <500000000>,
 						       <200000000>;
 				#power-domain-cells = <1>;
-- 
2.43.0


