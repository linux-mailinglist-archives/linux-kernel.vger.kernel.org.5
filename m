Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47775C095
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGUH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGUH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E322726;
        Fri, 21 Jul 2023 00:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A036561666;
        Fri, 21 Jul 2023 07:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82059C433C7;
        Fri, 21 Jul 2023 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689926340;
        bh=N2PEMeZJ9b5SlVCWEYVt1aINdwFqkHLWjucVt4NofwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsQ7i225uLYOP+wwcVtk4oiybbfHVs8yBptuTohptP2nr9RTaHWGUDvySJjvNfwK/
         Vew/Jl5uhEchZqZnyEOgC2nCbdK0Kvwg+tzh0W6/6MVXa1SDcW+ERv6E8FgAuUsSO8
         T2EKulha+honeEia9gL2/os3UYzzbl1/rZszf0zFZvbfdhVfJzPNFAu0A3c7wu9IPA
         uUBrhzS53wKSUNZ7hlNwZGalLl2R+LBsZOHq8viAPa0i1i0TBkB+uupnbuJrVAIf9u
         Yt2lZklJQ98YM/9mIVdDX2LL4K9xmuQ9I5uEjyoR0hlhw1Q0EHXlUBOW738Ww8la5g
         25PMraWhMxb4w==
Date:   Fri, 21 Jul 2023 08:58:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-ID: <20230721075854.GA1908841@google.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
 <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023, Lee Jones wrote:

> On Mon, 19 Jun 2023 10:56:17 +0100, Charles Keepax wrote:
> > This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> > SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> > branch.
> > 
> > Thanks,
> > Charles
> > 
> > [...]
> 
> Applied, thanks!
> 
> [2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
>       commit: e62ba8443b11f12b45c61444249458a2f8c2f4ef
> [3/6] mfd: cs42l43: Add support for cs42l43 core driver
>       commit: 843079209e1506c94fde797fc0ff914e2c9e6645
> [4/6] pinctrl: cs42l43: Add support for the cs42l43
>       commit: 85f034dd7ff0a66aded653cc91dbc406fba7cf1a

Pull-request to follow.

-- 
Lee Jones [李琼斯]
