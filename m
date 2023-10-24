Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8427D4820
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjJXHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjJXHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:12:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE410C;
        Tue, 24 Oct 2023 00:12:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED6BC433CA;
        Tue, 24 Oct 2023 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698131575;
        bh=6CW+3Mmz6AosZy/4MFTzdVXxgv6Dow6fy47mc3T3cbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvuPMG3mLH4cjcaxdM5ceCtggaqLCvzsX/2dPTTtS5NUxh2/1joGMNATqlf2bSCeF
         j6vqYdacne5LP0g6zwKGtySpTPtQ5obiwNCstYK2tBs/xSiU9JGrgRPx712CFLkems
         n8+zCAq9bQULzmV38+BedJXQmNC9/am05bbI07dvLq6S4AKIvF163KiZ53WRc3oekU
         5hs83xnaew8KGnCMugp+tFHq+Hz1OlzS9Ii56ZoFhQOextA1HgX4GnC3aVjKA6OFZO
         BPQKB/WwTL/RWeogVgJbau3jPxR8qycQnSmMEQEDlbOiLtu1DhVD8OgXBcAnT7Yczi
         sirlvGaXQfSrw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvBbD-0003dv-1g;
        Tue, 24 Oct 2023 09:13:11 +0200
Date:   Tue, 24 Oct 2023 09:13:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZTduh5LULBMYf3wq@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-9-quic_kriskura@quicinc.com>
 <ZTaauQewazaaFonF@hovoldconsulting.com>
 <c50e9266-2308-4fd5-b102-f604bf4ce2e8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50e9266-2308-4fd5-b102-f604bf4ce2e8@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:04:38PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 9:39 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:18:04PM +0530, Krishna Kurapati wrote:

> > The interrupt order does not match the binding, where the power event
> > interrupts come first.
> > 
> > And we probably also want the hs_phy_irqs here after fixing the
> > incomplete binding.
> 
> You want to update the driver code for this as well ? I have no problem 
> in adding it in DT and binding but not in driver.

Possibly both.
 
> >> +			usb_2_dwc3: usb@a400000 {
> >> +				compatible = "snps,dwc3";
> >> +				reg = <0 0x0a400000 0 0xcd00>;
> >> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > I'd also like to know what that second dwc3 interrupt is for and whether
> > it should be defined here as well.
> 
> Second interrupts is for HW acceleration I believe for which support is 
> not there currently.

But the interrupt is there. And devicetree describes the hardware, not
the implementation, as I've pointed out before.

Johan
