Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8F751847
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjGMFnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGMFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:43:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E61993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:43:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6689430d803so180045b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689226986; x=1691818986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htTCMJvv8elHIEVT998xI0pGLMx8CVO3oMV4YmxuhY0=;
        b=SEyXB3/hRRGbfVl/zdvIJiSrFPmvn8ypW7hac0xZfSvWaaLJ8xYimvW14dIPVDyysZ
         lj4smglBwR7ntaCvPJEquB1axwVgKlXXKFq4faybegh7Ab2Oj8zLuo61ILmmo8YpbQEl
         5uCHf2Sw/KL8yxbhOGnL5gOkEs69x9U4K4bMB0AZGLPyv1O0/j0sy6IsaI9TYojWiUqU
         N3urALgEwdOse5lPN872rJQFKzcXvfmjMLya2cJCEGkLkvZ0pIM7MN35zhvupZSz4L8L
         SlXmm/qOJpZbdsgENLXdTvWmprdMK6xX3+AxXjschJ0/y/1bu3+sJCV3H+EMqPoESndi
         /Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689226986; x=1691818986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htTCMJvv8elHIEVT998xI0pGLMx8CVO3oMV4YmxuhY0=;
        b=BESAlDGJSmnbyGJLhUQxhEX/cXZPgviNeJ90vsUZrdOtUO2WyNFi/aTfnskBG+FCqf
         xiV5agTPfg7xqmqmdQo7Ze4KaDonAwnOewyI//WR7dB0qGjYsxvGZVolUsS/KsWdygcj
         XHGjeYGKvEKDcITjBFsfO/7YhIy0eoZOKCpzmHi15ZUkWUVKismn3LCYK48gbb/BOttW
         xjxs0lzEHGPHuVUpdw5bP/Pd8OX5fyLCuVnlmM/Qqp4IGpCR6YUZl4ff+YvsvLhu4MVJ
         I6wfkoeMFzEHwOWELbfbitLyVKI37HHm+NHl5YM4yzHwno+a5IxqInQa4npIm32IAOY9
         3X7g==
X-Gm-Message-State: ABy/qLbXQ4ytQAsOpQN+6r2Evp9dHQZemj4JH72MF638LLI8W8L57PMH
        fGSaXp/8AtyKVedthqETwh0YppwfM/iCuC4YW+o=
X-Google-Smtp-Source: APBJJlGa1W2dYC+J3tKwswTp3gEhz2001aF3iHAajU/C02P+sRaVF0TFBw0Ue1gbNhJQcu2UtLqtwQ==
X-Received: by 2002:a05:6a20:6d96:b0:130:d596:61bf with SMTP id gl22-20020a056a206d9600b00130d59661bfmr126783pzb.62.1689226985662;
        Wed, 12 Jul 2023 22:43:05 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b001b895336435sm4969787plx.21.2023.07.12.22.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:43:05 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:13:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20230713054302.tu6fgd3meb5krsx5@vireshk-i7>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
 <20230712163406.GG102757@thinkpad>
 <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
 <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
 <20230713050550.GB3047@thinkpad>
 <20230713051235.ob5z3li3lz52xtzm@vireshk-i7>
 <20230713052843.GE3047@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713052843.GE3047@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, sorry about missing one point first. I thought we are adding the
clk config callback (which neglects 0 frequencies) to a Qcom only
driver and so was okay-ish with that. But now that I realize that this
is a generic driver instead (my mistake here), I wonder if it is the
right thing to do anymore.

On 13-07-23, 10:58, Manivannan Sadhasivam wrote:
> On Thu, Jul 13, 2023 at 10:42:35AM +0530, Viresh Kumar wrote:
> > On 13-07-23, 10:35, Manivannan Sadhasivam wrote:
> > > We can settle with this custom callback for now. If there are drivers in the
> > > future trying to do the same (skipping 0 freq) then we can generalize.
> > 
> > Just for completeness, there isn't much to generalize here apart from
> > changing the DT order of clocks. Isn't it ?
> > 
> 
> Even with changing the order, driver has to know the "interesting" clocks
> beforehand. But that varies between platforms (this is a generic driver for
> ufshc platforms).
> 
> And I do not know if clocks have any dependency between them, atleast not in
> Qcom platforms. But not sure about others.

Maybe this requires some sort of callback, per-platform, which gets
you these details or the struct dev_pm_opp_config itself (so platforms
can choose the callback too, in case order is important).

> > The change require for the OPP core makes sense, I will probably just
> > push it anyway.

I tried to look at this code and I think it is doing the right thing
currently, i.e. it matches clk-count with the number of frequencies in
opp-hz, which should turn out to be the same in your case. So nothing
to change here I guess.

-- 
viresh
