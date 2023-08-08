Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E3774928
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjHHTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjHHSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BC7C70E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:23:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583f048985bso76765707b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515383; x=1692120183;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZSxNnusQnqM7bOFqjAX37IzOmPldIdsi1KW1Hkrx20=;
        b=gLEuK3W/Hv+DbvezYqwcXKPPzm0v+UaZRRvoEQwSNCZDV3EOZcOnN4vlXwJeDpnvXh
         s8oltOqG0CscYCPYoamYi+tb35p9Y6u2Kr00jR/Qf2uQ3j1JP2+GtuwaKe/dAbnmBXl7
         +67m1XYNQdu+B9KXTR/x4BD8Z0LiSBJe4ICocI4Qzs4dL0f+D2NbGdQJaWq+oaJOGMx5
         K1TvJxWgduvpTtU+Oh4ZopmEZHv9UjDYZQgsK7ODLEa2EPO7WwI9dIdW0Tj0VIWmXFff
         yTUuKcZlKvBCza9ZbLOZH7gHwVtE28WLEiNRraKxFJ3wOzsqt2/11jOCLGsZ+F5t9hA1
         xz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515383; x=1692120183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZSxNnusQnqM7bOFqjAX37IzOmPldIdsi1KW1Hkrx20=;
        b=A28QGjbup1wf/iu/rnXprGoGDsc2MzoeLC09psPN66bt0bXR+EjPGcgkqu1w4ANiYf
         vdN1fIDT932KYcYbolQTUu22NUjR3y+jwCOzcnDzH7329wB+l73GvgsYlwhDUyy+LRty
         D6NGQ2hrhn+kw/Og7zglExgHlKVIjkVLnrMVkChRUvGiwCDKcsZ8RvVVni1lRiMVuvuD
         iak9LZtL2iXGM8fGBwJmjP0L0MV38O1AxSzHJ5a95uU3+wKSpW5kj5mRKONELxLRdNzh
         dA5+HqMpiYx+RYWSWTMBOSidtrgeg8F5m3ReNEotcAxxmGvsg8cXk2ebt3pV5VL37OAJ
         EY0w==
X-Gm-Message-State: AOJu0Yx9MaXJdIhhxuh3I0qirrBiVCLVrDy7/ykYBQnG4aUg/z10ybdD
        YGA5deprIsij76EjWc46aN3HhRcWTsThuFbBWU8=
X-Google-Smtp-Source: AGHT+IGhKIYXbGqQFa3PNzDwZFStQZnz3B4JCOhZKzQz+zmk0c/LSgrF/1imHAfTp1q4woPyqeiNcjqwpLiSdZcROp8=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a81:4114:0:b0:565:9bee:22e0 with SMTP
 id o20-20020a814114000000b005659bee22e0mr4887ywa.0.1691515382897; Tue, 08 Aug
 2023 10:23:02 -0700 (PDT)
Date:   Tue, 08 Aug 2023 10:22:59 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPJ50mQC/3XMQQrCMBCF4auUWRtJUqHFlfeQImkzSQZsR5I2K
 CV3N3bv8n/wvh0SRsIE12aHiJkS8VJDnxqYglk8CrK1QUvdyl72YpsfgdNqNksstLKdlp1Fgxb q5RXR0fvg7kPtQGnl+Dn0rH7rHygroURrL9KNqNyo8OaZ/RPPE88wlFK+RFUcXqkAAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691515379; l=1570;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=dbN32OaDa6wdBfpJqNjWVde/ve993rqcumzB7h2wQwI=; b=R1babvoEEcd3tWtPK5ZsMtf8Mc8xS6lV6vxwZrg5QTVql2nwCMa16rXoANn9viYqoiuKT+/3y
 BOzTAe2GtTnB9GLZpkUnwwSd3r/WXgVvAvyOoYa0yBWCeDGg7+FvhPL
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_hostaudio-v2-1-000b4e5e3c35@google.com>
Subject: [PATCH v2] uml: audio: fix -Wmissing-variable-declarations
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
Closes: https://lore.kernel.org/llvm/202308081050.sZEw4cQ5-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Fix kbuild test report lore link.
- Link to v1: https://lore.kernel.org/r/20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com
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

