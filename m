Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E517B1C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjI1MXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjI1MXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:23:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A0A139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:23:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D49C433C7;
        Thu, 28 Sep 2023 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695903790;
        bh=FhiCLuXE8xs5g1A7GLVUNFyMEugHawIxGqltKFYikQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4LSdgPYPgVEwS6xsCENhOeWsGBpCMYKUdabc/3c0vS1/50rScD+6wB+OtF/r1KdN
         Z1cAaMCwTV97ZYYwDussm0Y8XhNQL29pqDaCYkkjg/ptMiJ1WjSu65DOFhGq22KTyR
         AAkZSqOcJH16/b5tgVyhPoYPQy7sYDvadILrgqbQ=
Date:   Thu, 28 Sep 2023 14:23:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Message-ID: <2023092835-educator-cardigan-1ae0@gregkh>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-3-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928092804.22612-3-eliza.balas@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:28:04PM +0300, Eliza Balas wrote:
> --- /dev/null
> +++ b/drivers/misc/adi-axi-tdd.c
> @@ -0,0 +1,780 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

License comment, why is this dual licensed?  You are calling
gpl-only-marked functions in this driver so attempting to say it is also
BSD is quite odd, how are you going to resolve that?

Has a lawyer agreed with this licensing?

Please get a lawyer to sign off on your next contribution of this with a
dual license to ensure that they agree and that you all fully understand
the legal issues and complexity of attempting to have dual-licensed
Linux kernel code (hint, it's not as simple as you might think...)

And document in the changelog _why_ you want this to be dual licensed so
that we can all review that as well.

thanks,

greg k-h
