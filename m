Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1665680BAA7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjLJM01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976DFF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:26:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA2C433C8;
        Sun, 10 Dec 2023 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702211193;
        bh=BAEGOiXxGiji7Yqd9F2gFQ5MrzDwy3Usblm+rgqjv30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k8nHEPhk3gGqCwrGy4zVJCHVGZVUJrtXP12s0QnFTgo441rpwwHWu7J9cxQLgm5fo
         25VuSnGBiBJPU/MC05j/IZpl0rO/tR7SYUFZBgVxsAv3sya85ig2aBXxbNxPcY43ft
         G8Lv8mGh6l5JI7ueaFM/Nwnwe1HTUhhtmZ7wjVyfhq8yBDgCynbpnE6SMlIwQiJL2M
         Ib0TpHBM+ZruKCqrg3mjJ5SP+TKiOeP7BQnGaK9lvBfOcKjpsiwdVEn8A9hA7ZpCDH
         1lgsF7gI/X/u8sHES276XDhc3iPgNsZC3lHc9dlKOgYaOJzbeoVCQ4xSiJ1ymaqS8c
         OjkvVIXTUqI0g==
Date:   Sun, 10 Dec 2023 12:26:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] dt-bindings: iio: Add AD7091R-8
Message-ID: <20231210122624.6a58b8c4@jic23-huawei>
In-Reply-To: <ZXMZ-Y18SwIFEIgA@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
        <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
        <CAMknhBEFnTUm9FPK-74+GkJs2d80dS+Q9WeGTxd3Ajs-JJGcdA@mail.gmail.com>
        <ZXMZ-Y18SwIFEIgA@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 10:28:25 -0300


> > > +
> > > +    required:
> > > +      - reg  
> > 
> > Missing `unevaluatedProperties: false` for channels?
> > 
> > Bigger picture: since no other properties besides `reg` are included
> > here, do we actually need channel nodes?
> >   
> 
> The channel nodes are not used by the drivers so we can remove them if we want.
> I thought they would be required as documentation even if they were not used
> in drivers.
> Looks like they're not required so will remove them in v4.

A lot of drivers assume that if you paid for a device with N channels you
probably want N channels. Of course there are always boards that wire a subset
but it's optional whether a driver cares about that.

We have drivers where not channel nodes being supplied means they are all
on so this is extensible if we later decide that fine grained information about
what is routed where is needed or need to add per channel controls.

So fine to drop this.

Jonathan
