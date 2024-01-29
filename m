Return-Path: <linux-kernel+bounces-42812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A6840715
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7E292CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2290657B5;
	Mon, 29 Jan 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwuUF+1p"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DB64CF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535296; cv=none; b=GX4N6PrfPiIBCK7esYJeMlMVRsjeI30+Geb5yv/ZCcu/XrtyCXfaPo8aVxBx8AtK07udxPEAml/1H5t6KxlMEi+TJr2v1k5EVOj952ldDm5Z8gAP58C+O2t0f5DJzH0geeQ9Om8bhGP+npI2uojY0ZTAwvBoStbEDumsVXYfiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535296; c=relaxed/simple;
	bh=flicCfqngKIW3zeJAOSjBz4FeMqtB9eKYKJzdn+m+m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E87mocDmOI6N4apz4CQqdcocnZO7xQ8vTJOA37UOYodOxEAps8pu8RyIBgUL+q9HfqrIiokHY1YgLVMYydnap1joybVG8It/BDDCGsT9/Ye2hXlbTwvpV6MYkB0ngANv9EWHV1+TBWYeyIioH5Az0pZn6IyfjCwIFyOO3keOJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fwuUF+1p; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso315444366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706535292; x=1707140092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ4qQ0eECaBxK5wIYNRpchzy4eFlwHhLiJlk9IpbxIw=;
        b=fwuUF+1pyMIG9H4Z3J/lcHY1Xq1DEpZ0yDsP8yhUTBtPk9fM0YofeZXquwpOn9PsTz
         pbA8y1jK2r2dsmnRHKhdWXgT0RDlhzxyIQBRUZrs+fNBS/jx0KunKkMEr1CLuhH1NPJP
         O4+vq9o75mNsuDTIlsFMMPVOmYdYb555q6BBZ/f0+8wWuyTevZ+LsJxzRdogmGqg+YlV
         4UoOBAHFbWMLIiy2/5LH/8cJg9Nv6NzTHLKoDmnPOVRYWfqCxiyHHvyQDaAnsAtf9Hae
         iQEBpdCcFIFeDw/YF/rBAWMWHkD9Hf+HlTwzn6ND2rVGgDFpncdtnrH5Yhl05bzQpEfe
         f87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535292; x=1707140092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ4qQ0eECaBxK5wIYNRpchzy4eFlwHhLiJlk9IpbxIw=;
        b=HbT/IplkgeKwv0TCueQ6uDq6dJ6BkmuRWq25f2vYZSKnzHMVDXE8zKO8eHgQwcj0nt
         VNCLW6rke/Vpby+FTOg6HPubzfLNPW200YcHSrDaLpDHSXFL8KJwtow9UvB53PPcIJx2
         T1jS3Ufctz+uVJQf4XzNdEtV6FqD8k3k52jQ4EAJVB5H74UXqd2jh7vAlmLzm+6O9jSh
         Ff0aqbS/3iZ0T8ie+LS2BFnKcm7CqOiOgfiPAVXNJR3E7YAIMvDkkzzYYikUDs7BvijA
         ky3MeEB6elJ8UB5VKNbWHLILWY4qeeKiUnXpiAv4zI29+Gxl1UlhHy4LvSEx11dlm8sj
         wGOg==
X-Gm-Message-State: AOJu0Yxb+VbK045UWvrPYsYD1DGCYTE+ycLh61IbkAkJVywwUQDnSKr7
	SqiNg1dN5BY1Pmf+eOCSGyFXcroM/pxu8IrMxrGVbdRsoEp5f3CFd9GAnh1X/4I=
X-Google-Smtp-Source: AGHT+IHCog9ng7nG8mwlAJ0EvaLusfKdmX0v5Fypp66prrrEgSafknWTbNyzVpYHrU0T8fbS43hhDA==
X-Received: by 2002:a17:906:fa97:b0:a35:9e3c:80dd with SMTP id lt23-20020a170906fa9700b00a359e3c80ddmr2719499ejb.5.1706535292479;
        Mon, 29 Jan 2024 05:34:52 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a2f48a43c3esm3911483ejc.7.2024.01.29.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:34:52 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 15:34:37 +0200
Subject: [PATCH 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document the
 X1E80100 aDSP & cDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-remoteproc-v1-1-15d21ef58a4b@linaro.org>
References: <20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org>
In-Reply-To: <20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=flicCfqngKIW3zeJAOSjBz4FeMqtB9eKYKJzdn+m+m0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt6l2phfhnajXDLtV+vW3u5qyfRgKguQo9eLiV
 ojQee/9tEGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbepdgAKCRAbX0TJAJUV
 Vjw/D/wNbhRk1lwXE1/jRT3HWG+Ko4TDujVe3Xak63OUDc+Y7k43YBNyJ8CSYQOFz4ONfpWG/Z3
 Cjn02Yu8FsycMQKIglZxHwRgIbV6Di1iKBNjVclzUGM2+bgDXh/jtyOZBRQehJ39BaA6/e58EJW
 Ij/CG15mpzZ3VVt11ACMETQrWqSypaZoeAbMCHIXHWBkUVY95qMIbsKbwXy4SD9Y/icqVCuI20T
 iiVf+cpSxMLpbV2IhfYcrAasP5mofTzLCeOQndI9cfjiTTjvVeD7aV26/eeP+7Ev5uUMiBcb+m2
 qKUf0/y5OIKll5GmIMhIx9rw+0fnVdvAuHppBOpk1EkNgQNjslKtWbncKzaa3nlOyXyJnmrGY1N
 AccbblLclG3HTFJ72KoOi5d2I8XPTZ8CHn03FigoULtZT6ZRC09Yxs0wNoqj2jPvUTUEQiu9Q4o
 75Fbj2I/i1OwZn4D17LigtUwGUM94J9e4jjuWb9pro9wBgT1MgIN/NfLf0lP6hpavoOdGsYbN4O
 Z+VshdNdJkc3aP09XizSJ+xMSf54YGL+diF8xv6XU+bDzTSzIfR0TTkbxV2LJp3kw7moCjVcdDr
 Oc7Nv1eOC5VBAaJL8Z2jioWiube86JXhOe0HSvQzOJlFtyRiMH4qeGnRDURL7RVILrccgFHb0Lt
 K7kboPFr/m4zbGw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the aDSP and cDSP Peripheral Authentication Service on the
X1E80100 Platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 58120829fb06..95ae32ea8a0a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -19,6 +19,8 @@ properties:
       - qcom,sm8550-adsp-pas
       - qcom,sm8550-cdsp-pas
       - qcom,sm8550-mpss-pas
+      - qcom,x1e80100-adsp-pas
+      - qcom,x1e80100-cdsp-pas
 
   reg:
     maxItems: 1
@@ -63,6 +65,8 @@ allOf:
           enum:
             - qcom,sm8550-adsp-pas
             - qcom,sm8550-cdsp-pas
+            - qcom,x1e80100-adsp-pas
+            - qcom,x1e80100-cdsp-pas
     then:
       properties:
         interrupts:
@@ -85,6 +89,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm8550-adsp-pas
+            - qcom,x1e80100-adsp-pas
     then:
       properties:
         power-domains:
@@ -116,6 +121,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm8550-cdsp-pas
+            - qcom,x1e80100-cdsp-pas
     then:
       properties:
         power-domains:

-- 
2.34.1


