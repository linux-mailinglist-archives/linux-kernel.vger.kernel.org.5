Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA87BADC8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJEVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjJEVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:41:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00BE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:41:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a234ffeb90so20885607b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696542061; x=1697146861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUNTafqkYZ7pS8TSpllde2onzuaLMD5Rpj1fQvAjFxs=;
        b=yih8VVQVbfsOJD+xe9G7VSjmr3gkSrWedv7OE+hc/NKhaEz52vDlJjfpANDyNCOo++
         ZuJQ5KRjVDHPo3XqJ+3Fi9+WyvUDWIRT2JMMe2m9BamJcMN7BXvENbovA9X18peyHhY2
         CYe/EFiW+eEqOOFmJ5qGoW1QFRdrwmx9o5Wz9wYT0cygBGmU9GdUgKjmziDI6554PGNM
         JvREF67MTmmfgu2+KTBQHUZREQ6k1YrkV2Gcg3M/myhyUZHmt/Rpdrf4bbKJQLymPb8O
         Uw1RfHbJr41a9wxTeNqTy0PQ3+o1lK3YxuX58TOExUz0iXqBa9QSwaTUsM8yVwnyifNg
         jEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696542061; x=1697146861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUNTafqkYZ7pS8TSpllde2onzuaLMD5Rpj1fQvAjFxs=;
        b=u9uDKIex8YOQ5EE1V1H4v2yANAx2w4DucottVBgBOHIvv7LpFjhut656+pndf4vGRA
         G8fyZvLg2zT4f3o9CrDMIuk7n307eXlSdwBs/8Llk496VFdmM7BmK5IHtq1Epa14l1fu
         eaLxiw4K8AhgmonHYnhCM/b5oVhzJq2ABaXSCDbEpdyqHl6TIf8eFDrUGGukvihzIbk5
         rSLtTqmmv+IYMFMu0HLQbAROhTOMvV+erRPA+CdpRNpH+ysr3CX3LR/e7Rj6Ah7lSprl
         rODSqIxORfp1488kHjdreeghdbeI2UBQ9ACSbkrzJPebVucfRnyD21F5PPYHtDgbUfIc
         nVgQ==
X-Gm-Message-State: AOJu0YzAGjo0MFjDk3p3RA0VUxHagNqO3e7597q0vDvnHztGpF6/bJpA
        eOnvoWfo/TTFBAcWL9mf9WyZSkZhu8ZeHNVbbw==
X-Google-Smtp-Source: AGHT+IHIj5z+jvjYSjnBQF7WCdI7cYn9+zHtt+lT2Tek1tSQxg8/n/kE/wh2oRCpNDC0LT+wVxbd/NvsJuSfkIjCmg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP
 id b8-20020a81bd08000000b0059bc811a702mr115088ywi.6.1696542061583; Thu, 05
 Oct 2023 14:41:01 -0700 (PDT)
Date:   Thu, 05 Oct 2023 21:41:01 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGwtH2UC/x2NQQ7CIBAAv9Ls2U2gDWj8ijEGYWs3sVAXSjRN/
 y56m7nMbJBJmDKcuw2EKmdOsYk+dOAnFx+EHJpDr/pBK2UwF4l++WAQriQZIxWkMpH8wLvK64x Pfq0cODVIt9lxRI93ZcbjyVptBwOtvgiN/P6fL9d9/wIUVboaiQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696542060; l=1918;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yhFq2y5Pvep99s3JFnDeKpoF+G2I2fKxp4dpMs9PGrs=; b=IYKSrXCoOucrIGOtUWa4qysZwdksei5CHi15EgsgQOrR/qCXqCUliEBjohbluw3vTmot+IDW9
 T5berNGOdbtBJlSvm1r9BfJbMiOaF5ISWKSrN++2bykFZjoprZKmXdg
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-v1-1-663e3f1d8f99@google.com>
Subject: [PATCH] net: liquidio: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We know `fw_type` must be NUL-terminated based on use here:
|       static bool fw_type_is_auto(void)
|       {
|       	return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
|       		       sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
|       }
...and here
|       module_param_string(fw_type, fw_type, sizeof(fw_type), 0444);

Let's opt to NUL-pad the destination buffer as well so that we maintain
the same exact behavior that `strncpy` provided here.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees both NUL-termination and NUL-padding on the destination
buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 100daadbea2a..34f02a8ec2ca 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1689,7 +1689,7 @@ static int load_firmware(struct octeon_device *oct)
 
 	if (fw_type_is_auto()) {
 		tmp_fw_type = LIO_FW_NAME_TYPE_NIC;
-		strncpy(fw_type, tmp_fw_type, sizeof(fw_type));
+		strscpy_pad(fw_type, tmp_fw_type, sizeof(fw_type));
 	} else {
 		tmp_fw_type = fw_type;
 	}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-b05f78661635

Best regards,
--
Justin Stitt <justinstitt@google.com>

