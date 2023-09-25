Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D837ADD31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjIYQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjIYQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2F107;
        Mon, 25 Sep 2023 09:32:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45716C433C8;
        Mon, 25 Sep 2023 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695659523;
        bh=n+WiPsDnWg5mw5vXXLARdkIqoBSXRgce+BnqlsXdPd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7g4uhxXRuRtUC1cQUIRiIleXVp0kCCx/IbG5BLcRMYLmIXLxVgZsAqvI7vSCR7YO
         Xyg9+Vp5Ukz2aKQ0g8bHpYuGaYG1OoFar/6mhXwZE6a1EFB2TinCseztCXNGR/nAGX
         UY1ajGVbndbKWaokdCszwPg7oBXTZrZFkDR5p/Ln6En1W1nBVUUVFkRgJJq4ahhEIF
         keoE2tkcpofPOvGJdKZXCvh/4GYhKzMzFg+3nAUJ1BaUVNxZoe1b3CRX1sOAiIbyox
         Dar0QKY2zXO+cXPdXjuYWFErzYw8+o3ajsB3cYyHKYlGmkHXIVpDFvm/rfoKv2MWR4
         5vK3qydiy2/kw==
Received: (nullmailer pid 1476217 invoked by uid 1000);
        Mon, 25 Sep 2023 16:32:00 -0000
Date:   Mon, 25 Sep 2023 11:32:00 -0500
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
Subject: Re: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
Message-ID: <20230925163200.GA1469001-robh@kernel.org>
References: <20230925074131.10133-1-ming.qian@nxp.com>
 <20230925074131.10133-2-ming.qian@nxp.com>
 <bbc8dd05-8589-44ec-87dd-f2d7b4368245@linaro.org>
 <AM6PR04MB63418AE18D3D0ED98CCC1A0FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <751a552e-5209-4d5e-9292-23339a06f8a9@linaro.org>
 <AM6PR04MB63410BEA725DDBF1D1B7814FE7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <10c50df3-9a99-4552-9b25-0844b87e28f5@linaro.org>
 <AM6PR04MB6341C8E7553F66695467C398E7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <df86ea4b-d389-4060-bd3b-830bacabde1c@linaro.org>
 <AM6PR04MB6341D59E9BBB433F6045D367E7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB6341D59E9BBB433F6045D367E7FCA@AM6PR04MB6341.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 08:48:01AM +0000, Ming Qian wrote:
