Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489B97A69B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjISRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjISRl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45A1EAD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBF71FB;
        Tue, 19 Sep 2023 10:41:56 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9363F5A1;
        Tue, 19 Sep 2023 10:41:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFT v2 00/18] firmware: arm_ffa: Add FF-A v1.1
 support(notification + new memory descriptor format)
Date:   Tue, 19 Sep 2023 18:40:48 +0100
Message-Id: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACTdCWUC/x3NQQrCMBCF4auUWTuQpCrGA3gAcSclTOLEzsK0J
 LUUSu9u6vLn8fFWKJyFC1ybFTLPUmRINcyhgdBTejPKqzYYZVp1US3GSG7WqF0aJonIWvtgjyd
 rzwYq8lQYfaYU+p19xzJlpo+rbJ/HzFGW/98T7rcHdNv2AyVfOb6EAAAA
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Cc:     Joao Alves <joao.alves@arm.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3511; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=3CdSSoesTcz29vvfc5L+ng97FLRT56WZCuNfC2ibU9k=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd05xRMXBVY1vZARS6YM2GhjcVPopPYKCEnyU
 Ve6Aqnft0iJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOQAKCRAAQbq8MX7i
 mCJ7EAC2Wsss473OlrNKXReqyET8abWdDKGxJfdv93aw34Di8aMfO2CyZe8bCg7MesM7pNDPEUb
 o1pykg98tHgMbp2DrYgDmFm3Uc9X127f+gXGjHTuT0yDlJ3JdvnOwoZuRBN24Hwge81XL6J4L3M
 iUNCBF97UyWOhdS+y20YIpp5M5/VTaQyD/ehmyrtK7XWqrqvkB26ahiVx/6z0WsUnqFclgxehHu
 BtWbXQZnw1Z4EBFoo0t4uJff1LPhz5iOuwJbQdhWVAMupUuI1hNMPD3q7rDuIBimW94KaLCEaqr
 WSHYn/JAe67WbTCZv8EVoCeLFv74wiqDoGE1pLS3WfusEGOqGX7Ma4AX1O/LoJ4/Mc5fCiATlui
 1pjDNuPkEy3YAl03JFjaq8Ct9DxADKr2K3Yq1ZRobmLZSZ74hkfzPuC6CGb1GidlJmn1F6IuA9e
 xtQMFCTwP8tWJ6Bc7ooVoKK5EuBN+8Crzgsrrana/PKHnIoYvWK7aie6vEYhnze4Apah+4yv3ur
 BxDy+WF0jqxNwgh5EjLNeSbvLpVs7a+lk67pam5Y9lP0jDUuv7I7GU3mEDDpcbshOwa4qQTetJM
 Xmx4BGkc5GSZiDcN+hr6GvZMyQM9zMnHLrEjatt8g1TwTvZSXj+AN7j5V9JufVqB5Q79bFLi1uK
 fR7fqtN1ijbNdxA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds initial support for the notifications and memory transaction
descriptor changes added in FF-A v1.1 specification.

The notification mechanism enables a requester/sender endpoint to notify
a service provider/receiver endpoint about an event with non-blocking
semantics.

A notification is akin to the doorbell between two endpoints in a
communication protocol that is based upon the doorbell/mailbox mechanism.

The framework is responsible for the delivery of the notification from the
sender to the receiver without blocking the sender. The receiver endpoint
relies on the OS scheduler for allocation of CPU cycles to handle a
notification.

OS is referred as the receiver’s scheduler in the context of notifications.
The framework is responsible for informing the receiver’s scheduler that
the receiver must be run since it has a pending notification.

The series also includes support for the new format of memory transaction
descriptors.

It also contains one fix for MEMORY LEND operation.

v1[1]->v2:
	- Added a fix for MEMORY LEND operation
	- Upgraded the driver version
	- Added support for the new format of memory transaction descriptors
	- Remove unnecessary partition ID information in the notification
	  callbacks
	- Fixed setting up drv_info->sched_recv_irq before enabling the SGIs
	- Added missing resetting of bitmap_created in notifications_cleanup()
	- Added some comments about GICv3 and SGI assumption
	- Removed partition ID from the notification hash table entries as
	  they are redundant/incorrect. Added the notification type instead
	  (SP/VM/Framework)
	-

[1] https://lore.kernel.org/all/20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com/

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Sudeep Holla (18):
      firmware: arm_ffa: Update the FF-A command list with v1.1 additions
      firmware: arm_ffa: Implement notification bitmap create and destroy interfaces
      firmware: arm_ffa: Implement the notification bind and unbind interface
      firmware: arm_ffa: Implement the FFA_RUN interface
      firmware: arm_ffa: Implement the FFA_NOTIFICATION_SET interface
      firmware: arm_ffa: Implement the FFA_NOTIFICATION_GET interface
      firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface
      firmware: arm_ffa: Initial support for scheduler receiver interrupt
      firmware: arm_ffa: Add schedule receiver callback mechanism
      firmware: arm_ffa: Add interfaces to request notification callbacks
      firmware: arm_ffa: Add interface to send a notification to a given partition
      firmware: arm_ffa: Add notification handling mechanism
      firmware: arm_ffa: Don't set the memory region attributes for MEM_LEND
      firmware: arm_ffa: Simplify the computation of transmit and fragment length
      KVM: arm64: FFA: Remove access of endpoint memory access descriptor array
      firmware: arm_ffa: Switch to using ffa_mem_desc_offset() accessor
      firmware: arm_ffa: Update memory descriptor to support v1.1 format
      firmware: arm_ffa: Upgrade the driver version to v1.1

 arch/arm64/kvm/hyp/nvhe/ffa.c     |   8 +-
 drivers/firmware/arm_ffa/driver.c | 769 +++++++++++++++++++++++++++++++++++++-
 include/linux/arm_ffa.h           |  76 +++-
 3 files changed, 827 insertions(+), 26 deletions(-)
---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20230803-ffa_v1-1_notif-e11bc9459962

Best regards,
-- 
Regards,
Sudeep

