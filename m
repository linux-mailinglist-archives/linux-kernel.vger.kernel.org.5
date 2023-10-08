Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868557BCECA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbjJHOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbjJHOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:02:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE599
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=figW6V5IxO3BN+Q3ev6fcFUCPxrFf784LSxaFnVtQh0=; b=hXUnR+z5iXugz8qJvJ6sO3rUMU
        UeLlJjoEa0+ezplb8/cgbEVxY6c+TS+Ai6cz4h1cNpXUOjJ2NNk0+fESqqPVLe006JtsNF1dg9AWP
        lfutHgYn+Rr3H3OV6fBEyxhXzfDxxeL2zgzbmdUfZYwuqximXP/PGjdZ5ZJuTU96ZKEpkvGyEqFmQ
        mvguTtscESZ/a9E5tY4/P5VCh5iGSeGKbZ+B7qI0KVb7ITD423v0aCqdOJlBU9LWEEKDMwwODYFvX
        pSo3X24IOb3FGnnQ3C/UYbPt9vwhLl7P8g3gGK1oESwLkdV5LQWVfoEDfyZwhCNn/NRckVnppBE84
        TvF5BEJA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpUMZ-008vP6-2d;
        Sun, 08 Oct 2023 14:02:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Subject: [PATCH v2] drm/nouveau: exec: fix ioctl kernel-doc warning
Date:   Sun,  8 Oct 2023 07:02:31 -0700
Message-ID: <20231008140231.17921-1-rdunlap@infradead.org>
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

kernel-doc emits a warning:

include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand  * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
 on line 49 - I thought it was a doc line

We don't have a way to document a macro value via kernel-doc, so
change the "/**" kernel-doc marker to a C comment and format the comment
more like a kernel-doc comment for consistency.

Fixes: d59e75eef52d ("drm/nouveau: exec: report max pushs through getparam")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
v2: update commit text; somehow I sent a version of the patch before
    adding the full text.
v1: https://lore.kernel.org/lkml/20231007005518.32015-1-rdunlap@infradead.org/

 include/uapi/drm/nouveau_drm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -45,8 +45,8 @@ extern "C" {
 #define NOUVEAU_GETPARAM_HAS_BO_USAGE    15
 #define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
 
-/**
- * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
+/*
+ * NOUVEAU_GETPARAM_EXEC_PUSH_MAX - query max pushes through getparam
  *
  * Query the maximum amount of IBs that can be pushed through a single
  * &drm_nouveau_exec structure and hence a single &DRM_IOCTL_NOUVEAU_EXEC
