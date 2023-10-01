Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2B7B44C0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjJAABM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjJAABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:01:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84433FA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0LLT2vAzEeUbMT3UdDc9ssPQNBYvi5QweTc9XkxKrtU=; b=1ei84gtlHJd8bNJoobYD44LosS
        LFtpf7d0kDkRASCicw4zIaJeYV7xBTEixznlYJtlkybwNQjuyuIYwVjXMt7ClxyVYUjD8HvCt8+TS
        o0t8UvszfCFNQWJmeaReeCtyZS9wlvKz1RL0qmEiDFUnP12KCi35fN9k7zNxB6FsYdAjTyKFEj7qZ
        UYT+2YHxAaBQtd6lWGcyCOQ71qI20nFBLBPd1YZwjNKGYrWV5Q+JsFMwDGEY3p3T+Km/48Pmx11Vh
        FOYqiw7U2xmKxo+bbhC4bZUHBRSRHcyB4FdVJFO/2ucCp37zyXw+A8mneLZWAlS7Lu1rLja0FeKXe
        GZBfCalA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmjtR-00AFOE-22;
        Sun, 01 Oct 2023 00:01:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: fix kernel-doc warnings and typos
Date:   Sat, 30 Sep 2023 17:01:04 -0700
Message-ID: <20231001000105.26766-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling of "list".

Fix a kernel-doc warning by describing the nested structure completely:

include/soc/fsl/dpaa2-fd.h:52: warning: Function parameter or member 'simple' not described in 'dpaa2_fd'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
---
 include/soc/fsl/dpaa2-fd.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff -- a/include/soc/fsl/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
--- a/include/soc/fsl/dpaa2-fd.h
+++ b/include/soc/fsl/dpaa2-fd.h
@@ -25,14 +25,15 @@
 
 /**
  * struct dpaa2_fd - Struct describing FDs
- * @words:         for easier/faster copying the whole FD structure
- * @addr:          address in the FD
- * @len:           length in the FD
- * @bpid:          buffer pool ID
- * @format_offset: format, offset, and short-length fields
- * @frc:           frame context
- * @ctrl:          control bits...including dd, sc, va, err, etc
- * @flc:           flow context address
+ * @words:                for easier/faster copying the whole FD structure
+ * @simple:               struct for the FD fields
+ * @simple.addr:          address in the FD
+ * @simple.len:           length in the FD
+ * @simple.bpid:          buffer pool ID
+ * @simple.format_offset: format, offset, and short-length fields
+ * @simple.frc:           frame context
+ * @simple.ctrl:          control bits...including dd, sc, va, err, etc
+ * @simple.flc:           flow context address
  *
  * This structure represents the basic Frame Descriptor used in the system.
  */
@@ -497,7 +498,7 @@ static inline void dpaa2_fl_set_addr(str
  * dpaa2_fl_get_frc() - Get the frame context in the FLE
  * @fle: the given frame list entry
  *
- * Return the frame context field in the frame lsit entry.
+ * Return the frame context field in the frame list entry.
  */
 static inline u32 dpaa2_fl_get_frc(const struct dpaa2_fl_entry *fle)
 {
