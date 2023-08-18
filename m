Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B067780E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377861AbjHROmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377804AbjHROlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:40 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267C13D;
        Fri, 18 Aug 2023 07:41:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C18D01C0005;
        Fri, 18 Aug 2023 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxxmUiGvT5UOOmJLgLDViUnvtWQ82iV7h6JU1NSs8xc=;
        b=LBGavffUz1CqYCyDJDNY7VuvaYwyVwlqwJR4/u/CgAI1UgppMC+VeRzk0kl3nd5cvCuVO0
        Y66SrcNJy2PhQ6WkGGI3h03JdGEqm1bHmoLeaYe2sPhdRGHaiIZ/f0Ymv19JWR94oAkUgo
        85GpX3IxOzvx0d3vYUKMVZEz3wMU5YeelrHXGFFRvVDxkAcGv1C0P7O4aF6TQwoyISG+vB
        XEB6JltfC7tAUcD9VhjLrII3sDs1wpDPC4N2Ychew/bRatP3Mxo/50yxkurNEX4nTrLL+j
        +LyVAVtKclUb176E+RNHuRk396TPAturjwXLMH7UfWdGGV9S9EZWMJi//oWeOw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 03/10] mtd: rawnand: qcom: Handle unsupported opcode in qcom_op_cmd_mapping()
Date:   Fri, 18 Aug 2023 16:41:36 +0200
Message-Id: <20230818144136.146083-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-4-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'dd3c8f4ab2035bdba41c840a7daaf1cc735f36bb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-05 at 17:41:39 UTC, Manivannan Sadhasivam wrote:
> Handle the scenario where the caller has passed an unsupported opcode to
> qcom_op_cmd_mapping(). In that case, log the error and return the
> -EOPNOTSUPP errono. Also, let's propagate this error code all the way up.
> 
> This also fixes the following smatch warning:
> 
> drivers/mtd/nand/raw/qcom_nandc.c:2941 qcom_op_cmd_mapping() error: uninitialized symbol 'ret'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202308032022.SnXkKyFs-lkp@intel.com/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
