Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB647A1F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjIOMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjIOMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:55:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F01BEB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:55:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401f68602a8so22780485e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694782544; x=1695387344; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7EqKPxcYmhqUUSygv21qZ32ZU2BZ3oQxs47F0gcyJg=;
        b=QPOSQVtkQ4WGiENEJdIkRA5ESI2hotgNjGg76vwqM8yjmNIjgXT6Rz/ZTm8pzKq5/q
         LYWEkvB3Cu/wl876W7dBzp/7p0kY0AaZYr7PIBVicum3JCHV8dPK0rxos00Mym5YFrk5
         aeWjQCiiI9+DJxZSCJ2RGdO0/9y3fGxuMl5OE27+N2yAnaygCXTKanG+hPTGx7w2bGqZ
         PFwYb9mSvIozJMg60Bd4XcZ4OlFdwlec53eMk89riR+q/Q5Bc+xSayE9H6FoqClJ36Lo
         WGRhazGk4+hVoKEDBUuRqEQ45hv14ogWcDLwt2ecXy3vSeQeGDkhwqPNtp1eGGGbyrES
         x/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782544; x=1695387344;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7EqKPxcYmhqUUSygv21qZ32ZU2BZ3oQxs47F0gcyJg=;
        b=NumR6yxMzLpYd0ITnDjuvS6evXVt3ad1MjKEnqEEIy++VXAsFU+1Ba4oY/52j5HCgD
         NFEbly1FJPNN1eM1LVos7ObdOdQuc4QS/iETUvUcAY0jMR1jat3hHHauCMKI3MbheQP8
         QZNWdjahmgi4PJNRIwWDrYafimO5VBxXAkgszhjeF9fjvOUHBRZgHwA07NedXxG++/Yw
         53t7tw/JuuYnFXJWXjCcPqAVhf/lV9DMbk0RP87F4sFN6wsKzSWttkkLt0luOc3dApZq
         PsBnvtwLxUYXPIPobuvgEP74IGzBeNNUDEDMpXiOwLVmSDi5B0ud2cCcq6sD0qSFi2Wf
         O6LQ==
X-Gm-Message-State: AOJu0YwDLXcHyArAY4ebl5C0BNx+myjvAWGFjFfjIGJ4QJtfdDZypcqX
        Vrzh7vQaxORg0wT1mi54MpytEg==
X-Google-Smtp-Source: AGHT+IEto7bO2ll96rxIxYH9bIhRuf0HO3ll8ym/KB6KqDjLJQEEz6UfL9AXbJCbFh2iCQTgp03viQ==
X-Received: by 2002:a1c:ed19:0:b0:403:bb04:2908 with SMTP id l25-20020a1ced19000000b00403bb042908mr1359308wmh.23.1694782543945;
        Fri, 15 Sep 2023 05:55:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r10-20020adfdc8a000000b0031aeca90e1fsm4408590wrj.70.2023.09.15.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:55:43 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:55:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] bcachefs: acl: Uninitialized variable in bch2_acl_chmod()
Message-ID: <ce3a4798-f467-4776-939b-b094c365cc5c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clean up code at the end of the function uses "acl" so it needs
to be initialized to NULL.

Fixes: 53306e096d91 ("bcachefs: Always check for transaction restarts")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/bcachefs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/acl.c b/fs/bcachefs/acl.c
index 9653401957b3..6b1579e96dfe 100644
--- a/fs/bcachefs/acl.c
+++ b/fs/bcachefs/acl.c
@@ -417,7 +417,7 @@ int bch2_acl_chmod(struct btree_trans *trans, subvol_inum inum,
 	struct btree_iter iter;
 	struct bkey_s_c_xattr xattr;
 	struct bkey_i_xattr *new;
-	struct posix_acl *acl;
+	struct posix_acl *acl = NULL;
 	struct bkey_s_c k;
 	int ret;
 
-- 
2.39.2

