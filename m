Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3947C7D1681
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJTTqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJTTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:46:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F09D61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:46:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a397a7c1cso1537696276.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697831171; x=1698435971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VY26jasGvoK52ErKJqQiLhyEvSJKvdG2hTJjnfxEGsM=;
        b=ZNgOLavC8fzTZrLtjT8LABBsjAACnBHp8y++tiCif+Z3Xa6VKsWJsEIrSBnRbITeXn
         oMbBpSVzGVD0q7C72jAGMelMWToILzy7pf8Q9Q564+4fxxTDSFVBINmfMaUuboZXNsT0
         JbE2r02Kxv2O9H33zAgHz+SVQji/wWScrIAt9gRvcJXHQVWvRqVD5CQT2OMLcUGC9o+R
         QU0Rn0o1WXno6dXr8FgSCfV+6Fnevy7xPkSei+SAFQolzfraAOarhyaJmsIzc70RFq4i
         ICVRtqjt6NgYwWQRKVKF2yA2ZT8Aob+bviA5ZwxBvo1agAOUoFSge7x5kyRWcQ9TlMBJ
         Gkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831171; x=1698435971;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY26jasGvoK52ErKJqQiLhyEvSJKvdG2hTJjnfxEGsM=;
        b=kHSTgHwrcIKcnBSNzN9IQumLZN57fPAozbYI3J5ROK5ruwDKYoB74u2uM870te/sim
         uo5AWu5QUIJG/QTgFOSG6V24pUPqoRy9IPOLInMUzqKi52BVpPEgYdvZVURyQPVdGL1v
         vJ8FOkIewF4cIIDDHrEvgajSI3RAWkw7lGyXfuCp9EYtNH+Glprmgrf8+uo+Xl8eA3Jp
         Ml8owlZrwhpoAqgH96YtQU8XPrz8NCADDp6SrG/5zzMzp9BSJikwo6pXIMZsWBSnr4Jd
         QpmxW7c/sindZUeX4QNdrSTO4Jdxt6VtNp1VzIPCTLtEN7xBLO3htLp2ZdQxOszaljDP
         vwmQ==
X-Gm-Message-State: AOJu0Ywbq7whhYAFuuY/GDV8HQ4a8+eSvR0J5XF1vBO6AaJbb9B6mJ5I
        83Mv/XN4unTztv/1PPpdvd4R0fNOcl8aysPWcw==
X-Google-Smtp-Source: AGHT+IG97zohXV8c60rF/wNzxWx2VFDqrZjuW/RKQVsOoHrGomIA9J+a4stpEs9Ol6SfQRsZL3Blf2RTmc7HiEy5xQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:5008:0:b0:d77:f7c3:37db with SMTP
 id e8-20020a255008000000b00d77f7c337dbmr57402ybb.8.1697831171763; Fri, 20 Oct
 2023 12:46:11 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:46:11 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAALZMmUC/x2NUQrCQAxEr1LybWB3LUW9iojUbbYGZBuSWi2ld
 zf4NbyBN7OBkTIZXJoNlBY2nqpDPDSQn30dCXlwhhTSMYYU0GatWVYclBdSQ5k+pGhvkdfqoaX PdHdVR68ztl13TqE8YmlP4KOiVPj7P7ze9v0H31wQnoAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697831170; l=2331;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MoENqRWLCZfJlaomoU9I/5Gv5zHSfuvBj5Ts109QtOo=; b=AGIAqvvph99TN7o26x2Jna1GEQQbXsXDNhvBOWVmAJ4nDa1gz+pDDw6NLF4IDqEqLdmoBb7dh
 eSFv7SOqwvQDEk2QPNb16gHfi0TAPdg5TkfUSc3zf/NMuwfjv7hn8ew
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-surface_charger-c-v1-1-93ddbf668e10@google.com>
Subject: [PATCH] power: supply: surface-charger: replace deprecated strncpy
 with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect ac->name to be NUL-terminated based on its usage with format
strings:

surface_charger.c:
190: ac->psy_desc.name = ac->name;

...

power_supply_core.c:
174: dev_dbg(&psy->dev, "%s: Found supply : %s\n",
175:   psy->desc->name, epsy->desc->name);

Moreover, NUL-padding is not required as ac is already zero-allocated
before being passed to spwr_ac_init():

surface_charger.c:
240: ac = devm_kzalloc(&sdev->dev, sizeof(*ac), GFP_KERNEL);
241: if (!ac)
242:   return -ENOMEM;
243:
244: spwr_ac_init(ac, sdev, p->registry, p->name);

... this means any future NUL-byte assignments (like the ones that
strncpy() does) are redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt for the more idiomatic strscpy() usage of:
(dest, src, sizeof(dest))

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/surface_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index cabdd8da12d0..7a6c62d6f883 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -175,7 +175,7 @@ static void spwr_ac_init(struct spwr_ac_device *ac, struct ssam_device *sdev,
 			 struct ssam_event_registry registry, const char *name)
 {
 	mutex_init(&ac->lock);
-	strncpy(ac->name, name, ARRAY_SIZE(ac->name) - 1);
+	strscpy(ac->name, name, sizeof(ac->name));
 
 	ac->sdev = sdev;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-surface_charger-c-466920fb1f48

Best regards,
--
Justin Stitt <justinstitt@google.com>

