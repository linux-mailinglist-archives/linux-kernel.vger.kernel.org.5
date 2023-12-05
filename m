Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B54805C30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjLEP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346244AbjLEP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:29:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961A583
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:29:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2BC433C8;
        Tue,  5 Dec 2023 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701790154;
        bh=SclM1eXnYMdnRBvBsf/lJdJQ0p0yUDsjtvGBYqnKRvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t+u2FnOSzD0cZ0AXurNhbOSSJJX0fjLrpxVxj6J14W/se6GIxs6iMIOoGYr9cdPKG
         z9jBGgLMCmn0X3Q0RQejJxVOJ2S01GZ/pekqoTzjtwYLWVD74qxMlgj6kHFvQ1yBBg
         2t9Kz2AmDcSrjafmINUo15LXgEQ8V7Iu8xmJBlyk15/u1RUdwloUJqmM8kFwHcu4GO
         tiITk+KpH4rw7pOy0UredN999rtOK2t05dEFp6I9yrbf/Pw7jFMSr00fhE5MTCDghH
         ENTAxxXxsIMBrZdJKQaP3+VmpeVsPivJEnxKFLPsee5YTaaKlw8R2lnCJSBEFjK9Fp
         7NKl4u74A8FnA==
Date:   Tue, 5 Dec 2023 07:29:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        workflows@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231205072912.2d79a1d5@kernel.org>
In-Reply-To: <ZW89errbJWUt33vz@shell.armlinux.org.uk>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
        <20231128133630.7829-3-ansuelsmth@gmail.com>
        <20231204181752.2be3fd68@kernel.org>
        <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
        <656f37a6.5d0a0220.96144.356f@mx.google.com>
        <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
        <ZW89errbJWUt33vz@shell.armlinux.org.uk>
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

On Tue, 5 Dec 2023 15:10:50 +0000 Russell King (Oracle) wrote:
> I've raised this before in other subsystems, and it's suggested that
> it's better to have it in the .c file. I guess the reason is that it's
> more obvious that the function is documented when modifying it, so
> there's a higher probability that the kdoc will get updated when the
> function is altered.

Plus I think people using IDEs (i.e. not me) may use the "jump to
definition" functionality, to find the doc? 

TBH I thought putting kdoc in the C source was documented in the coding
style, but I can't find any mention of it now.
