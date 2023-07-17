Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17BD755D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGQHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGQHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:51:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC67E56;
        Mon, 17 Jul 2023 00:51:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso165687739f.3;
        Mon, 17 Jul 2023 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580290; x=1692172290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEYm+uCdh21vtzPh6yGEiTfgPybVQ4Gws/BVR8lDFGw=;
        b=B21eWkwiYUZWk4RMZN/v+9xtSs7+KMzCpts43evWoxRAjosFAIN+pujjG5PzeA56Uf
         C4Y3LEaRtMYbpy2BuIv+1Rt3cV1t29jSOBYtDtXjeSRmioCCgopyOPIDr88KIMQ5IPWA
         KfmQFUDxA/vgDKTg0ZTvN2vouCPn5Kg30xx5EZVVaqDJpIO84mnBEv4ZjAC2UvSHm56c
         eZupT4tRnaIScSh+I+GhEFWG8xZnmPukOS8jtySCcfOLyU04P8oqUZedNuFRmc2kMq4s
         jPFCsVM79MIFOVHltW0uTHm8xa1U03hlnDhRjwwZZLxpnjCErYmdECUKjEySiJnPC1ox
         0GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580290; x=1692172290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEYm+uCdh21vtzPh6yGEiTfgPybVQ4Gws/BVR8lDFGw=;
        b=EheNRjHbslYnXr5ekjWX9ZdE8nMilVXIqx981gWV9k8m/6aupCbwgjYs2L85xQxALT
         50t3rPqifZA9ssP8MWrRFV6p3TOxsfGqE+mHrNzxyK5Mes+Srf7TbwEbuk0a1TR8C8VE
         k36vx4AbiZYTsDT5B9jHktEracdxofCxC+MMTkQlvJzDBOSs9LA0sGjgi4+hbINbKgZq
         oe5Wdy9qg2UOhI+mx1h6qUWOZBPcOYoQtXodZyx7Gd+6DKFpyOqQS/eODPaRgD9sVHQP
         JVIVEU/nFHrE+7CfDTHYW7qcBhYkIhBw1J9iGVoAogin129q8lthrtDzb3S4dO9Zi6RP
         K16g==
X-Gm-Message-State: ABy/qLZsw75xGGaHKZq4fzPVgNUyh4c97c4hvCbwW0ZPAoD9URGolc7z
        kLwfIC6TLrhLcrGynFQkRe5Z9x63QsPKnA==
X-Google-Smtp-Source: APBJJlF6edBFS25YEdOmcG6Z4yN+UiocZ4M+lYK/exstURX/nmfgEEVrv4X8zaSepmPkAlAJr/qqGA==
X-Received: by 2002:a6b:d616:0:b0:783:3957:9b46 with SMTP id w22-20020a6bd616000000b0078339579b46mr9066359ioa.13.1689580290418;
        Mon, 17 Jul 2023 00:51:30 -0700 (PDT)
Received: from localhost.localdomain (211-20-114-70.hinet-ip.hinet.net. [211.20.114.70])
        by smtp.gmail.com with ESMTPSA id a13-20020a6b660d000000b00786fe5039b8sm4635283ioc.46.2023.07.17.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 00:51:30 -0700 (PDT)
From:   Dylan Hung <kobedylan@gmail.com>
X-Google-Original-From: Dylan Hung <dylan_hung@aspeedtech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, Dylan Hung <dylan_hung@aspeedtech.com>
Subject: [PATCH v2 RESEND] dt-bindings: clock: ast2600: Add I3C and MAC reset definitions
Date:   Mon, 17 Jul 2023 15:51:23 +0800
Message-Id: <20230717075123.1597977-1-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset definitions of AST2600 I3C and MAC controllers.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---

Resend v2 patch through my gmail account as the aspeedtech.com domain is blocked by gmail.com

 include/dt-bindings/clock/ast2600-clock.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index e149eee61588..712782177c90 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -90,7 +90,19 @@
 /* Only list resets here that are not part of a clock gate + reset pair */
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
+
+#define ASPEED_RESET_MAC4		53
+#define ASPEED_RESET_MAC3		52
+
+#define ASPEED_RESET_I3C5		45
+#define ASPEED_RESET_I3C4		44
+#define ASPEED_RESET_I3C3		43
+#define ASPEED_RESET_I3C2		42
+#define ASPEED_RESET_I3C1		41
+#define ASPEED_RESET_I3C0		40
+#define ASPEED_RESET_I3C		39
 #define ASPEED_RESET_I3C_DMA		39
+
 #define ASPEED_RESET_PWM		37
 #define ASPEED_RESET_PECI		36
 #define ASPEED_RESET_MII		35
-- 
2.25.1

