Return-Path: <linux-kernel+bounces-72964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CB85BB38
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBAE1C236AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280B67E6B;
	Tue, 20 Feb 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUETALiD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8767C5B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430303; cv=none; b=jdLEjo7Q/S2X5md0qA3DL67lGB+C7QnupuYgOSdrdmTiBdXjxwXPKEBRuXSX6XO1MZjOATtfnAQhu9PeH1y7qX5a6CmxakJaE6NoJmvYMKNvBwFzhwKo5tfXlDDHIuk1aLM6KEeEEkEzxndym6dTezr0C9g73Fm15HRJGVqWJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430303; c=relaxed/simple;
	bh=UEn883fEvn74EKDrMBY5HRtTZ852wPrXNTB+0TMl9N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQteAjWHvu3871lFhpcdnnp5Tfc588oJ0Xhonqe8h3KVi/XO8ofTyIKs3ygBGwiCjK5OhzeD8Inlo/g+4H7HVHjc+iZl2V3lHMAx3YnQ4Vg9JyUtjH3cZipUXXrL3KiAOWYaLNXxJXCwAJ1GtoEe4ejtXTWx/xW65qbOaZBodVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUETALiD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d1094b549cso78339251fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708430300; x=1709035100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXniBx4zGce2I+zUvQZeh9F9TJPf5+YSFwkB/zgLcpo=;
        b=DUETALiD9qXQVDYD9pVRAaxQITLJ63A4i7zvtPEATGd8LymrZ5ZIz+Ws5fPXt/at5z
         /0jM8L0ijfB93+ZMclZiG7Uq/YIk9ArDwYOVj4BsX4DCwHXL1VFaWBRzgL97dU/yxZbv
         qQDl2xIegP9P9K/9lorEZhZ9jtlBbXWE+DPplgWnZH5y5UUrX4GO5WYsj7V5erSgRgw0
         FNiZvktdosiu2Kft0YRr0UnyZfQ8MU23iBcyzgKDrjW33DdXtFv+uPiVyTgh2HzNsxdh
         yr682hti1T5fU2Y99QAWtM15PMEUTew33KKTilLsMv365u8gangbfVK0vx3XHrcESHgk
         PMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430300; x=1709035100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXniBx4zGce2I+zUvQZeh9F9TJPf5+YSFwkB/zgLcpo=;
        b=cEqa2JkUPDkNRZHyUJkvUaZlriz8Iccq48MIcyHob3+SLxea74PmNL/Yb+J0Q+XrxU
         xKdRHUyupym9Aj1A143WmgdIMfmpM7PRCE3+Z9e6m2EcQElRgy8rdc06WOCria/qIrnj
         PujHGZBe1RRyXO8vP/e4V9OUC9f5C/oDsbAPoEGtba7LewkGwCO83CMryJzXhjhmt47x
         4URywfqS8rtubBwekY2WT1/O+5xfRuIzCkzG+whuK1YOR2YvDHRMiL6/XzkV8oHpgbWK
         /+IHBnQMakBSLYeLXSc6uvVtCF+X1W4B2JMgPU4ujtPDo3nLGsjCPXKetQk88kcUFLuF
         gBug==
X-Forwarded-Encrypted: i=1; AJvYcCWYyvixHtQPDLwpvgzsOdlKHkFvAaA/xmkTFMG1Pncmf2Cssxaky4lcypVNAqOT+uFWGA57FDeAmmDtLVUOLWzbOb8+BRiAt4QFFl0q
X-Gm-Message-State: AOJu0YwVC8hvrja6RJ7qeoTENIPm3/70OdHNID9xcwiOa1Rc3fNrUqol
	LY1Y/9mGYM7LpaLvfuzirH+m3k/0KkMIQNvMxSAbQOyr5+1JcpbRH3iLfNpYAgA=
X-Google-Smtp-Source: AGHT+IG4jWWO+KknvlzpM+Lin7JrB+HmfQsUsz/gayBqrfoSc7B9J+Cnq1Ez2e+vd4q1YCG4NdRrVw==
X-Received: by 2002:ac2:4241:0:b0:512:aad2:80c9 with SMTP id m1-20020ac24241000000b00512aad280c9mr4291841lfl.27.1708430300290;
        Tue, 20 Feb 2024 03:58:20 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id hu11-20020a170907a08b00b00a3e0b6ea9fdsm3806200ejc.26.2024.02.20.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:58:19 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 13:58:10 +0200
Subject: [PATCH v5 1/2] phy: Add Embedded DisplayPort and DisplayPort
 submodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-x1e80100-phy-edp-compatible-refactor-v5-1-e8658adf5461@linaro.org>
References: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
In-Reply-To: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=UEn883fEvn74EKDrMBY5HRtTZ852wPrXNTB+0TMl9N8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1JPXL4Ic8N92mDtTIZbPRk9h2SHNRLPdcNxki
 2nwDS20y+uJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdST1wAKCRAbX0TJAJUV
 Vth8D/9NTlqJoCtLixiwCSoEDO+8wgtAsvUobYA3/01ndpgPwajs8duOOTVTUd/F1pAvwOd4aYd
 fEw6G0L77T4oaedJ/tLeGbVr2oo+BtxtYAdzQDs6I0ZLLF7J+P987j9IZdtSz/iG51YQKwYK/1c
 kqDYEnpSQLG4V/0ItMUqOsiFzGvjuI7tMoS7ieoM07EbfRmf5q0Qn/uP1oMscBQFPnx+JKiEKM7
 VzbDetS33Rol2vbz6/P1nitKxR9ApL3ZENaCVvOGd1fCGiZmLbH++fnb1+meX98Zr9QGY2Rb4zg
 80ri+T/edvDFujKP1Z6NvI6Fs/ogyYzvGFxd4Z5MQxaKwxgSJJHamT1TQ/0OgvG236Fvd6QKakP
 iAC4llFD4+nd/xqofsCxh76F7bksT0ps05VgAUvmwKE6pn7Rsywj6p9a+tl8si9AREkg8S9dl19
 vmWSakQ9VUbzanGQx+JxkTysGv3v4YxC7t++zFvESIijWYcp3l5gbFfl2RClc/VdO9/aACXESGd
 ZqiXo1P3E0nKYbsQSf3c/gIJRMN3VYxOHaRbvVw1NCfC4t0dep+LFtLgB8nOBrYUXI30qrgeSFq
 FD12D/dF7xLE2uaPUPfryjE+J08evl3yXtHYtFqxKbplCSCZrD/WdfoYwqDGULg9E1NZpTR2ujV
 0KyKifVBRS5Z8sA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

In some cases, a DP PHY needs to be configured to work in eDP mode.
So add submodes for both DP and eDP so they can be used by the
controllers for specifying the mode the PHY should be configured in.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/linux/phy/phy-dp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/phy/phy-dp.h b/include/linux/phy/phy-dp.h
index 18cad23642cd..9cce5766bc0b 100644
--- a/include/linux/phy/phy-dp.h
+++ b/include/linux/phy/phy-dp.h
@@ -8,6 +8,9 @@
 
 #include <linux/types.h>
 
+#define PHY_SUBMODE_DP	0
+#define PHY_SUBMODE_EDP	1
+
 /**
  * struct phy_configure_opts_dp - DisplayPort PHY configuration set
  *

-- 
2.34.1


