Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC47D4E57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJXK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjJXK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:56:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193E2E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:56:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF722F4;
        Tue, 24 Oct 2023 03:57:07 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA1D3F64C;
        Tue, 24 Oct 2023 03:56:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/4] firmware: arm_ffa: Few fixes for FF-A notification
 support
Date:   Tue, 24 Oct 2023 11:56:16 +0100
Message-Id: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKiN2UC/x2LMQqAMAwAvyKZDTRVB/2KOJSaaJZWWhFB/LvB8
 bi7ByoX5QpT80DhS6vmZEBtA3EPaWPU1Ri88x0536NIwJRPFY3htBhFb644rkMUYuqIBWw+Cv/
 C3nl53w+60xWBaAAAAA==
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=f0TnNwWuu8+hVREinfQjHgQiCfsqhzCfUIqVLO6bLGE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlN6LZt7oRl3heWQa6vJbNlxo5SgcY/EqS7Ts6c
 tls2J+M3c+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZTei2QAKCRAAQbq8MX7i
 mDHLD/9jEN0EdUL7ijZ3kS7SDgjA10+PmfU5pZBMu0Fg4roHXOsPy0x6WOf0hJ+3pirWIyhvV6y
 C+Uo2AF4tAw2UEKmwa3RB2ZoU5qR+8mVgEOmAzos5c60qOnZ50bpk5LcZPgLBJOLh++ZSR9LXFb
 wA7Xcn/tO+j+UfznFEmKvy0cdrFhvzbJmU2efKxKI4oyPR330Fbjy1PcnZTqkGGHawnhiFcqvhG
 MniQEMwbw9AnvheFcWBN6W6H+HwV8K5FPqgYVdvs9/AnoIY+1hNU2OJabJ4UEohW6tojLE+tQIM
 wo0f9eYy2i1uh4PnPYyTCMmMNYh0xp8gUEM7eiy3DW5BThAK+JgNMIETlRbm+fN3jGfsC0vrZgh
 53mzBqqtGArbI6Qbk7BjfsNDuQb1dcN0l+krUZGG2gUsEu8fPwArV5aFkZe7tj3bqQq9aZL1V15
 fzkLjwdvdWGveyoVP2P0rfA8A97ot5Q9NTRU6P6lOa+qKnOVGMriQMsKGVi8/J4KjWMePwFQ+uc
 u4XQOXxvmSTiZYQDgtWkCfLMWmLnwwUJvY2DzLp/w3JuZhgpubth+8Omn7iZGvUyZitn2BpnJzK
 UDldfCRF021R9JEfYRuj0iiH3e8L/28qWuaoT0bNKaJPtBAiTd/RSN+cgfZdmTUs/eoRCoaANg3
 iyxS6nBi3wGmw4Q==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are set of small fixes around FF-A notification support that are
currently queued in -next. It is mostly to take care of absence of
the notification support in the firmware as well as allowing them to be
optional and continue initialisation even when the notification fails.

Regards,
Sudeep

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Sudeep Holla (4):
      firmware: arm_ffa: Allow FF-A initialisation even when notification fails
      firmware: arm_ffa: Setup the partitions after the notification initialisation
      firmware: arm_ffa: Add checks for the notification enabled state
      firmware: arm_ffa: Fix FFA notifications cleanup path

 drivers/firmware/arm_ffa/driver.c | 65 ++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 21 deletions(-)
---
base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
change-id: 20231024-ffa-notification-fixes-9d5cf1e131ef

Best regards,
-- 
Regards,
Sudeep

