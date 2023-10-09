Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA7BE21C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376905AbjJIOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376728AbjJIOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:08:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12E8E;
        Mon,  9 Oct 2023 07:08:18 -0700 (PDT)
Date:   Mon, 09 Oct 2023 14:08:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696860497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCuOoJ3iQR9hMZJKIvfJQ4xYZUuuXDNUWmc3XV54GBU=;
        b=WvGOUFckko3HMd2q42KF2A2QW999Ns9RqLNPlqmC204l+XGdwLxs9Y4OyoSTO947Y2fDOu
        Og+4oFSCmaxu+wcJZY+TjgClrZsVIMyf4qjqF+4Rg753rO8Ci5KvNfQiAQncQjOHUPAgeF
        Lm8uh8JyRBya7MCVKnGw6gEiA/wNbh+Fm5DKxIZwXQHHqyRLo8hzOmYaEvIVUcsYJkSlUj
        BR/kaUv4DUGWmstVKnXbafoRyhr9XvvAdsYPaaw3XS8fha8JEGziD0S2RUdPmdjb1Qvxq+
        rcLJdG1Qvv3ZoELycAt937eKaEzjttsUhKQIzE0j//t7LTG80LpRgz9a03X9DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696860497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCuOoJ3iQR9hMZJKIvfJQ4xYZUuuXDNUWmc3XV54GBU=;
        b=/Oik8rpVLLRHF+51TootX39235r0639WgAea8pyNP8t7kgUz/dL41jtT2jF5uAJ046PWu6
        qJDm4alyD8256OBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.6-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231007121933.3840357-1-maz@kernel.org>
References: <20231007121933.3840357-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <169686049676.3135.7685393730075598660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4dc5af1fee55e38b5016e45b66bec1e1312973f5
Gitweb:        https://git.kernel.org/tip/4dc5af1fee55e38b5016e45b66bec1e1312973f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 09 Oct 2023 16:01:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Oct 2023 16:01:55 +02:00

Merge tag 'irqchip-fixes-6.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

  - DT binding updates for Renesas r8a779f0 and rzg2l

  - Let GICv3 honor the "dma-non-coherent" attribute for systems that
    rely on SW guessing what the HW supports

  - Fix the RISC-V INTC probing by marking all devices as initialised
    at once

  - Properly translate interrupt numbers from DT on stm32-exti

  - Use irq_data_get_irq_chip_data() in the rzg2l driver instead of
    blindly dereferencing the irq_data structure

  - Add a MAINTAINERS entry for the various ARM GIC irqchip drivers

  - Remove myself as the top-level irqchip/irqdomain maintainer

Link: https://lore.kernel.org/all/20231007121933.3840357-1-maz@kernel.org
---
