Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D003676DB3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHBXEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A23123;
        Wed,  2 Aug 2023 16:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A04B61B7F;
        Wed,  2 Aug 2023 23:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CCBC433C8;
        Wed,  2 Aug 2023 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691017468;
        bh=AyckQbINUXyvMIJTDA4FvQVV7MtXBC3frps+2v05rDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLmEHvkuER6UeMI6RiY7RXRNJX3AyMg/4Yds8SA7hPLDCdecDjVsKUBqHQzg3tDq1
         Dd1g2hZU3/YZfzKd38CaEJqMEr4cxjNj10Oac4boeHiANhUJs2ExFnt1V2wC+7sV1R
         tNHkcefYD6H36QKFcgCxdkeSdQY0K0i0hIie0jPV/c/rO+Dq3XqCWHq67jUg7Qtv+o
         MmGpJM0Hro2TlL4Mhb8hWinTXjeL3Qv3Ebs5WzWjiASL4Mo6ou7S79aF8ZomunadQk
         zzPvJRVDEVCrFuJYn8QaTKjuFj9ox13Ga45u7JkG0Q/aBdglsylkPrxJf9J0/Pkce4
         oFa6qMgrrx1Fw==
Date:   Wed, 2 Aug 2023 16:04:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Sahin, Okan" <okan.sahin@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "zzzzTilki, zzzzIbrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>, linux@leemhuis.info
Subject: Re: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Message-ID: <20230802230426.GA3027248@dev-arch.thelio-3990X>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
 <20230726161033.GA1102409@dev-arch.thelio-3990X>
 <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
 <20230727145143.GB2013261@dev-arch.thelio-3990X>
 <CAKwvOdnPQEdbTGBO0hBn7CC4d0xtRV2zmfrYDfAhH0stfDYeJA@mail.gmail.com>
 <32af6891-8246-46de-ba1d-ae1999f6eb10@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32af6891-8246-46de-ba1d-ae1999f6eb10@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:02:38AM +0100, Mark Brown wrote:
> On Wed, Aug 02, 2023 at 03:52:52PM -0700, Nick Desaulniers wrote:
> > Hi Okan,
> > Have you sent a follow up fix? The build should not remain broken for
> > so long.  Otherwise I think Broonie should drop your patch.
> 
> Someone sent what's probably a fix but I was waiting for some
> confirmation that the change actually works on hardware, it's not super
> obvious.

Got a pointer? I don't see anything on lore:

https://lore.kernel.org/all/?q=dfn:drivers/regulator/max77857-regulator.c

Cheers,
Nathan
