Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7567CD028
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJQXBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQXBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:01:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3EA4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7aa161b2fso95697437b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697583678; x=1698188478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOKJf+aFkcLqb+vIwiVLl6niteK0lFsixSF6GjMiBCE=;
        b=XbDnJKqYZ7SVFDowWbx/bTwJP8RuE/wzj3iAFiVeoBVOsh0JnRFzaSQfNOZ8jXtDlW
         7r5Lrz/e/5SOIsQltFMS8Cf1LnxGI/yKUnO5WVSmmKKbogzTzDW3M4mfNustcE9WieUz
         Zs1+ApNFlYtQIQaF/nRIcuFHI6EE8zhhcBqYfskyuDllm/A4ShrcW72xxfBxj6KloEON
         Kw7L08SWmzOXt66Mq2uE8eWP0+hB958idEciAfX9AnnJIAQFAqrwKjbSv1wivrQn+fnf
         FDKD0HKty0u82itufiL19h6I/6sOdu75whJS17ENM8HpUUXlZoFfR6zzN7FYCiY0m2Fn
         MsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583678; x=1698188478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOKJf+aFkcLqb+vIwiVLl6niteK0lFsixSF6GjMiBCE=;
        b=rgmPe/enQvZOZQSV6Ghkbqr2dbsLLuPtsJz+UaQKgA1SIcolx299NOdxE1svGFDipR
         8hXdyxI7G9g5AXTJxIhTYNemP3rMprIzok5DYHpsnzsoGMxyt8UjpMhsr7sjckFzuth7
         YKPAzlvF0cic6DNVWExHXkkD9pqK4KmgB2wsuHzi23jv0XtfnQBQFPiXnvy0MPXY8ETN
         HDAodkhbKzxFmyyOMj0RUowJXlgAi+yQWzao8wg71BgJka5tzWkGLuQ3cc5lWUgii5w5
         UcA9z8LBQiRvNJLB9q3hWKyQIYxKTMM7pVBDnv6uKOTwdCWbty7ZjNISI+UGy4/CXF5d
         X9jQ==
X-Gm-Message-State: AOJu0YyvOWqc4MCUfZ3vkAeenjfJ3f45If1K8Ph759E2iaLB5KfGx+ms
        B93k0RU2+55Zfunmj+HpiIbQUqS4pZ3sLAzazQ3A
X-Google-Smtp-Source: AGHT+IGAw1OQNPEiWHUiooH43d5H85P1JTg3yn4uwHQG4ATI0Ap1hSLGIMAXTD6Z8FLwajxXq0T/etVDjId1uCwOy+fP
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:cd04:35d6:a586:5c86])
 (user=axelrasmussen job=sendgmr) by 2002:a0d:d848:0:b0:59b:ec33:ec6d with
 SMTP id a69-20020a0dd848000000b0059bec33ec6dmr90025ywe.5.1697583678192; Tue,
 17 Oct 2023 16:01:18 -0700 (PDT)
Date:   Tue, 17 Oct 2023 16:01:08 -0700
In-Reply-To: <20231017230110.3170850-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20231017230110.3170850-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017230110.3170850-2-axelrasmussen@google.com>
Subject: [PATCH v3 1/3] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old FIXME noted that the zeroing was done to differentiate the two
EINVAL cases. It's possible something like this was true historically,
but in current Linux we zero it in *both* EINVAL cases, so this is at
least no longer true.

After reading the code, I can't determine any clear reason why we zero
it in some cases but not in others. So, some simple advice we can give
userspace is: if an error occurs, treat the contents of the structure as
unspecified. Just re-initialize it before retrying UFFDIO_API again.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index e68085262..82aee667c 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -272,6 +272,14 @@ operation returns 0 on success.
 On error, \-1 is returned and
 .I errno
 is set to indicate the error.
+If an error occurs,
+the kernel may zero the provided
+.I uffdio_api
+structure.
+The caller should treat its contents as unspecified,
+and reinitialize it before re-attempting another
+.B UFFDIO_API
+call.
 Possible errors include:
 .TP
 .B EFAULT
@@ -305,14 +313,6 @@ feature was enabled,
 but the calling process doesn't have the
 .B CAP_SYS_PTRACE
 capability.
-.\" FIXME In the above error case, the returned 'uffdio_api' structure is
-.\" zeroed out. Why is this done? This should be explained in the manual page.
-.\"
-.\" Mike Rapoport:
-.\"     In my understanding the uffdio_api
-.\"     structure is zeroed to allow the caller
-.\"     to distinguish the reasons for -EINVAL.
-.\"
 .SS UFFDIO_REGISTER
 (Since Linux 4.3.)
 Register a memory address range with the userfaultfd object.
-- 
2.42.0.655.g421f12c284-goog

