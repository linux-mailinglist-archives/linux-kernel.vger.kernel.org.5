Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4A75EAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGXFqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGXFqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:46:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B7138
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:46:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-348d1cf5639so2101565ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690177593; x=1690782393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TG6JOP2J900QufJGXL3SOGbK0BDioW/ee138PuYXujs=;
        b=Ed7dQ67b9NC7GE6UJWlEnDJTcg4ufIpLfEwH6rG36MHsuuEdaXkcEC7onDl82a0u0X
         PGTemZr1iZ+UAZ0+dNTyoPbLdmKBRJoWQcsM568mC++UxnTMyc69Qvi7VT/jWa+nQz9O
         tJ8MhwtgbQYmjOf3UAkBcLCTbKwKg9zjmlaZGs6RnzYWMpdGE//zw6yPLBTIZ2BjppEu
         1DG4zunBg91k1XhSPl+E+pF7Vi/1KHWVPFfbpcJJIOM8GtJd5SbHv27TVaVJNeBQ2B5I
         sIYjPwSh4f2ThS3542kmbMGo8mxysrpPUJmbNb3nhscFpfAKpIrJ71T8Pj71egi/mmqs
         rgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690177593; x=1690782393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TG6JOP2J900QufJGXL3SOGbK0BDioW/ee138PuYXujs=;
        b=berlhbQBDnDZCLEyNtuxg4aYJAipVFUPGGUCjXcI4lU3fWWknog5k5TdQRA2vqg2zf
         wBC6HiTcUniYtzjxQo/4WiMbSZE7ExmLrtThoV/hs8sj9Q7tAe5CvR4NxwuLdomP15MM
         acotO0S4miSjpq1vCulrnAw4LLAZf209ifLYfIAnGKgmlKWF6CCUTg7P+wnrk4AfUr6M
         sq6zEkcuk5jN6IJcJ1lHUZLMZKGGf+x15/95bNhyol/qssxKwJDnRcysJIbkIB2C/aqt
         VQjAw172FDhr9vHyh34KUbMvWNHJ/TTg7+hbRY91jr1Ya32xd5z+N5PdMYXPyrQEWh6n
         +T5g==
X-Gm-Message-State: ABy/qLa49E4lSYXVeIlgcS67Y/CgDxlzqUNMrFL9r3CQBe4tyPgl38To
        7tWdsiKn03zJ9K9WtT1uFONT
X-Google-Smtp-Source: APBJJlGL8LQaESe7C4zGtaDDj+x2d1qp08DMCz6L9amQV7T/sz1yGscztMp9pp22xLnvWa4ZLJ0VYg==
X-Received: by 2002:a05:6e02:1a8a:b0:345:6e49:30d2 with SMTP id k10-20020a056e021a8a00b003456e4930d2mr6548275ilv.10.1690177593359;
        Sun, 23 Jul 2023 22:46:33 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id s9-20020a63af49000000b0055ff89c5453sm7459240pgo.6.2023.07.23.22.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:46:32 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:16:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
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
Subject: Re: [PATCH v2 09/15] PM / devfreq: Switch to
 dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
Message-ID: <20230724054611.GA2370@thinkpad>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-10-manivannan.sadhasivam@linaro.org>
 <1703ab6e-8567-8574-f011-af19813f97e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1703ab6e-8567-8574-f011-af19813f97e8@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:06:04AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 23. 7. 20. 14:40, Manivannan Sadhasivam wrote:
> > Some devfreq consumers like UFS driver need to work with multiple clocks
> > through the OPP framework. For this reason, OPP framework exposes the
> > _indexed() APIs for finding the floor/ceil of the supplied frequency of
> > the indexed clock. So let's use them in the devfreq driver.
> > 
> > Currently, the clock index of 0 is used which works fine for multiple as
> > well as single clock.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/devfreq/devfreq.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index e36cbb920ec8..7686993d639f 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -88,7 +88,7 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
> >  	struct dev_pm_opp *opp;
> >  	unsigned long min_freq = 0;
> >  
> > -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> > +	opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &min_freq, 0);
> 
> This patch changed the used function from dev_pm_opp_find_freq_ceil
> to dev_pm_opp_find_freq_ceil_indexed even if there are no supporting of the multiple clocks
> and then dev_pm_opp_find_freq_ceil is not removed from OPP.
> 
> I think that it is better to use dev_pm_opp_find_freq_ceil_indexed
> when need to support multiple clocks with real case.
> 

There is the user for dev_pm_opp_find_freq_ceil_indexed() which is the UFS
driver and since UFS is using devfreq, we need this change. I've added this info
in the commit message as well. What am I missing?

- Mani

> >  	if (IS_ERR(opp))
> >  		min_freq = 0;
> >  	else
> > @@ -102,7 +102,7 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
> >  	struct dev_pm_opp *opp;
> >  	unsigned long max_freq = ULONG_MAX;
> >  
> > -	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
> > +	opp = dev_pm_opp_find_freq_floor_indexed(devfreq->dev.parent, &max_freq, 0);
> >  	if (IS_ERR(opp))
> >  		max_freq = 0;
> >  	else
> > @@ -196,7 +196,7 @@ static int set_freq_table(struct devfreq *devfreq)
> >  		return -ENOMEM;
> >  
> >  	for (i = 0, freq = 0; i < devfreq->max_state; i++, freq++) {
> > -		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
> > +		opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &freq, 0);
> >  		if (IS_ERR(opp)) {
> >  			devm_kfree(devfreq->dev.parent, devfreq->freq_table);
> >  			return PTR_ERR(opp);
> > @@ -2034,18 +2034,18 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
> >  
> >  	if (flags & DEVFREQ_FLAG_LEAST_UPPER_BOUND) {
> >  		/* The freq is an upper bound. opp should be lower */
> > -		opp = dev_pm_opp_find_freq_floor(dev, freq);
> > +		opp = dev_pm_opp_find_freq_floor_indexed(dev, freq, 0);
> >  
> >  		/* If not available, use the closest opp */
> >  		if (opp == ERR_PTR(-ERANGE))
> > -			opp = dev_pm_opp_find_freq_ceil(dev, freq);
> > +			opp = dev_pm_opp_find_freq_ceil_indexed(dev, freq, 0);
> >  	} else {
> >  		/* The freq is an lower bound. opp should be higher */
> > -		opp = dev_pm_opp_find_freq_ceil(dev, freq);
> > +		opp = dev_pm_opp_find_freq_ceil_indexed(dev, freq, 0);
> >  
> >  		/* If not available, use the closest opp */
> >  		if (opp == ERR_PTR(-ERANGE))
> > -			opp = dev_pm_opp_find_freq_floor(dev, freq);
> > +			opp = dev_pm_opp_find_freq_floor_indexed(dev, freq, 0);
> >  	}
> >  
> >  	return opp;
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
> 

-- 
மணிவண்ணன் சதாசிவம்
