Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309A37BFE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjJJN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjJJN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:57:44 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2AF99;
        Tue, 10 Oct 2023 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fnkd1aij7Tpc2L+QxXML50n+8ixS5invGoodurLeWlU=; b=ngCOHN8v9MKAiT7mihTGC+tYRD
        QYIdeaZOHdujS3q+ZWzzSpAAbysLySouhqwNJLonOb0A+VsrjcKoZXXGowyP+vJ2zSzfZq5ZFLx1R
        nQCk/5liQePtbmDPa16MOpNFgsXN4m+6JduYZfCOTAuzkNtfgX/mt6z3sPYkLJsQzBJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qqDEs-001Fhr-T4; Tue, 10 Oct 2023 15:57:34 +0200
Date:   Tue, 10 Oct 2023 15:57:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <5348ffc3-a514-4d61-85f9-56910aa94d44@lunn.ch>
References: <6a366c3a-49e7-42a4-83b2-ef98e7df0896@lunn.ch>
 <20231010134139.17180-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010134139.17180-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:41:39PM +0200, Ante Knezic wrote:
> On Tue, 10 Oct 2023 15:25:44 +0200, Andrew Lunn wrote:
> >> +  microchip,rmii-clk-internal:
> >> +    $ref: /schemas/types.yaml#/definitions/flag
> >> +    description:
> >> +      Set if the RMII reference clock should be provided internally. Applies only
> >> +      to KSZ88X3 devices.
> >
> >It would be good to define what happens when
> >microchip,rmii-clk-internal is not present. Looking at the code, you
> >leave it unchanged. Is that what we want, or do we want to force it to
> >external?
> >
> >	Andrew
> 
> Default register setting is to use external RMII clock (which is btw only 
> available option for other KSZ devices - as far as I am aware) so I guess 
> theres no need to force it to external clock?

We just need to watch out for a bootloader setting it. Or is it really
guaranteed to be false, because the DSA driver always does a device reset,
removing all existing configuration?

I prefer it is unambiguously documented what not having the property
means.

	Andrew


