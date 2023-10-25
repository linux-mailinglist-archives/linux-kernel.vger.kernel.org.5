Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E97D68D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjJYKfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJYKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5191715;
        Wed, 25 Oct 2023 03:34:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A22BC43395;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698230089; bh=xtsuT6/iXfx/uvEO3WShw9/zkkhG/bR6W4AGKYROtvM=;
        h=From:Subject:Date:To:Cc:From;
        b=06RUCYPIyrx3wJsiycc1o8fYgtFFN67jU2LFOOTc4iYfv3dAFFxBeBbn71vxgAokb
         r1u9LPZ/j2v9qD8k4yXCX45eVCW7Xc6c4LCwLi1gx1dIdHJJDVJDxnGnPyoWPuYGaT
         oNOUJ9Co98otgSz/ljCYgopvSamLDY0QbGebVTzk=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB10C0032E;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Subject: [PATCH 0/4] hwmon: add ti,ina237 support to ina238 driver
Date:   Wed, 25 Oct 2023 10:34:10 +0000
Message-Id: <20231025-ina237-v1-0-a0196119720c@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLvOGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNT3cy8RCNjc12DNMNEy2RDk7QU0xQloOKCotS0zAqwQdGxtbUAgSW
 57FgAAAA=
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698230088; l=974;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=xtsuT6/iXfx/uvEO3WShw9/zkkhG/bR6W4AGKYROtvM=; =?utf-8?q?b=3DJSCc6cvbBsof?=
 =?utf-8?q?fyx845Xz1K3QnAHJDn6h/3HULSsfLgA7GaAMdQDRywoCxnPoEBDsbxIVDErRcq5c?=
 4RSZFpziB6Fb979JlJ5Ko1OaM0w0qSIWWsks1YSxlqQCISpmoZdu
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

This series adds support for the ina237 power monitor to the ina238
driver as those two are very similar.

As the driver missed MAINTAINERS and dt-bindings I've also added them.
If this is incorrect please just ignore the patches or drop me a line so
I can provide a v2.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
Richard Leitner (4):
      MAINTAINERS: Add entry for ina238 driver
      dt-bindings: hwmon: add ti,ina238
      hwmon: ina238: add ina237 support
      dt-bindings: hwmon: ti,ina238: add ti,ina237

 .../devicetree/bindings/hwmon/ti,ina238.yaml       | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++
 drivers/hwmon/ina238.c                             |  3 +-
 3 files changed, 56 insertions(+), 1 deletion(-)
---
base-commit: 4f82870119a46b0d04d91ef4697ac4977a255a9d
change-id: 20231025-ina237-0f1a9c14fd5d

Best regards,
-- 
Richard Leitner <richard.leitner@linux.dev>

