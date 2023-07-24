Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395E175EB04
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGXFs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGXFsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:48:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E318C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:48:48 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a5a7ebdd9fso1169221b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690177728; x=1690782528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNMSJE9p1d1PLJNEmsQ7eFS8jEnCuwKDv4PumrYQpcU=;
        b=U2hCDJhqsVhkHUOQsTHa749IWNwB0SnHVLRpLCH+muXbPeT9dFRmgcZAt180d0ZGwQ
         GoFJw8/oJ/6kKRqNckSYZe+MtIYZJJucZdWCR+j5PJEGUjNSUVIeRfwAqJ+ECgoo4XTi
         DOGAaudgfcJW9Sz0dPv2uWhvq/XushbdnZyhIkY5z5Qzg89DdSyrJ+lvXIgqEO1iuvoY
         Zt3cumjiC1wQxl/1XDgRTL+zWaClNYqe8PFqwQeleeLpXsdICfpKICzpeNpC0SWzTOKV
         EVlOqbQ5D9Dj5BaJvtgsfX88GVXXvr35iAvrLxsyjvIyXtQ45O1vcTfg/0asjpsztYWE
         M6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690177728; x=1690782528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNMSJE9p1d1PLJNEmsQ7eFS8jEnCuwKDv4PumrYQpcU=;
        b=EmVKWWnPfp1bRRE3jgXsnWDX90DNTDAXjPat10LHPmNnFGknsOlKqHDOQfdzoZcEcL
         xc0VVajNy8+ldPTqhMGrHfp5AyHz0r9VPv+zgEYopTlutPu5OjL2ZFFX7P0ToYZ0kDmZ
         OFLdxBBuJ2JTZmuujWi4MeflbHbSKH8Y1PimcPaloCg+8BMIfICqtyKebNGjhYm08FqH
         TIbozgmDX/NtMA69Sbf/tr0nTv3JDq+YQx8I80i6uMEmqo3YCd0tmveJeOPIVE+DdXnS
         ienpk8svfT0pqfrdL5N/NN1tzrbLP7OgXlGIMBN0+sdXKj3xZvU9tDbyne/onUzsf9FD
         Unxw==
X-Gm-Message-State: ABy/qLbIjG8wjXJB1QGGzl3qdd4XxR7OEuER1D3guUqEYo+9XDneYyKU
        4EQJNlDfHK1qVKIBPuJWNOuV
X-Google-Smtp-Source: APBJJlFz6ludZ7Mio0r4WkFjCla6W2awgNfZfIDwDmUrHT+7qIWS2Z4g1QjBEXxpcBblte51sXGp0g==
X-Received: by 2002:a05:6808:1a2a:b0:3a1:eb0e:ddc6 with SMTP id bk42-20020a0568081a2a00b003a1eb0eddc6mr11524567oib.29.1690177727975;
        Sun, 23 Jul 2023 22:48:47 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a714b00b002676e961261sm7285578pjs.1.2023.07.23.22.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:48:47 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:18:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
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
Message-ID: <20230724054831.GB2370@thinkpad>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-5-manivannan.sadhasivam@linaro.org>
 <20230721071801.e6ngfnkwg2ujsklg@vireshk-i7>
 <20230721115731.GB2536@thinkpad>
 <q36uuwhjmolgf3kjn3rrtw5fgfobatav334fez4cofzmrvge2h@cgwfhhhy6b6s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q36uuwhjmolgf3kjn3rrtw5fgfobatav334fez4cofzmrvge2h@cgwfhhhy6b6s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:15:36PM -0700, Bjorn Andersson wrote:
> On Fri, Jul 21, 2023 at 05:27:31PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 21, 2023 at 12:48:01PM +0530, Viresh Kumar wrote:
> > > On 20-07-23, 11:10, Manivannan Sadhasivam wrote:
> > > > Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
> > > > downstream vendor devicetree. So fix it!
> > > > 
> > > > https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > 
> > > > Fixes: 433f9a57298f ("arm64: dts: sdm845: add Inline Crypto Engine registers and clock")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > index 9ed74bf72d05..89520a9fe1e3 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > @@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
> > > >  				<0 0>,
> > > >  				<0 0>,
> > > >  				<0 0>,
> > > > -				<0 300000000>;
> > > > +				<75000000 300000000>;
> > > >  
> > > >  			status = "disabled";
> > > >  		};
> > > 
> > > Please keep new feature and fixes like this in separate series. This
> > > could be merged directly in the currently ongoing kernel rc and
> > > doesn't need to wait for this series.
> > > 
> > > Or at least keep the commit at the top, so another maintainer can
> > > simply pick it.
> > > 
> > 
> > That's what I did. This patch and previous patch are the fixes patches, so they
> > are posted on top of other dts patches to be merged separately if required.
> > 
> 
> I agree with Viresh, this is patch 4 in a series where 1-2, 7- are new
> things.
> 
> I can pick this from here, but I think it would have been better to send
> this as 3-4 different series; 1 with DeviceTree fixes, 1 with driver
> fixes, one that adds interconnect support and one that adds opp support
> - the latter two with dts changes last...
> 
> 
> And, the freq-table-hz -> opp transition in dts files must be merged
> after the driver changes, so this will likely have to wait until 1
> release after the driver changes.
> 

Hmm, Ok. Let me resend the series as you suggested (excluding the patches
already merged).

- Mani

> Regards,
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
