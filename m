Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F20776AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjHIVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHIVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:05:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036AC3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:05:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5897d05e878so4037807b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691615129; x=1692219929;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6lWbhl7iPJrKFXOG4ZaXM/5SQTR9KDU65oXklH1K4hU=;
        b=fMCAVDOvA6abfaeXIlx75caOtQLcIc6b9zdTM7IW7E5kXpI/FWnsA7H9NI/dOSnkbV
         Qs3dCOWtDkniTZoDuVrEdC2Be093Ik3r48mYlbsV7Lpm2i9/C4qVS0vNPG7yDDjGanQk
         WYh83aCWB6HTYZ03sbMIbu4YUXQNfyh3h2eU8Gsf1iySdbb8useMreKSxeQawaRzTnHx
         f60YliZPOLSVl5z9bw92AaCinsDthiTbuUljl6s8bFx2sbuYJjPjE2XJLMRtiNOiisNq
         j12LO21YRi2m/SxNfTecTGi5Y3Yt6twRcfjLrmHMxKIhIKxxPtVch659YzJttcW8v36a
         VN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615129; x=1692219929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lWbhl7iPJrKFXOG4ZaXM/5SQTR9KDU65oXklH1K4hU=;
        b=OBa/h1jGokgARs6LhUisENt7J8dsVI+Cz8rh5cxlORdP5BsaJkU65Bl1xkE9pGZ08p
         5y8y27Y3KOnu44sHvbbKEnBqREuIMNXiB1B3SGD0NjHxmkbX/BMgQ2bsVhQRStaK1uUW
         0u5LG/00SSvFsOy/pPHuShdbk4KI9tFRF1q7Og2nyhiqqlg4R1s08O/Ll9RU8hvcaJQ4
         zMHgTnkG7r9+9586jX+w/x05QxYrKeXbHQPFERww7j6SncH82yLSGR073CPL8aznFyLY
         XZcYidBYr1Y9lxlBKsut479u/eQgl2L3cay25At8NlkIcC3R0pS1KuhbHLH88mQdcNfx
         H8tg==
X-Gm-Message-State: AOJu0YwRW2qWc6Nrfu2HULRJqh5mShEo2idGUCE9flg67VnDyxZHznpV
        Bl8q5i7L/5Gu0rp3vJVi9yP2LwpcZ8K/ephDOA==
X-Google-Smtp-Source: AGHT+IFQmgkrI8VuWgIDNLZ7KR+fil6n5jwemxgi5ftyxtUzT4A3cLkr7PSGk7zkzAE0NI22zP0CK8uKN2at/Sddxw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b654:0:b0:589:a974:d7ef with SMTP
 id h20-20020a81b654000000b00589a974d7efmr8012ywk.6.1691615129773; Wed, 09 Aug
 2023 14:05:29 -0700 (PDT)
Date:   Wed, 09 Aug 2023 21:05:17 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIz/02QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNL3eSkHF1DSwMjXXNTY6NEcxPzJHNjQyWg8oKi1LTMCrBR0bG1tQA Yc43mWgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691615128; l=2051;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=4fwVtNGUzPaNWTNSFgWLMCLfJmRtOqh+bfG+cBvU9Fc=; b=1gU3hL/wzLUxNjg0CNumlzju0uyRaxlNZsxZ08WyrI5v/J6HMXXm2wvDibGpMK6pZ8L477ovJ
 1qI9WLjjLnMASiKba2+k6n9m7GYjszkKfxYisHrJgpVROBN/gFLtblp
X-Mailer: b4 0.12.3
Message-ID: <20230809-cbl-1902-v1-1-92def12d1dea@google.com>
Subject: [PATCH] ipmi_si: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Corey Minyard <minyard@acm.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
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

With W=1 we see the following warning:

|  drivers/char/ipmi/ipmi_si_platform.c:272:15: error: \
|       cast to smaller integer type 'enum si_type' from \
|       'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
|    272 |         io.si_type      = (enum si_type) match->data;
|        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~

This is due to the fact that the `si_type` enum members are int-width
and a cast from pointer-width down to int will cause truncation and
possible data loss. Although in this case `si_type` has only a few
enumerated fields and thus there is likely no data loss occurring.
Nonetheless, this patch is necessary to the goal of promoting this
warning out of W=1.

Link: https://github.com/ClangBuiltLinux/linux/issues/1902
Link: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note:
Arnd had mentioned that there perhaps may be some semantic differences
between GCC and Clang regarding this warning or family of warnings. For
now, this patch (and others following) will yield less noisy W=1 builds
and hopefully materialize into this warning getting promoted out of W=1
to an always-on warning.
---
 drivers/char/ipmi/ipmi_si_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 505cc978c97a..0d509d683c0f 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -269,7 +269,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
 	}
 
 	memset(&io, 0, sizeof(io));
-	io.si_type	= (enum si_type) match->data;
+	io.si_type	= (unsigned long) match->data;
 	io.addr_source	= SI_DEVICETREE;
 	io.irq_setup	= ipmi_std_irq_setup;
 

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230809-cbl-1902-7532a747b731

Best regards,
--
Justin Stitt <justinstitt@google.com>

