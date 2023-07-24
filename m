Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C475ECCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGXHxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGXHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:52:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6C91A5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:52:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb775625e2so12735285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690185172; x=1690789972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VhedmatU6HoIII2qqg2OWSwifXoBo+6lC39h5T5OiE=;
        b=mUo9VVHeJqvv5/13oniv8dSMGS0TwRRoZ2KGC3abbvQcQgCyHE0y/I3BncT8UWegAB
         QWrfEcCgoxQLZ4QmMwWnZiAQy0jAF5vsrBxLwNgwv6FZfXOkT17iQMP7SuGCEOZ68J9C
         hq5KnNtEkUFKZCEe8ti4FuHzKHW51XerefYzR4o6jijCVkNgf0HqWpQVVzWZjaKYNzyE
         i/QLtR0woZdJ9OGfx+IhCvptaH499B2V5DfjzxHCTIqDniyB/JJDYGzqhrWFqwgu5i0q
         XkxY6J+FInh4hQLedUHDckonZq6L0xz/BD204qrHCgkZG/kUh82WK6hEohn+CZjSjVLr
         Tbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185172; x=1690789972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VhedmatU6HoIII2qqg2OWSwifXoBo+6lC39h5T5OiE=;
        b=ChRik4P+nKmWEJvWGe58s/t6Sv225SyTlhWezyXE0vVXupLNRpHm/RzcAOv1ZVcRVX
         7cAYde8DL+ZkkwM6QBkuMYhtEcw8aEM6XoBLgxS0pMMf0gF+xrqlvzzV3JjM+5PlAc46
         rMoAolXWnaW/8/DIDEp9m13jrhLCjQ1KdT2k7K5oS5Mi53JudQxQvjy1f8W+2MyqrCfA
         e5XEA6uRfxVmV0s7q4bop0C2PjudAK0ILeS1aG8kWVfEC+MfCWOkk2kBSc7UE27CUXy+
         6kvRVFitkNdreocsVdW3GYqGskzsrd7gX37g2tAcEPUcY5TwKNNu9+PhSyizXQGx5g4V
         Sk+A==
X-Gm-Message-State: ABy/qLZ0AZgKFxyVoVrCbocQon92hIgJSuOtDiihakQedL3aQ9ZBRLuS
        6L2/MzFP/HVi8xLtlIgR7rWbhg==
X-Google-Smtp-Source: APBJJlELM8SaJzazdwWH5EKfNF7REafvHJx9cgtFozFimBEV2JSUitEcnIudb1cDrOBfCk/uNxR82Q==
X-Received: by 2002:a17:902:f687:b0:1bb:8cb6:3f99 with SMTP id l7-20020a170902f68700b001bb8cb63f99mr6534056plg.14.1690185172533;
        Mon, 24 Jul 2023 00:52:52 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id v6-20020a170902b7c600b001bb7a736b4csm4613001plz.77.2023.07.24.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 00:52:52 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:22:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20230724075250.eezimnx4sum2ffjy@vireshk-i7>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230721094206.dfgnn73kmzzj6rtw@vireshk-i7>
 <20230721115453.GA2536@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721115453.GA2536@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-23, 17:24, Manivannan Sadhasivam wrote:
> On Fri, Jul 21, 2023 at 03:12:06PM +0530, Viresh Kumar wrote:
> > On 20-07-23, 11:10, Manivannan Sadhasivam wrote:
> > > Hi,
> > > 
> > > This series adds OPP (Operating Points) support to UFSHCD driver and
> > > interconnect support to Qcom UFS driver.
> > > 
> > > Motivation behind adding OPP support is to scale both clocks as well as
> > > regulators/performance state dynamically. Currently, UFSHCD just scales
> > > clock frequency during runtime with the help of "freq-table-hz" property
> > > defined in devicetree. With the addition of OPP tables in devicetree (as
> > > done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> > > both clocks and performance state of power domain which helps in power
> > > saving.
> > > 
> > > For the addition of OPP support to UFSHCD, there are changes required to
> > > the OPP framework and devfreq drivers which are also added in this series.
> > > 
> > > Finally, interconnect support is added to Qcom UFS driver for scaling the
> > > interconnect path dynamically. This is required to avoid boot crash in
> > > recent SoCs and also to save power during runtime. More information is
> > > available in patch 13/13.
> > 
> > Hi Mani,
> > 
> > I have picked the OPP related patches from here (apart from DT one)
> > and sent them separately in a series, along with few changes from me.
> > Also pushed them in my linux-next branch.
> > 
> 
> Thanks Viresh! For patch 8/15, Kbuild bot has identified one potential null ptr
> dereference issue. Could you please fix that in your branch?
> 
> You just need to remove the opp dereference in dev_pm_opp_get_freq_indexed()
> before the IS_ERR_OR_NULL() check as below:
> 
> ```
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 66dc0d0cfaed..683e6e61f80b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -208,9 +208,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>   */
>  unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
>  {
> -       struct opp_table *opp_table = opp->opp_table;
> -
> -       if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
> +       if (IS_ERR_OR_NULL(opp) || index >= opp->opp_table->clk_count) {
>                 pr_err("%s: Invalid parameters\n", __func__);
>                 return 0;
>         }

Fixed.

-- 
viresh
