Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C077523E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjGMNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjGMNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EACC1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB89612E6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CFFC433C8;
        Thu, 13 Jul 2023 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255261;
        bh=jYzPgQnf1TaaL1US+K04i/G+98207d12v9hEK0Jivt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSBXQCqpuJNHv3gH8O1XFfQXEQcmsxUKzg9XYQgQDlSsS1WoWFKHupUoPjlmdDscg
         mcDYpoWc0zIkZWKyG2s5oLH/w6771wtPfrD4ydYkv26VJJhKfNxvoJ6OEZ4+6LEFjy
         SrhiXmK660ly0tElFsyETGq1b01oAWXBz68+SZc8+GcArdBw+sgoHCNmtNOpqbnXOJ
         KeH2odwPgtn9dGlDMWGhpT1wGUl+/L4goTT6nS7KU5PtNeTWxIe0zkAZcMeZUptapO
         Ax5Sxry1qIHszz/SKHyag6GACeo0Hne41HftWEbl6Qg4vztzbNeCw+RLFTkp+BfMjj
         Wy5A9Wp8a3z/A==
Date:   Thu, 13 Jul 2023 14:34:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rk808: Make MFD_RK8XX tristate
Message-ID: <20230713133416.GU10768@google.com>
References: <d132363fc9228473e9e652b70a3761b94de32d70.1688475844.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d132363fc9228473e9e652b70a3761b94de32d70.1688475844.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023, Geert Uytterhoeven wrote:

> There is no reason for MFD_RK8XX to be bool, all drivers that depend on
> it, or that select it, are tristate.
> 
> Fixes: c20e8c5b1203af37 ("mfd: rk808: Split into core and i2c")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