> >From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >Sent: 2023年9月25日 16:33
> >To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
> ><mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org; shawnguo@kernel.org
> >Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
> >kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
> ><xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
> ><tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> >devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
> >kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >Subject: Re: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg: Assign slot
> >for imx jpeg encoder/decoder
> >
> >Caution: This is an external email. Please take care when clicking links or
> >opening attachments. When in doubt, report the message using the 'Report
> >this email' button
> >
> >
> >On 25/09/2023 10:20, Ming Qian wrote:
> >>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Sent: 2023年9月25日 16:14
> >>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
> >>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org;
> >shawnguo@kernel.org
> >>> Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
> >>> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
> >>> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
> >>> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> >>> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
> >>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >>> Subject: Re: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg:
> >>> Assign slot for imx jpeg encoder/decoder
> >>>
> >>> Caution: This is an external email. Please take care when clicking
> >>> links or opening attachments. When in doubt, report the message using
> >>> the 'Report this email' button
> >>>
> >>>
> >>> On 25/09/2023 10:13, Ming Qian wrote:
> >>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>> Sent: 2023年9月25日 16:10
> >>>>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
> >>>>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org;
> >>> shawnguo@kernel.org
> >>>>> Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >>>>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> >>>>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> >>>>> X.H. Bao <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>;
> >>>>> Tao Jiang <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> >>>>> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
> >>>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >>>>> Subject: Re: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg:
> >>>>> Assign slot for imx jpeg encoder/decoder
> >>>>>
> >>>>> Caution: This is an external email. Please take care when clicking
> >>>>> links or opening attachments. When in doubt, report the message
> >>>>> using the 'Report this email' button
> >>>>>
> >>>>>
> >>>>> On 25/09/2023 10:07, Ming Qian wrote:
> >>>>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>>>> Sent: 2023年9月25日 16:02
> >>>>>>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
> >>>>>>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org;
> >>>>> shawnguo@kernel.org
> >>>>>>> Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >>>>>>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> >>>>>>> s.hauer@pengutronix.de; kernel@pengutronix.de;
> >>>>>>> festevam@gmail.com; X.H. Bao <xiahong.bao@nxp.com>; Eagle Zhou
> >>>>>>> <eagle.zhou@nxp.com>; Tao Jiang <tao.jiang_2@nxp.com>;
> >>>>>>> dl-linux-imx <linux-imx@nxp.com>; devicetree@vger.kernel.org;
> >>>>>>> linux-media@vger.kernel.org; linux- kernel@vger.kernel.org;
> >>>>>>> linux-arm-kernel@lists.infradead.org
> >>>>>>> Subject: [EXT] Re: [PATCH v3 2/2] dt-bindings: media: imx-jpeg:
> >>>>>>> Assign slot for imx jpeg encoder/decoder
> >>>>>>>
> >>>>>>> Caution: This is an external email. Please take care when
> >>>>>>> clicking links or opening attachments. When in doubt, report the
> >>>>>>> message using the 'Report this email' button
> >>>>>>>
> >>>>>>>
> >>>>>>> On 25/09/2023 09:41, Ming Qian wrote:
> >>>>>>>> There are total 4 slots available in the IP, and we only need to
> >>>>>>>> use one slot in one os, assign a single slot, configure
> >>>>>>>> interrupt and power domain only for 1 slot, not for the all 4 slots.
> >>>>>>>
> >>>>>>> No changelog and I do not see much of improvements. Do not ignore
> >>>>>>> the feedback but respond to it or fix the patch. Really, what
> >>>>>>> happened
> >>> here?
> >>>>>>>
> >>>>>>
> >>>>>> Hi Krzysztof,
> >>>>>>    What do you mean wrap commit message? Do you mean line
> >wrapped
> >>> at
> >>>>> 75 columns?
> >>>>>>
> >>>>>>   - The body of the explanation, line wrapped at 75 columns, which will
> >>>>>>     be copied to the permanent changelog to describe this patch.
> >>>>>
> >>>>> I gave you clear link to the doc explaining this. What is unclear there?
> >>>>>
> >>>>> And you decide to ignore all the rest of the comments here as well?
> >>>
> >>> So this is still ignored? Can you respond to all my comments?
> >>>
> >>>>>
> >>>>> Best regards,
> >>>>> Krzysztof
> >>>>
> >>>> The link content is as below:
> >>>>
> >>>>   - The body of the explanation, line wrapped at 75 columns, which will
> >>>>     be copied to the permanent changelog to describe this patch.
> >>>>
> >>>> I'm sorry that I didn’t get your point.
> >>>
> >>> Wrap
> >>> your
> >>> commit
> >>> according
> >>> to
> >>> coding
> >>> style.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>
> >> Hi Krzysztof,
> >>     I opened your link about the Linux coding style / submission process, but I
> >only find the following message:
> >>
> >>   - The body of the explanation, line wrapped at 75 columns, which will
> >>     be copied to the permanent changelog to describe this patch.
> >>
> >>      So I don't know what do you mean the coding style.
> >
> >
> >Linked document explains what is a patch, how it is formatted. Just read
> >entire doc, not one sentence.
> >
> >You keep ignoring my other comments all the time, so I will stop asking you to
> >respond to them. Instead I will be NAK-ing your patches till you decide to
> >respond.
> >
> >Best regards,
> >Krzysztof
> 
> Hi Krzysztof,
>     I'm sorry that I make you unhappy, as I didn't know how to improve the commit message.
> And your other comments about the change, I get your point, and prepare to improve in the next version.
> 
> Sorry again that I didn't response your every comments, I will avoid doing it again.
> 
> And can you give a example how to improve the commit message.

'git log'

There are 10K+ examples every 2 months.

Please talk to your NXP colleagues experienced with upsteam about how to 
write and submit patches upstream, and explain what Krzysztof has said 
if it is not clear.

Rob
