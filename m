Return-Path: <linux-kernel+bounces-42294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D0683FF38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61190282373
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B814F1ED;
	Mon, 29 Jan 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zD0JfOPJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339D4EB23
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514543; cv=none; b=K8ZQkxZEH3oaYQOVcNv6r/SpvpYGD+znuVnIyAH6//dsKZuOYr6tbcNGMKTZphzmpzvLX+qy0XxRcSvU3TzGzDgyXl7RsXdErZmNGCNaLLS2Lu3/ivkmQsv5BXZyWgabRhqj7HvznX7OfvWXSAO7crWO8ZsaOQ50ognsnRFOxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514543; c=relaxed/simple;
	bh=BKP83D9yJgO7dHlibnyMa09vHevxppr0G+06k+2XFWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jF7eEBpU6ZpHQkEgUg2NhMbDQi5DBvytOarDXZOFc/xo4yDOO5urRM9NILn5aySm+UTBvKfI8B0VTFNrrjZV00yZ5XBaPHOcmUHC2VHiGZv+dc/tnBu0dkgIeivR/SpylD4jq+FC03fs5ljvTZST89TviqMyzLuhYm8dgY1FPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zD0JfOPJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a35d0764076so37684966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1706514539; x=1707119339; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hi3wdBPHy9dOJfUItOIZktdrEsNa9te/nL1WfaDI3y0=;
        b=zD0JfOPJHHPGaXfIawDeUuiT7Jl4xsIl3OqLLbJjuY0pY0GjUKidfiElXlN8PB/2tj
         eSvjXBE/bHQEHKrpvrjTC4OkUif2mFkmV2t/t6xwwedWejM0f8Cfu+TuUHzuPRKr9/9n
         uOC3185PWvH0pPa8z4NyTF/x1SRhc9e8Ayad204t8CfbvKl/9aSz9rynbDiBsOn6gl+X
         9UP3kMwoTrXzFZcPUAu5GH1cxN7ZrbfQHy0N+2j5rx27q5VtrXQokpXf3uCWA0O3I3Xg
         I3Bi5K1Bm7gF/K5muQ2K5tne61BftSTAqGyJQ+VTCBz9WGduSNkH7XqGXb1w73rsXUb7
         x/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514539; x=1707119339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi3wdBPHy9dOJfUItOIZktdrEsNa9te/nL1WfaDI3y0=;
        b=iUXIWS5GltVgv3+uBLYk5N0xs2pudIM0laY6Z7gjG4aTMOG25xgZXAmj0peKTlrvhL
         bSPSQSffuTzeqaErjeaAplVuNIPZ5iTsldLaVsTDePnQOJyF5ew05EBtABAakAnl38qX
         n6E3D63QbFRCYBS563IYEGL4fNS/RW7XFKFfNhFphW2X94Dmv6MU2bh2VzOezi1BJZv7
         FCQIv1JzG+zc0lgXTdxXY+3DMgT+NOFMOgJbqpL/vCXYQElPkZbzD8XR7z3/ZBVMy5F1
         wp8EBapkXWdFJsUByzr7LkJ7WrknrO9ccQTT1VPqH8Ugku07L5enCAKoHM3TyhkgLui4
         JWwg==
X-Gm-Message-State: AOJu0Yy09e5o4x18N/7N7ixUE1q3lIm30rbWQeoCEqsZDNiDiQSnczlY
	7/hFQMZVfHdnP/LD561hCObLUJNhRXvYugDlhnMxYWg2SBHGO/n0AxsGwgFg9GQ=
X-Google-Smtp-Source: AGHT+IHk+mC/fG7pO9q79H3dEN8aAlJyGvqAHmPJhChitf/sDZtgl4y8tPnRH+IhsiPE5Sa2TKqS2g==
X-Received: by 2002:a17:906:a14c:b0:a35:d2f8:4927 with SMTP id bu12-20020a170906a14c00b00a35d2f84927mr590202ejb.70.1706514539677;
        Sun, 28 Jan 2024 23:48:59 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (dhcp-089-099-055-216.chello.nl. [89.99.55.216])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709066b8d00b00a32429e455asm3679881ejr.175.2024.01.28.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:48:59 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 29 Jan 2024 08:48:54 +0100
Subject: [PATCH] media: dt-bindings: qcom,sc7280-venus: Allow one IOMMU
 entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAGVYt2UC/x3MMQqAMAxA0atIZgM1SLVeRRzURs0SpUERxLtbH
 N/w/wPGSdigKx5IfInJrhlVWcC8jboySswGclS7igLa3FDr8GI9DSfRKLoaevY0huDJRYbcHok
 Xuf9vP7zvBwnbDmZnAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Some SC7280-based boards crash when providing the "secure_non_pixel"
context bank, so allow only one iommu in the bindings also.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Reference:
https://lore.kernel.org/linux-arm-msm/20231201-sc7280-venus-pas-v3-2-bc132dc5fc30@fairphone.com/
---
 Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
index 8f9b6433aeb8..10c334e6b3dc 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -43,6 +43,7 @@ properties:
       - const: vcodec_bus
 
   iommus:
+    minItems: 1
     maxItems: 2
 
   interconnects:

---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20240129-sc7280-venus-bindings-6e62a99620de

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


