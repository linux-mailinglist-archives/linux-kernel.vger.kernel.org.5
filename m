Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7243A7CA423
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjJPJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:28:58 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C8F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:28:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B53AFF809;
        Mon, 16 Oct 2023 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcfKaPMk4ICJkrPPn/L7fgIsoFc6RYVQUdVPA9Z0ZZc=;
        b=VjRrvwb51Qdx/Ts76oInryFb8kRkNMoEXAFV5h3Taz7MB7FOqwITF+a5fFjWbCXxXjkoPK
        6unqVdNgFB/OaojhZHcYU3TkpwhNZthYgG/ggRskZC8v6tcdrbyiagW/RALQ2Nu6A4OMZy
        87KZj7VB+CZiukPiNqtjfy4/h2kyD9lBffrX4rZvdrahZj9o66NTadfz6YzFYjNNUJ8nfp
        8wWweVTCWxOfhHHU49PeS3BZ74OGyy7If+ZCKvBaiOLC65bxxUVwpK7SlQYYdVtC9/I/rB
        +QsS4NEOpFr9TvEwhVyXF0JRYhWXlBC0qfC7XAaQyUMWHnbn9KoqdcC9AZQShQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sridharan S N <quic_sridsn@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, frieder.schrempf@kontron.de,
        mikhail.kshevetskiy@iopsys.eu, olivier.maignial@hotmail.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Md Sadre Alam <quic_mdalam@quicinc.com>
Subject: Re: [PATCH] mtd: spinand: winbond: add support for serial NAND flash
Date:   Mon, 16 Oct 2023 11:28:52 +0200
Message-Id: <20231016092852.289052-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012064134.4068621-1-quic_sridsn@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6a804fb72de56d6a99b799f565ae45f2cec7cd55'
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

On Thu, 2023-10-12 at 06:41:34 UTC, Sridharan S N wrote:
> Add support for W25N01JW, W25N02JWZEIF, W25N512GW,
> W25N02KWZEIR and W25N01GWZEIG.
> 
> W25N02KWZEIR has 8b/512b on-die ECC capability and other
> four has 4b/512b on-die ECC capability.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
