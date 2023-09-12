Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49CE79D13A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjILMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbjILMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A29F;
        Tue, 12 Sep 2023 05:37:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4018af1038cso60783375e9.0;
        Tue, 12 Sep 2023 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694522272; x=1695127072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I02ZJvcK6GhbUBW4QVsF58xjpd6UhuUZvB8KzEHFDwg=;
        b=MEIdJ2HBNbtKTq8IgNBYBBcoLEe9frcuAhh8htpYP//OGDwqB6qgL+peb9SJZ1xvhL
         6nlsvII5iQ98PMrsjZGVJdl+0RlaKf95yq8IOxqbX33LI2tAxcrs4O9tZrOYByReoL/y
         fN/EmaOSaMv9G1WUz/dy5Iu3qtdEyElXt2+OrFx8HNeLJuFQFQGM7NxfrIYhbdRPpj/x
         83ZGyYlpMdJ+iP5AoWwv4Kl06iiASsG7zb3qY8zYaCRTLtYs37bkRdSJzt0zcXCUoFsX
         qofeM3HGi0OtCqKOfeSHv/cGIYvhlj1m5JOl1wyQhQbc7xKxInvGcTPNwkkTHXYiwUV7
         Dn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522272; x=1695127072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I02ZJvcK6GhbUBW4QVsF58xjpd6UhuUZvB8KzEHFDwg=;
        b=aV258qZod/BczGhZKP0ZQmvjdRVT0+38uB7zsIWKNxbtpbyawZ77C5HKEXHKRkIxa+
         ++xWQtYvu9fTpmrWuZJvXWlhvCSI8RvEu2xrlVWZKhFSXO4hS+3sJlObqpoN0DtUEekc
         A5qd3XLStTwBm/SdwpEYXvwj7kVZXLdP24Qi0jHcGzcxNKEPX0f6BxNlHDGhjrQuUjUY
         mfTs9CxPFb/LJ2Ic4pUcU7Epq8l7z2FIjw3yJ+V5RZscMvsXBZRCAeacitvEhg2mMl5j
         C+z7jJGq5HVPyiCts+9bLyl6t8Za1UAeRpraoI479tC05chaG7p39T5x2FYFtSLqx7xl
         jjfA==
X-Gm-Message-State: AOJu0Yz4BSajsLAkPic74IJS9WbqPSzTt9waMtYryUIUXS4TWYgahWve
        zeQwWn5X+4qQShqsuA90LD0=
X-Google-Smtp-Source: AGHT+IG4Zr99DFTYBW2EgYycCExLwNij4YIY3l3le/zFhcTUIlm/6cB/7qB1+8HiFhhUSjDkP++M8Q==
X-Received: by 2002:a05:600c:2946:b0:3f9:c82e:9d87 with SMTP id n6-20020a05600c294600b003f9c82e9d87mr10697629wmd.13.1694522271728;
        Tue, 12 Sep 2023 05:37:51 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d4ec6000000b003177074f830sm12805397wrv.59.2023.09.12.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:37:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5][next] bcachefs: remove redundant pointer q
Date:   Tue, 12 Sep 2023 13:37:44 +0100
Message-Id: <20230912123744.3929609-6-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer q is being assigned a value but it is never read. The
assignment and pointer are redundant and can be removed.
Cleans up clang scan build warning:

fs/bcachefs/quota.c:813:2: warning: Value stored to 'q' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/quota.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/bcachefs/quota.c b/fs/bcachefs/quota.c
index ca99772aedc6..719c4c9fc51f 100644
--- a/fs/bcachefs/quota.c
+++ b/fs/bcachefs/quota.c
@@ -786,7 +786,6 @@ static int bch2_quota_set_info(struct super_block *sb, int type,
 {
 	struct bch_fs *c = sb->s_fs_info;
 	struct bch_sb_field_quota *sb_quota;
-	struct bch_memquota_type *q;
 	int ret = 0;
 
 	if (0) {
@@ -810,8 +809,6 @@ static int bch2_quota_set_info(struct super_block *sb, int type,
 	    ~(QC_SPC_TIMER|QC_INO_TIMER|QC_SPC_WARNS|QC_INO_WARNS))
 		return -EINVAL;
 
-	q = &c->quotas[type];
-
 	mutex_lock(&c->sb_lock);
 	sb_quota = bch2_sb_get_or_create_quota(&c->disk_sb);
 	if (!sb_quota) {
-- 
2.39.2

