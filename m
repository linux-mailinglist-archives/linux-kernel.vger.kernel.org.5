Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF687D7422
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjJYTVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYTVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48D4213A;
        Wed, 25 Oct 2023 12:21:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 904C92F4;
        Wed, 25 Oct 2023 12:22:22 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0F103F738;
        Wed, 25 Oct 2023 12:21:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 0/7] Minor cleanup for thermal gov power allocator
Date:   Wed, 25 Oct 2023 20:22:18 +0100
Message-Id: <20231025192225.468228-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The patch set does some small clean up for Intelligent Power Allocator.
Those changes are not expected to alter the general functionality. They just
improve the code reading. Only patch 3/7 might improve the use case for
binding the governor to thermal zone (very unlikely in real products, but
it's needed for correctness).

The changes are based on top of current PM thermal branch, so with the
new trip points.

Regards,
Lukasz

Lukasz Luba (7):
  thermal: gov_power_allocator: Rename trip_max_desired_temperature
  thermal: gov_power_allocator: Setup trip points earlier
  thermal: gov_power_allocator: Check the cooling devices only for
    trip_max
  thermal: gov_power_allocator: Rearrange the order of variables
  thermal: gov_power_allocator: Use shorter variable when possible
  thermal: gov_power_allocator: Remove unneeded local variables
  thermal: gov_power_allocator: Clean needed variables at the beginning

 drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------------
 1 file changed, 64 insertions(+), 59 deletions(-)

-- 
2.25.1

