Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17C7A9BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIUTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjIUTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:03:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A6880B3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:51:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bfccec7f3so18615337b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318708; x=1695923508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEYxgEiQ2G0lBnnvjz69oKH6w7GyE7puCJV+/rYXSPI=;
        b=k5QCvOgA7I4XAm56OivfNsDesUKGumTK59ZYFdORCk1bSRrEAr825CG2wyJ9u62UbX
         mmPgdzxVX45Ex4gzd/Z6398DgWyZq8nZNHttqw6gFau8CubmHI0zKeWk20GSiqKYM8vP
         t3wsFfqzPrQj4xKTImJg6fFk14fVMrFsn8uT0WzC26wonKiVRreo6rPeoNzKW2L8XfJQ
         D/mTIcp/HbYPF0DTn/J2hyMOp4awbw4HFJgAz0irtXskru6gm/LpkAKOx+/pFxp6Jl4T
         41l/KHH4+kuZb6eq6CqTkZ4FxOyLJkp0lHpbmUg+1tc474TSDwP2g0YHjygBzeY3ISyc
         gvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318708; x=1695923508;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEYxgEiQ2G0lBnnvjz69oKH6w7GyE7puCJV+/rYXSPI=;
        b=kDoUy2t4YnINlRUyUxc8idvIhFLMWwQgPsiPK/JVus6d04TYbczu/8V4x8HIO7qtIp
         ZlHBt9rjB5sgIAEWQHCQPw/dDDEhfqYBbJkjPrtRMdpZpJrAYo3N5Wr6/H5hlrLP8Vif
         t79Zr+/KuxHCvEl5EAIox5oeb/wxMkZWNv4p05vslGzz0JoBz71iMHJhZI0pmiePQ3TM
         naJLeTzqncESbaonjpHlrKBy7pV2FHIcMDur6V+S7MdarfK/RcL7tQ1EJSdRUIUQEktq
         ndHHQV9YoPtIycohpqGDQAiou1T4GGW/PdmEJMYQn/tgEDuqq6609KPkeqScJclbPGLo
         XMJQ==
X-Gm-Message-State: AOJu0Ywxzdbu6YAdMuifr67n0FaUTudIz2ZEStab8m0EzLl96Ei8ghFx
        rNHp5eGEfMHltJi5UxU3dF5V4t1vTNiPz+a1Jw==
X-Google-Smtp-Source: AGHT+IG9JP1J4pBm6vm4/7J90B3qLg30FrVskTwqtCiK09WfK3eRbjMqCD2nEv0oUdEhxfNK7H3bPH2RoaQFQ57HRQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ac1f:0:b0:d78:a78:6fc7 with SMTP
 id w31-20020a25ac1f000000b00d780a786fc7mr62541ybi.6.1695280667831; Thu, 21
 Sep 2023 00:17:47 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:17:47 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABruC2UC/x3NQQrCMBBG4auUWTuQVFuoVxEXaTIx/2YME6lK6
 d0NLr/Nezs1MUij67CTyYaGp3b400CxBH0II3XT6MazW0bP7WUa65eTYRNrDM1QrEETlzeXDM+ xoHLkaV0kzG6SOV6o96pJxuf/ut2P4wcSjWpSewAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695280667; l=2643;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gl6rbcY5JocGZdujGLJVeAlqntg2FcLChTBuwnqHH7U=; b=NicE4L8AAk6eGWezYObrbvJqP3acl0HC36VETSmVRV4fbfv1RZmywz56MTfFRfbzVnUQx8JQ0
 ApR6UamY9EhBv4sAizOSMNlKCNEyUY1P3vMSPVFbgvy6kATdgL3JIiI
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-v1-1-37afcf4964d9@google.com>
Subject: [PATCH] IB/hfi1: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We see that `buf` is expected to be NUL-terminated based on it's use
within a trace event wherein `is_misc_err_name` and `is_various_name`
map to `is_name` through `is_table`:
| TRACE_EVENT(hfi1_interrupt,
| 	    TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_entry,
| 		     int src),
| 	    TP_ARGS(dd, is_entry, src),
| 	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
| 			     __array(char, buf, 64)
| 			     __field(int, src)
| 			     ),
| 	    TP_fast_assign(DD_DEV_ASSIGN(dd);
| 			   is_entry->is_name(__entry->buf, 64,
| 					     src - is_entry->start);
| 			   __entry->src = src;
| 			   ),
| 	    TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
| 		      __entry->src)
| );

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees NUL-termination on the destination buffer
while maintaining the NUL-padding behavior that strncpy provides.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/infiniband/hw/hfi1/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 0814291a0412..7b8e1456284f 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5334,7 +5334,7 @@ static const char * const cce_misc_names[] = {
 static char *is_misc_err_name(char *buf, size_t bsize, unsigned int source)
 {
 	if (source < ARRAY_SIZE(cce_misc_names))
-		strncpy(buf, cce_misc_names[source], bsize);
+		strscpy_pad(buf, cce_misc_names[source], bsize);
 	else
 		snprintf(buf, bsize, "Reserved%u",
 			 source + IS_GENERAL_ERR_START);
@@ -5374,7 +5374,7 @@ static const char * const various_names[] = {
 static char *is_various_name(char *buf, size_t bsize, unsigned int source)
 {
 	if (source < ARRAY_SIZE(various_names))
-		strncpy(buf, various_names[source], bsize);
+		strscpy_pad(buf, various_names[source], bsize);
 	else
 		snprintf(buf, bsize, "Reserved%u", source + IS_VARIOUS_START);
 	return buf;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-5b9ea605e6c4

Best regards,
--
Justin Stitt <justinstitt@google.com>

