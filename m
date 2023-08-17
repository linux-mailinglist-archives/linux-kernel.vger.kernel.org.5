Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCDF77FEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbjHQTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354447AbjHQTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:43:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75DA2D61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:43:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc0d39b52cso1369115ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692301396; x=1692906196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Si/xzp3b5Kfu8G0nSEoa+5klikTF3Mu0+jk3qoGOAuY=;
        b=KxeY56i6e9bFm0eDLiKO1bFoDccJOZEBnJkV76FAX6YjulcKBu3jHRv3YQ70b3yGOe
         PQJh1FpNvAgbEriTiPx4ICw9HDbU89czk8Hn2Uy1XwgXBObBtPrStXLnf09A8HsVeOuE
         4EUrxiDykORt1gXd103esmYcKGNmvZD0Mt3TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301396; x=1692906196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Si/xzp3b5Kfu8G0nSEoa+5klikTF3Mu0+jk3qoGOAuY=;
        b=CqzyeV/nOh90bNDNPI2OlV+ok5I2yM5mfTJQ3hCEODG2EjmYhC1jQVk4EcBlSe0887
         aSvXfsAbNycYp9nUO+7JHUqXgnZ8rDo3vYwBxbZs+c2Gjmhbt39T0hvTRhs0dNVk9jhU
         kfdtlgJa2qVjm7UBIcnMXfholOSNWGV5u2xeWcUWSqRzy2jAyz0mX2CFS8UqDrPoFJGM
         50NCe49LVdS9yiLoCYLa8XF2be6mdRGBQdsxmbEgqHBGkJFeO/WMHekHw7CDoSGKQ5gC
         3KxHz5zZAhmnGJ5lDP5EUfLgspAk5uNeHTsv6Yvx1tqX2EKPJV9gF/onF5e9zxAgQWzZ
         EIRA==
X-Gm-Message-State: AOJu0Yy5mU1SsC7T0YxEpkv5T26RvT+fLQmznER3D2C9vMw9606QA4Yw
        qYU3bZ5vxU3xPXGH7+NFMsIQqw==
X-Google-Smtp-Source: AGHT+IF8sqhGihwt+Ap2J98YCk1tsnEznH8Rh7IBJbNautALI9sMLroMhoKNbFg4o8I8ywbZP133Aw==
X-Received: by 2002:a17:903:1103:b0:1b8:17e8:5475 with SMTP id n3-20020a170903110300b001b817e85475mr416559plh.24.1692301396327;
        Thu, 17 Aug 2023 12:43:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902744500b001bdc8a5e96csm137716plt.169.2023.08.17.12.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 12:43:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] seccomp: Add missing kerndoc notations
Date:   Thu, 17 Aug 2023 12:43:05 -0700
Message-Id: <20230817194302.never.378-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869; i=keescook@chromium.org;
 h=from:subject:message-id; bh=DEr99gvD9OSuIqfU7dmInPXq0QE7MMx8F00y6G7s5aQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3nhJaR0a0brdry5b9BAE4I8tunfkNG/oOi85j
 U2lGl5v7E6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN54SQAKCRCJcvTf3G3A
 Jg1bEACjXGJUFlyf3qhxRMCtND2MpTVw8GOlsxq5zdhG1hVcz9OjWnkOiACp6dpW+dWw767cI+X
 7XbbJy0YlR7Fd9Nx3gpWP1mBHEIOqQexioqPYvjEtQW0ruWJ6y4Ih6/v5RFTk8JoixpQArUOJHK
 Yanfa32J2doWlnNsnAFcRq2BwmqzPsH7h4BT54zbr5S1ByjKgD3rHQzXyKcbhYEz0iLELa12mK9
 /uvwfrrAoqWp7+UWQX2mDeZIWDaMeR4SlJV/M+/bjGrkixS+t7620YbugsuMXmR3eE3PP3pP2m4
 B1W9/N3H5v1GOK7cksbUBOI03UJOwSc1rm4B1UfkDn+8wXaZz44wg96CUoFoTVNIr0wS44fe6X9
 2u/N9TkdSmp0C0NVq1imNOX9UYgLPOV1RzqHMPHaOBMfsk6CGVdBEDnmMWSih2eSXSNqbEQfjYh
 OmW1cGqNYF3iZs4x5RVLfsydMaoN6HCH29HoLvzavxoePrJ2V0pg4MTKUMYkdYoiYgoQmFBFc2C
 qaH4ZUDi9gXoCG1CleB7UE37hJVqkAcHTQ9x1lRLSO5W90R01K8fscoMhgAdwFojrnSQhLOvelC
 kNtQj+t8cf/ETIeFpyWN7WOfYFVE9ZvLDRBXria8lnMe3fcB3ffGZZEiuUYpdrJawh4qZq+9TNx
 saQFJl2 uQ+SwWOQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerndoc for some struct member and function arguments were missing.
Add them.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308171742.AncabIG1-lkp@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d3fdc0086168..255999ba9190 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -110,11 +110,13 @@ struct seccomp_knotif {
  * @flags: The flags for the new file descriptor. At the moment, only O_CLOEXEC
  *         is allowed.
  * @ioctl_flags: The flags used for the seccomp_addfd ioctl.
+ * @setfd: whether or not SECCOMP_ADDFD_FLAG_SETFD was set during notify_addfd
  * @ret: The return value of the installing process. It is set to the fd num
  *       upon success (>= 0).
  * @completion: Indicates that the installing process has completed fd
  *              installation, or gone away (either due to successful
  *              reply, or signal)
+ * @list: list_head for chaining seccomp_kaddfd together.
  *
  */
 struct seccomp_kaddfd {
@@ -138,12 +140,12 @@ struct seccomp_kaddfd {
  * structure is fairly large, we store the notification-specific stuff in a
  * separate structure.
  *
- * @request: A semaphore that users of this notification can wait on for
- *           changes. Actual reads and writes are still controlled with
- *           filter->notify_lock.
+ * @requests: A semaphore that users of this notification can wait on for
+ *            changes. Actual reads and writes are still controlled with
+ *            filter->notify_lock.
+ * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
  * @next_id: The id of the next request.
  * @notifications: A list of struct seccomp_knotif elements.
- * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
  */
 
 struct notification {
@@ -558,6 +560,8 @@ static void __seccomp_filter_release(struct seccomp_filter *orig)
  *			    drop its reference count, and notify
  *			    about unused filters
  *
+ * @tsk: task the filter should be released from.
+ *
  * This function should only be called when the task is exiting as
  * it detaches it from its filter tree. As such, READ_ONCE() and
  * barriers are not needed here, as would normally be needed.
@@ -577,6 +581,8 @@ void seccomp_filter_release(struct task_struct *tsk)
 /**
  * seccomp_sync_threads: sets all threads to use current's filter
  *
+ * @flags: SECCOMP_FILTER_FLAG_* flags to set during sync.
+ *
  * Expects sighand and cred_guard_mutex locks to be held, and for
  * seccomp_can_sync_threads() to have returned success already
  * without dropping the locks.
-- 
2.34.1

