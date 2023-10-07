Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE16B7BC367
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjJGAoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJGAn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:43:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45745BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:43:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50308217223so3321771e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696639434; x=1697244234; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2i7SU6EGyxqMylhMcqAeEXUl2esBxj9TVs6vu8xDfG0=;
        b=At/Dx7MdddGdlgPSNutQU+s12hUeZKP/STbAZIBxMN/IjqyiaFcHwUshWwo20fy9PD
         ZfAg/Z025d4IgJiU4bK14/hWZJTX6ZbSE95ijvzGHZTC/q2VRgdPA9ZWMk3AH48HHxzV
         jBpRhNHN+g11R85J8bvca9KVNZri30ug2dwpv0nzEoQP7Rf8TiveoZHPeIBb3ALtelMJ
         9MJslMHcTiZaiu4Kufp+YA4rLXKBzGCfyUq4tTjAhhpUzor3pp/zDU2XtGOR7QVUXYls
         yqnjgsODIldV/8f522morKBQOeJE3vie3Ezgp2cQPMOz97Cyg240ewQMum/RvkP/ZpfQ
         dlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696639434; x=1697244234;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i7SU6EGyxqMylhMcqAeEXUl2esBxj9TVs6vu8xDfG0=;
        b=sK32ikkh1NXzGOL5OBjl0PbhBLW6y/txnmXKNQuSuUt46pwtifCYwyayNktHjrnH6x
         BJJ4rl1oi8F7ugDIoffWZuN5bfblFrCN+wd3cb/u1ROyxDMpitsHNhocnnSTWLgo5IZZ
         vXo88goxLuUQmjSFjE5ucJujFiC434skrAcS6sOvv5coJYeudNzLli6sJVGcDrTIWgPd
         4R9QXTbL/i8dlVN/M8ueawDE015rWc6a2y4/Xzm0c+guPfb3LPVkSbPL3XIQb+y2hb0f
         LeN96bxF6jWYHfYtQBThy1gvSwuRISUD5Ex9jipOkhpBB25t93jVcakZH1I7pkltSzFT
         BvIg==
X-Gm-Message-State: AOJu0YyQAHGBMhuDv8wEdRh6434tVSa1MgfWv4exU0xQgPrKEln5Ark1
        VWK/PrHjSIwX7qxnJPhek4X5rA==
X-Google-Smtp-Source: AGHT+IFI9eOT8axsVoEo2tOZEhrDgFsGkI3OXuA9O7GPk8YuXtaSm/TMTj6vfU1QQttp17TT7pQ5/A==
X-Received: by 2002:a05:6512:1285:b0:503:33ab:8126 with SMTP id u5-20020a056512128500b0050333ab8126mr10672999lfs.17.1696639434420;
        Fri, 06 Oct 2023 17:43:54 -0700 (PDT)
Received: from [10.167.154.1] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id 7-20020ac24847000000b004fb745fd22fsm492682lfy.32.2023.10.06.17.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 17:43:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 07 Oct 2023 02:43:08 +0200
Subject: [PATCH] docs: submitting-patches: Introduce Test: tag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231007-topic-test_tag-v1-1-513cd9e577ed@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJupIGUC/x2N0QqDMAwAf0XyvEDbgWX7lTFGWqMGpEpTx0D89
 wUf7+C4A5SrsMKzO6DyV1TWYuBvHeSZysQogzEEF+7euYht3SRjY22fRhPGkDL1ofdxfIBFiZQ
 xVSp5tqzsy2JyqzzK77q83uf5B4mzpBd1AAAA
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Submitting Co-Author <sub@coauthor.example.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696639433; l=2711;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SIEVaHthR5Ve3brLeeJf9IytmM4E9WoIPQI8DGRS/3M=;
 b=DOmjEF2R8rq8WZs6hM1z7rM2lY946gD/FywWsZB1OLCmP8rZ1a4ndfO2gtHwkBLCS397A7NYr
 XJSmL/tqEOmC9XbUADRe24xxL1L7pXGNcQUniAXuA/3mUc/aoZj4LT/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we blindly trust the submitters that they both compiled their
code at all, tested it on a relevant device, and have done so in a manner
that made sense for a given changeset.

If at least two of these three things were always true, the review
workflow would be much more exciting.

Introduce a new Test: tag to help submitters express the way the patch
was tested, making it easier to understand for reviewers and maintainers
whether it was tested, and if so, whether that test was sufficient.

I originally found something like this on Google's Android kernel repos
and loved the concept.

Test: make htmldocs and manual examination
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/process/submitting-patches.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 3fcfa029c9b3..c3fda5743ca7 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -522,7 +522,7 @@ Example of a patch submitted by a Co-developed-by: author::
 	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
 
-Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
+Using informative tags:
 ----------------------------------------------------------------------
 
 The Reported-by tag gives credit to people who find bugs and report them and it
@@ -600,6 +600,22 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
 patch candidates. For more information, please read
 Documentation/process/stable-kernel-rules.rst.
 
+A Test: tag confirms that the patch was actually tested by the submitter and
+helps reviewers determine whether the testing procedure made sense for a given
+changeset. The latter in particular, may bring attention to errors in the
+testing procedure and prompt a more in-depth examination of a patch.
+
+Commonly, ``Test: Smoke test on [device name]`` may be used to signify that:
+
+	 (a) The kernel compiled successfully with the default defconfig.
+
+	 (b) The device has successfully booted the image from point (a), with
+	     no apparent loss in functionality compared to the state before this
+	     patch was applied.
+
+	 (c) The submitter believes in good faith, that such simple test is
+	     enough, given the scope of the patch.
+
 .. _the_canonical_patch_format:
 
 The canonical patch format

---
base-commit: 0f0fe5040de5e5fd9b040672e37725b046e312f0
change-id: 20231007-topic-test_tag-72bca62617f9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

