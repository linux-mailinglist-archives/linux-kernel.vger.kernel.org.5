Return-Path: <linux-kernel+bounces-76889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FD85FE31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BA9287A38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D504153BC3;
	Thu, 22 Feb 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8OQXrXL"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A9150988
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619852; cv=none; b=P9cSOVzyubOIO/BTKahHAzYtXUCJUqN/3Vx9Qv/ssFXe0tGYrINmPtOh6ZUR0+QqQ8n4PkblO61bxK6qzH+xBytEQlM0FanBz0QWIRepVXm2gPfqELZRK14zG9kwtbffEnVqay/GbyMXF0uBpIeqJu/QmXWiolaXrcPUEKeF7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619852; c=relaxed/simple;
	bh=7TaWjSMnr9SyJaL1rSnUq6UVe3SDZbweU+CU/JSE12o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKoSuU0PIjN/Eeof8ScdbVxLXPgUquJeNx3H60v9rb3EfCJfvQqqyIvHJS52cGJRyOcrCrOKy7ZJ48iDoc2b7e+za88T8bRpxBfjSsV9G+Qi/bOc/Mef8Smbyp4Hdo4X8gavd5hSd5g3/pN7Bng8YysvUxOH63ONqJGsSGIT2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H8OQXrXL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso8429801a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708619848; x=1709224648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ythAlB5fOuduCOWoNXa4hv2/pnJOcPq8G9cfPzDgUoI=;
        b=H8OQXrXLleYyVLeshdY3zehihi+qwT/Nk6N+ArWW1TNbRoUb6v5aJbow9wQcaklDB1
         /rlt6vftkl6XzIk36t4Ka9C3tDXlm2v3g4Ac6vALE+5v1vEOt+xuUUTNAi/q2FYD/vSM
         ZCMZ3b9i+myf1lPeAbQzCTCJMTRi+sJcjLHVH3ugrRiNyERuBRASVEHvpii5C91c+oPy
         IamZL503BYj+lm38EAjmS4Tq+uN4O9mSmXiWtmR3pqftboA+/n9FrbVL5xIdIbSP+lOW
         K6GoU2vUCQYX3GCMyWBClShmo3wM2T5+PurN6kKpz1JBi3FqNWIOC89H3YyXeO4UFFEo
         KKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619848; x=1709224648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ythAlB5fOuduCOWoNXa4hv2/pnJOcPq8G9cfPzDgUoI=;
        b=NBDlLAUbYGjRoa7f5Ibdscr5fvZL9pIsCc8DIO68goyoOnG4FrIZfZPSEegZTmyGhQ
         AvwAtGVu7kG5h/bU8XZ6KZmLHsvTlb+edLLAX0vNRfP7nCog68vgKhqRiGGcGLw/EN1s
         oND68d1iVAeMcCFQbd1TvWs/Gh8ap4/byKwgfrTGXIcWi7i+BFU4yiNX11jT4GB6dvf8
         rviYDi8aK/83bCHl8vlNDK+sU/5sGGRrSCm1wfc6W6rXjrB87AWznkSew4yJgu/gj/l+
         seazcchcYsPv/Xr11+F1yIraVodge3Jb/1RZcpg64LNMK0YL/YWZQNBezkGlwCzynUul
         sdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6C0wmGtP0xxUBTap0T7FFXNTzdmJ8EmDmirk+/Gn0uCZpX/PWsMJJ9fL5RWThGnbnVc+CYf+ZBEX4s2NruCgDgCqRgjn6oXgcPfdp
X-Gm-Message-State: AOJu0Ywcx+YqoaS68Ab5EIbkNbopOuAr2IZzHzuxFGttX/59RL06U+2U
	r46T89hA5pgqgvF4SgAR2cCIWYUeYpDlu7iuuf0zOlimStmsyJc9hFZP0gtNvM4=
X-Google-Smtp-Source: AGHT+IEDqRBn3wWYrrFcXKIOrpL73QXc+7HDhyj6TIw4Ua/8t6GPiVQ6GsEbJRHzFBalKuA1vFJmwg==
X-Received: by 2002:a05:6402:5246:b0:565:2183:d296 with SMTP id t6-20020a056402524600b005652183d296mr2969008edd.27.1708619847900;
        Thu, 22 Feb 2024 08:37:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7d993000000b005653c441a20sm614191eds.34.2024.02.22.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:37:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH usb next] ASoC: Revert "ASoC: dt-bindings: Update example for enabling USB offload on SM8250"
Date: Thu, 22 Feb 2024 17:32:04 +0100
Message-Id: <20240222163204.65468-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a9c83252bff616cf3a38d55b7c6a6ad63667f2dd from USB
tree, because it depends on other DT bindings changes which were not
applied.  This commit alone causes dt_binding_check failures:

  Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:97.44-45 syntax error

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Greg,

Please take this revert. Original commit should go via Mark's ASoC.
---
 .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 49e4f5bbe9dd..2ab6871e89e5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -227,21 +227,6 @@ examples:
                 sound-dai = <&vamacro 0>;
             };
         };
-
-        usb-dai-link {
-            link-name = "USB Playback";
-            cpu {
-                sound-dai = <&q6afedai USB_RX>;
-            };
-
-            codec {
-                sound-dai = <&usbdai USB_RX>;
-            };
-
-            platform {
-                sound-dai = <&q6routing>;
-            };
-        };
     };
 
   - |
-- 
2.34.1


