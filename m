Return-Path: <linux-kernel+bounces-125297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD68923A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E51D286F86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474D13958C;
	Fri, 29 Mar 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObET4h/z"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212212F5A4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738490; cv=none; b=u+U1kNOsvft57gnKTpCjJq8NUuhbeDP/pUHfMPwLnP0R5CczFFrEyitY0mY00fS0ZTPW5XlTGghUeEs9bJ42fzS4/oKqxq7sydOY6vGdrn6gW13UKf0kwimXcCFNK83kL1idnpYPR8UksylR7wBCVOGZkzonOS6Vfjnr5bvDgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738490; c=relaxed/simple;
	bh=f1k2/XtnKKT0QabjDTtzy+0Tu+D0+1BkiYHMuQzuNWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvg0yj3Vo6x1ccCAPeersjaGGDh5S7sJqI4UTC8bwBdyUQwHBrr3L8kQbGU6iL6nKp64/bgueIpOpJXNEXvOTPdpsRXb5dKLiY8UtA510Lds2BMsVYjwOO+EEZGTAgZYuU74IBrbjb5XzXgmX7ewmK6cGil6DHdOh0vEyKmOBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObET4h/z; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51381021af1so3139965e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711738486; x=1712343286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lYudh1XGipLZp45Ed9irT2kjTBzp7nX6WUMRhG9/PM=;
        b=ObET4h/zHTBDBGOFoi18SCP36PD7ZFw2+PQzzHW/u969sM0WxoNbB+VRTJV/qK62dt
         hy48E9tqjV8WddKb//e1Uqd7fRzrNxjWuO3KDlgS3DgwL1x4ZCLp6RKZVv0NAuCRE/eN
         ipRXH2MvS947vf4FXsRY9tA3xnkEE/9/iSJhhkHKiEYz7p2kHKhaKVb+VM1RzFxTnnLr
         JO2ntd28gNScqer5BoGddqeJsqIUIi3AyRcwadtkpBS/CWbz7phOJqvAuqoKDFTZerrI
         +ZAPFdy0Frunsl7JXi1bi2aaiaNxRy1aLuD8JwPaEDVkDAArSNcDWmF/WoCTUvzAWcSw
         JvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738486; x=1712343286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lYudh1XGipLZp45Ed9irT2kjTBzp7nX6WUMRhG9/PM=;
        b=g4tcWJn4hRoKAyd0q9Py8eCLM6GfTrD4rXytwKpQOjLo670fvdVoPx3Nqk8/8zps2H
         rffKKA9zV0ipuTyMo1c29VWW4KdWodEU8kkxSONVTu9VkqZEOXBVUXwu15wHJS2BQoGv
         kwCHs5HenGQ/Z9nbs4ci//xbe0Wza6Zy0CzaEdD4CGX13DdMKfgUdJbJZ2EfPm6oX4Iw
         5TiDDQtUdXIy7Uqb2p990ta162fY5T69JF6gB7wHTqKzCssojft5nb049RCiuuUWNE41
         1Ko034NBUfrW9DwrTlgIUf8d1bHd/Hry1jUDPCO4044HmFmZX28NfTiNO4cMFBiHefqQ
         VbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmCwF7918NWamfSa6U8Ids/HIfX+2PxuTftu4t5h4lRGVw0xPOOulHSzPYIehbvdssxdkgYr7/9gnKSt05yIlQkmAFw0rmzoOwjm/y
X-Gm-Message-State: AOJu0YzAuVJ/4OKLA+T+fT+7qoEBxdTbvlRn4snfedsmaqx/a1oTlCxp
	soZaudCYnqJKzblLgQIxFVac6rGEY2GG3d/gK3v7LpmwsNOGOE5NQTwJwsNErkQ=
X-Google-Smtp-Source: AGHT+IFLq2zPNZAQWIXV2oGHh7AXsnxXyYm+kF2F9Y8m5wIc8iL/MpNSFstxnipVIzw2JZJ8+OEiLQ==
X-Received: by 2002:a05:6512:3f2:b0:513:cc18:d4c6 with SMTP id n18-20020a05651203f200b00513cc18d4c6mr2423772lfq.41.1711738485916;
        Fri, 29 Mar 2024 11:54:45 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm2235618ejb.148.2024.03.29.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:54:45 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 29 Mar 2024 20:54:19 +0200
Subject: [PATCH v7 2/6] dt-bindings: spmi: Deprecate qcom,bus-id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-spmi-multi-master-support-v7-2-7b902824246c@linaro.org>
References: <20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org>
In-Reply-To: <20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=f1k2/XtnKKT0QabjDTtzy+0Tu+D0+1BkiYHMuQzuNWI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmBw5rmBF1a6Kayn0McPPhO9Vili8LVVjwUHVTA
 Ms6jQpU9aiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgcOawAKCRAbX0TJAJUV
 VjcfD/9TlUMe8f+3fPhLYasDGg8g/v36up5C2ABrJX8El4US2PozU/+1trcDJU52ZXplM4CiawA
 ebRTCjQ+vB4Ca8MN2XWbaCeeUu/0ecjmS/48HSrnRhphCoIXCTe8AWUKwO+R8VBRnRKPGdJg7u1
 kUTzgSclc9W0ThCgx8xXEUV4sR8Tk0Q4sOc7GPORWd55rBjAN8r5L3LhO8USw5A2TUc6wWI0iDX
 X9RxsdMBXyS7Ej4+jQcZlxhEru5zKQtjEVyagVLEh6WhnSB07uU6hY6+zG/yREFm4fEeu5JDQgO
 Cn/rgajjrkX7d2sF4aCY3gLZqWaF0shIGI1IgUPGsvLLRCTfvkM8ZXgfGeGQWhA6BW0fcMGbHe9
 BjU8rqrXvV9N91vAhN+3AyijyFcQQ4n3Ge2RUtdhQ1OcmfsBK3Bp3mjdStQqUm8+RGtuVTCqTaD
 8eN6QIaPVMZ4ZRoI1o9pQI+5RiLBIBQF24jf/BVM6cWEEQM5mMB9L69QErcsdy42FgybYoMsVXq
 Ujoxjut03zTyn+h5XZvGSUyYHuHl8EFH440/peAFjMmc0wT41HSBd+64w5OSoTq9c02w7skXyfP
 p+hVjyJFiBh/zpj9kAC8WqX62nGSxOfM6JXauUagiuw+tN/XDGXda/Zl2jmRQEgRjSXuV4xCmXf
 nDUfN/EHg2aDOaw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

As it is optional and no platform is actually using the secondary bus,
deprecate the qcom,bus-id property. For newer platforms that implement
SPMI PMIC ARB v7 in HW, the X1E80100 approach should be used.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index f983b4af6db9..51daf1b847a9 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -92,6 +92,7 @@ properties:
     description: >
       SPMI bus instance. only applicable to PMIC arbiter version 7 and beyond.
       Supported values, 0 = primary bus, 1 = secondary bus
+    deprecated: true
 
 required:
   - compatible

-- 
2.34.1


