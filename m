Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E17583A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGRRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGRRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90790E6F;
        Tue, 18 Jul 2023 10:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFD3616A8;
        Tue, 18 Jul 2023 17:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC501C433C7;
        Tue, 18 Jul 2023 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689701844;
        bh=J43/S4lutq118/A5V7YO0P4DU+erOplZ6RTbTJcyXXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1LzwR5aDD8TXdJqJdZSkB7/GA6wxpVZ6fnubikPocdmnJ5tem7vZpnYowJFNbdIi
         B1YKxGR2ON9JVPgHbhs6Nft5EBG33UVV1yPBgVCT7qoqW4ude4jxxQovdxRjZeiFYp
         v+Mtz00ppX7ZIVi3E12AW8rwY5jgUivU7D4xW2Pw=
Date:   Tue, 18 Jul 2023 19:37:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4
 boards
Message-ID: <2023071850-festival-illusion-6399@gregkh>
References: <ZLbATQRjOl09aLAp@zephyrusG14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLbATQRjOl09aLAp@zephyrusG14>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:09:41PM +0530, Yogesh Hegde wrote:
> This patch fixes an issue affecting the Wifi/Bluetooth connectivity on
> ROCK Pi 4 boards. Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
> on ROCK Pi 4 boards") introduced a problem with the clock configuration.
> Specifically, the clock-names property of the sdio-pwrseq node was not
> updated to 'lpo', causing the driver to wait indefinitely for the wrong clock
> signal 'ext_clock' instead of the expected one 'lpo'. This prevented the proper
> initialization of Wifi/Bluetooth chip on ROCK Pi 4 boards.
> 
> To address this, this patch updates the clock-names property of the
> sdio-pwrseq node to "lpo" to align with the changes made to the bluetooth node.
> 
> This patch has been tested on ROCK Pi 4B.
> 
> Fixes: f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth on ROCK Pi 4 boards")
> Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>

Why are you saying this fixes a specific old commit and not also
properly cc: the stable@vger.kernel.org alias?

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.
