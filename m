Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4476B7FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjHAOsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjHAOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A291BD3;
        Tue,  1 Aug 2023 07:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5FD7615D7;
        Tue,  1 Aug 2023 14:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADCAC433C7;
        Tue,  1 Aug 2023 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901329;
        bh=nT8gUQ6qDAmcesueSE4m0Nz7EwpMx5l0NtHDJ0UaUKc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YNcdFczYzaieRuS9r1BQyiKUAmTILRQLhyy9Bdhw4fY7U6RKJHISLOpTIpTQTWOWG
         qjpntf0uj4YT8FUENS/vE151qxVlzro8RDEMDu3Ix/i6u5DPhWQS9yj019zH+5dmb/
         dQbhnMlk26ZEVpJ7+Y2i5OLH8a12tjJ5q2SlvL4X1sZDHXiKzmBz0v/QRCwyzVe5T+
         x7I2LFOvRrXEnxy2C+T1eaqmUhXbDmAb/NbeM5Rm+XpOP+q9wJkDeq84xVWyYyrmWb
         gihdh3gxke8iWCdpm108MZ2XHbsc385uwa0Ejgod2lvTOgHWmCQUgT5bRbBdsmFX41
         IeBO6cPajX/6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: drivers: Explicitly include correct DT includes
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230724211914.805876-1-robh@kernel.org>
References: <20230724211914.805876-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        wcn36xx@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169090132389.212423.4907787613050355047.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:48:45 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> wrote:

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied to wireless-next.git, thanks.

e7899a90cebe wifi: drivers: Explicitly include correct DT includes

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230724211914.805876-1-robh@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

