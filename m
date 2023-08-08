Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C377448C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjHHSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjHHSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:21:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E218F012
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:31:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so163846276.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515908; x=1692120708;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JK8CUncptgcyNF0cGkjEA8kKWV78TabfUcMXlDPGaN4=;
        b=a6Ag7VXjAsl8cBU4aYzrmGp+LGdAmWWFvill0aLl/BfUEGAMo9Fps6frvQLeqjIuhD
         XlN66q+gi938xPlgkBioE+6G5T8Ol4cL8eHouqLBmXJDKJ4ofNgNbEyzFQgfwJN5wX5h
         FYDm9fsDAdaSMZe+FiluFtG/hjeKkEawL1za/6eCiRJN35Mc4LW12k1s0m1xOYJ896S1
         ajizwbTiIXVwvKayvFjResg+QbJFi5sSjCD3RDXK0Aed9+bvab3RpQkJ1elmdhgv05Su
         a8qNKNMfPEzvEjf8JDTmpmBChnLwWPeqN8Nh96D4P3CNaUchJtCcdF9/W/qDduK8As2c
         UF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515908; x=1692120708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK8CUncptgcyNF0cGkjEA8kKWV78TabfUcMXlDPGaN4=;
        b=Hn7t6NMV3fI/8E76nTjMQhfSes1OpncmXJymwpyJtxb2O15DJhTy7Up1KkB4JIwVcV
         6PkneZYcOb6ad/BWbnxlTPflXJKeyB8P50RTxqsdvNEQ3zMAFHuxukFSVj+XSSSU/eYo
         jYIGwsUnj/nTk+C9qxDB+LZhtbMd88gfydcl+IyUnstdvN99WW2VkMMtMfDr3b67K55F
         XNlhKv9xhS/sYigiHRcUBc2NIVhq+4ureLtO98r8f7Q/f93rTLb2OjBBY05K+RJ8zZ1Y
         RXMy0ULijWWHg5NsLgZwciGYKIDrj/otWx/RAAjpt8uZW9oTWyD2AwA+LLxZLP8d2ODJ
         GDYw==
X-Gm-Message-State: AOJu0YyiTigjgeQiyOsj99nEB7uc6E2OnIfzpZelhbRuiL9u6Jca9Ax+
        zbO6lodW6BTnJNxhH0AguWEVQwRB0D/t69HJeCw=
X-Google-Smtp-Source: AGHT+IFuIZZ9U+HFkMO58uj8HDjeBgI0ZQAsk0P/vzaZPrJxYj2UOeQKD8aOt/SMEl5gPv9zleDrc3PVPpUJ3i0n+p8=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a25:590:0:b0:ceb:324c:ba8e with SMTP
 id 138-20020a250590000000b00ceb324cba8emr7568ybf.4.1691515908064; Tue, 08 Aug
 2023 10:31:48 -0700 (PDT)
Date:   Tue, 08 Aug 2023 10:31:45 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAB80mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwML3dLc+IL8opL47NSiPF2zNMNUc2Nz47TUJFMloJaCotS0zAqwcdG xtbUAp63nSF4AAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691515906; l=1516;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=wd2IgnzJebaakuklw0wfvUJX4iZiu7mdNDFHD+AAxrI=; b=nwemPY1tE0AdQPYAgJzWaeXtnN2spPLRAwSR5RGznOobwW8wki4Ug95D04bQMIQZ3m3VbdjLh
 iHtBufNW+DbALPRP0+Qd07XoJ9pW2Z1jMIj5ZXyXQVKXAMHML1aY8z8
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_port_kern-v1-1-867351f32af9@google.com>
Subject: [PATCH] um: port_kern: fix -Wmissing-variable-declarations
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
bot spotted the following instance:

  arch/um/drivers/port_kern.c:147:14: warning: no previous extern
  declaration for non-static variable 'port_work'
  [-Wmissing-variable-declarations]
  DECLARE_WORK(port_work, port_work_proc);
               ^
  arch/um/drivers/port_kern.c:147:1: note: declare 'static' if the
  variable is not intended to be used outside of this translation unit
  DECLARE_WORK(port_work, port_work_proc);
  ^

This symbol is not referenced by more than one translation unit, so give
it static storage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308081050.sZEw4cQ5-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/drivers/port_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index efa8b7304090..c52b3ff3c092 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -144,7 +144,7 @@ static void port_work_proc(struct work_struct *unused)
 	local_irq_restore(flags);
 }
 
-DECLARE_WORK(port_work, port_work_proc);
+static DECLARE_WORK(port_work, port_work_proc);
 
 static irqreturn_t port_interrupt(int irq, void *data)
 {

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230808-um_port_kern-6f1e7373feb5

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

