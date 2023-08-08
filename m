Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD26774426
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjHHSPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjHHSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:15:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08D1E4D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:21:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a5cd0ea9so54853807b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515289; x=1692120089;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A52RibxNLEy97VBVqOrueH6EOuxfxLmE/sIUm+aEQ+w=;
        b=uVZmnYoriE+9+Mq+YaugxJfh0MQ3WQB2B4J81xX5KW9BbHnW4WVpsihYMg+oVitArc
         dx2Qw47nhPdh50lsb/VLRbzhiv+TdKPdfWmhCkwr58jLsVwWiQHY0t1zutf3qfLgtZhG
         HhedOLVGzDFThVbo75z1hWiM+TCa5xtkbKT6GNy4MgmqFajMKu/HBRVKDcxoBQd+nwi/
         EgddBBgIs67pmSf8wQB90OD4iDNjLPBS5fFXz3c5Ac+8K3kImH9TwWvqh/lYgMQBzoJY
         Z6BHKA9s8oK/dPuSdLxZsgd0iuYaXfo0rXRGIHewy4wiO+Uv+SFo4jNVwHONPa6U3zC4
         YC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515289; x=1692120089;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A52RibxNLEy97VBVqOrueH6EOuxfxLmE/sIUm+aEQ+w=;
        b=lo4Rr4Uplq+phlcyPOdvMYZg0I0FbLPNRuBVzUNIAfrYRiMXwRd9aUAJBjPpRD3o29
         e1uf+f2muoDFpUvyOa7nGky01DPC9G8tGRfPHJFVvWcYmtcXSydzW2FM40Y4GGMSlUAg
         ZwZDl9sGIQxa7/Gof3ROzeGO3nxOFA2ZqIaXWvVXegnOaxrDvAfhQaddw+5EaZdl32Ov
         m+77KmT8ycSYvflR0+XD07vmOaZ+FABLlmiOceCUXdH9/N5j4Hdbl52fUJJTM82Nwp4f
         +Ge5Y2KOZCH2q+R5ISIJcX++1GWj7UVc4EJRXN52E43uwpxf0jv7rQnQTANmM7XNcZVb
         ICMw==
X-Gm-Message-State: AOJu0Ywkn2G2B+2voNPAyr7BnXw9xiKKoSAOMAzMGjdhyejDKE94PCPA
        mQr3uDbrjoRyVKWbemr5bM9zm0u11q5pp7I/ykg=
X-Google-Smtp-Source: AGHT+IGJqMAAiUXBHcdyYGpY4t2f1wB6tRaSHDofaAQJaQYlmWAQhsPJY+NqguyPoETN/GUldNNfV/ngPqHKxSm1btI=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a81:cb0a:0:b0:560:d237:43dc with SMTP
 id q10-20020a81cb0a000000b00560d23743dcmr5515ywi.3.1691515289533; Tue, 08 Aug
 2023 10:21:29 -0700 (PDT)
Date:   Tue, 08 Aug 2023 10:21:27 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJZ50mQC/x3MQQqAIBBA0avErBPUFkpXiQhpppxFGloRiHdPW
 r7F/wUyJaYMY1cg0cOZY2hQfQerd2EnwdgMWupBWmnFfSw+5svdyFFohUZLg+QIoSVnoo3ffzf NtX53Zd2YXgAAAA==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691515287; l=1420;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=EVNrQJhfphmof8sUAyFcvsNS+eeuJ4/HQslsOrxMtGA=; b=ZF1X+Fz/2ksGP4RCvzO1mQ60oyrQbavwKrExZxs1egjFcWlVZhzv2is/dJNtgP47UleLNYUpW
 mQqLD5mRDVyBSMNL6JDv1NR2+E9ZEW19aD5kwtN+l1Yqfv981OQX4qC
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com>
Subject: [PATCH] uml: audio: fix -Wmissing-variable-declarations
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

  arch/um/drivers/hostaudio_kern.c:316:3: warning: no previous extern
  declaration for non-static variable 'module_data'
  [-Wmissing-variable-declarations]
  } module_data;
    ^
  arch/um/drivers/hostaudio_kern.c:313:1: note: declare 'static' if the
  variable is not intended to be used outside of this translation unit
  struct {
  ^

This symbol is not referenced by more than one translation unit, so give
it static storage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/drivers/hostaudio_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 5b064d360cb7..c42b793bce65 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -310,7 +310,7 @@ static const struct file_operations hostmixer_fops = {
 	.release        = hostmixer_release,
 };
 
-struct {
+static struct {
 	int dev_audio;
 	int dev_mixer;
 } module_data;

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230808-um_hostaudio-21d7207deaed

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

