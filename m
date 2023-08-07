Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49858771A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHGGOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGGOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:14:02 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFA3D10F9;
        Sun,  6 Aug 2023 23:13:58 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(3962117:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 07 Aug 2023 14:13:39 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 7 Aug
 2023 14:13:38 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 7 Aug 2023 14:13:38 +0800
Date:   Mon, 7 Aug 2023 14:13:38 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     ChiYuan Huang <cy_huang@richtek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: Re: [PATCH v5 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230807061338.GA30158@linuxcarl2.richtek.com>
References: <1690355592-10920-1-git-send-email-alina_yu@richtek.com>
 <1690355592-10920-2-git-send-email-alina_yu@richtek.com>
 <20230803063656.GA19124@linuxcarl2.richtek.com>
 <822f63ef-d9e6-84f2-1a98-8a916ffaeb58@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <822f63ef-d9e6-84f2-1a98-8a916ffaeb58@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Krzysztof,

On Sat, Aug 05, 2023 at 11:27:00PM +0200, Krzysztof Kozlowski wrote:
> On 03/08/2023 08:36, ChiYuan Huang wrote:
> > On Wed, Jul 26, 2023 at 03:13:11PM +0800, Alina Yu wrote:
> >> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> >>
> >> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> 
> 
> >> +    
> >> +  richtek,mtp-sel-high:
> >> +    type: boolean
> >> +    description:
> >> +      vout register selection based on this boolean value.
> >> +      false - Using DVS0 register setting to adjust vout
> >> +      true - Using DVS1 register setting to adjust vout
> >> +
> >> +  regulators:
> >> +    type: object
> > Just curious.
> > It seems this PMIC only support buck/ldo ouput.
> > Since Krzysztof already reviewed it, not sure whether to group it into one node is common or not.
> > AFAIK, if there's no more function included, to put all on the top level may be better.
> >> +
> 
> Indeed we tend to avoid empty nodes just as a corresponding part to
> Linux device.
> 
> Here, I don't know Rob's and Conor's opinion, but for cases of having
> more than 2 regulators, having "regulators" node makes sense to me -
> nicely organizes that piece of DT which can grow quite big. I can also
> live without the "regulators" node.
>

Thank you for your kind advice.
I will keep regulator node in v7

Best regards,
Alina
