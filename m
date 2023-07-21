Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467D475C0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGUIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGUIKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B11B2706;
        Fri, 21 Jul 2023 01:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7142661713;
        Fri, 21 Jul 2023 08:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D74C43395;
        Fri, 21 Jul 2023 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689927030;
        bh=JltdfULPxWz8Dlw+w3aZFp6VjNTiHDJDfEr7o9YRNs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niUdYILFYdemwUU0w/emWHL8ztgfvInBdEat9aHRd7SwlIqHTIeGzYpF174Vi6V5L
         n9CCNBAXoQ2aO/p0ys56jYcNJBD6A0PPXHRHEu6Na3ezoZgAEn+/JeHdqTZSyanaBC
         dUuf/2m/ZbvUz1gulF37zc0XJIA9CtYOguQU0AqGBuXXOvoqXVDiWRio59rmzkGcAI
         zD/SFytbZB0b9twHz38q/BkleTqEiW9Vfh0c0hb4pN5iqXVl62t7tY6CIX4odkkvzZ
         laeC+dmsdiHQsF1Av48sXPL1cOfNCMnjzGcdDWli/IK9oQ1dD+A8AIRqZDqAmR8ie1
         pkvdh3FvzASwA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMlDi-0003M5-2u;
        Fri, 21 Jul 2023 10:10:38 +0200
Date:   Fri, 21 Jul 2023 10:10:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 01/10] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <ZLo9flzTCha5iU-K@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-2-quic_kriskura@quicinc.com>
 <ZJrGG6FXWLacRLbg@hovoldconsulting.com>
 <ZJsCf3nYrikF7nZc@hovoldconsulting.com>
 <548e35a7-984d-a62f-ea4b-a5aeace8009a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548e35a7-984d-a62f-ea4b-a5aeace8009a@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:41:59AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/27/2023 9:08 PM, Johan Hovold wrote:
> > On Tue, Jun 27, 2023 at 01:20:59PM +0200, Johan Hovold wrote:
> >> On Wed, Jun 21, 2023 at 10:06:19AM +0530, Krishna Kurapati wrote:
> > 
> >>> +          items:
> >>> +            - const: dp1_hs_phy_irq
> >>> +            - const: dm1_hs_phy_irq
> >>> +            - const: dp2_hs_phy_irq
> >>> +            - const: dm2_hs_phy_irq
> >>> +            - const: dp3_hs_phy_irq
> >>> +            - const: dm4_hs_phy_irq
> >>> +            - const: dp4_hs_phy_irq
> >>> +            - const: dm4_hs_phy_irq
> >>> +            - const: ss1_phy_irq
> >>> +            - const: ss2_phy_irq
> >>> +            - const: pwr_event_1
> >>> +            - const: pwr_event_2
> >>> +            - const: pwr_event_3
> >>> +            - const: pwr_event_4
> >>
> >> The naming here is inconsistent and interrupts should not have "_irq"
> >> suffixes (even if some of the current ones do for historical reasons).
> >>
> >> I believe these should be named
> >>
> >> 	pwr_event_1
> >> 	dp_hs_phy_1
> >> 	dm_hs_phy_1
> >> 	ss_phy_1
> >>
> >> 	pwr_event_2
> >> 	dp_hs_phy_2
> >> 	dm_hs_phy_2
> >> 	ss_phy_2
> >>
> >> 	pwr_event_3
> >> 	dp_hs_phy_3
> >> 	dm_hs_phy_3
> >>
> >> 	pwr_event_4
> >> 	dp_hs_phy_4
> >> 	dm_hs_phy_4
> >>
> >> or similar and be grouped by port while using the the
> >> qcom,sc8280xp-dwc ordering for the individual lines.
> > 
> > Perhaps the ordering you suggested is fine too, but I'd probably move
> > the pwr_event ones first to match qcom,sc8280xp-dwc then, that is:
> > 
> >   	pwr_event_1
> >   	pwr_event_2
> >   	pwr_event_3
> >   	pwr_event_4
> >   	dp_hs_phy_1
> >   	dm_hs_phy_1
> >   	dp_hs_phy_2
> >   	dm_hs_phy_2
> >   	dp_hs_phy_3
> >   	dm_hs_phy_3
> >   	dp_hs_phy_4
> >   	dm_hs_phy_4
> >   	ss_phy_1
> >   	ss_phy_2
> > 
> > so we have them grouped as pwr_event followed by HS and with SS last.
> > 
> >> Side note: Please note how the above interrupt properties can also be
> >> used to infer the number of HS and SS ports.

> Can't we just cleanup all at once later ? Might not be a good idea for 
> some properties in the file to have _irq and for some to not have it. I 
> will modify the order though.

No, DT bindings generally need to be as correct as possible from the
start as they form an ABI. So please drop the _irq suffix from all of
the new indexed names.

Johan
