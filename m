Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0423751A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGMH7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjGMH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:14 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6C268D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08B481BF20E;
        Thu, 13 Jul 2023 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfWHzF/NZMw6pmpY4U5IE/NM90+HSQvQntRCvYUqciQ=;
        b=GWvBErsDArq/lV/aMaKNBtF9FS0hAxSGmq6VljY40dBVwasYi792ua+e7jxZR06dm8pimU
        1/coVv52t3D13cOCyCHN0SRJFi0HGlDc6do5hk1+HLLzaBkPZ/aO+rARMU+QZdTpFG6lOo
        UhetSdtlF4yQUx4GWaAr29M/SEWyKJQxZKtjwdNM14qEwSSQd3OFkeQjaiXb+ZBhSF2m+H
        Iz4yPpYAzpWZRL7zDJ6dWgIPhsmEH3TSwqRrJrFUBPAdabhmwPYKi8bK++YmFxKTf8pqc5
        V800U5pghPWm8AEpYTzbMTXqHKWhhb3HfZATfBnJcbgS1CWv/HmROmV+RU3ReA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] mtd: rawnand: fsl_upm: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:02 +0200
Message-Id: <20230713075802.486192-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-8-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'892ad2638a6ba33c0b5afb335501b9bb7e8a83b6'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:12 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
