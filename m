Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17433751A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjGMH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjGMH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:05 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D62713
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:57:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D0C76001A;
        Thu, 13 Jul 2023 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2rrTKML2PGQOGjKRFJnjSlB02Tb+RkYO5UuH5F+OIY=;
        b=o/XTxi1GM5jS2d9tzAqYxdPkYT9V2v/d3KPILatQQ6cN0xfi+gq5zfL493O1NbRZF/NU7w
        A3sfWXZjlrlyyRZYL0yE2w0WPDGi/DYVNsfNp1t6b2n1eDYqrWR7oERaWYTSgcBq8Vv7kB
        WpxlMVMWOcijVUiWZlSDEIMk2ZAvRbAQ5o97XFESzgivgXlq+boYzSpf6WfIse5Y/jfUP6
        hdmWx9+Fjoe52Q9kMMi0PRyNY9wR1kRtGTxnrpVYVVJkdpznHrw5Ub5J6FUy5MHnfI/IGz
        Eu/Dpmg2hvWyh1ZziaKo8jm21xPlf6zeCdsn+ie8MAkjH85eIWoAWqxbdvT08g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] mtd: nand: omap: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:57:51 +0200
Message-Id: <20230713075751.486075-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-12-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2ef5fc30ae167056e7d9a92fc854f0741029fa04'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:16 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
