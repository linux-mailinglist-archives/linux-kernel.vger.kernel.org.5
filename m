Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7275B516
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGTQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGTQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:57:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2A119
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:57:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecb21f86so872160b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689872268; x=1690477068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RurPK5XlwVd1iZs5pxMs+mAdNFFXdwkpgha3mP0teo=;
        b=ZK+11CFXcgQp0bhAJ4DPBSy3hNI+ni2d97fD+tiLZlfK+8kC7YXUzs7DJRJOXkhSZp
         4UyRPv5+kfz7Ac/vKdba21CC+S8GweNz+UfrXKDpWFB26x7cgt1UHD+IgHSL4eB47q8R
         yHOAP3wEWpavDQuY/GqSg/FZsR5TDutY6iJrcQPjYxXTYM3gNHUkuN9Tdow1wBQRfye2
         OZrQFJVfs+F4PtqbzduVlnA2ar7SH700LWgivpVjbsMnnJmNtIMd/jhEcUtqWLsvu7Z4
         QpK8OLXjHHeheASlUnvBKaOmGWWACJ3Dil7F3DmuNTENKsuLDkZDC7FMENAGHF2Tui3M
         jeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689872268; x=1690477068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RurPK5XlwVd1iZs5pxMs+mAdNFFXdwkpgha3mP0teo=;
        b=J5Eme2thMcm6GtavhHMfkseF2bVlfUcli8Dphn0yyNej6DGU/1HX+Z5ko3+C9SS2EP
         /G48PHwI8GfIqbxUTSe4LzUFXRggufz+11cKbswnBJhqkB2BhCCab9CNHIvyDGgcw9b3
         aVkRRqHbDaM172rQI8PzhNV7OVpjhUS+yRzcLXesWZNTU6aH1VdwTT0+Y9U9Jb9Wxb4t
         o52WrzvnGocY//XWErfd97Q2J67WDeRW5UUP99Pvy9vlYkcWIWQyjNSEBZXOdh81GY7q
         l1vGc0qxZQRVPr+LC20s83a6VVfLep+TBV5+RsjQiHePXIUeoIZLjZaSDPqLAP2iPL9q
         kqyQ==
X-Gm-Message-State: ABy/qLa318HwPfJCjZ3+9ed56RzRk/PdWkjPDq6QNttKmrPplsEux+dK
        GfwPCyIIMW1LJOEibEIM0PSz
X-Google-Smtp-Source: APBJJlHZSFRdLSBkfKlGc/lyxUmjcdtNRmstzn6Q7EmPMSzVNBtbZu5/OMJD7BMmL7VVTx2A8GmGuw==
X-Received: by 2002:a05:6a00:21d5:b0:686:2fde:4da with SMTP id t21-20020a056a0021d500b006862fde04damr3245948pfj.15.1689872268250;
        Thu, 20 Jul 2023 09:57:48 -0700 (PDT)
Received: from thinkpad ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id y8-20020a62b508000000b00663b712bfbdsm1431362pfe.57.2023.07.20.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:57:47 -0700 (PDT)
Date:   Thu, 20 Jul 2023 22:27:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] UFS: Add OPP and interconnect support
Message-ID: <20230720165737.GG48270@thinkpad>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <e46f077f-4602-1882-bc14-e8df2a216773@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e46f077f-4602-1882-bc14-e8df2a216773@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:44:38AM -0700, Bart Van Assche wrote:
> On 7/19/23 22:40, Manivannan Sadhasivam wrote:
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
> How much power can OPP save? I'm asking this since I'm wondering whether
> the power saved by OPP outweighs the complexity added by this patch series.
> 

I haven't had a chance to do proper power measurements with this series due to
lack of access to tools. But it won't be optimal to run the clocks at high/low
frequencies without changing the associated regulator/power domain state.

Atleast on Qcom platforms, the clock frequencies are tied to RPMh (power
management entity) performance states for the peripherals. So both have to go
hand in hand. Till now, only UFS among the other peripherals is not doing it
right and hence this series.

- Mani

> Thanks,
> 
> Bart.

-- 
மணிவண்ணன் சதாசிவம்
