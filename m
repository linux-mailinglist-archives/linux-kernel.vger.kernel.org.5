Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1362E80C8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjLKL6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjLKL6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:58:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775AD5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:58:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0538d9bbcso40396585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702295902; x=1702900702; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpvWYxjWFurzRqzsLDAXQBY+VL4dQWNhgml/pHM61h4=;
        b=f8ywkz6t0gPNR1DAoI4IAwm0V5AgZ/MDTiAGVeKkxsnivu/tsP5dkjMVU0a17l/DkF
         E1uut5eoUx5PDp1wz8xda2zkpJz5Xzag3GZMyekx+0tweUcZQgI5alc2T1SKI+EZ95dK
         gCxoMtkn/qEf7F5THm+FF6paR3EqXGeyN9NDDaKW1IjCloRaQKMYie7cnnk80S1tEOvP
         JuItzMVqTN1uRGhBGR7uh/UJeo+wPFKdVWdjCglvug5xeIpC4BDmzovGcrbuHD6C/RMH
         lz/YgPvK7YOj/gCdqnvZuf6k0JlICY9cSDg1SW48fefRlDjiWV6BfnYdVtMM8HxkTMa+
         +62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702295902; x=1702900702;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpvWYxjWFurzRqzsLDAXQBY+VL4dQWNhgml/pHM61h4=;
        b=gfikv3Kh7EIYDt0G7bkmEsW71zwFWz4yfXalV+jqlKmuwdVvhxOiktt0ifj1Jnz9Km
         /I2MzFs2hdOJiykNPA8g9LeTdMHmwAokPLvwOsOU1OY2R1R1gGrKX3a33NboQoMqzgY6
         cg6rEkvgqqiKq/DGfrgHx/jKYxk8DDmv0bdG2VDFI7Wnb3f5GgIgBO/Ju3lxzcRANa1i
         uSgLv33t3WGDy7RKlHtS8WxIA0DljgVMMby3w1k+lSFTHzQgdGV3FNcj8LODDmZzqLZx
         wElZl0KK7nuQ0HZ9dQ4KGihEeuUvI+Xb7gb4hVlMzNvMbJJFmCmfs5H5GAm67xSMVvKY
         OjPQ==
X-Gm-Message-State: AOJu0YzSY74IL/LAOfbw7FJ1h1dOmu0ejgfTCeQZ7o7XZrIwruohxgQe
        9dZTVyNE8vVEL5BfR1oWdnnzMSTALMxIC0zYSwo=
X-Google-Smtp-Source: AGHT+IHFPlHWB9wdlQAUWE/h5+IeqqZ6sNNZVSere++9j8M/zONuplMC+AVS+J65oKa/uYbH54j09g==
X-Received: by 2002:a17:902:e789:b0:1d0:6ffd:e2d5 with SMTP id cp9-20020a170902e78900b001d06ffde2d5mr5193351plb.111.1702295902169;
        Mon, 11 Dec 2023 03:58:22 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001cf65844874sm6468291plg.45.2023.12.11.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:58:21 -0800 (PST)
Date:   Mon, 11 Dec 2023 12:58:15 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE kernel private shared memory optimizations for 6.8
Message-ID: <20231211115815.GA616539@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these two patches that optmize how the OP-TEE driver private
shared memory allocated as dynamic shared memory.

Thanks,
Jens

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/kern-priv-shm-for-v6.8

for you to fetch changes up to 225a36b96359aceaa9a6399f2dff99627397e637:

  optee: allocate shared memory with alloc_pages_exact() (2023-12-04 14:48:42 +0100)

----------------------------------------------------------------
OP-TEE kernel private shared memory optimizations

Optimize OP-TEE driver private shared memory allocated as dynamic shared
memory. Both to handle larger than one page allocations and for more
efficient memory usage.

----------------------------------------------------------------
Jens Wiklander (2):
      optee: add page list to kernel private shared memory
      optee: allocate shared memory with alloc_pages_exact()

 drivers/tee/optee/core.c    | 44 +++++++++++++++++++++++---------------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++++++------------------------
 2 files changed, 44 insertions(+), 45 deletions(-)
