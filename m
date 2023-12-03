Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270928020A0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjLCEF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCEFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:05:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE85103
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:06:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0414C433C7;
        Sun,  3 Dec 2023 04:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701576359;
        bh=Sb12NKNzKiav+jhQefJAJ2Uqyi4PD3GBfm4v+Jz7tuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttHCk4BMXGN5JaDPzXmzd/FxEWDj8BieAXsEcaW4u+TkzJJjHxJ/A52/MENRP4Dem
         mQwoKEdc4BGiAeQ2OSFc3yxxP0P9yilcpKNhHC+qQ8aqV4JZlfb3JkZwn5vHBQmrT6
         ZnxFwo/mPllkY/ErqrYmUEnc31NjYp+ZfBNplxejMRjBhXuFtOsoB9RoxrBU1wd2l5
         TfZ6dt8MMSrHV+sRHLl3udTLkz4QY7A+8c60MZHmDLltUMQGND7fT9cng2bL6gZz9c
         4SOvwS6vIi1rftm55YBYTwqqtUnniRY6faF0++8ImYFUC3TZrHigKLOE555Owsm5Il
         rbt3PSafIVGdQ==
Date:   Sat, 2 Dec 2023 20:09:24 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8550: Add GPU nodes
Message-ID: <y23kmalezyvwcd42jacpoksl7vh2p77e2we3jlbsfiszojmodd@uxlpmdyi3cuq>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
 <20231127-topic-a7xx_dt-v1-3-a228b8122ebf@linaro.org>
 <6504d0d8-3087-4990-a8f3-1517eb68707b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6504d0d8-3087-4990-a8f3-1517eb68707b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:21:30PM +0100, Konrad Dybcio wrote:
> On 27.11.2023 17:20, Konrad Dybcio wrote:
> > Add the required nodes to support the A740 GPU.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi | 166 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > index 7bafb3d88d69..8f6641c58b3b 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > @@ -2841,6 +2841,172 @@ dispcc: clock-controller@af00000 {
> >  			#power-domain-cells = <1>;
> >  		};
> >  
> > +		gpu: gpu@3d00000 {
> > +			compatible = "qcom,adreno-740.1", "qcom,adreno";
> The milisecond I pressed "send" I realized this is not the correct revision
> of this patch.. The compatible needs to change.
> 

I could have corrected it while applying the patch if you only included
the revision here...

Looking forward to v2.

Regards,
Bjorn
