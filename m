Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FCA7D7D60
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbjJZHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjJZHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:08:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C0129;
        Thu, 26 Oct 2023 00:08:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39C06C433C7;
        Thu, 26 Oct 2023 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698304136; bh=/GtJaouCP9uYvnQf/YrQKxvci6Y4JpBN0GXQjS2r29E=;
        h=From:Subject:Date:To:Cc:From;
        b=n9J5TpYidezIblJXGajSjuAGMsIB0iQ8lxWEqWgto77GA6J+MmoJ6+3xazy5CmQ8L
         IS89D55Lg/QGM/D5dODhxw366HMfhfCGC3VKs8m12YRWMwEaUYE13EsXd8aVM8/jDP
         L9tJGxQr7ebvy6PLSXfyn1rbo1zcqU0qG/EU935k=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF5C25B48;
        Thu, 26 Oct 2023 07:08:56 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Subject: [PATCH v2 0/2] hwmon: add ti,ina237 support to ina238 driver
Date:   Thu, 26 Oct 2023 09:08:48 +0200
Message-Id: <20231026-ina237-v2-0-dec44811a3c9@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAQOmUC/2XMywrCMBCF4VcpszYyM7WWuPI9pIuQix2QVBINl
 ZJ3N3br8j8cvg2yT+IzXLoNki+SZYkt+NCBnU28eyWuNTByT8iDkmi4HxUGMtrSKbjBQTs/kw+
 y7tBtaj1Lfi3ps7uFfusfUUihMkj6TKRHRnt9SHyvR+cLTLXWLz4oR82cAAAA
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698304135; l=878;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=/GtJaouCP9uYvnQf/YrQKxvci6Y4JpBN0GXQjS2r29E=; =?utf-8?q?b=3D0tI3/dPziYw9?=
 =?utf-8?q?MSGLgP4np9BF9AJSZ2F7UAb/TMp0Q9VBuy5n3mYqM+tlptr9PzIZ5Ry7Nh3zqkVY?=
 Rw49LwMcAnEYWN8DrDuEHdJAHZxMWhV1HXkKjLNHKC3636hVLHYJ
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=ZYa5+0m9RFYtnNU6DLet7sHyPehnVHa0ucJlYiAu2NU=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20231025 with auth_id=90
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the ina237 power monitor to the ina238
driver as those two are very similar.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
Changes in v2:
- Drop separate MAINTAINERS entry as it's covered by hwmon
- Drop separate dt-bindings for ina23{7,8} as discussed with Krzysztof
- Link to v1: https://lore.kernel.org/r/20231025-ina237-v1-0-a0196119720c@linux.dev

---
Richard Leitner (2):
      hwmon: ina238: add ina237 support
      dt-bindings: hwmon: ti,ina2xx: add ti,ina237

 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 drivers/hwmon/ina238.c                                 | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 4f82870119a46b0d04d91ef4697ac4977a255a9d
change-id: 20231025-ina237-0f1a9c14fd5d

Best regards,
-- 
Richard Leitner <richard.leitner@linux.dev>

