Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF47EECD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjKQHlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjKQHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:41:06 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394CD4E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:41:03 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3130ba31so19586005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700206863; x=1700811663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrcXzmodF6bK/8UfI2UeOK6vegFHaOecvZu9oGApnk=;
        b=L4ktQxO2I5Q+ev3TR8G/c3+67fsX+n+PIxmQyRsFktIQEFoZiNFcZs5HzgE3vr+GEr
         guH8madizda4cm8L6LdD8H8BiOvH3mhOD8lk49zsvLkVzK9balLa6arIuPJGGEDjUTHC
         miZn6Xq5CjxgcrjjZdyxak6ZkqDgEP51ZjK1S2zXe1Dc2azJCZ0KZGRpoa7czugZBeGU
         upJg8//gFSn/Pdd60plTxldBsQR86wq924UpZY6HZbI48j/3I3xr9g96tJnAyZYehp7u
         GWCoRhSIHW+2F/f61wo9ouqJq6PqXBwVp1azM+Bm6TlPseYxqs3zkuKw08+P6pGw3I32
         nOnQ==
X-Gm-Message-State: AOJu0Ywrat1lqLpNyv0GRufMOulw9JIrQGGcSUlypCy1IYbYtx1TT29H
        yTnSD7v6Vx8QN3J0IG+AFwwXPOIBa8X84s4mRFNTsDlFpWVzG0M=
X-Google-Smtp-Source: AGHT+IGoBYCtCjAQ86SAxGs9xBkfwr5QpF0zrmzEB30sGG6UUpGoI9ekq1FFDqzhUkm5pyvP9Cw6kBBKOiGZs9Rt6cW4r6YsLDKH
MIME-Version: 1.0
X-Received: by 2002:a17:903:2782:b0:1cc:6529:c7c9 with SMTP id
 jw2-20020a170903278200b001cc6529c7c9mr2749943plb.6.1700206862859; Thu, 16 Nov
 2023 23:41:02 -0800 (PST)
Date:   Thu, 16 Nov 2023 23:41:02 -0800
In-Reply-To: <000000000000dad29506056fbc93@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b047c060a544209@google.com>
Subject: Re: [syzbot] [PATCH] Tried removing the warning.
From:   syzbot <syzbot+ef3256a360c02207a4cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Tried removing the warning.
Author: tintinm2017@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 44a948b80ee1..d4ff4e6850a1 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,9 +222,6 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 	struct drm_device *dev = obj->dev;
 	bool final = false;
 
-	if (WARN_ON(READ_ONCE(obj->handle_count) == 0))
-		return;
-
 	/*
 	* Must bump handle count first as this may be the last
 	* ref, in which case the object would disappear before we
-- 
2.34.1

