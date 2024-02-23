Return-Path: <linux-kernel+bounces-78503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8376E86143D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E9E285AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8784FC7;
	Fri, 23 Feb 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GS1oTA5X"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A6F9CB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699091; cv=none; b=lbseOIkLrIPBcaBG2m8HfgtJgg/oS1Ck2fExAEygZuEDn7d39yJU09n8L8A9p3TgRwT+h43Qz4UTFBjfmnTjYMMLcnmjkqN/Rmvlg+pVMwTtpopp8hvaRoZXgbUqIH2b0Osw2zDSrl+JWBbdTWD4tHjjM63KCaHXZBveF+dlxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699091; c=relaxed/simple;
	bh=smlb+jj6ALx89IsDFkX16M4a2mpAcYj4/rz9jWdmAk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shtAabqQW8+XPs817YhVqQ/yCB0rBv5eKmdwiu0ifTqcOqAKd+HE26gj08cxf72fbg1swNwuMbHYEOryv3ohofEm4oa2Q+Zv+Tw9LymcANBpuJ966m64IuhtCeVINhJUqxZc0uMY2fbdXiMukTvQkzUoSkMzW/MmXDnbw3dEEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GS1oTA5X; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5654621d62dso909030a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708699088; x=1709303888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCL0C1o2euQ75RV/p2dm99BzWuaTT0CZ7OauLOGfO7M=;
        b=GS1oTA5XWwrpL1ZnVtSxSTX7X8aO3RA0Jh94y3PbbDomKdDi5rav92o/MpMhgByI88
         lroPkhr9+uKSoHVGJ2btf7OyLxS/Ji4Ebire9E4Ge0AvRXxpLC1gz/SZ6sHELrFeARoW
         1scIYmQkW5+HVK55VFOS+krpOmHT69v8eO3VNqig8ZvBKynvWhWYYIzabgAYVPsP+dLX
         9Iq0qBbXN837mQgpeAwuSTiv3KWe78BVMG+h38CSPH2dNKFXcDDARSIapSuH3oFodO0/
         r2KtlCQnG9pxNhJnYhgmniBAb97keH2kxKumgvfl/mx/SkRKRim4lem2NdgNObybJDI5
         G/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699088; x=1709303888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCL0C1o2euQ75RV/p2dm99BzWuaTT0CZ7OauLOGfO7M=;
        b=dMxmBRvhP4BE+3d37wExvJPfdMSaJscJQsBVXJVHSHzPMoFFoBu5KwrWr/5bbQ4KDQ
         MA8MVUbRntjVsNhsIdB14thLmqfXzQnw4sVnNQV0FuhbJeeXQl1F56oh++Ols+OolCZI
         I4uVnitrQDq1VEOPwpxqC1E6A0elwNChqew0A9a2K41FQHK4BsHDgSRevOl0hAzKGS2D
         wnX6bFzwsuVjMW5eyIU5p2BFAvPF4aiNhSapBVjQ1GI5Q9h0HSTiKFp6qypUa8DHDZQ4
         Urt3/3gqRkTJ52nrQ7d1zkYbe4DF5dm/TufgCb9wS24afkoygfNTBEhozh8O6Rvv6XvU
         SaPg==
X-Forwarded-Encrypted: i=1; AJvYcCX+OcmE5EUb69BgSYK7N4y8KaaX/a5Rk/R+ol+3seuPAYvGlU5y1xIv6KNOxgH+GLZ8IDBPkvGlHUdQKuw9y0hQ8LsL3xHBQRgaD8/c
X-Gm-Message-State: AOJu0YydAWv2ddr4UjeT8rZ2y3vvsNKn/mIhH2vReOER1uD5uOqEeEAq
	sLkU1CSEDeynFWNfq1jMsf768NtR/mm6P1aSsU3MJrghyPWOi8OPUqO4mUT6EA5OQYauQY2eoRD
	M
X-Google-Smtp-Source: AGHT+IHPUKnec4vp3f5qiBscb0t1cwzYv/Oy6tskt3QMo89Qid7i6Gaa0IOkJKDWeBVxxD61P+L7Cw==
X-Received: by 2002:aa7:c0da:0:b0:565:7ce5:abce with SMTP id j26-20020aa7c0da000000b005657ce5abcemr30826edp.20.1708699087859;
        Fri, 23 Feb 2024 06:38:07 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b00562d908daf4sm6637536eda.84.2024.02.23.06.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:38:07 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 23 Feb 2024 16:37:55 +0200
Subject: [PATCH 1/3] dt-bindings: arm: qcom,ids: Add SoC ID for X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-x1e80100-socinfo-v1-1-be581ca60f27@linaro.org>
References: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
In-Reply-To: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=646; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=smlb+jj6ALx89IsDFkX16M4a2mpAcYj4/rz9jWdmAk8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl2K3KhxV7BMymkcsdDl3aXEQWpIP3hmECAIimh
 8SSm/ig07OJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZditygAKCRAbX0TJAJUV
 VomZD/0dt8EI6qxwbRB1AE3odICm8+vlJH5nd5BNHVagqfuoAJq+j3u3x4ID4//iydZSrN4PTAc
 Nze5t+s7XDF8ATlWFZPdUzhdio700BcQgJWKPHyY7ec7lJfxSI4WyHV7dtCWibuC4QfaavYoKHI
 yLErqRhrcbOVAiKrcBCTIZ1odXmBSEc5LxSuExhxIAN5IC9Ij2ArTPRDlHSR8d8nhQXHCAM9GA1
 GsT8+E4brVmTh5GwrEGGVaWe20ypp1T8MDqM/oLUZ2/EdhynJB4P5YINNbyDpDMs/zwP6z5k51X
 iyIIIEY1j57FAAvW+9gE0Djp4CsIr7pQtLotD5CixFiiw3yZpjYpuWMiSgCDbkqW6Rbm09MWunk
 gdYi8cMekRSVRFSMxqUzG1H65Xra96LTRSDd19wQf80GcuwIUCXKafzriRhsuV6yur8Q9c+YPeX
 SV+kvTINkDEkAHvNoywyaIjYoBUib4fUtY8VkuGLHYMGHOJqb3C+7WMbks+LfX/rPhJqDo+cMiw
 e52HNGM/WBpxGtm71xOl40JtgJYpPtMKudfEIOhLg63+0hGXWnQl8rM7xjOLKdeICw1icUYI4tF
 rd0k1sSjMVPZbC+UuXdmJ0y4XRz0wHGHqbOx74MBn0IxaG/3FJT65leIZOaHSBwUAtEeLHUGBhg
 y+caJzAW8YSgr8Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the ID for the Qualcomm X1E80100 SoC.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 19ac7b36f608..d040033dc8ee 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -258,6 +258,7 @@
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_SM8475_2		540
 #define QCOM_ID_QDU1000			545
+#define QCOM_ID_X1E80100		555
 #define QCOM_ID_SM8650			557
 #define QCOM_ID_SM4450			568
 #define QCOM_ID_QDU1010			587

-- 
2.34.1


