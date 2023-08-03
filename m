Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5680276EB9C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjHCOBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjHCOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:01:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0333330E4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:43 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 905C4420C0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071228;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=AEAArPRqZNJ0vesOF8RCUdDwSEncyLzF1iUVsRhZj62DtXGrLEK3VI1t3m5SaPD9W
         x+dSd0n1zQBqWj/fz8OfWltlOlFITioytdxEs9S4SNdwLaC8jPeUFzntH2zflr6lVb
         jv0j+CdLaWjhcJ9ziRw44hGh2doSUAX4Vl81yGW+N8BL8uyMVGOib28SpWmA+M9wUG
         nznHWbXegj20ETANM3vNOFIsd81diig1DFD+rSIMoKni4X5Th4R0D8/9Ev+WyMq9zt
         CAjsx1FcICwAoRIHW4tqHQdScfbDaqh6kHq5bFFmAwyG80q8g4eBz/3s2ZytR64udU
         R+tA39vo67MQQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-522a85b4caaso1376484a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071228; x=1691676028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        b=DSWtzgEKvB3AKbbMOUtzeJX5HGwzDmJumA4TYcDpoz9ve77WdAJz8cdMEJV7Ql/QqB
         uud4ax3lr2SCMqeWk/ipYvg/mu35rYiGHyKNJQfmee5v1ALN+lu1JpYLkWQTD5jt7vzf
         Jrua9ZlhBLjvy3lBFdVJ/wT/UaGD4k6cNdagL2+Wi2lSsvouLQeW83Es48pKRy2GaFZL
         c9xkatMKrqBxgN79DaZ3o1vyhE8wq7tuLhGl/1Lmlae0izTFu4Zv5ij3lCZZE+Jarffl
         J4XBQ2WP0jp2SSwpoeAEJvR+k7I7lOkwDvtcTZ0u30BIqUKOjDwO/CoVS4djFtctWyKU
         mBBQ==
X-Gm-Message-State: AOJu0YyvvqqCq8EFmX/i3vwysBRiTs/8RZLv/jSa3YkrW2ecN6QcBC05
        oSF+gp933Rxa3k4rBxrzVYkxn8RtJ43uxlyhAIA6v+ZzQTYXBoKyUXt9lzjDCAhrqhpPPdUgMK+
        pB+oaATxQnViyVK+jBrta+z/VeG/9Y7zESSH9/YnGfg==
X-Received: by 2002:a05:6402:1e92:b0:523:108c:9da1 with SMTP id f18-20020a0564021e9200b00523108c9da1mr1310097edf.15.1691071228225;
        Thu, 03 Aug 2023 07:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXIWH00hAA9JhRO4ltGaLPgi5HRMsa3dnowPuj7IPYkjIJeJxq8gWd9F+PV91tcL+ROU9eWQ==
X-Received: by 2002:a05:6402:1e92:b0:523:108c:9da1 with SMTP id f18-20020a0564021e9200b00523108c9da1mr1310065edf.15.1691071228019;
        Thu, 03 Aug 2023 07:00:28 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:27 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/12] ceph: allow idmapped permission inode op
Date:   Thu,  3 Aug 2023 15:59:50 +0200
Message-Id: <20230803135955.230449-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

