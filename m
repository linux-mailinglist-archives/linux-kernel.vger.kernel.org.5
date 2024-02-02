Return-Path: <linux-kernel+bounces-49569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF410846CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1DB7B2F754
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D97F474;
	Fri,  2 Feb 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlLhwlnh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A997F46C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865781; cv=none; b=NA9S4osFlW1l6yHvkKImDdytA3BiSQUXwfG3fZteqrS5q0VPVtPPoRnjzUu5FNEsUXBYVgLwlYz8ULB+1ZK4YsbjmLelR+gAPTEdrGmMm3bCe0y5Lc4e0wbc1l/WR4tncqs2S2jP7rjgTTjwaODEoidu+QvnZ+mj9dezY5rIozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865781; c=relaxed/simple;
	bh=dd+eXX+dl1OWEzo7/glw3RkA/h5jaC3FxhfWglqWQKw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=DS/h+CtFTSNyLO3a7JGabQnHIITplGg4YlkI7NOb2BKHp2cttJ+OSgmRtTeYZxL8xFVNZZ2MlPD5LE1zMJOQ7RrZ3Lzv8xkkskm6txBVtGVX9ETIkvATjF3QxyKMBhtp5hLbPkjeGLW6AUrtdprI0w7FKsArYMhcY1jYus/GqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlLhwlnh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041dbb7a78so27870527b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706865779; x=1707470579; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5YNJyMo7T6ZuM5rJpTOCCSH+s00uoF+8fpfMCUPszE=;
        b=QlLhwlnh9hb2TZJz08rXJfQ+XYSL6f+3qqJdy8FSI/ut5npFugRGVm5gEUp9Rf6M/S
         y90rH5mwq8Ux72JtOT0BuNOkq5hR0DRxP5ZRt2jaDA2dyNjEY+iPc2TzpwdH4w8VAFBX
         xBZRe7kmNAdZLPpE1j0STlkg9ab1y52uETdgtAn+Nn2gmYM+8zD4xcGPXxyh9S/O42hL
         wEk3Tt+Di5PnCeoa6bzg8ro4UcDIBTO2e4Dpr5UhIAxnwixmGaNWOCK/v4GlTVDPrHa1
         8iT549M9gmmtYXMdBONlRlUBApPafiJBdWp9jpbrnI5EVqt7KQX/6ciYqp1LECqaIIC0
         sqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865779; x=1707470579;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5YNJyMo7T6ZuM5rJpTOCCSH+s00uoF+8fpfMCUPszE=;
        b=h0BMSJAlYqz9UBX+lFEQfNAPXx2pr5SATwot4EDZD/tyTiSQt9JRU5etx9fQekIxYK
         iocNRwCgf4j8wAqrlCyvCDFFx9/MxSbbrJPc8Ip7vvUSbNTHH9I+mh6EXbZcu3Q4v3MF
         V0wGRHqyYxH7fujc5+Lqga4MCHYAIVMASxCUvnfarmOLMFtEDGf6wwewA0gVHl0Tpo2t
         oGCcjHpKRV1bYvFJa57QSlaWOxapxEv2hSWzISSYArWkUtZ85kBgTFph32RmQeEWCR+K
         ekR30nn+bM39USYF0Z/XPNwHlBFhENnzAYJ/mG1OEdeScaa2Yxy7tr8JV0VfvV/knYI3
         HgCw==
X-Gm-Message-State: AOJu0Yz51nGDbN6XUaA9mRc3CZM9mzQGOP0fg3zK1ipqsCT+yPGD/u9r
	qqcWcU1l57epaPtbM0Owu/NEw0w6OFW/Zkl9Ap+q5wDAaK0vjrRsVwp56RrvooaEi3ZZa1dmXC3
	ZekCztxfwg7l6lw==
X-Google-Smtp-Source: AGHT+IEUswgg/dRMEUK8ShDHmFMeuFJr56NZbrrVmM0GuwsoagVJ8/Goh8qjIinmvSivShznpEP+bOe1TBEexH0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP
 id v5-20020a056902108500b00dc6e5e9f3afmr704904ybu.9.1706865778896; Fri, 02
 Feb 2024 01:22:58 -0800 (PST)
Date: Fri,  2 Feb 2024 01:22:48 -0800
In-Reply-To: <20240202092250.786276-1-saravanak@google.com>
Message-Id: <20240202092250.786276-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202092250.786276-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 2/3] driver core: fw_devlink: Improve detection of
 overlapping cycles
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fw_devlink can detect most overlapping/intersecting cycles. However it was
missing a few corner cases because of an incorrect optimization logic that
tries to avoid repeating cycle detection for devices that are already
marked as part of a cycle.

Here's an example provided by Xu Yang (edited for clarity):

                    usb
                  +-----+
   tcpc           |     |
  +-----+         |  +--|
  |     |----------->|EP|
  |--+  |         |  +--|
  |EP|<-----------|     |
  |--+  |         |  B  |
  |     |         +-----+
  |  A  |            |
  +-----+            |
     ^     +-----+   |
     |     |     |   |
     +-----|  C  |<--+
           |     |
           +-----+
           usb-phy

Node A (tcpc) will be populated as device 1-0050.
Node B (usb) will be populated as device 38100000.usb.
Node C (usb-phy) will be populated as device 381f0040.usb-phy.

The description below uses the notation:
consumer --> supplier
child ==> parent

1. Node C is populated as device C. No cycles detected because cycle
   detection is only run when a fwnode link is converted to a device link.

2. Node B is populated as device B. As we convert B --> C into a device
   link we run cycle detection and find and mark the device link/fwnode
   link cycle:
   C--> A --> B.EP ==> B --> C

3. Node A is populated as device A. As we convert C --> A into a device
   link, we see it's already part of a cycle (from step 2) and don't run
   cycle detection. Thus we miss detecting the cycle:
   A --> B.EP ==> B --> A.EP ==> A

Looking at it another way, A depends on B in one way:
A --> B.EP ==> B

But B depends on A in two ways and we only detect the first:
B --> C --> A
B --> A.EP ==> A

To detect both of these, we remove the incorrect optimization attempt in
step 3 and run cycle detection even if the fwnode link from which the
device link is being created has already been marked as part of a cycle.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Closes: https://lore.kernel.org/lkml/DU2PR04MB8822693748725F85DC0CB86C8C792@DU2PR04MB8822.eurprd04.prod.outlook.com/
Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 52215c4c7209..e3d666461835 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2060,9 +2060,14 @@ static int fw_devlink_create_devlink(struct device *con,
 
 	/*
 	 * SYNC_STATE_ONLY device links don't block probing and supports cycles.
-	 * So cycle detection isn't necessary and shouldn't be done.
+	 * So, one might expect that cycle detection isn't necessary for them.
+	 * However, if the device link was marked as SYNC_STATE_ONLY because
+	 * it's part of a cycle, then we still need to do cycle detection. This
+	 * is because the consumer and supplier might be part of multiple cycles
+	 * and we need to detect all those cycles.
 	 */
-	if (!(flags & DL_FLAG_SYNC_STATE_ONLY)) {
+	if (!device_link_flag_is_sync_state_only(flags) ||
+	    flags & DL_FLAG_CYCLE) {
 		device_links_write_lock();
 		if (__fw_devlink_relax_cycles(con, sup_handle)) {
 			__fwnode_link_cycle(link);
-- 
2.43.0.594.gd9cf4e227d-goog


