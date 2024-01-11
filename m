Return-Path: <linux-kernel+bounces-23903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38A82B379
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC65CB21C89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA243524A4;
	Thu, 11 Jan 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVR1qHQc"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470D53D565
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e60e13581so7734405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704992333; x=1705597133; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhvvrsVRrZ+8WIVClmCa0NV+6nlcX/mgm0TQRfXYglQ=;
        b=eVR1qHQcOBgECHbAOYVA0H5zrNY1PU4+nJDySt5MgVc+4PpWHsBpwqt+NZpSAk7poT
         W06/aEWXS+V27vd6D1AAmEnm50n1He3n6tH1HFlubrSt4s1bmiCKZqxntfdyRQKlZMsD
         LtOWTJkOVUjDPoYD2IGJ0ifRAtARsdYLePs1WcFIzTUcGrMXCODxitrBsY/iQhktB8LW
         D66RzxQBa1aCSm3BqOGttYaXTRUr5QcqVA1NaD3PhA0UN4KXLKVEh495OKi29M5pMpTT
         Eul6oE/QZ8MGAmvJ9PGnEkLi0OoP+rJBfIZ/fQHkeRNu8IP8h7yl5MQ2d/X7g2LuUa26
         u7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992333; x=1705597133;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhvvrsVRrZ+8WIVClmCa0NV+6nlcX/mgm0TQRfXYglQ=;
        b=BUdE+b7et5GkrpfFJCkXHjWa5E8TjHzbDdG4FH8QxVo7dSyLfc1or8CR27g2pcJq5e
         0+6N/xAHXzBB/zQYT8bIgFbDxtpZiVtiTB0stqtwh/Zq6LOTYhaFl5wia2dJUpnhqd/i
         2gfcCBiv5rS3p4hcusY8WdvcVdaIUI27d330vrLhsrcDNoNtvcEjbHCYProwo5BvZ1oK
         8gRXcW2FG+pprb/Di7HKqRqz6ZGQJMsmMWp/AgOCqfmJDzW+AYOSRs1cS/CzjhtLbFba
         w7lNQNBQD5cmeA7/TPrK95/aXocFNQ045XdhJLydUKUZQXaxq+UoIfHYZ3Fb0u+XrWWQ
         nDQQ==
X-Gm-Message-State: AOJu0YxmBvUtCs7lTlbfhdB4YSBh5DY7MDKV8w3+vTkWSTTfhAw7M3Ki
	v22TtMowRZzif+jnIe41xeF7hl2G6j+lkw==
X-Google-Smtp-Source: AGHT+IHbc5kM12iaZHmsnwhN7KEZQrhJk3jRP6EDSF9h7YmzwBCH/VaHn70LMm77b0UOp6qt+nEotg==
X-Received: by 2002:a05:600c:3510:b0:40e:4d51:99a2 with SMTP id h16-20020a05600c351000b0040e4d5199a2mr44688wmq.145.1704992333484;
        Thu, 11 Jan 2024 08:58:53 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id iv17-20020a05600c549100b0040e5034d8e0sm6501354wmb.43.2024.01.11.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:58:53 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8650: mark gpio74 as reserved
Date: Thu, 11 Jan 2024 17:58:48 +0100
Message-Id: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgeoGUC/x2NQQqDQAwAvyI5N7C7VhG/UnqQTao56G4TKwXx7
 w09DgwzJxirsMHYnKB8iEnZHOKtgbxM28wo5AwppHuIMeJeqmS0dei7gJ9qu/K04lsJX/LFuUp
 BZY8eTBhzS12fE7U8gBerskv/2+N5XT8cGbewfQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=938;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Wt6CfNuJptOIyGlkvERKaMpnubz1M+hUXCgBywQ3HR0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBloB5L9e13ojZ3UH5DxVNWYBrZHs4HjBZclwrMXlQz
 uaa6ZyGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZaAeSwAKCRB33NvayMhJ0dWnEA
 CowT/fxqsC7aFAgmrYkE7VxaHM0epf9+Hly3qqRGT96ppZNXQ2Ub7ABLYBdMf41pYgJakJ++knUEfk
 RPg4O1XZy/xluTrd71n1Jjr49a35f1I2gzjRrBsbl58YY/FR66ASxA0iokXG/w+/j+FnomdL+sCiBx
 doONJcVPmt4ckpnXAlcUVpjrlRFP/gZ63uWeb7NQXiOHlwJq7HhlUF2HVKjhx84t+imwvoydBpzIRk
 IFHEa/nTW6WZLm27Rgx8xo1PTFyQNEyYS+x0AycZhZCy+G6eMb4Uf7ZUtg9z7D2T9b3Iog59Dm1dPU
 ZIxMqS6vUjuXCZQX6ZjLlFYJ/CuVKxHaWHTDe4TNXrJ/7M0Gdv9vaA0IrthaXEgCA02Dqy5AnbidjO
 X1ijmXxCIJiONuk3komRygUF7h0zN7z6V6mA+h9WdRL8N6oyDNsZerTQ9wC7DjjRRR15CUimwnNjeh
 QBY9LzgH45BbEfQBUkg39qKXZj+i6VUc2BL8iy0VejRvESgB8ZOVw5kqITDlrRZuEBcXl4imaGA+pI
 3Rua6L5H3qfu8cSyLssQla5tpMMm0cMBRRjTYw8AF3LpDptBr9Ft0pzjYTp4OxPMt+v94m4Zd1Yhll
 WCJL9Km9y8pFaRQCjlihxSKAtkC9cJhZmfQOfPDYmn5ombRdBONhplAiPaZw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The TLMM gpio74 is also used to communicate with the secure NFC
on-board module, some variants of the SM8650 QRD & MTP boards requires
this GPIO to be dedicated to the secure firmware and set reserved
in order to successfully initialize the TLMM GPIOs from HLOS (Linux).
On the other boards this GPIO is unused so it's still safe to mark
the GPIO as reserved.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved gpio
      arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved gpio

 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 2 +-
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: bffdfd2e7e63175ae261131a620f809d946cf9a7
change-id: 20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-1c3d56c2d3e8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


