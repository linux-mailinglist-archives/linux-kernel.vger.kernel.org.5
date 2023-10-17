Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8ED7CB76F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjJQAfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:35:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F192
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:35:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694ed84c981so3977635b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697502920; x=1698107720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=965htGTr4iAy8JWuVwp19hRsc2Rq/cl5JVFnASD2LSA=;
        b=MYQZ003/94vYp7HM1UqLbK6ZqoqH69O99lt8NbIZrXeNlLaiJifIwdiEtiPVFbeyNG
         ZBHxrKspKkuocU1oYtwtYVOTvm9SM05SA18nZcVKdYayoUjNcTEO9EXooRFwymyRzh3G
         IBP3VMp4VtfFMZLomjavPpJT5xSmtDYwS/zpp32OBvPbqg6is3Pk06inFSeamVtOzVDh
         SmLlmL8BJoXedQB0UWzHuQ6/4cg3nEP7CCuEgrV2VTNwPmKYJ7M491BBYQgxBgoG9Lib
         /QgdywbS95niT2gWvCcrqSNkq4iMYjpXuKQx4lRVr8PNh7Vz0sIzn30bE9XotzekiLTG
         9FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697502920; x=1698107720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=965htGTr4iAy8JWuVwp19hRsc2Rq/cl5JVFnASD2LSA=;
        b=UwPKFiOyJCXp8hZoBcf8+7VEgW0raW8qYP4lfG8QZ9fJ6s6bkEE8wRnd3cAdUstkvS
         mWvPGODdsnysi/QIhGY0gJkcqz7m7yG6RNFeRwARlszsspvRCdQQ9ch3xEcGNag0t8cI
         1heemEW6r8P7Bj7JqOHf2aoUrcMIqSrlDY1Hm+nXgfglVlDvH65vCOeD3SZuOWs7TfbD
         21hW/jdtiy0ilzhuyOJqO6PMiSmDRBA5skmfcsYANDE3abRYqpb3wi9JkmCJUlyXv2RX
         93JqkquxS5wxjzH5NCuM6ulkz0yj2Va2skSbBJ3MZaxPKDg5abLUgcELFXB9plPecHrT
         oAng==
X-Gm-Message-State: AOJu0YwU3u1rZf1Sn5oHgH0YnKNGubDm+79Mek54MCGEnSS/RGGXbzT1
        BQWGalIogfkv2/Qbj2g8bew=
X-Google-Smtp-Source: AGHT+IElhOeMnJVKNR5ydqILwBP6orMU80/VrnvIVlK6f04yPLgWHamqxk7g7NTvR2mgwowlCrlJUQ==
X-Received: by 2002:a05:6a21:2c94:b0:160:8984:6cc6 with SMTP id ua20-20020a056a212c9400b0016089846cc6mr537928pzb.58.1697502919875;
        Mon, 16 Oct 2023 17:35:19 -0700 (PDT)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090264c900b001c61901ed37sm207894pli.191.2023.10.16.17.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 17:35:19 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz
Subject: [PATCH 0/2] minimize swapping on zswap store failure
Date:   Mon, 16 Oct 2023 17:35:17 -0700
Message-Id: <20231017003519.1426574-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when a zswap store attempt fails, the page is immediately
swapped out. This could happen for a variety of reasons. For instance,
the compression algorithm could fail (such as when the data is not
compressible), or the backend allocator might not be able to find a
suitable slot for the compressed page. If these pages are needed
later on, users will incur IOs from swapins.

This issue prevents the adoption of zswap for potential users who
cannot tolerate the latency associated with swapping. In many cases,
these IOs are avoidable if we just keep in memory the pages that zswap
fail to store.

This patch series add two new features for zswap that will alleviate
the risk of swapping:

a) When a store attempt fail, keep the page untouched in memory
instead of swapping it out.

b) If the store attempt fails at the compression step, allow the page
to be stored in its uncompressed form in the zswap pool. This maintains
the LRU ordering of pages, which will be helpful for accurate
memory reclaim (zswap writeback in particular).

These features could be enabled independently via two new zswap module
parameters.

Nhat Pham (2):
  swap: allows swap bypassing on zswap store failure
  zswap: store uncompressed pages when compression algorithm fails

 Documentation/admin-guide/mm/zswap.rst | 16 +++++++
 include/linux/zswap.h                  |  9 ++++
 mm/page_io.c                           |  6 +++
 mm/shmem.c                             |  8 +++-
 mm/zswap.c                             | 64 +++++++++++++++++++++++---
 5 files changed, 95 insertions(+), 8 deletions(-)

-- 
2.34.1
