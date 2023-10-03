Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D387B7201
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbjJCTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbjJCTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:46:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9CE8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:46:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so1465157b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362364; x=1696967164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocOKNhdUvGY6/aq7ieB9QOD0OYSMZQy4WsHc5CUE0HE=;
        b=ehJl6aaLJNGOhOrfjjGtgCtiYEfY2LHntsLdKU/FBYgJCiFvaNLYgNbJOOFqVDKxI5
         0tlEFynHceZNL3fSBFgNHZ/kLvifj37uiXSwhIL1YooLzMKPkYDmRSFbfbPOqtYD8Mvs
         Ps87tCr2bZMUZO9Zivitv9PsxX4MH8W3ZctJd3WnSDp3CQH2uBgMmFZ9jZPGD4xAy01M
         CEJUgtwAs2Rehgmozo13+bOtV85KtDo2c6aN5lwTq+DI5TBPGYCmJpjro1XfOD/QuDCJ
         11hqB3Ls9BYhUN9zXKZU0dMLFKJjf0senhpOQGX5id9jawbC/CKbhBUIvihVc6GXfU7d
         jH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362364; x=1696967164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocOKNhdUvGY6/aq7ieB9QOD0OYSMZQy4WsHc5CUE0HE=;
        b=k1Jtj+OwT4XDCxOWj+6k7p8mn7PrsquAw9YUg5+9aJNk1G6ApznTwSYHejHPrEEuOQ
         J5pqp2FGvLI94oREHvbVf+CTWvimLDwZqjGlNGTsoXkIYpkp7gIkcThBv+tKtpKgyZjL
         saEXAqJ6x88VyXLsWbIDiK1YxnL3Ju7sNcR6EguwOsBkJ8rixioksDl6ACZVz9jQD+rQ
         kTI2PwDRAWlB+M2Ht6e4Qfal2YJyKwB1NdZGEHxGdt1Ll7EqGdp+ANeNlleESs2k1QJF
         X81IFqaP6LqPLA12uL8RbF0CdsYO5rCRylPcBerAV9fhSSTrDTbLmDramULT5AE6ndcp
         iVDg==
X-Gm-Message-State: AOJu0Yy2GHHI6MmxxqRoNe69T0Mhm+OpgpPNNYvJKH+YFHlNNbhNqmBg
        E8/HaOBCEHyXKx/vgW3KKXw0Hp9TFPWaho3k4u5x
X-Google-Smtp-Source: AGHT+IGX6pNwu3ESq/UN3DQ8E4VR3aqp5GHkfoy0UspQ/ctrBmmE6u0DHXZ9fEYmIiF/O9MZkGLTajhNajMrNK//v5a7
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:6577:b8c1:dd2d:1c93])
 (user=axelrasmussen job=sendgmr) by 2002:a81:d106:0:b0:595:8166:7be with SMTP
 id w6-20020a81d106000000b00595816607bemr6831ywi.0.1696362364727; Tue, 03 Oct
 2023 12:46:04 -0700 (PDT)
Date:   Tue,  3 Oct 2023 12:45:47 -0700
In-Reply-To: <20231003194547.2237424-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231003194547.2237424-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231003194547.2237424-6-axelrasmussen@google.com>
Subject: [PATCH v2 5/5] ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 95d69f773..6b6980d4a 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -380,6 +380,11 @@ operation is supported.
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
@@ -890,6 +895,113 @@ The faulting process has exited at the time of a
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
2.42.0.609.gbb76f46606-goog

