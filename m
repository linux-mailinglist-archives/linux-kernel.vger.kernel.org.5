Return-Path: <linux-kernel+bounces-98386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C500877951
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1720A1F217C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E067110A;
	Mon, 11 Mar 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G06A5gyO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E4631
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710117210; cv=none; b=Jbp6jLkoyVypky2DHHSO88vSXrJ0yxocMLb29TiEsG28MqIexmRGLQX4SGiHICbVYNJsEEo15HHXgkzG9pnxnxzWRiEMRpZIqdKhOWXHl5Xo9hLUts/FnrCy+zq1nTG6r54mtl3ocrsRbSVa2WYNcgZEYjyeCYXEe2YfULQN3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710117210; c=relaxed/simple;
	bh=q3MFamMIr6NFVpUFcDH0jWX4vsZYOAYFx1MyZtEqvyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S9nWjyvZwtF22Tk5i+YqIu0SiZIGlID2eKHOJ1+Rpx21ZbUn174a+ui1ZgH164CztKLK8ncSGu4xbnG4wJ+cro4mHjx3JZDyMh+xBY/FkPfyUX0RZi59b4Mk2P/bM0YpD1EvZeAKy+GeqULKzRfQiz8e5cdE1IFCYsPHgSck3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G06A5gyO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e94c12f33so638907f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710117207; x=1710722007; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfyiNRPXIKA0wIGpSVJEarVeJ6YjuAYZ6W8XU9TBWZg=;
        b=G06A5gyOSWhOCdfOvpciP7O2FLtr30VEiftt/DxtYfV14qmKq7XDpfFAEJnhtoUH2Y
         RTF8Y1mVo6eMhN6ONniokvzIb7h1tdEIf3+8KAyxdmoD9zlJ81WPOzcJUlsOQup71Llh
         SO04Nn+77qKjtPZD91xoBFL4CAKgJCaE0phv3vxhmlzck09GpfkZgZSSKOcC2vWGCv9m
         kCA8HcwikSpbcyQsjPfFCGu3S2jQOJqP/ag1CdcwFCI/DmqS99t5s+i+/sIRDwwCCv97
         rrx5WeeXQglQznyprjrrFZXIN4sP8MTMvt8x0n96iRW6HWnOvf8wPgXiOmxB9bTnm6wf
         t2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710117207; x=1710722007;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfyiNRPXIKA0wIGpSVJEarVeJ6YjuAYZ6W8XU9TBWZg=;
        b=w+bixD2r1+oQoPcUj7OQyJqhk62TpWmbn9SNZdTIrIuaUwobjEspQx72vDm9kY9ace
         0HvMsklKGdr73nUgEgFN/dTP40tN2SUg/5ealhlu9t6KiB5jRS5N+8lSWe1BoLQygucQ
         OyDWsF3bwFJLkmJC36Esa7QMJ+S9n03bx26F8tAB0hl+lLLI870fpc6h5obBMcT5/2O5
         kc2N0v2r13amvOVyLVKsSzZBAJVitvkrPm8xCsYiJdUz4ZWD+iexFXEf5YUuuugi0C0G
         Fniuon6wfgOJHOGpKc06ViT8i/YrTa5lxsOgMhfBL2gr0qe2Wyktm/6O0BqnO2qcXflU
         wSug==
X-Forwarded-Encrypted: i=1; AJvYcCWhdVf94Ra7oiQYo4H2fQvr/ZYs2B8wTr+5quIIqG2Xs1jSwr6sVBqYMGws4dewh/fEddMnfY8DoE74bsBVkd5SEuOM8Z/D8NgxwQ8E
X-Gm-Message-State: AOJu0YyF3dOoi5anlruW0xZ6EKvIKm0ClFAciiPP74CQFnD3onHqY7bd
	Lcdii4azxeqJzQ4aCNCWINffsWmGKbYmfqxkPvSaIx2nG6t8bd4pEPav7vZsOrh2qkeo8SRbUZa
	L
X-Google-Smtp-Source: AGHT+IFwRUunT+Ya9ZAsaCyFZIIhiHE6ops/oFZR1frJlejjxGjqW5MNXAD/9FWboTVWVIXp+oDlPA==
X-Received: by 2002:a05:600c:1d86:b0:412:f8c2:869a with SMTP id p6-20020a05600c1d8600b00412f8c2869amr4095684wms.30.1710117207063;
        Sun, 10 Mar 2024 17:33:27 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b00412b6fbb9b5sm13881720wms.8.2024.03.10.17.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 17:33:26 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] qcom: clk: camcc: Fix power-domain definitions on
 x1e80100
Date: Mon, 11 Mar 2024 00:33:24 +0000
Message-Id: <20240311-linux-next-camcc-fixes-v1-0-d126ae0b9350@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRR7mUC/x3LQQqAIBBA0avErBvQMaK6SrQQm2qgLLRCiO6et
 Hx8/gORg3CErngg8C1Rdp+hywLcYv3MKGM2kKJKGa1wFX8l9JxOdHZzDidJHNHWjSFqdV2Rhjw
 fgf+Q33543w9RZaGpaAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-26615

There are two problems with the upstream camcc implementation at the
moment which this series addresses.

1. The camcc block has two power-domains MXC and MMCX however, the yaml
   description doesn't include MXC.

2. The code for the GDSC definitions for x1e80100 camcc fails to list
   the titan_top_gdsc as the parent GDSC of the other GDSCs.

This series addresses both of those bugs. There is currently no upstream
camcc dtsi for x1e80100 so the yaml change won't affect the ABI.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (2):
      dt-bindings: clock: qcom: Fix x1e80100 camcc power-domain declaration
      clk: qcom: camcc-x1e80100: Set titan_top_gdsc as the parent GDSC of subordinate GDSCs

 .../bindings/clock/qcom,sm8450-camcc.yaml          | 37 ++++++++++++++++++----
 drivers/clk/qcom/camcc-x1e80100.c                  |  7 ++++
 2 files changed, 38 insertions(+), 6 deletions(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240310-linux-next-camcc-fixes-a68322916421

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


