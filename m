Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53ED808BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443505AbjLGPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443473AbjLGPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:31:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B3710C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:31:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE94C433C9;
        Thu,  7 Dec 2023 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701963089;
        bh=6F4ahMF1HkJD/fLnjNXZvdSTw88g4sCNHF10gcN6v14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKI5e+Z7SRmOTHUEIpDvA0cfxmqVkOIgYb/ExhWL1GIr38FKOpv+LUlJTrLJmw/Bt
         kM3hr9wKXV16NNrg/pDjrwLb1mRts+uOP3R44iRTU40lzeWP9KauCr8PZ7WUp+STg8
         +6l/Vp8jg4G9pxQq105DqH4p+pcWSYSerhKYSW7lanNTLa9u0bFDNCBVZLEe0yHMMB
         zh5Qr7k6SxCPfKrXIvi1NSDri9SQEIqW5qHx6+E8w+u+vv0N53+ImF6jTg/Od2hmYP
         BPpJGR8RMkWWCo8AF1WQQgSGAKDn0UHq0GjoYj+PrT/O2vfUwy/F+/Cuj54Y6dJWRC
         F6hfLSUK5kokQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBGMN-0000r2-1S;
        Thu, 07 Dec 2023 16:32:19 +0100
Date:   Thu, 7 Dec 2023 16:32:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
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
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
Message-ID: <ZXHlg3orGSEXjO7w@hovoldconsulting.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-4-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100950.28712-4-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:39:47PM +0530, Krishna Kurapati wrote:
> On several QUSB2 Targets, the hs_phy_irq mentioned is actually
> qusb2_phy interrupt specific to QUSB2 Phy's. Rename hs_phy_irq

('PHY' throughout)

> to qusb_phy for such targets.

'qusb2_phy'

> In actuality, the hs_phy_irq is also present in these targets, but
> kept in for debug purposes in hw test environments. This is not
> triggered by default and its functionality is mutually exclusive
> to that of qusb2_phy interrupt.
> 
> Add missing hs_phy_irq's, pwr_event irq's for qusb2 phy targets.

You also add some SS_PHY interrupts which could potentially enable
remote wakeup.

> Also modify order of interrupts in accordance to bindings update.

Say something here to as to why this is safe (e.g. all known current
users look up these interrupts by name).
 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Johan
