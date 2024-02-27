Return-Path: <linux-kernel+bounces-83262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C28690F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1A8282A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60D13B290;
	Tue, 27 Feb 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHDOz4SL"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9213AA24
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038411; cv=none; b=BH4vZK+86srPuqhnqd1n3SYFJmwTWdQBXe3mHHozwLPrk+WWU6rKAd/5W+M5W+6HhhZCffledsSNkxEDe1JTVSmrS5q1bs7H3q6OhJeJfOe9J+nxq2vbQRTRjFJs7WNhTb/ESkAMNaBYm9N51vfpm7/0BKmHNJ6knkCYK2ehndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038411; c=relaxed/simple;
	bh=W7s8U+G1CvS95ciIBnZfewffYKGs+qLImFMLmUIEz94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3sk5SBLl6Y5WuXw5f22Ir8jWsvKiJDcrY3/HExNs5vfwniieooILE/z7UmVCEw/8cxpbDXpuzftLNyDGWkkFj4zuAr6yROrVjiw7viDmktIqozfMqIrGr18SerPJ+jRbsy91aivEl5AXMRR66OjCazd52565HU57uVfycy13Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHDOz4SL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19bc08f96so2267932b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709038409; x=1709643209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkwHy8KHvQ06UnRgJAw6K/xRKAhhDmr4TJmxluTjy4o=;
        b=YHDOz4SL6hNQoSFAlk9w03Pe1ixaEETVxtjT3CyoL5bLzPnDDMmgy6enxFv1y8++1n
         U8RK1ZKW7eQVO1dfZKJZWu3g1pL/8KjcNlwvF48ReXfrartuLeMGnAHYhpapAo+8bOfw
         QM4wSiJzVhe7ShswElAzybRLQD6law0d3gtIlZXpO8oZlpa85YSB9U2tpUPvTEtnFhsb
         NKlwBkGC37qirlD4gDKP/CfgYlfeKc+qLKNw17DjosS7TCOsgj0w/aylglmUplasXMZz
         TNCuXex9xe27pOLAf5+/r3frMiUkdpqcLdD1xNrgPHPPDp3pjEL+TW4h86GO/sFPgPcp
         UU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038409; x=1709643209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkwHy8KHvQ06UnRgJAw6K/xRKAhhDmr4TJmxluTjy4o=;
        b=pcS764k8nRA9ipUCQ+NXotmfKpG1VFg/Ze6miXbMyMYyG4qXufxbX7m93ed6am5eEr
         FFQCt/DW55zYfl51+3nyw+7KP5/JBkVd4O/jHARIq1o6TlV8WPxj4NYSDQI4BS11wz6a
         7xO1vzEIGJmKgfnz5MMRLs5Rav/kyTPz1JqIM1XcuHlDuiAH8C00naJ4tbz4iesOIzpk
         ECdyTGFbI6QNR4jKf18F4KvqGJmNO63lOhkLazOTwljsO6hjvtVRKUHNmAEDGtNomzbf
         kE5qZA2D+conNv3k4Q1LgA0IjlNzPD1O72tch/yHYIDUUfg4EEgwPOsKD8TyzVGwNr6V
         ToBg==
X-Forwarded-Encrypted: i=1; AJvYcCUs/HssoU3vpCOE7cAK9EXPnnMfeENCZGN8EL+xnV8ENS20uG8jPvG7cHetvs8qjHlhzGlg3TdV1gBK/Xa7LOWpkDVCCqzzu9KH3QNZ
X-Gm-Message-State: AOJu0YxTBS7YvGhjuZTqGtbUkbqS2WQydTNvAU5oJBnjCUQKMA4pGqCl
	AYTZc1TuQArocl2CstNB3SDRQUC6r3p67Z5hgbfYhcF7JVC5OUO5QhoJ48NRWGY=
X-Google-Smtp-Source: AGHT+IF/yHO/Dm6DIcnG/gZgn6sGN8rhphuc7dovq6xwKaY4wfQou/GyqdJW/0DRZ9i6znaANdCKrg==
X-Received: by 2002:a54:4492:0:b0:3c1:3a0c:c1c8 with SMTP id v18-20020a544492000000b003c13a0cc1c8mr1836701oiv.51.1709038409299;
        Tue, 27 Feb 2024 04:53:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020aa78b87000000b006e48b04d8c0sm5841193pfd.64.2024.02.27.04.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:53:29 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Feb 2024 13:53:05 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: sm8550: add missing
 qcom,non-secure-domain property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-2-15c4c864310f@linaro.org>
References: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
In-Reply-To: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=W7s8U+G1CvS95ciIBnZfewffYKGs+qLImFMLmUIEz94=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl3ds2VZrS/0F9OMKj3N2y3MIVbsJ5tqtVhzTZzyQH
 CIKCdkqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZd3bNgAKCRB33NvayMhJ0bu3EA
 CHIyE8P7dkULJoQZs6aR2vh555iFziqGjOVHgMgfB/p53Bcb4ua8ASEN0WQq5cv+MkSpJti7yaK6vY
 KCDckbJ3PIlFGqo2IsigEQRX3/FUe1ROwt2KloZgABFWRqTIXioe4z44OKGa5IWxPWw9zivKsmt9GK
 IPlCRGo+UGOE6Y5a45ua17jhi6p1joa8zJqF6O3gk0+FulYfXSYMJR1Dq1gf/pHfb+5ZpzDTgZmjR+
 TVBBfwhWbj3O+dHt7CLE2Gzae+NQ+X/pkTTWk9C1B6oTEbwWsKEl0ZxcOXpq33gA7E/JSdITy+QSrw
 E4YrstQ+381uvQuhYHhYf77bnvnx/TSmOWXzFwHw/2y0XSNd/Uo82fHGhjyHF6zI4ZdIcRWmfMej70
 TqbWz9gVaRVn87PVNA08isZGaB4AH1sD5f2eD+9RmI9swJOrqbQxU3Rlih9KeoO6I/BZ68Ggj7wsuF
 FwzKJBM6EpjfGBkA2+Rh16hpf8i1DdCgBQSGs1559T9AdkVnf0zGd+9tEDXtyS0migK9EnCTVZKt6Y
 oaS873EkRIdycZB4aiq9xlcWTLLlpbnFyGJ94/CFIpYaJ6pZoqx+k7jIBUMrvuuC9m0LfFa9S982Q0
 UVPfcKA9kAD0YLqvI8iaKiIevaxDmCsDY0rZz9bYClCsdZs8iXqC/+9GD9bA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

By default the DSP domains are non secure, add the missing
qcom,non-secure-domain property to mark them as non-secure.

Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7474cddf7ad3..7bebba45eff2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4316,6 +4316,7 @@ fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "adsp";
+					qcom,non-secure-domain;					
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -4454,6 +4455,7 @@ fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "cdsp";
+					qcom,non-secure-domain;					
 					#address-cells = <1>;
 					#size-cells = <0>;
 

-- 
2.34.1


