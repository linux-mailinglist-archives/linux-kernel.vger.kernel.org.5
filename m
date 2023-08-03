Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E776F063
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjHCRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHCRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:12:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE735A8;
        Thu,  3 Aug 2023 10:12:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so166988166b.2;
        Thu, 03 Aug 2023 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691082726; x=1691687526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z73G2iOJ2jMdW0hUi/WJTYS9nKjrWw45RzPB2IDtYwo=;
        b=jf6jtpdb3Fak8pt/s4RNhfa3gspI+Ju/3Qm6trcub2Nij6NOns4+3+mAfUidwoyFnV
         uA/KIGPbyLTeZ2rZkCG/oHja2Qjn3Y8dRMtsGXyvGiMWLM7XkUodgeURvW3Wz86E3eLk
         rDy3wYGDZvHmliFK1JIKuuQ7BNqypUPCv8STXKy64tt40qkqyu9oSbntD5kxOaSSATa6
         18AkUekakKXE8OXHnGFbDzC37qnXYVeQ8ZOVRa5Gl04xj9Iimoi7R5KXW90SnkW7m9Pc
         GbIjT8+BfZS7lxnXHMUucb7wZgB1eEf6XCoRRr6rV+qeF994fU/FwfCjiTXdB7p3bHSb
         h+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082726; x=1691687526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z73G2iOJ2jMdW0hUi/WJTYS9nKjrWw45RzPB2IDtYwo=;
        b=YmmgICG2qu9amatZCQZI07HpoFumP48VLzz/D9yh4wObP+lJfF09zWms7BBQV1jlxI
         oiyqDnSttQJESbZGUXfcvqKDjSzdJifTvYKYILjWiBNWcQJw/AfjlXTsYwULX7wefGrI
         d9yUSFXOpVHoj3y2pNYq1ODdO3ZGJVujFwxxYjpph3eTYy2qFBlr6HFeEjT21JwNTvdL
         19AZJWss0l8r1Baw2jlxJW0SqE/kTgKLrJY0+wiin6oPK5nzb2BuqiZVeeqPR1iyfNj1
         a+qlxWb+xOKW5mwFLsopmzsERk9iHBPNzlhzfdmMtw+S0Ot2tHnMbcYgW/WUjU9lKUnS
         tdDw==
X-Gm-Message-State: ABy/qLZRY+oKYLtQgIUUQHZLhkdnTN6bCAuGSNTY0BcHD6+axuq6dHxu
        D9hQDRCk2ylpXZZPGoxZ2ZhKlbf+ebGP6JQjBYU=
X-Google-Smtp-Source: APBJJlE/wk+sZVLtQFJlCu+Qvx+l4WhALBK1LhaQlm9p05p4o2Pb/oedvdSOSl75h7lQT6k53SexzA==
X-Received: by 2002:a17:906:31d4:b0:96a:63d4:24c5 with SMTP id f20-20020a17090631d400b0096a63d424c5mr7076679ejf.77.1691082726023;
        Thu, 03 Aug 2023 10:12:06 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id b22-20020a1709063f9600b0099b921de301sm79569ejj.159.2023.08.03.10.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:12:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: optimize ebitmap_and()
Date:   Thu,  3 Aug 2023 19:11:58 +0200
Message-Id: <20230803171158.486111-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate on nodes instead of single bits to save node resolution for each
single bit.

Similar to userspace patch efcd00814879 ("libsepol: optimize
ebitmap_and").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  fix array size computation
---
 security/selinux/ss/ebitmap.c | 48 ++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 77875ad355f7..653de257d70d 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -81,18 +81,52 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
 {
-	struct ebitmap_node *n;
-	int bit, rc;
+	const struct ebitmap_node *n1, *n2;
+	struct ebitmap_node *new = NULL, **prev;
 
 	ebitmap_init(dst);
 
-	ebitmap_for_each_positive_bit(e1, n, bit) {
-		if (ebitmap_get_bit(e2, bit)) {
-			rc = ebitmap_set_bit(dst, bit, 1);
-			if (rc < 0)
-				return rc;
+	prev = &dst->node;
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 && n2) {
+		if (n1->startbit == n2->startbit) {
+			unsigned long testmap[EBITMAP_UNIT_NUMS];
+			unsigned int i;
+			bool match = false;
+
+			for (i = 0; i < ARRAY_SIZE(testmap); i++) {
+				testmap[i] = n1->maps[i] & n2->maps[i];
+				if (testmap[i] != 0)
+					match = true;
+			}
+
+			if (match) {
+				new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
+				if (!new) {
+					ebitmap_destroy(dst);
+					return -ENOMEM;
+				}
+				new->startbit = n1->startbit;
+				memcpy(new->maps, testmap, EBITMAP_SIZE / 8);
+				new->next = NULL;
+
+				*prev = new;
+				prev = &(new->next);
+			}
+
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (n1->startbit > n2->startbit) {
+			n2 = n2->next;
+		} else {
+			n1 = n1->next;
 		}
 	}
+
+	if (new)
+		dst->highbit = new->startbit + EBITMAP_SIZE;
+
 	return 0;
 }
 
-- 
2.40.1

