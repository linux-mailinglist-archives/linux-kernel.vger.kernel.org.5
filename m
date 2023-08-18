Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B1780E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377839AbjHROl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377797AbjHROld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:33 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32713D;
        Fri, 18 Aug 2023 07:41:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF131E0004;
        Fri, 18 Aug 2023 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxaYZ7yDiLnZGQNGRO2Cl3NLYWufVEdVB7s9OZJ7av0=;
        b=RjNYS08dOA3EvGrqXUxQP22+bDYVRFBEE/fvB8Mm9iSulT6ozD3tlUuzBQQV0iNx3sXEr5
        FJJeusj1wXZlfV99hOMlkKAKDaZvDljcxxfVwD01hOQQC2UbUfolUjqWdkz4nvSTk4nNkM
        tIhBOtlEgGknA2NLnp9hM8K9efvRBLjkRl0FIbDd6Ac1uUQHbY9ZYeSwFUG7VSVHy7Z8QQ
        OIUbcC5citUT0IM0K+1kU0Te1TNdcs+fAqlms1y6wVs33qdZPLzzdzvVsS52dYx8Ksa+7h
        kM2pn0uE1we7Nf3HSP/ULMH7KZLWt0MmzTIfolDPG+JWPb2L8dN5BJEJL7NY1w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 05/10] mtd: rawnand: qcom: Use EOPNOTSUPP instead of ENOTSUPP
Date:   Fri, 18 Aug 2023 16:41:29 +0200
Message-Id: <20230818144129.146024-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-6-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ab15aabac028afd4889745239a1860a76598e79f'
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

On Sat, 2023-08-05 at 17:41:41 UTC, Manivannan Sadhasivam wrote:
> Checkpatch complains over the usage of ENOTSUPP for new patches as below:
> 
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> So let's fix the error code which is already present in qcom_check_op().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
