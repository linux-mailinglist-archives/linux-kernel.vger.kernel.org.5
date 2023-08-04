Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC677063B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHDQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHDQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B41BDD;
        Fri,  4 Aug 2023 09:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E05620A3;
        Fri,  4 Aug 2023 16:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3713C433C8;
        Fri,  4 Aug 2023 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167567;
        bh=GlqgsnDvIgwYUmpWjzH//C5p/Ly3FcdHijBMlK4iV4M=;
        h=From:To:Cc:Subject:Date:From;
        b=oA2Xp3HMd/rmWFiFl3VM0Gi6VtXcr0dFxbeakyhbO0BC6STCjLrfXHceWe6xzd1oq
         BGgrwgPSSND9CUbSP+JBqbb5EKLgtB/GRMDibGMXfSt8TSVYLyqr0DsnRvcrhO9z6T
         IZFSjhk+2UM1WQmwuKXgFMucSXONirIF4SprIxUDlIwl3SpCBazPKxYjql7oRg9YD3
         xByXVE/FVKlyKqaSIEBYxH35R98DisujuqMqrEntJGNL7Ct864LKDPa81GzH96cMuc
         lnvzrULEu8wGV0HWQcOJMVUfvB1/4pG9JZhWioouXIeOO0Lb9s5obf39JI27fg5CxV
         kRe2UAok84z7A==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.5-rc
Date:   Fri,  4 Aug 2023 19:45:49 +0300
Message-Id: <20230804164549.3407394-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains fixes for the current cycle. The details are
in the signed tag. All patches have been in linux-next during the last
few weeks! Please pull into char-misc-linus when you get a chance.

Thanks,
Georgi


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.5-rc5

for you to fetch changes up to 3cb11fe244d516f757c1022cfa971528d525fe65:

  interconnect: qcom: sa8775p: add enable_mask for bcm nodes (2023-07-11 15:44:43 +0300)

----------------------------------------------------------------
interconnect fixes for v6.5-rc

This contains a fix for a potential issue on some Qualcomm SoCs where
bit-masks should have been used to configure the Bus Clock Manager
hardware, instead of bandwidth units.

- interconnect: qcom: Add support for mask-based BCMs
- interconnect: qcom: sm8450: add enable_mask for bcm nodes
- interconnect: qcom: sm8550: add enable_mask for bcm nodes
- interconnect: qcom: sa8775p: add enable_mask for bcm nodes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Neil Armstrong (3):
      interconnect: qcom: sm8450: add enable_mask for bcm nodes
      interconnect: qcom: sm8550: add enable_mask for bcm nodes
      interconnect: qcom: sa8775p: add enable_mask for bcm nodes

 drivers/interconnect/qcom/bcm-voter.c |  5 +++
 drivers/interconnect/qcom/icc-rpmh.h  |  2 +
 drivers/interconnect/qcom/sa8775p.c   |  1 +
 drivers/interconnect/qcom/sm8450.c    |  9 ++++
 drivers/interconnect/qcom/sm8550.c    | 17 ++++++++
 5 files changed, 34 insertions(+)
