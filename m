Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98A7725BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjHGN3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjHGN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4026C1991
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:55 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B29D4417C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414913;
        bh=ARhwDsiPa3Ci/G2xteJutduXCGuj42UUR3o8sfJhjpo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tASI92dghztMQQ32j5Aclvvn1dHF17vXAKXK0AYsxbS+rPMsmMjB7wllx9U4vA2LE
         0adXRhYHOADfpGCofTO5CbHdQ8XgrnW3tKftCYM0e6nn4PKNi6sfmdVUZMKIeno9Mi
         xbQvbbBAarTVnJYCwSj84ejTrRIZWgLJBrvSHTXD1p/ZlmXniI7UkN9aISfRJkl/iA
         Mt7BNqrvpes8I+d/tn7Fr3RwJydHuy2VxfBcaMglBrnJt+dqaabPKoWNHAs7Md5uAm
         3zxktNfhfX9T3P/8fiSqoK13xsAIiMGq1QW1n/8sWAl4gNvDLEWufpn3Qe/Czo+vRg
         OWOCltjln2USA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99beea69484so344973366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414913; x=1692019713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARhwDsiPa3Ci/G2xteJutduXCGuj42UUR3o8sfJhjpo=;
        b=JWc5tjGnLdYeBVEmKNKIUY1E/ECf+leD0EPNnJcwUgJAApLk8TZVqqiNXL+Z0ayHR1
         rWpLT+20NdhpCk97lWg4lmrWJZ/G1TQqe6dK42U1lWuw8DUnf4bd8K4/VNLSuMQmx4Q5
         jdoeWn1S9yyFSCxsW9pJjT67LXaM7fGzbW/JgWspAmoAnYuiTzaMU4AO1VImKmEZV1Ws
         pG0vM05UG6J3qzRxcPY0G1CeGPE6qgiG8Jt+0rTGlXmEVsf5FxKiLoGj9+dfTiwlf2Qk
         mbKUbZ7pbmd74L+HELSNdEl1r1Jn+fKqoJ/1R8P/QE5pOPLdgjK7vNbLFzNb+/26202x
         xheA==
X-Gm-Message-State: AOJu0Yz2sgSBEu7RdEcvANR33CbZ+FHEnuVhdFN/sW5QGaIJrNAyZZLl
        0HATuX7De6osRfDpn7FaTdb47yX856xuLBULKyahAoTtF4Z68VutrZe6bwvBt0msg8u7VTVfrO9
        HS4QJ9xzblsgkuzv+H33o9zddFpdUwS9I4tunRt6i+Q==
X-Received: by 2002:a17:906:10cc:b0:98e:2097:f23e with SMTP id v12-20020a17090610cc00b0098e2097f23emr7419782ejv.77.1691414913482;
        Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGltB/ZZoCQVwgCS4UTRIz0u73a/bCvTNvfAJknZZvuyuqC87rnvtadbkCLyDzGWG1RAK7amQ==
X-Received: by 2002:a17:906:10cc:b0:98e:2097:f23e with SMTP id v12-20020a17090610cc00b0098e2097f23emr7419770ejv.77.1691414913267;
        Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:33 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 10/12] ceph/acl: allow idmapped set_acl inode op
Date:   Mon,  7 Aug 2023 15:26:24 +0200
Message-Id: <20230807132626.182101-11-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
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

