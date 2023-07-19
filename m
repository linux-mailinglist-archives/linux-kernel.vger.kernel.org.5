Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04453758B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGSCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGSCOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53EE12F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DC72616B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580EBC433CA;
        Wed, 19 Jul 2023 02:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689732872;
        bh=3HLKChLyL9JPdyst9k3t4LgRUL+54IFiq42lL+w+5lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dP/XljB6NcpUifVaaNB7oN3sgrjiEUuOHHVDYcA8KjnBtUzTKC8OTcab4tHxgwyPR
         iuFXVtcxobS7kXy8cf5SgPE5fPAkEw6QOBJilBbZUipo+lqGVVym7LeACFjN9y36C/
         YHZuSt2Wa8X45BCvMhFaN6qcOrIwFG70kUoLsiMVfzRjj9KP2o527LKUOYjbZozyTa
         jwkc6yTxoUBiTHcWkMoQ1r9lf0pqe9dCnl7Bz7hI35omdlFx0OanO47RK1F+0dKaz6
         2mlySK6qIllov9EBX9NpqTAHieLdBUryJTuF3xGS9l4eCupPJNahVTMSM77bKieni4
         o1nBrhzyE46UA==
Date:   Wed, 19 Jul 2023 10:14:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: use devm_platform_ioremap_resource
Message-ID: <20230719021422.GT9559@dragon>
References: <20230709133945.182307-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709133945.182307-1-martin@kaiser.cx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 03:39:44PM +0200, Martin Kaiser wrote:
> devm_platform_get_and_ioremap_resource maps a resource and returns its
> physical address. If we don't need the physical address, we should call
> devm_platform_ioremap_resource instead.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks!
