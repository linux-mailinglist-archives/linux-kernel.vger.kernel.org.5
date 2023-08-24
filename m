Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116C78798C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbjHXUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbjHXUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:45:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B97172D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:45:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6ce0c4489bso285681276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692909908; x=1693514708;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUR68uKdghzn2Y8Ad4w0Ea6gF9hUY3E2tFS5OeMPoWo=;
        b=WUm5i98pTP7NvgunuzXTkokjDZUgTIFrlN4kIp7ozqkz/QPleN+RIiBkhtGzOb9IBn
         XsHVw91mX8ry/g42MRuowOm6eJ6GZrtoVv70me8cLRmwLL00hddEpgBlZPtSp70QPdq1
         Uj0wcbPRCkyZdNX8YiHdkM56E+dPiWmmVuPolOJP+eCIAgwxNTlIF/czwiEGJDOiVEiW
         2gDxnqLq1qLFVrAIseA5XK2HRXeSLhRTM0lE9rhHkiJ9unE4qco+6wHHZaHbF0S4ZYCt
         aGhsVltsPfzxtYzhXr2vUEutUWE/Dq5OrX+qkTicJEbr0+UZE1mPDZn3xfRKpPRZhjN9
         UETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909908; x=1693514708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUR68uKdghzn2Y8Ad4w0Ea6gF9hUY3E2tFS5OeMPoWo=;
        b=bCl6RzN0M2J0l9yV0B0PkHSn4CCypuOZZ6Wf4urgo+iGcWsWhxBiGxa744RUO3cj6c
         xNj6TkpHiWr8pwGairW03UQgqNDYX9H7Kxq5uYSwlfxZYERHDw4wpQcsr+q7+xgTL2fc
         O1EaNBYb439sWQVs/Th+DMXmV7zZ1zSMeZQ9NIXsnow9LPrR3ocv6IAokB8DGmDwsZsW
         do4IQ4SROUqlr/vFGOR9RrxTY3m/UZG11NRC0dpvgRz3oanDt7ZQE4LwZicv1ktll0lT
         mzJJP4+bC8B95qu0KFqpBvXpmHk1nC/ZMA8eTSss9gJjxXB+i65AtnCic038XZ/UcHpN
         0ttA==
X-Gm-Message-State: AOJu0YxqlSYGdXC5IDyHdtCJKYG3XZG3DCRqJP69nffj01HUbeCujPts
        1oOPzSa7+Vu4nAWi+92MD6L4hEAROaBSVJe9mQ==
X-Google-Smtp-Source: AGHT+IGPDaZhtt7yTFPzL+iUB8gPlSwsG7LrnFHzE3lb+AAvs/HuF+e1Dp6UupEf3ne4ULA78L3JabmtBg+sOQn8+g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:2442:0:b0:d11:6816:2d31 with SMTP
 id k63-20020a252442000000b00d1168162d31mr248160ybk.7.1692909908546; Thu, 24
 Aug 2023 13:45:08 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:45:08 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFPB52QC/zWNQQrCQAwAv1JyNrCbChW/Ih6yu2kbKGtJtCilf
 3cRPA1zmdnBxVQcrt0OJpu6PmqTeOogz1wnQS3NgQL14UJn9KfVvH6wmG5ijpyzLDhz4soLJ8e JX0Xpj4wh9eMQhyQSCVp2NRn1/Vve7sfxBU6EPOOCAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692909907; l=2009;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=6YGJBQmqB85nFtFD66zoKdZ4L+GgP4Vbcd+6oeKMetM=; b=+rLrfvbmfKhGQUmnwCP1/TSULbb1D6F2rtJ/GwVNHlqUPNPwNaUZuVzkoksRXIHvf+ECMV3Od
 iAsOhO9SWEsDzwggz1kemkbqpISqUBHTxxpuL/PkaFKeR7WZw8MhNQ5
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-drivers-accel-habanalabs-gaudi2-gaudi2-c-v1-1-1a37b65576b4@google.com>
Subject: [PATCH] habanalabs/gaudi2: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 20c4583f12b0..755b2d92357d 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2431,7 +2431,7 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = CFG_BASE + mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
+	strscpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
 
 	prop->mme_master_slave_mode = 1;
 
@@ -2884,7 +2884,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 	}
 
 	if (!strlen(prop->cpucp_info.card_name))
-		strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
+		strscpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
 
 	/* Overwrite binning masks with the actual binning values from F/W */
 	hdev->dram_binning = prop->cpucp_info.dram_binning_mask;

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-accel-habanalabs-gaudi2-gaudi2-c-0b3f717bee12

Best regards,
--
Justin Stitt <justinstitt@google.com>

