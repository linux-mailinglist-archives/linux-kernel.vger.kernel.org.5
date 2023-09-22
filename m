Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A77AB69E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjIVQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIVQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:59:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A330122
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:59:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0c6d4d650so21177315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695401943; x=1696006743; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgApR4QKR0jTTIWGbZED9KyQ8+ob7E8gjbpmfglkOS4=;
        b=By1U7SEWbR+JttBpZqs5RCKlg3WBennOyEICh29yud2CTEiewcdgSdWagQ9HSw7wX1
         cEKcjGvJnxcT16oU1kK+1j4wVzbMkzLtROj3ZKO3QI6IZ5dCfW9MNNzwIYjR/YX+xNm5
         MUHn0MQFKuE08BNWY/K6wW+3S8IIPN5hL33uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401943; x=1696006743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgApR4QKR0jTTIWGbZED9KyQ8+ob7E8gjbpmfglkOS4=;
        b=X9vaagQf5I21pMzYMVv8iDwtddvhmQDGMcsnDsaoD/Tr+GSDeervDfkHc27pS80bvA
         SBzmW7tVCYbHMRwmGqRWwY9pvAG+Gmh0HN/Z3Q4QDuUqJ3jiH8HyiiTX+RBh4DU9KvOs
         6GOI+L6Cn8+APCBt/pENrVRybjIhjv8QwJ5IDFqC1jJN8Bfom8o0UaqAjTK5vZjks71K
         nVitAOvxGXFGxbFyeUG2jwg84rcmEdrDTi8yjjb8SmptHkVx7oyPKHEHHJphAfNk9JUL
         J/ptt5G/2HN6o5R7lJ2/n3dDpINMkFoZADo5o4XTGawDmH9Y5cddoDs7fvRLW2u+c4UV
         o+Mg==
X-Gm-Message-State: AOJu0YxyAbxQwrVukuWfoCTg/toF+4lJXfeUUOJ4PXTNfIqKAko+Dur5
        /8jeRG7HaPNjq/q+fK6FnNMEyumWU6DNwBsRuIo=
X-Google-Smtp-Source: AGHT+IGGPPEfgAcFyBWncry+JxYQRZba/6D3PSasaxIUyd208w/7AiS/EpwlAcoyUp/cjsIZ0Fdbww==
X-Received: by 2002:a17:903:2442:b0:1c4:375c:110a with SMTP id l2-20020a170903244200b001c4375c110amr27448pls.19.1695401942810;
        Fri, 22 Sep 2023 09:59:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001c57aac6e5esm3728308plx.23.2023.09.22.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:59:02 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:59:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] hardening fixes for v6.6-rc3
Message-ID: <202309220957.927ADC0586@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening fixes for v6.6-rc3. These have been in -next
for a week now.

Thanks!

-Kees

The following changes since commit 5f536ac6a5a7b67351e4e5ae4f9e1e57d31268e6:

  LoadPin: Annotate struct dm_verity_loadpin_trusted_root_digest with __counted_by (2023-08-25 16:07:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.6-rc3

for you to fetch changes up to 32a4ec211d4164e667d9d0b807fadf02053cd2e9:

  uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++ (2023-09-13 20:09:49 -0700)

----------------------------------------------------------------
hardening fixes for v6.6-rc3

- Fix UAPI stddef.h to avoid C++-ism (Alexey Dobriyan)

- Fix harmless UAPI stddef.h header guard endif (Alexey Dobriyan)

----------------------------------------------------------------
Alexey Dobriyan (2):
      uapi: stddef.h: Fix header guard location
      uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++

 include/uapi/linux/stddef.h | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
Kees Cook
