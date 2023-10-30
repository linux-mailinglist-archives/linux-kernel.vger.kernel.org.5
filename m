Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CB7DBE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJ3RFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3RFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:05:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4CB3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:05:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9d407bb15so42106245ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698685544; x=1699290344; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpoK82vM9+w/LO1csF/zKyyZK4DZcstBZkP+dk7Q69A=;
        b=daod1jcdSBBp8Z9RVw0KCShaHIAdQch/3gQZERGBytUvkRa+icNErulVz3SWBV+jtn
         y3oihk17+oCixzKuSGWb0v6Bn1OvAFU4quImbVfmgMhDBEYh2MYxMOCWIpCW0vnaWer5
         yskcTJOlP79oP967KJZZ2OabF0nofCjwSr1aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698685544; x=1699290344;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpoK82vM9+w/LO1csF/zKyyZK4DZcstBZkP+dk7Q69A=;
        b=hAl0dZlOqrlBup/iKkDLnT9kyL+vkbl4Ut1YC5CVaxuJbK0BxNMjNcrusFXPVdsEgL
         StzmHHgILv6sglBoVH24DfCGAgf2PNNFv/FK2KWjkk2m15J3pMID12rskS4KYjm6NCUH
         LXS2LlZBuVGg9ReepbqZ977aWjOotFXXz8fMIVGTtTu47YCV/YLM8CwgcaOw0N+9Ud1O
         HJQcrKz7+fYQa6R772TOg/I/Lo1gAeOo8gT3PeStg5LIFguovlz6rvYxG4EA14CztDiT
         D87n6UTN+P0Ey2k14EqzHLPp1ReItog9u1JLmbmRiHBJlu0C8EcSebRiWNTJVX3/Y5hW
         vB4w==
X-Gm-Message-State: AOJu0YxQCeBXSB14eJ9n0sYysfw3qXMdpl/RZrcqP7CVapUDJ046ggS9
        g33ViYglkC1ktrLelpCP354lSJec/yBBmvYtj60ZuQ==
X-Google-Smtp-Source: AGHT+IG0UEt3dnfoBAEhkoMtdSGOd6b2sJDUQcQrf+yl8y0yhmP1mC5IvP9sKtvBBRR28WXukL+GVA==
X-Received: by 2002:a17:902:f1d2:b0:1c2:1068:1f4f with SMTP id e18-20020a170902f1d200b001c210681f4fmr9600777plc.17.1698685543679;
        Mon, 30 Oct 2023 10:05:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b001bb99e188fcsm6501434plg.194.2023.10.30.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:05:43 -0700 (PDT)
Date:   Mon, 30 Oct 2023 10:05:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kees Cook <keescook@chromium.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [GIT PULL] pstore updates for v6.7-rc1
Message-ID: <202310301005.D5CF8F730E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these small pstore updates for v6.7-rc1.

Thanks!

-Kees

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.7-rc1

for you to fetch changes up to a19d48f7c5d57c0f0405a7d4334d1d38fe9d3c1c:

  pstore/platform: Add check for kstrdup (2023-10-12 09:47:01 -0700)

----------------------------------------------------------------
pstore updates for v6.7-rc1

- Check for out-of-memory condition during initialization (Jiasheng Jiang)

- Fix documentation typos (Tudor Ambarus)

----------------------------------------------------------------
Jiasheng Jiang (1):
      pstore/platform: Add check for kstrdup

Tudor Ambarus (2):
      docs: pstore-blk.rst: use "about" as a preposition after "care"
      docs: pstore-blk.rst: fix typo, s/console/ftrace

 Documentation/admin-guide/pstore-blk.rst | 8 ++++----
 fs/pstore/platform.c                     | 9 ++++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
Kees Cook
