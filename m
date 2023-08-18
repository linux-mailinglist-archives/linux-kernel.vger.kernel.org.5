Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1058378140A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379874AbjHRUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379866AbjHRUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:02:42 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51481706;
        Fri, 18 Aug 2023 13:02:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8703D60003;
        Fri, 18 Aug 2023 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692388959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqqEGbGR8a1vZLu2pKvVCNRkRVecAjsILyTXMbDwPVA=;
        b=XNF6bnuL+izKGwy9oyuxGRfqzetz+FnoB1mKsioCNgVLD943l8SY1GOK5zRm/KVkG8StiY
        1N7i5mL8Z4YuQe7QQmjZ1NkgMWotwJwueksvEwXhdm6gE2McpwRaiI/TR48Lic9xN/Ax1X
        5roO5D66kmzh7GGHZXweE4ipLOW67novuhXsarOvZEOUPW/gR08ETNdJ3ZlkKu6smCR0UP
        qOOz/IO1hT8ENE+9CIl5wxBc6SSJhEkMD9KHoGlsiMJXow5NK8tQBvv1kQOsa5HcGThy+n
        rmRY3P5iAJGe4ou5BH3D8mDkg0BBnSQc9cZqLtDG+HpcoHFkVeTIPqxGMYmP4g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com
Subject: Re: [PATCH 2/3] mtd: rawnand: qcom: Clear buf_count and buf_start in raw read
Date:   Fri, 18 Aug 2023 22:02:36 +0200
Message-Id: <20230818200236.149324-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818145101.23825-3-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'318207ffe487bde07e0ef229a9a51c896d66341e'
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

On Fri, 2023-08-18 at 14:51:00 UTC, Md Sadre Alam wrote:
> Initialize buf_count and buf_start to 0 before starting the
> raw read. If we will not initialize then read staus will get
> updated with wrong value and we will see failure for even
> successful raw read transaction.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
