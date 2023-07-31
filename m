Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11226768D37
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjGaHKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGaHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:09:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893630F6;
        Mon, 31 Jul 2023 00:08:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso28260395e9.0;
        Mon, 31 Jul 2023 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787265; x=1691392065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrTsz8QawI4NoHoGnNEcszB2yjFUPV7z0R4z7qGc2Tg=;
        b=cMmkR/Nw8pe8AaKpbaRL9SRljMNQBv8XEvvy+xwdGDc8CoC16Gq1t8q9XujyqUD/ZV
         CUgid/Kb7nQkFFOoxbmNtkMficwKnJFW84MToIfcNr4PKT+chcVnL2hcP4DGV+QgLFwB
         8LjSwkGKTQ4OAfxSKEQ34VPvLWjkx8jycS70ciiudM8pbgACJuS2d0t0Kral8K9qcYLV
         pXeoexF57S6kZAKrr6mCo8zX2mAx/9NLP5iKEBfZqEoRHC5+ZUmeWPoFPkHX6Q7GVK2G
         l93oNndBLwckSonT2e3EDf/TfD3b4rCDyKAseHe3FD3gqJecPNGzhDsKXcrTSwBgDPIg
         cw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787265; x=1691392065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrTsz8QawI4NoHoGnNEcszB2yjFUPV7z0R4z7qGc2Tg=;
        b=jZuapdHVeUeUQxoUH6yusp62cAZtbbr9j685rE7yZ6ZpOywHZWoM/mWkt7uHmxKpni
         NIifse6HZ3coT2hDCIHhGgfd/XUSqHsgzPiLYM46bv5jqMceEnEafznQ29/YuqAhQhNj
         JX7ILHUCsLU2wrDRWqYPYpddxgnSp1jhnAyo2VgTLxi0+PaIm1jFPlG6ifDLtv3dlHNO
         +TD3AhBt9YO79pmZSa8Mojm7U8AzniAJ0H0Cr/o14hzdOU6bqf6G5N5SBzW9SfoxkRdz
         YrVzQZJ/k6Y/q8zj0mEx8Zyc7hAt1SgJomRmvQmg8XGB3ldr4cg/bBvXyZVBUyXA1lAD
         NdlA==
X-Gm-Message-State: ABy/qLZlxQt+cWgCTe2yFIcvjjb9dpoYGIc05A3/ai5F5pTDmv8gM2MQ
        +Ug8twcvFaw9PCUVpX76+04=
X-Google-Smtp-Source: APBJJlF2YjxFQlhdr/gdJJSW3Aeoej8UVQHl6XofWSLbtf0ibd+hIaZrJHGyDSVNaUsCo46L6b1LYA==
X-Received: by 2002:a7b:c44a:0:b0:3fb:c060:9698 with SMTP id l10-20020a7bc44a000000b003fbc0609698mr8041465wmi.5.1690787265337;
        Mon, 31 Jul 2023 00:07:45 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.65.235])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b003fd2d3462fcsm15114098wms.1.2023.07.31.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:07:44 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, alison.schofield@intel.com,
        ztarkhani@microsoft.com
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 0/2] lsm: change security_capget LSM hook
Date:   Mon, 31 Jul 2023 12:07:30 +0500
Message-Id: <cover.1690786466.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Change security_capget LSM hook's target parameter to constant and split
cap_capget decalration line to multiple lines.

Khadija Kamran (2):
  lsm: change 'target' parameter to 'const' in security_capget LSM hook
  lsm: split cap_capget() declaration to multiple lines

 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 7 ++++---
 kernel/capability.c           | 2 +-
 security/apparmor/lsm.c       | 2 +-
 security/commoncap.c          | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.34.1

