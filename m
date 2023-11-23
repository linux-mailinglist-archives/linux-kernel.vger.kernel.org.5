Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29397F5A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjKWIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKWIqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:46:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F9B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:46:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530A8C433C7;
        Thu, 23 Nov 2023 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700729211;
        bh=Gq20ZxmRSolswgb2G6DXtsmXB3yMAbJOuI31L5TBSvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ60Yr4DHag7rgtwu1Xlu4ys4dLSAzfk2xaEutrqND8a7Cfe3F2HaIwRyEzf5V3lH
         CbdrFnhEu6B+2+P8kB4bcdue0LBn3tl6xlZ+E+0nXAjVf94mMxh+lJuOTwbrj1IRSF
         irs0N2HnR702RPI5VU6RyAyZibBpqZ7of6MTz8YYJO3o9g9n8dlD7dPPax9iEvUEX5
         l3JbX4YU3G7gwSELyPj3UGaQmvs52mx39001YLkRS7gSFnA3HDi/Ffi8w47objMAY0
         rTnT7BjPjP0JcEv6oGcf5j0yTXKVoEUDCIOr0YxcLphcdib5QuNheyVHgoERf2BQfI
         PUk+uejK9V/fA==
Date:   Thu, 23 Nov 2023 14:16:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
Message-ID: <ZV8Rd9XanZEWEYJN@matsya>
References: <20231030190113.16782-1-rwahl@gmx.de>
 <akeklf5f3alqemdlssdgimqqqvkvbtqbbq3pxtsgkykma4fv3o@4op25kcmguja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akeklf5f3alqemdlssdgimqqqvkvbtqbbq3pxtsgkykma4fv3o@4op25kcmguja>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-23, 13:32, Jai Luthra wrote:
> Hi Ronald,
> 
> Thanks for the patch.
> 
> On Oct 30, 2023 at 20:01:13 +0100, Ronald Wahl wrote:
> > AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
> > This also fixes the thread numbers.
> > 
> 
> Please add the Fixes tag so this gets backported to stable
> Fixes: 5ac6bfb58777 ("dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data")

No need to add and post v2, b4 picks the Fixes tag and applies

-- 
~Vinod
