Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81065752B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjGMTdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:33:36 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382B2D77;
        Thu, 13 Jul 2023 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cA+1aUaQanMFNEQyl9OnMvn02aE9XScDbFGO22nPMMY=; b=cf4/cn23xXdm+s4y2Y0MnOwH7A
        AMiDHv+11kSOTUAGsEz1W/byhrW2GjlDunN55IcZBNbxaShSl0hYNvZqXjkilikasHrPqpe3HNpYN
        rcev8TKCXFM4oztm3HGYWuQ9F68IH+eQEmXEPeIOABB5EBfwSghnmfCvhTpTgcrlgYno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qK248-001HjT-Eo; Thu, 13 Jul 2023 21:33:28 +0200
Date:   Thu, 13 Jul 2023 21:33:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "Haener, Michael" <michael.haener@siemens.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <9edfd9ed-a162-480a-8265-261c2fe72750@lunn.ch>
References: <20230704065916.132486-1-michael.haener@siemens.com>
 <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
 <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
 <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
 <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
 <d154d59edd2883b30de8f80fa9c08ec7700504d6.camel@siemens.com>
 <d7466827-7f39-495b-a129-91188e3d150f@lunn.ch>
 <d1d3ac6fe99c6f54c82ae0c2f7e817d86b6e4075.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d3ac6fe99c6f54c82ae0c2f7e817d86b6e4075.camel@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:29:12PM +0000, Sverdlin, Alexander wrote:
> Hi Andrew,
> 
> On Thu, 2023-07-13 at 17:34 +0200, Andrew Lunn wrote:
> > > we did understand Andrew's request indeed, however we were not able to
> > > backport your series quickly to the version we are able to test on the
> > > HW.
> > 
> > But your own patchset has been tested on net-next by yourself? So it
> > should be trivial to use "b4 am <threadid>" to get Russells patchset,
> > apply them on top of net-next, and then add your patches as well.
> 
> unfortunately it has been only built on net-next and tested on a 5.15.x with some
> limited backports so that Russell series would require even more backporting.

You should indicate that the patch is only built tested when
submitting it.

I assume you are using a vendor kernel? What is missing in mainline to
stop networking working?

	 Andrew
