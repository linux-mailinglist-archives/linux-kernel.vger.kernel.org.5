Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07A0780ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378046AbjHRPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378071AbjHRPMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:12:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24055420C;
        Fri, 18 Aug 2023 08:12:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so133932566b.2;
        Fri, 18 Aug 2023 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692371545; x=1692976345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmwLesiFYumNQ6O67fwcKZ7FMnVzuOPHn3ALA9q8Gkg=;
        b=bWv9yL6kAXBMtiAE5R3Vf0Ub8ZGiElyEL7Odw7Z3/0+CCMfc6Ym2nt0TFzS4q91NGe
         T/vzJY8OOdNIzWtoVmFSog2rI/VfXGhHW5ziEC4FkrvI1uxZ67Pew0SkAeTRxZ59CGR3
         h0LJeU3dxCbNKIFIKicCLI3SM2SvGwbPXQBL4DDtkHuUTXj07MvqJ6x9y791lW9K/U1Q
         9b7rQSOw86thqXaEhTTgHE5gCIwWFDNO87zSn9jBqXOzDDYTC8rWPUiGmPHbXI3c/j+F
         ZQz517p0R9VCw+6nuf4/yIbRQIiMrSROOoNZM9CXNFmCKDrfvY01w1iA5iaO6Fsc6If7
         PVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371545; x=1692976345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmwLesiFYumNQ6O67fwcKZ7FMnVzuOPHn3ALA9q8Gkg=;
        b=VbEwUDFkOl+bH6g1sX0PseY0wPEVbznpU+fwSL9YGmCM1ht7rh03jSMx8eVQY1bpdo
         v0wNhjkO3YggPKG9/2sYtmVsM2B3LCNdVAk/SJXsAGqTm+stLnV69qL8fIs3D/wNUQ+g
         51ZjQkhCIVQOqaBIUpFNvrsONGXmqiekE1LjgNdKfPJnSqIV+WorDvTJP0yZbmzKPQRe
         QzaVF4r0G1vWkOCesBH4xVqGQJ1afoPCCRV4KBw45HdXpWbgXZwCag2VDhk0ZmHEFyvX
         Eth1k8bIls2ZF/1/fZYH8EpTNeTAeayP0+WiJ/nI01tyJY5yVvl21w1QE3qySpo5YpBe
         lFHQ==
X-Gm-Message-State: AOJu0Yz3KJ4dG92XDTnMTMVx4zjUS3f9R0p30tcf7O/S4Onhtg08QKRB
        tHz6VL6w2773QE5cYbyITy+/a/7fTEh8aQ==
X-Google-Smtp-Source: AGHT+IFJ1Hdu25ZB09hgePICL8nmS6b458AH2wdxKHHueAU4N5ZIFOtwjnnZ06Wph1T+T/fjT9+rpA==
X-Received: by 2002:a17:906:3099:b0:974:1ef7:1e88 with SMTP id 25-20020a170906309900b009741ef71e88mr2205288ejv.13.1692371545323;
        Fri, 18 Aug 2023 08:12:25 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm1285913ejb.92.2023.08.18.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] selinux: dump statistics for more hash tables
Date:   Fri, 18 Aug 2023 17:12:13 +0200
Message-Id: <20230818151220.166215-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump in the SELinux debug configuration the statistics for the
conditional rules avtab, the role transition, and class and common
permission hash tables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 3 +++
 security/selinux/ss/policydb.c    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 81ff676f209a..0dd17fe76286 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -171,6 +171,9 @@ int cond_init_bool_indexes(struct policydb *p)
 					      GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
+
+	avtab_hash_eval(&p->te_cond_avtab, "conditional_rules");
+
 	return 0;
 }
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 84f02d4f8093..932e383bcad6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1158,6 +1158,8 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 			goto bad;
 	}
 
+	hash_eval(&comdatum->permissions.table, "common_permissions");
+
 	rc = symtab_insert(s, key, comdatum);
 	if (rc)
 		goto bad;
@@ -1339,6 +1341,8 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 			goto bad;
 	}
 
+	hash_eval(&cladatum->permissions.table, "class_permissions");
+
 	rc = read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
 	if (rc)
 		goto bad;
@@ -2616,6 +2620,8 @@ int policydb_read(struct policydb *p, void *fp)
 		rtd = NULL;
 	}
 
+	hash_eval(&p->role_tr, "roletr");
+
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
 		goto bad;
-- 
2.40.1

