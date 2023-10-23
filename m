Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993E7D4045
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJWT06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWT0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:26:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F162681
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:24:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso3596237276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698089081; x=1698693881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1u0nT80/oWTGKj5iiFWIMDgyK4i/U55br4Gc2RUIvo=;
        b=WDW/yDkcw9atejGZZ6wUfuQtZv7E3+XEHEUKwat8sz8lD6Ygqo/AvtTYri9MU/XIbb
         cnRELqN9j1DY9Ua5tU6ovxSlCzO4EyrM/Sd/lFkg834DgTU9HsvoTrQ03AdXGgdeBbhU
         YUfh8Ed0VsjjPRmW6XTI1CCY+0X6waWkP7tViHl5CYv6hyC/8vLhf7cU8plGUlLw/FG6
         NG8+iTIenL7jXhgh8eKNuMlto6pz/hdDXdgLGM5I16hGfAEkTi0UZuGkb4Yhk59Jy045
         4Cw0Pej2OUftX13u+3IztaV1KxIWfH7ARMdei8SoCu5EvvYZhn2gYVy04hCmnLm3FLFh
         15qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089081; x=1698693881;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1u0nT80/oWTGKj5iiFWIMDgyK4i/U55br4Gc2RUIvo=;
        b=lf9Qf9lp59uFhjhzONxK37zipGwEQRBjO0xQ7cl1yIgt52VsPWgy1RZOGJ1H/hB5Iy
         2alzhpyGBeCageeoK8438MoMuSDpY3uLpx5kO2Ay4+h1tU2kWfCCShCXAUHuh/TVF8YD
         XaPsAR58myYSxDX2R46iqoxZAbQL0BLMp4o4OnfcAxvNWdernZksBxsvPB07SBYbranr
         U/0OdZW9YUPsjyskaMKDkZiigngzMBtSl85h9A8u+SNShog9BGGYQcv93c8dq8qx99aD
         zMwEpENBqQSQfiWb4XWWrn0PAoooFqkJw0/TdYZwZuHavgn6moH1rRo7JUE0T44NXTkO
         PPlQ==
X-Gm-Message-State: AOJu0YxkhAZFr0XSDGFr4aCQlWS2wrsteKJDxlGUdfHvY1M9I9/a8FcN
        IsaSoyUTwtf05cpIcW3lv4GiIyQSUIAPHeWc7g==
X-Google-Smtp-Source: AGHT+IFUKYK2xSaVpZRjE3yKqd5oCeoZ5INX6+H5nQEkU7FkNWODenlUp4Z0Cw1VHadoUivSdTo9IcOT3px25CBk7w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:874e:0:b0:d9a:be7b:283c with SMTP
 id e14-20020a25874e000000b00d9abe7b283cmr227737ybn.0.1698089080962; Mon, 23
 Oct 2023 12:24:40 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:24:38 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHXINmUC/x2NMQqAMAwAvyKZDahFin5FHDSNNkuVREQR/25xu
 OGWuweMVdigLx5QPsVkS1nqsgCKU1oZJWSHpmpcnUE7NNF+Y1A5WQ3NdRWSbEjRCAndPC2BfOv a2UOu7MqLXP9hGN/3AyEFH6FxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698089079; l=2352;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=shgo/ijuilR7APiDoVAzbgVjyPHSx3Fk4jWNLwNojr4=; b=iqSHq59hDlv00a+mF9qf2ovdAGlGL5EEa7A/NR+u7F7rOs3+i4mmCJiOjuH5qO5BjIgPIVBYz
 4kn+m+pQ0U2DyEmeQcvAN9EZqdiwn+3XS4gufoUEdlcJ1UfVm7KtkTw
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-s390-cio-chsc-c-v1-1-8b76a7b83260@google.com>
Subject: [PATCH] s390/cio: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both `params` and `id` to be NUL-terminated based on their
usage with format strings:

	format_node_data(iuparams, iunodeid, &lir->incident_node);
	format_node_data(auparams, aunodeid, &lir->attached_node);

	switch (lir->iq.class) {
	case LIR_IQ_CLASS_DEGRADED:
		pr_warn("Link degraded: RS=%02x RSID=%04x IC=%02x "
			"IUPARAMS=%s IUNODEID=%s AUPARAMS=%s AUNODEID=%s\n",
			sei_area->rs, sei_area->rsid, lir->ic, iuparams,
			iunodeid, auparams, aunodeid);

NUL-padding is not required as both `params` and `id` have been memset
to 0:

	memset(params, 0, PARAMS_LEN);
	memset(id, 0, NODEID_LEN);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Note that there's no overread bugs in the current implementation as the
string literal "n/a" has a size much smaller than PARAMS_LEN or
NODEID_LEN. Nonetheless, let's favor strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/s390/cio/chsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 0abd77f4b664..9319f448a6e2 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -393,8 +393,8 @@ static void format_node_data(char *params, char *id, struct node_descriptor *nd)
 	memset(id, 0, NODEID_LEN);
 
 	if (nd->validity != ND_VALIDITY_VALID) {
-		strncpy(params, "n/a", PARAMS_LEN - 1);
-		strncpy(id, "n/a", NODEID_LEN - 1);
+		strscpy(params, "n/a", PARAMS_LEN);
+		strscpy(id, "n/a", NODEID_LEN);
 		return;
 	}
 

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-s390-cio-chsc-c-3bafdc7535b7

Best regards,
--
Justin Stitt <justinstitt@google.com>

