Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB217CB2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjJPSms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:42:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534FAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:42:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so75149967b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697481763; x=1698086563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ivRw9UOALg3+ZFDXu75FoDqQWG1hBKv7UDpo12vH7Vg=;
        b=ovu4Ttrro/dxJHYw/mxQXqmiihXMWQ6OfaBHGjRttDM3U678UNLkXb7g2gO0MVlwio
         llHQGR77CLZiYHkCxHq6nTyrICSbtL1zwNKbEO0Fd/OI2nVM3ibQaZb7lYSzdtrLzgks
         FxGCS/JqMzU6TuMn69rkjse0wwLPqv8QsZaV28+R/bUXQ0q+FAM8mGz532pLkTRpRlTN
         vt86DfwqSWqbU5EvvR4az+dirLcsJryhR3LC0++kd6wywNrORg83y5523ve+zXKdsuur
         VEBHPT5R6d3haOUeH0flDoR4HyYqVE1buvy+q+5CKyZyADUEON4SWWI5MP7tsPrI+6Ws
         Okvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481763; x=1698086563;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivRw9UOALg3+ZFDXu75FoDqQWG1hBKv7UDpo12vH7Vg=;
        b=CEsrSNXziFupAlgLDdiIkKbo2/GkkWMUZkbFb83XbIOx7VsueeSGT6EfeIm1S5gZNq
         ZF/4ZobhgovQgSVmtRFZqHIZLKnVm9kw48VrQCugoYzSrGX9YYMo9v4Q1jXnP5TlFG4J
         Yz9hdzggHRatbb6uzZ/k0A2zH5dI90QkxWZPrjX2Q7VinOQRzQRwXbglSfw+/UFsR7sS
         yPFqd4vT3DR1+jkMKDBkE6bfuJ0eaIs2kI1F3n6L7JL+t29/LLSeDQu+r/8XuoBwjggM
         U0EevWr6kr8aHxLw7ASAFEOUzGmBAZ6LtDWaiiHGn3XFW8b4qeXWNnakLB0drzIBzwj2
         tzEA==
X-Gm-Message-State: AOJu0Yxtc9gSkwAMcKkQXlYsUTywJ0oo8or67lYJj6plHNuaWTJXBHVY
        F+qU3KjIB7S7nQ5ubaNxzxsfJZK/q5WFxz6rPg==
X-Google-Smtp-Source: AGHT+IFuTvb8CF14ArEw4X9jZT4hKRCTZvNAsD5jxo5CBCgw7rpVSQ1ttcs0rr39kBvX/wg1x6dg66NZdrU0PCNqaQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d8ce:0:b0:5a7:b15a:1a7d with SMTP
 id a197-20020a0dd8ce000000b005a7b15a1a7dmr165ywe.2.1697481763100; Mon, 16 Oct
 2023 11:42:43 -0700 (PDT)
Date:   Mon, 16 Oct 2023 18:42:42 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACGELWUC/52NQQ6CMBBFr0K6dgwtqODKexhiShlgEmmbKWkkp
 He3cgSX7+fnvV0EZMIg7sUuGCMFcjaDOhXCzNpOCDRkFqpUlSylgrCyNX6DgSkiB7C4wqwX1gM
 56PVm3PJC78HAFaU0bd1UfTuK7POMI32O1rPLPFNYHW9HOsrf+k8lSpDQjHXZ3i5Vg1g/JuemN 57zRXQppS8DPjql4wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697481762; l=2821;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9OAsLt5xhpoq++LwUFSyGBM2eLJQZ3SSzZBtifp1JdY=; b=r2iDDmOZ06G4yQXq+rRj5nSlF16zH6RZUjIrABYMNgufZfNtz6QUD+vkxcP1bQip47HAJEkgd
 B9zyXnN4z0zCvXN0Y3xSGzg9yScCK9GWviqrj7moA4RtZvbBdZMP9WZ
X-Mailer: b4 0.12.3
Message-ID: <20231016-strncpy-drivers-net-hamradio-baycom_epp-c-v2-1-39f72a72de30@google.com>
Subject: [PATCH v2] hamradio: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
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

We expect both hi.data.modename and hi.data.drivername to be
NUL-terminated based on its usage with sprintf:
|       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
|               bc->cfg.intclk ? "int" : "ext",
|               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
|               bc->cfg.loopback ? ",loopback" : "");

Note that this data is copied out to userspace with:
|       if (copy_to_user(data, &hi, sizeof(hi)))
... however, the data was also copied FROM the user here:
|       if (copy_from_user(&hi, data, sizeof(hi)))

Considering the above, a suitable replacement is strscpy_pad() as it
guarantees NUL-termination on the destination buffer while also
NUL-padding (which is good+wanted behavior when copying data to
userspace).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad (thanks Kees)
- bytes arrays are now considered "buffets" :) (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com
---
Note: build-tested only.

Also, there are 33 instances of trailing whitespace in this file alone.
I've opted to not remove them in this patch.
---
 drivers/net/hamradio/baycom_epp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 83ff882f5d97..ccfc83857c26 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -1074,7 +1074,7 @@ static int baycom_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return 0;
 
 	case HDLCDRVCTL_DRIVERNAME:
-		strncpy(hi.data.drivername, "baycom_epp", sizeof(hi.data.drivername));
+		strscpy_pad(hi.data.drivername, "baycom_epp", sizeof(hi.data.drivername));
 		break;
 		
 	case HDLCDRVCTL_GETMODE:
@@ -1091,7 +1091,7 @@ static int baycom_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return baycom_setmode(bc, hi.data.modename);
 
 	case HDLCDRVCTL_MODELIST:
-		strncpy(hi.data.modename, "intclk,extclk,intmodem,extmodem,divider=x",
+		strscpy_pad(hi.data.modename, "intclk,extclk,intmodem,extmodem,divider=x",
 			sizeof(hi.data.modename));
 		break;
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-hamradio-baycom_epp-c-6e11c9483b9f

Best regards,
--
Justin Stitt <justinstitt@google.com>

