Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075B75D53E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGUTxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:53:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A099171A;
        Fri, 21 Jul 2023 12:53:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3E8499C;
        Fri, 21 Jul 2023 19:53:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3E8499C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689969189; bh=Bhtz84t4fOs3g02T6j4nqwRic//QC3BmMDYoL6IlI6w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P6sbYBVqAJzedJJOaX/sYgWJUYCPlaAkZvcl36C+oqAmXPCf2HcF1njUCgg3SG9yN
         K5uHxBV5JDt98XspxsudvtUIVg2dJK3spBmETRQh3/RKv1P+f0Hz1f7NG7OE2yyPbC
         gcWUuqQkfBPXG/hT93G9IhfGiucYyFwxAAwnYess7wi/s0Rb70xzETAcX4E0uWZgIv
         +Ith6ejLSGVCl8FVoU8HaSa3W4j85aFKoYqdqkN8a1PUOYN7MtDvef7B0ubxR3VYWl
         QOicjDPuZw2Y70HnKC9bM2rKuAlw/La6ZBp+pz6XaojPFYvi7HKJ4uPFtMdqn08DrE
         +1olhNBHNsihg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of
 small time maintainers
In-Reply-To: <20230719183225.1827100-1-kuba@kernel.org>
References: <20230719183225.1827100-1-kuba@kernel.org>
Date:   Fri, 21 Jul 2023 13:53:08 -0600
Message-ID: <87351hdot7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
>
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>  - clarify that mailings list in addition to humans is fine (Mark)
>  - reword the "review from one maintainer is enough" (Benjamin)
>  - grammar fixes (Benjamin, Shannon)
>  - typos (Andrew, Shannon)
> v2: https://lore.kernel.org/all/20230718155814.1674087-1-kuba@kernel.org/
>  - use Thorsten's wording for bug fixing requirements
>  - put more words into the review/response timeline expectations
> v1: https://lore.kernel.org/all/20230713223432.1501133-1-kuba@kernel.org/

It sure seems to me that the time has come to apply this before I need a
bigger disk to hold all the Reviewed-by tags ... :)  So I have done so,
thanks.

jon
