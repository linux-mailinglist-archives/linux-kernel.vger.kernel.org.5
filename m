Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159E4790208
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbjIAS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjIAS1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:27:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FF19E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:27:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c22103bce7so17499805ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693592834; x=1694197634; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jgmTWHniYT/n7g/74rxfaCQq/pUUq65xnPHgaPGXxM=;
        b=lmS/SJGGOSsUzEZlNUcZrzJ7yHoXoPOhYYqwbzGxm7AYhxyfEV6iOYpqsmtgaa7Jb3
         VKeRnw/6V9U9nOSYzSjOS0wouvaxzWxYQfmXj3wPYZS1o4Y73+r6x/QfBJ69FIAQmxUC
         MBuTpMK2VKr87jJ5matWfiTOpqNOmJdBpiUnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693592834; x=1694197634;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jgmTWHniYT/n7g/74rxfaCQq/pUUq65xnPHgaPGXxM=;
        b=A7Jx/OukBfzToULLyWo2YE6PHsEfc/OUNffo+dHxmuV/o8URUb7PWvaFJ9Kf2a6dF4
         5niYMz8Bvdw3PITdxHOMKKXpHOcsxa3cBIJsF6T2CMoAKtgMLkxbskI1nmIHdtrvTr68
         T+VgOS3mMz7Qg1+85VoU2I4iTnRo3MkHMo1HfwtGyRb3TLIWuAP/GIog62ZVrAdwCaK0
         0B2X0ISrn6uWHtD4eMC65evQaNUyW1S+QpHf1ozJtd8RebKWCr8gdtp+KHpurz8fAC8+
         KDfhvCgj6fOYxX093yl2Z4RNs0SOQDQcoDr29W4FzJBbxe9zi6t3mPleABjutDo4lXd7
         tgCA==
X-Gm-Message-State: AOJu0Yy8GqPtiHNs6tWgWt5w2yRaDO+Afb+fZikrI/bhCNp03ay3NwyM
        Id1GIO0R8GhBdnNecNE65vUUxQ==
X-Google-Smtp-Source: AGHT+IEWLtz8gOELqyImCi2sIwQNqV9O/ZkMR39VmNTyc5SjTnOaCjupACox7RXb3UYgm6ICfp67dg==
X-Received: by 2002:a17:902:a582:b0:1bc:5924:2da2 with SMTP id az2-20020a170902a58200b001bc59242da2mr3357559plb.56.1693592833893;
        Fri, 01 Sep 2023 11:27:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001bb7a736b4csm3270204plb.77.2023.09.01.11.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:27:12 -0700 (PDT)
Date:   Fri, 1 Sep 2023 11:27:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] pstore fix for v6.6-rc1
Message-ID: <202309011125.B1C2550792@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore fix for v6.6-rc1. This should solve the
issues[1] you saw after the initial v6.6-rc1 pull.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com/

The following changes since commit af58740d8b06a6a97b7594235a1be11bd6aa37fa:

  pstore: Fix kernel-doc warning (2023-08-18 13:27:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.6-rc1-fix

for you to fetch changes up to 94160062396d7e7cff4ed69320ffc5e22d51a0ab:

  pstore: Base compression input buffer size on estimated compressed size (2023-08-31 13:58:49 -0700)

----------------------------------------------------------------
pstore fix for v6.6-rc1

- Adjust sizes of buffers just avoid uncompress failures (Ard Biesheuvel)

----------------------------------------------------------------
Ard Biesheuvel (1):
      pstore: Base compression input buffer size on estimated compressed size

 fs/pstore/platform.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

-- 
Kees Cook
