Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EC7A36D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbjIQRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbjIQRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:32:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F85130
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:32:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401f68602a8so41357455e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694971926; x=1695576726; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rv0WXvEmWnyDaqUvUFB3wnqqS3oft6IQcWo3AfHaMBA=;
        b=I+RASyk5M4/IGleMPJ531Nx9EDgyYVuAse3AFqOISCN5EAgjUywRDBCbNAiVjzRNp5
         QJkwBAIFABr7zI6Oz0U6yCNYZmF4iJi9e3h4mblPOWf+oe7w/AtiOP4SC6MqPU2hcDco
         qUfCA4mtxEjxHXWx5qa4gDAVgC/1tHm9wbhRw/tehpA9WYoP3QOoIEL592GgswRYXkBt
         GF+4Q5CaB2D24f3pSM4CGUX1usmautp6E8vEdrheBbvk0vxVza3rd02njtnzTglnL07Y
         dHBr5HbxHvYLUaygwPPqdNKsHSoM2TBfdv1pBL9DWnmp6zk3unwgvfdedP8luj7ubWsl
         zsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694971926; x=1695576726;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rv0WXvEmWnyDaqUvUFB3wnqqS3oft6IQcWo3AfHaMBA=;
        b=TP9Y8Q7QHMk6bUUqJurusNJ7KcVakfA8juE1YOPtUpMtjhTMpnFoqoiXfV/dVTEgfq
         M9jmF5zv9c5PMCRaDqqI3+bQg8VU/rxVPTOK19CqF/hhiaQe29LMk0SZm3mmMp6SztlE
         ZrOetdfhlGmQlhNYX7HZQCm0btBvd+rDzAqike3JW3Yxe6ZV50MCdU+v6UzJqVXFwZuf
         NdPCE5/+NyBZOErTAmAIbuhhQYjeHZ7+oIcUsGJyq6k4iH42+MDBZuGYlHU/QNK4faG6
         y/Oos06/8MvdMP8DowrGJYE00lHwO1L7zEGc+8+Jff+u9HIVgysiWir+HDZm+wG/ZLqU
         WSYg==
X-Gm-Message-State: AOJu0YxoGaEZPM24o7R5R/4XA0ZUxv8i8WeFUXmlTEgLWlXRCxp9JnLx
        oJ0JjwFDJZhpkmu8Lf9MaXsEkUQlKV0=
X-Google-Smtp-Source: AGHT+IEKZM+WwY4MZ5astIFysNcFknxpJeVZuwwWDOkwTkT2C4xhaqZKh4sgJb+WluDHuvLFooBKTQ==
X-Received: by 2002:a5d:6dcd:0:b0:31a:ea9a:b602 with SMTP id d13-20020a5d6dcd000000b0031aea9ab602mr5600023wrz.1.1694971926279;
        Sun, 17 Sep 2023 10:32:06 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d4a07000000b00317b0155502sm10126130wrq.8.2023.09.17.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:32:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 17 Sep 2023 19:32:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] WARN() fix
Message-ID: <ZQc4EdCAFDOHpVM+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest core/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2023-09-17

   # HEAD: cccd32816506cbac3a4c65d9dff51b3125ef1a03 panic: Reenable preemption in WARN slowpath

Fix a missing preempt-enable in the WARN() slowpath.

 Thanks,

	Ingo

------------------>
Lukas Wunner (1):
      panic: Reenable preemption in WARN slowpath


 kernel/panic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 07239d4ad81e..ffa037fa777d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	if (!fmt) {
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
+		warn_rcu_exit(rcu);
 		return;
 	}
 

