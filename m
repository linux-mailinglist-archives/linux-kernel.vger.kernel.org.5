Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972DD7C773D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442682AbjJLTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442688AbjJLTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:48:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34978D51
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:37 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a2bfd584f0so57765939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140117; x=1697744917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J26zzzV+rsRrtzvFakAziiZJUnlN/p9jMvjOqrUCer8=;
        b=fTJ/q4xRGHi7Ahddn7liWlR7kh+mhyqH2V/UszGwYP3cxm50Fea2HWtOeukq1SR+Q6
         x9A0vk9JtJIj7Qbe+WAtBuw8LYUIMm4kaP2HmYN01/OIcY2Tdx0xRUVj4G8NzjHCW0GP
         WHfN6eP2ZNYT00cCyi/uCKLYCrlr7WKRKpHeWYCYw0jhnPJ6E/H3+mCHHcrjJHNEbq9O
         +Vq09zM3/KjBTTk481FX+xMJU0TX2rbP4HzNVgdNSeCs7zl8Pu4Ndv1wZZbA1D1zuQ6j
         pBDqC7F4o6+0y4IxQEkE1qQyAd3ztM9t1drfiSLS1FCwvk3Jcb98pdZeRDSPniMGtLsD
         JZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140117; x=1697744917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J26zzzV+rsRrtzvFakAziiZJUnlN/p9jMvjOqrUCer8=;
        b=E8CI+EWp4KN0bi6OayLNtsxtrFObqWB+IL4QXVXfwgVQ6JRX44cC5jQD1MY0vfsFGl
         5K2LFbypKS5pCGVxdQNeUHSS/M44tQ/hTkDYLXnlu5JM/PZ+0GNBpT2EAwlpaXDuxI2s
         py6E/Ca/Y9RCKTaozYVOXjWj1DOZG+4xXlHwKAwaswtDN9Pi3EvmW9vlO96GdKyjlA+e
         7GXD3BnhzXMxVjWirqzJV8E1R+vezWAI8yYcqOFJqyvH8yHFfhj9to2Z8lZar5qxfTwK
         vXVhBbmU4MjOK5CbEDc8cAim8Bsueqae3BWu82ydO9z/KiTjh7gwlx7jN0vUzc6b80Zu
         M/Nw==
X-Gm-Message-State: AOJu0YygxWNRf246ltEwf1mdp2iw+bNE+GarZ1dZA0lDx3jM1H0T+l9X
        88o47410jcrpFSdAHC2kTSA6T6AOOTznMQ==
X-Google-Smtp-Source: AGHT+IHibITcQER6FdBWmdUf4dR11hKNvWzh0rnLl9orCcGQntVzbywQCyH7VFrOxordRuX2XddXFg==
X-Received: by 2002:a5e:a916:0:b0:794:eaef:f43e with SMTP id c22-20020a5ea916000000b00794eaeff43emr25695573iod.1.1697140117074;
        Thu, 12 Oct 2023 12:48:37 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 00/10] how to reclaim unneeded vmlinux memory ?
Date:   Thu, 12 Oct 2023 13:48:24 -0600
Message-ID: <20231012194834.3288085-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For builtin modules, dynamic-debug allocates blocks of memory into
DATA, via vmlinux.lds.h.

dyndbg's struct _ddebug has fields: modname, filename, function, which
keeps the the code's structural/organizational info used to enable &
prefix prdbg callsites.

The linker packs the callsites in-order, which means the repetition in
those 3 columns can be compactly encoded in non-overlapping intervals.

So this saves each unique column-val and its interval into a
maple-tree per column, and retrieves them as needed with accessors.

It also splits out _ddebug_site and __dyndbg_sites section, and no
longer needs the section, so that block is ready to reclaim.

Somethings wrong with patch-9, but it seems worth showing around.


Jim Cromie (10):
  dyndbg: prep to isolate 3 repetetive fields
  dyndbg: split __dyndbg_sites section out from __dyndbg
  dyndbg: add 2nd cursor pair to init-fn
  dyndbg: save _ddebug_site mod,file,func fields into maple-trees
  dyndbg: avoid _ddebug.site in ddebug_condense_sites
  dyndbg: add site_*() macros to avoid using _ddebug.site
  dyndbg: wire in __desc_*() functions
  dyndbg: drop _ddebug.site member
  dyndbg: add dd_clear_range to prune mtrees
  dyndbg: cache the dynamically generated prefixes per callsite

 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/dynamic_debug.h     |  40 +++--
 kernel/module/main.c              |   3 +
 lib/dynamic_debug.c               | 238 +++++++++++++++++++++++++++---
 4 files changed, 252 insertions(+), 30 deletions(-)

-- 
2.41.0

