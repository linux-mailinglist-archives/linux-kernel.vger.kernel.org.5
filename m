Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4113810924
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378474AbjLMEeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378460AbjLMEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:33:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC7D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=79tMagtsx8zWFd0gwV9uxN+xp9p3j086sCtxdA2GSnk=; b=I/Sz2oDNDne/J3Ji69c3Zo++0B
        KaVvqGIpFlld6IZQUKri3eM55z3fDBI7pIu6MY+ThDmnnB0g9DKRArT29U/geony9NIVmoQFoYQVR
        jCdqwSlgc9lB1DkpjlmUM6i6zg4/5U9MgdCANbbKn2ZetvNdixgr+yTtr+sG4eO3PD2cuQqupFyTd
        qUS4U240hypNStCQURcd6lMRXGDOohyaYsYMHMUfDNpKVNJgcLfAWWdPqaoT6ez4me/xlKPW2Z/1y
        FKbcDKEUDegvjUpoUIuPI12CEsZU21jSnyi9cFrCUB7yvKB6Go2bXOzgJ/mF6mET0IoZN2pdqkuSx
        LK2djSEg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDGwf-00DaMf-2Q;
        Wed, 13 Dec 2023 04:34:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] iosys-map: fix typos
Date:   Tue, 12 Dec 2023 20:34:05 -0800
Message-ID: <20231213043405.10163-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spellos/typos in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
---
 include/linux/iosys-map.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/linux/iosys-map.h b/include/linux/iosys-map.h
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -34,7 +34,7 @@
  * the same driver for allocation, read and write operations.
  *
  * Open-coding access to :c:type:`struct iosys_map <iosys_map>` is considered
- * bad style. Rather then accessing its fields directly, use one of the provided
+ * bad style. Rather than accessing its fields directly, use one of the provided
  * helper functions, or implement your own. For example, instances of
  * :c:type:`struct iosys_map <iosys_map>` can be initialized statically with
  * IOSYS_MAP_INIT_VADDR(), or at runtime with iosys_map_set_vaddr(). These
@@ -85,7 +85,7 @@
  *	if (iosys_map_is_equal(&sys_map, &io_map))
  *		// always false
  *
- * A set up instance of struct iosys_map can be used to access or manipulate the
+ * A setup instance of struct iosys_map can be used to access or manipulate the
  * buffer memory. Depending on the location of the memory, the provided helpers
  * will pick the correct operations. Data can be copied into the memory with
  * iosys_map_memcpy_to(). The address can be manipulated with iosys_map_incr().
