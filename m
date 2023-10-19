Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078737D00D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbjJSRpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjJSRpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:45:05 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F0112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:45:02 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-581ead8a0deso3347877eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737502; x=1698342302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qg+otgUOPQR+8G/4uV/TUAnZUyW51Jn+plgzCktzBuA=;
        b=XDrru/ApZi0UXweUD7gr35ntg23Lt6QbrC+gaMYzlj6SB+gYOAjz3t7R5ockw+MHY5
         nAI8oYvVYUrtmsr7HZwamZqKxvQqafGaVIb0TBm9XjC5nGmARMH2nIyJL/D9g1OERy2K
         2qlHmwyJ01x9qs5JsEZlpmr7+T05U7DMFoySaqPshFPCbwRuKld6h/hDhCGLtYHvuafi
         To94gucsbTQwVuDc6Q3VzoDuh92fNEzpiGUAFO3ti0fBGfIA/d+ECCCbs2vGNZXXiNvM
         j9q9D5SlqVSP2b3IJJYv4SNXHZGOgdTOnAXFMwmbZcFIHf7guo/8duT4QwWtp6qXC0GJ
         xZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737502; x=1698342302;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qg+otgUOPQR+8G/4uV/TUAnZUyW51Jn+plgzCktzBuA=;
        b=rbpEoqDwwkTXWEb4NYD2Rhk+a6Hzl21h052RLbKQKgJIzc8MdiD+o58rbPz+rPf5qp
         tJlX8tzf870Mugki22AqwJv3OBGtTRX56SPUqlVsh4GheT9cV8hW6Z59rcC0FerAistC
         P2N6EsdHGQZ7pes+DJL43Cvo0RS+8mgIX9m9DkuQUXxdNiDYAPaDzCNQI+dLUGt6Jm2Q
         BmJIQI4auZSJFchrUO02THTZUP3fFqFXOn2UddSjkgB8JxmOGD3vvBoqBLM/7MR2DPhA
         pVrlyDAt45cwv5x9mvk/c3x3s+kbiQ+9aWPjk82zyKCk/msLeGH1qXUmpO0ZWZJCUjwZ
         0yTA==
X-Gm-Message-State: AOJu0YxKQa2cSdfxgIm8oqE7hdzpAvSAc5TrmQmjKgIhQP8MU09vGJJU
        xqcWlVoFCP6uzWFYCFyWCHBCP9BeOBwl9nHg7g==
X-Google-Smtp-Source: AGHT+IF/1XWODGKQ3tILQKxRsLwEu1ZDsY+BIBDOaGIwchVda0e1YeB9gM+pNN+BK6LJjMlqq0ITrFJ7PPV61+TGJA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:6c15:0:b0:581:f8d7:e4af with SMTP
 id q21-20020a4a6c15000000b00581f8d7e4afmr1090598ooc.0.1697737502309; Thu, 19
 Oct 2023 10:45:02 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:44:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABtrMWUC/6WOQQ6CMBBFr0K6dgytRsSV9zAsoExhktqSadNKC
 He3cgWX7y3++5sIyIRBPKpNMCYK5F0BdaqEnns3IdBYWKhaXWQtGwiRnV5WGJkScgCHETIxWgw
 ByEW0QNlmMgQmwzhMoEGaa2vqerj3CkVZXhgNfY7qqys8U4ie1+NEkj/7Xy9JkDCYW4u6GeXQN s/J+8niWfu36PZ9/wL0GBhH9wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697737501; l=2408;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+j1ZR4eOwaN2eWhtI6Or7popX8JK/RP2CN1CNyJtMuM=; b=BJyGQKERL2LGGUnreMt73sxdVT2rdOk9iwAulRF+/ouCnd05D/W3ZTM6a5zobWDvA04d1pUyB
 RMDmJtVuIm/DdGrXlkpaGZ8jYNcg5qsjcAjsQrDmYemRAMmAxa9iYGi
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
Subject: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
both dump_info->dev_human_readable and dump_info->bus_human_readable are
intended to be NUL-terminated.

Moreover, since this seems to cross the file boundary let's NUL-pad to
ensure no behavior change.

strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
it.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- prefer strscpy_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3ab6a68f1e9f..7aa282592cdc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -880,10 +880,10 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			cpu_to_le32(fwrt->trans->hw_rev_step);
 		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
 		       sizeof(dump_info->fw_human_readable));
-		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
-			sizeof(dump_info->dev_human_readable) - 1);
-		strncpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
-			sizeof(dump_info->bus_human_readable) - 1);
+		strscpy_pad(dump_info->dev_human_readable, fwrt->trans->name,
+			sizeof(dump_info->dev_human_readable));
+		strscpy_pad(dump_info->bus_human_readable, fwrt->dev->bus->name,
+			sizeof(dump_info->bus_human_readable));
 		dump_info->num_of_lmacs = fwrt->smem_cfg.num_lmacs;
 		dump_info->lmac_err_id[0] =
 			cpu_to_le32(fwrt->dump.lmac_err_id[0]);

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-1f49f00b8a2e

Best regards,
--
Justin Stitt <justinstitt@google.com>

