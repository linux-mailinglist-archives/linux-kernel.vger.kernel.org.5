Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C078780F31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378167AbjHRP3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378219AbjHRP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:29:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEC2D69;
        Fri, 18 Aug 2023 08:29:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso15996321fa.1;
        Fri, 18 Aug 2023 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692372554; x=1692977354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGdhKDagLNiyvMYG4vSpVc/SWNCjljR9K7K1OsrdWaE=;
        b=MwPzDBJhV7igODZT5nXZdih7Mtw8E8LRKumyLrNRhCj2uJo3YG+j3gnV2RcGX1done
         AgliGTCMnkghr1okSuZcO1Sjfy9Nr9sfVsLSYmxlU5X4YZ+yCGtLxRMWbTsh51/utoo9
         1IwU++yk96A7av17PjAVFFtDHfqPLKn5bpa3PQAG3LfizJLBguiUNv52bKqFii+rn2eu
         4gy9QSxKWL7rYEKeNxsuN+/+wRqyuHO5jDEb5tGFyafcjGZd24kjY4+2BjxFGMQ0jUxJ
         iWL1pCAIDVpunah5tCdfNOHRhbkZ/tRpJpMrCljK8+BtdZEg7yTJZi2nTs87MUG4g+zx
         +Xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372554; x=1692977354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGdhKDagLNiyvMYG4vSpVc/SWNCjljR9K7K1OsrdWaE=;
        b=JgtdU3nIunizhsfY2Id9Hb71badS9v9FboVv2YfIIEu2kXWy11KmG/OV5+O57urNsT
         ygzroN6J8sSN5OFJIZrEQ2BlbccHMaFtGAw5UfZ5of7PZYGusnVQKU/LNkpCIg95KKtN
         g8a58quCKXcM6kBPk1VJFAZj235zTqLBLAI67KvsUFohJahPr+UxXFGbmfhS7f34MEUV
         0CuiiN0LqDP5ZGZ4J8hGNKP7Jhqz11zds90cxZ4lZMPH/VY6lxFXu+GNLuUtEm7qWm+4
         FaurB43eP/e18TCLXyhl+W3A1pr782Gy1gDRLt2VlO4tIBu3iJ/EnMPBchmS+H90Jqwm
         vmWg==
X-Gm-Message-State: AOJu0YwGwTwwR+dw4eaje2cqnk4vHl0J/AbZBlHRpZZCpuhQvfKSnjos
        6MoOl9kZJ4GRju90MaKsf37T46Ahcrd0qA==
X-Google-Smtp-Source: AGHT+IGkbgl6jn14jt/o0eSJUF1QSIigvpFhD3+0nyY7tr854Zx7mv71Gb18aw9pTtsbbwK4BUeoZQ==
X-Received: by 2002:a2e:9b0d:0:b0:2b9:ba02:436c with SMTP id u13-20020a2e9b0d000000b002b9ba02436cmr2370679lji.28.1692372553487;
        Fri, 18 Aug 2023 08:29:13 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090615c700b00999bb1e01dfsm1294142ejd.52.2023.08.18.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:29:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: reject invalid ebitmaps
Date:   Fri, 18 Aug 2023 17:29:09 +0200
Message-Id: <20230818152910.176044-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject ebitmaps with a node containing an empty map or with an incorrect
highbit.  Both checks are already performed by userspace, the former
since 2008 (patch 13cd4c896068 ("initial import from svn trunk revision
2950")), the latter since v2.7 in 2017 (patch 75b14a5de10a ("libsepol:
ebitmap: reject loading bitmaps with incorrect high bit")).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 77875ad355f7..ac9da819531d 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -450,6 +450,10 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			goto bad;
 		}
 		map = le64_to_cpu(mapbits);
+		if (!map) {
+			pr_err("SELinux: ebitmap: empty map\n");
+			goto bad;
+		}
 
 		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
 		while (map) {
@@ -457,6 +461,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			map = EBITMAP_SHIFT_UNIT_SIZE(map);
 		}
 	}
+
+	if (n && n->startbit + EBITMAP_SIZE != e->highbit) {
+		pr_err("SELinux: ebitmap: high bit %d has not the expected value %ld\n",
+		       e->highbit, n->startbit + EBITMAP_SIZE);
+		goto bad;
+	}
+
 ok:
 	rc = 0;
 out:
-- 
2.40.1

