Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A97671DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjG1QeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjG1QeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:34:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD863C35;
        Fri, 28 Jul 2023 09:34:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so25692525e9.3;
        Fri, 28 Jul 2023 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690562044; x=1691166844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT48dgkldoDe9AzLyWANAP5X6Ur3eOt79TKT0p646Vk=;
        b=PL7k9y3SFFBii4fOawRir/gNsBhgbmvRm1vXGV82Iv3o+8onTo+KviHDLgN9ePrPtc
         BCP/28c8Ns8g2K32B32sQk4KWPcO14CFDFIt3mRSEM968IMz2Cf1Oao0FuLWHk608Y5S
         WVgp8DiUJ8084mJfE66rHtcB5d4EnJFXB+zIHFlEsxjCTXl9VQjUnLuZjOeAib/2bo6t
         U0pmoG5xA5aLOvArdDS2acjKJRd6dmKPsaPRz5IfdEkUTZqVJBXzPWn1zjv4BBfWCiCQ
         Z0/K6YUch95zkp1xPzuXuJSBi5MfJXUFglnyNFpnahbri3/hKzTgS4QcGabmhd7mSOoC
         Fa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562044; x=1691166844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WT48dgkldoDe9AzLyWANAP5X6Ur3eOt79TKT0p646Vk=;
        b=dFPU39p7c9J8l81FDoc+ZasYqVV2cj8JVAY3Rf9E1ZmNH/8uIv+qGbSC9jGd0Y6uOs
         oq5qvHyIKM9whlLl7KZFXdL+n26e6iZzzKFUg7B6V9sQ6uo+ncL3OLjlgvF8UGDpRNfe
         iRGM8ajr0NTq1ChgzNEFqHqhmn8y0grd1oiEOQVQNTQM/C22m2fGTBgEgNCnukfYLF6f
         /hJbsKUR7j7CscDCORF8WPGIaQK2NaDwKFMxLSJRHzkDIzM73ApeqhIqD6T4Y4S4b/Bu
         stIFizClEeiiTW5/FExWVt9GphwfHj55CgGuEuq2rmw1T9ERtmNUgSAASVdzWBCyEM/Z
         N0iQ==
X-Gm-Message-State: ABy/qLY39TAjvRNKCBaFarohVlubgPw3KuHwDAZ0qEvggnhsNGkd+TwB
        TW2hBNmg/2pOcnpwnEi4eORnzVJbF+4=
X-Google-Smtp-Source: APBJJlG76OulxNjUSTZC57LQsWop4la3xga6beCk2Lcd+WxGXQ7miBnEIJPq6t/f5FxFAyIx/b6cVg==
X-Received: by 2002:a05:600c:285:b0:3fa:97ad:2b9f with SMTP id 5-20020a05600c028500b003fa97ad2b9fmr2317986wmk.16.1690562043714;
        Fri, 28 Jul 2023 09:34:03 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id z24-20020a7bc7d8000000b003fbc681c8d1sm7388179wmk.36.2023.07.28.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:34:02 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.5-rc4
Date:   Fri, 28 Jul 2023 18:33:46 +0200
Message-ID: <20230728163347.176178-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc4

for you to fetch changes up to 588159009d5b7a09c3e5904cffddbe4a4e170301:

  rbd: retrieve and check lock owner twice before blocklisting (2023-07-26 15:08:21 +0200)

----------------------------------------------------------------
A patch to reduce the potential for erroneous RBD exclusive lock
blocklisting (fencing) with a couple of prerequisites and a fixup to
prevent metrics from being sent to the MDS even just once after that
has been disabled by the user.  All marked for stable.

----------------------------------------------------------------
Ilya Dryomov (3):
      rbd: make get_lock_owner_info() return a single locker or NULL
      rbd: harden get_lock_owner_info() a bit
      rbd: retrieve and check lock owner twice before blocklisting

Xiubo Li (1):
      ceph: never send metrics if disable_send_metrics is set

 drivers/block/rbd.c  | 124 +++++++++++++++++++++++++++++++++++----------------
 fs/ceph/metric.c     |   2 +-
 net/ceph/messenger.c |   1 +
 3 files changed, 88 insertions(+), 39 deletions(-)
