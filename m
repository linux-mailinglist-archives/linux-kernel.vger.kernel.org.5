Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7789A751A92
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjGMH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjGMH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69D1B6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 575F3E0010;
        Thu, 13 Jul 2023 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/dQ3rIV5hFuFca0hdzW7g9ibvFRuog2dZ3pQ/WJm3s=;
        b=MdoSbR4uJM3s+Qqs6Z21XNSXlMxPWYKIprbQystEpa2Vw1dLDrn6KixrjJhtlyNQmBLA5V
        4H2oaQkkcREd8N8TVcxhBG+1QtgJ4qT5UjpsOK9+sjwoF8iPLLVIUkXZy/Dst859/1jxXw
        mdCdOF4C145onofGqFdrie+BuwJVQw8Hpbjn/40wOt8SKvuQjrbkUoOrx2gLgHRmKmOnX+
        sc4kRiuGbHPWXRIPoYY5fO7chssA/jeR+n0kUtGKG2YUfxLhgVbS0jiXOEVsB53FPlIBk0
        zz3Vhy58h9F01ir7CQ/d9EHPrLvmzPrEuWr9goP5M0sxa+1FEDglyWdckJEoDQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/18] mtd: rawnand: lpc32xx_mlc: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:05 +0200
Message-Id: <20230713075806.486221-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-7-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9cd9dda8f06c9100997e981f11e8ef9cec042a95'
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

On Fri, 2023-07-07 at 04:06:11 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
