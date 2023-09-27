Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52CD7AFAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjI0GRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0GRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:17:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465319C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:17:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c2ca3bcf9so200748597b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695795462; x=1696400262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3IdjZrPwiGzFr5iXwebO1sIVd+FSmTVZlXYqn9eNO/o=;
        b=l15XFjKsNujV3q/caKPiU7k3hXqgT7DUJMHPKQj2jKr2lUzdffwxQVTQ8FEkl7bcZ3
         Ed9MTxwTm7CrImaO0BsmYzC0sTv1I/3e/jSWYefNvxA5k3GbtLVVFzV5HO5ytAdfWVW0
         KTbiqW4PRA1fdRMcETNdSvCAfBOWzdPR6F3zzLfOANGGSRdP1jGw4sJ+7x3vvrLM+UV3
         s7DlkqMp+/kYQIds9LxqQNyxOIWZtepvb7GyAtGzs66N8+B+EIPBRpuQCePUDVSBs2SE
         qo3UreaEKAXEzive7cVcQrPzF9p3J5MnJq3sP4yvVn+A1k+TwHhDbLhmyyxOQLulGL1D
         vF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695795462; x=1696400262;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IdjZrPwiGzFr5iXwebO1sIVd+FSmTVZlXYqn9eNO/o=;
        b=OkPNz2foi23xL3XpSxDasZ9l2MmFCIZJnG+hJCb7nL/U3GTmF3GQKJzQnRIMT90Vze
         yxiqqRNrB2DtMujqEAVzodKXIlLP1uK3m+yCVc9M58cEnCKXOyUE/ygUQKJIJRucuYTh
         XI21ETCRlX+n/NPVKaPbi2AHJ3n7OMGqWh7CPi+l+VAOyHw5iTXv2NCZlNc9pvgd+qN2
         SrXjpTHY2hMWmCWZJbjEF3bU3oQ6LsVEQO5o1fm1pf7AuBc/px2tsiD7neBbae85Kaa8
         bHhI7UgRKn8Vr7ssaTnXUnuwJjVcf+AkK09EVGKAB+jWMJNd7z64N87zkJK3Zul/umBG
         Mkgw==
X-Gm-Message-State: AOJu0YwKtoyjBtOX1Glz8f/Pg0gpBiBH5mAMIU5oEdrffo7GoNWsBN32
        1NtWtDHRqgzxtflU1xR56UvKH89t6D1D5sw15A==
X-Google-Smtp-Source: AGHT+IGty3iDdvodLn5N42xewqcb19ygJUVDbIreutpUAwmPkTqUPb52GEZdra96YgUPu0V3Y1/z120PC866kAEL/w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d7:0:b0:d89:b072:d06f with SMTP id
 206-20020a2500d7000000b00d89b072d06fmr11121yba.7.1695795462505; Tue, 26 Sep
 2023 23:17:42 -0700 (PDT)
Date:   Wed, 27 Sep 2023 06:17:34 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP3IE2UC/x2N0QrCQAwEf6Xk2cDdFSr6KyJypFEX6VmSUpTSf
 zcI8zLzsLuRq0Gdzt1Gpisc7xaSDx3Js7aHMsZwKqn06VSO7Is1mb88GlY15wkuvCB6cHthYmH Nw9DXknNNQrE0m97x+b9crvv+A01lss51AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695795461; l=2199;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yf2mZJ5UhZfCEhl12Sbw0YsexAnc1bDuCOjAYvjiTjo=; b=UoLwMaEMOF3kZXOjT/dbWypJzNcwXQhW527o0bYN72xF4yynGwkJKo3oZgu+MURWCOzlkYLxA
 no/nZypsDidCOb7stUoIi4a3RXthyGGFPkxnLaWOT74StfAjtuk0kCX
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-misc-ti-st-st_kim-c-v1-1-29bbdeed1a2c@google.com>
Subject: [PATCH] drivers: misc: ti-st: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both `kim_data->dev_name` and `kim_gdata->dev_name` to be
NUL-terminated.

`kim_data->dev_name` seems to not require NUL-padding.

`kim_gdata` is already zero-allocated and as such does not require
NUL-padding:
|       kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/misc/ti-st/st_kim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index fe682e0553b2..a034b5d8b585 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -590,7 +590,7 @@ static ssize_t store_dev_name(struct device *dev,
 {
 	struct kim_data_s *kim_data = dev_get_drvdata(dev);
 	pr_debug("storing dev name >%s<", buf);
-	strncpy(kim_data->dev_name, buf, count);
+	strscpy(kim_data->dev_name, buf, count);
 	pr_debug("stored dev name >%s<", kim_data->dev_name);
 	return count;
 }
@@ -751,7 +751,8 @@ static int kim_probe(struct platform_device *pdev)
 	}
 
 	/* copying platform data */
-	strncpy(kim_gdata->dev_name, pdata->dev_name, UART_DEV_NAME_LEN);
+	strscpy(kim_gdata->dev_name, pdata->dev_name,
+		sizeof(kim_gdata->dev_name));
 	kim_gdata->flow_cntrl = pdata->flow_cntrl;
 	kim_gdata->baud_rate = pdata->baud_rate;
 	pr_info("sysfs entries created\n");

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-misc-ti-st-st_kim-c-e1663a211a0c

Best regards,
--
Justin Stitt <justinstitt@google.com>

