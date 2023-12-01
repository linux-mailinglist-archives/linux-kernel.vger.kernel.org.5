Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230F28009F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378563AbjLALak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378544AbjLALai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:30:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB75CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:30:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5FCC433C7;
        Fri,  1 Dec 2023 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701430244;
        bh=R0BURlPt9pn7cRC1T122gXwCEky0SoXm6oQC0WCEAMA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Lh3bIljPxWvK4HWlXXuZhft4O1gsvmFCJas4m+URgesbPamef/9vB5SEeEo++OMBI
         AR3ksc5WwZEfKEwUmtQ1HF8E+P95TJgsF1rj373Ybe2ho1tJxcM9r6hltLz8fZNo7q
         QRVUZCr3+r/vjQYnpvwAOIlteyV4igT0SOgFvHom3zigqxb2IBJDMGv5Hch63U+Kfl
         0FU5bdW0cnjoOGWu4H3BB1N1rHsg48xDL4xgodrCBN+StoxNr3d4+unTrJ2pLa6k3c
         qoaeWonVTDmtsVL93XxwbtwgDyDu9d9x3iO4EA4PVKCBtu40L+MNxBd5kvWfwsPdFu
         LipZ/RuhiVgaw==
From:   Lee Jones <lee@kernel.org>
To:     tony@atomide.com, lee@kernel.org, robh@kernel.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     wens@csie.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
Subject: Re: (subset) [PATCH] mfd: twl6030-irq: Revert to use
 of_match_device()
Message-Id: <170143024270.3373744.599680244503281704.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:30:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 13:48:43 +0200, Peter Ujfalusi wrote:
> The core twl chip is probed via i2c and the dev->driver->of_match_table is
> NULL, causing the driver to fail to probe.
> 
> This partially reverts commit 1e0c866887f4.
> 
> 

Applied, thanks!

[1/1] mfd: twl6030-irq: Revert to use of_match_device()
      commit: 6caa120c47c6f8ccb94c4a1d47e44c17de04057a

--
Lee Jones [李琼斯]

