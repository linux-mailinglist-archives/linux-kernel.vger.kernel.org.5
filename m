Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05A27A4C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjIRP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjIRP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:26:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45DC100;
        Mon, 18 Sep 2023 08:24:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5744C3278A;
        Mon, 18 Sep 2023 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695048038;
        bh=72A3RMIZJmHx8XBk/HX5om5J8tMSKPisdGFQjimNloY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K15hjWmAXXINZIdK+qe8cDfi7qyrC+LpFHt2Kw8DsEfq7LWdUA3gozCcNTIZEau/L
         Lmd0xPiS1yfrDRe3VIldChXs+tTT31RmcZUAnine+flaLZCo5WzMab/bR4LvvWXX7c
         +Dx2zBgkOvb8vu2zRKY2MYAfFX6sG3ddTO4f8UTw6hcm5RoWVrv3eKZonCjnYxar3a
         99uCqo1Q4DrgkmHPnxFpoJ9No95POaBkQfkbO77I9eCPiIcu9tZHsYSuCbrcqqXePd
         tdkqyYoIMNhC5oCQqiIEMT6JddjMnahAI2s6M3nZqz9Q2s6RHXWdX/ZW4TeJQGGyEx
         dYUayDs8IeCew==
Date:   Mon, 18 Sep 2023 15:40:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: linux-next: Tree for Sep 15 (drivers/mfd/cs42l43.o)
Message-ID: <20230918144033.GQ13143@google.com>
References: <20230915120127.1bc03420@canb.auug.org.au>
 <fb3f00ab-178c-45cf-ba39-baf61bb3f117@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb3f00ab-178c-45cf-ba39-baf61bb3f117@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Randy Dunlap wrote:

> 
> 
> On 9/14/23 19:01, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230914:
> > 
> > The btrfs tree gained a conflist against the mm tree.
> > 
> > The device-mapper tree gained a build failure so I used the version
> > from next-20230914.
> > 
> > The kspp tree lost its build failure.
> > 
> > Non-merge commits (relative to Linus' tree): 5026
> >  2501 files changed, 391711 insertions(+), 34318 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> > 
> 
> on arm64:
> 
> aarch64-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
> cs42l43.c:(.text+0x19d4): undefined reference to `devm_regmap_add_irq_chip'
> 
> Using GCC 13.2.0 from kernel.org crosstools.
> 
> Full randconfig file is attached.

Who is the intended consumer of this report?

Are you planning on following up with a patch?

-- 
Lee Jones [李琼斯]
