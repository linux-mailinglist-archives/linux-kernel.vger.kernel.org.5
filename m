Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEB7FEABA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbjK3Idf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjK3Ide (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:33:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC7D9A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:33:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B39C433C8;
        Thu, 30 Nov 2023 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701333220;
        bh=tRGvouhLQr1KpWUDyBmlCJiZ9WRoYoSqiQEHNkqWpbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gv5ZR8S2wi4mCPXgnySrTlzpfn8Ix+u0SnoSorF+TU+YWGFoKQITboqfE2qa4B13k
         AQmoENYxBt1UZoxBdkhKodzZHHNf3IojFoFob0jYKZV5mEm++fpV7iX0CB/FUt+hR+
         MwLAS+X41xv4WfWmruPOAhpu4yGZUXGzblbi2K2aNKw/GwwptHCOKlD2XF3fySsEQO
         BrkutL9jYwzpDJUlI2jXJaIQoa6xeg93HWgG3oo2rEHdSvzLhVH8JCTBs7gExvSYen
         K3Ue0JhAm73hoJuk6mDKs/FosOv1xbB95a+LvzPnHYWus6oBhUR6HIRDa/U2oTD9kL
         yso7IkSVapc6A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r8cUt-0006Z9-2R;
        Thu, 30 Nov 2023 09:34:12 +0100
Date:   Thu, 30 Nov 2023 09:34:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Message-ID: <ZWhJA6m7IQk00rk-@hovoldconsulting.com>
References: <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
 <ZWCpGdJRexnk98IN@hovoldconsulting.com>
 <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
 <ZWW_FOAKp95Cf9vN@hovoldconsulting.com>
 <18965bb9-7afa-4892-8b71-981ba29d2cd4@quicinc.com>
 <ZWXHrvUDnF2dMk6r@hovoldconsulting.com>
 <6d7527bf-8c1a-49b5-a0cf-99a92098c971@quicinc.com>
 <c8a28c72-5c0a-4a67-a4c9-e46a5716cda4@linaro.org>
 <ZWcPZPX-eT-xHAOv@hovoldconsulting.com>
 <85527699-f549-4728-b263-7d10c669b889@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85527699-f549-4728-b263-7d10c669b889@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:16:41AM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2023 11:16, Johan Hovold wrote:
> > On Wed, Nov 29, 2023 at 10:28:25AM +0100, Krzysztof Kozlowski wrote:
> >> On 28/11/2023 12:32, Krishna Kurapati PSSNV wrote:
> >>>
> >>>>
> >>>> So back to my initial proposal, with a slight modification moving
> >>>> pwr_event first (e.g. as it is not a wakeup interrupt):
> >>>>
> >>>> qusb2-:
> >>>>
> >>>> 	- const: pwr_event
> >>>> 	- const: qusb2_phy
> >>>> 	- const: ss_phy_irq	(optional)
> >>>>
> >>>> qusb2:
> >>>>
> >>>> 	- const: pwr_event
> >>>> 	- const: hs_phy_irq
> >>>> 	- const: qusb2_phy
> >>>> 	- const: ss_phy_irq	(optional)
> >>>>
> >>>> femto-:
> >>>> 	- const: pwr_event
> >>>> 	- const: dp_hs_phy_irq
> >>>> 	- const: dm_hs_phy_irq
> >>>> 	- const: ss_phy_irq	(optional)
> >>>>
> >>>> femto:
> >>>> 	- const: pwr_event
> >>>> 	- const: hs_phy_irq
> >>>> 	- const: dp_hs_phy_irq
> >>>> 	- const: dm_hs_phy_irq
> >>>> 	- const: ss_phy_irq	(optional)
> >>
> >> I did not follow entire thread and I do not know whether you change the
> >> order in existing bindings, but just in case: the entries in existing
> >> bindings cannot change the order. That's a strict ABI requirement
> >> recently also discussed with Bjorn, because we want to have stable DTB
> >> for laptop platforms. If my comment is not relevant, then please ignore.
> > 
> > Your comment is relevant, but I'm not sure I agree.
> > 
> > The Qualcomm bindings are a complete mess of DT snippets copied from
> > vendor trees and which have not been sanitised properly before being
> > merged upstream (partly due to there not being any public documentation
> > available).
> 
> True.
> 
> > This amounts to an unmaintainable mess which is reflected in the
> > binding schemas which similarly needs to encode every random order which
> > the SoC happened to use when being upstreamed. That makes the binding
> > documentation unreadable too, and the next time a new SoC is upstreamed
> > there is no clear hints of what the binding should look like, and we end
> > up with yet another permutation.
> 
> While in general I agree for the bindings, but here, for order of the
> interrupts, I am not really sure if this contributes to unreadable or
> unmaintainable binding.

The more if-then clauses you have, the harder it gets for a human to
make sense of the binding documents.

By cleaning up the current clauses in four groups which reflect actual
classes of hardware and not just arbitrary reordering and omission, it
will make it much easier next time a new SoC is added. Most likely it
belongs in the latest category, and a reviewer can more easily spot new
mistakes if someone tries to add yet another permutation.

> > As part of this exercise, we've also determined that some of the
> > devicetrees that are already upstream are incorrect as well as
> > incomplete.
> 
> Sure, good explanation for an ABI break.
> 
> > I really see no alternative to ripping of the plaster and cleaning this
> > up once and for all even if it "breaks" some imaginary OS which (unlike
> > Linux) relies on the current random order of these interrupts.
> > 
> > [ If there were any real OSes actually relying on the order, then that
> > would be a different thing of course. ]
> 
> The commit breaking the ABI can justify the reasons, including expected
> impact (e.g. none for Linux).
> 
> While the second part probably you can justify (interrupts are taken by
> name), the reason for ABI break like "I think it is poor code, so I will
> ignore ABI" is not enough.

So it's not so much about the code as the messy binding schema this
results in and that that makes it harder to spot mistakes next time an
SoC is upstreamed.

Johan
