Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE37D68CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjJYKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjJYKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E01716;
        Wed, 25 Oct 2023 03:34:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52F3FC433C8;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698230089; bh=To9+llqVwQfE3FZYma/wWqALeRFyp/9+Ac4qHFPwfQc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FzwS0199WwjkV+1Fcqqi4ZRw1eaGO+ES2LrQBDkUR31aV8WgtrVT3vIreqzuijz23
         L+I6kRnSBpcZSvM86a4uSv00LdXn3DSCpV/qeflzVWjoeAd/UCZKATVZH/McGVLU9s
         /2HnfOaLHV9h4ND45wlFwyKG5WxR0m/iNBddLuDE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 266FAC25B6B;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Wed, 25 Oct 2023 10:34:11 +0000
Subject: [PATCH 1/4] MAINTAINERS: Add entry for ina238 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-ina237-v1-1-a0196119720c@linux.dev>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
In-Reply-To: <20231025-ina237-v1-0-a0196119720c@linux.dev>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698230088; l=764;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=To9+llqVwQfE3FZYma/wWqALeRFyp/9+Ac4qHFPwfQc=; =?utf-8?q?b=3DGbcBOmbxKW/N?=
 =?utf-8?q?aOZK/tWlRFetfHjOKl+VCAXOa2pUDIWUfcoEjx++tHSDimH9wHPkypn2z8yR908y?=
 oV7A1CFxDLcMhgE5pRVfnFfPrGx+xr9d6mKqdI52FLyq7kX1jBXV
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=ZYa5+0m9RFYtnNU6DLet7sHyPehnVHa0ucJlYiAu2NU=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20231025 with auth_id=90
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ina238 driver is available since 2021 but lacks a MAINTAINERS entry
file. Therefore add the missing entry now.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 668d1e24452d..28f91c8a2e1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10267,6 +10267,12 @@ F:	Documentation/hwmon/ina2xx.rst
 F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h
 
+INA238 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/ina238.c
+
 INDEX OF FURTHER KERNEL DOCUMENTATION
 M:	Carlos Bilbao <carlos.bilbao@amd.com>
 S:	Maintained

-- 
2.40.1

