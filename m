Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD07DFAD5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbjKBTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjKBTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3F18C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698952922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gMbvaW7xFMUV0KcreKNTNoj1dffs08hfun7sVblosFo=;
        b=W11wx1jL8w+9uL2q8KDkPBOaGvVbXJdqMML9fEnx9VMdngtHEch9sfd+0X7OoOlG64qbjg
        Anzi67iIkNgrmZeXs9V2KVn/KKR8UIAfaC+BRr9JIBBhcmzjdf8EeZOsQQj7njNEvOqos9
        BwrSLmjnJSpq9pEvEnvTPS+CghgQFDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-zLzjRFtoM5KatsAlfDD-HA-1; Thu, 02 Nov 2023 15:22:00 -0400
X-MC-Unique: zLzjRFtoM5KatsAlfDD-HA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40856440f41so2739945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952919; x=1699557719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMbvaW7xFMUV0KcreKNTNoj1dffs08hfun7sVblosFo=;
        b=EFyx84n5suHhEVsM1QdFSZEGlqvZoW02XFXcH90/AeNRpJXJ0I1/Bi68fD4F3Jg9I/
         XhvRGSARp/xTkaqqX7//naSr/RT+ML5phb7dCsMGukPoLd/6LX3ccHP8tR6mlz2ToXs/
         trvDbrfX8O8FZCeyXbafzk8YJz5tJH9QzeGebwd+iQe9TsQibdZ2smC+YmR0V+S8tJfz
         3X8Unt9xUQl6vE4BtgQdhHjlIOBAVDKqfDJ0MGHDG1p2BmvKBVmNRs+GVdOT1kw8Nrh5
         LVls6dODjd8Wg45sBwuuSjiDmQrdO0Ivu+WeGtgbEJr0JPbWORrskGEaGJh/d+OZJzWk
         V/wg==
X-Gm-Message-State: AOJu0YyhDasT+fBZdeUQ5kIoHhYraq8hrGqHcxHXk+PgqshxwTxA15dL
        iVAc+NXxguQYMqBDU5ZBAHqe29VEXXSW6d4ZLEpebvl/8HBAHTgYBg+Ipo4ppLHYwuDAdYhq+aH
        HPevSEEBg87gwaR82Jl20DznK
X-Received: by 2002:a5d:6b06:0:b0:32f:7648:18b6 with SMTP id v6-20020a5d6b06000000b0032f764818b6mr9906418wrw.6.1698952919689;
        Thu, 02 Nov 2023 12:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3mjA4NEtrXUS/d0Brl+TuRNJcpgXcLj1pTDEgegrB7GTIvz59l85VBE10bZg+13/IBsEvHA==
X-Received: by 2002:a5d:6b06:0:b0:32f:7648:18b6 with SMTP id v6-20020a5d6b06000000b0032f764818b6mr9906408wrw.6.1698952919393;
        Thu, 02 Nov 2023 12:21:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b0032da87e32e2sm119892wrv.4.2023.11.02.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:21:59 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/tty/vt: copy userspace arrays safely
Date:   Thu,  2 Nov 2023 20:21:35 +0100
Message-ID: <20231102192134.53301-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions (v)memdup_user() are utilized to copy userspace arrays.
This is done without overflow checks.

Use the new wrappers memdup_array_user() and vmemdup_array_user() to
copy the arrays more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/tty/vt/consolemap.c | 2 +-
 drivers/tty/vt/keyboard.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index f02d21e2a96e..313cef3322eb 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(*unilist), ct));
+	unilist = vmemdup_array_user(list, ct, sizeof(*unilist));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1fe6107b539b..802ceb0a5e4c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1773,8 +1773,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 
 		if (ct) {
 
-			dia = memdup_user(a->kbdiacr,
-					sizeof(struct kbdiacr) * ct);
+			dia = memdup_array_user(a->kbdiacr,
+						ct, sizeof(struct kbdiacr));
 			if (IS_ERR(dia))
 				return PTR_ERR(dia);
 
@@ -1811,8 +1811,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 			return -EINVAL;
 
 		if (ct) {
-			buf = memdup_user(a->kbdiacruc,
-					  ct * sizeof(struct kbdiacruc));
+			buf = memdup_array_user(a->kbdiacruc,
+						ct, sizeof(struct kbdiacruc));
 			if (IS_ERR(buf))
 				return PTR_ERR(buf);
 		} 
-- 
2.41.0

