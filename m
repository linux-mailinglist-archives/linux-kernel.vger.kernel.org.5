Return-Path: <linux-kernel+bounces-91687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94EB87151F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1739E1C221A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156714AEF9;
	Tue,  5 Mar 2024 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FN/zM/lT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B777BAEF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615111; cv=none; b=Y+Iiv4TEjRg04Nmh26/EnyT91IE/w0DaogEEkaAptgqoGmoqsqsp5L7d/+9l6x818AgSI/icVfOJgHM7kZCNzusa1Lao3h412ZYps75/W2r4K20mdt2x87EejLbADaHdzxnNUqMBPWSlrXAlfH4AqcchLTBrq7L4RTAFPk2g7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615111; c=relaxed/simple;
	bh=KbTlvkqJZdkWz3JMFIvxA09yqx88DYjINdZ8RsQzQSg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jUesXPEObO3NRdV17Oa6kslSBbvYItBADVCKfKyWq132SVJOhhgh5Tdyo1KhaqEcIb6WaEdqS1zUMiXkuRfP7L6vyWKWpS1KyDWJld4caqMXd44Bb4zrVefBN8QzeRUjiy0+Xg/lBPV951/0pUVZyImt0gh2PQO22fb+69n5HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FN/zM/lT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ab197437so82062977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709615109; x=1710219909; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kq0SZT0ux4lTSc+RRyaK9dfv6pgUchfiIyZPjXxEFKk=;
        b=FN/zM/lTOHIj/8BYWIMntUXN7yeq9q9GgULLDzZpoeCxfR3zIrQBSSuYD+TzJgjLoo
         Tn53kMr/vfkLpS5w69T+CVIMnwGezCPIdBlyvAxIpS1UVmkz+n+XEbFU0cpMhv0rRwLX
         nj1WvJBkVqA6B1m9QVJZvB8eIETIf/gaq8d5gVWkqV1anGwvF1esN/2BUzreuE2ELhgP
         jkSgdXXRNZ9YkioI0dZ5y5sqfmu59SF/D0gctyvIxnJRQKTS8u5F0VXgMZDR7OZTM3n7
         qD0o3ng9NrPIu2T0kCcuLz0aLmS/EJgJ0e0fMNQDhdX13cdoDX+T4wSlLhIXXThobt9U
         xkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615109; x=1710219909;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kq0SZT0ux4lTSc+RRyaK9dfv6pgUchfiIyZPjXxEFKk=;
        b=anHIT3PY8jhstrh9euqZ7cOfUDYx5etL5jxMhUo9jczXwT/IAnMes2FJmCtO0CdwYa
         Y67GsB+Y0h+Js0oAVkicHbKDcoWE6tCeeniHVfr+rFDHSh2ZE6r3zY3d4JZV/ih/N3JK
         8xq/TzYh6HUyAKjInu/Eo8E/X5uyhbCTZ2SDSHZ2E1nxC5q/5IQ/iM8h+Q3TgpEGBrPI
         u7jWCv3TbnNHLCCNBg052yio9M9DW3OKDj98H+yl2aO4Vu+RrwxXPO8MuZx0oOte3LEf
         CjeCLZBl/i8berKO0wcTpd1LMSIrN0hQHB0VZf7D8HYoKCtAVFPyJWsT43946sORF3fV
         uRTg==
X-Forwarded-Encrypted: i=1; AJvYcCXzL/e4HLHn9G+ySTdu9qSYlx8QkvM2fXDWbYij4iXrKJjVNDnwVLytO4gF0X2kaC6ZhtbJ6LKlshvlJsd2r/Lg4SJdzQRS2HPbguq6
X-Gm-Message-State: AOJu0Yx50XtOYMUJbYMSL3kR1Lot6elTWhlrl437wbn2FsaY8tqpHzEu
	sxpAq96g+HdsVlrEAD02hWyr9NvcAa6e/eHsM+JvOYw6kXYrvzpkhEMWNU76amqKAmeidPg5AbA
	Bib6+Z7uQoi0Lyg==
X-Google-Smtp-Source: AGHT+IE6/OTFvoDlN5dzzFm/6hXqO2ionBjtS7azhJTBXni5SA73D3v1dU11zMy141HH8FUf/OzA3QpN9CW4JHU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d64:6ee3:55a9:46e6])
 (user=saravanak job=sendgmr) by 2002:a05:690c:a87:b0:608:a8da:1caf with SMTP
 id ci7-20020a05690c0a8700b00608a8da1cafmr3127642ywb.6.1709615108938; Mon, 04
 Mar 2024 21:05:08 -0800 (PST)
Date: Mon,  4 Mar 2024 21:04:55 -0800
In-Reply-To: <20240305050458.1400667-1-saravanak@google.com>
Message-Id: <20240305050458.1400667-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305050458.1400667-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v5 2/3] driver core: Add FWLINK_FLAG_IGNORE to completely
 ignore a fwnode link
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A fwnode link between specific supplier-consumer fwnodes can be added
multiple times for multiple reasons. If that dependency doesn't exist,
deleting the fwnode link once doesn't guarantee that it won't get created
again.

So, add FWLINK_FLAG_IGNORE flag to mark a fwnode link as one that needs to
be completely ignored. Since a fwnode link's flags is an OR of all the
flags passed to all the fwnode_link_add() calls to create that specific
fwnode link, the FWLINK_FLAG_IGNORE flag is preserved and can be used to
mark a fwnode link as on that need to be completely ignored until it is
deleted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/base/core.c    | 9 ++++++++-
 include/linux/fwnode.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index adeff041d472..fac017657d25 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1012,7 +1012,8 @@ static struct fwnode_handle *fwnode_links_check_suppliers(
 		return NULL;
 
 	list_for_each_entry(link, &fwnode->suppliers, c_hook)
-		if (!(link->flags & FWLINK_FLAG_CYCLE))
+		if (!(link->flags &
+		      (FWLINK_FLAG_CYCLE | FWLINK_FLAG_IGNORE)))
 			return link->supplier;
 
 	return NULL;
@@ -1963,6 +1964,9 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	}
 
 	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_IGNORE)
+			continue;
+
 		if (__fw_devlink_relax_cycles(con, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
@@ -2041,6 +2045,9 @@ static int fw_devlink_create_devlink(struct device *con,
 	int ret = 0;
 	u32 flags;
 
+	if (link->flags & FWLINK_FLAG_IGNORE)
+		return 0;
+
 	if (con->fwnode == link->consumer)
 		flags = fw_devlink_get_flags(link->flags);
 	else
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index c964749953e3..21699eee9641 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -53,8 +53,10 @@ struct fwnode_handle {
  * fwnode link flags
  *
  * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ * IGNORE:	Completely ignore this link, even during cycle detection.
  */
 #define FWLINK_FLAG_CYCLE			BIT(0)
+#define FWLINK_FLAG_IGNORE			BIT(1)
 
 struct fwnode_link {
 	struct fwnode_handle *supplier;
-- 
2.44.0.278.ge034bb2e1d-goog


