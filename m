Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25B7DB12D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjJ2X3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjJ2X3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E75B81;
        Sun, 29 Oct 2023 16:00:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15529C116B9;
        Sun, 29 Oct 2023 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620444;
        bh=H6PU+qPOGDb+0My74bBCeQDqCXkrfPF8NgoiYUtkxUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C31wEaJTHlQfPJ2i7ms4VFhxmTfCumgUVO1BJeGFhHgLfc6yEIJI17QSPf+NdxYE8
         dnTf/X8iYcFpoK13+AcO98Deyaa6wMXpga22a+IO84TzM63rA1pff2Q8yJxflxX2mV
         7lWlt9nvfwSPIizzwoTFjeTXiJJL1O3PdxmwlWO3OaGMMkhm38DSWFxf/n+rN+2Gm6
         vGGDz06xepwWnIRA9lXxc+dYEHuagEDOHv2n2QxKg8F8/yZan28uXrbYh4oTM/2KvM
         sCk+u7ZjsHe8wb0dUOEjmJZymv3JCpk8H+R6H8ozJlUMg9CSnBHCHoc8OUXbze9DBA
         lOX85HR0CnRPw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, welsh@cassens.com,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 16/16] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date:   Sun, 29 Oct 2023 19:00:02 -0400
Message-ID: <20231029230014.792490-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 ]

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9c67ebd4eac38..970a1b374a669 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3181,7 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.42.0

