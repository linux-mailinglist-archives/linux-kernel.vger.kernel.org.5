Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD997CD02B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjJQXBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjJQXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:01:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD7F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b3ae01c0so94881467b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697583681; x=1698188481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zotUshyT9JxTsldtXKWoET48qiWRumjzDVZqgqNWkYo=;
        b=kf/T6LdDv4xfAdWiT02p0AlEjTHl7QjAysREP4ZFS7MQsbUKlzR+gfCov5qN7R9j8Y
         iN9cx/P2T45Elo/1ReAljLM5Ka5QY3WeBdTGujI7Yjrua6ojQl0Yt9O8bH6DSNKFhB7d
         sOrTByJVubhrBVKIhO2GCIBYV6fm3m0n1/8rj3UmKm6wcouMqm1mNk8lwZkpdFEltBgS
         03hMOJCJECMPnV0evvbub713Xm+p0psHseUijIej77Luyuxm+yM8gnHCS7M7cB9ABWzm
         JQ9HEHC55ZXt8Z8/0UEPqdbDS9Sd2TCBWQMTtNA6FeVbmK1Mti2Ebdtn6h7jdOfBOxUa
         +XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583681; x=1698188481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zotUshyT9JxTsldtXKWoET48qiWRumjzDVZqgqNWkYo=;
        b=NVPe9FX/XziiMZ+XYolZ6YZlukUXas/miBRnuGj6Gg8kdsz33sJ6pck3xWMopDFCDg
         MuI8HW3sJOFdV/IFka6Id/dbkvqlHxygB4nEJ5Ov9WrplGfkcb+gQkT2jGsWCaz6HUYd
         UwpI9Tt8sefyFdnpJSMowskPSo5hq+rUjk9XUWdNjrVdjQLG3PLzkiVOvWWpzleQYV7Z
         ll6w7Tl5syQXpQXhG+kV4/yiupxIplxLFuMRkxCFHr3mR+3apRh3iVuaeBL0mN9kYwCL
         oqDVDfDf05/KZeNAbeQ+VHxTIKc5XK1kK9JtltT371Oc4MZTMLrRn6re4IwK94r7Akyd
         hUfg==
X-Gm-Message-State: AOJu0YyfwF1X77n6VK+mdf2/aPcI/8YbuXtNvCHB0FIR4OdYEcsDbVBm
        Ijo5ks8VmwroqXCTyawZM+wbL2J3RFBmapxg5JsW
X-Google-Smtp-Source: AGHT+IG33rPX+YBy/IxDNh0Hn8HuEPXvaiympTSyyMMX5HQVRWBVdttcufnoKeE06bjlWpxR13bX53lvCE4ue3giXDWV
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:cd04:35d6:a586:5c86])
 (user=axelrasmussen job=sendgmr) by 2002:a81:4f92:0:b0:57a:118a:f31 with SMTP
 id d140-20020a814f92000000b0057a118a0f31mr84700ywb.7.1697583681778; Tue, 17
 Oct 2023 16:01:21 -0700 (PDT)
Date:   Tue, 17 Oct 2023 16:01:10 -0700
In-Reply-To: <20231017230110.3170850-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231017230110.3170850-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017230110.3170850-4-axelrasmussen@google.com>
Subject: [PATCH v3 3/3] ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>
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

Also note the corresponding new ioctl flag we can return in response to
a UFFDIO_REGISTER call.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 124 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 6 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 40528001e..a9131515c 100644
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
@@ -886,6 +891,12 @@ does not equal the value that was specified in the
 .I range.len
 field.
 .TP
+.B EEXIST
+One or more pages were already mapped in the given range.
+.TP
+.B EFAULT
+No existing page could be found in the page cache for the given range.
+.TP
 .B EINVAL
 Either
 .I range.start
@@ -900,9 +911,6 @@ An invalid bit was specified in the
 .I mode
 field.
 .TP
-.B EEXIST
-One or more pages were already mapped in the given range.
-.TP
 .B ENOENT
 The faulting process has changed its virtual memory layout simultaneously with
 an outstanding
@@ -912,14 +920,118 @@ operation.
 .B ENOMEM
 Allocating memory needed to setup the page table mappings failed.
 .TP
-.B EFAULT
-No existing page could be found in the page cache for the given range.
-.TP
 .B ESRCH
 The faulting process has exited at the time of a
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
+.I uffdio_poison
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
2.42.0.655.g421f12c284-goog

