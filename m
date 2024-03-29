Return-Path: <linux-kernel+bounces-124258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043A89147E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066C1288B97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7C43150;
	Fri, 29 Mar 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="V3bWzeR9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015640852
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698361; cv=none; b=JGBLllpvmUSDeKtgKmg3wUWz1hKtGrZkFdv3Iq2N2AkDo0k8myJYoIWGNI6tDviH2YrW9dPANfKetoZ0/9HO6lXN0wvQi24wmFiT4w7dIa3q3zIoz5lKOLlfVKx2JGdiMAG2kwYxS0bhtHHVRBJaL0t0lSvfCIsJRc8su+T041A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698361; c=relaxed/simple;
	bh=QTZb3SliXj7z8d9Aptik0u48ClR998kWst6mXqAlvu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dn2fa1xyRIKSWlBDRD+BslbIUfqB4yBQUotHe8IFXIcMHECcCNXykHWPq+49hvSYDOwlQNoSSU4827kCG6u9gJohdMQl4+Vxbe6qqvs4xG2gYDrYIL1W5Dw/Y5aUUhu6QdWSq6YFq10Hfgh2MOSWvzoCxwbiqIY4TPoQhYfn7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=V3bWzeR9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4e28b10a53so130293466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711698357; x=1712303157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktUevP6u8w4KHYW86f+K8GcdXFfL/uIUgZtZWzBIQhc=;
        b=V3bWzeR9f0eGWA21t3UsW59agntbPiPpdv8LziYG5lDgDALT2m+yjZzIF3OyUSzJYI
         Gv7nCWrXjkGfebsH5A2YZEZajGcDWidzYD0492Qi27yNfIDWwsmD0IiNs7ZUOacstv5/
         LHRMDjxEjckZC0ZDPq+2SmHNX/RwbSYx8z2UtuuPcX3twpPpzaP1IxjAvuYNrIjUPvd4
         VawCNcLIhVzHWAhythuHDavCP1xlvQ7mxzJ9lZXaMES0n2ACm9G9eDgyeqMI+5S1qm7C
         1f8IqtOpi5WD1728lwHQa5lpfaRWFNDn9OrTqT/j3Ssow1e74dGK7qNimPA+SIjYOzWJ
         8fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698357; x=1712303157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktUevP6u8w4KHYW86f+K8GcdXFfL/uIUgZtZWzBIQhc=;
        b=xNoYatbZsyucjIjL+7B+g/64G9ONPt7kJ5Fk12JA7Erfujs/tMR/7/qyHXsjibNkdc
         qgpV0BCpbGYqlZ5VNRIVkH2+Ru9bPtveX9idbnftl0GFAo2voKunfuusRVMK4zpjsiVI
         4W2JikYrjyKhSUisl1cOyy2DeZ+fQN+8qlxt+/SwI2z/REMCKtImgcYLhXv/i1i02BUq
         l7ghk9JfUOnNrLvfu1HvmPLC5iR1OEStIq2e3tGoxe5z6BIXxZl+MbSIF15zzpQD5JXl
         KecCa1Roo+f20R6VhY58bzkzN0tnKOLP+MY2UKKO3GJmY5oZUHFveVmwxXxT1DWfa6Qb
         +62g==
X-Forwarded-Encrypted: i=1; AJvYcCUvzygJFNbaniHSRd7ABYTShEyDmfcR4/DI4i0FMH8tKpBiitSws1fw6NTDvgja/I+fI8NXk68sF6KEhkPRP7xEDSDUeTGAWqQSvSOl
X-Gm-Message-State: AOJu0YzRoaIMF/5ncNvOjbvUgr0GxAfQDLP7pOABnI5VuPcnTEyuz8nO
	krOxYUxHjAdKppLLNXVZ9IuzDxa+uVIVX+COdQW9so3XLgtzqBakjPcCRHOW7PU=
X-Google-Smtp-Source: AGHT+IFa6363X6GOmkR4BsEQwG0xCUHGlbVBpxaeQsPeMOww1hYOuly/ejvvRwJqZ9obHOITNtL4iQ==
X-Received: by 2002:a17:906:5053:b0:a4e:2a62:7eb6 with SMTP id e19-20020a170906505300b00a4e2a627eb6mr863656ejk.51.1711698357114;
        Fri, 29 Mar 2024 00:45:57 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00a4e24d259edsm1382737ejh.167.2024.03.29.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:45:56 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 29 Mar 2024 08:45:54 +0100
Subject: [PATCH v2 1/3] dt-bindings: display: msm: dp-controller: document
 SM6350 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sm6350-dp-v2-1-e46dceb32ef5@fairphone.com>
References: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
In-Reply-To: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Add the compatible string for the DisplayPort controller on SM6350 which
is compatible with the one on SM8350.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index ae53cbfb2193..97993feda193 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,sm8650-dp
       - items:
           - enum:
+              - qcom,sm6350-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp
               - qcom,sm8450-dp

-- 
2.44.0


