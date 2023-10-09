Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B500D7BDA42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbjJILt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbjJILt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:49:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E1F194
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:49:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64BD21FB;
        Mon,  9 Oct 2023 04:50:37 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 416F53F762;
        Mon,  9 Oct 2023 04:49:55 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 00/17] firmware: arm_ffa: Add FF-A v1.1 support(notification + new memory descriptor format)
Date:   Mon,  9 Oct 2023 12:49:52 +0100
Message-ID: <169685038705.1329488.4432517923320577763.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
References: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
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

On Thu, 05 Oct 2023 15:44:53 +0100, Sudeep Holla wrote:
> The series adds initial support for the notifications and memory transaction
> descriptor changes added in FF-A v1.1 specification.
>
> The notification mechanism enables a requester/sender endpoint to notify
> a service provider/receiver endpoint about an event with non-blocking
> semantics.
>
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[01/17] firmware: arm_ffa: Update the FF-A command list with v1.1 additions
        https://git.kernel.org/sudeep.holla/c/1609626c32c4
[02/17] firmware: arm_ffa: Implement notification bitmap create and destroy interfaces
        https://git.kernel.org/sudeep.holla/c/192e88cfea8c
[03/17] firmware: arm_ffa: Implement the notification bind and unbind interface
        https://git.kernel.org/sudeep.holla/c/933db703e8ce
[04/17] firmware: arm_ffa: Implement the FFA_RUN interface
        https://git.kernel.org/sudeep.holla/c/fe2ddb6b4235
[05/17] firmware: arm_ffa: Implement the FFA_NOTIFICATION_SET interface
        https://git.kernel.org/sudeep.holla/c/47561777d694
[06/17] firmware: arm_ffa: Implement the FFA_NOTIFICATION_GET interface
        https://git.kernel.org/sudeep.holla/c/faa19623e3e1
[07/17] firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface
        https://git.kernel.org/sudeep.holla/c/3522be48d82b
[08/17] firmware: arm_ffa: Initial support for scheduler receiver interrupt
        https://git.kernel.org/sudeep.holla/c/897e9e60c016
[09/17] firmware: arm_ffa: Add schedule receiver callback mechanism
        https://git.kernel.org/sudeep.holla/c/0184450b8b1e
[10/17] firmware: arm_ffa: Add interfaces to request notification callbacks
        https://git.kernel.org/sudeep.holla/c/e0573444edbf
[11/17] firmware: arm_ffa: Add interface to send a notification to a given partition
        https://git.kernel.org/sudeep.holla/c/e5adb3b20e39
[12/17] firmware: arm_ffa: Add notification handling mechanism
        https://git.kernel.org/sudeep.holla/c/1b6bf41b7a65
[13/17] firmware: arm_ffa: Simplify the computation of transmit and fragment length
        https://git.kernel.org/sudeep.holla/c/c9b21ef0d0a8
[14/17] KVM: arm64: FFA: Remove access of endpoint memory access descriptor array
        https://git.kernel.org/sudeep.holla/c/76cf932c95b9
[15/17] firmware: arm_ffa: Switch to using ffa_mem_desc_offset() accessor
        https://git.kernel.org/sudeep.holla/c/e4607b84c681
[16/17] firmware: arm_ffa: Update memory descriptor to support v1.1 format
        https://git.kernel.org/sudeep.holla/c/113580530ee7
[17/17] firmware: arm_ffa: Upgrade the driver version to v1.1
        https://git.kernel.org/sudeep.holla/c/bcefd1bf63b1
--
Regards,
Sudeep

