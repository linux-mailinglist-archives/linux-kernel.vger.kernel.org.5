Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3997BBB96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjJFPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjJFPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:17:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C393983
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:17:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1AD3C15;
        Fri,  6 Oct 2023 08:18:07 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F33D23F5A1;
        Fri,  6 Oct 2023 08:17:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device
Date:   Fri,  6 Oct 2023 16:17:25 +0100
Message-ID: <169660288342.693075.14799298358017285320.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003085932.3553985-1-sudeep.holla@arm.com>
References: <20231003085932.3553985-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 09:59:32 +0100, Sudeep Holla wrote:
> Commit 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical
> partitions") added an ID to the FFA device using ida_alloc() and append
> the same to "arm-ffa" to make up a unique device name. However it missed
> to stash the id value in ffa_dev to help freeing the ID later when the
> device is destroyed.
>
> Due to the missing/unassigned ID in FFA device, we get the following
> warning when the FF-A device is unregistered. Fix the same by actually
> assigning the ID in the FFA device this time for real.
>
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/1] firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device
      https://git.kernel.org/sudeep.holla/c/7d0bc6360f17
--
Regards,
Sudeep

