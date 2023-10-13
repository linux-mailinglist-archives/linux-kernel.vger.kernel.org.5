Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFB57C802A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjJMI0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJMI0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:26:45 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E83B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:43 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57de6e502fcso1000376eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697185602; x=1697790402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=reNApFY+y/nEKBVj6jhBlvKWFZlo0eMfbeufoLG6DlY=;
        b=aEBrXLRKbkFxaprLOppBAHTgq5yXAnph8Ym+mi3T/IcRXdLeJkw5t1Xe2cuCx1BoNx
         8bKEBx1OtFqzcgxyapl3bif1UOTqlDAJ0ilUHGC1dSxtItP3DU+4I/PIwFS9NSfziI7I
         GbX81GhNgBW54W3CdSB6GcC3kvw8xwsykCvYGQKd1jv/zyDYjpmloUQCu4XmquWHp32n
         4Rl6URVpB2qdZf8ILyvun5eUgvKQO62pz0wol4Gdm/d5ThHUm2bVJ8c6R6IgkBriUS48
         bzzHA/94AGQp/cWr+uKJB7XzGLvCRrDLb3Nnj5omB9cAEe6d4AlB20U/zwllWCgryJlt
         boQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697185602; x=1697790402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reNApFY+y/nEKBVj6jhBlvKWFZlo0eMfbeufoLG6DlY=;
        b=aoRk0s+3Jz18kmSzru5Oyb1l480+T47C2ifCCMwU/S4Vz3fGC8Ecd+06QuBVjOZgZt
         ZbpkGE8R+sXU0ozVX26b6ypM7fperEUOU8mSudXoYAlWySzzpVrZaYIrre3SpJRhF2r2
         jybPJGljoKHc2b5/KzGKPTCGAHCCHK81vkgnQRpsOWllPTcOTNusptg96p5KyXFnXiBV
         VlHB4Lvf79RSm0m2oUtcEXENalX/n7NEl9EzsfyHHzDdJn1Qqe3Kv9GN81jif8dJu2yp
         mICsE0I21QvQ5lZpdmyllWiwoMOXlxqglYusrh8I6r0vBBPFTYZt/N3gsB4hGA+FhzVl
         ZEEg==
X-Gm-Message-State: AOJu0YzOFQ5pPPRGJ3CcF0IAbot6b0vxMbObCWuLxCg2TENXix3wsRS0
        Wrbu+PyKt9YM7mBVoKfGsyo=
X-Google-Smtp-Source: AGHT+IFJ0JbVkvyz/thqzxydud/CFNHx7HeOr8BQImJa91r60A0h/JVF35oVVJSTifsTu3ApY7l3Dw==
X-Received: by 2002:a05:6358:99a8:b0:141:d2d:6da7 with SMTP id j40-20020a05635899a800b001410d2d6da7mr27248704rwb.17.1697185602682;
        Fri, 13 Oct 2023 01:26:42 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b006933866f49dsm13506789pfh.19.2023.10.13.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:26:42 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 0/2] tty: gdm724x: Fix coding style in gdm_tty.c
Date:   Fri, 13 Oct 2023 01:26:33 -0700
Message-ID: <cover.1697184167.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl raises 2 warnings in gdm_tty.c. This patchset contains 
two patches that cleanup the code as per the Linux coding style & fix 
the warnings. Patches can be applied in any order.

Soumya Negi (2):
  tty: gdm724x: Match alignment with open parenthesis
  tty: gdm724x: Add blank line after declaration

 drivers/staging/gdm724x/gdm_tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.42.0

