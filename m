Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5A78A910
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjH1Jkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjH1JkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:40:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF51FF;
        Mon, 28 Aug 2023 02:40:13 -0700 (PDT)
Date:   Mon, 28 Aug 2023 09:40:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693215611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjCX1gnoWv74QX7La4W2uptIUiRuAQXYPBr6ClP0S4w=;
        b=G+kdvNeGh1cI+x9s8qv1mEdCuDIfodtScI5q8EbSyFKnCGMQ8YaXbt2lru5yspewqZwd3e
        hwkSiVt69yGU6q3C9KgdPub8Cvd5zsaJgvmaNRL9plPRhxixuUvHHgscrAw7uuXifkWYht
        497l0TZEyzEpdoQVIVhEJgT9eWwGXVn+MxK2iVd6To60UbbQfev4NHymOs5iYCMqIka3bw
        1DxBj/+UX4z8fC4BjdFPiK3BNHZ+9APPb7g8Y22b9MMh80Eabq0pE1eC06j3QPckkD6a6/
        QKZqdIcKzD6h8x+uuT1x2AkuJLKiCcR45JVi5vHfaBQusbEuqXUUJw2iuLiapA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693215611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjCX1gnoWv74QX7La4W2uptIUiRuAQXYPBr6ClP0S4w=;
        b=KaYkwh4bBA1wamfRvehwF/NBq/QgTT3FEMZEr3XGkU3biTbvLh17hEoI5/Ym0A7Sc3TcHQ
        7p4+kKPOeXSvsGAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-6.6' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230828091543.4001857-1-maz@kernel.org>
References: <20230828091543.4001857-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <169321561088.27769.2768788814854169199.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     02362c9a99b69aa956f015fa93025221b887684b
Gitweb:        https://git.kernel.org/tip/02362c9a99b69aa956f015fa93025221b887684b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 28 Aug 2023 11:33:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 28 Aug 2023 11:33:03 +02:00

Merge tag 'irqchip-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

  - Fix for Loongsoon eiointc init error handling

  - Fix a bunch of warning showing up when -Wmissing-prototypes is set

  - A set of fixes for drivers checking for 0 as a potential return
    value from platform_get_irq()

  - Another set of patches converting existing code to the use of helpers
    such as of_address_count() and devm_platform_get_and_ioremap_resource()

  - A tree-wide cleanup of drivers including of_*.h without discrimination

  - Added support for the Amlogic C3 SoCs

Link: https://lore.kernel.org/lkml/20230828091543.4001857-1-maz@kernel.org
---
