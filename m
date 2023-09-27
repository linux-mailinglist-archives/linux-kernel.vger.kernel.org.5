Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB87B0290
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjI0LPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjI0LPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:15:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085C192
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:15:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692c70bc440so5836205b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695813349; x=1696418149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ILQTIya7HcBL5OZKx6dzjYAup4yveW1HKg0YsYZucU=;
        b=nSzohTHczpdag7naXoE2adPHh/Xn9NhSJno4hgEJwib6XGti0U5R4lKRj4K4UQvOve
         LxI1ZP7cyshbq5vk81dcylZmz/IBP9dHa9o94q50SPUABCLEcGLcwSayf6Ce4SLbfb3E
         M0xpZ4I5JDMZnvZfFIrZlYlEE6Hqa4TOc4CctbTJBYc8WmhC1hWbePS+bhgz+WNg1afb
         kmTJUd7qZR3yxPV3x6PSsiYBwdRfa4yIy2+tc4dY/eAwjSrfv431UVqnbyS/FXsZurjm
         XpkmC8bS2Ttdok+zTmHyU+TL+ZgZH1C/N7LFrV9zuPRYKZgllzUMCbKM3EkkNOFk8fN/
         8LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813349; x=1696418149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ILQTIya7HcBL5OZKx6dzjYAup4yveW1HKg0YsYZucU=;
        b=RVj5MW9XdgI4Ic1akqgK6r6SxDO1+dwDCDSDZZxFqnDMtpTYmpYv7bN5HamBqoynTr
         xPs5R7CBYArMBmKYZPADs9kVzfeA0bKWPeG6nLs4iaUcItiCkEmulhkNHx+ott+ZATT7
         9CJoYtU+RAHUdrg9qzpJZduHt/yDkTJkuQLjxaUjrI/QSLcHT1jTaAsWfXAvWJzfYPSo
         mRiIlXR9V5/aZU0zIlCEmlYUMW5cz8SLVK9RD6udzSdRB07XFSM7k45FNL4j7wi/7CtY
         Co/dwqWdMZN9Rkc6EjKnxuETceWk6se7hbA/Azwq9E/PSbA21ceha5sWcEt1/Q3uRMOz
         wt6Q==
X-Gm-Message-State: AOJu0YyFnzA+tNwhjtxbEjYYBb5xp6WUG1xXwGQSpl6M5ZTpMeXW6RSg
        a1uXtWNvJu3rL2/mPQQ/ha/h0Q==
X-Google-Smtp-Source: AGHT+IF+OQNFDztWq/9f7H4m3a5CkvfRLNuyr7Z1Y+kYUGAK9CSyS/G0wHhHEiX+Nc+jvptbD3e6ig==
X-Received: by 2002:a05:6a20:a11b:b0:15d:facd:f20c with SMTP id q27-20020a056a20a11b00b0015dfacdf20cmr1779519pzk.41.1695813349251;
        Wed, 27 Sep 2023 04:15:49 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id gk6-20020a17090b118600b00263cca08d95sm3647431pjb.55.2023.09.27.04.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:15:48 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:45:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20230927111546.uyaod34zcjr7npgf@vireshk-i7>
References: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
 <20230731163357.49045-6-manivannan.sadhasivam@linaro.org>
 <04eb9f71-78f0-41f2-96a6-fc759ba296fa@linaro.org>
 <20230912065918.GB6404@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912065918.GB6404@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-23, 12:29, Manivannan Sadhasivam wrote:
> On Mon, Sep 11, 2023 at 04:15:10PM +0300, Dmitry Baryshkov wrote:
> > I'd say, I'm still slightly unhappy about the 0 clock rates here.
> 
> Neither do I. But it is the only viable option I could found.
> 
> > We need only three clocks here: core, core_clk_unipro and optional
> > ice_core_clk. Can we modify ufshcd_parse_operating_points() to pass only
> > these two or three clock names to devm_pm_opp_set_config() ? The OPP core
> > doesn't need to know about all the rest of the clocks.
> > 
> 
> We need to enable/disable all of the clocks, but only need to control the rate
> for these 3 clocks. So we cannot just use 3 clocks.
> 
> If the OPP table has only 3 entries (omitting the gate-only clocks), then we
> need some hack in the driver to match the rates against the clock entries. Doing
> so will result in hardcoding the clock info in the driver which I do not want to
> do.
> 
> If we have something like "opp-hz-names" to relate the rates to clock-names, it
> might do the job. But it needs some input from Viresh.

I have already given an option earlier about this [1]. You can change the order
of clks in the "clock-names" field, so that the first three are the one with
valid frequencies. You shouldn't need much of the hacks after that I guess.

Or maybe I missed something else now, talked about this a long time ago :)

-- 
viresh
[1] https://lore.kernel.org/all/20230713040918.jnf5oqiwymrdnrmq@vireshk-i7/
