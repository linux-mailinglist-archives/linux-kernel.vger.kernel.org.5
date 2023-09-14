Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A979FD92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjINH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjINH4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:56:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854A1BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:56:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66922C433C8;
        Thu, 14 Sep 2023 07:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694678203;
        bh=oIKeAmW3zeqiXvkEC9u99aJZ1TFg4c+R68Gwak9Gfno=;
        h=From:To:Cc:Subject:Date:From;
        b=L+mn62JvoDAM3cT25k3zMyrXV2ycqlO298XauslZoY/s1zVj2078u9M/NbS8dBxRu
         AKuLMjYvhBRGa5ov6n5rhvTwhK3QSamqaa4c+s0bYNFR5glov4xjuEmOL3n/AZ8eHN
         XZofqJ6ZEjakGD8oOOOhqzQ+AoXthJUkOwfT6UwZ7wVKdFqXV3QTqfn3BQNqxBrkKI
         tXTFwfp0kpBW6wKVFKR31HW/RJ34Rzlln1yWy4D37M1rU7pV9Wq1QUbrGTuZZEXpa9
         4PaFJSyK4MF01sZIYkEs4gMpgXJZgqSP8YsKR04V1SRRYBeBaQKYwD2Gk3jVgiCqrL
         N53RTGTJQFfYg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] memblock test: fix compilation errors
Date:   Thu, 14 Sep 2023 10:56:30 +0300
Message-Id: <20230914075632.9515-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

These are small compilation warning fixes for the memblock tests.

If there are no objections I'm going to take them via memblock tree.

Mike Rapoport (IBM) (2):
  memblock tests: fix warning: "__ALIGN_KERNEL" redefined
  memblock tests: fix warning ‘struct seq_file’ declared inside
    parameter list

 tools/include/linux/mm.h                 | 2 --
 tools/include/linux/seq_file.h           | 2 ++
 tools/testing/memblock/tests/basic_api.c | 2 +-
 tools/testing/memblock/tests/common.h    | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.39.2

