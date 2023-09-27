Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D67AFA33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjI0FmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjI0Fle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:41:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0794ED4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:43:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so16261170276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695789789; x=1696394589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iePGiIkzKfdzMIOYNHOPRk3cHv3ow4quHNbS62CX7cc=;
        b=f+BgNC9iLIinJJtX9RsOwyapX+ljtdbJ6aXe875+wmA+mhGZZpFyW8IXkfcCq6foEF
         hBi7GYcengpzpVU04f0ddt/A61YSoN7ayzrL/TX/G+iZI3LQxtupxuhxOsNq/vzo/IBG
         +5BlZGaWVRWaMF8jGmSYi5/SolazV3zHGXhXvZnd4wJdhEYzEfJWPIrhu6QKAdnQ77kH
         CUHUwARmC3VHOdvK9gHu/+jSB+JjPSWuI8joKEmt5Pbc+OX0EzepzllCI+GLmQHKwaC7
         59TGzErtfZxD5ng8c+EX14dgtvH4qOil1hccALcQXOC3i5DG30McDOyzlP30HKIQgV2b
         CXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695789789; x=1696394589;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iePGiIkzKfdzMIOYNHOPRk3cHv3ow4quHNbS62CX7cc=;
        b=vgVAbO7mH4nBR5dKRc8eTIYWTOqIRWpaxT9wpkzL+Yx0M4K0DEnY7jWplTXQzBAJvv
         4OXFlKd2W+UJkTenw6Mocl7TNlaI+3RJhLXWKaURkjgb6A40+vPr5wzfoG/aTfRk9fjh
         WbNeds+05b0n2bF55DgPew7vMI4ZgxnwMlNK4wGxlqauwxOuAnJx3qkZQZgkpoXGqbLL
         qJ8EQYa9bFVFLxfSCEN9CBsOQwzN1ek4P1r/TeZJaE9R8T0xhHaybpWocZ88PT1VfNgs
         pWS82lOtpTjZYYXRbaaeAZ/kR85J/055oyyXuKmXhR8XDowejBfGL1AuOODZc3crPVzG
         HnCQ==
X-Gm-Message-State: AOJu0YxlsBvKurpG4wz7b1J0Z9wgKZ81YYYIjlgOqaBaNWHMNyGjcoM4
        pwcAG3SkMSCOSzhv8EdIivnYR1uQSecKEgy/gw==
X-Google-Smtp-Source: AGHT+IFd0ooW1etTxxJiTNoTbFujxXZt/InXzvbY0UsHwCdSv0uv0h4zfagMpHW3ZgyyIZZQBDRZadcuoO6RPk4m5Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:503:b0:d7b:8acc:beb8 with
 SMTP id x3-20020a056902050300b00d7b8accbeb8mr10054ybs.2.1695789789581; Tue,
 26 Sep 2023 21:43:09 -0700 (PDT)
Date:   Wed, 27 Sep 2023 04:43:08 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANuyE2UC/x2NSw7CMAwFr1J5jaVgQHyuglhEiQNeNER+pQJVv
 TuB5Uhv3iwEdVPQZVjIdTbYs3bYbgZKj1jvypY7kwTZhbMcGZPX1D6c3WZ18KhA7LPy+qk8tgk RnLiI5EPch5OoUH9rrsXe/9L1tq5fn35o8HkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695789788; l=3357;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=EG1YpGCKOg76/PpeoMN8n1JVEehvPAP4ohoFDY4oUi4=; b=qhrzWo9sVm0VaNN5eB2F4JA68rayk7qenKcrcBKhCIwLhJbjdk7cI5E1kw0NBzW7Fn/9c+Wsc
 TDomOeaRGTJDjyyt3Nq2pOIikjhgZO5jnJrgq1M8e+SRVRIwLmBzEVc
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-message-fusion-mptsas-c-v1-1-edac65cd7010@google.com>
Subject: [PATCH] scsi: message: fusion: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

The only caller of mptsas_exp_repmanufacture_info() is
mptsas_probe_one_phy() which can allocate rphy in either
sas_end_device_alloc() or sas_expander_alloc(). Both of which
zero-allocate:
|       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
... this is supplied to mptsas_exp_repmanufacture_info() as edev meaning
that no future NUL-padding of edev members is needed.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Note that while `strscpy(dest, src, sizeof(dest))` is more idiomatic
strscpy usage, we should keep `SAS_EXPANDER...LEN` for length arguments
since changing these to sizeof would mean we are getting buffers one
character larger than expected due to the declaration for these members:
|       char   vendor_id[SAS_EXPANDER_VENDOR_ID_LEN+1];
|       char   product_id[SAS_EXPANDER_PRODUCT_ID_LEN+1];
|       char   product_rev[SAS_EXPANDER_PRODUCT_REV_LEN+1];
|       char   component_vendor_id[SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN+1];
... and simply removing the "+1" in conjunction with using sizeof() may
not work as other code may rely on this adjusted buffer length for
sas_expander_device members.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Note: similar to drivers/scsi/mpi3mr/mpi3mr_transport.c +212 which uses
strscpy
---
 drivers/message/fusion/mptsas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 86f16f3ea478..1dc225701a50 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -2964,15 +2964,15 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
 			goto out_free;
 
 		manufacture_reply = data_out + sizeof(struct rep_manu_request);
-		strncpy(edev->vendor_id, manufacture_reply->vendor_id,
+		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
 			SAS_EXPANDER_VENDOR_ID_LEN);
-		strncpy(edev->product_id, manufacture_reply->product_id,
+		strscpy(edev->product_id, manufacture_reply->product_id,
 			SAS_EXPANDER_PRODUCT_ID_LEN);
-		strncpy(edev->product_rev, manufacture_reply->product_rev,
+		strscpy(edev->product_rev, manufacture_reply->product_rev,
 			SAS_EXPANDER_PRODUCT_REV_LEN);
 		edev->level = manufacture_reply->sas_format;
 		if (manufacture_reply->sas_format) {
-			strncpy(edev->component_vendor_id,
+			strscpy(edev->component_vendor_id,
 				manufacture_reply->component_vendor_id,
 				SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN);
 			tmp = (u8 *)&manufacture_reply->component_id;

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-message-fusion-mptsas-c-f22d5a4082e2

Best regards,
--
Justin Stitt <justinstitt@google.com>

