Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADC769119
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGaJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:08:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FAF102
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:08:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so6259951a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690794503; x=1691399303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/9NdmaSyKLbjJW5BdDysXmROAqdZ1S2mkS0FBxtKKA=;
        b=gMfN8qiVH2N6ecI32ZM4CkYJH5hoxVfdHz8RZUeuD54R5wz5q6+xuNd+cGTdHxTyEc
         FYci44NG45wCsKm6Mid2ieH9wnpzE7J3pWMKw7u40rm8xo8/ValyvexMdPQcWn5kFPTV
         wTGKNzZm2aq9oT5EOkJ86AMVLSbS2qXOJnyr4Bdicrlct4duEw0JOUfyX/jw62A8aDJF
         GzM5til2F5Oc9TJ0TDstRJCwukTMTXo3wuUFOoRa3fizYHrg5c2yuG0GSNP5cnS0fpAP
         qh1EHNfnu79NZgn5NQhCUL1HrxPXGkC/7QQoWsHW2VZxKX3YBT6qliMKgWF1k0aCufqv
         5cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794503; x=1691399303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/9NdmaSyKLbjJW5BdDysXmROAqdZ1S2mkS0FBxtKKA=;
        b=go452Wrnhu64DGISjt1sEEg49HBz658YRpgwy6pEj2NXLgUcHOSI0avAsxtunkqfMo
         PDDdyjowwHBQ+8BV4CcHSzhdjBx5+U/TghMToCmUAD7U0gHIX3D979uIYmdZtKijUeHc
         SgRhpxGyOZdau4QoMp2Mh/dRqwHU9/YkU7lddknEIYSrWIbqBqEz7LFy4BWFu5vyoVh/
         jkBMf2FZJXuRojAC0szNtjk8/eKPj8bouh1pe4ALQF3lbpHmUZqeCgdENNJDay6H5sKo
         0GmTHVjGXoZ0xPPUVn/UXKOG7ckgMStLVihi7Jw37l/rNJcIc3c8Pd+YWB5aYwR3za3A
         /oNQ==
X-Gm-Message-State: ABy/qLbxv13W2rx9fR7T0X0diDLOYho7+nEnLfQ/e++PJuDNjqzD0UOW
        nuEDzCmGMlG8VXnvNgR7dmfDIw==
X-Google-Smtp-Source: APBJJlEBlycDp/8J+FKABadTyy2Yl/Sc9/q8lQirARa4V+e6Eyi8UTxknRrct9qsBrZuetqnsEtXMA==
X-Received: by 2002:a17:906:2258:b0:98d:fc51:b3dd with SMTP id 24-20020a170906225800b0098dfc51b3ddmr7257118ejr.41.1690794503657;
        Mon, 31 Jul 2023 02:08:23 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id gy26-20020a170906f25a00b00992b7ff3993sm5800563ejb.126.2023.07.31.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:08:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: exynos: exynos5433-tm2: drop redundant status=okay
Date:   Mon, 31 Jul 2023 11:08:21 +0200
Message-Id: <20230731090821.104733-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status=okay is by default.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index e4ed788413fe..d163891cd399 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -137,7 +137,6 @@ sound {
 			/* Receiver */
 			"RCV", "HPOUT3L",
 			"RCV", "HPOUT3R";
-		status = "okay";
 	};
 };
 
-- 
2.34.1

