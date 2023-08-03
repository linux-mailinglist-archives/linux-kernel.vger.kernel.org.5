Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A676F324
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjHCTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHCTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C0CE2D4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB056113E;
        Thu,  3 Aug 2023 12:03:04 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D2103F6C4;
        Thu,  3 Aug 2023 12:02:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 00/12] firmware: arm_ffa: Add FF-A v1.1 notifications support
Date:   Thu,  3 Aug 2023 20:02:04 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=8/+/woPUCsRDrEmBsDXsX8w4wqPx+nhTYySmM06ZPOM=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iMz/bv2SQtquRo8zplLlxuFD2902QwL9wXR oOLa9lUIUCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jAAKCRAAQbq8MX7i mFiHD/9bD8jxsi92cJBcC/39MAMec+ZMOWedA2b0H5caXwPAMsgoAKe5pFQJNplH8J6tkhZr4kn dST8VkuH6O/rGDOavshMIEDJwDhNU+D9jO9/hdHYME6EsnG7o0QEmnH+SAaVsl/6WLQJ9cyBpw/ WHV/DJ0bJHf9ZfWYkqdXcuVsuO6IDjslnXYsYROTE7HaF3OwMocITaJEJd1LO6qCNwDqBljodrI Uyuwuna+vBBQS1lDgKoxBcQ71oOV5eEiHC5yaD7T2ZSpCz2Mi7hgl8SFX1Y3iS6G6GH393Q7yUp pY4vwKN0PGucnSYe/s6hu3NN+oTI/NUnZWt3dSejJaag5nsH/zeJVd25b3w5TH/YksnwtmDTPF6 0/GdVoXVz6A1iifP81n9zR00uHORxGYuRSlUi5+/e0xOzpaUMfxkhOsyXb4aen9iAROiaeTt3ww 3gKC7tJdURdFwfUo09eCPlDikcNCSnX613iAQBkQMgVWZViNLHpSHeUZyRen/6Q5pJcqUsmnOMK 9620O90uWeepzP/0SkVCypxFmKc7JrD6dk6g9uzqAMWafoDd+Jxsdh2ULUcH9GKmDMyuZDWS2ex ttaHAfycSU56YfNkGxPidYsoozR/fqmxksrVZtVuvqIKkDKWJVrtUUNxQnkxPE46b5rU1mdObHY 9IiUO1iW
 Oglfo8g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp; fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds initial support for the notifications added in FF-A v1.1
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

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Sudeep Holla (12):
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

 drivers/firmware/arm_ffa/driver.c | 700 +++++++++++++++++++++++++++++++++++++-
 include/linux/arm_ffa.h           |  41 +++
 2 files changed, 740 insertions(+), 1 deletion(-)
---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230803-ffa_v1-1_notif-e11bc9459962

Best regards,
-- 
Regards,
Sudeep

