Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6947C78A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442954AbjJLVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442946AbjJLVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:33:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E4DC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:33:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ed6903a6so21450027b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697146413; x=1697751213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYSTVrCouVWE319gwaD4mDagDCplKYTMAl9k6NN6p0U=;
        b=j3CIIv3gCVmU9R0l2dslE+oPVXaVD1Wa12FQFQirrDPseN8A6dyuCjQkG4CehA7t1K
         zIKzQ/jnbO72wkULosOjGE3p2+FlOAojLHQt6Yhpgen1kY01ui21t7uupxt9dbDP7NBW
         Xsl7U0Ceuwcax1UQPZSnQ4gZzAz5K+Q20nqi2u7o2OnxBs0I4R91gOBp4hg0G4OTFwzC
         M/yTkOKiVBVDy/udMkd/tg9/nBLXJZ8WYkmYMYiW3RKBbYU40THgrA0nEhjEpn4veDd7
         SL55rM0LcZY4zrw+T2zRKByaW6gfhT1IBAhRWlYd7QkxJM1KA4s40A2t6S0cvivV35Gg
         IlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146413; x=1697751213;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYSTVrCouVWE319gwaD4mDagDCplKYTMAl9k6NN6p0U=;
        b=V6Jmmp6FtBe0JPv294pDgMzfjmkhal1T6pcOLE3bzeNXB3wXFI6bYdhJiTJrEMoFP2
         mzPggEoaExdSlUJuTBzJENKZFR7YPGz2gH+iKSQfVokFVCSQqj3L9J393wCTwA8GKtfG
         M79UfH6MBH07Mh3KF54XWP8IBxQ3BCqreDH/mwlNCW3PVudSU5mlIPl2CgJD/bdnFFGM
         Z0i7CBtoOXK4qsWc+txD31okFiFafqlaBhW7FNMeCMwgQs/7VGY12x7MZP3ZXxI6QnMp
         8KX8yFMqgEvrXDxg2oBgX4cnwf7rBxHZdokmO0SaUIVcJRPBd2c11LWIfF8MdLI3TN20
         jZhA==
X-Gm-Message-State: AOJu0Ywg9d5cPb8Q/KWBcx/bRL6mBg7O3o3roSf/yRJgcJXiCE0U86jT
        apS0KNt3CljkaW02OZq6PnJ2dh5RHMhAQPcX6w==
X-Google-Smtp-Source: AGHT+IHLXU+q2owngkTbSiNtMR5BADqKtueGDHMDZYEex8Po8KdOypDGg++9ce6J7+BSWDwmTy9Wy7uJXqIZ+5F3rA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:361e:0:b0:d9a:6b49:433d with SMTP
 id d30-20020a25361e000000b00d9a6b49433dmr164492yba.6.1697146413504; Thu, 12
 Oct 2023 14:33:33 -0700 (PDT)
Date:   Thu, 12 Oct 2023 21:33:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACxmKGUC/x3NwQqDMAyA4VeRnBcwVcbcq4wxahpnDrYlFZmI7
 27Z8bv8/wFFTKXAsznAZNOiKVbQrQGeffwKaqgG17qOWnJYVoucdwymm1jBKCvOfjEfNOHod07 LR3JGxrsQ8dA/unGYoPayyaS//+v1Ps8LZduKZXsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697146412; l=2666;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=GEipWyiXVMyF4NttCT1RNho91xfYNJdcMAw0nEmg9aU=; b=x7E6v7q0m/O/QprpRqxWPblE89KJH/8AAzMt116g3gzow9M2f7BwcEy/LlgWAsSKhgaWC4jk0
 9TdRQ3QWP87CvCdaWXAAGHMw7Gj12xOELpNOijQRm8halo5ZaaCR6zx
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
Subject: [PATCH] hamradio: replace deprecated strncpy with strscpy
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both hi.data.modename and hi.data.drivername to be
NUL-terminated but not necessarily NUL-padded which is evident by its
usage with sprintf:
|       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
|               bc->cfg.intclk ? "int" : "ext",
|               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
|               bc->cfg.loopback ? ",loopback" : "");

Note that this data is copied out to userspace with:
|       if (copy_to_user(data, &hi, sizeof(hi)))
... however, the data was also copied FROM the user here:
|       if (copy_from_user(&hi, data, sizeof(hi)))

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Also, there are 33 instances of trailing whitespace in this file alone.
I've opted to not remove them in this patch.
---
 drivers/net/hamradio/baycom_epp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 83ff882f5d97..30a0fbb12b9c 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -1074,7 +1074,7 @@ static int baycom_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return 0;
 
 	case HDLCDRVCTL_DRIVERNAME:
-		strncpy(hi.data.drivername, "baycom_epp", sizeof(hi.data.drivername));
+		strscpy(hi.data.drivername, "baycom_epp", sizeof(hi.data.drivername));
 		break;
 		
 	case HDLCDRVCTL_GETMODE:
@@ -1091,7 +1091,7 @@ static int baycom_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return baycom_setmode(bc, hi.data.modename);
 
 	case HDLCDRVCTL_MODELIST:
-		strncpy(hi.data.modename, "intclk,extclk,intmodem,extmodem,divider=x",
+		strscpy(hi.data.modename, "intclk,extclk,intmodem,extmodem,divider=x",
 			sizeof(hi.data.modename));
 		break;
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-hamradio-baycom_epp-c-6e11c9483b9f

Best regards,
--
Justin Stitt <justinstitt@google.com>

