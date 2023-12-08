Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA72880AD92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjLHUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHUJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:09:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E193
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:09:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB23C433C8;
        Fri,  8 Dec 2023 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702066186;
        bh=I466eE+xnip8ZqtgQ6/GRHSwKNzyZEsjGJvnLC6k9wQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BSwo5iz33TxP2TqUkqKmQ9lcSO1HjQ+d3tw8YtSKcJ1TaPvyQZlsNyObY+ecPIcKN
         E7KnoUXS9Pv6xHy96/kFaAgyJDg4v1Q0EHY8hf2b+xwILzeLr6C19UharPJRycQmBU
         sQoxdMaiAHTZFtMQORsO3/nFG2iMArTfANWP4DAnxoZ64eQFlAJOKkUBhIwp2aIn0W
         BX4IH6O1q+i4Wdg6o084hniXT9ydu5JDDPFC4e5TnjVH5tqHhmNhjq2cn/HLX4WBrL
         UGIxNqh2W19eL5xYFZ0sEmOyTE3582aaNJTgfPntbq++axNZQjtu01wX9O/0hhF7kj
         LV7aQNCxFK/Aw==
From:   SeongJae Park <sj@kernel.org>
To:     stable@vger.kernel.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: Please merge commit 85c2ceaafbd3 ("mm/damon/sysfs: eliminate potential uninitialized variable warning") into >=5.19 stable trees
Date:   Fri,  8 Dec 2023 20:09:43 +0000
Message-Id: <20231208200943.64138-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please merge commit 85c2ceaafbd3 ("mm/damon/sysfs: eliminate potential
uninitialized variable warning") to >=5.19 stable kernels.

In 2023-10-31, I sent[1] a fix for v5.19.  After a week, Dan found an issue in
the fix and sent a fix.  At that time, the commit that Dan was fixing was
merged in the mm tree but not in the mainline.  Hence, Dan didn't Cc stable@.

However, now the broken fix[1] is merged in the mainline as commit 973233600676
("mm/damon/sysfs: update monitoring target regions for online input commit"),
and all >=5.19 stable trees.  Hence Dan's fix should also applied to those
trees.  Please apply those.

Note that the bug was only potential[3] due to unchecked return value.
However, the unchecked return value was not an intentional behavior but a bug.
Hence we further made the return value to be checked[4].  The return value
check fix is also merged in the relevant stable trees, so the fix is now needed
for a real bug.

[1] https://lore.kernel.org/all/20231031170131.46972-1-sj@kernel.org/
[2] https://lore.kernel.org/all/739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain/
[3] https://lore.kernel.org/all/20231106165205.48264-1-sj@kernel.org/
[4] https://lore.kernel.org/all/20231106233408.51159-1-sj@kernel.org/


Thanks,
SJ
