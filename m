Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5475C625
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGULzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGULzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:55:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483342D77
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:55:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8bbcfd89aso11133735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689940509; x=1690545309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=On8b445xAkLYUxpJLOmZ0YWWWQZf3nyJOOroUboklMM=;
        b=T3pZqcf1DO1Oj8nR4yrRDfIASwhXLhR/wRmcZyfEHEtdvRFSMpR9mLda4++5e0L4jp
         +w1msJRSSMqo4TvG2EEMVYWGXRwbbjZCbBDRKahAOsBeng1DJE0VANDVoC1/D0p/Wsnp
         CO9NXuSntfstKdVBC/vknWCVHuJDbdwQG5aKZHuvg4X7lCD8NNyuFe+DqA424uAnvH1p
         iA3rL9+A1bk2S6DvC+MdSDuqsYlt3/fUMWwA3xkblOfh3VBLvcy1WhBs0/fOs93WWW8K
         kpqZROU4xfGnj4muW9lBHYSCvJKEItGoq9pYUoiTI+b72ROx2xAGD9OuQSyG7Z8sK2hG
         vRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689940509; x=1690545309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=On8b445xAkLYUxpJLOmZ0YWWWQZf3nyJOOroUboklMM=;
        b=iRbu50JKXGSL/AND05cR+0xGyh5HyyfpdIOPhZibTQbRp5a8840vYO4yvIRhCsNsMs
         muootXymEcaZgvU4f6d4vPSB/snMANrbl8ov4/1svXywrsHLZV3cH2vFpU86F32H9Xn8
         icPvuIq1/gY52pUpgv/ImrU9Zzr3soUikRCmr9wsx/RqAWYao7qMQ7ZPisQpBM3OH5ZZ
         gOI0yiMF8oGuMxPcu29GebrTgDJclyXTHMUBzYrDvWMUPntIR8Rx2kbryGwob8LCe00g
         3iX5WJpyGqHh6UNPS0MQeVplACCFqYeurNpa5p23JniWsyre0QWtlYuYsi8yjvgaQmZB
         J6Dg==
X-Gm-Message-State: ABy/qLbfblxKgkbZJD9O+xQ0S6dXQdTCbxrKZF5ItMQYdq7xljOSlj5v
        2k5Q+76kuI/uGyRhsajkno7X
X-Google-Smtp-Source: APBJJlFNRGbewBgg9HiacJ4fpesbUAVMolRzK2jP1QYCQXrzycHh/FWUEtZJyRIKO78u2hoKFzxzfw==
X-Received: by 2002:a17:902:9f8f:b0:1ac:8be5:8787 with SMTP id g15-20020a1709029f8f00b001ac8be58787mr1269158plq.21.1689940508620;
        Fri, 21 Jul 2023 04:55:08 -0700 (PDT)
Received: from thinkpad ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902b71800b001b9cea4e8a2sm3245155pls.293.2023.07.21.04.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 04:55:08 -0700 (PDT)
Date:   Fri, 21 Jul 2023 17:24:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Subject: Re: [PATCH v2 00/15] UFS: Add OPP and interconnect support
Message-ID: <20230721115453.GA2536@thinkpad>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230721094206.dfgnn73kmzzj6rtw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721094206.dfgnn73kmzzj6rtw@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:12:06PM +0530, Viresh Kumar wrote:
> On 20-07-23, 11:10, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series adds OPP (Operating Points) support to UFSHCD driver and
> > interconnect support to Qcom UFS driver.
> > 
> > Motivation behind adding OPP support is to scale both clocks as well as
> > regulators/performance state dynamically. Currently, UFSHCD just scales
> > clock frequency during runtime with the help of "freq-table-hz" property
> > defined in devicetree. With the addition of OPP tables in devicetree (as
> > done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> > both clocks and performance state of power domain which helps in power
> > saving.
> > 
> > For the addition of OPP support to UFSHCD, there are changes required to
> > the OPP framework and devfreq drivers which are also added in this series.
> > 
> > Finally, interconnect support is added to Qcom UFS driver for scaling the
> > interconnect path dynamically. This is required to avoid boot crash in
> > recent SoCs and also to save power during runtime. More information is
> > available in patch 13/13.
> 
> Hi Mani,
> 
> I have picked the OPP related patches from here (apart from DT one)
> and sent them separately in a series, along with few changes from me.
> Also pushed them in my linux-next branch.
> 

Thanks Viresh! For patch 8/15, Kbuild bot has identified one potential null ptr
dereference issue. Could you please fix that in your branch?

You just need to remove the opp dereference in dev_pm_opp_get_freq_indexed()
before the IS_ERR_OR_NULL() check as below:

```
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 66dc0d0cfaed..683e6e61f80b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -208,9 +208,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
  */
 unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
 {
-       struct opp_table *opp_table = opp->opp_table;
-
-       if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
+       if (IS_ERR_OR_NULL(opp) || index >= opp->opp_table->clk_count) {
                pr_err("%s: Invalid parameters\n", __func__);
                return 0;
        }
```

- Mani

> Thanks.
> 
> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
