Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87178773B09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHHPhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHHPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:36:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7362115
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:30:28 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403e7472b28so34614861cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691465427; x=1692070227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pwtHw5vOD1RYKMIWegCIn/ujHRoRt+MzmoTcrvlAMU=;
        b=qKRFBwr8PO8Pvp07hvRp77Hhv7IVQwVDuZiGG5YmZpjkQD5Eyr8mgyRFnMQ7fdmbhZ
         6fCo6ml9GTzmtSBGnV0U2jYlL/hVQ0/4QoZh7sMzdVALsSliilDqnpJDSDx5vccXPJnD
         1os+/cy0e+Aa3quHrUGzVmKlyKAZws8JiS16wsqHAUHyU2tvskmUSDZ6h2bkQBYzHp4y
         Y4n6JQokCcYfm+m7+opszjr/oXqrax80Ap2ki64Y4dzPqzhAT3bM6n0ScWr+eDR7bY/X
         4DCrfzcOPzh7aRQy3QhSuDSGsFxfNNe8UcNtqYfAbS/gkgm1lqrCqc/4bvBZV435VY8F
         mX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465427; x=1692070227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pwtHw5vOD1RYKMIWegCIn/ujHRoRt+MzmoTcrvlAMU=;
        b=Tfjz8lNBg4NOceU6SO1U1HMLxOa4TDQlvUQkUR5eTfA/Y59WfX2cJgx2PvWDk1d/D8
         zZrpHpl5KP/sfokks2bn8cHDEBvYarVR7q/XKZC+nmRhtxh8ey2BzMm7tM7HtRo5BN/i
         SEsVqntsaV+mmnovwWduarFmYP1wDengyJtyx6F+NF6l3CMuX1EGZ0aTbKmXxopnKe9M
         pKJBjS+HVt0Bb/Ttb7R1yaoXsIgeT9nZwXbunO8X3906lX7oiRgEEsgGG/36hFzyA1ef
         YHRd+2OScIFwtH+ETzyzrLT5ZxEeLjAOWACtjZgiDCtLbjimobtKUU2G8rOMl9k7gNX/
         HIsw==
X-Gm-Message-State: AOJu0YxaImb4ozwgsewYnLZZCCeG8NZtYeOfdxREaW8cQGDHYl1WNOBH
        VPuXzQrScZtfbkk60TfiwQShNsxjBEU2TA==
X-Google-Smtp-Source: AGHT+IFTlNsk+I0QB9zoXtMVAjjI96pH73V9i1H2ISxoofH/hrPBkuGZTscXhj2wtJbTBeRj4WKuTw==
X-Received: by 2002:a05:622a:14c8:b0:403:b645:86fa with SMTP id u8-20020a05622a14c800b00403b64586famr15664525qtx.24.1691465426827;
        Mon, 07 Aug 2023 20:30:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id em12-20020a0566384dac00b0042bb5a8e074sm2854031jab.8.2023.08.07.20.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:30:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Jim Cromie <jim.cromie@gmail.com>,
        apw@canonical.com, joe@perches.com
Subject: [PATCH 2/2] checkpatch: reword long-line warning about commit-msg
Date:   Mon,  7 Aug 2023 21:30:19 -0600
Message-ID: <20230808033019.21911-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808033019.21911-1-jim.cromie@gmail.com>
References: <20230808033019.21911-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

Reword the warning to complain about line length 1st, since thats
whats actually tested.

Cc: apw@canonical.com
Cc: joe@perches.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6aabcc1f66c1..6e789dc07420 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3272,7 +3272,7 @@ sub process {
 					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
 			$commit_log_long_line = 1;
 		}
 
-- 
2.41.0

