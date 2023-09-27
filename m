Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DD7B045E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjI0Mjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjI0Mjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:39:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636DE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:39:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40535597f01so109992095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695818378; x=1696423178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+cyOeFjn2n638CIp01wW+C7aq6a/BkmIOcsXz/bUSY=;
        b=rp6R9jJ9TqBdLrZ81VnOI3v3v3JzGeI4++hLvQAIGn10K6UxZxFija9vX1hQA8SNTA
         AnbeMm/jjYxnESyaXnF+/sFXKSTn4CnfR1YkzDAaondsghzuEFH0DtNqjf+iVI7y008/
         lGUMxEtSnnzY2w05xoLAZZFlJWzslak5aVzS7o2TdlvcKqm0vAr5wkV7oWrQQCGK1NS9
         rSnx4yTTg115W90xWEWAzLz4jn4Z8FZdGynWOMTvApqHTpBzKSDh5+GKQAJP00V8KTbe
         DVy7B3/CAI2fF+Rt10xJX54MXRiB9xnXQkn94gq1cTirHdqLviVKoyH5DgXZ0MfORCP2
         uIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818378; x=1696423178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+cyOeFjn2n638CIp01wW+C7aq6a/BkmIOcsXz/bUSY=;
        b=se4Dkki4gzTWjZO73bb3wDFQWnIq2DAOms2haWcI88Stvnn+xzgakFAy68eirGF5Tn
         EAxtkJ78cdlH5Bgjr0qg1YYQ5GpdMVqtPOwt+ZCFMDAciUYfVTR2GJPZuPtTpv71xSNS
         MUuQ5bFos4/dBSEneu4CHHbrf5fC8wyl1lnZeFmsTRh4nAynmyq9MCiEWc3WrB84EKjZ
         Kf1dCukYacBTgSdxd8sp7cV+7xETCFxa6XedtAdA9QeqcpBEGupLJhfXWUHgLJCPqNJK
         HcF/e3lisEt3bnCE8ifRN6x6QMSx2/3kzjPv226xSaX198SPKlX9f49KOlaXTbt8hoTV
         FfNw==
X-Gm-Message-State: AOJu0YxMIhqvHpB2CZi5/beElTT7tOoFnwk5/NAXRTRl4KUoo5rUKT0J
        pVCD7vuNcTD4mxEX0gMK+5u1
X-Google-Smtp-Source: AGHT+IEUQrnf8x4OQMQgfuUC6w8g42eZnvd1DnAZZXZ1CqQ6BdhYwmEb1wrC3MAeK+npL0Ctv4zBDg==
X-Received: by 2002:a7b:c7c6:0:b0:401:be70:53b6 with SMTP id z6-20020a7bc7c6000000b00401be7053b6mr1878257wmk.15.1695818378372;
        Wed, 27 Sep 2023 05:39:38 -0700 (PDT)
Received: from thinkpad ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm17787716wmo.40.2023.09.27.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:39:37 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:39:34 +0200
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
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
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: sdm845: Add OPP table support
 to UFSHC
Message-ID: <20230927123934.GA18050@thinkpad>
References: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
 <20230731163357.49045-6-manivannan.sadhasivam@linaro.org>
 <04eb9f71-78f0-41f2-96a6-fc759ba296fa@linaro.org>
 <20230912065918.GB6404@thinkpad>
 <20230927111546.uyaod34zcjr7npgf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927111546.uyaod34zcjr7npgf@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:45:46PM +0530, Viresh Kumar wrote:
> On 12-09-23, 12:29, Manivannan Sadhasivam wrote:
> > On Mon, Sep 11, 2023 at 04:15:10PM +0300, Dmitry Baryshkov wrote:
> > > I'd say, I'm still slightly unhappy about the 0 clock rates here.
> > 
> > Neither do I. But it is the only viable option I could found.
> > 
> > > We need only three clocks here: core, core_clk_unipro and optional
> > > ice_core_clk. Can we modify ufshcd_parse_operating_points() to pass only
> > > these two or three clock names to devm_pm_opp_set_config() ? The OPP core
> > > doesn't need to know about all the rest of the clocks.
> > > 
> > 
> > We need to enable/disable all of the clocks, but only need to control the rate
> > for these 3 clocks. So we cannot just use 3 clocks.
> > 
> > If the OPP table has only 3 entries (omitting the gate-only clocks), then we
> > need some hack in the driver to match the rates against the clock entries. Doing
> > so will result in hardcoding the clock info in the driver which I do not want to
> > do.
> > 
> > If we have something like "opp-hz-names" to relate the rates to clock-names, it
> > might do the job. But it needs some input from Viresh.
> 
> I have already given an option earlier about this [1]. You can change the order
> of clks in the "clock-names" field, so that the first three are the one with
> valid frequencies. You shouldn't need much of the hacks after that I guess.
> 

I do not remember all the details on the top of my head, but I did investigate on
that and concluded that it won't fit.

- Mani

> Or maybe I missed something else now, talked about this a long time ago :)
> 
> -- 
> viresh
> [1] https://lore.kernel.org/all/20230713040918.jnf5oqiwymrdnrmq@vireshk-i7/

-- 
மணிவண்ணன் சதாசிவம்
