Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9975D95D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGVDMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGVDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BAB3A9D;
        Fri, 21 Jul 2023 20:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E21961DCC;
        Sat, 22 Jul 2023 03:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3728C433C8;
        Sat, 22 Jul 2023 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689995538;
        bh=q1c9De4MZ8uHRRY3FXPMx0Q6xjMl4701oGCk+c4Jqwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThsnjbhhkdJboBKAIljvSTt4F6WS4F7yVXJDvUYmZwYzpnc8ARgfaqzuR5yOE1+FR
         b+b36ZyKB99VWSgGvSxqjtisOx1P4zfddWQZIGpYAdln+IkYsZF2qKeCozo7Kr7l6P
         /9VK+5CgojUirOPI1vjvAWyPckb+9wqGygVTNEsptCCdzPqbgReqzERlDxHLy2ZWLG
         om/GBJ1ROwxrlcRxvyCuswS+hcxNg0TEZq4U/WfOTi6p8ktd6/vGK/YssWoFmuNlDF
         c+c2A5HsbJ6bWS5C01uGLt+S5RSk/bdp5fBrc9fiXgUwauEdVL31u/C2h7qkC842Fw
         mGzao7XYgOUxA==
Date:   Fri, 21 Jul 2023 20:15:36 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] arm64: dts: qcom: sdm845: Fix the min frequency
 of "ice_core_clk"
Message-ID: <q36uuwhjmolgf3kjn3rrtw5fgfobatav334fez4cofzmrvge2h@cgwfhhhy6b6s>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-5-manivannan.sadhasivam@linaro.org>
 <20230721071801.e6ngfnkwg2ujsklg@vireshk-i7>
 <20230721115731.GB2536@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721115731.GB2536@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:27:31PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 21, 2023 at 12:48:01PM +0530, Viresh Kumar wrote:
> > On 20-07-23, 11:10, Manivannan Sadhasivam wrote:
> > > Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
> > > downstream vendor devicetree. So fix it!
> > > 
> > > https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > 
> > > Fixes: 433f9a57298f ("arm64: dts: sdm845: add Inline Crypto Engine registers and clock")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 9ed74bf72d05..89520a9fe1e3 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
> > >  				<0 0>,
> > >  				<0 0>,
> > >  				<0 0>,
> > > -				<0 300000000>;
> > > +				<75000000 300000000>;
> > >  
> > >  			status = "disabled";
> > >  		};
> > 
> > Please keep new feature and fixes like this in separate series. This
> > could be merged directly in the currently ongoing kernel rc and
> > doesn't need to wait for this series.
> > 
> > Or at least keep the commit at the top, so another maintainer can
> > simply pick it.
> > 
> 
> That's what I did. This patch and previous patch are the fixes patches, so they
> are posted on top of other dts patches to be merged separately if required.
> 

I agree with Viresh, this is patch 4 in a series where 1-2, 7- are new
things.

I can pick this from here, but I think it would have been better to send
this as 3-4 different series; 1 with DeviceTree fixes, 1 with driver
fixes, one that adds interconnect support and one that adds opp support
- the latter two with dts changes last...


And, the freq-table-hz -> opp transition in dts files must be merged
after the driver changes, so this will likely have to wait until 1
release after the driver changes.

Regards,
Bjorn
