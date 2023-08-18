Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C77780E28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377817AbjHROly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377779AbjHROlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:22 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E6E13D;
        Fri, 18 Aug 2023 07:41:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 693B4C0003;
        Fri, 18 Aug 2023 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JL8VnhWsZioufp73fM1Z9QHnAnuH4IfQprUTEmxqQC0=;
        b=g6DYzWAGwbZKQFOBEloy7GG6QL7uZPtqY+DHNwf/A6H8o5Wpe8mhioOThew8RibHB9oz1W
        kDgt5u77r7FILjbcud3tpf36LTjUB6/N9MyWNqt7U3vD+Fv2hCRgP7p71EvhTPhDsKxGoK
        0E2Mc5M0ZQ5IoAfwACxIUeNxTN5yStyTmjpZbYoTAS5NrrsQM/r02vjJBRsa6wHqZLIluH
        SVKaVj0eTCR58YbW+eVxU7ptZ/6JrpIP/ZKRvBE83n90jKAWHr1cWitZZVupHiWJGl0nWt
        yGblCb/v5WYzbss5Eik2a4fSYagngyla6+xAKu+OOhXx/sdThIE+KkzDUTwsRg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 08/10] mtd: rawnand: qcom: Simplify the call to nand_prog_page_end_op()
Date:   Fri, 18 Aug 2023 16:41:19 +0200
Message-Id: <20230818144119.145938-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-9-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c56de1e5b916154afcaa9f4df46f685cae75f173'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-05 at 17:41:44 UTC, Manivannan Sadhasivam wrote:
> Now that the dma desc cleanup is moved inside submit_descs(), let's
> simplify the call to nand_prog_page_end_op() inside qcom_nandc_write_page()
> and qcom_nandc_write_page_raw() to match other functions.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
