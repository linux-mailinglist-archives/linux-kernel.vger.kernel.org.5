Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC0751A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjGMH6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGMH6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488210D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 863821BF210;
        Thu, 13 Jul 2023 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0bjV29wYjqB+q/N2ZyF/FiTtB3lwfxaqS2uYRcMBcI=;
        b=XTspBV1M0r3b/VnnxufJIYNWdA4BhMTNO5ZtwPhoSgNhUk6eAzpNB00p1fSiz9+WCd2rKA
        Nxgjx5bLM4SmqQXXIHZyZh8PxLzId6TETat+Vh4iXrpdb8PN/sAO5HuIlx9sabcSh/C6pv
        SFrasJcnHUUyk7KBIEJGtk51HyNRHgGxNPpPS6sTXdZcQ9Kl8YguCHv/qPOMJ5OaogRmNV
        rCql6k0GUhIkWdI/uIedHXEPUQnorGBTAR73FPj15wRpViPuJe2lH5KA2GPh+v5itxN14/
        nQyYBOis2hoOLT0dHg91bucZiNO2ahwGlipP0oxECqrlx8UI5GH11HSUDaWdGw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] mtd: rawnand: mxc: Convert to devm_platform_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:19 +0200
Message-Id: <20230713075819.486335-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-3-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c96b3e0905b41cbf8e369faa1e4decded58860b5'
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

On Fri, 2023-07-07 at 04:06:07 UTC, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
