Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529647CE914
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJRUey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjJRUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:34:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF16118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:34:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7aa161b2fso112137017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697661288; x=1698266088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GYfskxGvkh052vsvEl3d1awIlELqt+/ddHAW9BMrb5M=;
        b=tjTDUDggaay6pZ8JPWGnkBCMlNApkbCjAUcM95JTuLhhNKnx4jWxVlXdeIZLUrk5CA
         spybpbmeC77+7ZVi8jZEzRAinCS5ZqAEzHiW75KYIcVLyAxXmfJChHm1/Sho/rjyo7UZ
         JFkTSF0ajFt1PecigoRKX5q0NlFhtik1G0P7fv1NVKcyMcRmUlbl0vt+dT/j9clocfxc
         qLICOXY5foAUQyx/HrF8cS0HpSQRDw8oEXlwls7r6Q40dDlfgG3c48ZDIh+hrtF80hgr
         SDVZtJRhJWMyFPaTyEfW97HDtQyPb65V9Wuh3CYaBawU0qAP/YGU7wJ58q43xiiuxwgg
         CGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661288; x=1698266088;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYfskxGvkh052vsvEl3d1awIlELqt+/ddHAW9BMrb5M=;
        b=V9F4Z1mi8ue6XDL4UXdplptDMG0bgoeAiNY4P9FA1WBnSJ4Xstz0ng93iAyUfESmPh
         AaYVmOtgS/XvbJLptNqHPFpsgw/Gjh6zbaNffk8+DV0TRqxPkhXaZAOnb3pwOdfVIws9
         O1QyqP7muX7ljyvxmF0+gGSxe3uuiMHMfLB/kg15mW211SGZS2wyTWXpZj+pG1pEQmhw
         2F/7XfKwVhVc6XJtvjN1YwwqvIFVR4GBQR7onM7/F3Zeea0XA1RyDXv64KQ6jJ4oQXjQ
         CQDSiXttNFCf8a53puXtrFScjTFKQzRePkA8cJX3ZAhup46YRDbpepW87+rnFfDq0I6P
         iYjA==
X-Gm-Message-State: AOJu0Yz4o+7OCjEC1yYopm46Iqp4B3+Cl2yS1J8omt+CTC5wk01QynDY
        7m6IILue/x4lQJVXgpMrHMnTgNwrZ0w+MEU=
X-Google-Smtp-Source: AGHT+IHH9L2XcQrcEnBx+5sYGPq31tgkiNdL4i/MGxTDHxJzWb/KYYrSKiunlxKSpvVOsOx41RQLlhhGwcxpntY=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:4948:0:b0:59b:d33b:5ddc with SMTP id
 w69-20020a814948000000b0059bd33b5ddcmr8572ywa.4.1697661287989; Wed, 18 Oct
 2023 13:34:47 -0700 (PDT)
Date:   Wed, 18 Oct 2023 20:34:09 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=rdbabiera@google.com;
 h=from:subject; bh=hbXS4m7M+3a84/Y9ShZ33pG/hhrskV0AxsaMBUHbk7Y=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKkGjg4WTwWm9nz6HvjwYaA023frFi2/Z/w3b1Trlb2Ra
 JgRKnOyo5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgInMfMjwP5Zh0tM4sb/H7jhm
 iGjGq05RTf52o3CJRPDV/wIedq8PHGJkWPMnNezDosTQBc//BmpWrI2uKHjv5rRDJnG3sFSB0qr /XAA=
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018203408.202845-2-rdbabiera@google.com>
Subject: [PATCH v2] usb: typec: altmodes/displayport: verify compatible
 source/sink role combination
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DisplayPort Alt Mode CTS test 10.3.8 states that both sides of the
connection shall be compatible with one another such that the connection
is not Source to Source or Sink to Sink.

The DisplayPort driver currently checks for a compatible pin configuration
that resolves into a source and sink combination. The CTS test is designed
to send a Discover Modes message that has a compatible pin configuration
but advertises the same port capability as the device; the current check
fails this.

Verify that the port and port partner resolve into a valid source and sink
combination before checking for a compatible pin configuration.

---
Changes since v1:
* Fixed styling errors
* Added DP_CAP_IS_UFP_D and DP_CAP_IS_DFP_D as macros to typec_dp.h
---

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 5 +++++
 include/linux/usb/typec_dp.h             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 718da02036d8..9c17955da570 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -578,6 +578,11 @@ int dp_altmode_probe(struct typec_altmode *alt)
 
 	/* FIXME: Port can only be DFP_U. */
 
+	/* Make sure that the port and partner can resolve into source and sink */
+	if (!(DP_CAP_IS_DFP_D(port->vdo) && DP_CAP_IS_UFP_D(alt->vdo)) &&
+	    !(DP_CAP_IS_UFP_D(port->vdo) && DP_CAP_IS_DFP_D(alt->vdo)))
+		return -ENODEV;
+
 	/* Make sure we have compatiple pin configurations */
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
 	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
index 1f358098522d..4e6c0479307f 100644
--- a/include/linux/usb/typec_dp.h
+++ b/include/linux/usb/typec_dp.h
@@ -67,6 +67,8 @@ enum {
 #define   DP_CAP_UFP_D			1
 #define   DP_CAP_DFP_D			2
 #define   DP_CAP_DFP_D_AND_UFP_D	3
+#define DP_CAP_IS_UFP_D(_cap_)		(!!(DP_CAP_CAPABILITY(_cap_) & DP_CAP_UFP_D))
+#define DP_CAP_IS_DFP_D(_cap_)		(!!(DP_CAP_CAPABILITY(_cap_) & DP_CAP_DFP_D))
 #define DP_CAP_DP_SIGNALLING(_cap_)	(((_cap_) & GENMASK(5, 2)) >> 2)
 #define   DP_CAP_SIGNALLING_HBR3	1
 #define   DP_CAP_SIGNALLING_UHBR10	2

base-commit: 5220d8b04a840fa09434072c866d032b163419e3
-- 
2.42.0.655.g421f12c284-goog

