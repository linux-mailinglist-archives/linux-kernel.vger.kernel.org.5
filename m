Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F20D776655
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHIRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHIRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6321FDA;
        Wed,  9 Aug 2023 10:22:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-267fabc8465so14457a91.1;
        Wed, 09 Aug 2023 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601736; x=1692206536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIjR8W6W9m2PjIF6D/zUdSvJyC/16Kuu41vIHd7JPvc=;
        b=JwMuT3S26o0MFu1YnQpYmyJ8zusifodLaPrvCM2CMIEy6c8x3Cyysfz8ec9lDUt+Du
         W7FPhUd3+/4kvv7Rm4iySXCjqoL76krBwKid0/DnJb/Nsci2DiH7rps/isqXLn7lBjSO
         meYEdpded60oz6uV8W06np3tYe+aHSLbghC7MxYrevY/W8nNDh7sy2g62iZ3VK9Ug/9g
         ziCjfPO+dO9exGGvvzutrIzk8ia98yUrYJMd3qM7Ct0i2ApiTuT9FyQgxn4US2gwe2lL
         qydkdLTPdaHSTgsIpQ808L5nV2gxZ1bh+Gn5ijfr0V10S6NwFEerFBEqSVBLVsVpBPQ9
         NIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601736; x=1692206536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIjR8W6W9m2PjIF6D/zUdSvJyC/16Kuu41vIHd7JPvc=;
        b=Re2beGX5bnbJpenlDXRV1yQcl3dh7WDxo5oBEJItl5lj0mrdNCdMm0L3oS8OXY+Lxy
         /39Apy7pElmyR8m6wZQd8vWU9B1hgfUd0IADjDsQFOBzCNdtqkdy+/5yY32Cxa8mjOdW
         ehIK8CqvTn9dnHnayF7TBmxfZ9nM4acNzlO6qRr0K8JUmxMCu6c+PPz1C57T/C+xCDta
         E3uzz9VmPHOaHHbH5s81RUwyOOIY6JNCupviPPzpI/BXZ+Od2iu1MIXASNgcIFWzpe7V
         aUfc6YTuQVJeyu1Rh10IlOZKUyktkhLSd19Fh8BU9saZMpCvOouqgSgVgomlmRksZadn
         yY9Q==
X-Gm-Message-State: AOJu0YyWcah/yfwoKM7odfgn7oqrmsCuZmt0lD8dgS48s7cVywSw10Be
        5TsC8iky4eECc74ZMF9fwtU=
X-Google-Smtp-Source: AGHT+IEfX5/J/lCT1a/VB3u3tZnxIDV0X1GUJb8k3SyRSh0fqkiEI1d6P5SKR9Uoif231VAJ7zlOIw==
X-Received: by 2002:a17:90b:a09:b0:260:e256:27c7 with SMTP id gg9-20020a17090b0a0900b00260e25627c7mr2535511pjb.15.1691601735719;
        Wed, 09 Aug 2023 10:22:15 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:15 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 0/7] refactor file signing program
Date:   Wed,  9 Aug 2023 22:52:03 +0530
Message-ID: <20230809172211.343677-1-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the sign-file program.

Brief of changes in this patch series:

- Improve argument parsing logic.
- Add few more easy to remember arguments.
- Add support to sign bunch of modules at once.
- Improve the help message with examples.
- Few trivial checkpatch reported issue fixes.

Version 9 changes:
- Dropped kbuild related changes, thanks to Masahiro Yamada for all the
inputs and advices.

Version 8 changes:
- Addressed comments from Masahiro Yamada
- Fix the bisect'ability error in patch 2.
- Fix missed out modules_sign_only issue.

Version 7 changes:
- Change Makefile.modinst and divide the tasks further
- Don't do everything from one place.
- This whole thing is done to facilitate bulk signing of modules
- Greg suggsted this idea here:
https://lore.kernel.org/all/2023060155-mustard-mating-32b7@gregkh/
- Thanks for the inputs Greg
- v7-0008-kbuild-modinst-do-modules_install-step-by-step.patch is fairly
big and I'm sorry about it. I created all patches considering build
stability in mind, so this can't be broken into pieces else in the
intermediate commit build will break.

Version 6 changes:
- Fix commit messages as suggested by Greg and David.

Version 5 changes:
- Addressed review comments from David Howells.
- Fragmented the patches into further small units.
Link:
v4: https://lore.kernel.org/all/20230221170804.3267242-1-yesshedi@gmail.com/

Version 1 - Version 4 changes:
Did some back and forth changes. Getting familiar with patch submission
process, nothing significant happened.

Links:
v1: https://lore.kernel.org/all/dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com/
v2: https://lore.kernel.org/all/20230213185019.56902-1-yesshedi@gmail.com/
v3: https://lore.kernel.org/all/20230213190034.57097-1-yesshedi@gmail.com

Shreenidhi Shedi (7):
  sign-file: use getopt_long_only for parsing input args
  sign-file: inntroduce few new flags to make argument processing easy.
  sign-file: move file signing logic to its own function
  sign-file: add support to sign modules in bulk
  sign-file: improve help message
  sign-file: use const with a global string constant
  sign-file: fix do while styling issue

 scripts/Makefile.modinst |   4 +-
 scripts/sign-file.c      | 292 ++++++++++++++++++++++++++++-----------
 2 files changed, 212 insertions(+), 84 deletions(-)

--
2.41.0

