Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC06F7FFCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376377AbjK3Uft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbjK3Ufr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:35:47 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288C1712;
        Thu, 30 Nov 2023 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1701376551; bh=AfUfFkZlUVV8xnA1PoNR+te0G++zGye/8BENKSIEvPs=;
        h=From:Subject:Date:To:Cc;
        b=S64T9aAZQ/Y0yXhmFaL8xcNLp6L+jqL5h5lAEpxWZ9qqzowKOb3UObrMgWnFiFGfF
         hzmUeQ9PcyDcUIgWGZwTPn03S1EpsojK16kGmwlVZj2TCIqxCB+I3onx4WZ95yUG8Q
         dvM1AODbTmJVL5MtxwMj/lPX+SUbV9XgBpSUuMJo=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Add GPU support for MSM8226 (Adreno A305B)
Date:   Thu, 30 Nov 2023 21:35:17 +0100
Message-Id: <20231130-msm8226-gpu-v1-0-6bb2f1b29e49@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXyaGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ2MD3dziXAsjIzPd9IJS3WSjtDQLE3PjRMu0NCWgjoKi1LTMCrBp0bG
 1tQASSii6XQAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=AfUfFkZlUVV8xnA1PoNR+te0G++zGye/8BENKSIEvPs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlaPIX4qWS7sr58b9UMT9Pnw41UlYig//AX8prq
 MGX0XqPg0aJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWjyFwAKCRBy2EO4nU3X
 ViqxD/0QXEuGfMIQ8ksMhfE+hjDJ2k4hub4zyzhOzFTU33niAmwPkSxHI1bvfOlNdYGzjeqMz5s
 hb8OKR0WCGJwEvqDUoCHyx/H+p++pz6FnSHfzkY19nec4uoo0jdIgM+m+tEwudIt+yqa2Vw5KJh
 ysdFh+Tq9Osk6hMY0SPuEGMrPpmS6RO0FXsk7D+6uBRbmUQoas7DNtkYIhwLSky3t/rBGrccgj8
 aH5SbYIJrU+It8v/yYrNThPpcy0meGqX5h12moUxgS0DMuazitdLBs4rmh+v3v9UblOkm4NKqCi
 1Z3rb6vyvy3aXQwoANEDVPAwZqmWs0t4n8DgT/laDQz+PdG8MGNY4lAmC8irjxWx7UGy1Q0+w+2
 nafqOQvMnxoJOX3oYlrogxiRtvB/GZlaJq4snkBfVTaqVrlOX2To/0xmn9zC5a3IyuXhRk9Yw/7
 JqQzuhrZY3EOQHhYZ6ry73NqU0Uej3Yu/is0UfapQXrlI4MjSgqS1PhS92ZwsnTFugyLxirKxYo
 opr7+JM+iLKBo15zNyE+Re4UNN63qutzh0R7KKTmz9qwKkF7y3JEJ2gPb3JcwoW01covleYfw67
 +77P6N7lTj7Pz+Y3mHeFKgHLhhKbYJwMQdg9y3iVSEKb1u+1bMpTmVQMAgRK/ev6XK+xt2UQsQC
 JtPMcpvmyKOgecA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary bits to bring up the GPU on msm8226.

Tested on apq8026-lg-lenok.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      dt-bindings: display/msm: gpu: Allow multiple digits for patchid
      drm/msm/adreno: Add A305B support
      ARM: dts: qcom: msm8226: Add GPU

 .../devicetree/bindings/display/msm/gpu.yaml       |  6 ++--
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi           | 40 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              | 15 ++++++--
 drivers/gpu/drm/msm/adreno/adreno_device.c         | 15 +++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  5 +++
 5 files changed, 71 insertions(+), 10 deletions(-)
---
base-commit: 32bbbdc6dbe6ca65a3e3e2ed2ca3c562793e7797
change-id: 20231130-msm8226-gpu-c2ff8473a9ff

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

