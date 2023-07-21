Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0E75C5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGULQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGULQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE17B3;
        Fri, 21 Jul 2023 04:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D489619FD;
        Fri, 21 Jul 2023 11:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49392C433C7;
        Fri, 21 Jul 2023 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689938174;
        bh=NWyqzz5a+wAq6c2twKmdidEBQwn5x/NSXAUIdsFwufU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pt3dweDjmU4JyP0PLAYVWb3i2Jj/iUiWaKYGf253+T5ThrPpgVry/wVc6r6xrJqhM
         mbxOK1gYUQf2cM5czIJQKKiCBSp+NtB76R1+qhCDbbTc5sRD1rrFNvPgOzNd2/uCCt
         nWFJaYiAlFTLAJ37wFJR/kmUoB7DiUVM29/xm0XinxE7rNmJDrMQvHBGcbQvbf6Ffj
         MAEiZx3dz1/LcxoIWi+1SjDSRcmgsyJ7noZ7gcVMh8qkwzVHO3AcyP0JEaesjfoyjp
         43acpy0pWdb4zZkiXMmZ3Mw8M/dyC6alpEIvhnysnfI1u/26oA4TleouxuQ1702IRY
         Xv4vTUeXFkZRA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMo7T-0003q6-1C;
        Fri, 21 Jul 2023 13:16:23 +0200
Date:   Fri, 21 Jul 2023 13:16:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, ahalaney@redhat.com
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZLppB67LyWk1kD8w@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
 <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
 <26ae15d1-4e13-3ab7-6844-3a7d3ed03af4@quicinc.com>
 <ZLEOk-9VImJNHYHa@hovoldconsulting.com>
 <f02104c0-d177-0e4e-dcb0-ffca589c8b00@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02104c0-d177-0e4e-dcb0-ffca589c8b00@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:08:45PM +0530, Krishna Kurapati PSSNV wrote:
> On 7/14/2023 2:30 PM, Johan Hovold wrote:
> > On Mon, Jul 03, 2023 at 12:35:48AM +0530, Krishna Kurapati PSSNV wrote:
> >> On 6/27/2023 9:13 PM, Johan Hovold wrote:
> >>> On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
> >>>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
> > 
> >>>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> >>>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> >>>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> >>>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> >>>>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> >>>>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> >>>>> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
> >>>>> +	}
> >>>
> >>>> When testing this on the X13s I get:
> >>>>
> >>>> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2
> >>>>
> >>>> for the third port, whose status registers always seems to return zero
> >>>> (e.g. as if we're checking the wrong register?):
> >>>>
> >>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 0, pwr_event_stat = 38103c
> >>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 1, pwr_event_stat = 38103c
> >>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 2, pwr_event_stat = 00
> >>>> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 3, pwr_event_stat = 140030
> >>>>
> >>>> I verified that everything appears to work as expected on sa8295p-adp.
> >>>>
> >>>> Do you have any idea of what may be causing this?
> >>>
> >>> You never replied to this; do you have any idea why the status register
> >>> for the second port seemingly always read back as 0 on the X13s?
> > 
> >>    Missed this mail. This never popped up on my system. So no idea what
> >> is different in Lenovo X13s. Might need to check with team internally.
> > 
> > Did you hear anything back regarding the above?
> > 
> > Could it even be that the register offset it not correct for sc8280xp?

> No. I rechecked the register offsets and they are proper. (same as what 
> we are using in downstream).
> 
> Adding Jack and Wesley to help with any suggestions here.

Still no idea as to why this appears to be broken on sc8280xp and
triggers an error on every suspend?

Johan
