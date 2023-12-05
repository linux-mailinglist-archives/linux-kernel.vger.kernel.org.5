Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAF804BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjLEILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbjLEIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:10:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49733D4B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:10:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a195a1474easo516129866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701763832; x=1702368632; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipnJdp7mJoRPcpkndnemBdivVzYSFsiz8nUEcYGP2gg=;
        b=ocilNGWZXwuYEE/rbwutfvl9jqeBY0xScxc+nmH07ipSRUMrNO6tnBvaqu7KdwWS4j
         cZ25zLVxAGuxV02V6MBYJzXDig5ner+Qg6L1YuvQ6Avo8uEJUHZLei/CMlB+iw2SL5R4
         0juO6E5/42teGuLfRfA2CqtLhB6UVWU6F9UonulZZfm/4rwJPKHCmLAFAJ2TAzBMofMW
         sqso83yXM4Vb45XOejrDga/KQiMD/0G9wpGng7oyqM1MRHmLN/w9opGBF7b3qPO0GNMv
         1EQAURiFCHrvG2g3G/KaC6s8hUt/7680C9KN1FfwHLMhpVFxFfTzFF4uQEpvu5ZhnCUs
         eu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763832; x=1702368632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipnJdp7mJoRPcpkndnemBdivVzYSFsiz8nUEcYGP2gg=;
        b=dreA4NPj9WeT+BBWE61eVWzJoIuIww5baJSFGm8lMqc0bomFOs0RHMQ1J4BPtVDJaP
         WaS6TZOTtFbxCsHtts2wMGh9So1lYBvw4UcJAgyBgDWIG05RqxikAbUaIoLs7z83eg93
         IcW3s3DZS33Sc7z/YslQ5wBDQldrAevAtNC3q1cqQmZvpBW4aX3eDAtNBaYgkrl4XPLi
         MjxQoOyB8SXs3+npLMOEMVbJfpbeqfd3DtGY5/VhWXzYRsd8fJMyUkD+QooME/g/kAxh
         SS9rePZ5+yBqdthFn/yG01SU3OD3AJDTdj0LhmPdHVRC3pPEgIGE3bSsQFp35ZMgjVA8
         1Y4w==
X-Gm-Message-State: AOJu0Yx2etaK8VmPZta0ScDuAHoScqcHb2Rjk48un0DELvhalrG5AIg3
        mDD+VJCqlRFy7pzrIZNkQKy0ztyig4tGRzdNuPU=
X-Google-Smtp-Source: AGHT+IF6ASHTCJrg8w88p8r6cfFGVG4bFlEXyKcC+xXKM6td01zQgJMjtawNPeSmKDddkhPrigqIwg==
X-Received: by 2002:a17:906:314d:b0:a1c:9c1a:3d36 with SMTP id e13-20020a170906314d00b00a1c9c1a3d36mr158896eje.59.1701763832218;
        Tue, 05 Dec 2023 00:10:32 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id qx1-20020a170907b58100b00a0ad580e1b6sm541667ejc.48.2023.12.05.00.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:10:31 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 05 Dec 2023 10:10:29 +0200
Subject: [PATCH] soc: qcom: llcc: Add missing description for members in
 slice config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-llcc-fix-slice-config-warnings-v1-1-d6331d601dd3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPTabmUC/x3NQQrCQAyF4auUrA3MpIjiVcTFNKbTwJDKBK1Qe
 neDy/8tvreDS1dxuA07dPmo62oR+TQAL8WqoD6jgRKNmdIZW2PGWb/oTVmQV5u14la6qVVHTlR
 yvo5EF4JApuKCUy/GSzD2bi3GV5cQ/q/3x3H8AK5/Rh2FAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=jUwKJoHWjeRb21ldnTZQvf0NN0juAGv2FWSaUgUqmYU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbtr2inKGF5rLgE276S6VOS9BlsZaqEOGOxGKm
 oqr8r9Rv0uJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW7a9gAKCRAbX0TJAJUV
 VuNDD/0U9hjLeyfd/Nu8KPu21vwggb5wUXK/lSGSmb6aAcOvQO7dud4JNCOfi16qhzXMhn8SSqt
 N70jpo6Gy1xUYiCeaTCkQe6POnFh/I5FydiUm2kV2fTVzXzwdePC9oIqSausnUy5mNDGY+Wubcy
 oEbfAaRIUROR5PcPutpmHZWAcal/zA0FyF8JmH/DO/W2tMdguoPG/whIQd5Ai1ejSMNiRdSXBHr
 WDA7HAgLIxqZKIymOcChsuOSp+bLlhUB9uOfGMloOLphKbD2nXKHWOkTu/EviLeDgSVDJcGdbce
 LmRVT3submKJTRpiC/LYcGQINOQalQ1wyUM+lkmeKs83+d87x0H5J7TDinyAGvxMGmA9OguB7sB
 HX4EpNGRG7G4slH07yVybfj68CJib6lv1Rs7TIabC/axtu76zu4gIm7/4nYTnV6qi3BVfvsteY0
 U6OmLLLz1mGeCtM+dZW2812nMWZojegxWN6rvh/8giEMM+vhwLVyxFToBrqjKWBhhB2kR1vYlDe
 qasl+GruE0pwghKg0CPBB10AQfTjQWBRiBP66xA0uwqprIe9gYsXPbLI9v6WksNJL5cqAW0PH0B
 HjTsJ5qyfp5uAMervfsmiaAWrYSldeq9t1M9/489kVIU+cCS2POu1aPwRQXlcw9T+GDyOtdAo9A
 SWvv1lkZ9q6gyVw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all warnings thrown due to missing description for some of the
members in llcc_slice_config.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312050519.mup4Q8mD-lkp@intel.com/
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index fb4085b7cb19..76157e3a96b2 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -92,6 +92,19 @@
  * @write_scid_en: Bit enables write cache support for a given scid.
  * @write_scid_cacheable_en: Enables write cache cacheable support for a
  *			     given scid (not supported on v2 or older hardware).
+ * @stale_en: Bit enables stale.
+ * @stale_cap_en: Bit enables stale only if current scid is over-cap.
+ * @mru_uncap_en: Roll-over on reserved cache ways if current scid is
+ *                under-cap.
+ * @mru_rollover: Roll-over on reserved cache ways.
+ * @alloc_oneway_en: Allways allocate one way on over-cap even if there's no
+ *                   same-scid lines for replacement.
+ * @ovcap_en: Once current scid is over-capacity, allocate other over-cap SCID.
+ * @ovcap_prio: Once current scid is over-capacity, allocate other low priority
+ *              over-cap scid. Depends on corresponding bit being set in
+ *              ovcap_en.
+ * @vict_prio: When current scid is under-capacity, allocate over other
+ *             lower-than victim priority-line threshold scid.
  */
 struct llcc_slice_config {
 	u32 usecase_id;

---
base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
change-id: 20231205-llcc-fix-slice-config-warnings-c02a11832272

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

