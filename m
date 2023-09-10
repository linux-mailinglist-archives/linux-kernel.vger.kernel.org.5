Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B72799EF4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjIJQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIJQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:21:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D91A5;
        Sun, 10 Sep 2023 09:20:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c93638322so777556866b.1;
        Sun, 10 Sep 2023 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694362854; x=1694967654; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ng6BvSWrmtyxNhyAHyI/hbTxjJRF3fVcx0Yq4Iv9jAk=;
        b=pXbMx/MHgkxhssnkjgFAl7w/qlDa/KwmeDdyQ0o2HsEjKj9bPnd+v9c8pXgLysl/j6
         EigvuBKaBf0tdaE3mTtkZYwWlmRqKxBMaaaCWi6gRbwEBfanCKW9PoNtIEHcXAMhJG2+
         VInWaQHgR/Wy1Rq77AA+u6otVHW03v2w3g9rHcmoL3eU0NvW3iaUHWIdPKKhdVPzcrtB
         0BAHfw1isE+i7nlPMb63OnYYCPq3Sz34Cdjd+LBwOVrViTGFXzwqMl82Q7hnCyux5cFw
         stfyMQYTiYn9Bg5J03pKdb6xgCfSxiNEOoPoQ8MbJlCkTUVzEO3sDG36T6h7LMaP7Xyl
         27Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694362854; x=1694967654;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng6BvSWrmtyxNhyAHyI/hbTxjJRF3fVcx0Yq4Iv9jAk=;
        b=ZkofB+ekcPXCcamxQFcHZJ3mRW+45/ve5SSto3tBCnslFpdoSAdhbNK+8hYA88put7
         UMrxUahv99feyZHF5Em2ni/VGnxXq9q+EIhSlDqyzj8xcnIgo4YVkOtXOdgNwdYlJTJC
         ot87UR0Nkb0BNXlExtS9LaHr4767OikHQaZjUxCp8qmKKCPcdpDOycPuxLBcfKjWEGSU
         2p+skeD3MXDOmrMrwm0NUXDqE02w7bY0QI4FKzpQw/MSuVJNC9TDoKOidU7U8bXT5Izp
         l/m5Fln7r4ik5syxXIBrC9X6PGS2azI/veoBTESCarsALJ5yBccXUw8fgzK1KJevpPR1
         36hw==
X-Gm-Message-State: AOJu0YzbhApeylmRmu3bOhhUJqy0tc85LjMRMLGVW5oRiCJp8SKU3N3c
        tM+hG6cmRriLz1uwS0ZAC0Pi/LdDczw=
X-Google-Smtp-Source: AGHT+IGCMRegEDmfhY3X7vWaNn94jbCgTeUUHMHEqqC+CxFGZQy/psWwhSFG2QM46Vm34HmN/IF0+Q==
X-Received: by 2002:a17:907:1c94:b0:982:a022:a540 with SMTP id nb20-20020a1709071c9400b00982a022a540mr17799320ejc.11.1694362854037;
        Sun, 10 Sep 2023 09:20:54 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7d34e000000b0052a1a623267sm3507563edr.62.2023.09.10.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 09:20:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 10 Sep 2023 18:20:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZP3s4yKcWtgCn6zb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-09-10

   # HEAD: 6f7f984fa85b305799076a1bcec941b9377587de perf/x86/uncore: Correct the number of CHAs on EMR

Work around a firmware bug in the uncore PMU driver,
affecting certain Intel systems.

 Thanks,

	Ingo

------------------>
Kan Liang (1):
      perf/x86/uncore: Correct the number of CHAs on EMR


 arch/x86/events/intel/uncore_snbep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4d349986f76a..8250f0f59c2b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6474,8 +6474,18 @@ void spr_uncore_cpu_init(void)
 
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
+		/*
+		 * The value from the discovery table (stored in the type->num_boxes
+		 * of UNCORE_SPR_CHA) is incorrect on some SPR variants because of a
+		 * firmware bug. Using the value from SPR_MSR_UNC_CBO_CONFIG to replace it.
+		 */
 		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
-		type->num_boxes = num_cbo;
+		/*
+		 * The MSR doesn't work on the EMR XCC, but the firmware bug doesn't impact
+		 * the EMR XCC. Don't let the value from the MSR replace the existing value.
+		 */
+		if (num_cbo)
+			type->num_boxes = num_cbo;
 	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
