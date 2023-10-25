Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDFD7D6170
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjJYGJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYGJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:09:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E49D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:09:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9fa869a63so34567115ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698214154; x=1698818954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DOzMC9JnINWc5MYbwZ7TC8/K6W3nb2Ih949g1iEUhFo=;
        b=a7Fwmswe2R6BA242HyaxkWSPKCzrgHr5RZvM6TrPAmwocaYpEsKMLiCLpSDjdAPYl4
         TfSeYwmFoEs26xEaYmKYlkzOOtXoTNcv031rE8XTdRzf5Q0FPsVSVTYch09Lsm1U11tv
         mVGNDJ1l1vCkoSBbGC/X+sqPUnSlXDpBg67SU0F9VCu8X+TE8XEhyhBwcSATC112PnG5
         EjpYci0R8gC11WTQczeW+tZTFI70eBS7UfdxXx9Dibq8CxbLe7NMepCJgVSkKFhytrTg
         HviMMVKWKC+GZSJuzUjCY50BHpOPFWidRLXzA5AwYWum7EhR+EZy7/rQD12Yr3PMGYyY
         00lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698214154; x=1698818954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOzMC9JnINWc5MYbwZ7TC8/K6W3nb2Ih949g1iEUhFo=;
        b=WKQjMUi5HdwY7v8X42BawulTFCn+axbC+q+D80FhO9IJ9PyV1uEk4o7zuhlhN7i3ur
         pAZVP2h4pD2FimrBhZHGbc7Z6cTV7C6xwcTsfNkpAKMkvgjIlVFwOyltFHU8GYNQ9JP/
         dpQtcomspaEpGd9cS0rVhaRKT7w7H8oR2yqrltZ4YUOjtycUZGnsO6VgATzT1zenknzK
         U5wbGJeCKMYUTP5vQe4zTev+YCVN8gn3KhJT56S1hr/Sh7FmFfqUUUgaWdC8E7k19n2F
         SKTnZPGznUpHltk4nONkj9T+iGQD3CCW50n85HW4vGI2Wj0OjEBAlyuHMVB8w3uSxlJ6
         /XXQ==
X-Gm-Message-State: AOJu0Yyq8ItRZI/EM2sRl/JjwtDvFdDMO/FrydOirsYpUgCD1QhnmteO
        CAETPIng0f0uyawIGkN4xEQ=
X-Google-Smtp-Source: AGHT+IEaeAcoCGe4BhTpz5eV1Ol/6pw+vtWHIt90lHzvDh2Llq6p722EYAJEY6FXVXxugtYLDKt2Kw==
X-Received: by 2002:a17:902:c404:b0:1c7:8345:f377 with SMTP id k4-20020a170902c40400b001c78345f377mr15172079plk.29.1698214154398;
        Tue, 24 Oct 2023 23:09:14 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c723d6c410sm8380067plb.16.2023.10.24.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 23:09:14 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dan.carpenter@linaro.org, dave.kleikamp@oracle.com,
        shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        oe-kbuild@lists.linux.dev
Subject: [PATCH-v2] jfs: fix slab-out-of-bounds Read in dtSearch
Date:   Wed, 25 Oct 2023 11:39:07 +0530
Message-Id: <20231025060907.115675-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently while searching for current page in the sorted entry table
of the page there is a out of bound access. Added a bound check to fix
the error.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202310241724.Ed02yUz9-lkp@intel.com/
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
V1 -> V2 : Removed redundant check on stbl

 fs/jfs/jfs_dtree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..cf67d32d5b7f 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -633,6 +633,9 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (stbl[index] < 0)
+				goto out;
+
 			if (p->header.flag & BT_LEAF) {
 				/* uppercase leaf name to compare */
 				cmp =
-- 
2.37.2

