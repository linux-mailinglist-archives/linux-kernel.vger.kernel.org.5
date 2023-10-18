Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585B57CDBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJRMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjJRMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2E7A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507cd62472dso17664e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632242; x=1698237042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TztbikkZ51VRIxmNeKA/VvxfbGv/p8LjK23sQPIxK0=;
        b=DJ231Vl9NBb5hdZ9ngy94zsGQVSo0v/I30X9GekmxR3+pPNU2qqm5rwUHxvN88wpln
         VPE0216pJDfWi0tpA9fotc0Ih6JYWWL/f7HkAAjtTLJJXsoEI1f6mY4Ay90ttgw8pMZp
         ZIPqzv5MvcvwI6BpWkxLr9wHz4PUkdJQNzGthiKH54nD6fCEC9Lnqw7/9iscAUvMrJDk
         pwY1V577LakUoLfkGAoa0miohczj1N5BLMtEmfAQZ6u4mdr5f+dQZXT2GC0n7PixJPd1
         0L5O5lFdUi0bgtEXQSe5/7MD6TRHzAfgAwdTTq0FUhu81vAyycUZWPzK7Vf/7AcqZCzS
         SOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632242; x=1698237042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TztbikkZ51VRIxmNeKA/VvxfbGv/p8LjK23sQPIxK0=;
        b=rkjda/GxPWNYsh3KhuKJSsfBuAVfFYfMaxRfMoPvQyYlDnKLLZJzJRzbgIa29JbRzh
         +ZENXX+y7WdweXobO9a8l0r2jJCvyiv7D1bkYNZp1dEw0i+gPIanFhUmhlyCc5BYGDJB
         RgV1GqdlZRc/jKuh0gkeRWYjSvmD4oXTJkAOCXKgQJa6i8edz8gdb2nrz5IB651IPGsE
         eAqFAbtGf4GrF6WmnOKagjr8IcdmHDlPiW3DPshIOzpVhJSeOaw4ykq86vtcXq8BgSJF
         q8NYNBY3ga4ZBu2I1Mr7ZiQiYRqVUaCLHfNVyskbt5x6zP0sxqUVB557XxKn5uoGTzej
         tDIw==
X-Gm-Message-State: AOJu0Yw3MJ5wHXPr2iyzNeTWTVpV/ihI0QR83aLHOPsI34tvp2odovac
        37CB0JHtrzjHI+VT2yW2pmlSK0VUa1g=
X-Google-Smtp-Source: AGHT+IE0NtF4ZT9LQdgOMkeILbbkqJLmHfo7gyTLBH3hbjCA+K8LTA7ir6lbsdYa1MrAbA5qs6jqVA==
X-Received: by 2002:a19:f604:0:b0:507:cc09:59ab with SMTP id x4-20020a19f604000000b00507cc0959abmr251253lfe.9.1697632241943;
        Wed, 18 Oct 2023 05:30:41 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:41 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 3/6] arm64: dts: qcom: starqltechn: remove wifi
Date:   Wed, 18 Oct 2023 15:30:30 +0300
Message-Id: <20231018123033.301005-4-dsankouski@gmail.com>
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

Starqltechn has broadcom chip for wifi, so sdm845 wifi part
can be disabled.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---

 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 7c2457948a32..e9fa230d11ec 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -413,14 +413,6 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
-&wifi {
-	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	status = "okay";
-};
-
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <27 4>, <81 4>, <85 4>;
 
-- 
2.39.2

