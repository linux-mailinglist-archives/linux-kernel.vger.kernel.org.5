Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF22751AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjGMIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjGMIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:00:31 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354022710
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:59:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0F21240002;
        Thu, 13 Jul 2023 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9bHgahEkdgpUpie4iMYMgevEutUsxc2a6NekUq66V4=;
        b=a2+ZSZ6dYMCshRTzEE8Qww3rpWiUZ7ztiiyMrY3bESKpBt7pC5CX3ptOP8ragBs3JkBBJv
        OrFguyyv1lp76kKsmH2owtjCWBCueBuYEtQVPgC9OLRU8AI1klFaHNhCgFT1fW2KxPWLRD
        wUVXI/tq/zFFVSlRHl4e09e+I/5UZI+xpFIy2X7fYr8jnbIFwbyd4If5mQJnScSBvsLlC8
        dMrlsXa/sWwgJWrT8U9+KuLqUMbay6bLPwDBrtLgaM1lbGuff9UVEPaD/psqCVCF4Mqyad
        cieFprgbQL7QGY2ISie0SYZ0UIzPEMFbDcYAIXJxh5dPF5t5VZTJ55tFX6BqUg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mtd: rawnand: export 'nand_exit_status_op()'
Date:   Thu, 13 Jul 2023 09:58:58 +0200
Message-Id: <20230713075858.486654-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705104403.696680-2-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'079c8d9da26ed041a54706de68b754337e6df17e'
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

On Wed, 2023-07-05 at 10:43:57 UTC, Arseniy Krasnov wrote:
> Export this function to work in pair with 'nand_status_op()' which is
> already exported.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
