Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3A76CF3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjHBNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjHBNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D92101
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B44619B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D961C433C7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690984466;
        bh=FJnDD9zyKXrDGdoILBH7XDtM+Ny6pFZhQvI1ffEGhAs=;
        h=From:Date:Subject:To:Cc:From;
        b=sBcX5Y+pot6Oz/kuqSGLrUNAZlWu6G9QIGkUhiRcAOlcMRRXM6P0HxYjdPuFFNy3h
         EMeBmD4kza6jgbbcgSlGqyaJ2yDNDpGQPmux14oCnbjQfeVjalodyFGtt4Y+JlB00g
         AxzcjqLFXFRhbwxD7LW5yqpMLNpI0jFnvClwORT1hek+S92NOqAaeiIhl3q+NLbVNq
         fGLyJNWWVpU+2G0jvQRNQk6gTrZMuC86mkKsAS1QK7gCMgIhMa/q+mHHJhHcMRyUW0
         CfJwRTaZrqJmm1tpWfgIJkLHs+EPvaB2/PqET4h7DCQyvK+FoZ4p6AIForAMJvZTXL
         Pe3QaWbCL1elw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1bf0a1134d6so1675986fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:54:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLaZWn7PyIBCKFXYEDf5c+xY4Q+zypJmg/jLam/t5HkUy8Xew+Ak
        a3Op6jly4lXDQYUOAqSSEpZxe3eHzFaStB8cpFM=
X-Google-Smtp-Source: APBJJlHWRjoWNE2JTbTVLP+M9KIg3D7oYx1fH4tmBg3JGYnZKHXvkH09BJ696xmyU8wOR31fSoaOUsNn2h0mdctvDnE=
X-Received: by 2002:a05:6870:538c:b0:19f:4dc2:428e with SMTP id
 h12-20020a056870538c00b0019f4dc2428emr17154143oan.14.1690984465552; Wed, 02
 Aug 2023 06:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:603:0:b0:4e8:f6ff:2aab with HTTP; Wed, 2 Aug 2023
 06:54:24 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 2 Aug 2023 22:54:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8zp6HW2rA_ivTG9FEOcrOanNLEg0RBKPkNh_2kSS+rcw@mail.gmail.com>
Message-ID: <CAKYAXd8zp6HW2rA_ivTG9FEOcrOanNLEg0RBKPkNh_2kSS+rcw@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.5-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v6.5-rc5. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.5-rc5

for you to fetch changes up to ff84772fd45d486e4fc78c82e2f70ce5333543e6:

  exfat: release s_lock before calling dir_emit() (2023-07-15 08:34:19 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Fix page allocation failure from allocation bitmap by using
kvmalloc_array/kvfree.
 - Add the check to validate if filename entries exceeds max filename length.
 - Fix potential deadlock condition from dir_emit*().

----------------------------------------------------------------
Namjae Jeon (1):
      exfat: check if filename entries exceeds max filename length

Sungjong Seo (1):
      exfat: release s_lock before calling dir_emit()

gaoming (1):
      exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

 fs/exfat/balloc.c |  6 +++---
 fs/exfat/dir.c    | 36 +++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 20 deletions(-)
