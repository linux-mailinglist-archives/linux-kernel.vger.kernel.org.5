Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4247B22B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjI1Qr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjI1Qr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:47:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD3B1A4;
        Thu, 28 Sep 2023 09:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047F8C433C8;
        Thu, 28 Sep 2023 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695919644;
        bh=3ULes3SP+nVMDrHJRNu8hN35Zfay9cO72EBXJbs4MP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJ1hHcd501bSblfoDC1vqRbgIic8CijJLyrB9WU3GwGIixc/ptBw7AW6exr6EoqYw
         sp/0EzHtubpTo9CKuKlWwr4EIOP2r3JK/4ERExObJomh1xKu8ijpkfTIsqKOqN8HeL
         9P/kpYJ4NjjZyRL2X48oD63uH0njQxA63qpHyKiD/1oiQTjBTnErpeVNmj8t+1uOE1
         ynHoKQ+cjSBMYCXWKzHVL7gzPTBlxnzG1aoXkqJ4gDYv7FKmzB25wf0oj2NBDeToQF
         q7bEwMBVt4tN5EXZkbXUg4SsuOEoN2Or5NWZnG+iQrudJwaClAIr6QQN2AntjYHJvs
         NthIpULy3TQAA==
Received: (nullmailer pid 834795 invoked by uid 1000);
        Thu, 28 Sep 2023 16:47:20 -0000
Date:   Thu, 28 Sep 2023 11:47:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Message-ID: <20230928164720.GA816352-robh@kernel.org>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
 <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:10:52AM +0000, Ming Qian wrote:
> >From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> >On 26/09/2023 12:10, Ming Qian wrote:
> >> There are total 4 slots available in the IP, and we only need to use
> >> one slot in one os, assign a single slot, configure interrupt and
> >> power domain only for 1 slot, not for the all 4 slots.
> >>
> >> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> >> ---
> >> v4
> >> - improve commit message
> >> - don't make an ABI break
> >> v3
> >> - add vender prefix, change property slot to nxp,slot
> >> - add type for property slot
> >>
> >>  .../bindings/media/nxp,imx8-jpeg.yaml         | 45 +++++++++----------
> >>  1 file changed, 21 insertions(+), 24 deletions(-)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> >> b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> >> index 3d9d1db37040..4bcfc815c894 100644
> >> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> >> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> >> @@ -32,19 +32,26 @@ properties:
> >>      maxItems: 1
> >>
> >>    interrupts:
> >> -    description: |
> >> -      There are 4 slots available in the IP, which the driver may use
> >> -      If a certain slot is used, it should have an associated interrupt
> >> -      The interrupt with index i is assumed to be for slot i
> >> -    minItems: 1               # At least one slot is needed by the driver
> >> -    maxItems: 4               # The IP has 4 slots available for use
> >> +    description:
> >> +      Interrupt number for slot
> >> +    maxItems: 1
> >>
> >>    power-domains:
> >>      description:
> >>        List of phandle and PM domain specifier as documented in
> >>        Documentation/devicetree/bindings/power/power_domain.txt
> >> -    minItems: 2               # Wrapper and 1 slot
> >> -    maxItems: 5               # Wrapper and 4 slots
> >> +    minItems: 1               # VPUMIX
> >> +    maxItems: 2               # Wrapper and 1 slot
> >> +
> >> +  nxp,slot:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description:
> >> +      Integer number of slot index used. There are 4 slots available in the IP,
> >> +      and driver can use a certain slot, it should have an associated interrupt
> >> +      and power-domain. In theory, it supports 4 os or vm. If not specified, 0
> >> +      is used by default.
> >> +    minimum: 0
> >> +    maximum: 3
> >
> >NAK, you still did not answer concerns why this is needed and justified.
> >I keep asking and you keep ignoring...
> >
> >Best regards,
> >Krzysztof
> 
> Hi Krzysztof,
> 
> > Nothing explains what is a slot and nothing explains why do you need this property.
> 
> I thought I had answered that question, but seems you don't agree with that explanation. 
> Would the following description be any better?
> 
> The slot is the IP used to share the jpeg engine across multiple VMS 
> and os, there are 4 slots available in the IP. We can use one slot in 
> linux. The slot index indicates which slot we choose. If not 
> specified, 0 is used by default.

If you have to modify the DT to update 'nxp,slot', then you can modify 
the DT to just expose the parts of the h/w for the assigned slot. For 
example, only put slot 1's power-domains entry in the DT when slot 1 is 
assigned.

As far as formatting your emails, talk to your NXP colleagues. They've 
figured it out. If you've configured git-send-email successfully, then 
using mutt should be possible. You can use 'b4' to get the thread mbox, 
and read it in mutt.

Rob
