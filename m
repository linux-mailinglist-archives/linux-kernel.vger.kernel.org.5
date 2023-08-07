Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B497725BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjHGN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjHGN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA92117
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:58 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 358324248E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414901;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kM05WPvONwmOxJ76VhmPQscD4eahAPaI6K7gyMXLKVtk3+b8/ANE86DpouGTV9ZSY
         JSFuOWLIuQIzQFchmhf2noKOX30FcUPWf9vVkDjf8UOPLsQhdVldeB4R6phd1TTLEF
         RzD/y5OdLRdWVuselFcn2jkFGuQzTvtxd7XR9FlphNjfLXVu5wbaFWHmeV8w4eflp2
         2wOL3b3s1rRdzGa3WefQxykRibLcfiltdaU9UA5vWvkED+ShBZQTfr5W6TLCK+4xbj
         PSk6JMdoOKpGLIgNJ2lbfw0/iTS9PAp+YIJqwW2cTeALMNxyE24BM3XFiLnFKA5mT9
         f2vJvqOf+/05A==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d7ca4607so315673666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414901; x=1692019701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        b=bRQl+xoAfEDIC+1Ojf4YPCbU7qiiEUm15a5JAnh9gEbbdrtbSV+X6wA/0pvLnLpZP+
         pPILjzgSrL40V+ztYN4Be0pAC81bm1MZ3iDl0d5x+BjvfvnA7ZQnWKDkMsJt7+hnDZue
         cNkn/rxZLj7/oqhc9h1mRyE6D+MPXMhePXf0o9GdgjYh2rpQOKBCi7X1T7HqpgYPI2fr
         1cjSLiXK/nsRDFLtr2pXV0I33p17Bpv3pzJMNDAeB9eIvbZdqK4Wr6vclG8nRHXVYQFB
         fwbhmZeWK0BOuilsyALBiFn4wO68LW+hyfy2bnl8/lemqy+BHBXhZXoXKBYHuxPrf9PA
         z7dQ==
X-Gm-Message-State: AOJu0YwamIigPj2rTHW0Ohl/RajIdRF/JiGkowk+UYi2PZ0x7RCkVLXT
        JQFAZ0VeI5ds6IlPhjzKKc5BMfooa1ZpQa82ZJ3oQrqtcqmC+O5wBFt//1FQ/9cAeNNnNyNIqef
        rHSSFqHxucu4BYJv2ezlh0Zn7cNjBECbczt2XV6ur3Q==
X-Received: by 2002:a17:906:1011:b0:99c:3b4:940c with SMTP id 17-20020a170906101100b0099c03b4940cmr9039177ejm.7.1691414900866;
        Mon, 07 Aug 2023 06:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3ADA4o2cJQwyFlv49UMgDsjmvjuXfeU1vTiwFnYE1XpiRQKXsUX4t+Epk7AEPPGhbvKUbow==
X-Received: by 2002:a17:906:1011:b0:99c:3b4:940c with SMTP id 17-20020a170906101100b0099c03b4940cmr9039165ejm.7.1691414900716;
        Mon, 07 Aug 2023 06:28:20 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:20 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 07/12] ceph: allow idmapped permission inode op
Date:   Mon,  7 Aug 2023 15:26:21 +0200
Message-Id: <20230807132626.182101-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

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

