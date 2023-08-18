Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A7780E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377850AbjHROl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377802AbjHROlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:37 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651C30D8;
        Fri, 18 Aug 2023 07:41:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19F071BF204;
        Fri, 18 Aug 2023 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4boPha15u4pwIkLZ4/5I8jzI/YgM/ESZY3KWwaz3xbI=;
        b=JAoJKAaA4UlX1rhx3W4eUAII6YxhUdN/hhP1uIQ+n8y3VIVWt2XyA7Oapi1fJX4PyuHYd6
        sTsHabPPrq951kexa3RZjKmlwGy/r+r1T98DVnGn9quYQh0+MEeH8LEFF6eNhM5tSSy35K
        YO8M5rmJsrb9R2IE3xMHnbXo3nJcr/X4QXVrAQc4G5oyKfwg1kZv6Dgonc43VOhNat+j7r
        NZE+hfEskeekr5Y+F5VPUnCETdmgMfQQffIOHUUtnAHuMC16uANnswjNnpiGp/R/fSbqE2
        oK1FIMWs6vPSLNMVrZxDpVbJahmNUJvHyVE6UIkcF97GIDCzS+dMp+Ms2OlOSg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 04/10] mtd: rawnand: qcom: Fix the opcode check in qcom_check_op()
Date:   Fri, 18 Aug 2023 16:41:32 +0200
Message-Id: <20230818144132.146053-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-5-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b4bb4800313de0d8faa5615d4943615ff56c1cc2'
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

On Sat, 2023-08-05 at 17:41:40 UTC, Manivannan Sadhasivam wrote:
> qcom_check_op() function checks for the invalid opcode for the instruction
> types. Currently, it just returns -ENOTSUPP for all opcodes of
> NAND_OP_CMD_INSTR type due to the use of "||" operator instead of "&&".
> Fix it!
> 
> This also fixes the following smatch warning:
> 
> drivers/mtd/nand/raw/qcom_nandc.c:3036 qcom_check_op() warn: was && intended here instead of ||?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202308032022.SnXkKyFs-lkp@intel.com/
> Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
