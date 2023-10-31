Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6547DC3AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjJaAiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjJaAiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:38:19 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276649C;
        Mon, 30 Oct 2023 17:38:17 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5a8ee23f043so47660887b3.3;
        Mon, 30 Oct 2023 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698712696; x=1699317496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLpCc3PyWTTTD0AKPiPlElmu9sH8xImon2sau71Xr/E=;
        b=M7KZgcrGvDefdZFYzvyWdgQWXfnlYilAMI6RcSoMx0uZVrVVMGORCvb3JTvdYOvURQ
         7HwYQe4qXJRmaTQLhLXV90GF0g8TOtpzuz5uzeWuCbPg7wHvOlum8sJJcyQ6OMZk2uAB
         YIr7Un7LlB7JS+vtCHleujCvreiDf3Fi4O8swiTJBtUQ2l3S/rPLCVTb5Pa1TEGUJITK
         k0rK2fvU8iIzF3wNjQnbH17XNRBeddsLbTj5tp+BciMoGfpRqEs1gYYWyCoYKYO2vK4b
         5WO7bDXRzvsO4lyPuX7NUHPE1Q4iMBSllZDI/XuYKObnEUgdqct2T887oNEd+2RWFuoG
         qbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698712696; x=1699317496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLpCc3PyWTTTD0AKPiPlElmu9sH8xImon2sau71Xr/E=;
        b=IKAm97+zyHDNJJNGBDYz0Z2K0MN9gvXIaB3TbH7a3h3yLmF8mT2IRLdRUDicTFYy7b
         SXnBGjuu4dHAwCGxPvojA6KoLBkOiJdRytWNQsmhDqqnanlrCVcvhIvxxA9ElHzvCz6C
         K66Ho1AvjjmqgTpXzNuCV96z0ruJLNb0wx0aTw1N7Fxqo7axHx6u/4J0wAVV/OEbb+59
         j6EC159mpVTqRpANkoPnGRxQvKNN3lTCmDvOwb5+PwxZqnWcHLbYcvvFxS6YD4xFMT/T
         aM96FJpKFdaXCr4R7ObQQnMH+NYbmT2qO7+tO7Yhmi+fx+nGaMKL34S6vq+sx/wn3ONe
         mUTw==
X-Gm-Message-State: AOJu0Yzo/CgEAiZgFQYqOZBqn8DGPYz6SQUUu3cEGh0Vg7oCXpE6bnzg
        7Ck6N+gp4Y0WshxP6N5Jj4aL+8L15LAC
X-Google-Smtp-Source: AGHT+IG6TgaDvVWkgXrMoVTwaJlU2gSdyzoxReWXHWwJSUYAaeuuyocGk5Eo93eo9OzmgpOqIZtQtw==
X-Received: by 2002:a25:50d0:0:b0:d9a:4839:68fe with SMTP id e199-20020a2550d0000000b00d9a483968femr9952161ybb.43.1698712696084;
        Mon, 30 Oct 2023 17:38:16 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm182750ybj.50.2023.10.30.17.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:38:15 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        hannes@cmpxchg.org, tim.c.chen@intel.com, dave.hansen@intel.com,
        mhocko@kernel.org, shy828301@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Date:   Mon, 30 Oct 2023 20:38:06 -0400
Message-Id: <20231031003810.4532-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements weighted interleave and adds a new sysfs
entry: /sys/devices/system/node/nodeN/accessM/il_weight.

The il_weight of a node is used by mempolicy to implement weighted
interleave when `numactl --interleave=...` is invoked.  By default
il_weight for a node is always 1, which preserves the default round
robin interleave behavior.

Interleave weights may be set from 0-100, and denote the number of
pages that should be allocated from the node when interleaving
occurs.

For example, if a node's interleave weight is set to 5, 5 pages
will be allocated from that node before the next node is scheduled
for allocations.

Additionally, "node accessors" (synonmous with cpu nodes) are used
to allow for accessor-relative weighting.  The "accessor" for a task
is defined as the node the task is presently running on.

# Set node weight for node0 accessed by tasks on node0 to 5
echo 5 > /sys/devices/system/node/node0/access0/il_weight

