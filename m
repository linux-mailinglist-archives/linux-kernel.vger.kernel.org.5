Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B783751AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGMIBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjGMIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:00:31 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF52702
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:59:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1ED72000F;
        Thu, 13 Jul 2023 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lr8NnR15dZIZ9ezMU+VjtxkgNV7Zsb3wb9geDn/0N5U=;
        b=OlR1ulMD9fMlMWYZMwlaTvlSSEsUeIIEtzJkKhbx6F9qSbX7BIwuP/7odoomEDJIbCkRiW
        PxCEisuPHpjdjIi1WtRDuXS/yqhENQ4SKPYtkpOth8n6QwgGp/NEENiW8Mu4aYe///6H5T
        67cqYDjc4IcKlu9E7BQMNyyi5aDv0B9U23UX6uem37rpY+go3LBgfbaiKeRwMZrXp6zBJF
        4xpI6+LZtMxANw77MDJv1WhvWd0L/8+17KSjazZFtGugqhyEcDvFn7UXIMs8+wN/oKh616
        CXsLBxMjmiSxPn1iNtwv7N5439uJUqH0Fprz8IGyJzRW6E8MeY8Rsy009rFAVw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sridharan S N <quic_sridsn@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, ddrokosov@sberdevices.ru,
        gch981213@gmail.com, mmkurbanov@sberdevices.ru,
        quic_mdalam@quicinc.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: spinand: add support for Toshiba T{C,H}58NYG{0,2}S3HBAI4 and TH58NYG3S0HBAI6
Date:   Thu, 13 Jul 2023 09:59:21 +0200
Message-Id: <20230713075921.486794-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623045757.30055-4-quic_sridsn@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'dabd64be75ae38be09c35ea66037d410c68bc322'
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

On Fri, 2023-06-23 at 04:57:57 UTC, Sridharan S N wrote:
> Add support for:
>    TC58NYG0S3HBAI4 - 1Gb SLC NAND flash
>    TH58NYG2S3HBAI4 - 4Gb SLC NAND flash
>    TH58NYG3S0HBAI6 - 8Gb SLC NAND flash
> 
> All of these has 8b/512b on-die ECC capability
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
