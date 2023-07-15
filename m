Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1511754BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGOTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:51:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB41B6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:51:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso28021335e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689450679; x=1692042679;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4GbW45t2bxRqivhDRu5jFgHelCXhxmoAea6VVpAeTN0=;
        b=OkCSid7w3zQ8n9XG+ty/DBDeXbbHXgFbTU1GzROa+YeHcrLizyat7fs4fyJJUrTRNE
         idnyHoxq3aemDupzHnxC3xC0WM6w9e86klwGP60qVAJUdrwvNGaKtAkb+B1zUmCtP30A
         LpmBCK7Ojy6xNLX5PZMYhMieP41QRhiAkuzmj+/0OO7hkJZu9Zxi40oPHfQ6+AtKjWGr
         K1xxA0EETGR0QPIYBEBKaSIVtxEQ8jvmeKOTKh638LrenmdhgSZ2QoU39RY1IXfdCsWt
         8gZxMTkp2OE72B2ax1rz0Bze7LPypWXRbLHeSdTWetPFfGARkUdTITPD0cP/UlinEx4M
         i4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689450679; x=1692042679;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GbW45t2bxRqivhDRu5jFgHelCXhxmoAea6VVpAeTN0=;
        b=K9CKFf/kItBk4qZ8H3GtxQCRBanFF1BqhjY0/2a99DYgQwHt/NTtwWG/qH47Dhewai
         i4RfzStDKL0X0naGpI3IKv5kAW/GrOpyksj51I033kDAw5V3NgDX+sxcCGwEcV9FfBOa
         En1z9fnQfUflmbpBziG2ghw397z7NOP0y2Iy2/kRM8SwkwXxJ0MwgMA5LTzkzy7HKh6U
         KGs3vN+khMep8wdSycpzUKRIRTz91uUy8EXCnmnFzNzNJup8DBgD3HWO1zMDEKUchJng
         PHgfEAbqyiRcH1NSh5GIwYnXjdO6BswWwNGUEWowSmeBSGHpmcjKv1vNWVFwQe5fy+65
         SJSQ==
X-Gm-Message-State: ABy/qLZdIhHK27IKXSFcKmFT5iDZbmd9CWqAL79P/Z7DwlpdBXgTmRLi
        TmzqiAsuuPyXUmkBpas6cI4cArdK456LlKoV2A7Ny+IQ
X-Google-Smtp-Source: APBJJlHqWVTA+9SG6L77IdZXuhu7jmxz21Mewb9S2j+9MVzrKtg3Ph7sd0MG4SdT1vjP+iei0u7gfmSKA4MAjQA89kA=
X-Received: by 2002:a05:600c:290:b0:3fb:a506:5656 with SMTP id
 16-20020a05600c029000b003fba5065656mr6250570wmk.32.1689450679159; Sat, 15 Jul
 2023 12:51:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:de5b:b0:290:25e9:9dde with HTTP; Sat, 15 Jul 2023
 12:51:18 -0700 (PDT)
From:   Budi <budikusasi@gmail.com>
Date:   Sun, 16 Jul 2023 02:51:18 +0700
Message-ID: <CAH0GyZD4GkpYaVXNNkiNmBNs1HwFdR36Nwm3MbXJzoFPyfvKQg@mail.gmail.com>
Subject: Anyone help in a sudden build error
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used to be perfect for make to build/process module but suddenly just type:

$ sudo make modules
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
make[4]: *** No rule to make target
'/usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include/stdbool.h', needed by
'/home/budi/Downloads/KERNEL-linux-6.3.9/tools/objtool/libsubcmd/exec-cmd.o'.
Stop.
..

Anyone please help shed a light what actually it is
