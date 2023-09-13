Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CC79DD28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjIMAch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjIMAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:32:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DED1708
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:32:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e7e70fa52so5921863276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694565151; x=1695169951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cQl22gfvlENoqC9ZXlr6AUA6g9l8rOoYr5Ou8EedNjo=;
        b=TOXMPhmVpM30/v3Ym1W6cdGCRVibsfIJLOLJuMfjfT6sEFT//4WtFgtG0UXWa2OCLk
         LsRtjpUG44wbUYYb32scmeJuItVfmjfQ5tKIfYEas9kLtcT6UT9QYUxZJsYj/xR7+PZp
         ELZcwn/CSvBcmo577/p3DQs6bXyZaB5WzETWa9Bt0/C0hQn4s74CTxQol/z8jkew+5t0
         6mCxABgWwFN1QvGhaqa/Sj+N7WheRzwJG0cDjoq1/bG8oWdVRnDOGsxpijrD4P0dJYhV
         EHNogQoppCtbXx1YyfUruvexHA5ML5DUoEVwM9e5RkF2ZLF+VEI9QMpMaZQhqDc9RlG4
         /raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694565151; x=1695169951;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQl22gfvlENoqC9ZXlr6AUA6g9l8rOoYr5Ou8EedNjo=;
        b=W/ahf4XjjwYiklWWWwrw5cWhtxDcblhoxe2pJga0ZfLNne4Y8Lj+Q3Wvk3RD+kVfPA
         hQFTDTpCkrX3CKCA1HybBTyIe63s0EhKQ0OmDMGEYMy5qOvHwrN8xsMoS/VC4Uh0Q+3i
         S+v9hazNHvV34sEfELFHTYnU1Qx3lCMTbYtTxrAeqcHY/gcucXF13XkuH+HqGs74oLL2
         NBKfx9pHBciSd5/ufNkGDfm56291HJaSvnv1Yk7M0UovaIvlmBCHFawvsYi8lkmuKPpF
         9e2g5v4RNPe3YDFiLP2nnYs2p3P1ciO3J1m5RnhLiS7XAFpw4QhW4eHXqvKPB7QWQdnk
         MTvw==
X-Gm-Message-State: AOJu0Ywz+eBGBv+D6lz5qNrmU/3rAricA1wm5I8t7a+3tLUY24dVrxVn
        7AYusBk6a44Pf/tRqDWkpzaTVGOKuYofnecoMw==
X-Google-Smtp-Source: AGHT+IHoVWkYS1QIi63uxbOLxBnLNCBYs5NDQ+6C3gkVkJrVL7u/DLT38IB8YsEgrz4fMCxjhNeLFvbuEF8Pyu7LvA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:f824:0:b0:d07:7001:495b with SMTP
 id u36-20020a25f824000000b00d077001495bmr23740ybd.11.1694565151782; Tue, 12
 Sep 2023 17:32:31 -0700 (PDT)
Date:   Wed, 13 Sep 2023 00:32:31 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB4DAWUC/y2NQQrCMBAAv1L27ELaiqV+RaTE7cYuaBI2MbSU/
 t0gnoa5zOyQWIUTXJsdlIskCb5Ke2qAFuufjDJXh850vRnbHlNWT3HDWaWwJiTdYg5ItsjnjV6 yhvWPabEvJHQXGgcarDOPM9RuVHay/p63+3F8ARydvrWDAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694565150; l=1681;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=bOgFzN8SV0Qi4vEgDu2BIfI1a2yF4o5ibhxUCjl2z5s=; b=WToZdgDM5Ly/+mHpiu1w7j8NAZvAWbO/Dnsor3phmGalGk7ChrcEfY8n208HdrWqz2DC/h2HV
 5U4mxlaEIuxD9LgvsFARKZ9O2ZBhpeaKhEsFEFYxbz+EAERaz0Gnbto
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-crypto-cavium-nitrox-nitrox_hal-c-v1-1-937411a7bc7d@google.com>
Subject: [PATCH] crypto: cavium/nitrox - refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We know `hw.partname` is supposed to be NUL-terminated by its later use with seq_printf:
| nitrox_debugfs.c +25
|      seq_printf(s, "  Part Name: %s\n", ndev->hw.partname);

Let's prefer a more robust and less ambiguous string interface.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/crypto/cavium/nitrox/nitrox_hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_hal.c b/drivers/crypto/cavium/nitrox/nitrox_hal.c
index 13b137410b75..1b5abdb6cc5e 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_hal.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_hal.c
@@ -647,7 +647,7 @@ void nitrox_get_hwinfo(struct nitrox_device *ndev)
 		 ndev->hw.revision_id);
 
 	/* copy partname */
-	strncpy(ndev->hw.partname, name, sizeof(ndev->hw.partname));
+	strscpy(ndev->hw.partname, name, sizeof(ndev->hw.partname));
 }
 
 void enable_pf2vf_mbox_interrupts(struct nitrox_device *ndev)

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-crypto-cavium-nitrox-nitrox_hal-c-f6c97c7af0b4

Best regards,
--
Justin Stitt <justinstitt@google.com>

