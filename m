Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BA77A9DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjIUTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjIUTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:46:00 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C6E8C60F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:06:12 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id ada2fe7eead31-4525d1075afso585277137.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695323164; x=1695927964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEI/FE0LzaOE8LB3j/EPmAsW/lNDHZXMlP+MK6JtiH0=;
        b=T4G0kmwnn9rWTNvn8r2laozFkLhliepsTuDpdqRkt90vr/1TMPlBX/6MxSlikmVAe2
         JfgOzgVxmSVc6mA1Z7tJbtRalOhTIqNHPCM+iinXGRHISUhM/bKzd0WGfu08R2un+ai6
         eAKklVIGPMDKR80CaPO2PufRmHuUYkE8/EOoFXu2ZtP7Ek0CYhqVLVWJDTg33OlTrx3o
         7+aodDsuyhyloG0HA2KoegLM1WkynRQJBjkWTpS+PZxjEqAn4aSBA2xAGIm7J5D8f5Bi
         n5Fxe2muC9GDfqR1ZP44CQkV0XMciatLz2eGnQxyrDlyJDF6G+sk/MMF38UHmitxGHNl
         YN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323164; x=1695927964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEI/FE0LzaOE8LB3j/EPmAsW/lNDHZXMlP+MK6JtiH0=;
        b=a1kWlucIVzqeMnUa7rxu0jT+nOP4jeE0qlDAg3KUVI4v/9DoYCCphzrYW7exG7w5KM
         ppaRf30S6MJjPUQhLSRVeA48dLd7isYVaNcpjJBLjg1I3lHPQEb11wG7ndhez6gLEHiD
         NtCHdFa/Tefx+kkfBsRAbdldhnMe4rNIqfu9QRvw8PSidlj2MZkB1zUMcYm6jfoMkLUU
         PhbtwYddtPexTjGn0boWTR6P7SN+rj36FyTh4LfR4xWXcs3dAoZ4XxS2ATthnXMQEGaJ
         XHMdF8tQohsxg1a9kcAh6nKeQrDx1ACRNLArr+UW/G2z+Wv5jn9z705zZXK3vJEOar9H
         kx8Q==
X-Gm-Message-State: AOJu0Yya5CdmnGutYZ+mH8JAkgBZd6sOuVa7ZW6HZcordKaSUmq0elAe
        mh1jPndhfRW+KwURzKDq0XxFbSrabSjpBzwARg==
X-Google-Smtp-Source: AGHT+IEYzveRK4DpKaBvTcozNvLOzlrpzzHF+TShyi7tBIAI7apmqP3Y8DUHUTwq86i/Sw1IZExa+IRloVCK7eDaOg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:848e:0:b0:d82:9342:8627 with SMTP
 id v14-20020a25848e000000b00d8293428627mr63851ybk.6.1695268265522; Wed, 20
 Sep 2023 20:51:05 -0700 (PDT)
Date:   Thu, 21 Sep 2023 03:51:04 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKe9C2UC/x3MwQqDMAwA0F+RnA3Yyg7dr4iHkGYzB7uSFNkQ/
 33F47u8E1xMxeE5nGByqOundIRxAN6ovAU1d0Oc4jylGNCbFa4/zKaHmKPOjDt5E0PGnCQ8IqV ATNCLavLS790v63X9AcxwdSxuAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695268264; l=2236;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xRRL8ZZagoPuEYpnmLvMHfqr3+/4b42z9ovF8TORhlE=; b=pVohjE+m58JPvLT2c72pPRI1bHXV2c7QOlM9qXaA2xrrnFGjQsCWYX+d7O882U2GpU1hdFZVW
 yLLUEfbE8+rDkX3sbp6f/QeKPamXfHchETunk7iwfC0o7f3mbtu7FJs
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
Subject: [PATCH] i3c: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

We expect adap->name to be NUL-terminated based on i2c_adapter name use:
| dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);

NUL-padding does not seem to be required as `master` is zero-allocated
and `i3c_master_to_i2c_adapter` simply returns a field from within
`master`:
|       master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
...
|      	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
...
|       static struct i2c_adapter *
|       i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
|       {
|       	return &master->i2c;
|       }

This means that `adap->name` should already be filled with NUL-bytes.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 87283e4a4607..8573ca507708 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2309,7 +2309,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	adap->dev.parent = master->dev.parent;
 	adap->owner = master->dev.parent->driver->owner;
 	adap->algo = &i3c_master_i2c_algo;
-	strncpy(adap->name, dev_name(master->dev.parent), sizeof(adap->name));
+	strscpy(adap->name, dev_name(master->dev.parent), sizeof(adap->name));
 
 	/* FIXME: Should we allow i3c masters to override these values? */
 	adap->timeout = 1000;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-i3c-master-c-d9e152a91aca

Best regards,
--
Justin Stitt <justinstitt@google.com>

