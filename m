Return-Path: <linux-kernel+bounces-38258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E343F83BD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B46B2C219
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845561C6AB;
	Thu, 25 Jan 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqYCpS6N"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F411BF3F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174886; cv=none; b=E3q4r3iuDJW+RQGYogJ/2FlSIH4Nb0lkrQHMBtbHQ++OoeTReYkff7/R0adJLTr8pqZgBy8hXhtfdkYCCYr5S/r6U/zaTBZMnLgd649N+HWLsq3EDJBToqXJrtyN+x9AeIFM2FGVmH0yRt3BT80nVgMip7BYeWAghKBnLfZr7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174886; c=relaxed/simple;
	bh=5MJ4betndPLB3+GaS8rupLO+6HYIc26RUxR61uF8vh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpN7prf1V8TEyzZhXY1cyv+YyMdKUyWgW8/Bt5Kdin/gIuDeTr6DdwJ0aRKt9+t5a9BN4T8PnInxe33Hzl1Ud9Brc4FiB3/9Se7xmKYxxumGeGK7UckyrxFUurl2CRPFEu05Ai+/WQZatEVdiH94fhgCCQYWa8KLFqzrlNQMbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sqYCpS6N; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a354a65afso5702197a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706174883; x=1706779683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHT3+Y7h/53KxXy0tjhxe8TgS0h7ZYJLdmLrPUUOUEM=;
        b=sqYCpS6No0VxE7cvy7YlgZ/YesCVbPGhtYk2zL5+aI+/RXNSfWHTcTtENVKsCSBHOK
         PyxDiIm8FqEui/c9L8KvjsZRdK7Z1wiy0fXc/NE1zM07pMBgTun3jy12jW3zL/+Hxov6
         8D6anUCvY/gAUj8i4AIKX6Qi6uJ9EAlzjOgkdwNtLgacFuivaSVWxLkAGMRpaACOSge0
         drnGbAfNRu4beRaIKMop8t5pqZSnoXt9Pnty1n1KOTz0ArhMk2Wc6ape10hMUNptsa7a
         Vm7fyvQ3siWw62ZxD4OcZcw6YtpGWPP/K4GU2azu0cKbjmreApiIOlxSmSa/XLGCVczt
         zYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174883; x=1706779683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHT3+Y7h/53KxXy0tjhxe8TgS0h7ZYJLdmLrPUUOUEM=;
        b=thvdDunnM9G/EkhYRu2L+sEqw60K62Wdh9AUQfNGvEpX9BmOpNTuwZs0vStzrvhB0o
         6v0LhPKvSDp3BfegNN/yeIQ/jIiiL32MQLXhQPiOmgNTWXg/WzU2gjyWp4WhCpnic88a
         hJWusdO0+1YNt9wrGo2/uB/Ovx7OSgmfF/6XBC4cGkbQ24rkUHUQ6ZRHIrciXH8Ps/hO
         o53VZ0Lgj1BA7vSOIOwc48zNGYquoUuEjhhwyuRXKYgYr+4M6EmWZTDEKUyvwP96BghQ
         cTlKxL9LPp5v8sdM2DMx8RNX0Hxcf/JFM2vEqCznCI/QLrvYvUAcy+9mCFfQCF+l78fp
         64Dw==
X-Gm-Message-State: AOJu0YzeHpbnZV+mxllXQFkdH/Lxd7P/ul2imUxITulNK4wS+oF2WbTN
	qkpaIl+VxizRC02qFLLPv1ISO/119FLnP43o4/fWI2AJUp6o7Tyhw0eyQ6tjDVg=
X-Google-Smtp-Source: AGHT+IHhVPm2mX1vsJTl5kLMxJkz6GHjE24Bh6ovTbyKBtRGUVWaoZvdVIB47FqC4H+CE3GDSeb6bg==
X-Received: by 2002:a05:6402:17d1:b0:558:6213:d36c with SMTP id s17-20020a05640217d100b005586213d36cmr380184edy.75.1706174883163;
        Thu, 25 Jan 2024 01:28:03 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402005300b00554af5ec62asm17356391edu.8.2024.01.25.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:28:02 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 25 Jan 2024 11:27:45 +0200
Subject: [PATCH 1/5] dt-bindings: clock: sm8550-dispcc: Drop the Disp AHB
 clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-1-0f8d96156156@linaro.org>
References: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-0-0f8d96156156@linaro.org>
In-Reply-To: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-0-0f8d96156156@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=5MJ4betndPLB3+GaS8rupLO+6HYIc26RUxR61uF8vh4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlsimaRcVf/Fmc6zAzz4kmyBxKvLZCetTvNaBKJ
 evRutORMSKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbIpmgAKCRAbX0TJAJUV
 VuETEACd0w6HgfuY6jTgn/lkUwpfRRkkU99ZixoX6GHXwGWnBLmq93GR/nG87HXbPEf3me784+T
 4zwjctrmjO3nUUhMRo7XAJdO3KaaY0/Q+v6hV/UpQpKdYo9UqeFDZyNZRaLihqqvgiH47r/Ze1L
 xUpqi/jAZfGkII49MLMbDrmRHW2JX0+svN8LdYhOK2XHGfAISS7DxvIYcfbSDqiCWLbbH73YgY5
 iWp6G5zF179yAfk0E8Ypoc9PFG0cN8sO/0bDn2FvGHDC8MYbcI1s8DNYcwbFCF0EDT9glrAHjzp
 muJPI73Deeijkw1EZJ/dnvJYR9D7bMUauFCnLQ90Omcalvjs1Wvjnv9Xws/Qa+xXJNAH3bE7QJZ
 drb+/BDVjdmWsukdt0FmqU1osl8jLoMyR/bxD73gpROtmItH8b3MtfP8vHu+oFntXyysuiyTJDd
 fAv/mwbqDC3S5rQazaDziw7ojz74E41Ujw1xaCP3Knn2XDRW33DAIrQ7OKYKkndzI5BPHWeFJW6
 KNX5ar4TuXhsIpUNTnIRwK4YrNza8pc0MwF/vFb0O1jvQUN4OarP1xD1dKQujc5W8eLJDzTYMkB
 BYA+E53arP+mkXbPD8xBZD2enqc15Q3r9z2Q3Z7S9lZdwEnJhLeb7ndZ3zoB0PfdRVPDVUROhau
 X6nvJmyDCazKShA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Disp AHB clock is not registered, but enabled on probe, by the SM8650 and
SM8550 GCC drivers. So drop the clock from dispcc node.

Fixes: 553f9bd45554 ("dt-bindings: clock: document SM8550 DISPCC clock controller")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index c129f8c16b50..6660d38bef86 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -25,7 +25,6 @@ properties:
     items:
       - description: Board XO source
       - description: Board Always On XO source
-      - description: Display's AHB clock
       - description: sleep clock
       - description: Byte clock from DSI PHY0
       - description: Pixel clock from DSI PHY0
@@ -82,7 +81,6 @@ examples:
       reg = <0x0af00000 0x10000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&rpmhcc RPMH_CXO_CLK_A>,
-               <&gcc GCC_DISP_AHB_CLK>,
                <&sleep_clk>,
                <&dsi0_phy 0>,
                <&dsi0_phy 1>,

-- 
2.34.1


