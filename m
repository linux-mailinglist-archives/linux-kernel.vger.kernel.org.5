Return-Path: <linux-kernel+bounces-52981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA74849F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C611F22D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93132C92;
	Mon,  5 Feb 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSwNyrHX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146A3FE3F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148694; cv=none; b=fI0fxJZ0evEXRgf8SYmkN+ZVY8KB2SMAj18Fj5O65ejbSRaGf+uOPFRo4aSrMqJSYoxqeJW83fdejonMBGekdyzLHnD4DaKdKLfZmcLdfqW5CXvL7ZrYCyzXZYNGpND8OqkrJ8976ppvD6vlZt9fpNtqjD5g29LQKnYPLuiBCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148694; c=relaxed/simple;
	bh=cH+IHSOUNQiZJ4AhybvDpgnWU9mwe+s3f6c3uJA9pdM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TejVCuYpYUGn14l88HRXHcLxijNUho9xrDywCsOyRCffxRFO0TaRbR3iH5Asp8ijrkQ9ueVVOuRgJ4orkgCdTNk1k5L+PDevKTuav4jhvNnwxDPsIli3bKhNUgnPJREGY6E59jpNDvQl0gYLJ3x0wq8nEQ8WZ2senslLVnMWb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSwNyrHX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe0471c39so316375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707148691; x=1707753491; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPDtyriCqaAtYk8H8DG6JK5SzxdMPRlAdWz2ttUDJjk=;
        b=dSwNyrHXr6vyLn20ZU1QnfgpaxJaI5/5gMaQn9l7nC75Trg+mJgIKALuVmSo30OEMz
         drj9ypIEsJRiA0GmF3G8dD2ikxyyxp2lleuuezrO+7NGXVHyP0S/N5+0oSFSbkzLR4P/
         ORTI3zm2oO2eS9cNAiI/lOpbOVFDmQKLP1MqPC+X6JgkxEhCQszO6AZl9VNrTbJ6mUaK
         sqv8xVnZnSacVNHpKeCRSSRPa0JiiRsWFmoh2oo+mkbo1HHlCUreMgdidc+oZkU6jv9+
         s0rKNZEm94aSTqFygjFeKr5UHf/NEXsQ5tD9OOMbgxaDwRGLrB0YzUHAlBSTWrQkVTf6
         bxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148691; x=1707753491;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPDtyriCqaAtYk8H8DG6JK5SzxdMPRlAdWz2ttUDJjk=;
        b=ZuuESR+68E0RoQ4W9SAA0m2JTeN7u/XZ8jxCgCgZeWNPOVS9WNPrAXSlElEyWdaYnV
         krMW2woO+dF0CJ2ilMQ8hIEIZH1LxDAKnhdKICnBZfEwV2qtW+zbxR8U75wIiSaELD4+
         P9lTl5hK5YIqNzb52hmD23VHEj34N3nYh7DH4spQ+cVpbZ8mA0OCcZNQown8cuIuAC90
         x448bta9keMGqM1b2byQvKeB298dMXcQmYrubakh0rfkdIILpSq3ywpDCfFZVYMeMt8F
         bXaFAhcC4prz8b2Om7/maYISOucqC7uh6Qv8aMEiu2Vcn6xdUiWmsAxfj95+TRkl7vaI
         Ztjg==
X-Gm-Message-State: AOJu0YzfFLWgQpZX2md5ypk08AsT5zCggQ4qZE/F5tj20rk9y+PiXwts
	GG6uucN0226z2atwnTpx2RB0ImfQdWhRYXNGIj2nOnL3JgCSPlydBVxl7ePeAXg=
