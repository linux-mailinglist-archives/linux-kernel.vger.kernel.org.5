Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1220D7FBA1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbjK1MaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbjK1MaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ABBF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:30:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CEDC433C7;
        Tue, 28 Nov 2023 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701174611;
        bh=rW81soh58JgFvypfkt5SGdoRGcE0mbtnlO8fcf3y+/0=;
        h=From:To:Cc:Subject:Date:From;
        b=NCzQmT7AUM/87VPexPPppbe1DTHgRpvkYs0UPr4Jg8TZiVfNJ7u5iNrjtqRIXumy4
         rD9CIpp9t1JOUamcGCZFYHi2I5iw1FocWyHcaSWxDyiGlaCc8GqhQyL/pmxgLqPkWO
         EUxDTFcRvW7V1T8tRcIoCIFYopx49vawn5btRVyH3ouL0iRsh93hkF8/CKy+d0oYi/
         8dSvKDI6BxWtMNAEBkEE/8UHeXmr5Iu4CDyWZQCTKoU8MIRD60WrJ3rIgaWTXsDyl4
         KJGWOZJ3RbM39mOq6js/J1jszvl/wdVpe75eCLn9a1xYO/l+t5bQxhh6Y217EM7BGo
         CW4653ZSc3UUQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Shun Hao <shunh@nvidia.com>
Subject: [PATCH mlx5-next 0/5] Expose c0 and SW encap ICM for RDMA
Date:   Tue, 28 Nov 2023 14:29:44 +0200
Message-ID: <cover.1701172481.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

These two series from Mark and Shun extend RDMA mlx5 API.

Mark's series provides c0 register used to match egress
traffic sent by local device.

Shun's series adds new type for ICM area.

Thanks

Mark Bloch (2):
  net/mlx5: E-Switch, expose eswitch manager vport
  RDMA/mlx5: Expose register c0 for RDMA device

Shun Hao (3):
  net/mlx5: Introduce indirect-sw-encap icm properties
  net/mlx5: Manage ICM type of SW encap
  RDMA/mlx5: Support handling of SW encap ICM area

 drivers/infiniband/hw/mlx5/dm.c               |  5 +++
 drivers/infiniband/hw/mlx5/main.c             | 24 ++++++++++++
 drivers/infiniband/hw/mlx5/mr.c               |  1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ----
 .../net/ethernet/mellanox/mlx5/core/lib/dm.c  | 38 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 include/linux/mlx5/eswitch.h                  |  8 ++++
 include/linux/mlx5/mlx5_ifc.h                 |  9 ++++-
 include/uapi/rdma/mlx5-abi.h                  |  2 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h     |  1 +
 10 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.43.0

