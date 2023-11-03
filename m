Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8DA7E0746
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjKCRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKCRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652181BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2BDwvqkQrafYreOuDJL/fbzR9dfSYQpbXhoeoCg4t4=;
        b=KZICXSPfKJFv1Pr8iADOaCuMqzcbUyxqlWevAIbjyOdwMseC5Vxqw6vuOlKPYnTWjfVviL
        KlOrrXHTenTngTu1okD8luEXknMV9eRBnglCPFWt+RMrCUPhE0HSxHSq79o98zDHzB0+Up
        SLCZsCPypcrieu0k56X3+AkjcEGoPN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-pleYeuzlM6i_Grq8vQ4w-g-1; Fri, 03 Nov 2023 13:16:56 -0400
X-MC-Unique: pleYeuzlM6i_Grq8vQ4w-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D79E985A58A;
        Fri,  3 Nov 2023 17:16:55 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B65AE40C6EBC;
        Fri,  3 Nov 2023 17:16:52 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 2/8] Kconfig: Add the new file vhost/iommufd
Date:   Sat,  4 Nov 2023 01:16:35 +0800
Message-Id: <20231103171641.1703146-3-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the makefile and Kconfig, to add the
new file vhost/iommufd.c

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig  | 1 +
 drivers/vhost/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index b455d9ab6f3d..a4becfb36d77 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -72,6 +72,7 @@ config VHOST_VDPA
 	select VHOST
 	select IRQ_BYPASS_MANAGER
 	depends on VDPA
+	depends on IOMMUFD || !IOMMUFD
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
index f3e1897cce85..cda7f6b7f8da 100644
--- a/drivers/vhost/Makefile
+++ b/drivers/vhost/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_VHOST_RING) += vringh.o
 
 obj-$(CONFIG_VHOST_VDPA) += vhost_vdpa.o
 vhost_vdpa-y := vdpa.o
+vhost_vdpa-$(CONFIG_IOMMUFD) += iommufd.o
 
 obj-$(CONFIG_VHOST)	+= vhost.o
 
-- 
2.34.3

