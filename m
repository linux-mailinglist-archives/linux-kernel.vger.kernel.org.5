Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5327B7EB5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjKNRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:41:34 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EEA10A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:41:30 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2de8da87so3623071a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699983689; x=1700588489; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLGvE6w2nI/I1UWxr+lpIoR/ViMo1XgqtZtp21yYr4U=;
        b=VpcK59r5CrZ3QCH78240cjVtgXDGWCQH7bfIykn5Iviwllo8QJxqY4dQf3VOgGB51O
         RL6mlFZCTDmoMUwTw/GAbrsx5i3FgDMP/+/ePVchDHCgfmla6bJe0pIq2XGog4s5vSSr
         E5qA1jpbug7T8h05bcUjW2u2lR8eHdicnFicQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983689; x=1700588489;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLGvE6w2nI/I1UWxr+lpIoR/ViMo1XgqtZtp21yYr4U=;
        b=IZC0DxPMoSuuniNJCPzbk2npf9VgF874U07y0GdhCRL0z1yYZ9rncwfofQZq4Cblsv
         2ZTqA7WkV4npI5Shyp5u+ubx4B7YOScmgD0OdTcYPeTQs5g0VznTWJMehvn7Zad9UU2z
         4AqKIAUMh5kQtq6EpzXgwZPb/w7bC1G3bCp0JC0fgjP8zeqor1X+21wBVNgWcFFnNlH9
         Msu6JuTqf/PV1LZbl9pd4ZeLtTvcQ6YzLchVwfxnscbn0pmiz6ax4ZbJ3+lTVG4kkOkN
         ureTYfem+wO+o8LWqLQQONtLRun2cM2H78UadCV2VABE0pj92sL58AKRMDN+p1WZEo18
         Ihxw==
X-Gm-Message-State: AOJu0YwJXfgwhEiOnk1V3zZ6Bk3jt+nmpDsI6D4q/B4Es9Gi9ed8ncUU
        GNa7wHC6j425B2jK3YuIOXUJ8Q==
X-Google-Smtp-Source: AGHT+IGJzqjH4yljoCElrUZVFhXFzpSL5gTIxu5k3uXhgG3mqXWu6aooLTEXVEWJO+CRKYVvjAIkhg==
X-Received: by 2002:a05:6830:41:b0:6d6:4557:bb2 with SMTP id d1-20020a056830004100b006d645570bb2mr3148326otp.30.1699983689582;
        Tue, 14 Nov 2023 09:41:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 37-20020a631365000000b00578afd8e012sm5838502pgt.92.2023.11.14.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:41:29 -0800 (PST)
Date:   Tue, 14 Nov 2023 09:41:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bill Wendling <morbo@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Konstantin Runov <runebone1@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening fixes for v6.7-rc2
Message-ID: <202311140940.5D358293F0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these small hardening fixes for v6.7-rc2.

Thanks!

-Kees

The following changes since commit 9cca73d7b4bfec75b2fcef751015f31691afa792:

  hwmon: (acpi_power_meter) replace open-coded kmemdup_nul (2023-10-24 14:10:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc2

for you to fetch changes up to 782ce431613cf08c3a00dca42ad925c3b1108d09:

  gcc-plugins: latent_entropy: Fix typo (args -> argc) in plugin description (2023-11-14 09:32:47 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.7-rc2

- stackleak: add declarations for global functions (Arnd Bergmann)

- gcc-plugins: randstruct: Only warn about true flexible arrays (Kees Cook)

- gcc-plugins: latent_entropy: Fix description typo (Konstantin Runov)

----------------------------------------------------------------
Arnd Bergmann (1):
      stackleak: add declarations for global functions

Kees Cook (1):
      gcc-plugins: randstruct: Only warn about true flexible arrays

Konstantin Runov (1):
      gcc-plugins: latent_entropy: Fix typo (args -> argc) in plugin description

 include/linux/stackleak.h                     |  6 ++++++
 scripts/gcc-plugins/latent_entropy_plugin.c   |  4 ++--
 scripts/gcc-plugins/randomize_layout_plugin.c | 10 ----------
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
Kees Cook
