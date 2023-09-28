Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB127B217D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjI1Pjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjI1Pjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:39:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C67C2C0;
        Thu, 28 Sep 2023 08:39:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2DF1FB;
        Thu, 28 Sep 2023 08:40:10 -0700 (PDT)
Received: from e127619.cambridge.arm.com (e127619.arm.com [10.1.36.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637FE3F59C;
        Thu, 28 Sep 2023 08:39:31 -0700 (PDT)
From:   Divin Raj <divin.raj@arm.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 0/1] rpmsg: virtio: Make buffer size and number configurable
Date:   Thu, 28 Sep 2023 16:38:24 +0100
Message-Id: <20230928153825.151948-1-divin.raj@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is necessary to support the allocation of memory for an out-of-tree
rpmsg ethernet device driver over virtio, enabling support for packet sizes
based on the MTU (Maximum Transmission Unit) size (1500).

Peter Hoyes (1):
  rpmsg: virtio: Make buffer size and number configurable

 drivers/rpmsg/Kconfig            | 23 +++++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 27 +++------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

-- 
2.25.1

