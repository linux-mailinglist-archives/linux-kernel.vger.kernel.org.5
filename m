Return-Path: <linux-kernel+bounces-60486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7485058A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC061F24E15
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8235CDEB;
	Sat, 10 Feb 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWyThwhk"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865651016
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585015; cv=none; b=gc9C5q0eOZeJo0oeOlLZVtZ0QpjViR5SpDoAn2qHEL2In+bfIgyWf2VCIXyt8lzVPP94fIld9deBePgCu/0PfQ8fUgUK1QvMmdq91Rt1z9H6kgjKEkYfgAfGIaSNaKwQ8G/ggrronxR1FyDCNgUZNLgbWkChLxyQvt9Iyq1FtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585015; c=relaxed/simple;
	bh=BaU/bP7v133m08+SRbtNQA0dEb7SZt1w/Yj0I4z/vi8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sLrtoYwQ9NLoywM8Qb7y7ycZy8tnowrhaem8zV9tpwMB3rk74FJr8SS/5jUBDm7dODG2aFAss00F478lF5o9ERBAa45dJ1t1yqxLFUGB9btip11UcIXGyslv9QxaOAoDD5KEX4yNW7VajHwX7r5M+MmW6OYQyQUELLaGtw5YxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWyThwhk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5610c233b95so2150470a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585012; x=1708189812; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub3t1C16XKKLVPOgvYEAt5qRjsjAUqaoq3TtQjsnA8Y=;
        b=DWyThwhk9S/AeiJp2XcUqp3ugX3TBOoCLUA1Fwkc6vHGSwyZspWiSRAoa1RYiMkxo1
         nGQxO+TRX+KMKfOlHv3ISePZkGV+1fPs4MTRAuSqiueM0ZLJlVPgEGOGp3SSZ2RM2p+g
         DxSQzh937uwWi51qctypRgX0CGgZDUw0vUlcSBlU23NwG5KyfEyBmNi5mJL5zEOfvVqN
         FudlJIJEUglFzXOOt0VuQjm6PG7dUtZ55kxhiDoL9s+s6N/QWSVoAW6bNMrdGP5EQOae
         YSvUS9evpFU88sMRX2P9hpxbyJJbaUAfB/y2PSbuj9LlEcdOpOYW8VcGASuVhwHbb9EO
         P7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585012; x=1708189812;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub3t1C16XKKLVPOgvYEAt5qRjsjAUqaoq3TtQjsnA8Y=;
        b=GRkNyomPOPtS++hfYzhWE1zyuMWEWN7SElS+0uxKeRZ8WibCNzLS3uhtoAdodDVBv3
         8QK8iFJi3xW0U/LQnIQXwAp+hHAPRCWlctJJHDIs7Oh4z2DAdJ6Cz3ocbKjDhtx+m1Vc
         2nrMkKgCFJkmE9zCZhuHCDUr9xjaw2W+NY0h/qGCi+EjbdICqSPOb/AsthEZsTdSE21/
         tSmLopvzGRXgAAV2xFQwoNiYQtFlKT1PD/ZrMixnZzGhz8Vp38FdvfgOMHCuAij6UUAf
         uBKvrj5Qoc/lwPg1Xd6M2asrflD73JEfxQjoE1UEq7Cnx26jsI0AFID3WNrXMUgl5ehs
         RKAQ==
X-Gm-Message-State: AOJu0YxbrgZSP0mPnuiaOd1DeIs5wNWfzWs7irQ7TqPUcK8HKuPW9zN1
	g8d692AhdPFDOv35V6mnRD3n82X4Ua1hRD/x30IbDA1Lc7I0WFcK8L5RMlw+8Eg=
X-Google-Smtp-Source: AGHT+IExF/deVU4o4/K2ms8bjUDjITAx9RfeeX+sCanQBh2dY/Sb0Uw4sJCB71tV0mSzUGyVn7kvqw==
X-Received: by 2002:a17:906:bc47:b0:a3c:2bfd:1495 with SMTP id s7-20020a170906bc4700b00a3c2bfd1495mr1389894ejv.59.1707585011898;
        Sat, 10 Feb 2024 09:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUo3eDpPjMri7X98qBTjTw/GCgFdL055iuYdVbwRL7jqJSxjR0Wa9x1oicDkObOMIDb0OzOApIl+GYIPeIemivemNHEmoD1y52VRa+TxmXk7aFI7/4eAHeEhSyceTAVpsVgN5tlCKLKLmOq8UNSh9PlExAFmW4qH19kfeUtlAwspMikyvwXWXUpFDSWOKt+bfJI7EbgJb1XINT2E0WwQF5MQPfN6BBY5jY70k3+v8xdNUP3N/63/YjP7gZW6O4nUMHAKi0fFmcI99w+YjtTU1Va6sZu8LTQAeWgmCUeNgCAF8csv+EgNbHeVa7MUXc4keHF/aJ3gjwV5KVpn+4xcG8RI7FpgXMLD5FhiRvvLmRriey1oM3EZNmF07hDgunsUpwKLUwNDtFDcvM/gJR3tcNG++O2mCSFRFv8rw==
Received: from [127.0.1.1] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3c1e1ca800sm973242ejc.11.2024.02.10.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:10:11 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/3] Qualcomm PCIe RC shutdown & reinit
Date: Sat, 10 Feb 2024 18:10:04 +0100
Message-Id: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOytx2UC/x3MQQqAIBBA0avErBOmQUG7SkSEjTUbE40IpLsnL
 d/i/wqFs3CBsauQ+ZYiZ2ygvgN/rHFnJVszEJJGGlBdZxKvLFlckhdW3ulg7GAskoNWpcxBnv8
 4ze/7ATcsVpVhAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.13-dev-0438c

This series implements shutdown & reinitialization of the PCIe RC on
system suspend. Tested on 8280-crd.

Changes in v2:
* Rebase
* Get rid of "Cache last icc bandwidth", use icc_enable instead
* Don't permanently assert reset on clk enable fail in "Reshuffle reset.."
* Drop fixes tag in "Reshuffle reset.."
* Improve commit messages of "Reshuffle reset.." and "Implement RC shutdown.."
* Only set icc tag on RPMh SoCs
* Pick up rb
Link to v1: https://lore.kernel.org/linux-arm-msm/20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      PCI: qcom: reshuffle reset logic in 2_7_0 .init
      PCI: qcom: Read back PARF_LTSSM register
      PCI: qcom: properly implement RC shutdown/power up

 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 178 +++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 44 deletions(-)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20240210-topic-8280_pcie-c94f58158029

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


