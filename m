Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC427D9F03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjJ0RrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0RrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:47:14 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342FF3;
        Fri, 27 Oct 2023 10:47:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC63640006;
        Fri, 27 Oct 2023 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698428828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WR2D2RDvmSAWj8jXXY2dUJL/AUVsNPIfEe2Y4N53brM=;
        b=pxe00/zozNw9ebwfz7DJTNt/uV4g8WwgmKEoDbtwUfrc7z49Euh/ym+12njx95rdmy95sp
        6dijfn/aOyFZKOEPibKN0PFx2x7FyVc2TB3Iy68AuC/jEowZKWhdY/vylEiv5YL2KAcOcJ
        5Nd/p23j32mkMIDtk8qmdbDHlL4ZkGLN4IwKIlFHk1trAmKswPs2/jfsO2fdBMWcmZcjUa
        WGbcpm7XPE82uy3TrjAZIBPnfCWAJbSdMgZIQdfvDxoAEwBEFYugHLFV3XKIzCVFX4dNXS
        /y9xskkSsI1BCf1bhsrk4D79pqVwmPsP0cvXdjsdxOXxMjNxVjH191qgu0Zfkw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, vigneshr@ti.com,
        joern@lazybastard.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mtd: block2mtd: Add a valid holder to blkdev_put()
Date:   Fri, 27 Oct 2023 19:47:07 +0200
Message-Id: <20231027174707.369918-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021185832.25592-1-richard@nod.at>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ff6abbe856342d4a7d5c28a0f7e33838f9f0a873'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-10-21 at 18:58:32 UTC, Richard Weinberger wrote:
> Since commit 2736e8eeb0ccd ("block: use the holder as indication for exclusive opens")
> blkdev_put() requires a valid holder argument.
> So, do so also in block2mtd to unbreak bdev->bd_holder refcounting.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> Fixes: 2736e8eeb0ccd ("block: use the holder as indication for exclusive opens")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
