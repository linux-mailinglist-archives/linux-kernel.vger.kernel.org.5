Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E778B53D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjH1QSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjH1QSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88412F;
        Mon, 28 Aug 2023 09:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 257AA630F1;
        Mon, 28 Aug 2023 16:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB25C433C8;
        Mon, 28 Aug 2023 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239496;
        bh=+5nlbqLGMrZ/R2mFBTL8NGIJSfKWeHSioZy+2eRChiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLAkKfCYD72bkSppirG0k2qyUVfwPAsNfx2+FO5OQ64BgMwR3ksaVthGJO5uW9KpI
         BhSRGtV1s2qeIqxeUbLm+8+7mUgytigWxd24VQ9caKfYJIkP8kBVHHiUrB9bkdFROV
         mmNCR3qveLuhiQzVr1m5oxsOMLQSThKVlxsrU3Z9IJTBl4Krbo3SoxOg1Xv/3pGZ3+
         i5qh//cnVoF5pf68C5xXc7APk1Zbl+LrYIEjmWNZAz5SZhMqYyeNnh5p1eC7v2gOJP
         VKm5Rv71VDjqtBbXzW5WDJ5toGX2vQtnepG3SwHU1w8RYLXJDzp1tBfHpvCUVS31tQ
         9ip5J4dSyXmeQ==
Date:   Tue, 29 Aug 2023 00:06:24 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
        Coquelin@web.codeaurora.org,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: add T-HEAD dwmac
 support
Message-ID: <ZOzGAPlYm3rw1Lz0@xhacker>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-3-jszhang@kernel.org>
 <qc2nyqmuouig6qww2q7orlwzvcprjyruyeuyr5dqdpxysajjpv@6fzsgjgokry7>
 <ZOy6kLGZ1lR0I2sC@xhacker>
 <pbh7gh7fkfis7zqqmmug5wtosq3xsx7z3ktsfg3jy6jthm6qva@a3wy7knv2vcr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pbh7gh7fkfis7zqqmmug5wtosq3xsx7z3ktsfg3jy6jthm6qva@a3wy7knv2vcr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:51:49PM +0300, Serge Semin wrote:
> On Mon, Aug 28, 2023 at 11:17:36PM +0800, Jisheng Zhang wrote:
> > On Mon, Aug 28, 2023 at 04:13:00PM +0300, Serge Semin wrote:
> > > On Sun, Aug 27, 2023 at 05:17:09PM +0800, Jisheng Zhang wrote:
> > > > Add documentation to describe T-HEAD dwmac.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
> > > >  .../devicetree/bindings/net/thead,dwmac.yaml  | 77 +++++++++++++++++++
> > > >  2 files changed, 78 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > index b196c5de2061..73821f86a609 100644
> > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > @@ -96,6 +96,7 @@ properties:
> > > >          - snps,dwxgmac
> > > >          - snps,dwxgmac-2.10
> > > >          - starfive,jh7110-dwmac
> > > > +        - thead,th1520-dwmac
> > > >  
> > > >    reg:
> > > >      minItems: 1
> > > > diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
> > > > new file mode 100644
> > > > index 000000000000..bf8ec8ca2753
> > > > --- /dev/null
> > > 
> > > > +++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
> > > 
> > > see further regarding using dwmac in the names here.
> > > 
> > > > @@ -0,0 +1,77 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > 
> > > > +title: T-HEAD DWMAC Ethernet controller
> > > 
> > > Additionally would be nice to have a brief controller "description:"
> > > having the next info: the SoCs the controllers can be found on, the DW
> > > (G)MAC IP-core version the ethernet controller is based on and some
> > > data about the synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA
> > > FIFOs size, perfect and hash MAC-filters size, L3L4 frame filters
> > > availability, VLAN hash filter, SA/VLAN-tag insertion, ARP offload
> > > engine, PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE
> > > 1588(-2008) Timestamping support, PMT and Wake-up frame support, MAC
> > > Management counters (MMC). In addition to that for DW QoS
> > > ETH/XGMAC/XLGMAC the next info would be useful: number of MTL Queues
> > > and DMA channels, MTL queues capabilities (QoS-related), TSO
> > > availability, SPO availability.
> > > 
> 
> > > Note DMA FIFO sizes can be also constrained in the properties
> > > "rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter sizes -
> > > in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".
> 
> BTW plus to this you may wish to add the "rx-internal-delay-ps" and
> "tx-internal-delay-ps" properties constraints seeing they device
> supports internal Tx/Rx delays.
> 
> > 
> > Hi Serge,
> > 
> 
> > Thank you for your code review. I have different views here: If we
> > only support the gmac controller in one specific SoC, these detailed
> > information is nice to have, but what about if the driver/dt-binding
> > supports the gmac controller in different SoCs? These detailed
> > information will be outdated.
> 
> First they won't. Second then you can either add more info to the
> description for instance in a separate paragraph or create a dedicated
> DT-bindings. Such information would be very much useful for the
> generic STMMAC driver code maintenance.
> 
> > 
> > what's more, I think the purpose of dt-binding is different from
> > the one of documentation.
> 
> The purpose of the DT-bindings is a hardware "description". The info I
> listed describes your hardware.

dt-binding VS. dts(i), they are different things. Part of what you listed
belong dts(i), that's the reason why I prefer to put those into dts(i)
commit msg. The HW description is in dts(i) itself rather than dt-binding.
Anyway I will add generic decriptions to the dt-binding.

> 
> > 
> > So I prefer to put these GMAC IP related detailed information into
> > the SoC's dtsi commit msg rather than polluting the dt-binding.
> > > 
> > > > +
> > > > +maintainers:
> > > > +  - Jisheng Zhang <jszhang@kernel.org>
> > > > +
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        enum:
> > > 
> > > > +          - thead,th1520-dwmac
> > > 
> > > Referring to the DW IP-core in the compatible string isn't very
> > > much useful especially seeing you have a generic fallback compatible.
> > > Name like "thead,th1520-gmac" looks more informative indicating its
> > > speed capability.
> > 
> 
> > This is just to follow the common style as those dwmac-* does.
> > I'm not sure which is better, but personally, I'd like to keep current
> > common style.
> 
> It's not that common. Half the compatible strings use the notation
> suggested by me and it has more sense then a dwmac suffix. It's ok to
> use the suffix in the STMMAC driver-related things because the glue
> code is supposed to work with the DW *MAC generic code. Using it in
> the compatible string especially together with the generic fallback
> compatible just useless.
> 
> -Serge(y)
> 
