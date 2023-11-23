Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86277F66E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKWTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKWTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:04:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62F9E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:04:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76DC433CB;
        Thu, 23 Nov 2023 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700766279;
        bh=9vQGT/qLYbQVJ6jyB7uTbXrGWb2NZ5AwZAZqn9UW3bc=;
        h=From:To:Cc:Subject:Date:From;
        b=nqNiMT7rxoJOGnXcFeFm2ZrNwK4PR5dxH6p5Wml1P94yifzNfv1Yz8OkfJtlJow8l
         g9F29qkuH+gMH7cguIGbaMm1Qp/MlUaFpqEPc/PVZjOF5By4ve/6D58RaaDQ9rnvU8
         EGrq7cV4mHUhJYJ62vtMDUAj+l5jmkiaavISWE5kEGPNb+lc9Yv5hLvS7BP7B2GWjZ
         vJTnow89BCIkB+Kdx7EdLnPpdK6kMimXHikKiEB01ac1q0E0EA8QzOqG6OGSLaN7o6
         UZYsyQCkn+koMo4vdoviYWdbMy9Ysrblb7U5p3gzjeGS8G5ILZ+z1YkWPLsBjAcFSw
         7MQvBTy9uUv+g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH rdma-next 0/2] Add and use memcpy_toio_64()
Date:   Thu, 23 Nov 2023 21:04:30 +0200
Message-ID: <cover.1700766072.git.leon@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

This short series adds and utilizes memcpy_toio_64().

Jason Gunthorpe (2):
  arm64/io: add memcpy_toio_64
  IB/mlx5: Use memcpy_toio_64() for write combining stores

 arch/arm64/include/asm/io.h      | 20 ++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mem.c |  5 +----
 include/asm-generic/io.h         | 30 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.42.0

