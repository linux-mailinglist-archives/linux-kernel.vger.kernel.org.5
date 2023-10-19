Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4E7D0564
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbjJSX2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjJSX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:28:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA9115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:28:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so2364617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697758113; x=1698362913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pzUUh8EJbF6T18wc1SOQ/94eLw2vKmJD36Ybe2GN1oU=;
        b=k9hzLcYXK2AM0JwncCKYEHnebdm/027o7DhhaGWPnhvxzbsriF2vtxzKhDGIwEqk5N
         WxK+AasvRXuIq2d//xZZ0o1IOgmxH3hprw6uZfSHOA8ZDpTSYfd8jrw4gWmQVvPq56aq
         TgMEk4r4BB+lEhtcMohcLnFCo4KEGSf8cVo7Hwq77aFbcdZCqsesoLV36LvsvPKu9PUJ
         l2Xn9YMeKfDOaLEnukS5KhMlh4en5fRXkgKKFgV938BFMehmYZJA43sQ4Z1/bkmFnbJ0
         mjQwH8ADF3vej5AsAT4LS0FSubn7+PTZ9i1MWQj1useDgO4tkcf2EzIXErUJsaNzYGPv
         sAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697758113; x=1698362913;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzUUh8EJbF6T18wc1SOQ/94eLw2vKmJD36Ybe2GN1oU=;
        b=fJQuph1NpmqwVh7BvnX+sFBYn1el47Gotd+V1n5JUoDUrr0YfXWy8sQe0ArHsZak/y
         Lo9G5/chFVuxhfRNxGq9gw++ZBu3HqxHNvzPdteNyuHUK8Dp2Jd4PTuq/9wQwuy91PzB
         2PmiMFRxWHEjK05xuwJmGKaUimiyLkr3OBGg2zdujqjdDcvcE95peYnX2nNRuwZIGFR8
         PGenlRVU9p/3uDbl/FUXZxFxAczFHMbsVVyLAjyN32UeUfL20HNJb2/S2Qt3WTshhInw
         71FdniSW7c+nDyKihAdjDINvaT9+coRhlYIPscfniGWoKWqhagttC/ODO8aw4OsA9qSc
         1hIQ==
X-Gm-Message-State: AOJu0YxgnspHJyI5zqk6qaZGX83Ahk69qZMa+YBYBM/JKAYAXIhjM32d
        XIVM6+ts1yNS/HAmIh5znRtkKM2KGoCgYBKPhQ==
X-Google-Smtp-Source: AGHT+IGUI8wpguVW/zcazZa9+odYh4UV2WLd4vOIAq8jFTvfPkj7RADxp7QxZDCwYzqty+9DrmPoNBcIJhxGmfahNA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d5d2:0:b0:5a7:ad04:5118 with SMTP
 id x201-20020a0dd5d2000000b005a7ad045118mr5034ywd.3.1697758113362; Thu, 19
 Oct 2023 16:28:33 -0700 (PDT)
Date:   Thu, 19 Oct 2023 23:28:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ+7MWUC/x2NMQ6DMAwAv4I81xIhqSr4StUhOG7rJVh2hUCIv
 zftcMMtdwc4m7DD1B1gvIrLUpuESwf0zvXFKKU5DP0QQx9G9I9V0h2LycrmqFV/zLI4mmu2FkT Ca7nFFFMKlAlaTI2fsv1H98d5fgFzoZffeAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697758112; l=2436;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=nXaj+SDaGznDFnZbpN5SDDkaKW+YdcVYfsQcoGsWuEE=; b=vitL1pOLBqabYqfimZWktYB8iIQxDYX2yqZoBjW5OLRSdPWvEF4DWjPPpE2pF9Tlbyg8mNfab
 acG5LdOUOGtDrLno91cbVzblWqZJlQLwwp5UbWp5kn3DqT2QZXDRf/P
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-pnp-pnpbios-rsparser-c-v1-1-e47d93b52e3e@google.com>
Subject: [PATCH] PNP: replace deprecated strncpy with memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous
interfaces.

After having precisely calculated the lengths and ensuring we don't
overflow the buffer, this really decays to just a memcpy. Let's not use
a C string api as it makes the intention of the code confusing.

It'd be nice to use strscpy() in this case (as we clearly want
NUL-termination) because it'd clean up the code a bit. However, I don't
quite know enough about what is going on here to justify a drop-in
replacement -- too much bit magic and why (PNP_NAME_LEN - 2)? I'm afraid
using strscpy() may result in copying too many or too few bytes into our
dev->name buffer resulting in different behavior. At least using
memcpy() we can ensure the behavior is exactly the same.

Side note:
NUL-padding is not required because insert_device() calls
pnpbios_parse_data_stream() with a zero-allocated `dev`:
299 |  static int __init insert_device(struct pnp_bios_node *node) {
...
312 |  dev = pnp_alloc_dev(&pnpbios_protocol, node->handle, id);
...
316 |  pnpbios_parse_data_stream(dev, node);

then pnpbios_parse_data_stream() calls pnpbios_parse_compatible_ids().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/pnp/pnpbios/rsparser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 2f31b212b1a5..70af7821d3fa 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -454,8 +454,8 @@ static unsigned char *pnpbios_parse_compatible_ids(unsigned char *p,
 		switch (tag) {
 
 		case LARGE_TAG_ANSISTR:
-			strncpy(dev->name, p + 3,
-				len >= PNP_NAME_LEN ? PNP_NAME_LEN - 2 : len);
+			memcpy(dev->name, p + 3,
+			       len >= PNP_NAME_LEN ? PNP_NAME_LEN - 2 : len);
 			dev->name[len >=
 				  PNP_NAME_LEN ? PNP_NAME_LEN - 1 : len] = '\0';
 			break;

---
base-commit: dab3e01664eaddae965699f1fec776609db0ea9d
change-id: 20231019-strncpy-drivers-pnp-pnpbios-rsparser-c-5d7343441cac

Best regards,
--
Justin Stitt <justinstitt@google.com>

