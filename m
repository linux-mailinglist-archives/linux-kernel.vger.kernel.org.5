Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2376E92B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjHCNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjHCNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC9212B;
        Thu,  3 Aug 2023 06:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D81D661D69;
        Thu,  3 Aug 2023 13:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65916C433CB;
        Thu,  3 Aug 2023 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067813;
        bh=9Q9y+Y2QzfJdoochpxIlRw8fhM/lfnNz9Cq2beWflSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQgBuT1DPs2ZhqfHz11XVlQVgtgZYOO2SvR6J/Yx7D/mB4eH/wHd4EZRRLV7YXVJV
         YUeS/1MzNrrI+oAaDb5GTHC+dpv2AEYNCYdNZcNxqpVnxzqK0p2MXVUpCZdx0Vtcfl
         xynyCNJScw3T6fDa0v43F8YeTiwLKPMlUr9rJtrhALInxWgcs04clR+RjKv95b/3s8
         hLVhurE/xnYJetvBbq3eYmLGPZH2w3UuRFwWGzvUZoKpwqSEJ0rRIgbv/fn3kUzDxB
         54RIG8Oi13BR0dMkOiLLqQZ37Uxkx3f5H6P/k27DT2s5lMJfU32RKtwUFmYj5QQ9FP
         is1p4oZ7c2uxA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Clemens Springsguth <cspringsguth@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 7/7] nvme: add BOGUS_NID quirk for Samsung SM953
Date:   Thu,  3 Aug 2023 09:03:20 -0400
Message-Id: <20230803130321.641516-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130321.641516-1-sashal@kernel.org>
References: <20230803130321.641516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

[ Upstream commit e5bb0988a5b622f58cc53dbdc044562229284d23 ]

Add the quirk as SM953 is reporting bogus namespace ID.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217593
Reported-by: Clemens Springsguth <cspringsguth@gmail.com>
Tested-by: Clemens Springsguth <cspringsguth@gmail.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf37..8cef5805bfb2f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa802),   /* Samsung SM953 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
-- 
2.40.1

