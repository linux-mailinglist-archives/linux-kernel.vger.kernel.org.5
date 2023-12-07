Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98A8088BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379432AbjLGNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjLGNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:04:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D310CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:04:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D67BC433C7;
        Thu,  7 Dec 2023 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701954263;
        bh=4jBaR1qmNEDVE39mC30/eFVzEXe5bQ1xUwFeHyj0RXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e01Eyt0rpcM1Ytp27Vi/5Ux5jIZUUg3qNyVEgLwye46M3zTNK5v/AhaEytBZ4LHRj
         BPtpM4DFz6IHzU1/ql9R7G78du7TsHXIPrhm8VN+4RsUrHks32ZqIjv0yWEMIaFqNB
         jOd3IVBrVb9tKtDTZulik5qo9s57vl4bxKLhS/RSV1gmsVUAREBJnf/BImCYnPvMGK
         d1z96fqnY6a1WjT9XfmIt+ou7UN8pd+TQrHhALYpDyKHW1CkCwBzxdPJxH6g9QhFSx
         D83TwKDW42u9M/tS8nbeKhFC9yXF4/YbUPkVLUdlp112U3z+4NmNtoKzbviQHDoMQk
         qBfWp47EIJBJQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBE40-0000IF-2r;
        Thu, 07 Dec 2023 14:05:12 +0100
Date:   Thu, 7 Dec 2023 14:05:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Message-ID: <ZXHDCNosx8PCUzao@hovoldconsulting.com>
References: <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
 <20231201060716.GJ4009@thinkpad>
 <166d307e-7d1b-48b5-90db-9b6df01d87c2@linaro.org>
 <20231201111033.GL4009@thinkpad>
 <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
 <20231201123054.GM4009@thinkpad>
 <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
 <20231206131009.GD12802@thinkpad>
 <ZXGVjY9gYMD6-xFJ@hovoldconsulting.com>
 <20231207101252.GJ2932@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207101252.GJ2932@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:42:52PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Dec 07, 2023 at 10:51:09AM +0100, Johan Hovold wrote:
> > On Wed, Dec 06, 2023 at 06:40:09PM +0530, Manivannan Sadhasivam wrote:
> > 
> > > OK. How about, "qcom,broken-refclk"? This reflects the fact that the default
> > > refclk operation is broken on this platform, so the OS should be prepared for
> > > it (by keeping it always on).
> > 
> > Shouldn't that be
> > 
> > 	qcom,broken-clkreq
> > 
> > since its the CLKREQ# signal used to request REFCLK that is broken, not
> > the REFCLK itself?
> > 
> 
> Darn... You are right. I got carried away by the initial property name. Thanks
> for spotting!

Thinking some more on this after hitting send: It may still be wrong
with a 'broken-clkreq' property in the PHY instead of in the controller
(or endpoint).

Could there not be other ways to handle a broken clkreq signal so that
this really should be a decision made by the OS, for example, to disable
L1 substates and clock PM?

Simply leaving the refclk always on in the PHY seems like a bit of a
hack and I'm not even sure that can be considered correct.

Having a property that maps directly to that behaviour has rightly been
rejected, but it seems that simply renaming the flag but keeping it in
the PHY may still not be the right thing to do here.

Johan
