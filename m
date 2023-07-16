Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478AB755490
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjGPUbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjGPUbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:31:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F00E7C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:31:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8bbce9980so22246685ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689539496; x=1692131496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHkwXryw2dwlcvvwPKFDhmyYP7x1rP0KzxApo+FoyC8=;
        b=o7ZwSmFN9GN8zkJ6xkygcjwkBvbOYAxX5SyeKtOHNUcrfWRkhxKdHB7/7PaX/Ji9OH
         hl9bo+VVx0NvaMPB0WewjuTSHu+rcT60EYx4x/H+fiV2Q7Ar1t1fysJbMematMlnOlGT
         GZ+VJqVJJBlJWfEbKuAbhl/GEt6wScBfxShInNYR33Q3I3yfHmL8WJZM9OLDO2ifMzo6
         Z6rKyVmDiXltHierMSOu8Mex4Foi0lK3ZHkaX9laeRRf7oj/joeMErh7iY5IIr6Q6R1Q
         SkS3WbOujeQencMh78hmQyGsDVcOlXyokWbAGcVkSBOM2+rSV9X0K8EqYntyDsxiw+iQ
         yWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689539496; x=1692131496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHkwXryw2dwlcvvwPKFDhmyYP7x1rP0KzxApo+FoyC8=;
        b=hvx6EQPdLfD8SAuQfuB4RoEbBc+dEi1qv3pPWMtfNYscQHGNTmKUwNWgR6JSZSXK7H
         R1IHuSiObTAotF+Lzxpjktczltag3KF9a50pAzULYpHFqYGB+oNphttwxEn8NbB6FYke
         sqvWdZ/zBJ/PDILlyN0A1DAQhpArBht7GlHLuImg36RMZoIkDmO+yjXXhdaIuDaWtrSq
         vI1yTIg4Dn+4rag9ULmshXqrdkAAWnjpQK2XV8jkQM2u0WMtfUmxvMBm9bvDp6gWzKQ/
         L1fKPwobLXOUDL/X7kRye4Pzf5nMRRJS9cGmbHXBDhnEN5rYLSkH87CTGezORS/vWMZB
         O7RA==
X-Gm-Message-State: ABy/qLbvf3dqhtcyj4aWdyVOlVRGj94vdxtyIr16dQBEmN+DSZIHSYez
        uTHcrHevC7ZS+CIjip+Rte5vfL/WdIo=
X-Google-Smtp-Source: APBJJlGALKcID9MvC+uM4zol5/3H6DYgS6VnPyONNRzN1PVop4zRF0o4f2+bqyLBn3/bOTTvuHyJyQ==
X-Received: by 2002:a17:902:db10:b0:1b8:5bf5:543a with SMTP id m16-20020a170902db1000b001b85bf5543amr11232044plx.49.1689539496250;
        Sun, 16 Jul 2023 13:31:36 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:8948:c15b:5c02:ea0])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902988500b001a5fccab02dsm11321427plp.177.2023.07.16.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 13:31:35 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] Xtensa fixes for v6.5
Date:   Sun, 16 Jul 2023 13:31:25 -0700
Message-Id: <20230716203125.1658027-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230716

for you to fetch changes up to a160e9414d8a1747225206558b24d7df513b3c8d:

  xtensa: fix unaligned and load/store configuration interaction (2023-07-10 21:41:04 -0700)

----------------------------------------------------------------
Xtensa fixes for v6.5:

- fix interaction between unaligned exception handler and load/store
  exception handler
- fix parsing ISS network interface specification string
- add comment about etherdev freeing to ISS network sriver

----------------------------------------------------------------
Max Filippov (3):
      xtensa: ISS: add comment about etherdev freeing
      xtensa: ISS: fix call to split_if_spec
      xtensa: fix unaligned and load/store configuration interaction

 arch/xtensa/kernel/align.S          | 34 ++++++++++++++--------------------
 arch/xtensa/kernel/traps.c          |  3 ++-
 arch/xtensa/platforms/iss/network.c |  3 ++-
 3 files changed, 18 insertions(+), 22 deletions(-)

-- 
Thanks.
-- Max
