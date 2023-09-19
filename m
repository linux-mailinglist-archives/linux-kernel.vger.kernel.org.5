Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1487A6B24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjISTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjISTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197811B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59beb3a8291so75108207b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150153; x=1695754953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eY7SX8EsQtNfNMnrsSEHLyVvDJFOwMWgHyNV+Npddic=;
        b=GpGgJfdziP0T/pNiXVddEP1K/Ux6EdfOFFB79TdlY1L/ZPC2HhgE4xXyrs3h+BMGpX
         R1E5QoGjEV/KNuQWUFzEjJR1zuyGllv2a6b7Np+8gZYBzT61hgjOl6rBGGsmNZhSy7SE
         g5A5iti4sDDv6txnntWC7uYID6S7DhAW5bibedJI3jEgNBE99/yY3S597orD1ltXdsZu
         U3ZGxUFHcHeUhm2VRaP1rUw7dW/vSgPEf2YFJoNFYMjSSikWO4o0uoF2tZyaCis0Wxcx
         TlSYZvQKLO7ucSSfkCrhBS2qfheOcKmTeOdYt8NBTsLGQmo9jM0FVoJJv0Y2azgb11ba
         UJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150153; x=1695754953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eY7SX8EsQtNfNMnrsSEHLyVvDJFOwMWgHyNV+Npddic=;
        b=akFOlgfL3tnQUeN/vhtW8Eq76VI57Ruy/lmC//QIm551woiCZfGu44Ju2l2PqmuExN
         fUziHmYqybrp81SdXrmur7bkAn7ZbW7asj4lUdHSw2/Og5dSDPPMGzByhQx0VAYCGw7i
         n5YF5PnchoNynrrS+ISy/410xi380cklCP4Yab18KbvoC1Do1U6VYSHHb22/ydWs3wiy
         4b61WyoZZOyagp83m1ScOjeU6fGExfeupjJYxx9ZFnMcQwQTx6W7HAKnFnaH1Q1rjnD0
         NaZHOlJhTP1RjXUwpHx9w689abe6IolHClUsUBpK9lCmn9tWhcFI7sDwdPc+9lr/wVQI
         /yvw==
X-Gm-Message-State: AOJu0Yytn+6rnbn4MsH5bX058SKv6dhO2LEXQoRq2XXIkiYYXti5AthA
        SaZSSj/tzZMKcmQvgozJ9bi2yB4QdM5/p1VrK6mZ
X-Google-Smtp-Source: AGHT+IHpPbS96Mx6MQbi9mIPwv0TNNEi8isBoT3vJcnpji3vR4bjpJymIgfnAn4/hr01wOog5Jn9kpIhiLjimfXb/edb
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ae57:0:b0:59b:ee27:bbe9 with
 SMTP id g23-20020a81ae57000000b0059bee27bbe9mr5207ywk.9.1695150153232; Tue,
 19 Sep 2023 12:02:33 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:02:06 -0700
In-Reply-To: <20230919190206.388896-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230919190206.388896-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-11-axelrasmussen@google.com>
Subject: [PATCH 10/10] ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new feature recently added to the kernel. So, document the new
ioctl the same way we do other UFFDIO_* ioctls.

Also note the corresponding new ioctl flag we can return in reponse to a
UFFDIO_REGISTER call.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index afe3caffc..1282f63e1 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -405,6 +405,11 @@ operation is supported.
 The
 .B UFFDIO_CONTINUE
 operation is supported.
+.TP
+.B 1 << _UFFDIO_POISON
+The
+.B UFFDIO_POISON
+operation is supported.
 .PP
 This
 .BR ioctl (2)
@@ -916,6 +921,113 @@ The faulting process has exited at the time of a
 .B UFFDIO_CONTINUE
 operation.
 .\"
+.SS UFFDIO_POISON
+(Since Linux 6.6.)
+Mark an address range as "poisoned".
+Future accesses to these addresses will raise a
+.B SIGBUS
+signal.
+Unlike
+.B MADV_HWPOISON
+this works by installing page table entries,
+rather than "really" poisoning the underlying physical pages.
+This means it only affects this particular address space.
+.PP
+The
+.I argp
+argument is a pointer to a
+.I uffdio_continue
+structure as shown below:
+.PP
+.in +4n
+.EX
+struct uffdio_poison {
+	struct uffdio_range range;
+	                /* Range to install poison PTE markers in */
+	__u64 mode;     /* Flags controlling the behavior of poison */
+	__s64 updated;  /* Number of bytes poisoned, or negated error */
+};
+.EE
+.in
+.PP
+The following value may be bitwise ORed in
+.I mode
+to change the behavior of the
+.B UFFDIO_POISON
+operation:
+.TP
+.B UFFDIO_POISON_MODE_DONTWAKE
+Do not wake up the thread that waits for page-fault resolution.
+.PP
+The
+.I updated
+field is used by the kernel
+to return the number of bytes that were actually poisoned,
+or an error in the same manner as
+.BR UFFDIO_COPY .
+If the value returned in the
+.I updated
+field doesn't match the value that was specified in
+.IR range.len ,
+the operation fails with the error
+.BR EAGAIN .
+The
+.I updated
+field is output-only;
+it is not read by the
+.B UFFDIO_POISON
+operation.
+.PP
+This
+.BR ioctl (2)
+operation returns 0 on success.
+In this case,
+the entire area was poisoned.
+On error, \-1 is returned and
+.I errno
+is set to indicate the error.
+Possible errors include:
+.TP
+.B EAGAIN
+The number of bytes mapped
+(i.e., the value returned in the
+.I updated
+field)
+does not equal the value that was specified in the
+.I range.len
+field.
+.TP
+.B EINVAL
+Either
+.I range.start
+or
+.I range.len
+was not a multiple of the system page size; or
+.I range.len
+was zero; or the range specified was invalid.
+.TP
+.B EINVAL
+An invalid bit was specified in the
+.I mode
+field.
+.TP
+.B EEXIST
+One or more pages were already mapped in the given range.
+.TP
+.B ENOENT
+The faulting process has changed its virtual memory layout simultaneously with
+an outstanding
+.B UFFDIO_POISON
+operation.
+.TP
+.B ENOMEM
+Allocating memory for page table entries failed.
+.TP
+.B ESRCH
+The faulting process has exited at the time of a
+.B UFFDIO_POISON
+operation.
+.\"
 .SH RETURN VALUE
 See descriptions of the individual operations, above.
 .SH ERRORS
-- 
2.42.0.459.ge4e396fd5e-goog

