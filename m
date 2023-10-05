Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06E7BA231
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjJEPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJEPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:19:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7BE3843
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86AA8C15;
        Thu,  5 Oct 2023 07:45:47 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D693F641;
        Thu,  5 Oct 2023 07:45:07 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 00/17] firmware: arm_ffa: Add FF-A v1.1
 support(notification + new memory descriptor format)
Date:   Thu, 05 Oct 2023 15:44:53 +0100
Message-Id: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOnLHmUC/2XOQY7CMAwF0KugrCcojtM2ZjX3QAilrjPNglZKU
 KQR6t0JzGIQrKy/eP7/porkJEUddjeVpaaS1qUF97VTPIflR3SaWlbWWDTeoI4xnCtoOC/rNUU
 tACOT64h6qxoaQxE95rDw/GTBCVugoUcYRmDx3PGE4iJPJN009MQ+snvQOZXrmn+fU6pt5/jXS
 kDvrdVqo/uIATkgWeTvkC97Xi/q1B5VfMH2E2PD7NsG6IAM+3+8bdsdYdbRyxIBAAA=
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4442; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=9QGWZGDIVqC3L8ODpUC0ms96Oc/J1D43n5bVeT4vMcI=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvwKate+iRJ3MG2WQP+nU7/SKSoawwuoE8iV
 UBg2Cb+7jqJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8AAKCRAAQbq8MX7i
 mF3ND/9jjv8VMbJnuMXX/P91BdbjkCk1KWiOo9+Hmxh2w+pHEFon6WpELV8tHJ28aV5/4KyibTA
 1eLqbsO6Qfem3BIQteC7ZqX8ZP8Ht+OhDiwKs4K0JzLeCOa5k+sZGYsaIEZntqLcUn4IHqdQSjE
 UvGTnjCFoQBtmJ71P0QOB75q4cU/WGRfMUSpd0cvjkxoc6Fvf1XSml6mvChXVcazj3T7yTQeoCa
 cmwpXsw1XKwlU9AaUSfwKS5Dw+lQwwR8KX/Z6EYekUiA+jFcbkHVFMUyBybgXV1wl5WihAr7CRV
 RT500r1geeauB5VxbZcBoPP2iz4yx5O1/HGKMIUIpoNGalD//OExluYMJzUGGyTpOtSDS10mzaY
 2u69BAG7hzN1q6DNeDNr1m3EIa2mjxY6CvPaeedlcgswOv1jvOB/3kldRA3AWce9hlxInj+CtpO
 JVbkhvF8RHGIAIbcJzogINN1nqffeFG3T7SzzOfbTWOF3+DIwiJNpLO6W4LjT1lREfFGzXYq+4W
 /ZhbIwHuqOI3zUP8d7DLmBHrLJZl+72ReOXIc+oTrBDceOMbSwfpjVsnorX6ZCJbCEmZyfVtnUv
 8UzW6xZUat5wbYhBb4utl6DKDmGEmk9s3Aapf0/RWj3zn38I0RuPAvNYKkK+w5yF5lankjqxt8w
 TocZvvvOC8FWdpg==
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

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Changes in v4:
- Dropped the check for FFA_FN64_SUCCESS in ffa_mem_first_frag()
- Handle the absence of support for notifications in the firmware
- Fix couple of issues in the cleanup paths if the notification setup fails
- Handle both FFA_{FN64,}_SUCCESS in FFA_NOTIFICATION_INFO_GET
- Changed to use ffa version instead of boolean to switch between old and
  new memory descriptor formats in ffa_mem_desc_offset()
- Link to v3: https://lore.kernel.org/r/20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com

Changes in v3:
- Fixed ffa_mem_desc_offset() to not use possibly unpopulated structure members
- Fixed the parameter of handle_notif_callbacks(), must be notification type
  instead of the partition ID.
- Fetch only secure partitions and SPM framework bitmaps until we add support
  to this driver run in other than NS physical instance.
- Swapped back PACK_TARGET_INFO() arguments which I swapped in v2 with some
  confusion during the review.
- Link to v2: https://lore.kernel.org/r/20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com

Changes in v2:
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
- Link to v1: https://lore.kernel.org/all/20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com/

---
Sudeep Holla (17):
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
      firmware: arm_ffa: Simplify the computation of transmit and fragment length
      KVM: arm64: FFA: Remove access of endpoint memory access descriptor array
      firmware: arm_ffa: Switch to using ffa_mem_desc_offset() accessor
      firmware: arm_ffa: Update memory descriptor to support v1.1 format
      firmware: arm_ffa: Upgrade the driver version to v1.1

 arch/arm64/kvm/hyp/nvhe/ffa.c     |  10 +-
 drivers/firmware/arm_ffa/driver.c | 758 +++++++++++++++++++++++++++++++++++++-
 include/linux/arm_ffa.h           |  78 +++-
 3 files changed, 822 insertions(+), 24 deletions(-)
---
base-commit: d82dd2a5be45b20129d7f4a3f6df1681e0537a16
change-id: 20230803-ffa_v1-1_notif-e11bc9459962

Best regards,
-- 
Regards,
Sudeep

