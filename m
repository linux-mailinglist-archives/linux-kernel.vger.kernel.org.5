Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E516A780E31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377877AbjHROmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377806AbjHROls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:48 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083A13D;
        Fri, 18 Aug 2023 07:41:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0342E1BF20B;
        Fri, 18 Aug 2023 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9QTvLZbMsGHxuwSW5o3DQhI+aymS0RLjYYjz49XEkms=;
        b=e6EHFd5NenKZLOm/7CrIZR6/ZleVoHK3Y1o8UKl4KrGBli3EXikGzukq/ZBY1j5/VOKvIr
        YGsxj3pLD5Ci/cDgwnr8l9fvF7OgYoOzL5bUlDizwMi/gHHV9WLQhWf246b0VS8K4eelt6
        YSG2luMkLxwqZn0115l3f9cuskKUHpEGBEI6OAfZBBjgYypVqC8v1+/BAau0k+w9+IRUVg
        8Q22PDO6Ge8rDaInLvbGDX2HO44Zxtx+j85AgpCbRw5BWZCKK+CiOiwhfkmP8k5vyEVvyL
        wWokiWnfZk28jNxXmHa3ex/EerdlEywFhegKWxiwf/DglevoUGjaX+CT83M/Rw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 01/10] mtd: rawnand: qcom: Remove superfluous initialization of "ret"
Date:   Fri, 18 Aug 2023 16:41:44 +0200
Message-Id: <20230818144144.146143-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-2-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'847178fe4ccdf7f70beddd91eb15481afee0a224'
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

On Sat, 2023-08-05 at 17:41:37 UTC, Manivannan Sadhasivam wrote:
> In all the cases, "ret" variable is assigned a value before returning it.
> So there is no need to explicitly initialize it with 0.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
