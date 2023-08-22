Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B1784D90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHVX7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHVX73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:59:29 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD90E47
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:59:27 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1ca47197311so5722189fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692748766; x=1693353566;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cGRueg2eqYbMCY2ShRbCc3/RucSV6L/B/eSOD25AmaY=;
        b=oE7rm9AjFtO/wJhPR4I/B3C9PzPl0U9GIJtJ8lqhBf1+Myf/+D2iSRfZgrmLr7mR/x
         nMayejh5oe5AWTapQPCLq5jq9CY0Pyc9ctwVerkEBlIECHUhVK4vkKvWYwR27pziznqm
         9W/6Luzdj+ygswvRfmFxADqiAuYOViFaMm49y1CXqPV3sBb/+KuycOsoULepp7onHymj
         YJMqT/JW19FcVl0zqu0VHtUAcLgBtMlKbMHcBgSSsL0o1dCaBKqqRdrNmCLdDIilXVF7
         j8JurhCuRPmIhc+12Fomrtw8IDBZ0+NlB1WaYQiZQ5AwOcourf0LmrvpQCxGkEeWzW/q
         LmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692748766; x=1693353566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGRueg2eqYbMCY2ShRbCc3/RucSV6L/B/eSOD25AmaY=;
        b=HhGRQxK1CPHKASEh/f/3xVo6wja8eXFFGj8cR6rX8kXAPVNuFImZqZHi4jLJeWnvJe
         vzzPLNbEvZk2o+lrXVMjCBnAAM9w+1O7Ianq/KTzXiriSsEgxpgHwhgHZGxv46yIdFOG
         AMihmjYvMkhUI5FFOYVddJslHxPxPDmIwwm5Lj03nrkRq5iHle1Lm/jTaKVQLYqg9WEd
         qnhFDUmmKrUFbmum2OxO5CmFJrrCl9HMOb15k6g9zK1a0faxATEfk6oEw5ti9ECLRNv7
         I9C+b7IWiTdPf8Vs0dVCIJxHLgrc/pFfSsNgD/0wY24B6YXGu4Qu3tLlO89BF3+5TsvM
         ix8w==
X-Gm-Message-State: AOJu0YxeZ1jZEkymq8ILpcvwznsA0/i8Cs3Vr031g/qUMeFinpuoaF1G
        oZ7MrDZHsOftb/iH1YUUS+45Mr789hQKqpboyg==
X-Google-Smtp-Source: AGHT+IEg7NbVScd59jOYBOeVb3GuBkFoZlJ1jMAeIVZP8P7/g2W+bAHAovNBatxzdjVp9Qhlv5I+h6M7X52P9QgtDQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:c796:b0:1bb:91fa:7aab with
 SMTP id dy22-20020a056870c79600b001bb91fa7aabmr174453oab.1.1692748766615;
 Tue, 22 Aug 2023 16:59:26 -0700 (PDT)
Date:   Tue, 22 Aug 2023 23:59:26 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN1L5WQC/x2N0QrCMAxFf2Xk2UCtjIm/Ij60WabBrStJGcrYv
 xt8PHDPPTsYq7DBrdtBeROTtTicTx3QK5Uno4zOEEO8hGuMaE0L1S/meaU31qRNmjuGtIyzFN/ nBYepz0SpDwMn8KuqPMnnn7k/juMHT0R0HHYAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692748765; l=1601;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DvMuu8/lxku646YrnJJTNn2dZrYri5zBU+GthJXHRdo=; b=y9qu1DfwgWfym6uoXSaFbpI+RHlMMNIUgnNRgLwXSTUj4rO+8MpulMdSPc9QurH/sB/n7zscE
 V8PMAm229yiAOd/7pdZGUlXbYKP5Dt7IqsFe36jFT6eAtvHiQDn1fkp
X-Mailer: b4 0.12.3
Message-ID: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
Subject: [PATCH] partitions/ibm: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 block/partitions/ibm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 403756dbd50d..e5893cf71b57 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
 		    !strcmp(temp, "LNX1") ||
 		    !strcmp(temp, "CMS1")) {
 			if (!strcmp(temp, "VOL1")) {
-				strncpy(type, label->vol.vollbl, 4);
-				strncpy(name, label->vol.volid, 6);
+				strscpy(type, label->vol.vollbl, 4);
+				strscpy(name, label->vol.volid, 6);
 			} else {
-				strncpy(type, label->lnx.vollbl, 4);
-				strncpy(name, label->lnx.volid, 6);
+				strscpy(type, label->lnx.vollbl, 4);
+				strscpy(name, label->lnx.volid, 6);
 			}
 			EBCASC(type, 4);
 			EBCASC(name, 6);

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-block-partitions-cmdline-ibm-7f5bcca507ea

Best regards,
--
Justin Stitt <justinstitt@google.com>

