Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B072C7F3792
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjKUUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjKUUga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:36:30 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B50D1A2;
        Tue, 21 Nov 2023 12:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=n8r2YqwbMhKNr3zlZBjNkqkvBYIoxIi/cLEUD7ZrfpY=; b=Je
        820PRYE5x9xa1o3S3OwSouTO6IrOYeBsmC0/5QgogyteWoaB2iBC72/UoneRMqEXqhc17vPoMXuIw
        YJ3kqZUd6rBSL//QQ1Xxgq3l8+rRYhnaOdYeZ7ToVSUvjEEckN9WU5Tqy/jfg4GZb87Ymz5Z1n8m3
        heOg3FKx2mS3r+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5XTh-000nIi-Ha; Tue, 21 Nov 2023 21:36:13 +0100
Date:   Tue, 21 Nov 2023 21:36:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ray Zhang <sgzhang@google.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix out-of-bounds read via memcpy detected
 by KASAN
Message-ID: <ebbdf786-54d4-491c-ab81-de03006ec727@lunn.ch>
References: <20231121184543.3433940-1-sgzhang@google.com>
 <84be10f3-0880-4ccd-b6d3-b5feecea75ef@lunn.ch>
 <CAPqVEODWZ5suy7MEc_QXz_mx5uryypz1zAi9M9re-xqhs3urSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPqVEODWZ5suy7MEc_QXz_mx5uryypz1zAi9M9re-xqhs3urSA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>     >      q0_tx_irq_n: 4
>     >      q0_rx_pkt_n: 64
>     >      q0_rx_irq_n: 58
> 
>     What useful information does this list of statistics bring in the
>     commit message?
> 
> Each output line of "ethtool -S" is from the modified code: It shows the
> command still yields normal output results as expected.

Does it? Can you actually say that looking at it?

> No, since strscpy does the job already. Also I could not find ethtool_puts:
> where is it defined? Or do you mean ethtool_put_stat, which is inappropriate to
> use here since it requires a skb parameter?

https://patchwork.kernel.org/project/netdevbpf/patch/20231102-ethtool_puts_impl-v4-3-14e1e9278496@google.com/

Maybe check with Justin when we will resend that patch.

	Andrew
