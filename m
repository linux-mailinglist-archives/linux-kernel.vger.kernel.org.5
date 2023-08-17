Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA377FEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354726AbjHQTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354751AbjHQToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:44:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25245359D;
        Thu, 17 Aug 2023 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1ixeOe9GGtjbMNgtFir4oRPvY9H4IGw3hGrf3Yr2iv0=; b=UfL4DouLW2DM6tWq8gDQk4jGLZ
        nU99k69t3veYApdn8lwpgxMMIvQef1sLF6kTxXhMPnFA/1RtLjtC5HgdaAgGlEGFpN+WXmDCNMBtg
        qS+XgInJdafgVUEJMUTU8iMMJy2OMkX8ULZlZZNzgF1xZbZ1DNPlLIJf4dpMrRXTNeqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWiuZ-004QKa-2n; Thu, 17 Aug 2023 21:44:03 +0200
Date:   Thu, 17 Aug 2023 21:44:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <e8b7a123-f542-4a22-b463-122970922535@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <DM4PR84MB1927C6684845A9AEBD9F934F881AA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1927C6684845A9AEBD9F934F881AA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +	if (length > 1514) {
> > > +		netdev_err(ndev, "send data %d bytes > 1514, clamp it to 1514\n",
> > > +			   skb->len);
> 
> > Than should be rate limited.
> 
> How is this done? Is there a particular function to call that
> will handle it in the backend?

Sorry, i was ambiguous. I meant the netdev_err() should be rate
limited, otherwise some user space application could DOS your system
by sending big packets at line rate flooding your logs.

   Andrew
