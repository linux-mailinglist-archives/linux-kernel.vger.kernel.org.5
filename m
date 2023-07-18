Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E08757508
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGRHJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGRHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2491B5;
        Tue, 18 Jul 2023 00:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694F361490;
        Tue, 18 Jul 2023 07:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E8C433C7;
        Tue, 18 Jul 2023 07:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689664134;
        bh=jVjCTwjBzSyTcqcLvvC5oarH29mwv5OVwc1RA/9/26o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIcxDOif9p4SVoPgODDqYMkYnVTtUfa/qMlOn1c2dmjbwhVH6iKWjufrMS89QMbwE
         2+/PC7pm2KHeRwmG25WM2/hnFmS26/ANJ48UtLXNpWmQQbEkgjA3I4QW1QklvrG/vL
         5JqC2ikIdjozVzlS72tpnX+3b7z1ojbAJBHyXuShkk6b5EvoCa9JOVhBTSHHEcdmip
         NlFwTMpSFYokeaXDYOZIYk6T4CnKiPSBH604ArUP19qI51751mZ0mDjphR2yZeWj0M
         FG/BL0fSYyk8DGE1AUexvOekJG3cAixoSygNUndz3iTsgGVn8QCwnPXa/o/qdo24KC
         UybYXJzd629bQ==
Date:   Tue, 18 Jul 2023 15:08:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        ezequiel@vanguardiasur.com.ar, aford173@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] ARM64: dts: freescale: Fix VPU G2 clock
Message-ID: <20230718070843.GQ9559@dragon>
References: <20230707094200.47119-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094200.47119-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 11:42:00AM +0200, Benjamin Gaignard wrote:
> Set VPU G2 clock to 300MHz like described in documentation.
> This fix pixels error occurring with large resolution ( >= 2560x1600)
> HEVC test stream when using the postprocessor to produce NV12.
> 
> Fixes: 4ac7e4a81272 ("arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

We use prefix "arm64: dts: ..." for arm64 DTS changes.  I fixed it up
and applied the patch.

Shawn
