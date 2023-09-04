Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C666791B03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbjIDP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjIDP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A095C1702;
        Mon,  4 Sep 2023 08:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219AB618A8;
        Mon,  4 Sep 2023 15:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D1C433C9;
        Mon,  4 Sep 2023 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693843129;
        bh=+9p3UyXZKH0ZMyot4TslH+5rWOr29dBCXvclG4VS8H8=;
        h=From:To:Cc:Subject:Date:From;
        b=omnDcuJAUqkESypfDN9R3sPymAbSxAnUqs1X6Zzo6Na1tq9ImHbpjMqWTVwqpzSRY
         gLTK+u472UBHAahe5vT3M6qS+ifWXuu1pI7Gz7bgLn0OVcGtTs20fs1tFXfDKDnfmK
         M1jAZNkN//yaCboK6a0N0QkJ1tTiTkiPCbaspHnwSZKmZD/5MbuvgyPh5/4AdRRGX3
         KmtiqtY8r6nDMAJvOskpK9AqB8iO1/tnjMbaiOyy2pwavVrReXLbObiblwTTnYThjw
         kfzJOBa4O2CYkPIyBAmDBogrXQRcIv41LDVTAo5ZyrgocbfSHAFz8fSTWQREmXU/L2
         V4WLsgZZslc8g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [GIT PULL] rpmsg updates for v6.6
Date:   Mon,  4 Sep 2023 09:01:06 -0700
Message-ID: <20230904160107.2954624-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.6

for you to fetch changes up to d629e5bcdfd9ba1c9da6da9144cc7ba43f04a6dc:

  rpmsg: glink: Avoid dereferencing NULL channel (2023-07-18 10:12:26 -0600)

----------------------------------------------------------------
rpmsg updates for v6.6

Add support for the GLINK flow control signals, and expose this to the
user through the rpmsg_char interface. Add missing kstrdup() failure
handling during allocation of GLINK channel objects.

----------------------------------------------------------------
Bjorn Andersson (1):
      rpmsg: glink: Avoid dereferencing NULL channel

Chris Lew (2):
      rpmsg: glink: Add support to handle signals command
      rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support

Deepak Kumar Singh (1):
      rpmsg: core: Add signal API support

Jiasheng Jiang (1):
      rpmsg: glink: Add check for kstrdup

 drivers/rpmsg/qcom_glink_native.c | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 54 ++++++++++++++++++++++++++++++----
 drivers/rpmsg/rpmsg_core.c        | 21 ++++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 ++
 include/linux/rpmsg.h             | 15 ++++++++++
 include/uapi/linux/rpmsg.h        | 10 +++++++
 6 files changed, 157 insertions(+), 6 deletions(-)
