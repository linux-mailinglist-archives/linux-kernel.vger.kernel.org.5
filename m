Return-Path: <linux-kernel+bounces-32129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595E8356DC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2AA1C20C72
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2576E383AA;
	Sun, 21 Jan 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1xsTmvB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED6381B5;
	Sun, 21 Jan 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856361; cv=none; b=rL5UiBkSbsKsqinVCE/1c6/m3awl7HCBhbJNX0lBAVcZmuYa0GUwAGVsMDBJn0RNGTe65HToATH1mL8F22M1xdvch7A3rCzBGo0QsCdSGzGx4nWJQqRkew3aaGtTGlGiItiu93Orful7JT76o+xcmX2wTTzdqORXRn9MYhcQphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856361; c=relaxed/simple;
	bh=Jpa+UNNLs24Diq5dowo6GPIXCclVUvmY09+FVLxKwmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzcQ/Mk7QsHpwMfIqSR0C/VHWWe4cRcCLM/leOTUJ5ox4S9e+j1OeEWBPtxfdFp7rSG/itgRg3qDdh2zbgwZfw9E/1sArVJTKA5he/3ieRY7TB1lrwPCZnOYRBSmYHmzmcGyljjT7N9jGRh4YA94SkI/4YlgZfpcogqtjORBtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1xsTmvB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33929364bdaso895262f8f.2;
        Sun, 21 Jan 2024 08:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856358; x=1706461158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcyy3FdcumLf+0bJAa7WjbUfMZPoJdzKzctDCt5Y3/s=;
        b=T1xsTmvBOMLatqBC9Okjv/40EPajR6IpOxhDyFxJVPi3SmHnhR+ma71wxoQyNLvq9C
         YiH7gGC8Lwsys6613F0vc7TksAz486MWUwCuPRWEKUn71dHKJLU0bhIm05BoDlRVCbxk
         v78aidBEb/PECwqYYiDXvVVLVbiuFFLC+i5c2glISG+e5IvCpdXi+HP6KbfxpC9WQJCP
         GL4Xg8qzKpwL64KKhbvpDvdIGdYwoEqU9xEqJGMjmTs/pzGAvP6Hm3C+1bb6SOFTEZhz
         ZbvJ069xwRRSqCkA5AeM4hCPjrfpJSyln1xn5sD7oP661PDgetW24LMOqTPrMxlCAVfQ
         4wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856358; x=1706461158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcyy3FdcumLf+0bJAa7WjbUfMZPoJdzKzctDCt5Y3/s=;
        b=EoaQ3qOmifRyMgCIBCXoPBrc7EnaBJPnEnsxDWw4jOzqywA5TfJBIGewwGVyLZJKGe
         Tb6Ycq5VwWX/47BGQ5eyUajNH3/+S2SH4nnC3odgVKU2V2CEgbO8MLD8eWaClYTmm1cI
         oGd/PZLUfrWgw24Qn+Dy4bFpSpLRE4BJ8Kw2zkvHBvL5X05J/uea44xPCraxvEE749WS
         fiFDTtezWE5dMj0Vf7okXeVyqmE3SIsII7iHBqKP9XeOkGUDeeQHZyDiFBI5J8BUxUTm
         RMGx3ErQHxU6m8juyXeai3MV17yV0VvZtYY3wvssswimPdAylq3zMecGdHyGwIKCto3H
         S8NA==
X-Gm-Message-State: AOJu0YyjYe4jq45Dsb3VMlxu2eTQCziHLQSnq0NqPkLdzGT3YejDGw89
	ea3bDvCagTCqeIP84KoGE8GnzOg4l2XENcUkDWLmkyF5bbGybZTI
X-Google-Smtp-Source: AGHT+IH7vJfDguI9aWHPkY/+pU5zA2sBfQpsz1pmrv8VHhWYH8BCZUCPAUAflbiXwqJ1Jgg+BxdAcA==
X-Received: by 2002:a5d:54cf:0:b0:339:367c:d996 with SMTP id x15-20020a5d54cf000000b00339367cd996mr340629wrv.93.1705856357842;
        Sun, 21 Jan 2024 08:59:17 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:17 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:42 +0100
Subject: [PATCH v4 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible
 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-2-f7d1212c8ebb@gmail.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=1028;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=Jpa+UNNLs24Diq5dowo6GPIXCclVUvmY09+FVLxKwmg=;
 b=lNyeaYS6Qp1ZWD5Kvx5tHZczmo/Kws1qXyoqn1GfwLq811lXacb4y5BNYD9uczSgtcRTGGfwr
 2YR6nTxDvstCETIcABLyxsxqgnh8crG5seFQjjlfTxn/34m273oKeTf
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Document the compatible for the UFS found on SC7180.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..9a4f2b43e155 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
           - qcom,sa8775p-ufshc
+          - qcom,sc7180-ufshc
           - qcom,sc7280-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
@@ -214,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc7180-ufshc
               - qcom,sm6115-ufshc
     then:
       properties:

-- 
2.43.0


