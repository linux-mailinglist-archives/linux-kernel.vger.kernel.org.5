Return-Path: <linux-kernel+bounces-32130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6AD8356E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DB9281C98
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980938DE3;
	Sun, 21 Jan 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpWR1Wcf"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4188381DC;
	Sun, 21 Jan 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856362; cv=none; b=mG6gqUwX5YyZBtCTc4KNjqdieUMD/WjWdQvbFqYv/hFtycsZjhQgRfxmLNvXvVttg5z4NR82mdV4ch8mH/bMHrTJoBBjqMz9PjXVltJ9nw06XWQdlkohhYjAFYhsQlTjpIsY5duDaN3UEcrfDhjHu47GBgmnPJwyZoQ/gMGDFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856362; c=relaxed/simple;
	bh=7JQ6Zn2Q/95Qw3aNMQph8bonATbc18xDznjJ9sX4apo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNuERrCgAYl4NQ3az6ht0T6Ko+jXhkZg8KF8PCm+hKsuvSO1QG/3/5qGGk/vgwjxGly29vonXjfGEXTBsXMwB8G1ftQ7Ru8viVbu6c7Csq3FuTLh7Yk+IR5oa1k9MYyqNa4aKMD5UMScVxOJORoWZam7nqsZmLMmW2+AguohXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpWR1Wcf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1155142f8f.0;
        Sun, 21 Jan 2024 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856359; x=1706461159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7GFapMX83Ugwi2W5do1tXfyoLlSaiu9uYO/iyI3nsY=;
        b=TpWR1WcfMTWJmH0vxPz5aZDhxTXWhuYVanmeBia7RAxKl6IgVRdONMHKH1F0ppVcMc
         ruH2dWMbboPSQamF0KO6QY3Ls+EFabIQmqoxNQgBStmUn111bTbCw8r5PbVTJ6DzIIB/
         JUu8IQNpmOJrbQMc8FwCL7BtlRfLTrLHELXMXWmpGgBaCuGG2j4f6hw7jmg7l3AKHMYp
         jcjWjSzDG0niBpkGslWrrFS93S12pRAAqm33lSmJs3WKcS5KSLh1x7V/krk8N02c8aa8
         bi7hsMreRe5OvL+dBGlvK80jwDoZ+vIv8gzUmceLuOPNsWca294WyyAGAbIYRPNSoizf
         ZBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856359; x=1706461159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7GFapMX83Ugwi2W5do1tXfyoLlSaiu9uYO/iyI3nsY=;
        b=MhZBT1BYvt77Bnlxs8xFVNacwZd7M8/X2FZWn2e8tv0OIeax/wCpts6F9BmAOQou05
         73oJAE7gO6YtwFt35rlnzURMAQ27tgXjvm5XNJM6owlzzq/GUCw7Ul9I/PFWMlM6RCtB
         yJyKrKo/ZdQ2YJkplRiO220nP72D9imMWA/bu9/ITbTe0HdQ9sMO7hyhxTISRu/ohePN
         18M/gJZ/ucNAPgMQ053DV0lC/2NlfyZNV9HHGuau9/Z1PQdSiNCf/KjKLGZhvk77u29L
         DZo7yTUlBENhIhRZp7aIqlE+CPcNw9t+v7Pfha0Gh+ejuVv7BJiuiLc4f4SExRK+/T1J
         1dnA==
X-Gm-Message-State: AOJu0YzpREV+/mvhKlvCfbwkqASvh6B3VNF6oZP1P2C1d+22lPtd0TCh
	JvtoKVj57gwsMcRuDgxTb9bHiFl69qCZEvcW6g12fAI/UJJveC5U
X-Google-Smtp-Source: AGHT+IE8u/xPbve4SsuSe6cCHX0i1Rfu5/34go7AfvGZd3Wlg8LTxSONonioZF0LPss8c+LMH1Obbw==
X-Received: by 2002:a5d:56c8:0:b0:337:bf42:b1f8 with SMTP id m8-20020a5d56c8000000b00337bf42b1f8mr1642775wrw.137.1705856358841;
        Sun, 21 Jan 2024 08:59:18 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:18 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:43 +0100
Subject: [PATCH v4 3/8] dt-bindings: phy: Add QMP UFS PHY compatible for
 SC7180
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-3-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=1184;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=7JQ6Zn2Q/95Qw3aNMQph8bonATbc18xDznjJ9sX4apo=;
 b=p7icsHatqXQbBNED8tZYwMAcrMaUB6qn7TQ0TYBDmoaZXtd6q3BrjIUNtLAwbqxge+mvUiXa/
 w5MwFkUcizSCKuCRhI4qAwDpUiVlPCZDoWnWHfxUHK5Q/dNp1snfHsG
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Document the QMP UFS PHY compatible for SC7180

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 8474eef8d0ff..5faa1cb3a12e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sa8775p-qmp-ufs-phy
+      - qcom,sc7180-qmp-ufs-phy
       - qcom,sc7280-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
@@ -102,6 +103,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc7180-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy

-- 
2.43.0


