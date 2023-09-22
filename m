Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0C07AB830
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjIVRvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjIVRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:51:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004591703
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so1917566a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405049; x=1696009849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4NIQNCYJbnDD0lgKwFFor/ygcTIyNapGv2KUfTJ4d4=;
        b=TWzly4HsQ0Q+gICZhHmhyQCFnZJfkTFkDSAyA8VcJxZ89+HzElmdxvFYvMsNHgtbYq
         fzYBTcgi0nOcJhs5PnqQxLLp5vZMUg+S/2stVM7sI4EHL+MmTjs+oUgmtjtg4SYsZHXi
         dD7yDgX8UMrksHWKBXwN2DIe2BbHodAeNeO98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405049; x=1696009849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4NIQNCYJbnDD0lgKwFFor/ygcTIyNapGv2KUfTJ4d4=;
        b=RCZQaQZndnxNfPu6P9RGp6hEn1dZ/Tl/jig9vb009qaORaYToJtM/GsQ+TR6qK0/G7
         MUtuP7uQi2MOQrmNxovR7DKbhDyH1E+JVuR/eg/suCoB0mexj3AX2DLenB5U7/+Yddl+
         l0+C/V72J1ckL+Xh07vsvaudV4VC0tAJ1n9fKdJ/MR7EgnwclN62A33KFnlFp62pRTkP
         DkJXyOA+o+hCmTRknCdJ75W/rAInMDdxiecNRm9DhcJLtb6ZYXecueCC/IOdzYiq3nL7
         MkcMVo2vpkBPXovEH+kakbzTXtDJX/NpwaA5uqQ55fVbJ07CiuXd694QGUFtOeYzckPj
         9PLg==
X-Gm-Message-State: AOJu0YwuXCmgR6v7tVMyj3u2CwNOSXTryjFjzHPE+ARzEFE/8/BBLCM+
        pgn1eQtL9N/aIenEqisM9NT4QQ==
X-Google-Smtp-Source: AGHT+IEJ3CwBJxHBD2S/iRbuv7h3J2P2idJlpvbN/PHvMygWYxAkP3UQVJBARQ54CmTyH8OyoBgDuA==
X-Received: by 2002:a17:90b:3a8d:b0:274:8ef2:b251 with SMTP id om13-20020a17090b3a8d00b002748ef2b251mr422960pjb.3.1695405048769;
        Fri, 22 Sep 2023 10:50:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001bdbe6c86a9sm3776862plb.225.2023.09.22.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: usx2y: Annotate struct snd_usx2y_urb_seq with __counted_by
Date:   Fri, 22 Sep 2023 10:50:47 -0700
Message-Id: <20230922175046.work.766-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HuMddFYgVndPh/PHwPakmOFy8JD6xsoP6JcApWcCcuU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdP3P/EpFy9NJv+1rIpzaY3g8AIW3vya14cPa
 ztrzZA921GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T9wAKCRCJcvTf3G3A
 Ju4hEACjuUA3Cclq1k0WCnCTsZmN3Tm80FjCZ7ifVnctsIbqyFhFbiTbVnjnDmO7JtEkL1cvWTQ
 xHEXi8laitjmNKaBHHfu2ypu1K8iYnShM0cMUgmgbbUfNsOda9o+3zd5I/P46MZ6UxBv61qGB/9
 QF7uh5ORDm717e+wZRNy0W/tiCgFcuYgk7D5zf1PWjxxhPTeEgKnOsvR0Bb6GNg/kJwb8h8Gajd
 Fd3qjAW+hhzATiOhKR6jy49tdtK+UjSKjQ/nWguI4CDUNxxuxPrwFKggQ70hYDq1OBGWxbB0JdV
 8HaDQ3DhV6K9s8ixCvSo7/fk4fgPmgDX/iOQDw1E3Hw2zqZEz/NPYD/krvJjEMW3u0Y67zA5skR
 6VfdwxqbB/JdcJzfHas/Ta7pnmVimqc33zCL3AfXYoaNfG/HEgkOh28LWC3s8Wbacw9xQJRiYZX
 c82DKjSa75L6+UuneQdqQkQNS0AF7e1vXihoM07z3R9OUrhZ6qIjTxcHumTEqidVCpnZ+SMtZMs
 8N5biPzcYek87DYprIaESzg+vozpm/gY3yCTjY97bttJu1+6XyrgRKzd+HzPU7O5NguA6EbVURx
 kJUyBIAAJ8wAnWE0FViQaWfHgUGxfxyWoKd3Cq/NE36UOD+hKW1YsNpaTPyxENYPX3oVB8DvWCl
 MKaM/7M RUQvz/lQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct snd_usx2y_urb_seq.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/usb/usx2y/usbusx2y.h      | 2 +-
 sound/usb/usx2y/usbusx2yaudio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 8d82f5cc2fe1..391fd7b4ed5e 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -18,7 +18,7 @@ struct snd_usx2y_async_seq {
 struct snd_usx2y_urb_seq {
 	int	submitted;
 	int	len;
-	struct urb	*urb[];
+	struct urb	*urb[] __counted_by(len);
 };
 
 #include "usx2yhwdeppcm.h"
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 5197599e7aa6..ca7888495a9f 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -681,6 +681,7 @@ static int usx2y_rate_set(struct usx2ydev *usx2y, int rate)
 			err = -ENOMEM;
 			goto cleanup;
 		}
+		us->len = NOOF_SETRATE_URBS;
 		usbdata = kmalloc_array(NOOF_SETRATE_URBS, sizeof(int),
 					GFP_KERNEL);
 		if (!usbdata) {
@@ -702,7 +703,6 @@ static int usx2y_rate_set(struct usx2ydev *usx2y, int rate)
 		if (err < 0)
 			goto cleanup;
 		us->submitted =	0;
-		us->len =	NOOF_SETRATE_URBS;
 		usx2y->us04 =	us;
 		wait_event_timeout(usx2y->in04_wait_queue, !us->len, HZ);
 		usx2y->us04 =	NULL;
-- 
2.34.1

