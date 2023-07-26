Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839297638BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGZONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjGZOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22D2696
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:26 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB5C642489
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380655;
        bh=btgWKV3yveDSttvNeYwkzRRCd2/ECqsGtpVUjkBAwbI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S0a+yz8sIcNtK0ZXpiRQfpxq9kIgspctVB6TV73YCV8mw+Qw2pstbwcWgesvCcweF
         uCrxcVjJR10rhTYJFK/YoeauhkeI6Ht997wkqy2DjN5UYbf2ZcooyeTaEhJ0ekGvZt
         w4dt5MEDvOkDsYAb7+TJ9YMFgshgaNisPhJbDqLIkzNbqBd/DO6ZVFkJwEhFBRn1xB
         BSplGh07/jiThrHbga1ZsVOnUPS1UmHWa5I1hMCc2ynE3indjG+DB9JaDPk5duU6ri
         3/XT9/2pkdFSVWMiT8ycLp/nJt1MULYB5MwXF6R7dEUJ+xz7lOJeBj1mqg1SlLUIfs
         rUdSt27IekmdQ==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so33911635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380654; x=1690985454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btgWKV3yveDSttvNeYwkzRRCd2/ECqsGtpVUjkBAwbI=;
        b=MVcHjlQQM8jHq1geaGEYD97TkdUMy6z5SJvQ66JXjgaQxPTU9ONo65KomqrS9S6kVO
         Q7rboRUr+w9vX/E+5fRCJUe/y53MO5wgAGI6+FkzyxnX/MhFWUBGy3GYH76qamWnelmo
         +QhcTSay3xNNyap3XORc99vczRjjKdaEPsCdBpWioDCINqfGGBbABXS98x3vr56D9KhJ
         UZKp1LGFtemHR/3+LB7RXTFb7GtIl09YZLrZ20AQtfaG3cqCiiZcpjxesKsDzZPmu/zw
         fziJnz08KvU591u3LZHbk7m/6yRK96y21LmK9f7qREkIyMywKrbYX4wJfL8DMCWpZDc+
         stpg==
X-Gm-Message-State: ABy/qLYy+00d/eX6//+UD8J/62m5HTUM25RBC8l2PVVndFkYMbxlvmQa
        Xgzgadst2e1MGZRw8OmhBrKkc+ifUf8qh1eYcrl6VTBe4GJA7F/shRStrJIusphLsHsVU9NLfCZ
        op0NK9er/1H/uxid9WQl8ALdh1ZSUev1lZwpx7UsGIQ==
X-Received: by 2002:a1c:f30b:0:b0:3fa:9823:407 with SMTP id q11-20020a1cf30b000000b003fa98230407mr1492374wmq.18.1690380654470;
        Wed, 26 Jul 2023 07:10:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0kgNfDOvl4L/e4bgCJhjnwtHxj/EJz2PT0QwAgmPUSl/Z/j/8mmxYQlHnk4PjjNZchfPvDw==
X-Received: by 2002:a1c:f30b:0:b0:3fa:9823:407 with SMTP id q11-20020a1cf30b000000b003fa98230407mr1492359wmq.18.1690380654250;
        Wed, 26 Jul 2023 07:10:54 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:53 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/11] ceph/acl: allow idmapped set_acl inode op
Date:   Wed, 26 Jul 2023 16:10:24 +0200
Message-Id: <20230726141026.307690-10-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 89280c168acb..ffc6a1c02388 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -107,7 +107,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
+			ret = posix_acl_update_mode(idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
-- 
2.34.1

