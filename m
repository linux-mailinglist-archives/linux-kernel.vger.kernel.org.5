Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58CB762293
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGYTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:43:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1081FF5;
        Tue, 25 Jul 2023 12:43:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb775625e2so1489415ad.1;
        Tue, 25 Jul 2023 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690314228; x=1690919028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmDViLCRyHl/N/tg3JfeM78/5jvGUYwvAl/GxQs6m9g=;
        b=PVsbjHPBcn1yrgJtZoqGaQexpIl2NOm3dGF5HDWjJFFCp6izrIlWjZxk3k9ABTg/gk
         OTELwpMcumAZlm+K+S3Cm9ycQclgeWkWwbU33/1/lDK8gLemjU5X1Ij+GvHU8LBJuRz1
         iaiOaG3gRLgMVwy/DbmyYpoWcKqmcUCM/N/JCZNnfQ7oLrpGJwD6TisSsZEF9C69HRCS
         P/VVH28ofHSNitytYID8+ZVfFqLWyKTudqV0oTGIbjNsL5mj+QwoY3vos9iSG7yQwArR
         lY8ADN8vtjltEufcZ/cqzuCUylSDWDyI75aTTj8ZBSc7H+mFxVvHouLYkTAy25qcMojh
         pn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314228; x=1690919028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmDViLCRyHl/N/tg3JfeM78/5jvGUYwvAl/GxQs6m9g=;
        b=QRtq1R9HhY/exfVvh5FBzw/CJezNk4fuDqui2cpUI7JolGDcFk/6PhoMqThFWouFrz
         OmR3eBTg9KAN8085doNAanDIFA1MDMn5xO0X6JMf64eFMSdmyjjlu6q519mfMo4V4ez8
         ZGjNud1NExnVgGyY2OdxaYicUrGWzZgFyyXaV0bQaRKi6+Fg23AXlzt8gh6U0CFjuZC+
         cDBmet0g2Y940zL9GxgrUXF/YnjTIiLwtp0RukeVZ/QvW3LBG1Q2XNcsylv4GkWoAUWX
         YSwaYtOAEKNvQ8S7lVfX1MZhNz1eLu5nCjZA11GO7eOvt9oFhKmRfCdz3O4YWeFTUuQP
         OLbA==
X-Gm-Message-State: ABy/qLZERkurueVeXhoieXCExw+rMOelGz+ffCYeHS/zngVyS9NeFgcU
        ppurRS58Flzl/tyZmj7E+bOEKHyi+94=
X-Google-Smtp-Source: APBJJlF5A3iGfb5iscZyvIYmAxrLPczmwlUH4vwZH8eTXohwgnk+/WJefag1/fAURl88ThxR0Uht2Q==
X-Received: by 2002:a17:902:e545:b0:1b7:f64b:379b with SMTP id n5-20020a170902e54500b001b7f64b379bmr64248plf.17.1690314228278;
        Tue, 25 Jul 2023 12:43:48 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001b87d3e845bsm11503262plg.149.2023.07.25.12.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 12:43:47 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 0/2] Fixing check patch styling issues
Date:   Tue, 25 Jul 2023 19:43:39 +0000
Message-Id: <20230725194339.1694-1-raghuhack78@gmail.com>
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
- The v5 was approved was not committed, submitting both patches(v6)
  addressing styling issues in cxl/mbox.c and cxl/region.c after
  rebasing with latest source. The changes remain same except the
  function in which redundant dev_err() was present has been renamed to
  cxl_memdev_state_create. (Alison/Ira)

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

