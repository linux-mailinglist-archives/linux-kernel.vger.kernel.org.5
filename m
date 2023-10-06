Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC57BBD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJFQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:50:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F89AD;
        Fri,  6 Oct 2023 09:50:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7F4C433C7;
        Fri,  6 Oct 2023 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611037;
        bh=2aaZimPgHTbIm4nYbzzNMap4dmH7kQIVxsi+EmgVXzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKKIYCm1cbYRcvcQLLOlTTHe4wq6pp/CzXSjhvdRhLGlAx18oEMTQ3LXm0QGUDH6n
         hyBpwuP6H2nthJm8hWhPbuI6flcwWfj8S99rHoqyr6XrhT13dbmtyvKmRIQ0Hysbac
         rOp3JM5Do7cSOFUAIUjp60ozaH83GE2prLw34lZGQhmUSVFFd8SdzX4h4LGetDOk7K
         KagfRn5BhO4epM9lNg3RetFKlPZT4nQeHqcdX6WDymgXsal8z+kmZzj+zm0mc7DCxR
         pDkjaaY1VRWxMCrqBCc6xS3DWszOI3vvmCqSGeSWPIsRzngH5syTqScpSguAwrQ7B9
         lyGPSxZHyqQhg==
Received: (nullmailer pid 4059854 invoked by uid 1000);
        Fri, 06 Oct 2023 16:50:35 -0000
Date:   Fri, 6 Oct 2023 11:50:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/11] dt-bindings: mips: Add bindings for Mobileye SoCs
Message-ID: <20231006165035.GA4049125-robh@kernel.org>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-7-gregory.clement@bootlin.com>
 <CAL_Jsq+NkRM07U8enKSVvpOg+9qtDdnkqs2Pc0X8LgjVVo7Vhg@mail.gmail.com>
 <87pm1tce5v.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pm1tce5v.fsf@BL-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:55:08PM +0200, Gregory CLEMENT wrote:
> Hello Rob,
> 
> > On Wed, Oct 4, 2023 at 11:11 AM Gregory CLEMENT
> > <gregory.clement@bootlin.com> wrote:
> >>
> >> Add the yaml bindings for Mobileye SoCs. Currently only EyeQ5 is
> >> supported
> >>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  .../devicetree/bindings/mips/mobileye.yaml    | 36 +++++++++
> >>  include/dt-bindings/soc/mobileye,eyeq5.h      | 77 +++++++++++++++++++
> >>  2 files changed, 113 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
> >>  create mode 100644 include/dt-bindings/soc/mobileye,eyeq5.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/mips/mobileye.yaml b/Documentation/devicetree/bindings/mips/mobileye.yaml
> >> new file mode 100644
> >> index 000000000000..f47767bc2c8f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mips/mobileye.yaml
> >> @@ -0,0 +1,36 @@
> >> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> >
> > Use what checkpatch tells you.
> 
> >From my point of view GPL-2.0-or-later is compatible with GPL-2.0-only,
> but OK I will do this.

GPL-2.0-only is compatible with GPL3, so why does that matter? And MIT 
is compatible with BSD-2-Clause, but we don't include that. 

Are we okay with GPLv4, v5, ...?

What I really care about is having a free-for-all and having a 
proliferation of different licenses and combinations of licenses under 
bindings. If everyone paid attention, then I wouldn't care. But they 
don't and just copy code around. We already have a license mess with DT 
headers and .dts files. Besides the copying problem, it is not hard to 
find GPL only license included in dual or BSD/MIT only licensed .dts 
files. Seems like an issue to me.

Rob
