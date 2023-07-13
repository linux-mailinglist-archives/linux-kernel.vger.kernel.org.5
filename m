Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66733751A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjGMH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjGMH6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:10 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C1A2738
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:57:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB5DD1C0009;
        Thu, 13 Jul 2023 07:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzbnWBipEyKzakFN5m3gXHXFc+Lw91kYYGSsbgUP5ZQ=;
        b=czmms+Wv+tNI6e+tbSPNxh6A13/JM3TZk915BKDg9bA6R/Jlsf1qC7fCTgU8+tyub0jSs/
        uLf2R5MqFdqHTf+o4XmyUO8xUMrpLyP2QDZaTXxZRdVxO9VJzYcXSr1JrJIutqmpOp3oJQ
        JOa/wE8O21FWlCMwkriiB43xt0gAZ95clutJgfxum4gliSMFP59bxcjOEKmnA2o3jF1uqH
        x8rFJpmUFN6dM7KNluADa/y0Y2eFZym+OpfTU7B9LkOrzzuI6V9CtqtVJg7idiWmCabVfw
        DH0PX6TNsmH1ei8EEkQPt75Wx71sZCrbg0nYIoPUJsY2WWtu3c34KWR7mFmANw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/18] mtd: nand: samsung: Convert to devm_platform_ioremap_resource() and devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:57:55 +0200
Message-Id: <20230713075755.486104-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-11-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'717a53833d0b0d735df82f041d1d000afa768cf8'
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

On Fri, 2023-07-07 at 04:06:15 UTC, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() and
> devm_platform_get_and_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
