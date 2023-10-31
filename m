Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336587DC3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjJaAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaAhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:37:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510F98;
        Mon, 30 Oct 2023 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eZqivK5R+0xTQPQRA9NZ/dDkOniwdZAD6AsEMLwvMnM=; b=454x9iyNkAXCNWbqxXS9IA08mz
        /daqzAUFGU50qh+Ueouol+RYUC47CIZ6wTyOaB4I4CBLzZqbTJX874oVf0Ka658eEb2KLv56owb64
        lYGEjWBQA7VUHavfroJgzZ8x8ZLSq2EJpOEqJnqzHTmvLUEOiISaXg3inqXFn99N57W8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qxclF-000ZZh-5y; Tue, 31 Oct 2023 01:37:37 +0100
Date:   Tue, 31 Oct 2023 01:37:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <494a8bb7-7ca1-40bd-b3a7-babeadfd88a0@lunn.ch>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030230906.s5feepjcvgbg5e7v@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030230906.s5feepjcvgbg5e7v@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 01:09:06AM +0200, Vladimir Oltean wrote:
> On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > This of course make no sense, since the padding function should do nothing
> > when the packet is bigger than 60 bytes.
> 
> Indeed, this of course makes no sense. Ping doesn't work, or ARP doesn't
> work? Could you add a static ARP entry for the 192.168.1.137 IP address?

Probably the ARP, since they are short packets and probably need the
padding.

	Andrew
