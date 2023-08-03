Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA32F76EBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjHCOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjHCOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:01:30 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682644A6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:58 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 75EE642418
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071241;
        bh=VUgFUdqFi9+fVf4KBmHgMSHcrOKks48HLHXKSZR7nM0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JIRRfFumk1KY9LDcMpWwjJ90vLnQarrxyxZjplJtu/Vurq9gBwGboIOlerOQhzlKO
         c8NpAmjijcKMOiQ+O5XzppV//nZ6aECE9D4/UWeo8/x1h/Yinop9Oh+/+1JKGdE5dN
         24NWgAR/6NAwkg3GVrZlk2DoMIF77B1eg2CVvWdqanxnF6HwZ9+flPObW//Kv2xDuN
         bbrmz5AmcSXAdYZHShoGAjORp65Bw0v37GbU0ygaQETLLpoZtJMzw5KdspRvXlrIMe
         JB8pCRbin34GBqST0G0hJuVsMhjNre9ak+iwBt7cNJo05IFB1OQJhGKgt5pV9BZ+6S
         zZ6xOsiG4o06g==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5223854ef71so685389a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071240; x=1691676040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUgFUdqFi9+fVf4KBmHgMSHcrOKks48HLHXKSZR7nM0=;
        b=l7iXpSvU8c4pVezwAsa04w15jmQyQKBcpeKkMVUlYfv6WQFolO3b11TRLNTvJkwZLs
         B5EdnwPci5tPXQY/CZ9m6jQBCsEypFFmigakMyRhc+lUOI5jmjzvUS9Eux39/CZEBBnu
         uO5romNiq37k6+/OwBdvOCclPaXBNn2m6VpiKC7KYX+v5Y4R1U3LaPSOeJ1IsZ0L41eN
         krHy58YE0gOOpZwPZLF3uhOvLeUgaplt2EyA1GyzuZraf1UdH87cgnJKZzZnoSgzB6eY
         C6yJ6edd2AehSbeWni/mYmVECcxL8ht1oogIQDGES0cL1N9RFOYlhzCmxIWtStrttaZ4
         dqPw==
X-Gm-Message-State: ABy/qLbHQIDlqYrP1eCp4WtWLRAfK/kro7NiJBLA31YIN8DKVK1wN/Mv
        qkYWCMAnoOZxqXsHqh5FyB0ZmZ9W/P3mhzPzcl6EaO4DkPad9ARketcsyVCjTAa9eaXxPtpF8oI
        3riRhsNA54vmeyO+eYouDkaVfdvM4hwARDWLp8mN6jg==
X-Received: by 2002:aa7:cb48:0:b0:522:37ca:a51c with SMTP id w8-20020aa7cb48000000b0052237caa51cmr7051507edt.40.1691071240822;
        Thu, 03 Aug 2023 07:00:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6Q02R9Pwuh55imXZTjVXNaetMucDVc5mJ3+DcQHv4FmT8HpUH72N1OhXDUzrzxEYbQpmVdA==
X-Received: by 2002:aa7:cb48:0:b0:522:37ca:a51c with SMTP id w8-20020aa7cb48000000b0052237caa51cmr7051500edt.40.1691071240663;
        Thu, 03 Aug 2023 07:00:40 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:40 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/12] ceph: allow idmapped mounts
Date:   Thu,  3 Aug 2023 15:59:55 +0200
Message-Id: <20230803135955.230449-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

https://github.com/ceph/ceph/pull/52575
https://tracker.ceph.com/issues/62217

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 18bfdfd48cef..ad6d40309ebe 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1581,7 +1581,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

