Return-Path: <linux-kernel+bounces-5253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39D818894
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA66B2384C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79F1A5A7;
	Tue, 19 Dec 2023 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSdLH83p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE418EB3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33671384e50so844589f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702992220; x=1703597020; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3LPY/wP+4u8xv3gDTbgceni72i0f7dLsgXss15/0/U=;
        b=BSdLH83p31k+tIUHs2OgUKaP5mj0WqM6uP4LL0JAKxcWhFOyQ94TeEmicKwQEBNMnB
         AY8S43MmicreYgZhJx6Tkc7hwBSgaHlIpUPR1tlVTTlH/g3oF2kQyc0k8q6JyTr66LqV
         mk7Suu+a1EN648qBoUyS+nNZERrTMpc5WA4vu+Bm0s7hlKLgE9pRQ/kWxGwlcu8pSTxl
         0dOE7jppv98yEBcBtOEOwXnrRW30E3vixuYNLGE9riQXUcW5ra1CTZALtTOWmbxaRBZ3
         0ln6T0NAOgy0Xt4c2tGFEzDcQEuMs9LmKKnkCaPjm4uA9UrTpzMnTymrbpFwqk38pxD/
         Frsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702992220; x=1703597020;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3LPY/wP+4u8xv3gDTbgceni72i0f7dLsgXss15/0/U=;
        b=D04oGrzJ5IhGSQoxwBnckqqFlQszXsJmgCuGolseskBsoVep+bjzvOISxaHrC2wB7p
         Y5Ac2Ho7w9FKZTZo+AdTTy+qd3TY3Ql25QpRfgP+KE3Iym2uUUxb3EAAisq+u+vEtD7s
         B5MvMOC+oojvRYiH3lCzT3anuJJOBOtI8FtDpMDxW9R01FklNSnfK+lJ6ZP1PhlQyM34
         yvlV0fdrLyUn3ug+yTQUl/1KiZ4tSEidxnIX1tdvAQp3sn2CNQhBto+43MS5X204kt5A
         zDDYajlCrA+zrE+kBr3jaYxhvcpxz1MfFzA7Ipez7+VCwoyzY19F5UELbZCl7SmaONec
         w6eQ==
X-Gm-Message-State: AOJu0Ywfr9CP5ZtXth1k+3ETiUqqeibT/DTxLoshZkcfQByvFegWSQ8B
	7Qhgz6n3GSgZZVLpc2QiG4ZpbA==
X-Google-Smtp-Source: AGHT+IFHYzvyDi0corcqB0NWZOjE5iHCoZWBmG8HzPdskcKE9UWUerE1vnbScokBVmD2OSU8t9HD/g==
X-Received: by 2002:a5d:45cf:0:b0:336:578e:2bd1 with SMTP id b15-20020a5d45cf000000b00336578e2bd1mr3224416wrs.108.1702992219991;
        Tue, 19 Dec 2023 05:23:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j4-20020adfea44000000b00336471bc7ffsm15010151wrn.109.2023.12.19.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:23:39 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Dec 2023 14:23:37 +0100
Subject: [PATCH] ASoC: dt-bindings: qcom,lpass-va-macro: remove spurious
 contains in if statement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-sm8x50-upstream-va-macro-bindings-fix-v1-1-ae133886f70e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFiZgWUC/x2NOw6DQAwFr4JcxxK7JFHIVSIKsxjiYj+yASEh7
 p5Vppsp3jvBWIUN3s0JyruY5FTF3RoIX0oLo0zVwbe+c971uOYiAS2+jkeLW7FVmSLuhJGCZhw
 lTZIWw1kO7P19rjyJOwd1sSjX/H/7DNf1A26qMf59AAAA
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jX/VQsyuPIyHVsUjFUCTRKQIEp2WX+Su12Xn85ZrU+8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgZlaDrfW46D5usNUF+97Tkj84cNtskNX0ajIjSB4
 c2y3rGGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYGZWgAKCRB33NvayMhJ0YOND/
 46yLraBMW6CnFYt7o5AHOdDFaYq3RCOhhkv53wUrp2UT+9o0dkTo/hdaKGwJlfGVtpIjkR1G/W1n0l
 p0DAmni76jmRO2lXdxtWY9XfPqYXaFDdgo6OOkaA4Y6CJwJvQqDsRo+wpXftMOvHtgjwbmum8DzLZW
 70LxmqtfBXdA/5cxUDQecXMUtJt1RKpCDd84m1OsigYHQ0xVld+pem0MZRY1IHBZ8+e7NmeXKqwhJA
 4pbEKd7WeekEhtE8IouZbs1TptF1VnkgL7tKBloFGy/6bh0fQj+nvKZG520uXczqi8u3kuDnJNn2dd
 Z7e/+jsEOq39jgYM8at/AGCksKx81laJRZ26/eXExBzOrtdCWQYrjq1rJI9/FeUK2MUSeESB6CS00J
 uGFsd0iaGjIU8mMWI6Swqf23/kR2ci/zLrdpPMsq97gyNbHQ8xq6zrAv5N5/TNMPA39cQ+cu+xDxjq
 zhODVdvJ2NDNBaMmRab4ZyGjH0WrzZgNeSXLuLU9DWtblMAJc/WjZFfq097FZhl0DkGiD1e3zZ31ej
 1xr936utWiaifj2KSeILxMgX0zVAc+gO/BBC4tsvQZnSTOj0x0qzVmWh3dDsUBXG6eeCzsOs49NraC
 176n4KxcOQHDA7kWYlN1tFI0aJFqGUNUfZh60WteKpzmVEaensgmrZU/UuDw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Remove this spurious "contains" which causes the bindings check of
qcom,sm8450-lpass-va-macro compatible to fail with:
codec@33f0000: clocks: [[156, 57, 1], [156, 102, 1], [156, 103, 1], [156, 70, 1]] is too long
        from schema $id: http://devicetree.org/schemas/sound/qcom,lpass-va-macro.yaml#
codec@33f0000: clock-names: ['mclk', 'macro', 'dcodec', 'npl'] is too long
        from schema $id: http://devicetree.org/schemas/sound/qcom,lpass-va-macro.yaml#

Seems the double "contains" was considered as valid by the tool but broke
the entire if statements.

Fixes: f243ef746d0a ("ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8650 LPASS VA")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index c03ff9472a85..6b483fa3c428 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -121,9 +121,8 @@ allOf:
       properties:
         compatible:
           contains:
-            contains:
-              enum:
-                - qcom,sm8550-lpass-va-macro
+            enum:
+              - qcom,sm8550-lpass-va-macro
     then:
       properties:
         clocks:

---
base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
change-id: 20231219-topic-sm8x50-upstream-va-macro-bindings-fix-924ffff6ae31

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


