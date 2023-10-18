Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567B7CDBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjJRMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjJRMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0610CA3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507bd64814fso2565186e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632245; x=1698237045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HCfwsrI9J7fSS6nZ06wNpwGLOX6X1eNRVhzdArLyyA=;
        b=P5Ulvp4hqj8CsUG8dji0Vv5g1a2xsF9M8mti/TB8QyMWWJZOKBMZnRwmJFekp4Qxk1
         xvJDCORQL0qqn3VL8FxokeIeKyDys4UxQDZSbvVqVePc6LDNt9DFVFSVzTFpWxxctjIS
         YJMOR3PLeX05MizXZcQoP5rA5JyE8LUesdiS3TaP0ZxoCyY3TRNMitJ9QsHL01EO8xZu
         fj94Zr8xvqoCgeqZWlSTXhsGcWTJrjj0tSty1wcoibQqhXmiplk+JVb+k5OHszu7NliG
         qMTIwGHV/BAbX4LAwIMxRLdvcx5m3zmW6ZHtHpEdrghOzyScUaW4vsDyuWOTx+RN0N3+
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632245; x=1698237045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HCfwsrI9J7fSS6nZ06wNpwGLOX6X1eNRVhzdArLyyA=;
        b=FMRfTBY6kwnAcEalODAjLhAmC1X9IyFiQ4E3tchqeZ8qtrEFaabnbgPXk1bf/xOcS5
         dKHQCtMeQtdP747f6W8CTyVuKGRfESuh4Qxhrodvgu9kPEWY3svYowc+kZBGuZfFxahu
         /woaBjP5FbnYj620pLHJGQKyk5Rmf+Aw3DZOlLr0/ZCcYI04GCmYcx7S6hFTEZdHgz0G
         qpOaoTG+wIsAQovyhr17q8hcQ2Xang+7birkSMhs2g8Lg/CkpeDcn0EUl//6SFg1yV9m
         YcR9OoROjRBGs0ef64TlOP9KfQAVtPhtHMVXdQ35c7xEvZNrRydZ/rsTppkJIow6o+F0
         YPxg==
X-Gm-Message-State: AOJu0Yxxl2mee9wfrAZq5jqDTNFSeCtasD3EKipFozPz8/fZfSV5fD+3
        beRmccZNuVA8kba55Zx34lmVgivJ6Zk=
X-Google-Smtp-Source: AGHT+IFRmj7PyLXQO1vpVdA128ADX8LPQtmNFK/YvESwNRRF895/L1l+BybStbkLFu+hG3d/Ef+xLQ==
X-Received: by 2002:a05:6512:4015:b0:503:38f2:6e1 with SMTP id br21-20020a056512401500b0050338f206e1mr4574357lfb.5.1697632244677;
        Wed, 18 Oct 2023 05:30:44 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:44 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 6/6] arm64: dts: qcom: starqltechn: add supply to framebuffer
Date:   Wed, 18 Oct 2023 15:30:33 +0300
Message-Id: <20231018123033.301005-7-dsankouski@gmail.com>
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

This prevents framebuffer from shutting down.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---

 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 58b765b4c41d..f6e3004fc445 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -33,6 +33,9 @@ framebuffer: framebuffer@9d400000 {
 			height = <2960>;
 			stride = <(1440 * 4)>;
 			format = "a8r8g8b8";
+			vci-supply = <&s2dos05_ldo4>;
+			vddr-supply = <&s2dos05_buck1>;
+			vdd3-supply = <&s2dos05_ldo1>;
 		};
 	};
 
-- 
2.39.2

