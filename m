Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453457C772C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442438AbjJLTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442434AbjJLTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B0CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fa891b645so51172139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140041; x=1697744841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J26zzzV+rsRrtzvFakAziiZJUnlN/p9jMvjOqrUCer8=;
        b=VCQgbvcyVH7DIMhFK5ynoP3ivVP/wKu41taviH3CPirvxCZGa0kitdYRuTTLAeaMdG
         6R79PhOWe+hBL1BiJcI1ITNq7bcqB2E6u92Mwyq2Mds98ONVx4xQrIQBpXIioBrVaiSK
         vYFOyVKUndQbMefAbLdJJ1/ZXg5T0AmdHcibaLbPMXfrHIDvg4WZfTe1BSk3j/VPnE+3
         ReJ6q9AzR/tv9NWBOsls7b3et1BMyY4PNPcSaRUTMHHW4Epcmdy+UDAFPdkgFACpJRho
         eBLYWjNuBK22KvxK0yty6oiAKhckVPbcUsUZUVl2YlcEGjy0ueI9fZhKoFZS/eCNiLA3
         Xwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140041; x=1697744841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J26zzzV+rsRrtzvFakAziiZJUnlN/p9jMvjOqrUCer8=;
        b=qUyP57bMHrplPsUJ3YxAcQ3mW6xkllhQgDY4hKpe34dOWMzJWDW2h+KsTL7vm+/NG6
         rYtN9219Yr64iXSOACL3CDVCioMjCh13C2bWORbQ9y5D70wE+ampgL3e5fb+SjSYrrqR
         FwIlFSrPdE/qUz5hV6pg3AA4uTJLNKV9Ned0YOit2oCjdoF8s8/fNUlo0uKELHA+uSTE
         UTvPK0W4GFfUoLJBN1SgZirIj/GMrAQwxgo9fykDr2s8gf1YpVUYNaP/zTrewOs55m+Y
         TfRi7Qtg0SL4ugDZKtppX61G5QTBazFLq10imDEhYNGATCwZYzuF6E9FgFJ6MvlAVRmk
         WngQ==
X-Gm-Message-State: AOJu0Ywwh/YV4stTc3uBkP/jrOTZk4x+Eu/YZWS/JfcP/xQrB1qA8VaF
        x03dt24g06Ry8ISBvCIaN2fw+F1P9u+Qgw==
X-Google-Smtp-Source: AGHT+IEtpKtEiUHW58SKXa/X6fv26GQrh+CTpZc45+G87s6Iv0B3iD27tIqKGtfIcJJ00vzOWb2eBw==
X-Received: by 2002:a05:6602:2012:b0:7a2:ac5a:89c3 with SMTP id y18-20020a056602201200b007a2ac5a89c3mr27212332iod.1.1697140040910;
        Thu, 12 Oct 2023 12:47:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 00/10] how to reclaim unneeded vmlinux memory ?
Date:   Thu, 12 Oct 2023 13:47:01 -0600
Message-ID: <20231012194711.3288031-1-jim.cromie@gmail.com>
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

