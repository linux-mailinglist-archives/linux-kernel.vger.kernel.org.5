Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F77BEF03
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378979AbjJIXUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJIXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:19:59 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF9A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:19:58 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1e1391bee82so7508165fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696893598; x=1697498398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zjHQyvadONVOud3v/rE/Az+3J92aB2vK1iZQZ/OYRLE=;
        b=rGgDo/H5T9gZYLPmFpOQGJVZ4k6OAoKrpALI+biAf+tM24a13+h8KfK3Z04ysSZ92P
         lcuIFq/S4RgiZPrxJP7OmlhmlRU3lP3uCwsV0FXtlKSSIHlYV9rW8AeQO3Xm0MbOsnWP
         J3wfoKZSiXvl/Hq9nzVcR+F5zG1k6TXmEy+eIfQ27mzRP0ueLKEl4shn+W5X9EvW4aF4
         rg8v2ZjME3f2/4jTY7OaPnHOV5IXd6IHVti0q8gKE/J+MLPpVjCSoghcTIQ5Ce8UWkSs
         kcWyqBJ5YQeYo7503/Vv8QxoJTQHr48OQFlXT7ZjBY/SFK8w+WEGP8WlqQyDgLV4KPFj
         +H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893598; x=1697498398;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjHQyvadONVOud3v/rE/Az+3J92aB2vK1iZQZ/OYRLE=;
        b=iTU5p2+64ezHcHUad4CY8p95VqegF1RsAfT2kSZaYXNm+YLvzFC9PzosJCtShFZhC6
         fmwOsEJNs94yi0p56CzaP/AS9dRdpr1dmLHhdiGiOsj39hbUZSyD5Ru2SswMjw1Q+qf7
         KP7Pj4D2Ru5V7YIQNMlgqEiAmyzNfwiklKS3bQEVYVGptyL3pihpOrTotrgM4VtQrLtx
         Cshbe0sIJ61W1Nkt/5jKgOH/Tbpqu52RbeOSNHSt2GBtS0Qk1sHNn+VtyMYdcMwVCCI7
         cfr2rt/1nrOy8+GmMJrGrfucTyk8ySC5UbgL+TNGCzhSpLYSbrwQJM2qprYNKAx1hCgj
         zrNg==
X-Gm-Message-State: AOJu0Yy5VbU1HSTmvDDKVTaetOiHegNo+1egnaXCiE1NS7yQtq8VBAII
        x6h7b5I8mPxKtFa08Vg8qpdU8tegKPJsNIVKDg==
X-Google-Smtp-Source: AGHT+IEJoSw0wb7t9m20c6ZpjKDlOmD783PHpu5vdHPvTTgfWAZC5cRf21JJzRLNwBCQUCa+9r2jjqVtgVy/1uiCHQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:3a10:b0:1d5:95fc:2a65 with
 SMTP id du16-20020a0568703a1000b001d595fc2a65mr6733088oab.0.1696893598255;
 Mon, 09 Oct 2023 16:19:58 -0700 (PDT)
Date:   Mon, 09 Oct 2023 23:19:57 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJyKJGUC/x2NQQrCMBBFr1Jm7cCkohCvIi7a9GtnYSwzIVRK7
 27q4sF/m/82cpjC6dZtZKjq+slNwqmjNA/5BdapOfXSn4NIZC+W0/LlybTCnDMKo8ywY+j4Pqh ZEyeGRJFxCBGXK7XDxfDU9R+7P/b9B+1asIF8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696893597; l=1913;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=IQPojGhMm0FWYkhisYrQ00VPkfbCrbcIeRucK9CSAtU=; b=lqQitRgTvDQrS2yNAdU1MwFFmxI/TImPYzq1XkAQrajgWQGjpKNWCOFzZ6AGd8vHFb8Xj4b88
 UcPIIFUP2hSCCsgd+ycewkMTnHNJ1UB2BTMpZXFag89Q1wnWwAwYyer
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-v1-1-712866f16754@google.com>
Subject: [PATCH] ibmvnic: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Dany Madden <danymadden@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not required as the buffer is already memset to 0:
|       memset(adapter->fw_version, 0, 32);

Note that another usage of strscpy exists on the same buffer:
|       strscpy((char *)adapter->fw_version, "N/A", sizeof(adapter->fw_version));

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
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index cdf5251e5679..ac15dcadf4c1 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5247,7 +5247,8 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 	/* copy firmware version string from vpd into adapter */
 	if ((substr + 3 + fw_level_len) <
 	    (adapter->vpd->buff + adapter->vpd->len)) {
-		strncpy((char *)adapter->fw_version, substr + 3, fw_level_len);
+		strscpy(adapter->fw_version, substr + 3,
+			sizeof(adapter->fw_version));
 	} else {
 		dev_info(dev, "FW substr extrapolated VPD buff\n");
 	}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-e0900ba19e56

Best regards,
--
Justin Stitt <justinstitt@google.com>

