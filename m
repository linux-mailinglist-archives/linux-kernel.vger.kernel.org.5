Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356CF808D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjLGQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjLGQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:12:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344584
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:12:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9396DC433C8;
        Thu,  7 Dec 2023 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701965531;
        bh=oDFKU6He3TF2Z/VxsatMVTx0wO+MupzIPTDKqHifMUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgdsO7OIKFVnsRpXfPzhSFtBbKHmi+fLTH0WyXQIbUw+SmRKpaiHLmHcaQhxMjxng
         9IHefwqe3Ryh6cPXGecRg3Hubb0SDQ6+CfcPRYxMyquIqGqdF9+dc1Crptxu320g/y
         L7bSFC0PRGMrGe20aQYp6+X3X8+KuJlVundGC64PrvmFcG9BBJVX5ojLNHrxjMsjIy
         65Wu5b7SCS6kM/XlzY2FjFsjnDIskG1bAX2I+AuPz+xSdWTJPJkNtp4u39MMeyWE4T
         +p1VNFAwPB1qdJdm/n6vp6YYGvXOiIxbvB6s087lgX3gV8dzUcg/nBw/iSDI+oYRN3
         YDxGY6xtqQcUw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBGzl-00011w-1k;
        Thu, 07 Dec 2023 17:13:01 +0100
Date:   Thu, 7 Dec 2023 17:13:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Message-ID: <ZXHvDaeoG1SuZ9xj@hovoldconsulting.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-2-quic_kriskura@quicinc.com>
 <ZXHjXGEbdtbCiOck@hovoldconsulting.com>
 <028097f3-9056-4c07-a868-4eeac9bc8c94@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028097f3-9056-4c07-a868-4eeac9bc8c94@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:14:55PM +0530, Krishna Kurapati PSSNV wrote:
 
> >> +        - qusb2_phy:: SoCs with QUSB2 PHY do not have separate DP/DM IRQs and
> >> +                      expose only a single IRQ whose behavior can be modified
> >> +                      by the QUSB2PHY_INTR_CTRL register. The required DPSE/
> >> +                      DMSE configuration is done in QUSB2PHY_INTR_CTRL register
> >> +                      of phy address space.
> >> +        - {dp/dm}_hs_phy_irq:: These IRQ's directly reflect changes on the DP/
> >> +                               DM pads of the SoC. These are used for wakeup
> >> +                               only on SoCs with non-QUSBb2 targets with
> > 
> > QUSB2 typo
> > 
> >> +                               exception of SDM670/SDM845/SM6350.
> >> +        - ss_phy_irq:: When in super speed mode of operation, interrupts are
> > 
> > Capitalise 'Super Speed'
> > 
> >> +                       received when a wakeup event is received on ss_phy_irq.
> > 
> > The description as it stands sounds circular. And this one is only used
> > for remote wakeup right?
> > 
> Yes. It is used for remote wakeup. Mentioning it as wakeup event should 
> be changed ?

It would be good to clarify that this one is the IIUC not used for
connect/disconnect events but just for remote wakeup, that is, unlike
the qusb2_phy and dp/dm_hs_phy interrupts.

The old descriptions just vaguely said "wakeup event" and
connect/disconnect events aren't necessarily wakeup events.

> > Also have you set up the tools so that you can verify your bindings
> > before posing them? I assume the above wouldn't pass (e.g. due to the
> > "(optional)" strings).
> > 
> > There's some more details here:
> > 
> > 	https://docs.kernel.org/devicetree/bindings/writing-schema.html
> > 
> > under "Running checks".
> 
> I did do a dt-binding check and got the following line as well:
> 
>    DTC_CHK Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb
> /local/mnt/workspace/sriramd/upstream/torvalds/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: 
> usb@a6f8800: interrupt-names:4: 'ss_phy_irq (optional)' was expected
>          From schema:

Good that you got that set up.

Johan
