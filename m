Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD79E7517D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjGMFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjGMFGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:06:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA392114
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:06:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666ed230c81so362172b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689224769; x=1691816769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Qk0spvjqelsgWYpeQ4kuozBgLhUKaEE8K+ZAEOKFHI=;
        b=nc5qfVE+I1vS9zuVMeqaj6ZZnHW/m6LQosS9BCYtyi9vS/ZI/mRtPmNJV06jbclv2T
         6OEUpPk3DNqV/q6zaAXs2IeBBeMqS4qFsyO30n401Y2JRIodmbGZQhN+t7QVwS9vi3R2
         m+spgpGa9SDjPkuUcRuxdEovZwlp6419r3eKqI8A6a3XM9zYK3fyghxv1hYgfHAnBaw0
         WjHgFUAaO8qxBknEjsSNIGUeD4mH4gdz9t++pAvOgrLkRo9dxu96yrGGa1zz0ySN0Z/l
         Esaq8AgM+y+DwlwwwLYyn33FMVDEKefidr9ReAiKKORVRlv2YjXTqEUMgpDIHSPoEcGc
         lTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224769; x=1691816769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qk0spvjqelsgWYpeQ4kuozBgLhUKaEE8K+ZAEOKFHI=;
        b=YS8KA2g7irsA+yI8M8N8gESRlEZ78d3pLB/3K5etbObi0G7FkabHTHu5TPq2crAOJW
         q+ELdJLXuEeBDANx43VRjHywG6SuGY0x3Op2A68QVeeMta2FWnPN81CJCcPvGxpk4oTD
         6tvMsYsmW5jAbUaRYsF2es3lpP/TtdNu8O+a8YLvmh78kp+s78PHFPk0jcOgzm5Fe5Ws
         hL1TwjlFs9XJ0387PYi6kC5E46m+z6VqEYGupIKScdG9WNQMm+bZ10sUBJJljlCKJFAu
         yqAHmhN3p2GS67HpZLBFim+XMQTES8I7XX+RvbdQC4xzWebC2L9jbz0mlkTVRHCX1MIR
         oSdg==
X-Gm-Message-State: ABy/qLa9cVuUB5tNE7X8778JUltP3/ya0VHtRUWLemwElSG34KJGwN6H
        CMa2Z/eZ5uhWjiwrZWNZH1lZ
X-Google-Smtp-Source: APBJJlF/hqFCRZdE64GpVVbs24NyzUFsLplRA/w8LLjXD9OzLL/2jfLMegk0qSbqFNrpgcwWBLzCQQ==
X-Received: by 2002:a05:6a00:2e94:b0:654:4a24:d787 with SMTP id fd20-20020a056a002e9400b006544a24d787mr977416pfb.12.1689224768761;
        Wed, 12 Jul 2023 22:06:08 -0700 (PDT)
Received: from thinkpad ([117.207.27.112])
        by smtp.gmail.com with ESMTPSA id h25-20020a62b419000000b0063f00898245sm4589847pfn.146.2023.07.12.22.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:06:08 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:35:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Message-ID: <20230713050550.GB3047@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
 <20230712163406.GG102757@thinkpad>
 <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
 <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:39:18AM +0530, Viresh Kumar wrote:
> On 12-07-23, 19:48, Dmitry Baryshkov wrote:
> > On Wed, 12 Jul 2023 at 19:34, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Wed, Jul 12, 2023 at 04:15:12PM +0300, Dmitry Baryshkov wrote:
> > > > On 12/07/2023 13:32, Manivannan Sadhasivam wrote:
> 
> > > > > +static int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
> > > > > +                             struct dev_pm_opp *opp, void *data,
> > > > > +                             bool scaling_down)
> > > > > +{
> > > > > +   struct ufs_hba *hba = dev_get_drvdata(dev);
> > > > > +   struct list_head *head = &hba->clk_list_head;
> > > > > +   struct ufs_clk_info *clki;
> > > > > +   unsigned long freq;
> > > > > +   u8 idx = 0;
> > > > > +   int ret;
> > > > > +
> > > > > +   list_for_each_entry(clki, head, list) {
> > > > > +           if (!IS_ERR_OR_NULL(clki->clk)) {
> > > > > +                   freq = dev_pm_opp_get_freq_indexed(opp, idx++);
> > > > > +
> > > > > +                   /* Do not set rate for clocks having frequency as 0 */
> > > > > +                   if (!freq)
> > > > > +                           continue;
> > > >
> > > > Can we omit these clocks from the opp table? I don't think they serve any
> > > > purpose.
> > > >
> > >
> > > No, we cannot. OPP requires the clocks and opp-hz to be of same length.
> 
> I am okay with having a patch for the OPP core to modify this
> behavior, as I told privately earlier.
> 
> > > And we
> > > cannot omit those clocks as well since linux needs to gate control them.
> > 
> > Hmm, I thought we push the list of "interesting" clocks through
> > config->clock_names.
> 
> Yes, another way to solve this would be keep the interesting clocks in
> the beginning in "clock-names" field and let the platform pass only
> those to the OPP core.
> 
> > >
> > > > Maybe it would even make sense to move this function to drivers/opp then, as
> > > > it will be generic enough.
> > > >
> > >
> > > There is already a generic function available in OPP core. But we cannot use it
> > > as we need to skip setting 0 freq and that's not applicable in OPP core as
> > > discussed with Viresh offline.
> > 
> > Ack.
> 
> I am okay with either of the solutions, it is for you guys to decide
> what works better for your platform.
> 

We can settle with this custom callback for now. If there are drivers in the
future trying to do the same (skipping 0 freq) then we can generalize.

- Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
