Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789A8085E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378439AbjLGJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjLGJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:50:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC3193
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:50:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5B0C433CB;
        Thu,  7 Dec 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701942621;
        bh=YzfxSDFRzoSe+GPPF5UuUyQYbQJvr9Enxd0o7o5jPHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHXPpKQXNg1pjrxlf+/vHYiq9+FKp+oLoG9ASwloceCLg8aaYwtTfaAwvxhn4XvS1
         DDLjyxmy6a7zqgWmqaqwBIMNlH4Z0lyJ9e19DBmJLP9KTjs/7bIHknLni1a2EWehPK
         /D/EXii6OkGi6Y+6YLz3Fp7eYYw2AoHHAwyEv4GCpmENzrAuWGmrGaLXeyxsTGNoim
         ly3l4lZOdcwtem6tDSDM36aw6K6rsY7UaIMvgPSJgEDfebhwrO22E2eWEE1mXj7Pb3
         jFXIHA6NuKLi/s/nGnz+sloz2UT8/kceEzhR4E+nk+lK/lAERZqbxiFD+J/Y3gBBOt
         t2lxQPYABvoTg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBB2D-0008FF-0j;
        Thu, 07 Dec 2023 10:51:09 +0100
Date:   Thu, 7 Dec 2023 10:51:09 +0100
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
Message-ID: <ZXGVjY9gYMD6-xFJ@hovoldconsulting.com>
References: <20231127-refclk_always_on-v3-1-26d969fa8f1d@quicinc.com>
 <78815f1b-7390-40de-8afd-ac71806f4051@linaro.org>
 <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
 <20231201060716.GJ4009@thinkpad>
 <166d307e-7d1b-48b5-90db-9b6df01d87c2@linaro.org>
 <20231201111033.GL4009@thinkpad>
 <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
 <20231201123054.GM4009@thinkpad>
 <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
 <20231206131009.GD12802@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206131009.GD12802@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 06:40:09PM +0530, Manivannan Sadhasivam wrote:

> OK. How about, "qcom,broken-refclk"? This reflects the fact that the default
> refclk operation is broken on this platform, so the OS should be prepared for
> it (by keeping it always on).

Shouldn't that be

	qcom,broken-clkreq

since its the CLKREQ# signal used to request REFCLK that is broken, not
the REFCLK itself?

Johan
