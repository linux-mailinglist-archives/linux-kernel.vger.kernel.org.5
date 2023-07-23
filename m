Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B28375E26F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjGWOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGWOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416310E5;
        Sun, 23 Jul 2023 07:07:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so5205941e87.3;
        Sun, 23 Jul 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121258; x=1690726058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IKxf7JmOF95rTzSLnd0mZLk5/Wvwjp18VbT76vL0CI=;
        b=YjMJo4HlQK4Nt4nol/gKne/872PaRyv4CdNsM+TB6he3wVy1V15S24sMpgopIuABoF
         Q5LDk8AKT+WrfjTaSQdSVQc24wcFb80fuFdgaz2+7INP31NIxOagPMxR84Ahk11tYyXL
         VIHNN9uybXPtkqU6idRJxbIhz7PU7yD1QbfGl4GZNkr46fSI/6riZnQkDrBwo45mmlxQ
         TdTBu5zkYkkamKCJlWwIPs4+CSulZ7Y4aEEH04OsLCGwTMJO+n7aCYu6bNKBsuUZYbni
         wJsPfcl1tEaHWIZeXKeZxhRkteN9TBAfaR669ikYYQwH3dGTojluJRbifaUL+exIlcNO
         k95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121258; x=1690726058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IKxf7JmOF95rTzSLnd0mZLk5/Wvwjp18VbT76vL0CI=;
        b=XRKmit3hGPNTuURgmIpOxDF9PrZSCS3juVwCBu/8gsSg6vz5aZngvMGDlvNYcFEGzh
         r9u1bH+RWJmpIS7WYKISgGMBnem5b1dizO8zkClfX/QAnM0k1MnCtOH6do+ZZrStsaj9
         cRhEnzoLTcDW3taq5L6a8f8OPWXMVqLaXq+6wJm2NP2NYzIhk128qD6EkZFkks/PCBE8
         CGUJKn1KMuPWAAK1eCfbX+6FhPn8kNyAaNiicGji7v3hlMn6/XkC27tCAXsoJnCjuWhu
         g4NgbK6Wq3SSk/WwI/VSoq0zqZqYZhycgdOTHXpfSApGSTWa2ICZFpAVMJFsc0+kVr9L
         dKXg==
X-Gm-Message-State: ABy/qLbwC1GEGNC9FD9r/0fU5+JdXwoeJNJ3KQvGSC4jSpRJe5LuSIsT
        PXq2mHBsHp8y+5XXkABDhTvZo1gScuGOSA==
X-Google-Smtp-Source: APBJJlFUsPgzgMP64aq60zOS7JQdco352CkdAuJ5jCBXMM9LbWwyf6Q0s10hZ1+Jl+gNCYBwSO6Ofg==
X-Received: by 2002:a05:6512:693:b0:4f8:5940:5c6a with SMTP id t19-20020a056512069300b004f859405c6amr4957295lfe.31.1690121258172;
        Sun, 23 Jul 2023 07:07:38 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:37 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
Date:   Sun, 23 Jul 2023 16:06:51 +0200
Message-Id: <20230723140712.9438-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723140712.9438-1-a39.skl@gmail.com>
References: <20230723140712.9438-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document MSM8976 HFPLL compatibles.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/clock/qcom,hfpll.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
index ec02a024424c..855344957350 100644
--- a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
@@ -11,6 +11,9 @@ PROPERTIES
                         "qcom,hfpll-ipq8064", "qcom,hfpll"
                         "qcom,hfpll-apq8064", "qcom,hfpll"
                         "qcom,hfpll-msm8974", "qcom,hfpll"
+                        "qcom,hfpll-msm8976-a53", "qcom,hfpll"
+                        "qcom,hfpll-msm8976-a72", "qcom,hfpll"
+                        "qcom,hfpll-msm8976-cci", "qcom,hfpll"
                         "qcom,hfpll-msm8960", "qcom,hfpll"
 
 - reg:
-- 
2.41.0

