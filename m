Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7F79DAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjILVZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjILVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB910CA;
        Tue, 12 Sep 2023 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694553899;
        bh=lcaIV/ECVCgvfmpOvOHhH9PShQ1WRH/cLwz2eArAXE4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ghUe4u4VKEZLM18H9S+zUlfgL1vzoQarlSYzrB9AQzGeco00227DWylXO3Mcpu3Aj
         dsUHblvTVW3hTHbJH/XMGQmqmMtfpXtEOEk3WFqGt4lxtH1OLUQRCHL1KOhLDER4ay
         99xs8+bA1oUvYKhvoKzFRnfQW1svtLQPc/D3e6Ak=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 12 Sep 2023 23:24:41 +0200
Subject: [PATCH 2/5] bcachefs: Mark bch2_snapshot_node_delete() static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230912-bcachefs-cleanup-v1-2-c1f717424e6a@weissschuh.net>
References: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
In-Reply-To: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694553898; l=755;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lcaIV/ECVCgvfmpOvOHhH9PShQ1WRH/cLwz2eArAXE4=;
 b=C1az70RMin9nhh865O+G2H+Zias+zDorazwXfRauKsf9FyYfBQCBoCIXKL8BRCrr6512kw+Oi
 l5ONOXBg3RiBInEyVDrIO2thY1tamVeFhYZCegF3O1AP0I6o+dcfdnx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never used outside of snapshot.c.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/bcachefs/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index 9da09911466e..c69b16010027 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -930,7 +930,7 @@ static inline void normalize_snapshot_child_pointers(struct bch_snapshot *s)
 		swap(s->children[0], s->children[1]);
 }
 
-int bch2_snapshot_node_delete(struct btree_trans *trans, u32 id)
+static int bch2_snapshot_node_delete(struct btree_trans *trans, u32 id)
 {
 	struct bch_fs *c = trans->c;
 	struct btree_iter iter, p_iter = (struct btree_iter) { NULL };

-- 
2.42.0