# Set node weight for node0 accessed by tasks on node1 to 3
echo 3 > /sys/devices/system/node/node0/access1/il_weight

In this way it becomes possible to set an interleaving strategy
that fits the available bandwidth for the devices available on
the system. An example system:

Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
Node 1 - CPU+DRAM, 400GB/s BW (200 cross socket)
Node 2 - CXL Memory. 64GB/s BW, on Node 0 root complex
Node 3 - CXL Memory. 64GB/s BW, on Node 1 root complex

In this setup, the effective weights for nodes 0-3 for a task
running on Node 0 may be [60, 20, 10, 10].

This spreads memory out across devices which all have different
latency and bandwidth attributes at a way that can maximize the
available resources.

~Gregory

(sorry for the repeat send, automation failure)

================================================================

Version Notes:

v3: move weights into node rather than memtiers
    some additional fixes to node.c to support this

v1/v2: add weighted-interleave support to mempolicy

= v3 notes

This update effectively removes the connection between mempolicy
and memory-tiers by simply placing the interleave weights directly
in the node accessor information structure.

Node was recommended by Huang, Ying
Accessor was recommended by Ravi Shankar


== Move weights into node

Originally this work was done by placing weights in the memory tier.
In this patch set we changed the weights to live in the numa node
accessor structure, which allows for a more natural weighting scheme
and also supports source-node relative weighting.

Interleave weight is located in:
/sys/devices/system/node/nodeN/accessM/il_weight

and is set with a value between 1 and 100:

# Set node weight for node0 accessed by node0 to 5
echo 5 > /sys/devices/system/node/node0/access0/il_weight

By default, il_weight is always set to 1, which mimics the default
interleave behavior (simple round-robin).


== Other Node fixes

2 other updates to node.c were required to support this:

1) The access list must be initialized prior to the node struct
   pointer being registered in the node array

2) The accessor's in the list must be registered regardless of
   whether HMAT/HMEM information is reported. Presently this
   results in 0-value information being present in the various
   access subgroup


== Weighted interleave

mm/mempolicy: modify interleave mempolicy to use node weights

The node subsystem implements interleave weighting for the purpose
of bandwidth optimization.  Each node may have different weights in
relation to each compute node ("access node").

The mempolicy MPOL_INTERLEAVE utilizes the node weights to implement
weighted interleave.  By default, since all nodes default to a weight
of 1, the original interleave behavior is retained.

Examples

Weight settings:
  echo 4 > node0/access0/il_weight
  echo 3 > node1/access0/il_weight
  echo 2 > node1/access1/il_weight
  echo 1 > node0/access1/il_weight

Results:

Task A:
  cpunode:  0
  nodemask: [0,1]
  weights:  [4,3]
  allocation result: [0,0,0,0,1,1,1 repeat]

Task B:
  cpunode:  1
  nodemask: [0,1]
  weights:  [1,2]
  allocation result: [0,1,1 repeat]

=== original RFCs ====

Memory-tier based weights
By: Ravi Shankar
https://lore.kernel.org/all/20230927095002.10245-1-ravis.opensrc@micron.com/

Mempolicy multi-node weighting w/ set_mempolicy2:
By: Gregory Price
https://lore.kernel.org/all/20231003002156.740595-1-gregory.price@memverge.com/

N:M weighting in mempolicy
By: Hasan Al Maruf
https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

Ying Huang's presentation in lpc22, 16th slide in
https://lpc.events/event/16/contributions/1209/attachments/1042/1995/\
Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

Gregory Price (4):
  base/node.c: initialize the accessor list before registering
  node: add accessors to sysfs when nodes are created
  node: add interleave weights to node accessor
  mm/mempolicy: modify interleave mempolicy to use node weights

 drivers/base/node.c       | 120 ++++++++++++++++++++++++++++++++-
 include/linux/mempolicy.h |   4 ++
 include/linux/node.h      |  17 +++++
 mm/mempolicy.c            | 138 +++++++++++++++++++++++++++++---------
 4 files changed, 246 insertions(+), 33 deletions(-)

-- 
2.39.1

