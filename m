Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E506777A03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjHJN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjHJN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:59:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643761B4;
        Thu, 10 Aug 2023 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1QxiuF75076c1wIGtoY4akQwbj9n+G/4IMmmLPB7RYw=; b=zftM9yg48Q9Hr0YPn2yo7s+b+P
        IWG/mmvva5GCA6TWxUJgfH+uib5Sahc22PKz/XpAQs/0ngWzPAglzqk7brVqG+0JKi65Rx9IKva8r
        BP367v+ko072NisI/z+V0cbF93TWiFniUzSU4vaX0P8jRuJslB6pYudbvtXwC5NLsMRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qU6CD-003hOE-A7; Thu, 10 Aug 2023 15:59:25 +0200
Date:   Thu, 10 Aug 2023 15:59:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH 1/1] net: stmmac: dwmac4: extract MAC_HW_Feature regs MSB
 first
Message-ID: <9b9635bd-2635-4115-bafb-8a07573c6556@lunn.ch>
References: <20230810095929.246901-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810095929.246901-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:59:29PM +0800, Furong Xu wrote:
> The bit extraction sequences are a little messy.
> No code changes, just reorder them.

How is this substantially better?

If bugs are found in this code, your change is going to make it harder
to back port the fixes to stable kernels. cherry-pick is unlikely to
work, it will need a human to look at it. Not hard, but still effort
for somebody.

So i think there needs to be a clear benefit to this, and you should
mention the benefit in the commit message.

    Andrew
