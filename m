Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B078797E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbjHXUl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243570AbjHXUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:41:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9991BF6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:41:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59299db9977so425337b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692909688; x=1693514488;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hz4CFw7X3XsTByuJR93CvFKCbJeqUhmZnpkGK0VJwj4=;
        b=WGl84gWJpZs4+/H8ZXNv8yQkCqJlW6Q4Rd9RfqksEKVmzX3LHumwWfk6tFAhnVwvKM
         /FkVVV+dObPvSP8He0F5KMytfq9ZWu1i9HPU5E1CHIAlewDKBuJ85DmIrEaS49QJaJfW
         dBnwsmw8dj2h7ERu9DZgIgW9ZRs82zESu+KznfxdYuct4V4dq7fWFl5xRFTprOBC+Bzr
         zMbPVexoZYBUi2CgdZ4AhujbrPXbuWvLjDM7XLrUw1K5mIEVbfF6gdS+lwUMJKl/yA0I
         +6mGKqzwXrxSIFMeQfb4BifyswRTncphX1CyfA1wLTBfgcTeA0z3NDfRZDkpUv5hptEq
         C1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909688; x=1693514488;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hz4CFw7X3XsTByuJR93CvFKCbJeqUhmZnpkGK0VJwj4=;
        b=ZRvKcgJ6dTze+I5f1Yxo15fNnWRfZ00NADqehlE3MwAFWEz96HhAhwHAShFvYA8Jxn
         C0BWgoYQFl6J8xFQn+ylJOttYPMGgeplS/2oY3lsBfqAXM0Cyz/cV8PPpG3agAjImpUj
         2zxCgRGzGQJ1wQJK3aYg3DpxJjBI9rCraTuNTaoz3S2wShbq151iUpQPNjYBB8Wntkc+
         Z7J/sejdjtqSVpIEHswz3US47nH0GGjxOhkzA4FdkSnfnOfWaNEsGoml5S87xQfaTVx5
         Cwg4JNFc3dhVNicvkmg4DMHdvwHz0drjv0M7zmy7g7Fuw3TPgh69PmqgQkJFLMZ6lJkk
         GIOA==
X-Gm-Message-State: AOJu0YyFPeQjsFHptNWiGvLn3LYzheximg/99zkNdepUr1mmQ3NdzPcY
        YO3kTl4lOY6CtAUQb+pJJODEkhWk85zZs/4gLw==
X-Google-Smtp-Source: AGHT+IFDfmcb6QRyxXzjJwEVKI5B+o9eDZJHyc49OqYlJuzPac3u6KNBg9jNjwHaz5s9qqEmTbiHVP5TL0fZIEtjdg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ad48:0:b0:584:61df:9b1b with SMTP
 id l8-20020a81ad48000000b0058461df9b1bmr273288ywk.2.1692909688063; Thu, 24
 Aug 2023 13:41:28 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:41:26 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHbA52QC/y2NywrCQAwAf6XkbGD7EBZ/RTxks2kbKGtJtFRK/
 91FvAzMZeYAF1NxuDUHmGzq+ixV2ksDPFOZBDVXhy50fYjdgP6ywusHs+km5kjMsuBMiQotlBw nemf9k3EM6RrbgSX3EWp0NRl1/w3vj/P8AkGmFbKAAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692909687; l=1908;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=HFQNt7NrZ+VUFmpxtwuEPPv30mfdkkfZfzWz5XtYhO8=; b=JWiLA+vWRrMNRFZSBcilB9fmvYoJsOpvmuDtttnNah4xZ6mzum5C+zgvV/Q4etqSvgR6U9Axp
 A3zAcN+pVxbBTsC1E5YhNxXiVy3JeskI9DORDLxYCLXc+O7WHIf0i/C
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
Subject: [PATCH] habanalabs/gaudi: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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
Note: build-tested only
---
 drivers/accel/habanalabs/gaudi/gaudi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index 056e2ef44afb..f175456cdef0 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -660,7 +660,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
+	strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 					CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
@@ -8000,7 +8000,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 		return rc;
 
 	if (!strlen(prop->cpucp_info.card_name))
-		strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
+		strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
 	hdev->card_type = le32_to_cpu(hdev->asic_prop.cpucp_info.card_type);

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-f0b5814ced38

Best regards,
--
Justin Stitt <justinstitt@google.com>

