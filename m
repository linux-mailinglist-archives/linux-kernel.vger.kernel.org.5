Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD47527DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGMP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGMP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:59:24 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98D1BEB;
        Thu, 13 Jul 2023 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kbRaRAb0JOL2/28VqRGpCqPBtBaSf/qjgEEPz4Ozblw=; b=0YXzfhdXgCkaLlwHWfhq7w7NBW
        B2yrKFup3FthFeXz+uny9omFu8uiDopmfNCRlhggOeUmyNdYrKGpvg0BFkhNVzp4j+/EijFlqpEDw
        yQT2CMGgWn0IUnANOuPuAnvUVnW5lUC6888a0ba4McrU1KWCPA+LVlSPS+Bo6KLGYF7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qJyip-001Gmy-Eb; Thu, 13 Jul 2023 17:59:15 +0200
Date:   Thu, 13 Jul 2023 17:59:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
        git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Message-ID: <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +examples:
> > +  - |
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        phy: ethernet-phy@0 {
> > +            reg = <0>;
> > +        };
> 
> Drop this node, quite obvious.

Dumb question. Isn't it needed since it is referenced by phy-handle =
<&phy> below. Without it, the fragment is not valid DT and so the
checking tools will fail?

> > +        gmiitorgmii@8 {
> > +            compatible = "xlnx,gmii-to-rgmii-1.0";
> > +            reg = <8>;
> > +            phy-handle = <&phy>;
> > +        };
> > +    };

	Andrew
