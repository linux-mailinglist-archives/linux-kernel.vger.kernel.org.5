Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD778EC13
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbjHaLcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjHaLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:32:32 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D266CE4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:32:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso471394276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693481548; x=1694086348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y4Cq/IHdVsRZWccJ+nEpibfReLfGO5CUKhv7KNNEEs=;
        b=r22IQQCEFtQcbJRHBCq5qEcauLLGwMO++3wX21yyE8QrruYLJ2o5hdnH6eYCbDaH6J
         Lm7/PFLFfckGz+upSVnz3h6l9DwrWIEMMO2rLLzZU1vjBNJ2HF9nII3t0JvFTHsY3bEI
         yXXS07bojLRSxMlPSKr7E/zxvwJ8cRKB2ODJ5wEf+ntLb90dnz3zvs3YqZdQ1Aq6xcNc
         72LTT3v1RXqZQZIZf0jUUXqrrQkqggN7TBssKGpzvGYDc2iipFnEYxCxohNs39ONx/Mf
         ORL9L58hFjfyPS6dEYKjdyxQBBWnxhAL+tlBP1LAaerW4GOxyNniBLv44khEOKROGj5Z
         9Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481548; x=1694086348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y4Cq/IHdVsRZWccJ+nEpibfReLfGO5CUKhv7KNNEEs=;
        b=TWh+3jjwVn5Woi/PKN8hs/A6qDWDoaTV9Z+Ns3Wdcl0mPUC6Kcp5IJPYmqimTTHNso
         pGDcxFQ7TXqv9xMHwjpa1oB2doMhqexA0TSJsnrSHzScT6NPQW6x64Iqj8tOr/JD7H0M
         Advh30boT7nnBZhkXW2Z5KI2W3XJ5Vt38m4sdEqHHzv29qcCu9W8UFEM/936effKjFNB
         wFOpmAZkgOf8v+RFHfWOxLzzL6+dVhfq97lnXI6Sm4QzisOClfTmaKxlO+JDbC4TkWcn
         JwJ/on5ZXBh03cdhdL7MFtrc2mKgAbvaq+33vKCGSnUDOulVU/cjHipgVukpFy4t1LQN
         T/6Q==
X-Gm-Message-State: AOJu0YxzIMXPOzThBa8hrmOuObSnXYlXefIztnI5iKnWQ9YO6ONoIlvI
        ao5bWisEc+ym08wNRmnh+92lvY2iQs9MICGUhYCYaQ==
X-Google-Smtp-Source: AGHT+IGmZkwOv9/T3myqmvLQt+2FQYaNTQx2vhwnosm5z0c5JuszozfA/F3Oh1I0GuscrvpOIc2G/zJJoa5FiM3GqoA=
X-Received: by 2002:a25:b8b:0:b0:c73:e6b5:c452 with SMTP id
 133-20020a250b8b000000b00c73e6b5c452mr4431574ybl.2.1693481548627; Thu, 31 Aug
 2023 04:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
In-Reply-To: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 14:32:17 +0300
Message-ID: <CAA8EJprupMJY7xKq4qO_+vBsrtBDvEPr+HEZqc2S+o0B1tQsWg@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-msm8996: Remove RPM bus clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 12:39, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> The GCC driver contains clocks that are owned (meaning configured and
> scaled) by the RPM core.
>
> Remove them from Linux to stop interjecting the RPM's logic.
>
> Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Evolution of:
> https://lore.kernel.org/linux-arm-msm/20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org/
> ---
>  drivers/clk/qcom/gcc-msm8996.c | 237 +----------------------------------------
>  1 file changed, 5 insertions(+), 232 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
