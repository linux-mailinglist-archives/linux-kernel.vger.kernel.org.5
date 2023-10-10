Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162A17C43FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbjJJW1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjJJW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:27:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D612E4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1811858276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976831; x=1697581631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWOmRc+XZmwUYDYQzA9Y2kZz6fI7UsCc4iSNlP1q3ak=;
        b=ieWeN+dFMNp82LjmdHoBysKpK+iD+J2L4iVFJ6fpNBI0O3lPPbmIyCDBU2zdWorzNm
         jMnqMNwfiIFz6/3zn5BYdTVNRnVSeFc1HIpDRQezXUV+8B+0YFK8/7yVY0iRAUlL/UC0
         0rerP0f+W1Pn7zJ8mV9pbvpc4XmaDYfnLHXdRyCcNDVcAxWArBstYTPvHX1tLdPeSIXv
         jpA5Ifu0pOmLa4WlkNLwwvKQotCxqmRx59B5RnvhEPP5TTl4dKd1DAvprlT4WfzIaxQj
         xRcjCjJNVcpDHoY7W5iSvZ2SNKyYhwJgPmOJv69S8YCXwMCoTb4MhgX3ZMfqAhOkLPyg
         F24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976831; x=1697581631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWOmRc+XZmwUYDYQzA9Y2kZz6fI7UsCc4iSNlP1q3ak=;
        b=kK2YUXwXizMpIJaDAvkpLn+4GAQHGCjHD/fatFnAdC760GzutEOs3yfHd9CQA9OFPX
         GN9MVJRImqlWZZzxc6FdFyPiJ0cj/q+HBDcO6gOYCWehh2q1TChhD64oY8lGhbSshMDx
         sk9joscyzCbuLjC2AsAWGAd7fKUSTATWd/hHcTi4/cZ1apRJVDJ0yWt691YjrMAETZxW
         2J3u8z8Ouwf3T1ZYAEjNEbr94lrobN3xL4a89cxSvjT8KPxysf+hSkCU2NtzhPxW0Zbw
         VMXx6kAfrBAXWCbC1bybF2/WQtxJ+Co1GFKyk2pFZjSdhDypG5+ibp9jHrsycm8FA76M
         13xA==
X-Gm-Message-State: AOJu0YweDY9NUb6FhrwfOjp6ieSnakk6zH7ZNfReNZ24o7GD65JFS0R+
        8lR6+UjhMVS1Hh2ZwY8PYHNpffzQ5hpK991UFw==
X-Google-Smtp-Source: AGHT+IFkc91aNuPbdgNMKkpApTBJBwoJdK74m18bTrvbP5UnyOxaDLY5NiS6TA4MHAZJINXqQEimpa3GEQg6j8fOtQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:b50:0:b0:d80:904d:c211 with SMTP
 id b16-20020a5b0b50000000b00d80904dc211mr300318ybr.7.1696976830823; Tue, 10
 Oct 2023 15:27:10 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:26:57 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=1944;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vWykgd1iTIJF2QxHf+tyASmo5uKe5mdTGzeWp73J3yY=; b=dzlYZaGDxURN55XtwFmYQSEtTx4wp18WY6OhgjXTiLw5YGpZ7hnkSxOnVmHET2lNMcPyKfgGC
 QVaHSfcsAGGCOAoWF6TUtQ+jGaiCMlbEXkYYAyMsry5Pgk0nUS2vgl1
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-4-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 4/7] i40e: use scnprintf over strncpy+strncat
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Moreover, `strncat` shouldn't really be used either as per
fortify-string.h:
 * Do not use this function. While FORTIFY_SOURCE tries to avoid
 * read and write overflows, this is only possible when the sizes
 * of @p and @q are known to the compiler. Prefer building the
 * string with formatting, via scnprintf() or similar.

Instead, use `scnprintf` with "%s%s" format string. This code is now
more readable and robust.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build-tested only.
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 0e72abd178ae..ec25e4be250f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -438,10 +438,9 @@ int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash)
 		char profile_name[sizeof(I40E_DDP_PROFILE_PATH)
 				  + I40E_DDP_PROFILE_NAME_MAX];
 
-		profile_name[sizeof(profile_name) - 1] = 0;
-		strncpy(profile_name, I40E_DDP_PROFILE_PATH,
-			sizeof(profile_name) - 1);
-		strncat(profile_name, flash->data, I40E_DDP_PROFILE_NAME_MAX);
+		scnprintf(profile_name, sizeof(profile_name), "%s%s",
+			  I40E_DDP_PROFILE_PATH, flash->data);
+
 		/* Load DDP recipe. */
 		status = request_firmware(&ddp_config, profile_name,
 					  &netdev->dev);

-- 
2.42.0.609.gbb76f46606-goog

