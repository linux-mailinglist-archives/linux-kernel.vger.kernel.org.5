Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AED7638AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjGZOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjGZOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E72D44
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:19 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D17842416
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380652;
        bh=Srcpafr6A4NJGaRIaUNnfkHMnBPsuuDlnOMtOvEnSSA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VroLM/VDKpFBzq2NIcOMgB+OsP1eNXYMNbRvwNBQ1XZ+W+lAmdtyqjkFs/DbfdCm9
         bSirK4avHoinjKXO8U5/6IQWR9X/pmCiizU1y9AKbL8L+8RjLeYi+WHwAQqQrq86rF
         RZwMhu+4Ytp275mmuVC4SbPjsV8rSI8sRKq0mC8cFrUpz06nUc3v3g9p4VyGBYM+mI
         mJncxvuikfpk72hG/c6hHeuYHhXYq3UC/aCZ8p7jjiUrH16bcHyhgZ1Id+AFxoLxnu
         KP04P1WlFw+Iq44/NkdnuKlqipUqxPtZis6eogOu2Pdh1ztMLaprfpAurCYCnaMDlW
         1E6a5L3T3T6yw==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b70cabc656so64079191fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380648; x=1690985448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srcpafr6A4NJGaRIaUNnfkHMnBPsuuDlnOMtOvEnSSA=;
        b=Hfk4ctG9PVIEoit4hos7YeLi4dl2XUlFPbxctp1V2l8vC52dz0ydfPu7g2jhTz8LZx
         GiFrSO8l746n7qSW3fJW1aWv0OZ/EGBxCpv+uGKNkSTNZmO83Ausov98kdUXtnRbE/1O
         MOyhmb9ILAZpCJhxAPAAdijlSWpc7U47YNY/Fg2R8QATx5WS9X5ekCnW6wux2xZX1jp+
         wzNbMF56MQWvTTDr3LQjTJ5/auKhQjwaAIlhAwPLB4OGuEc6KwP0J7D9olHNvi48yYdN
         Z5p6dcCkaONYNNFJX1aFF5Pc044TwoImYyDF4/+LXEJxmLSU5jmB4g6khOms+GCOVT4e
         hzWw==
X-Gm-Message-State: ABy/qLZmIH5w66L7WZI36eQTaesalaqh/pC2X16o+8aIdB+OWLz1zio0
        u5ZMSKOlz7N+qVQJ1FKgcoCHxM/xlHIAbVLtyUr+8E0sI8fS2ZcqropQMHyPRpyCvAHCUtmRkIt
        rhvhXEekvcO2O0aBFw6+g0WfELXGNp2SKjioYM2/8TQ==
X-Received: by 2002:a2e:86d7:0:b0:2b6:a7dd:e22 with SMTP id n23-20020a2e86d7000000b002b6a7dd0e22mr1518808ljj.48.1690380647891;
        Wed, 26 Jul 2023 07:10:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpYu9WEgj2snc3ZtgSt1ExxcGBa/VYSWFcXye2JQbmsYlosKcGQTknjlNkzD2mlntMHE7P5A==
X-Received: by 2002:a2e:86d7:0:b0:2b6:a7dd:e22 with SMTP id n23-20020a2e86d7000000b002b6a7dd0e22mr1518793ljj.48.1690380647707;
        Wed, 26 Jul 2023 07:10:47 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:47 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/11] ceph: allow idmapped permission inode op
Date:   Wed, 26 Jul 2023 16:10:21 +0200
Message-Id: <20230726141026.307690-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 136b68ccdbef..9b50861bd2b5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2977,7 +2977,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

