Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D17E2C14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjKFSd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjKFSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:33:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54585D61
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:33:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A7BC433C8;
        Mon,  6 Nov 2023 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699295590;
        bh=fjg8513Gf1d7m4R7gTtM2nG8lVuqIwjwGxcDG8s0rGE=;
        h=Date:From:To:Cc:Subject:From;
        b=kXJxAz0ZAOzKlH/0riw9OGCsKqFeYwupuVkqVF8jmk/eWjs7qfp1Dpx6crQYSn+GN
         /Yg98o/qyyhhZdVDnvH50YLmxZtFsz1YSeGbVAF+drOj2UDjTIMND/gXtDOKGTX49X
         kvUrVk4JzBX1D3vz93q70HbFn+LWE5C6oZsK645agH91Qyy8m6404RM7nJT0sIid2O
         vB25PQ+OQclI+8E7MH47jpjHMeJJEpa7GX2bL0pPJj9hswYWH3Pe23QZktCU+MXM+8
         PYs3JDt+4QwAjzZgMyMI/YGW5HHjvPHdFTiqF3oasaAHvt4D8SzAbwNDv7SRXUYn6S
         jP01wc9XakLcQ==
Date:   Mon, 6 Nov 2023 20:32:58 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock update for v6.7
Message-ID: <20231106183258.GP2824@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.7-rc1

for you to fetch changes up to e96c6b8f212a510c9b22362de519f6e1d7920de5:

  memblock: report failures when memblock_can_resize is not set (2023-09-28 09:04:33 +0300)

----------------------------------------------------------------
memblock: report failures when memblock_can_resize is not set

Numerous memblock reservations at early boot may exhaust static
memblock.reserved array and it is unnoticed because most of the callers don't
check memblock_reserve() return value.

In this case the system will crash later, but the reason is hard to identify.

Replace return of an error with panic() when memblock.reserved is exhausted
before it can be resized.

----------------------------------------------------------------
Song Shuai (1):
      memblock: report failures when memblock_can_resize is not set

 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Sincerely yours,
Mike.
