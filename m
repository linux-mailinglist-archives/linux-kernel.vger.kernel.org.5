Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF27DE769
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbjKAV00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbjKAV0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:26:21 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B537511D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:26:15 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a84204e7aeso3845667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698873975; x=1699478775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dM+LROLHmfkfBpSjaW1PZaGn9FpCSaF42cM5WqtKLcg=;
        b=zKOe3QtqKy97r7XIo9YXDIoPsTtLkRg9ZoRf9e9UJB0h3FxNFBDQE2lu2D3ZcFBrv5
         oUBYc7Bk0hFee1Y3rXeeil+8qdWFmOzyOv0Oc7CzkMcKAiqVqjKWzeeLdKg22+KoqurW
         NoAijegqGCLDamykt/PnMtunCFBMVzIZH47f1T8N/Hpl36S9y5DBe4BBBMdtjBXi9Enz
         VPK82C7IdiOc6p7CR9SHWyvOEfj4z4VejlzGVTaT4kC8n5YI9OVAEuXDC8JIi6omUB/I
         oWgaN9t35P3DVwxCmCletC9tuDaYmzdw4EQEkpEK6eXx5+tgIU8RlUzk2oibNuO2PIgm
         K1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698873975; x=1699478775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dM+LROLHmfkfBpSjaW1PZaGn9FpCSaF42cM5WqtKLcg=;
        b=BtyEje/GJwmctWsUSBUdjn7N4QoJNYtzS14nbrWAftnu6ZX1MVaJH3lOfHA0oQPG/8
         bk7TiDaL6zjFq1y1GeSvjW9vStbifsiFgJi86gmlSKCU1R9Z8rtW0ZOyS3+WLsgW4/Ty
         NuJwDHk6swPHBgb0wVFB/+qFApB25YUTYn/tdRY9SH8lTOmycMbRJcSL/LQbn1aH4OFB
         z4vRJclGo/fXcPAobVBMivPtu5qba3xHiFRp92M7eNJyox6yz0pNyKtsnbyBzO08msGE
         4tYJIdOCgINr2xS7k/35/5Rhcqrdfw9ygE4zPtYqUIsVyj8YNXNXfTCTLv0sbLwrSCy2
         rF+A==
X-Gm-Message-State: AOJu0YyqXzQ64tVGjaUkCHSvsqJnbFU5lMC2YnfyR/ZrQ75BqFapXm2W
        Dtol7JdR2XZuo+Fb59Hu6zENrLtzxHl0ATF9vjJSRw==
X-Google-Smtp-Source: AGHT+IHCuEtVdpcr5cRUi6mQUFHDfZfg/vkcqJjTOAGyHJ1KQcm7224b4vSdHNYWO23AYt8ggbFXP3aPDO5syxbQ3lU=
X-Received: by 2002:a81:c404:0:b0:5a7:bc0e:193e with SMTP id
 j4-20020a81c404000000b005a7bc0e193emr17704074ywi.18.1698873974900; Wed, 01
 Nov 2023 14:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org> <20231101-gdsc-hwctrl-v3-1-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-1-0740ae6b2b04@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Nov 2023 23:26:04 +0200
Message-ID: <CAA8EJpobBJfmztkLoQBmUAbUR16HY0sNZpnA+ZTSmn5VvRWauA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 1/5] PM: domains: Allow devices attached to
 genpd to be managed by HW
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 at 11:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Some power-domains may be capable of relying on the HW to control the power
> for a device that's hooked up to it. Typically, for these kinds of
> configurations the device doesn't really need to be attached to a PM domain
> (genpd), from Linux point of view. However, in some cases the behaviour of
> the power-domain and its device can be changed in runtime.
>
> To allow a consumer driver to change the behaviour of the PM domain for its
> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> which the genpd provider should implement if it can support switching
> between HW controlled mode and SW controlled mode. Similarly, add the
> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> genpd provider can also implement for reading back the mode from the
> hardware.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
