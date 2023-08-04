Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81176FC8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHDIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5249EB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:41 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D58354248D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138979;
        bh=dbq6NgAMN4t7wxNwyddA+VrJjiC20GkONqywDZDeteI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=edXdGDcEtsqo8doV8kunlQD0coNauOaZVaUTViowv+QcRw+CVs1fZojjFCTALl84e
         Dy4VIouV/7PIzHeiRU1pkGewYL/EeBCU513DzJoZwbOFb0gSr3sJQMUdHfuaelygzO
         hBz3BIEGL6AujCjvuzD6MA37w/ZVOrWOltPo6e7XK+h9uFk994w7CzRyiNZ1cmddXf
         jLzonDlrVp4GM1WQGp3Mg9FzjG4NxPLVyQduc1dBzWwJtMz4gVSGIzeh/lum3B1Teo
         7YwJ4wryXuhE9A+fQ3gru7APn+CURcSgcoFS5PIs41qEJ9pJjxgVZmcF5GtB7Lk0z2
         VhvxQZcS1kU1A==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34e35f57so118538366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138979; x=1691743779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbq6NgAMN4t7wxNwyddA+VrJjiC20GkONqywDZDeteI=;
        b=MhdJoz9EOY9Zruoh9NZLEy1pzWwbnvewkKtY7OQ+QL3bm5r8HQjDLlM6PkPA4ZCLcG
         l1pRTot/cUAwLJM4ngZ0hZB8SEE3k83PuA2STtEdgg6gnszi6ybp86BGemFOQg6yvcSo
         bSzqJ56RK+tCLcyQ8u+87xblt2T0k+yGgZzeN5/2JiuHphdgYOY7Kjc+jPBiKGRPoBIs
         5xc9MLg3UD9UXwOTbUaye+na3KxDmF1CRaI7rAOtMijLhsmbVh1whIEyQW5pWqfifbI8
         VeDm4cps48UwkHmhpCNVbMhr0Sz6kg0hwkGG5eW9v5O+Adj4YhFjAdJkl+S4FO3iqfcW
         dhUQ==
X-Gm-Message-State: AOJu0YzaCXbOjv/p/PGa/kbAi6cZ8WgsUzyvVGCTX6y0dzxyXl/izWxl
        5AVD418ivldjHJSufuHVu4uw2+LTuPgljHffuV8vEJmG60kA5YuMMzITJecpf+39hVwd/fGcMb8
        MxiPzLBG6HnHEl00WyKHJoAyB2aBV87CTj15zSPwaEe9aYlN/Hw==
X-Received: by 2002:a17:907:2c75:b0:99c:331:4194 with SMTP id ib21-20020a1709072c7500b0099c03314194mr876530ejc.45.1691138979382;
        Fri, 04 Aug 2023 01:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESWXoXKkpSChoFK7yg9A+13bbRcRctLrscoYkM2GH7k6ZkVluHa/bbcpxuaBSQemmgRG6ytQ==
X-Received: by 2002:a17:907:2c75:b0:99c:331:4194 with SMTP id ib21-20020a1709072c7500b0099c03314194mr876517ejc.45.1691138979203;
        Fri, 04 Aug 2023 01:49:39 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/12] ceph: allow idmapped getattr inode op
Date:   Fri,  4 Aug 2023 10:48:52 +0200
Message-Id: <20230804084858.126104-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 3ff4f57f223f..136b68ccdbef 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3034,7 +3034,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

