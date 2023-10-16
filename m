Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683957CB6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJPX2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPX2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:28:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E419F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:28:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7be940fe1so79690227b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697498916; x=1698103716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCEoGPg5XicSC5Xjwme8YYz464nUUt8cFx09Ne//9NU=;
        b=ASkD4ICkNVi+O94JqJrR8DnsayeEq73xP3M5R7bBfWmbQM1F6sFEWiJXhTH3EHBWQZ
         5rxSGXBaavHWVYd65p/6oSIMvyx1RnaSEnS+qc/1Fbl6MpdNbELqFc1gmDBxPR/NinzC
         UXKPORQFpfC4tFbkWYLOBBs0BKBjTEPGhH2zf3rWYTQ6iZ/TRGvoxzOUIwTIgvYur+AA
         g3MAC6PlywziwDbEtxMq42FCLiV0lyi/8NaRWGKzF7QVOffUGWZlbeHwg+2r2uqi1cs9
         NbGo1L6jL3Zraq9ldMJ1EpbkHwXHdvdQt+7x6bqo4yYmdLJMt+a6O3/nrcfGzhosX8K1
         Z4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697498916; x=1698103716;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCEoGPg5XicSC5Xjwme8YYz464nUUt8cFx09Ne//9NU=;
        b=VunKRi2mn7rwlYePGBHCS3vGP51knV0adEP3hv3rGbgdFX/sBRzgwyIAyZ+gxwhCpO
         3PIL6KScBQhBOw4aeS3UiBS21Idwqm9rzmwYXxBsmzCMxLioxWRAxRi2yQEvVCjZQnH4
         gcTol+KwnHMfw0QV00t4bYTdzfG2cpuWRlUZfIG/QBe0xBGZGOVIOxpbaoX6U2cXPHiS
         Fy7CAG7aay52X27wCdJtbJPNEoQ5lTI6RX9t+sLM77Hoy9Z6CQMHdKxQ/p+fpCG8iGkC
         teqlFYhDUh4b6DAo8OeUe1WZUo2Jom0NDXquGgZFguTBEV3cjmuiD14SG+VqOBI8fXCV
         s1Ag==
X-Gm-Message-State: AOJu0Yzso8WnxS1bWNLupbgYBuu1NUrZ+abnSBoGRnYSypsw0WaS7cbh
        Nw8KPQm2JaWxEB+8QTpKCCSRc8tbaJwUpqA=
X-Google-Smtp-Source: AGHT+IGJR7NB1mIcK2dsdanuV4sAi/wWrSH1AH60bsH/QvglRjccxlpkobERrOhFRQqULXMQNqylQTWSsGTdcH0=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a0d:cc16:0:b0:59b:f138:c845 with SMTP id
 o22-20020a0dcc16000000b0059bf138c845mr15744ywd.2.1697498916624; Mon, 16 Oct
 2023 16:28:36 -0700 (PDT)
Date:   Mon, 16 Oct 2023 23:28:17 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; i=rdbabiera@google.com;
 h=from:subject; bh=nfiKb/BBwAYP9K/Daob1zJwyNTpgKdrEc4lVQIZP2tI=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKm6xwWErj4wXHDBu6b4tkhJoFZfTeVGo8rshLuF+SfuW
 1ydv7mwo5SFQYyDQVZMkUXXP8/gxpXULXM4a4xh5rAygQxh4OIUgIlIazIyLPyWYig+afb73RX6
 PyocNVLubrgmMFNXduP0WwFOmkITqxgZ3u5OKVu5Trj47Nb9n+1Ckrif1p8uaNasLNtUdXTyy7P ibAA=
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231016232816.3355132-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: only discover modes the port supports
 svids for
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux@roeck-us.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DisplayPort Alt Mode CTS test 10.3.1 verifies that the device can
recognize the DP SVID in arbitrary locations within the Discover SVIDs
response message. The test expects that the TCPM sends Discover Modes for
the DisplayPort SVID first, but fails because the TCPM sends
Discover Modes for all SVIDs regardless of whether or not the port
supports them.

After discovering the port partner's SVIDs, skip to the first SVID
supported by the device when preparing the Discover Modes request. If
other modes need to be discovered after the first Discover Modes message
is returned, skip over SVIDs not supported by the device.

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 46 +++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6e843c511b85..96636a6f1f7c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1543,6 +1543,38 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
 	return false;
 }
 
+static bool svdm_port_supports_svid(struct tcpm_port *port, u16 svid)
+{
+	int i;
+
+	for (i = 0; i < ALTMODE_DISCOVERY_MAX; i++) {
+		struct typec_altmode *altmode = port->port_altmode[i];
+
+		if (!altmode)
+			return false;
+		if (altmode->svid == svid)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * This helper will continue to return the next supported SVID that the port
+ * needs to send DISCOVER_MODES to until the pmdata->svid_index is incremented after
+ * svdm_consume_modes() in tcpm_pd_svdm().
+ */
+static int svdm_get_next_supported_svid(struct tcpm_port *port, struct pd_mode_data *pmdata)
+{
+	while (pmdata->svid_index < pmdata->nsvids) {
+		u16 svid = pmdata->svids[pmdata->svid_index];
+
+		if (svdm_port_supports_svid(port, svid))
+			return svid;
+		pmdata->svid_index++;
+	}
+	return 0;
+}
+
 static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
@@ -1705,9 +1737,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			if (svdm_consume_svids(port, p, cnt)) {
 				response[0] = VDO(USB_SID_PD, 1, svdm_version, CMD_DISCOVER_SVID);
 				rlen = 1;
-			} else if (modep->nsvids && supports_modal(port)) {
-				response[0] = VDO(modep->svids[0], 1, svdm_version,
-						  CMD_DISCOVER_MODES);
+			} else if (modep->nsvids && supports_modal(port) &&
+				   svdm_get_next_supported_svid(port, modep)) {
+				u16 svid = svdm_get_next_supported_svid(port, modep);
+
+				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
 				rlen = 1;
 			}
 			break;
@@ -1715,8 +1749,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			/* 6.4.4.3.3 */
 			svdm_consume_modes(port, p, cnt);
 			modep->svid_index++;
-			if (modep->svid_index < modep->nsvids) {
-				u16 svid = modep->svids[modep->svid_index];
+			if (modep->svid_index < modep->nsvids &&
+			    svdm_get_next_supported_svid(port, modep)) {
+				u16 svid = svdm_get_next_supported_svid(port, modep);
+
 				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
 				rlen = 1;
 			} else {

base-commit: d0d27ef87e1ca974ed93ed4f7d3c123cbd392ba6
-- 
2.42.0.655.g421f12c284-goog

