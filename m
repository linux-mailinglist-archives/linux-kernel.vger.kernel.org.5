Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379ED7DC41F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjJaCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjJaCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:02:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4418102
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:02:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41ccd38eaa5so42379971cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698717753; x=1699322553; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztrq4YBof36EuC9p7t8unE3pcq3LkHbGfTdfd8TB1gA=;
        b=FJg05QhWJmLN2hv5xcl3rPo06bb+e60KOUMs0tOkqS3OeEGm6fErzZa+MXZO47Yt0s
         rHSj90P6aC0WD3OJrfd9q5Q1LCh0IN8+IaesRenqk0p7GO9W2JpCJ4hvdeQrdF40w7FD
         /ofzICawr3zDGsbpdYe1llKlPa+ic79g3IE1oR1tRpFKscL/Xt+1k6MnGNPBUXvqpuJ4
         smU7KpVqKeRAdcCdPlUn5wzLAk3rOhS6L505NmVWgevmCSReoKNelaEWI7arD1SsK9Pt
         TN2mWc1JFjRY8Qahu6+XjEh5EVehTOU0IjvgMl0tdyGDmyDR+ihldwsyH6GD4C1BfJVG
         VZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717753; x=1699322553;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ztrq4YBof36EuC9p7t8unE3pcq3LkHbGfTdfd8TB1gA=;
        b=eiF8hBpbOiEZAgU//eG3c+NZ0HCJP5H9ZF/O+X4vF1VFfv+VUo2DAX7ia6Mz9LSqRl
         IIwi/7VQY3ByPNro+EO2/aXpp2fYhT8FYIpBxttX4OZoh/Qz18OY32tIAnZtVtPT9FlC
         JtTH2zxWHR50Z71typ65tsmd1kDzHfepQ2LWwBKsbqZq7X+eF94KXXMoMix/V5K1wFoR
         OOVAPLY1Z05pC4CNTWRaSu6VtrGNBLIbP9JX9tyl+we39NV1oITstF20hd2nrpqrrNpV
         zD7zhcbT6p8hpDrCxyODdCc1lj1q0n9BtF0FjGiEBSXl0d1guHqKJOkWoQb1mwpN94iF
         l0Uw==
X-Gm-Message-State: AOJu0YyeYwThRYUVUqxsPnFHzTOwEZw6VFoDw97gEEcrOngSlC0ptNcS
        JAabfv/PSRJO5OrgYLZehgqa
X-Google-Smtp-Source: AGHT+IHWJyeajQ3qP9clxCroCLoIaUQFJvCzNz8pqmjiPFRMVaoHu8bvxk4qc7TmLrJ7IvKNjedX7A==
X-Received: by 2002:a05:622a:174a:b0:41e:535d:3de2 with SMTP id l10-20020a05622a174a00b0041e535d3de2mr2351869qtk.28.1698717752723;
        Mon, 30 Oct 2023 19:02:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85755000000b0041977932fc6sm119576qtx.18.2023.10.30.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:02:32 -0700 (PDT)
Date:   Mon, 30 Oct 2023 22:02:31 -0400
Message-ID: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20231030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Only two audit patches for v6.7, both fairly small with a combined 11
lines of changes.  The first patch is a simple __counted_by annontation,
and the second fixes a a problem where audit could deadlock on
task_lock() when an exe filter is configured.  More information is
available in the commit description and the patch is tagged for stable.

Please merge for v6.7-rc1, thanks.
-Paul

--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20231030

for you to fetch changes up to 47846d51348dd62e5231a83be040981b17c955fa:

  audit: don't take task_lock() in audit_exe_compare() code path
    (2023-10-25 22:29:47 -0400)

----------------------------------------------------------------
audit/stable-6.7 PR 20231030

----------------------------------------------------------------
Kees Cook (1):
      audit: Annotate struct audit_chunk with __counted_by

Paul Moore (1):
      audit: don't take task_lock() in audit_exe_compare() code path

 kernel/audit_tree.c  | 2 +-
 kernel/audit_watch.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--
paul-moore.com