X-Google-Smtp-Source: AGHT+IHbj4GaaSx4OI+rTDIj0YbH0PRWEyXMclaHamjfA05CrvDDA08yhDBE00yuQNENCWlK6tSjyw==
X-Received: by 2002:a05:600c:55da:b0:40e:7232:bdf9 with SMTP id jq26-20020a05600c55da00b0040e7232bdf9mr163220wmb.16.1707148690875;
        Mon, 05 Feb 2024 07:58:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUvUEAvRDx9cP53hhyzI6JPbih6YP7w4MX0quCo5xNvosfT5BrvLVbFyL6/+Q/Xo3gHl993a5Rq8lYZZNss/xqynLz2g62K3bA9HfVKfpS2nteajTwmOOEfc6w5FZ1suFH46hNYP9V4ba7fYZbPvKKY7rqp9kn7oOx6Z9+I15E0OiHoWAaFPZlct3RyEt2/fNJBTBs0+kLKFwLBWPNBVGBb8Dz7qYepNXHqBh7tPfQRgKUpvUbCtF784KOfzey86Il7azOPtSz+5obyHiSL4/P16vm3hQ6e/7yFzOUsiS7xHMF2LYs6SKKNd+k/bcYoAskqmQztAfxsrGUkr5dOFIewfTLSlzCD4yOyVq3YspST4u8Z1Rkq3e8zH3XkUv2BhUObt794l5zTrx2CZDpHmmPbva6ijeUziPyCnkgQZJ+NuuWDBQTwd+0OT4qKMP/YPOk/YeRw
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0040fddae917bsm243714wmb.9.2024.02.05.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:58:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dt-bindings: PCI: qcom: move to dedicated schema (part
 two)
Date: Mon, 05 Feb 2024 16:58:00 +0100
Message-Id: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgFwWUC/x3NwQrCMAyA4VcZORuIxVn0VcRD18YZ0LQ2nQhj7
 27Z8bv8/wrGVdjgOqxQ+SsmWTuOhwHiM+jMKKkbHLkTORoxNZxEk+hsWKLgJ+Y3WnlJw5i1iS6
 ckC4hkPP+PHmGniqVH/LbN7f7tv0BUo4wX3YAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cH+IHSOUNQiZJ4AhybvDpgnWU9mwe+s3f6c3uJA9pdM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlwQWNsTkpjOU033udu9EMASMSQTzqKKPYvPqZ5
 MNttfTlLd6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZcEFjQAKCRDBN2bmhouD
 13O3D/42wYlTvMtHDfXBvw5E92y4SVBEGHECIu6umfRAvo22q0SzjBSVNioqCglprOdIulxd7Cw
 lhfA7o6u+dvMYkMIj5XvBhsq32cDsQ6GRRvxKZdM5UFJgC9IyOLYw+eiQRfVWu68+CmefM+hd67
 VTtBtP6Vrn5QA7Jpk/3uMOXevV7GwKUG0/zynfXfAzK0jDq/gODBGkbYXhx6yXf4KfA/1+G9Wqj
 2h04PMHdK8nCiJdCP04Q3W3xU4j+rIKAMGncm/fWpaegEup434/iJk0zgHPALyrNfvyY2r6ZgEq
 chMPRISzABet7nUVoXxs78tkIA7xpPF8w0VP6D7a8rMbG4feY3BpRZU6o4qrTk0ZHecKdKhYE8S
 UIhm/fG7pPxp9RQjq3mbLcCK27mEb4oPZUYSh9S8v4OoB1g/ya7mEis+ihZ7uZ6fPxLp8ewVfAp
 53rF1xjmyAQrJWm6NwtOWs8nOl3UB8M16xc/4QXAkgUzYgm5R9ukF6WSYwHqdPX5Lman+YHvenY
 1KVmw06JOHn+ANJfQvsRkSNaxLhZaOcblL6LDzDQ+VFuYwPcgFi/wtww7ccNBMIpmxREeoVQ05a
 wYQRFFbkMd95BOSDu3dEnVhKfhmHF0rIGAlRwhfaYqWRosjw0P/ccUR45A22nGhjoZOn1XZh6kR
 25rWAipEPSG/W7A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Please take this patchset and its dependency via PCI tree.

Dependency
==========
This depends on:
https://lore.kernel.org/all/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org/

DTS fixes for interrupts will be send separately.

Description
===========
The qcom,pcie.yaml containing all devices results in huge allOf: section
with a lot of if:then: clauses making review and changes quite
difficult.

Split individual devices into their own files, so we get rid of
multiple if:then: clauses.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: PCI: qcom,pcie-sc8180x: move SC8180X to dedicated schema
      dt-bindings: PCI: qcom,pcie-sc7280: move SC7280 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sa8775p: move SA8775p to dedicated schema

 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 166 ++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 166 ++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 170 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 106 -------------
 4 files changed, 502 insertions(+), 106 deletions(-)
---
base-commit: 664c838cd04e72eed58c3ad260d3aa38bf208af2
change-id: 20240205-dt-bindings-pci-qcom-split-continued-09aa02776b7e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


