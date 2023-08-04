Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF276FC91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHDIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHDItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8249E6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:43 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D6F7C417BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138981;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ixIVluzVEEFVnTs+B8ywrPN+MsLVxAOgurQvirTbsMHHw43QikshPOzToXoS7Klip
         4lkpteGQ2xNUMsKQFIc+ySJbnmvJpRVzyWZKdKz7yajCFJ49hjNg51Qg2I13w4a2AO
         377yZOEy2xKeFE8LZt6q6vkJg67wtEJHQy40wftWDc7IvaT5CD05Tc4YAQgEYxIlNf
         ZsyKaVDLZ2EvgW9068Rh2cYqGF9dnIAY8ZhEWD88QxksROM8efWlFkkYgR6I+3yYzQ
         XAapETm1KHzlQm1T7j/GgzHtmPyro/u9sePhBxYC8uJDaDonk+2qvriwtZuKwYcmR2
         RDku7PVfkkk5g==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso124417466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138981; x=1691743781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        b=CN4Y03YgG5o1rEqvPveoQPbKBVJEKuJHYJot0GdAXNm4YSMull4unedo8X10Vxq/CK
         iz0BB/7OOw46KZnmu6DaxjzjUD5HkcBNbA11we2F/Cd5O9DSn5WnkKP7jO0VJIB//hqA
         d/8gA0wFP07UhPmM0zZP0ZFD6KmvX5/nUCOAJ1sPClptEpk9gQ3z6LTBIcvvvgL7spKZ
         ccDDgStsBv/fAM+s/Q8KXC1Y/XEOs/iP+Ql0I5bb3x4X8Uc9ODh/LhIIb/8Fc8peeaUe
         pk6ySGfittJj0VHEbBK6r4vgdR7FxhP/Vjx8reBD6P8Jz1oePdEEOvW7tux0FJsCopbx
         FjZw==
X-Gm-Message-State: AOJu0YxYxE+DXcvkv2WILN+oGODtW6Q6YiKn6143bAsRl4tPkZBxHvPV
        Xo0ddNkKqH36uUUT8Z6uyH3ZlIGKvtqqH7hnlzdZfA8divqngjR9mHzAUU6qCI27yVD2UTMkZKv
        Jrllj55qLu2ymvKJ/ODgAhDbJCgpxlEWaBEfBIgqE/A==
X-Received: by 2002:a17:906:1045:b0:997:e9a3:9c59 with SMTP id j5-20020a170906104500b00997e9a39c59mr1098706ejj.6.1691138981178;
        Fri, 04 Aug 2023 01:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH95AAsx4OwruricX0LBMySZoccvHc9K7IbrBk/rcTzsxclDEI57KHtgRFatiy3JlDtPKgKBw==
X-Received: by 2002:a17:906:1045:b0:997:e9a3:9c59 with SMTP id j5-20020a170906104500b00997e9a39c59mr1098698ejj.6.1691138981036;
        Fri, 04 Aug 2023 01:49:41 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:40 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/12] ceph: allow idmapped permission inode op
Date:   Fri,  4 Aug 2023 10:48:53 +0200
Message-Id: <20230804084858.126104-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

