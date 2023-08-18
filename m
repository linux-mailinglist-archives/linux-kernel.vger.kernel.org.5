Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85E7780E23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377800AbjHROlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377785AbjHROlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:19 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E713D;
        Fri, 18 Aug 2023 07:41:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 552304000B;
        Fri, 18 Aug 2023 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLAseE1T0hWy5Y5VYaJohb6YUOHEOK8PID3n6/GDsDs=;
        b=FT/XC3e/DgWNjIC9vgKskc/heRbRSqFAnhX5NDA1H5anIEQPZ7f8T3Em97px30vWeeF5Cc
        vdtqb7bzZECb2qvLNFhMCE1UOBaHoQmLKyLy1yA1Yj9WqMP/Qi8a10D2QRkPLTPy5XjEWg
        sukjYLE6ZyWWd6uleEgReC66zc8ZqeT9HH5Q8YKPsr+0eM/tQSCl6wn1XEQyepLfXO9Fb8
        HbltG+z38N5Mnu9FMAwrubpevg0XZJRZTc3zv++tUNSapKoZvSaqFyLp/w7Mi7h5+7Cmjn
        B1wVgTxpQri38awlGQmZppqxddEykyGp7AvsgkTmdrSggaTdwpaGt+t+6favdw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 09/10] mtd: rawnand: qcom: Do not override the error no of submit_descs()
Date:   Fri, 18 Aug 2023 16:41:15 +0200
Message-Id: <20230818144115.145909-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-10-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'dcd1e618b6cb59b87eedcbaae184dfa982689b01'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-05 at 17:41:45 UTC, Manivannan Sadhasivam wrote:
> Just use the error no returned by submit_descs() instead of overriding it
> with -EIO.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
