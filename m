Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5E751A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjGMH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjGMH6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:17 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B882686
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E27E20002;
        Thu, 13 Jul 2023 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/j1cYBXUPPHHjAdNDFI/2LZU5KH9fYfzMh0905FV+0E=;
        b=Xua6698gxPHhfxpm8jBScSZC6VdSezcvi9oEr8ijucxiHbVRC6W67THwHNTmly1aF0uYcy
        cJ0pG7KdjZvWo3fOJ9/Mr0Ue4kXGDbuFYmD1BlRa9R07m5zIKBp9sk5Fbca/1T0MDPCU/b
        W3xf4PKXKpBgJFXeJ+ONb2hkOs8DVl+XSmEGlbrO5xnCjQKce55woT8sEULH6d4BgmABuf
        /LTO9OQJmjWOBt2URuGnNb0TRkMlKC7cqd9lU89PVemlD9iLa+2Hf9AakrBUuLd3q2XJK/
        zKby0uhDDgCsPM5n08XHliCLaTDvKZcHk4Bke9Ua3jczngJpa6OeieQZtPOCRA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] mtd: rawnand: omap2: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:12 +0200
Message-Id: <20230713075812.486278-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-5-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'189175e0c3554434416e75d7687011ef6c185159'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:09 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
