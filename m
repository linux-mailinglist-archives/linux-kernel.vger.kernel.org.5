Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064457CDBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbjJRMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjJRMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D4E116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a3b8b113so5507608e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632244; x=1698237044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c5bvQ+WgWpXL9DZXQiIiVsfEO/Jpl8XzhFUIIC/Hqw=;
        b=gGPFZGjkncXz+t+FNHBq7lpcFCGBZBcv9h5bBYhV9Bs8H4pah/8a6UBKKs/4saQa91
         6LLr64RA8Oj185okAbK2/5rEVDJbQwjF/bEbWj5mAYpSLT0dEx5y2tEO2N2fRXiDYuuf
         Libh6XEOkyDiRVNDlt/I3b1HADQLuBXYuh3bEbzaEy4t0ntIpaDtGSFb+jdUQW91Gk8M
         W0SdniVskGInYn+R0fylcYF6+91M114xP3MO2VgMrBkmKTXPmaWYFZ/pTVU2C7UREd0e
         mBTlWgO+YwPREcTxpbC75TuQARtbBux+B8ZLCjjJQUQgC+wvXW4KD3h4VNj79LfSCFlI
         glwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632244; x=1698237044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c5bvQ+WgWpXL9DZXQiIiVsfEO/Jpl8XzhFUIIC/Hqw=;
        b=CMX+HOYNbTVWOgzKPjf1xVlXo2vZ5GxDtq28YS8j+ChDVdfPUvLqNtAnYy80YTQ+r2
         SO9t3859JLcGVNM8CcfyOrg9n1+G29q1iDOw44GI0tshpVjmeqRxXouubi6k5gsl6FjK
         d0rnYHG7MI+oNoBxiBCtocz6ZnQ2hTDeEOrYh6WX4wltWquihEXiBtiDARsoVtOTFt8y
         KUC4bfqi/VFhn8idSVEL+JWZNKsONUgv/dQRNqKadctKq9eNWoLzhIMhWAAYElkGsbBF
         2y5haAlXWZqYZPIICXijQRhv8WR8Y3SMhR+HW2dgUEpATG5Q3KhBr8W352sm28oQGerj
         mD+A==
X-Gm-Message-State: AOJu0YwRDswaJBs1kPj7pzmqS0iZsdjukhMGLjpokl330yqjgSNvqsBZ
        3Ovf72vVabO/yKdT/s1zJxHe9mijJ6Y=
X-Google-Smtp-Source: AGHT+IG/I2G0/HKD7FjwEkIDN3feIz4U0OY/xd7i0aeQvFx/nUe+eKExqYcCtGKeKDBJFknommoCDQ==
X-Received: by 2002:ac2:4c4b:0:b0:503:446:c7b0 with SMTP id o11-20020ac24c4b000000b005030446c7b0mr4653413lfk.32.1697632244000;
        Wed, 18 Oct 2023 05:30:44 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:43 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 5/6] arm64: dts: qcom: starqltechn: disable crypto
Date:   Wed, 18 Oct 2023 15:30:32 +0300
Message-Id: <20231018123033.301005-6-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018123033.301005-1-dsankouski@gmail.com>
References: <20231018123033.301005-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the crypto block due to it causing an SError in qce_start() on
the starqltechn, which happens upon every boot when cryptomanager tests are
enabled.

Same problem is on Lenovo C630, see
commit 382e3e0eb6a8 ("arm64: dts: qcom: c630: disable crypto due to serror")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Link: https://lore.kernel.org/r/20211105035235.2392-1-steev@kali.org
---

 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 3bc9ae5f6213..58b765b4c41d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -502,6 +502,11 @@ touchscreen@48 {
 	};
 };
 
+&crypto {
+	/* FIXME: qce_start triggers an SError */
+	status = "disable";
+};
+
 /* Modem/wifi*/
 &mss_pil {
 	status = "okay";
-- 
2.39.2

