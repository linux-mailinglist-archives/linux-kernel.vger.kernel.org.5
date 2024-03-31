Return-Path: <linux-kernel+bounces-126374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51C8935F2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9954282441
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C16148848;
	Sun, 31 Mar 2024 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JB3QMRin"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5F1487C7
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711919447; cv=none; b=j6kDYItFnrFQLj036XQb7yIbKLwsN8cknSeOoC91rMXciw9oVbWKYlQnhrl5PqJMlIWK0wgZ9WgBMVNd8cNGyxv3bCjlDPGOIg1dgIEHtHxrvoXKFuMfIShpr8IMoeE1I0q6Nbk9JRb6nRqrsKq+X+4H2rBvBAyXabXIB8kmVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711919447; c=relaxed/simple;
	bh=o8kBoQFm7PJzjXGqhBUMrXuaVG7jgswhUcwQnLTI4j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iW4jNQGwpRY4Ot7Sskk8zKuzlm21m+vJPSJs2pNz7ui3Ym2tsNjGVuj489Te2X07ihbq1dsGI0NeUZ8pAlJtlqpLvKJDI038V5O5e17tfRyh9BdqTpcBma9Cx2AMyTwSuNvzBHFOB7GpTbAnsRDL/NGUmD0z9nBDZEoahil0vcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JB3QMRin; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d247e3c4so3267974e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711919444; x=1712524244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDv8zJ/AhefbpJoCZDcqkTXe888nW/523sAJ1ru8rg4=;
        b=JB3QMRinYvRs4npfw/aOOonrd/y8fLUNV0VQaenOLIdGgpE95ZW5M+dlhwz0CehRB/
         TtlLrtyrtgatEAC8RzRfR+iCks7Q/eYCtlCwRFFnBmvivvoekJ/7c2DB0l1039P5adHI
         Epl7KDLr0gJmHJa/oBKHoiwJjol9CUF/j98LnnRBSjiOJJwOoBWFR2hHShLSoD29XQTS
         IKO52xwKJWMc/r30uIpIXhfJRe1fGudsieUGdWXfPnllHkJN6ExvxKbeZoqNT7BBqXgG
         i0M4ukP5tLkEoFUnbbgXNbJLy8cTmOgH6NgPktRwlMcpW6GGKOYBYHkj17tEkYAuJowT
         rjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711919444; x=1712524244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDv8zJ/AhefbpJoCZDcqkTXe888nW/523sAJ1ru8rg4=;
        b=lB3fIlZ3z+DdLeQnXUChTX3pRNXtPjE+g5w3KgF9JIq6m0CAi2Hlbl/TPkKYx0qBZ9
         4pXdTr8HR5Txh+kmph4tyZVcarHDK1+/z+2Ekp64Psubpu8fySCddFFXzJrmZST4orh0
         mAe0Y+TvF5W5/Wz4dsIAcsK5iWe9GBCyAOhZxxXIZxi7QZo1XkYzl9aUrbzvwruqjiNQ
         6xbC6F6l297s3Yn0mOvHWaCJeZjTaHnmU/AY/8+X+EYGR3V2ekPlR5YwfR8DwhfTcKy3
         kdK3m9+zetfPASDRvXbwb2quNqOSR2IFxIGeYd36C/C5g7Bzt0lF+EjSkRhYjKSO2i9g
         sRnw==
X-Forwarded-Encrypted: i=1; AJvYcCX3wbFT2keJsHfzBHyI5D0t5E4rKe2BWYhScNkKUF5XUErcBLCF4L1Rmx96wqz9VhTENp/Cu1gaP/qOu8jRVXf40ngN4gTRrZ9jONGR
X-Gm-Message-State: AOJu0Ywg239Gcg1snYIdTVSJ5ASmMqSu5BOkey1+paxEYO5QpIRIYGEV
	KHOsPnnEhcy7JAgjFjSF7LDr9iDRrBU8fzfYSBGrmasneBdK8wXS8kEA/C4MzFY=
X-Google-Smtp-Source: AGHT+IE8zT3MQMl/IwbngIjgwWHP8wtQwF/fWkHqwfEpgBgp/YH5SLr6ZrCust7uwCAJ0sFmsL1G8Q==
X-Received: by 2002:ac2:532d:0:b0:515:89cc:26ab with SMTP id f13-20020ac2532d000000b0051589cc26abmr2589711lfh.9.1711919443963;
        Sun, 31 Mar 2024 14:10:43 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i1-20020a0565123e0100b00515cd1d5c99sm1033553lfv.85.2024.03.31.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 14:10:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 00:10:42 +0300
Subject: [PATCH 1/3] dt-bindings: remoteproc: qcom,msm8996-mss-pil: allow
 glink-edge on msm8996
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-msm8996-remoteproc-v1-1-f02ab47fc728@linaro.org>
References: <20240401-msm8996-remoteproc-v1-0-f02ab47fc728@linaro.org>
In-Reply-To: <20240401-msm8996-remoteproc-v1-0-f02ab47fc728@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=o8kBoQFm7PJzjXGqhBUMrXuaVG7jgswhUcwQnLTI4j4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxrnxaBJc/91LulmKih/vmJ5+cud2XaXbSIX9X2Z1tj9I
 a1+HbtoJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmYpbFwdDPK3j/uCXz7yN/
 1xj8rnVwqwo42Sxjl5U+fZ3UZRPtzQ5t534w5fwIP9R3ykGoMG115N1Zyunv1wbIdH4NzLbcz+C
 c95Pj8cGfJ/n+CWS2cV7mcc1V87Zs8r2p3DHne8Stu2uVouosle63nC1Q4PjFuU87/pvBbfvnLT
 fO2AWdeb9xmdTsXVfiPIqyX6mp8CcUsDyaEON6vYApr5vX2kUhvHG6l2bw9vsblnhf27r7rIzbj
 g+F1fYCpaHZAj56Fy+d3z0/ddk158VuO8ukoxvCpZ/lLo6ZbieWc7N0y/Kdunc/z+pwSm2ycUh9
 fYBX+5ZIqma6QPyq7FVd+2LLL71/t6fJq3aywU8Xl7pdAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

MSM8996 has limited glink support, allow glink-edge node on MSM8996
platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index 971734085d51..4d2055f283ac 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -231,7 +231,6 @@ allOf:
             - const: snoc_axi
             - const: mnoc_axi
             - const: qdss
-        glink-edge: false
       required:
         - pll-supply
         - smd-edge

-- 
2.39.2


