Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA57B272A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjI1VKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1VKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:10:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE4F3;
        Thu, 28 Sep 2023 14:10:19 -0700 (PDT)
Date:   Thu, 28 Sep 2023 21:10:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695935418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77afw0i6mpY2aGIKdmNyBfPjlx58NITlKelMTNshHZU=;
        b=hLhq0xFTs+S6r9aP+UkMTN0NXO8d1/QXIyHoYtHIBHPc+UekifEUpmZti+ohq+8XbsZ0bt
        lcoVAKsnrghIgLAwc2aZmPFLJzsJXnEL0Ep8Kb4aIb0tGBDb3pEaMmjEA/Z2HxA4ccwUrH
        j+rbEH6o0lXPaOGcv1Fhcn+aD5z/0sGiEASEbCELjkpKFML3AUytX3DKJH5ku6fwPcttez
        B1sc5ZRwxH1tsb8JMl5uzS1D95ZzDmLRNwyNMSqbK9QA4OGLmn8keI5yHMI1Tk45w6PAI9
        UfMXhmBauUDADmcTMvgUllklOWTfw6bieElEMczH0HFszldhzsXgiIM2tUyI8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695935418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77afw0i6mpY2aGIKdmNyBfPjlx58NITlKelMTNshHZU=;
        b=yOHtKbUgwS3lTMkCLB/jsalNKxve0TGZweICn6F/B3nND4a7eqoyR1byK8hx7V1tHwpj9S
        lToo2iRezzkXwhBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.6-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230924094105.2361754-1-maz@kernel.org>
References: <20230924094105.2361754-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <169593541756.27769.14546547060373396545.tip-bot2@tip-bot2>
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

Commit-ID:     9cd847ee4d64c10b52f26f18d19eb6462ba7d2fe
Gitweb:        https://git.kernel.org/tip/9cd847ee4d64c10b52f26f18d19eb6462ba7d2fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 Sep 2023 23:04:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Sep 2023 23:04:13 +02:00

Merge tag 'irqchip-fixes-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zygnier:

  - Fix QC PDC v3.2 support by working around broken firmware tables

  - Fix rzg2l-irqc missing #interrupt-cells description in the DT binding

  - Fix rzg2l-irqc interrupt masking

Link: https://lore.kernel.org/lkml/20230924094105.2361754-1-maz@kernel.org
---
