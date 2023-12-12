Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F05880EEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376689AbjLLO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376800AbjLLO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:27:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1632AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28acd29cab3so251836a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702391267; x=1702996067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5U/p6WhUwXmNbgop0UOPNRNBLfb2DEBWeLZPZx9Wi8=;
        b=at9vmyc4O+JIleXHXiP5KhLV9XRYQRSWIV6CPOSSNCdRzVqfQGjs/WEDUPQUgjUv4x
         Dbq6m9AxKV397cmFWC4RVCWb7QZxEbys/vcN/xgLlVMCO+yLx6hawZFJI1M6aCh+ugyl
         rjB5eU0p7Bz4+NUULGehMd/BixsCZ1LxEQslWVNCUvhZUZ+7v9hYrAX5JXZbJgrsZxtu
         rfkgJ87CPeLoSf8ToSH2cwDRtWZBnXrnZ3bC/LYojJaNCXGKDFWK4q8ZtWyDe01f9oUh
         /D0Duz3bHTcC2m4HeZFM2+nC7BkAKPoODlrSdXgy+I/A8rOVU9H6QsDztVYFqAlxvoi/
         6YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391267; x=1702996067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5U/p6WhUwXmNbgop0UOPNRNBLfb2DEBWeLZPZx9Wi8=;
        b=ZzA8xaWgY4rsFt2/WLKcT/7w0Qylh3KnrJURqjbYBp0NNWb9hgLnx1y40TLBSpz4Tn
         65paHu3TribfwhgVVc3VuGDfAZiSSxYOh1AXrb9rccoAe18fI0LSeyjzhNUUHa+uIag6
         /pCKyQEXBtLqrHmYrLU8OClkQu2UmsYV3NHO99O9aVxxzObX/Sa0sAO2+wg1BDf6GISY
         snKTeC+YuXdfVXLDpizyWOKefBDDEI3jLyTYaI0yJzfsRa5fsDA7j4SFmUfUcEASaLXe
         xTC+t+mUVQ2cQz59yw4bulNjkEMhEPXWnchAaGjYoGBo7oOVwo1wSV8wpYkFoyZnK1Bn
         H9+w==
X-Gm-Message-State: AOJu0YzPfC/Lq3QnceVP584jNjwBc9gYjZlD9B6P0BBPlENcZffixM2J
        H+0K+FP9QiXcZtPRtyuACgbFByHl3bo=
X-Google-Smtp-Source: AGHT+IHBa3kIuZPelSkD9/RNYWORbOb6/US7qHeFSWFjPGdbc4L/YeZdicdSYjA1EL9AkBcTfez/3w==
X-Received: by 2002:a17:90a:702:b0:286:db1e:f8fc with SMTP id l2-20020a17090a070200b00286db1ef8fcmr2877105pjl.92.1702391266731;
        Tue, 12 Dec 2023 06:27:46 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id pq18-20020a17090b3d9200b00286dfa09e7asm9156648pjb.24.2023.12.12.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:46 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] kexec: Use ALIGN macro instead of open-coding it
Date:   Tue, 12 Dec 2023 22:27:06 +0800
Message-ID: <20231212142706.25149-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Use ALIGN macro instead of open-coding it to improve code readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..0113436e4a3a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -430,7 +430,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 
 	pages = NULL;
 	size = (1 << order) << PAGE_SHIFT;
-	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
+	hole_start = ALIGN(image->control_page, size);
 	hole_end   = hole_start + size - 1;
 	while (hole_end <= crashk_res.end) {
 		unsigned long i;
@@ -447,7 +447,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 			mend   = mstart + image->segment[i].memsz - 1;
 			if ((hole_end >= mstart) && (hole_start <= mend)) {
 				/* Advance the hole to the end of the segment */
-				hole_start = (mend + (size - 1)) & ~(size - 1);
+				hole_start = ALIGN(mend, size);
 				hole_end   = hole_start + size - 1;
 				break;
 			}
-- 
2.43.0

