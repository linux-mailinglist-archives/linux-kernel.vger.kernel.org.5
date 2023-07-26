Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0691B762DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjGZHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGZHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:36:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760535AD;
        Wed, 26 Jul 2023 00:34:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3428687a12.2;
        Wed, 26 Jul 2023 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690356872; x=1690961672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BhJzvHH17zsu58aRI3qZvsQHAbkxeYw2yyHP54Sanc=;
        b=M8AJMeZpvw89DVVggNec6w34SO71lnA85aHHZ8bTQbK0uuS1y9DjYj4XQXpEltOdCn
         /6f08RgXGfcP+mcoAWtZVYFRewzwJUk4ayML8jiRyA6q8shg6y75YXnl6ojRg8V4lDlF
         54Mra8zx/rZGzds2Xe1Xvh7o7F+LLzImz8iaWfCvcDJL/8Zikm2SFVEC+IOqXB8FeEKJ
         +dU8pMj4WE/PIqccVlxpP1QnsFnbx2lR6GO2dT2NvOgNKWsy2whYxhFRM8scEYGPK8PF
         b9a5wx6YG9yNVNXnj9euVFw2T/jwIgBNASsW0Xwb9wdQjaxSSwM/prew/jl9KlYrr1Ul
         +eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356872; x=1690961672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BhJzvHH17zsu58aRI3qZvsQHAbkxeYw2yyHP54Sanc=;
        b=H0fYd5iFt5ZI3ClMyJ4p9XdCZDlR0Umci4O/fWkrS10tYNRMgTaCFHiDDYuUQue04q
         mdAPuqTh3TkM3S0Y8Pr68CMdQz3WlkjnCo2/+BAK7NDAe9GhkfV2NqPERvVS5JqpPRjp
         ja9rQDcXhdM4UPjTHxZ24vvSreAlTKxP0oo3br5dC82b0Nupru7cLHGTrmtSdY4n9loJ
         a4VzvJ3OG7uT2PILwWUFyy/4scGum9RVKTd640KxXANsNRj8Api6Ggvxz8q57izi+LP3
         pMwG14xDYIX4MOQaYhVJU3Ev6eC95wdJud7pMJTIaXvJMmKRTX0ZQjnEtZn7cOm2vj00
         Jbqg==
X-Gm-Message-State: ABy/qLYRl29IuIKgO7fqVm1EuecNZdEdClXuH1OmcE9ZKL6hMeh7YChf
        GSre+YxM6F+nlxk1jf8dqkizR6v2r2I=
X-Google-Smtp-Source: APBJJlGl34qgAAVwGvszdo6l5m2PPzahQjx8ZCgJ26hsqup5f/uhDqSxNbki4/9PowiHSb3pyVUAIQ==
X-Received: by 2002:a17:90a:7bc5:b0:263:fbe5:2125 with SMTP id d5-20020a17090a7bc500b00263fbe52125mr972070pjl.15.1690356872090;
        Wed, 26 Jul 2023 00:34:32 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id hi16-20020a17090b30d000b0025be7b69d73sm692301pjb.12.2023.07.26.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:34:31 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Fixing check patch styling issues
Date:   Wed, 26 Jul 2023 07:34:19 +0000
Message-Id: <20230726073421.2452-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7 changes:
- Append the actual patches that were omitted in previos end
- Update the v6 changelog
- Reorder and remove the blank line in patch tags
  (Alison)

v6 changes:
- Rebase
- Do the redundant dev_err() cleanup in cxl_memdev_state_create()
  (Alison/Ira)

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


base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
-- 
2.39.2

