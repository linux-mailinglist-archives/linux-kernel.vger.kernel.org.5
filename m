Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3797CA422
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjJPJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjJPJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:28:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF61E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:28:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C306EFF803;
        Mon, 16 Oct 2023 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/ny36PTyIOVrCHodnezxrX1n8CcGDnBOfmpYzvGvo4=;
        b=Vc+bNg4BLGnHTjzRzZDuWxsTnOh8QHkBO+O98swQCqKGQ+H2bE+mS3cRYx/yleQHf6yLFC
        YDJf6YqIe1IyC8gExtkQZZfw3Fk0m0hE7KAuy3ACmCL3B/UVFRqPAyWW3+cz/9zPDt2Xd2
        aBJDckGvUzsRi7qzSEWUUMrEnI/zBMDh7Q/L2fIx2X/PflI6neRjEQyxKVs2lhO0JiVKvn
        NSTL50FZw/iyxiAKn6AbLZL1CMTEJHF3+n7NF1jKYYBS9fx1+/Zs9jrxIvLpLmZ3yLliP8
        TxzD4IkPtyhsPTHz9Z126T5qgoykKrr1amEnMPt0kJyzNFUP7yEWS/1031Kiqg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] mtd: Add WARN_ON_ONCE() to mtd_read() to check the return value
Date:   Mon, 16 Oct 2023 11:28:44 +0200
Message-Id: <20231016092844.288967-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065733.3240322-1-wangzhaolong1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0339f62a9a778bb7cd4f764cd4640cc89155177e'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 06:57:33 UTC, ZhaoLong Wang wrote:
> If the driver cannot read all the requested data, -EBADMSG or
> -EUCLEAN should never be returned.
> 
> Add a WARN_ON_ONCE() to help driver developers detect this error.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
