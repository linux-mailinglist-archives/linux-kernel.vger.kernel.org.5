Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2497C7123
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjJLPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJLPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:15:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135D090
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:15:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306ECC433C8;
        Thu, 12 Oct 2023 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697123714;
        bh=fCA35uXSn16SfXjIFY+Kildy7ZXikS93KIx0exHbeCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqBSSsaYOVij2d4bsKo0TR+Z8Z/FHCvT+JY8YJNcl4EXbBF0xca/pHXdWbc3NVks8
         /o1ttjdpsfZ36A0s8fZ875zW9AWASshBSRZKQMdxhXjtKRXqGSvKmaxiAEu46gsYR9
         fM47q+F0zJ3bkVt9eHExFBf2EI31d5QTyBrtBaY/hovGQW8glv9mgp0Zw/sv67lYe7
         w06RSP8yC8xXVpV9Zt6MMXFvKVl1HdlmDVyvY9dQwZj6gO36lqe3gf/nrQNZ2JcGIL
         hhSaLRbuoESiyTmsdFfvdiS1mPY0Doo0uYti35Q6VLco7pA9rXuRT8fN/RwGDz4/q2
         vHXIjCZ0r5VSA==
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas Weisschuh <linux@weissschuh.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] const_structs.checkpatch: add xattr_handler
Date:   Thu, 12 Oct 2023 17:15:06 +0200
Message-Id: <20231012-karpfen-boote-83f11c904bcc@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-vfs-xattr_const-v1-1-6c21e82d4d5e@weissschuh.net>
References: <20231012-vfs-xattr_const-v1-1-6c21e82d4d5e@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org; h=from:subject:message-id; bh=fCA35uXSn16SfXjIFY+Kildy7ZXikS93KIx0exHbeCw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRq8OZd/P8j7/Mttpe2e2uDuaJdW75d3V5eUaCbyqO0VdKg LoC1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJzaxgZ7vQIf9+95bzVgqhH3ppeDd u99O8qq+8uPHn/rHbTpdZfFYwMW3l0mnfde95ief38It533y9xTuyynmV13t3Ldp9WxYvPfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 16:30:38 +0200, Thomas Weißschuh wrote:
> Now that the vfs can handle "const struct xattr_handler" make sure that
> new usages of the struct already enter the tree as const.
> 
> 

Applied to the vfs.xattr branch of the vfs/vfs.git tree.
Patches in the vfs.xattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.xattr

[1/1] const_structs.checkpatch: add xattr_handler
      https://git.kernel.org/vfs/vfs/c/a640d888953c
