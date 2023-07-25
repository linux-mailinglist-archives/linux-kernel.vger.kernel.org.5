Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6617776181F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjGYMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjGYMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:19:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844DAD;
        Tue, 25 Jul 2023 05:19:42 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78360b822abso230482639f.2;
        Tue, 25 Jul 2023 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690287582; x=1690892382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmkse9R3WOHTBkbe4aJIZU51V2+DiEo0ttZZIgu4oqU=;
        b=owy0Wt2SxFNzCX2mVc+Ze3vixidikCgj2p21PA4sFWbw1lhBqujhXNWyH67nqcFWaj
         G3crQ5ZpGTkaE2oQ5hUKzCUjZeqCHhR+2/Xw9MozczKxmgPfR34/RJsIB37Slw46/1h4
         hg19cfcGG7OMGtDmIJN/pwrHZ9AYTP4RvB1huX6i/pTJfT5l9H5h7HvVDpwDq+HP/hXj
         Jme6Y0Ib99s3NKjq7M7tHZ9SDRS6BoNzV3+T6kIodqLcD094XqU/uoeQz7WmoR1KN5G0
         A3NJuU02iELcIEWybgWTrPHEEbHlDLp3mPcx/AJg6KU7jQ0AMMHT7a6iqfLZJQANkxFE
         JAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287582; x=1690892382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qmkse9R3WOHTBkbe4aJIZU51V2+DiEo0ttZZIgu4oqU=;
        b=RneUSsl84ALZbCJ/wCocHJc/m1PbC+WIEZlzPM3T1Tm9uiNrH+y6Upw0bbubKDF9pX
         a/APnturI6DY8/Rb008FM7Um3MaZAYunaTvKQtAHWey/ZcJm2UBR6a1ISTHNsfahQ5GG
         srtPitULaocfiofIIdFeUSYR71tnS+QyKXxo6S8WetQ/h7bI4XzBZELr2EDNnaFX9MI9
         kKS6Av5CbFdEK1d6fSbEq2suxNxTsQAmKbib5EWozZH5t7MpBkUszgfVFPaNsiixvlXX
         q/7nmyxhP+5+mylhVQxSJ9KpKbyIUDr02mHc3111Q/29kgU6Yo88DnMlH8A64hGUNgFF
         aOSQ==
X-Gm-Message-State: ABy/qLbh2IXmVOZR3HcB9KJPR50fhBloIt/ojlXCYLfgcM9i6iFBN6N0
        4HXQgD0rTyWwieXFR0vAoONlxv30yUU=
X-Google-Smtp-Source: APBJJlFbOrsjZNDs1EqNc1P0kz4vMk9QPFyyWzOPtqXVCY5o5pBep0G8vh6g/nBhD8+Xi7e904aGTg==
X-Received: by 2002:a05:6e02:216a:b0:348:797d:a94e with SMTP id s10-20020a056e02216a00b00348797da94emr3123122ilv.2.1690287581870;
        Tue, 25 Jul 2023 05:19:41 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm988185pjb.1.2023.07.25.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:19:41 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH RESEND v6 0/2] Fixing check patch styling issues
Date:   Tue, 25 Jul 2023 12:19:28 +0000
Message-Id: <20230725121930.3732-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6 changes:
- PATCH RESEND, the v5 was approved was not committed, Ira suggested to
  resend both patches.

v5 changes:
- Updated the missing reviewed tag in "cxl/mbox: Remove redundant
  dev_err() after failed mem alloc" patch (Dave Jiang)

v4 changes:
- Updated the respective patches with reviewers tags for respective
  patches(Dave Jiang)

v3 changes:
- Update the cover letter and commit message with full author
  name(Fabio/Alison)
- Correct the "typo error" in commit message(Fabio)

v2 changes:
Thanks Alison, Ira for your comments, modified the v1 patches as
suggested.
Dropped the patch containing tab changes in port.c

v1 cover letter:
The following patches are cleanup or fixing the styling issues found
using checkpatch

In cxl/core/mbox.c, in case of null check failure, returning errno or
-ENOMEM in this case is good enough, removing the redundant dev_err
message.

In cxl/core/region.c, the else is not required after the return
statement, cleaned it up.

Verified the build and sanity by booting the guest VM using the freshly
built components.

Raghu Halharvi (2):
  cxl/mbox: Remove redundant dev_err() after failed mem alloc
  cxl/region: Remove else after return statement

 drivers/cxl/core/mbox.c   | 4 +---
 drivers/cxl/core/region.c | 8 ++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.39.2

