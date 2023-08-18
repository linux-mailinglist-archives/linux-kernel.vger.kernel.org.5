Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2752780E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377832AbjHROl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377793AbjHROla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:30 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB94C30D8;
        Fri, 18 Aug 2023 07:41:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56F46E000A;
        Fri, 18 Aug 2023 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yld0FzR6F0CNi0vpEAY11IySucmtoTiH1jcXNX7iZ8c=;
        b=U1arqpZMVyGJ2r0hHLcPGfuT6a/IjpOUIlES/h2EOl04zB5kxV9PaQiclkxaBKkO29ds6G
        M68dLbmDJh/mMU6elsabezrgRyrp/0m7YSlyluFRqxwOB7pyPR/8UzTgAl2qLe7qRNGBRx
        Ah6JDS1Ly81hcUosAj0V4c6yym/byXr4DDWpzCJ41ExrcE5b+3vqH95h8Nx9qsk1oYZsdo
        3UbBzwekgM0UgEEEnn1pP8s/WzilujlArx7LD5T4GUI3wpoNKqRMI1OJfVH7I2HWGaL5ME
        9vOvf8d7YktEFqrE1GixKTxRjW6yN3mF3gAb6Es2JlXqEnRcyukfLmUFv4xKPA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 06/10] mtd: rawnand: qcom: Wrap qcom_nand_exec_op() to 80 columns
Date:   Fri, 18 Aug 2023 16:41:25 +0200
Message-Id: <20230818144125.145994-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-7-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'cf82436dd831a87c87f3d625a527a9ee35ae6f4d'
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

On Sat, 2023-08-05 at 17:41:42 UTC, Manivannan Sadhasivam wrote:
> Both the function arguments and the definition could be wrapped to 80
> columns to save line space.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
