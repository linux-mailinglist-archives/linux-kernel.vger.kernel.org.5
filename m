Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D17CBA37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjJQFiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjJQFh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:37:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F7B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:37:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af609b9264so3458801b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697521076; x=1698125876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NymQgQrBR5+15gDoMLic0ZnEZ2tbOiVaD/D7avXdpOY=;
        b=mH5AoGFQSmie7+oacQKerm5Fiy12xx2t1+usnMIlSVQO8aeCc47EUWtCsuTotaMV1e
         rsNFZzmcIZGNJ6Zz1kanPqWP11cOEeYufNGl1Z9N1QqAKg4hLZeF0W0LN2YKNbQJEHrZ
         Jj5N7SVUXgNXIAE9sPp358hv0G3vRNP7lEO3E4h1EZyf23r+J8fya4EVFOHeCKkWrXUw
         MslP5jO9PuUl/+YynfznpdHlxa4z0++JMBtMjUjNXPLOVuEtKN9n9ZWazWwEYaan3t2D
         AjNIQ219whnM8q9sFww0GeHcVLguRE31sQQ8lSJnvflPIxgr/YywiSNdHn44hfCg1J27
         OXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697521076; x=1698125876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NymQgQrBR5+15gDoMLic0ZnEZ2tbOiVaD/D7avXdpOY=;
        b=fWarT2fWJBdQXWpgCMyU11c1JUstBoqrQ6G2IUUo0LdAAoRugOxaGpIeJ4B8BF1uVf
         yWz2PmeOs4TGzMj2YDRj+5gJK1TPcLjLKh852tDwWgTORWipscUNp7MI+B6HC3wMba7b
         0j1mQkx5eOiPiH6GU/1s0VFpytFM7S7C300j7I73sSP8ZnqBe6rhZ7iWvIy8TeDNnNUN
         8BcTQFzykp6J+YijHDUNx5xQ+5l8VnHZWctFdmXnls1JvoBSpZc4ViKTWcRl74/PV3Y0
         5nOjh0n2mCW5TzdJTSTQXHpK36MCtbJYVkhqwvawWZ+3No9F1+VhVv0VEEnAvKXKiaBW
         cmog==
X-Gm-Message-State: AOJu0YzyEE62rO/ymnIA4Q5xUixc0LeTM/R8k8bq9HxbhvsSP6JQxvP7
        NXvDXlg3ZO3JyltcYYlGI/Y=
X-Google-Smtp-Source: AGHT+IHgCUJNdnHtXru2EaDL6XR081LsUuFg2gAXuAZXjn/wrvl+807HGs1tQN3FQc0KX0TujU+r5Q==
X-Received: by 2002:a05:6808:9b1:b0:3ae:251f:923f with SMTP id e17-20020a05680809b100b003ae251f923fmr1470512oig.28.1697521075947;
        Mon, 16 Oct 2023 22:37:55 -0700 (PDT)
Received: from jio-Aspire-V3-571G.. (2001-b011-2019-b4ac-2011-fe5b-433e-dfe4.dynamic-ip6.hinet.net. [2001:b011:2019:b4ac:2011:fe5b:433e:dfe4])
        by smtp.gmail.com with ESMTPSA id h11-20020a65480b000000b005742092c211sm453411pgs.64.2023.10.16.22.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 22:37:55 -0700 (PDT)
From:   Cuda-Chen <clh960524@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Cuda-Chen <clh960524@gmail.com>
Subject: [PATCH] locking/seqlock: Fix grammer error
Date:   Tue, 17 Oct 2023 13:37:03 +0800
Message-Id: <20231017053703.11312-1-clh960524@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "neither writes before and after ..." for the description
of do_write_seqcount_end should be "neither writes before nor after".

Signed-off-by: Cuda-Chen <clh960524@gmail.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e9bd2f65d..734d9c598 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -574,7 +574,7 @@ static inline void do_write_seqcount_end(seqcount_t *s)
  * via WRITE_ONCE): a) to ensure the writes become visible to other threads
  * atomically, avoiding compiler optimizations; b) to document which writes are
  * meant to propagate to the reader critical section. This is necessary because
- * neither writes before and after the barrier are enclosed in a seq-writer
+ * neither writes before nor after the barrier are enclosed in a seq-writer
  * critical section that would ensure readers are aware of ongoing writes::
  *
  *	seqcount_t seq;
-- 
2.34.1

