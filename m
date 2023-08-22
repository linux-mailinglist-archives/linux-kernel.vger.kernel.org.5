Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01215784CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjHVWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHVWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:05:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA21CEB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:05:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso69554437b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692741931; x=1693346731;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kvfNAmaQkydKuK6ht78gS3RG+WyOgiqVP4AeurXmSVU=;
        b=YurVokxypIFmdNON8ep9uamAlris/X4zsoEuaaroV7EPJxmx+G1qMnvW9BifErZ7Ys
         5zE3J5jTO/J3KR3rPHz72d3FPwqGTPE0sQkhx3B4egJALdUC1L3kw063q/eWrB2MupcE
         sjM7AG3epGtZpNARVuUgXwdsvckKwHy6AY7k8KVvEEPu3kW9sy7Q/nbp/LMc6H8g/w86
         MbN6EMt/k5t8f5/3545gKucIkhtIjTY96at/vrz1VTNsvVM7X0N5SSTLiDkM+bgIZ64T
         DEpk/3B4N6QIgGviUFKaWyy8VFwwZYfNwKIz+1lf2gzDkJDbkpk85UPqquCVPlcqYMgC
         /u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692741931; x=1693346731;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvfNAmaQkydKuK6ht78gS3RG+WyOgiqVP4AeurXmSVU=;
        b=hIuZxEZRZX09v1/ABanUCaubcH4Ue1XJUbOt+DVxVxKlJbfo0OUQPpNORCMzWZm8lk
         2geIZ+UtsZb7SkTbqO0MZbKWj0YSi6JTL7TBQCFFhCvBCDWnCf7VOZ536q48vWVm8YCw
         fpyZITUBOsH3ZpTVDS+PFLePAlpjkek66t03NS4tFiuEfbZrv4Mq1FGUS2CSffO23yaY
         N3HXhTsR7MZYSLb0Gi7qE5GmiAxXtoZ/NT2fvgInlePUYhhAwvsyKJc7rRtCZxnVzo+3
         CGkHitQ+AadVC3aW3ctLNe1ZeT7ijDRLSV+5zcmxhVpOrNrJ1Aeknwj8d20nijV1eWvo
         RumA==
X-Gm-Message-State: AOJu0YyzqitydRhvHhi8hZRXdopMakrpK/scxeVQn9Z3Iql2gGT1AacE
        xqRGaYIFa319CFUnBZlLfhPNGuiFlHt0z4PzZQ==
X-Google-Smtp-Source: AGHT+IE3B57XdbJQeeRxg6tfixLqzX6c6nh6PDYTDTOOozVZuiP29CWKkjiXnDbtOgadRu1V5u5FVV5tcubdZSVRtg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7647:0:b0:586:4eae:b943 with SMTP
 id j7-20020a817647000000b005864eaeb943mr140317ywk.8.1692741931359; Tue, 22
 Aug 2023 15:05:31 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:05:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACkx5WQC/x2N0QrCMAwAf2Xk2UAXmRR/RWTULHNBqSWdozL27
 +t8Ou7lboUsppLh2qxgsmjWT6zSnhrgKcSnoA7VgRydnSfCPFvk9MNgPGHxF3yJRXljSMpY6ED /XfqC0rXifOjGBw9Qc8lk1PJf3e7btgNuSiRLegAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692741930; l=2119;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Y1vCgp5GYs4NsHT5r24HqojZFhU1daRE+/NKAA6CphQ=; b=Hi2h478Ff+VDwMs+vUBVNbhWGLJXHmI+lE2ifNg773E08iMLOxweArHLlRRxelq0JWloX12XL
 tTzo4RTqpLLDlFI7D1ya9b2QD+lAjabmNXKoLbUNeVWHnv22G1AnXl3
X-Mailer: b4 0.12.3
Message-ID: <20230822-strncpy-arch-x86-kernel-apic-x2apic_uv_x-v1-1-91d681d0b3f3@google.com>
Subject: [PATCH] x86/platform/uv: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

In this case, it means we can drop the `...-1` from:
|       strncpy(to, from, len-1);

as well as remove the comment mentioning NUL-termination as `strscpy`
implicitly grants us this behavior.

There should be no functional change as I don't believe the padding from
`strncpy` is needed here. If it turns out that the padding is necessary
we should use `strscpy_pad` as a direct replacement.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5b4b8e..b524dee1cbbb 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -294,8 +294,7 @@ static void __init early_get_apic_socketid_shift(void)
 
 static void __init uv_stringify(int len, char *to, char *from)
 {
-	/* Relies on 'to' being NULL chars so result will be NULL terminated */
-	strncpy(to, from, len-1);
+	strscpy(to, from, len);
 
 	/* Trim trailing spaces */
 	(void)strim(to);
@@ -1013,7 +1012,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 
 	/* One (UV2) mapping */
 	if (index == UV2_MMIOH) {
-		strncpy(id, "MMIOH", sizeof(id));
+		strscpy(id, "MMIOH", sizeof(id));
 		max_io = max_pnode;
 		mapped = 0;
 		goto map_exit;

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-arch-x86-kernel-apic-x2apic_uv_x-e51e08a5fbcd

Best regards,
--
Justin Stitt <justinstitt@google.com>

