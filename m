Return-Path: <linux-kernel+bounces-153792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED98AD339
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21902818EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCFC153BDD;
	Mon, 22 Apr 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lado7ywb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550A152197
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806310; cv=none; b=GG1uOT5nmZY1sdUZ0BCJ9qjUufzfqm3tGXWcGDHXdCCsSsbO06m1E4Duut0MFoeWq1ORms/DiuqDSKgO/LS5otqItSvE+R3if31/EqLzPPtESPgB+1E8z1jai+p+T+bmWn93snXdeQtN3n9UGl/cUHUY/jHAz+LPAEz6XTckboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806310; c=relaxed/simple;
	bh=ylVPuLqcS1WJMgp9a8XuASTt4JhCVhE3OAvfInu5e0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JjDJDaDn7ibQq0Z+NEqKQBVnPZyGoYFPIEBMJPs+e7c/kdxjU9jbZ0WeC6Du/pAh3x9jW/DOC+4lRPANQSsFQtRMObTI77nawSsKmiW++t/EKoKSuWLZCDi/UPNBaS3d49ASI0oxr4y3oV1Rw45QtzUmYr+VDhbiRlq0r7RpxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lado7ywb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3465921600dso4209794f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713806307; x=1714411107; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWgmC+cKq5ILi/+wUPD9o03c3KoRbDPga2rnK4G2r8=;
        b=lado7ywbak8AwV0akyQ5bMPicbqW8qhiy/SExS5KKRXD6woBv+md35gtU74Zf88n/E
         DD9Lk+Zv5ea7ZPs3U/KnViKRX9pwN5mYkFSFSEqxNXJrSrvZWL0j+3Pi8/ShvLfmswEs
         AFfVzUmX738FJxJ0GPwLP6KMjs12oDvT2T6b81RQiv7Jwug2/k0AnSkvwLa/DGHLrzm/
         m6/ca6tIt4E8BmXUZ7I1L+HivZsw5Ng+kweZRoC1KpVMzvhipY6L1VYfDMlUVQjgPhUf
         Twx053ehUPYC7B5ybbBDUVdN6Dh2OAv8ymFRABTTc9zXt41bzvRgaIBOiWt7vJKK4c8Q
         EBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806307; x=1714411107;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fWgmC+cKq5ILi/+wUPD9o03c3KoRbDPga2rnK4G2r8=;
        b=kCzWHsw9mL2P+W76AI0uyiyJIc0JT3dki3CyMwPMnHwnYWoel7KKyqeSudUgEP3msU
         Di9w6bVvvxxOGFu3f0Q+0LeWlVZxDe0tUvXSCLJhEfgP0GxD89L0NbFO87+0O1qt+AgO
         bhnePFqr9khcemQ1yuq6eHdOGMLoyWzNnon1rIDKGxx94TELEQLl7JpdvtrpyJhdo65I
         yrYXa+iSMi80xMuYADfrCmdZqBUd/4tbzqI29HlURwKhb0Ve74ujtBnvmW9CMwL3Yu1O
         0uAe/NO+MA6HDNoBxUVS0MttZwM+t/rHJ3+00xVYBNhszYJVyHPrkFKF1VHVRDPIhEFx
         +pTg==
X-Forwarded-Encrypted: i=1; AJvYcCWtal5nPoHHyLkNY00fBNj6qZcZ4qpZUFdexH2MJQOokzihNyOXjw8gCJB7kS6J1D+1Zsa5Q938WqzztXhPfVktRNPuet9DJogV5rzq
X-Gm-Message-State: AOJu0Yz81tgQcbnpt16tSsGic5PXb67nJdhvg5yeCq0f1BEbWuAyHqvH
	MuXY+LOsX6CEj6TbnQcAOgZbICO3Rzse8vBC1WVS3UPcLW1Ffs0wz+cdUDK752Q=
X-Google-Smtp-Source: AGHT+IE4x4r3L8ahx/2rD1lKZZqMztrneV/8IjQ6Ck6/f6K0Cf0g5tGKk+eOJckqxS6wN1WNIlXM+Q==
X-Received: by 2002:a5d:5586:0:b0:34a:e73a:51be with SMTP id i6-20020a5d5586000000b0034ae73a51bemr3385127wrv.31.1713806307048;
        Mon, 22 Apr 2024 10:18:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d1-20020adfef81000000b0034a7a95c8cfsm8655132wro.9.2024.04.22.10.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:18:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 19:18:25 +0200
Subject: [PATCH] arm64: defconfig: enable Khadas TS050 panel as module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-amlogic-v6-9-upstream-deconfig-dsi-v1-1-01511908477c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOCbJmYC/x3NTQqDMBBA4avIrB3QNNjqVcRFfibpQE0kY6Ug3
 r3B5bd57wShwiQwNScUOlg4p4q+bcC9TYqE7KtBdUp3Wik06ydHdngMOOJ3k72QWdGTyylwRC+
 M+kW9dc+H1cFDDW2FAv/uybxc1x/5GsRVdAAAAA==
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 khilman@baylibre.com, jbrunet@baylibre.com, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=935;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ylVPuLqcS1WJMgp9a8XuASTt4JhCVhE3OAvfInu5e0g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJpvhtHJRYeJBd1fbJE5+8INMdIKqwRLZNT1E137M
 scLJBhqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiab4QAKCRB33NvayMhJ0a+wD/
 47b6efjdEaUF1ykivJFo1MeNg9w10zCSwsLnUmi48eiBkiv7gKY0+1Qj3HLbeq0BKe+cJ3YRZdV1pK
 PFbZQUhXm0gdHsxKzo5fcV7Du6zgcsA0mZ4gbRGK5Tc3iPr4K8QMWDCQO8aguYo9JrblofwBESSMeD
 +0Zret1WVqk9DmQbqDYQyeRmZUjRzT+rEOQ+j4sQJ9u6cw4gLxzk+TujsdUVgEmzCq7zcRCEfrIGc2
 wawJEyzCqqK/b3GKNTOblLX/385tRpophcbQx7Apto6oRPoMbslImDW6xOw6URnnlAnKBf3xI+z4F9
 HvgfWBuyEYBHVnGbT9DE9xI2zaPB34qeMjhcch2kkfSsIRBEAGp3oAj27xghdRc2heOLGekNj2A+gp
 RR3sZEu+ET6os8pCicVUJMJ9DQaF4l3zNSJfnTsY6Wt+Z0UUmfoRG0L0sUiIf1c3FE+Nv0zcW/Dk0a
 8JpQp4IHVBu19WQSNRtu12nXZFW0hBkgnu54kfhPNonUC+I7uhd/XMWXZxpeEhB705xSbc82E3vl/i
 T0hyqA4UxVj34tmfpaQnTM71PdV4dCKgPNPlOg4AarhhBqey1xuwsekHvDfuV1GbvKfoDrF0FlGqyc
 UyULF3B8yqF0z51z2pcnCpFF6Fi6PDaaiSfJ18aY46e3049V66afI5toPMwQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the Khadas TS050 panel driver as module since it's
required to use the TS050 panel on the Khadas VIM3 and VIM3L
boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..76c687ae8b89 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -865,6 +865,7 @@ CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
+CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240422-amlogic-v6-9-upstream-deconfig-dsi-48e1bc73b4fd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


