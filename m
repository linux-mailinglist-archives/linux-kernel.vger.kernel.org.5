Return-Path: <linux-kernel+bounces-9736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF881CA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956BC1F233C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAE1C2BE;
	Fri, 22 Dec 2023 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr4ChxvG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6718C07
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so18471985e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703250108; x=1703854908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXniBx4zGce2I+zUvQZeh9F9TJPf5+YSFwkB/zgLcpo=;
        b=Jr4ChxvGiBJqFOCxKAWeiqwe55mnRrVqPNgTMFVemXy5pOVuCnf2h8mGwGEJ+fx0Vl
         yv3V3iBcD3V+pup0P6/6QHgWwoxUoRENjsFbHVphG+IsJP26FqhGNG0Kpv9iaR8szA2v
         +1LE+4vFLdM+lClYtzz1F9mcsL2JE0sCL5ksMbceufvHyPJ3B0sC/ect+bp2ZMJaWUTt
         NRQ7sD5NVxw4u9fQAp+pDrAE4h4yVk3JOeQcQ1QqAvgndC/WKjBsfYO2Thh+9a4r9Rd6
         qV9vzFc7wwUEOl/bm6lLmCoQDXmYIQ9ZwqEHgysDCgD+5N8ByWiEqfDcLueIgnW98FOg
         9c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703250108; x=1703854908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXniBx4zGce2I+zUvQZeh9F9TJPf5+YSFwkB/zgLcpo=;
        b=NqW5ETuy9YrOhDu63Q2hEL5rixqxCk6G1uX95TDlBovKzQno43Tcuumuw/s3oqDbX8
         NBbiVB9sucNolTRxM+U77tSL9ECmOP/KBfIzvTXI7i+lIAhPTKc8baXn/XKADCkQRBcf
         d9MKvQztquWvRpxEgGwuWiQdDAa7KK328MZiqi0KehZcFe7BHQvj5gx2NAqkkFC9dUJu
         uOYEt/KfNY4ecdyCI4NWwnEF6Viyfixs4IT7KN+m30WzeThqLczi+VZjQxKL+Wc+DttC
         KtnV1MqNmt2yEw/TDZRJUf823k4F20P2AcDQ1Bcs/xgyvMS8biOebalRevPxbWTfEeMp
         xsNQ==
X-Gm-Message-State: AOJu0Yx+s1xB1ovgTUAVji65ZHBjM52tQycFoXaX5qy00uZdqfC1LpPQ
	OA2qyzRxIVz3SXj3qLjfahdRKJ1ZXAuVhg==
X-Google-Smtp-Source: AGHT+IGsEXvrlwNcqAyZkLieozWSlT5FA+a/oVszUAchky4spis3eLBHjwu1NDeqr4UGtWFkRjdCXQ==
X-Received: by 2002:a05:600c:245:b0:40d:2765:d8c0 with SMTP id 5-20020a05600c024500b0040d2765d8c0mr690457wmj.10.1703250107987;
        Fri, 22 Dec 2023 05:01:47 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b0040d3f4b1c8esm5375631wmq.36.2023.12.22.05.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:01:47 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 22 Dec 2023 15:01:31 +0200
Subject: [PATCH v2 1/2] phy: Add Embedded DisplayPort and DisplayPort
 submodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-x1e80100-phy-edp-compatible-refactor-v2-1-ab5786c2359f@linaro.org>
References: <20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org>
In-Reply-To: <20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=UEn883fEvn74EKDrMBY5HRtTZ852wPrXNTB+0TMl9N8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhYi2kGCVeVr3XIct1HNI8/yl9StFcLZLAqZa2
 L8xEEaGIAGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYWItgAKCRAbX0TJAJUV
 VmxnD/4nG9MSB7dv3spF3zt/AlT/w1o53NEUjsHuXJTglSAQ1hH0b1+HkrHEwFtkhmBB7N/x1fd
 AeuC+9VOtcFmHNo+INgFTNXhhjgVLoAvjt5Lsb83TiaxcxOpYUDY+C7B21gGrgfkSkKkW5tBtNO
 YLpCMyapigNSLLsCPacsvXtsX0mrnx0mS2CgBF7zXRTiKVr2aiAdG5wwY/f6Xy3JG/dUu4G8skw
 sJlFUdB0DVemy4S0Swr+kISNxnqbEYFMGswpfmZlzd66FdR4oH2ogdsU0PAG3jsjNNPU0P1dB9S
 H1C2tFcIPAYO5Act71nK/TWlca3NsNRCbXTLq6Max+7F5rtexvEQ7sdMwM3XMeuHcni0GgDe96L
 6OI2GFDOaQfWCuN2t/9dIp4X56NulfWmLWVUL/uE75yOXYN3+0sCQptI2j+qQhOTccrz7SV9YA7
 6DilWe8D50kQk3ood0H7E0n4oN7ilgNnV02sJ/U9tMEfBB0hIHbAW67ggnIQDNos8qe/gN9jUQ9
 uUb93v/GUaZbKuwa/LZ6n2aG9TdKDnojqPiika6s5NvNL8jY8nn4Jll71BRBIY9C6CxgQrGqqK4
 84E6aW0rgqgx6N4ZLNmjU/G0vbRi8Q5+kYtl7JZzr8sVKschncVvr7DNpTmMPun67SKMJmcpdHr
 ZxWTUYmxWHGkovw==
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


