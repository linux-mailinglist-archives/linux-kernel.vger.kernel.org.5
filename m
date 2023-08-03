Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E58B76EB79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjHCOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbjHCOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:00:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248A170D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:15 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81B9D42418
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071212;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LkxSgFGPREHqri4xcSlBNKn5t2D2FW4SfnQPDYSHOCXGMCToyBx3y2afjQjC05xgR
         xKxUIXxLjTi6mI9ggkj+isg39VeUj0sX4zUGdkHV4ajDziNaP2Qzs7iu7dbCu2fxaQ
         D8Fpn5SXmJcHGs2gkCn7OTfxwDsmMsu46oJsJwWEwyAJ0KPXETJAtshHBUXIqUZe3Z
         ZMC4Rtpkc73vs2mrAYEfqG6dxKk+ih40mYRoi5dY8w9D/ktm9LEulU7gyQK6tOcWA0
         DcxI4qH4zXQPp2zhrSyqe4Dm77lZ64+3DSWw28xSytF7BqeLhCeNdCa6beq22MC4hx
         iuplb6FUOSbgw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52291e49dbcso696169a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071212; x=1691676012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=AthLNGNfPkBIyROlGsRgb8SOBwvO8ltlcPaCkvY3zTkhUf9MtL9RITbp+r0LMFVQ0H
         hdKtDHpo8JYF6griTGGqkQVNEENL5ZLQZ69eQlvMAG/Ht/WBeYZs3g/8X5ukPOy20FPQ
         uOpWsPet62sUpukj0bPk1l3L6mNUqyTC7vsDlnccXhQ3oEdn/+sP5sbZEdJ1JrFuuMT/
         33lv4qG71OsqVc1s95/CQ7I8Q1dJWX6l563UDoEL5U33Ko/QFVBqkds6SzSsrTyM3sve
         BLlZdL16hk4FF23HA0MArLXw5Aw+UnZ9Pz5geeP7CtT8ATTPdgUkY+VYHKZt5gTrGZFH
         +j5A==
X-Gm-Message-State: ABy/qLZVP6DtWr4K2nfPzp5PNakhfU11CEu4GzclmvSissPE9lI+miQS
        yVhswk6iQqvV6AsgwAuVN1Ovg68cm1gf/XOfNQSg8qDkGIJlE9LDTc8F3bo6UMc55SgWytSYIKJ
        CSI9+qOAfFpwUhHzQs+YbOJ515D3hOS1xaaONhd5U+w==
X-Received: by 2002:aa7:c49a:0:b0:522:3855:7ec5 with SMTP id m26-20020aa7c49a000000b0052238557ec5mr8584108edq.10.1691071212142;
        Thu, 03 Aug 2023 07:00:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfIOUItlo0hjwrY4HJh2AtdBwv8To0WNWjW3o7KEaguO5IXHRwEyXe3XNgge+1GeScqXxVOA==
X-Received: by 2002:aa7:c49a:0:b0:522:3855:7ec5 with SMTP id m26-20020aa7c49a000000b0052238557ec5mr8584083edq.10.1691071211914;
        Thu, 03 Aug 2023 07:00:11 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:11 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/12] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Thu,  3 Aug 2023 15:59:44 +0200
Message-Id: <20230803135955.230449-2-aleksandr.mikhalitsyn@canonical.com>
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

These helpers are required to support idmapped mounts in the Cephfs.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
	- EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL as Christoph Hellwig suggested
---
 fs/mnt_idmapping.c            | 2 ++
 include/linux/mnt_idmapping.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 4905665c47d0..57d1dedf3f8f 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 
 	return idmap;
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_get);
 
 /**
  * mnt_idmap_put - put a reference to an idmapping
@@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		kfree(idmap);
 	}
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_put);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 057c89867aa2..b8da2db4ecd2 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -115,6 +115,9 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 
 int vfsgid_in_group_p(vfsgid_t vfsgid);
 
+struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
+void mnt_idmap_put(struct mnt_idmap *idmap);
+
 vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		     struct user_namespace *fs_userns, kuid_t kuid);
 
-- 
2.34.1

