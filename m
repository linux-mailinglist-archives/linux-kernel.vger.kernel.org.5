Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC85751A09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGMHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMHiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC80C1;
        Thu, 13 Jul 2023 00:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48B161A3F;
        Thu, 13 Jul 2023 07:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D53BC433C8;
        Thu, 13 Jul 2023 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689233886;
        bh=M/Ep5iSr1YSGj+qt83vK1Al8zsiF7h1z2MTiQXaepbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEP+VEsDCj3gwsVKfQmpeJ0zAHgcBRD8She7CRG2jnTKWkGkAcjcZ0VvY09tJzZhq
         BHjPICtKxXhvW6/aIyhFavYhtPEpLuyqfpNsO+b2Gu8AUvsM3DX9xJCtcuiIukdmAI
         3yX5Vx8UwRJfV1guMrH7X8bPUbpJdZHaNu2kbyYObfIDFt4D/kbn7fnWlTb9m+vpyr
         xrsn+vbZW/GACKhglRa/uipXvmH+N9p/gpxJGPx+Js02F8jCz09NCiiGjQisF19mwM
         JJ6X+46bo5EME8mY0S8wgKHRPyu5/99dM1lPTZVrzHnWvvTv+mO8+7PE3Gwjzg5uuR
         oAwbvXHUTn1Nw==
Date:   Thu, 13 Jul 2023 13:07:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 04/14] arm64: dts: qcom: sdm845: Fix the min frequency of
 "ice_core_clk"
Message-ID: <20230713073750.GI3047@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-5-manivannan.sadhasivam@linaro.org>
 <20230713073003.GE2199@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713073003.GE2199@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:30:03AM -0700, Eric Biggers wrote:
> On Wed, Jul 12, 2023 at 04:01:59PM +0530, Manivannan Sadhasivam wrote:
> > Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
> > downstream vendor devicetree. So fix it!
> > 
> > https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > 
> > Fixes: cc16687fbd74 ("arm64: dts: qcom: sdm845: add UFS controller")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 9ed74bf72d05..89520a9fe1e3 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
> >  				<0 0>,
> >  				<0 0>,
> >  				<0 0>,
> > -				<0 300000000>;
> > +				<75000000 300000000>;
> 
> Thanks for fixing this!  What was the visible effect of this bug, if any?

No, this was just based on inspection.

> Do you know why the minimum has that particular value?
> 

Min and max frequencies come from the Qcom's internal documentation where they
have calculated the freq range based on RPMh performance states.

> The Fixes tag is wrong; it should be:
> 
> Fixes: 433f9a57298f ("arm64: dts: sdm845: add Inline Crypto Engine registers and clock")
> 

Yikes! Thanks for noticing, will fix it.

- Mani

> - Eric

-- 
மணிவண்ணன் சதாசிவம்
