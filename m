Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8D7D70DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjJYP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjJYPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:25:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E941A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:24:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d922c039so49467165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698247474; x=1698852274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vZjLIO/B5y+VzrWSbSd7j37eEPFfuFTft2CL1N1rIc=;
        b=aigjgpdaJVTvapQSOu+jqJbJnzI34GKjvzP9oMk8sXEZ8MDL8KfhdiYiDyBmgV1s71
         +blV9hGL+7XOV/rNYEmhMYJuk43cs0jXGhxSKVU8C+3n2HlMx1rrNS1RzM1m4axqYWiR
         wt90/pmfERTbLJMgWeQL2S8h79zCVawhdDaLZ4Ggp2H+i1COXBwga/0NKkh419usPvQL
         Gzb+R4fjH66zTVW6e1CY55tcQYKWErnoKfL5FLNge3+/dpmkR4RnQtxwmx5VS7BqgxvH
         AWhWiM7idtgD9DV4NgzN3zOVliA1AyHTrk2ydm4TWpBFZUD+Dy4IzMx4xi4wh0vifTsc
         6HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247474; x=1698852274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vZjLIO/B5y+VzrWSbSd7j37eEPFfuFTft2CL1N1rIc=;
        b=bAA84cbXbnB70Q4mdhXCkjxaeBEguv0Ju0/FUUfP4TVY7eMrP6M5dZM8wuqyCrtD+q
         k6zsX5tzkp0j4Q37J53tHCcIUxvSNwPGchSFlL7oI+MTOiXNn+l8mTo73Ild9p5uhxW/
         9WvDUyy6I3BuCTsngf3T3xsvlIX50glVr/WV4zA/2hqG2qMxgNnXxgAKxJRZG2gzkuCw
         a7XzD347IEp/qjJJtT/h1Iq5FtLonE4xv/s+UCH0KuQaHare7GSi88rlhSRkrihA3yNC
         Rpk/qAuo2ku0tSgrQA8xlurNqv1y6I+YQFZVpBW3kCnm/QJSoc8whxue0S42iQMnfAU5
         BK1Q==
X-Gm-Message-State: AOJu0Yw9J8arj2TD8R/nWWM8mdEXKn0MF/i70dejpzmd90Al7r2Aos1i
        LopvgPXcYuNVgraWaqW2zePsnA==
X-Google-Smtp-Source: AGHT+IGOH8yxX2TQRPmdnmOQ31wmTeOOWm8jyE86Ea52rjoYugP159wJW6o+gx9zasYHQG9Bq0s3Fw==
X-Received: by 2002:a17:903:1112:b0:1c6:117b:7086 with SMTP id n18-20020a170903111200b001c6117b7086mr16982450plh.5.1698247473983;
        Wed, 25 Oct 2023 08:24:33 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b001c59f23a3fesm9354069plb.251.2023.10.25.08.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:24:33 -0700 (PDT)
Date:   Wed, 25 Oct 2023 20:54:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <20231025152431.bhdv772dwbufocck@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTkciw5AwufxQYnB@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-23, 15:47, Stephan Gerhold wrote:
> FWIW I'm hitting this WARNing when trying to set up the parent domain
> setup for CPR->RPMPD(MX) on MSM8916 that I discussed with Uffe recently
> [1]. I know, me and all my weird OPP setups. :'D
> 
> Basically, I have cpufreq voting for performance states of the CPR genpd
> (via required-opps). CPR is supposed to have <&rpmpd MSM8916_VDDMX_AO>
> as parent genpd and translates to the parent performance state using the
> "required-opps" in the *CPR* OPP table:
> 
> 	cpr: power-controller@b018000 {
> 		compatible = "qcom,msm8916-cpr", "qcom,cpr";
> 		reg = <0x0b018000 0x1000>;
> 		/* ... */
> 		#power-domain-cells = <0>;
> 		operating-points-v2 = <&cpr_opp_table>;
> 		/* Supposed to be parent domain, not consumer */
> 		power-domains = <&rpmpd MSM8916_VDDMX_AO>;
> 
> 		cpr_opp_table: opp-table {
> 			compatible = "operating-points-v2-qcom-level";
> 
> 			cpr_opp1: opp1 {
> 				opp-level = <1>;
> 				qcom,opp-fuse-level = <1>;
> 				required-opps = <&rpmpd_opp_svs_soc>;
> 			};
> 			cpr_opp2: opp2 {
> 				opp-level = <2>;
> 				qcom,opp-fuse-level = <2>;
> 				required-opps = <&rpmpd_opp_nom>;
> 			};
> 			cpr_opp3: opp3 {
> 				opp-level = <3>;
> 				qcom,opp-fuse-level = <3>;
> 				required-opps = <&rpmpd_opp_super_turbo>;
> 			};
> 		};
> 	};

I have forgotten a bit about this usecase. How exactly does the
configurations work currently for this ? I mean genpd core must be
setting the vote finally for only one of them or something else ?

-- 
viresh
