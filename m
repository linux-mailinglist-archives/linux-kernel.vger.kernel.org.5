Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33581774D76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjHHV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHHV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:57:32 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59890EE;
        Tue,  8 Aug 2023 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Iw353CUGOaR9ntV/GhP6nXoYL9ZHZ1HVuitTAIcTyoA=; b=wQ6jQi1x24Y1QysBckKRqSeilr
        hExPc9tz1kVg313OrEORcp5T7arVJJ/0mnUea8bN4R5/meR8OQ6NyBWpXdLsxqP231KRTfbBAllB6
        fUT2mvCOXZRSLRY1LPidKNd2+orscVZV2i94XeNENT6L6eQMSdS9AEZO7CTGLbDa41hU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qTUhQ-003WUv-RA; Tue, 08 Aug 2023 23:57:08 +0200
Date:   Tue, 8 Aug 2023 23:57:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luke Lu <luke.lu@libre.computer>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, Da Xue <da@libre.computer>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Message-ID: <ef7000ae-721c-49ac-b0b3-b5d94fd82a4d@lunn.ch>
References: <20230808050016.1911447-1-da@libre.computer>
 <b8931b6c-5b35-8477-d50f-b7a43b13615f@gmail.com>
 <CAAzmgs75L6Y3PU1SF8Uvh1Z2cqt86HmaRKFn088yzRK73mfnLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAzmgs75L6Y3PU1SF8Uvh1Z2cqt86HmaRKFn088yzRK73mfnLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > And a formal remark: Your patch misses the net / net-next annotation.
> >
> Not sure if we understand this correctly, do you mean the one line
> summary of this patch?
> or the content of the commit message that needs to improve to reflect this is an
> ethernet/net related fix?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

	Andrew
