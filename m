Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931C784CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjHVWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHVWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:13:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF8CCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:13:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbc0e0c6dso44687737b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692742421; x=1693347221;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmjVsGgx6gF9dMVPPrLxg3tMP8b+7Z4gdwQXJbdCgco=;
        b=DbMG4atXV04JeA1MlW5YM7QZEFAcLCcbYhd+q3Kl//ACedYN6oe2Fx+a1RIfufErAe
         IUT8kbXSuCyjKsT+9snF4ikwgpUqx2C3e1qBKhpjaxZT29AQtuiebZ8iO4u4JC3liD2m
         uLC1kp1LK3j/isA8qa9Gewhx+4tUKRnl6Lt9OpGByfDmV6a6BIHcaKs0ak7GKTX0i1Y7
         FbM5FFz+vYdX+/HuObwWg/7qp78bXOBrLj6WF8ZgahP8ptM0e/Pk62Cu4buPraagFZg2
         emQBRuKBHul46vWmNQ8OEzn5LBZYC0ygn7NREdyHR3KsACHhId+oxosa0yg2OkI8C89D
         0T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692742421; x=1693347221;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmjVsGgx6gF9dMVPPrLxg3tMP8b+7Z4gdwQXJbdCgco=;
        b=NEyVLWRpCm0gxnWsycLVNFwsL0Ph63qjoxD7vjBn8x2e0WbZHIHadkPHho4V4vi5fU
         hFQItMo9x9d5mR+xP/6wkspKIGy/A3IlMH8SSk7ozMuuFKrXuw88QML2Twc0u2HRh0CH
         opw/m446oxfSC//hx9pEjTCC4Ipn47OCv9rabxLSN130DzQZC4qTqP+0FyTwiaGFTHXC
         uI1n+lf4eMR0GnFJr+Eaq0sUBeJBfzZ5UIdx0wdASTlN4eVltND7cprZ/z7lhzJgCnCn
         w49sb4qNbe2xSQPICGISYvSJaxwSBQOkYPflfPzz8rWEF25OSvNle+hr2WivNyl7SyPl
         SaoA==
X-Gm-Message-State: AOJu0YxFf69Vv5baI2kp8iSbClIm0XtMgregojLVsJl9EfU63f0iNkZ8
        H162oKSORgc5iKtEBC83Mfje5rT/W7ibzbN/hw==
X-Google-Smtp-Source: AGHT+IGE6GoIEbEH7DYVNW4HTiMGU+iCqd+cjZZkK4wdjIzwI/89TsZlV9fO7SSVysshSkpTnvseKNXgG3iQx/dYOg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:118a:b0:d05:7ba4:67f9 with
 SMTP id m10-20020a056902118a00b00d057ba467f9mr138492ybu.3.1692742421250; Tue,
 22 Aug 2023 15:13:41 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:13:36 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA8z5WQC/x3MQQ6CMBAF0KuQWTsJVsTqVQgLaD90oqnNlBAM4
 e40Lt/m7ZShgkyvaifFKlm+seB6qciFIc5g8cVkanOrrTGcF40u/XhQF3izLb+hER8OCQs3/v5 wo7cYny2VIikm2f591x/HCVo5fvNuAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692742420; l=1686;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=W25RC9CnsMsDX2n9Nx4KPoyzwG23ZFjcDXue4o9Kb6w=; b=0QcIzSUF693AP4G0xx/Dhih8ldcUVnRy4oxKaohCBvY6PwUjw/rulIO1ilg7PD2+HIcoaGr1K
 X/gNQPei+BEBto244jiaJPh20B53KKtAHiByBBLgF0+NLT49VGP8dyQ
X-Mailer: b4 0.12.3
Message-ID: <20230822-strncpy-arch-x86-kernel-hpet-v1-1-2c7d3be86f4a@google.com>
Subject: [PATCH] x86/hpet: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

In this case, it is a simple swap from `strncpy` to `strscpy`. There is
one slight difference, though. If NUL-padding is a functional
requirement here we should opt for `strscpy_pad`. It seems like this
shouldn't be needed as I see no obvious signs of any padding being
required.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 arch/x86/kernel/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c8eb1ac5125a..1648aa0204d9 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -421,7 +421,7 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 	 * the IO_APIC has been initialized.
 	 */
 	hc->cpu = boot_cpu_data.cpu_index;
-	strncpy(hc->name, "hpet", sizeof(hc->name));
+	strscpy(hc->name, "hpet", sizeof(hc->name));
 	hpet_init_clockevent(hc, 50);
 
 	hc->evt.tick_resume	= hpet_clkevt_legacy_resume;

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-arch-x86-kernel-hpet-4d57cbd8eb96

Best regards,
--
Justin Stitt <justinstitt@google.com>

