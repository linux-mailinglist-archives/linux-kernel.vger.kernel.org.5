Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4275EDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGXIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGXIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:35:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18184E42;
        Mon, 24 Jul 2023 01:35:35 -0700 (PDT)
Date:   Mon, 24 Jul 2023 08:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690187732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZIFjd8b1zmq6CVD9es57l2q/FwdfakaSpxogKN3LCM=;
        b=Cnqp3Il5EAZzbO5gF5oyvQgm1s9AyD2s8OxRCuE2mNOhsz2ZmK6CN5EXxabiKdVB/xfgGw
        /krkivpb7YAuEmfMq3BC8CQLsXF4P01e7kDga0l/jTNJ+Zp0SCOigB1KnIqv7KZ1p5kEdt
        cKq2iCGsYZ6tnvUzOC7lKyQKBR6z1V7tKidA/UC+Z9xhZGWgsbcA0vf+26AMK0J5JjAFN8
        rLkioU+cXKAJyQKtmJphzUNTy+d5AOn5KX2bCUX04ZiNBqjsJx2IdDdmLCTfBDqYadhA0v
        ZZcpRWT8BLFNpzv0Oe+feKGXqXAqzFfd4DePYcYoBVzp9cIXAHLlsUMBCLO9PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690187732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZIFjd8b1zmq6CVD9es57l2q/FwdfakaSpxogKN3LCM=;
        b=qG46IOBV6pcEF/+bslz0Kds2yWit5LG1QtVxBvAJDUTBkLQJorb3R3oKWR5//TzHfJTcz7
        5VBjloj03mSDMgDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.5-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230717113857.304919-1-maz@kernel.org>
References: <20230717113857.304919-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <169018773176.28540.6935364489444309798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     de990908521073d98a46ad0e29885df447e95242
Gitweb:        https://git.kernel.org/tip/de990908521073d98a46ad0e29885df447e95242
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 24 Jul 2023 10:27:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 24 Jul 2023 10:27:43 +02:00

Merge tag 'irqchip-fixes-6.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

  - Work around an erratum on GIC700, where a race between a CPU
    handling a wake-up interrupt, a change of affinity, and another
    CPU going to sleep can result in a lack of wake-up event on the
    next interrupt.

  - Fix the locking required on a VPE for GICv4

  - Enable Rockchip 3588001 erratum workaround for RK3588S

  - Fix the irq-bcm6345-l1 assumtions of the boot CPU always be
    the first CPU in the system

Link: https://lore.kernel.org/lkml/20230717113857.304919-1-maz@kernel.org
---
