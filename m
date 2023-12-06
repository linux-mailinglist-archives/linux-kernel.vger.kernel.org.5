Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D332A80719B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378744AbjLFOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378788AbjLFOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:01:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DB10D4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:01:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A0AC433C7;
        Wed,  6 Dec 2023 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701871305;
        bh=/smgYwrNiywTTOUBDU8u9NXotG8+d5x1VH+6Q14bcgE=;
        h=From:To:Cc:Subject:Date:From;
        b=QIYY42O737W5KvHlLRD+NnFnvcHBU33Xptq4n48C+y6W77vkWAo68OhPytfSqCW5m
         mLcO4qS6/jTSNIFEq0MhxxXSgvzM3lonJOMDjXfk0k55MblKghDkztH3vy7CA2FD6y
         Q0BKCKolqdkocKPkjTLQRJEArUATMFlxNmdqKsJJoOINLfayFlJhSUv3D3fU2a/lJR
         45tRqIldjL7Ee+QFVIj+x0uUr/XP/lHzzmLzpmUIJ6gMezgEU1cpnu9p99x6I6kEIZ
         qvAifQtP8tO4cmadQQ4l8SbU42+uj4iishys2xEKIAfUMDYyxBplKTNRKBC31aEkNb
         h6W2JzWIW0aGg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Shun Hao <shunh@nvidia.com>
Subject: [PATCH mlx5-next v1 0/5] Expose c0 and SW encap ICM for RDMA
Date:   Wed,  6 Dec 2023 16:01:33 +0200
Message-ID: <cover.1701871118.git.leon@kernel.org>
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

Changelog:
v1:
 * Reordered patches
v0: https://lore.kernel.org/all/cover.1701172481.git.leon@kernel.org

-----------------------------------------------------------------------
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
  net/mlx5: Introduce indirect-sw-encap ICM properties
  RDMA/mlx5: Support handling of SW encap ICM area
  net/mlx5: Manage ICM type of SW encap

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

