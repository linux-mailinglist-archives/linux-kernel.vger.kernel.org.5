Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B997A057E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbjINNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbjINNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:24:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066C1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:24:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f6ddb3047so863025f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694697864; x=1695302664; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXYeKwpulIh1RMbfJr120lsTEAn4d1E2jtPH2MjM2yQ=;
        b=KKezUFUNZKkcACFWxLvLSaIWzFvK6BmPFgFb+SQCL2uTv7DDUBgdEIKX2tynRkkijn
         ZGmSOhhi28anTs+be3zEPcczmHrMSgz4kH24A9ePoI4+AJe6ztt1IKigwO8Df2mzIwwj
         7CnvLjAR5YOqhmUJvxXNIMMwAMLN3XbYF9pzohftF9elDv7XIT8WSGnpSz6/BPkHY2Cz
         x3jGTXqtoiU/dGf2Mb0s2yFXIB2PdzyfWnh3FVl9jF9pM4rc8P5+EaudVyeoksImnYnT
         Oew3vdjvumjTlOUgG43l0c2ngSzu+Z1l6SxPVNShRPMu9PUz45FS5EB98hoHimu+vSX7
         9EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697864; x=1695302664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXYeKwpulIh1RMbfJr120lsTEAn4d1E2jtPH2MjM2yQ=;
        b=bglazUYCGCLAWvKyl1/Xazb8YQZZuX9LTW/Sc/eF9gNlXD45FXrvXkctD7TraPcgvr
         E0JzZGtnef88p+L2zeluaFR7IMSp1PvQ7eb8NZJyeVSmZ+Le7YGgqDPKJo/t5DmK7t66
         MhdwupHxs850m3majixzbkAr79XcTIxjOOIk3M2OCTjJlBiiw1OQ3br3w4OGY2jZkn/Q
         uwY29RIJjXSw0qCqvRMb+CNgD8/H0+C3dI3xNP2r9UGZqg2SYWWs/2qjBd7fxhXsMzVy
         qAnAZgmciWbQKPc9ixqAMYKMOyVtmhMdg7K8cWhtXUEvKJDYB9cJ81D7a2pTvoZ5wQvT
         DavA==
X-Gm-Message-State: AOJu0Yw07fFW/22JgDMtlZ6tHadbt+ZsSHWM9hm3L7DFH+Xwxusec6B/
        y+zxMxUEsoW5CxP9bMGLPGe/qw==
X-Google-Smtp-Source: AGHT+IFX5QrHR8UPMv5j2GVDuoTB2MlsHgIQas7bW9TGWw0RIDrLQQV+XqeSvghSOq3cESmIBxYOiQ==
X-Received: by 2002:a5d:6a4c:0:b0:319:8a28:4001 with SMTP id t12-20020a5d6a4c000000b003198a284001mr4665195wrw.41.1694697864612;
        Thu, 14 Sep 2023 06:24:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id n4-20020a1c7204000000b00402f713c56esm1978015wmc.2.2023.09.14.06.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:24:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 14 Sep 2023 15:24:21 +0200
Subject: [PATCH] arm64: defconfig: enable NB7VPQ904M driver as module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-topic-sm8x50-upstream-nb7-defconfig-v1-1-4f6fd9f3fded@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIQJA2UC/x3NQQ6DIBBA0auYWTsJSK3Uq5guEAc7C4Ew2pgY7
 17S5dv8f4FQYRIYmwsKfVk4xQrdNuA/Lq6EvFRDpzqjXvqBe8rsUTZ79gqPLHsht2GcB1wo+BQ
 Dr6htGMjMtnfmCbWUCwU+/5fpfd8/wOqaUHUAAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=poGyM8hfv14gfER3P/3BziQ95VzWzgF5E72FbTU0TWU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlAwmHFNG+99IBcTslWCLqNCmV9yiA8+FwHtNAvfjK
 ec+lUCSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZQMJhwAKCRB33NvayMhJ0T5HD/
 9rZXvdwnVmUoMuuhz7if8f3QzwDzlg43aF2o2MTqtc21kD2w9K3cAjS5M8VZR5/jJGXtaA/+59rdbA
 PleKpCyFV5opoc95hts+PBqGEN7A9Arf9Iuzc0sdKtvSmCZ5NvvDNzh8YPMl6iqXg/P1IRXvn4eRdA
 kjcxO2BYBX1nh417lt6lUVvHvbeOi8t5+xWsNwSkFZ8UA7T8IPgqKQnUWRm3WB3vfGusaFvUtjXEju
 1KLtWJSKesjF6fk3oTnekmAa2bGwkn6PQqt1fxxOgLtB/xXg9A9hulM+RQuNiV91m+XFE26A7XyV6Y
 4k9BVJiNAkkfKE05Vc8vbZYjXwFYKhO5Wak72pfJSTkJOFvPL/l/ugns56eUu6rll4IH3rJS+O5XRH
 mn+2paJ0p27ufuZc5V4KaoF1FvUnBdvEqBnfby1X2GWv9A/8d/XTiM38PB/PPxHQMvMhcymbB6ghHy
 S5gS1sLyffhwLZG1IqUI9ZEY99hbDrYOvZuZyIOagtAffygmifecAGL0lvy4WXkSZDWflya698d1fm
 U9sbxcvuXthH2Go+NCYtU2YFhuDE5UDp87DAIfkqDq0vkYZ7HhUdd7WQeGSrkOQTKX12EaCAA8ym/k
 vi5qiJ1y+H6oxXYvlayiA0XtJTQgxZsJ0I3pz2CnUHBO8NxfqxhA8530GB8g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the NB7VPQ904M SuperSpeed redriver/retimer as module as
it is now used on the SM8550 QRD platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5315789f4868..094c9eaa8e53 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1038,6 +1038,7 @@ CONFIG_TYPEC_TPS6598X=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_UCSI=m
 CONFIG_TYPEC_MUX_FSA4480=m
+CONFIG_TYPEC_MUX_NB7VPQ904M=m
 CONFIG_UCSI_CCG=m
 CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_MMC=y

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230914-topic-sm8x50-upstream-nb7-defconfig-18f7e3b85a36

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

