Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09D579D643
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbjILQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbjILQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9A131703
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C8AC15;
        Tue, 12 Sep 2023 09:28:48 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19FF13F738;
        Tue, 12 Sep 2023 09:28:09 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
        jsnitsel@redhat.com
Subject: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly flexible
Date:   Tue, 12 Sep 2023 17:28:04 +0100
Message-Id: <cover.1694535580.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/

Hi all,

I hope this is good to go now, just fixed the locking (and threw
lockdep at it to confirm, which of course I should have done to begin
with...) and picked up tags.

Cheers,
Robin.


Robin Murphy (2):
  iommu/iova: Make the rcache depot scale better
  iommu/iova: Manage the depot list size

 drivers/iommu/iova.c | 95 ++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 30 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

