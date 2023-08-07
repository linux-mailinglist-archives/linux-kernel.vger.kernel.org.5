Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE173772073
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjHGLPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjHGLPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:15:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80279199E;
        Mon,  7 Aug 2023 04:14:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b643df5dso2864151b3a.1;
        Mon, 07 Aug 2023 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406801; x=1692011601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhGXmtL0Qpe6G7G7Z2rnbE/6crx1iwJDMAPGjsoJge4=;
        b=S7AP62fbMFJOF9aEWvVk3W3e/mx0FEodUpn42wQfSzPMXWK8dUVuSTME8YK8Jcl1o1
         F6B+awy7JBMy9Hgc3YDVbaWFdW/Ym50Zwyxs2CtTM/VHqMvk0kSxUuTDa9Hos7F3gHck
         tpMcEfOStY3BxbMHoz4cfMsC2EmLKTB9b/cnjEdvGz6/1vTQWsDk1IN61ASb3AZNJ0tH
         2y0vK8dbQovSeaFIAPBE1QrE/TWufMZg+d/W/QoFM5+S5Bff/+W2Nhi1ht/O7D6Cwc63
         6qHsnBzmMmHNbhNr2wVaNIawYgXJ2NA3k6ddjPu3DqKN66l8bT4lQMYWb6CDIARRHQPg
         MsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406801; x=1692011601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhGXmtL0Qpe6G7G7Z2rnbE/6crx1iwJDMAPGjsoJge4=;
        b=i+TP3aR8QGpgYPIPupRDg9aLbNr1QY8B3Ylyn7gml7nqoQzkRqvwwTpCA1QNlYnzUl
         BmzDj0Mgp5lMwHIRN77TUvVgdgUjpiblU2JJ0ScH0DaY9HrmGUPqtptUOnaCuNkRz8d9
         kx1liUQqNllu7/hrsSKwAEtkiTwn7NOsVBrFcKaRC1dpKWrbcpQj1b7qEFsXLwNKj4uR
         DZ2s1ntI4cvGz85XdxA3Eqh2a/A8BxnYcxdXbcuL3dcXorarCCxVgy502mqlXyjB5Dqd
         G7eHTgdSfBJlxwwQU7ksB0Wgpg1Zsg91v5gsn8JheY2tHaqsOdByGVuMxLWhnEIPCJ0M
         Kdbw==
X-Gm-Message-State: AOJu0YxU1OVSOvUMwfYElM97TF5FNsyDhK1JTIddD3xe9zyEpaJHXa5m
        kdDq7BKGNwZm/IaYOIiEr8C8EFasaPk=
X-Google-Smtp-Source: AGHT+IEd63tE4kf93xvvS9qkitwIlGvoP5jnEd1UUYwL08Dfh084BVwZm24KaKwP1HnDsLMVvPksiw==
X-Received: by 2002:a05:6a00:851:b0:681:3ed2:b493 with SMTP id q17-20020a056a00085100b006813ed2b493mr9008987pfk.26.1691406800707;
        Mon, 07 Aug 2023 04:13:20 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 4-20020aa79144000000b00660d80087a8sm5939173pfi.187.2023.08.07.04.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:20 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v8 0/8] refactor file signing program
Date:   Mon,  7 Aug 2023 16:43:08 +0530
Message-ID: <20230807111316.315836-1-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
- Divide the modules_install task into sub tasks

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
v3: https://lore.kernel.org/all/20230213190034.57097-1-yesshedi@gmail.com/

Shreenidhi Shedi (8):
  sign-file: use getopt_long_only for parsing input args
  sign-file: inntroduce few new flags to make argument processing easy.
  sign-file: move file signing logic to its own function
  sign-file: add support to sign modules in bulk
  sign-file: improve help message
  sign-file: use const with a global string constant
  sign-file: fix do while styling issue
  kbuild: modinst: do modules_install step by step

 scripts/Makefile.compress |  53 +++++++
 scripts/Makefile.install  |  66 +++++++++
 scripts/Makefile.modinst  | 106 ++------------
 scripts/Makefile.sign     |  37 +++++
 scripts/sign-file.c       | 292 +++++++++++++++++++++++++++-----------
 scripts/signfile.sh       |  24 ++++
 6 files changed, 397 insertions(+), 181 deletions(-)
 create mode 100644 scripts/Makefile.compress
 create mode 100644 scripts/Makefile.install
 create mode 100644 scripts/Makefile.sign
 create mode 100755 scripts/signfile.sh

--
2.41.0
