Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D927BC36B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjJGAzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJGAzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:55:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AE4BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BT8tYl9kyCovYjvFEVeXbXj4P8U+VUi2Ywgg+MiH7SA=; b=2THIlO9aNRYwd5NkbeiK3pMNqH
        NVJFXMVfMrgYpaKmo+HvRdCyUG4hGIbVtdiNDP3LJWwpJcze8rqWWoMrlF6HpzEplrjlo2L3uEqoO
        2akY3DOGppEY+2MAdVQBJzxXvNtA3FZDkbea43kc4zQGt7IB/EzjwJoZWWMwcmJAuJGa2n4GccFH3
        YLAiWQ91KBaxJEnWONEpkXb+XBptKQgXxOypuZz4euLfM5GTKTD68/Cgatlag5YEMqH5BvwS7sONk
        Qvk+boo4Hqr8MMDr9aeYTlMrnquP6ZF82521NciqUNbTCyFqov2Oz1IKQtiSpg2qbAbaRAvJzHEvA
        GdWZ/vVw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qovbD-006j2J-0g;
        Sat, 07 Oct 2023 00:55:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: exec: fix ioctl kernel-doc warning
Date:   Fri,  6 Oct 2023 17:55:18 -0700
Message-ID: <20231007005518.32015-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand  * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
 on line 49 - I thought it was a doc line

Fixes: d59e75eef52d ("drm/nouveau: exec: report max pushs through getparam")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
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
