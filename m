Return-Path: <linux-kernel+bounces-11029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7608D81E043
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EE81F22177
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A752F6D;
	Mon, 25 Dec 2023 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgqEGXn8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A6B51C36;
	Mon, 25 Dec 2023 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d352c826eso50338045e9.0;
        Mon, 25 Dec 2023 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505817; x=1704110617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBMfr2lODPMTcDmhNi2VGEJxqKx/p+20Q8QVTg+VW18=;
        b=JgqEGXn8sT9eB4/lw/vzJGKsuFl5yGcIKCrSGV8rkA1+1FWaQN0/hruFcNiGXTc8Cp
         duoQu6mKTucFPG8qVRHrVwqMqY+BCbdf9rxvicPdrrzQsm7wVmEwouTdRq5+TPHndMFZ
         klSYbRISlqvlOxQXAkA8tLU5OnnpJixu8XwR0qtrDtnQ20pzjVdg/4YG9n45P9cWY4A6
         oSTzTsG6X/godVzYpJT8LuAYjeEqU5wJ55vT6zHppzWQa5wxMuvVw6HtITj88stRW3i6
         KahcAda8E8zcg5CEmCHRAmZibzKc2DPRYEDqRMlP6+mFfMydVS0UhaMDGWB/dZb7HdZN
         Gt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505817; x=1704110617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBMfr2lODPMTcDmhNi2VGEJxqKx/p+20Q8QVTg+VW18=;
        b=oZ2Oc9giQRTXsVpvhYPVZ4hWnPmQgodNCikztSz06JqYp76bB8va80Olbp577ylMJU
         9fPYbNYUydKd7+G97hH9gHts2xR6dvb+7WfywIFy66b1zT3x4hrW7zQ4zkUeFfEJ+nSN
         rml4jtK/7Jd4I3B31Z/0iPIF/zYXy49eWrecUwMK/VUsItav/vQMOzXlamr5S4W83G/3
         b5pXLab9b3BqFfl+WwsEmxNORhV5xgDg2Odw1jc/uvc8+dKvFkWJXznEaczQM1vBHnNW
         awwBXEtWmXgtImSWqgE3LHJd3nQ8hER94p9KsaKK87x7D4vprNGT4yOYdOb+7cZ56laa
         jv0A==
X-Gm-Message-State: AOJu0YxlWMkaja3X+Ei+mfqHXus6iKxukbLA2ozVAdXhs/XCjB7Q4sLi
	EpJvXh7bPEaA6tb7SxddC5o=
X-Google-Smtp-Source: AGHT+IGfqoB2JSmAZYfEAxqhXVOlF0JJXCI1ezf7LSzIcBi7ZdJYjof7SQRLfWvwB97Fo+0fQFZj9w==
X-Received: by 2002:a05:600c:4685:b0:40d:39ef:baca with SMTP id p5-20020a05600c468500b0040d39efbacamr3117945wmo.167.1703505817073;
        Mon, 25 Dec 2023 04:03:37 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:36 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible string
Date: Mon, 25 Dec 2023 12:59:55 +0100
Message-ID: <20231225120327.166160-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the UFS found on SC7180.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..9a4f2b43e155 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
           - qcom,sa8775p-ufshc
+          - qcom,sc7180-ufshc
           - qcom,sc7280-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
@@ -214,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc7180-ufshc
               - qcom,sm6115-ufshc
     then:
       properties:
-- 
2.43.0


