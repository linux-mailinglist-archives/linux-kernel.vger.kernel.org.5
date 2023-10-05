Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8B7BAEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjJEWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjJEWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:42:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA5D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:42:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5041cc983f9so1865944e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696545718; x=1697150518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxe0ak/46bJpsp3A6ERBsLYtpfqO5S6jfq8NjVc/4Bc=;
        b=tjDcCAxe/4+hct0QtUFUjD9YdQHh3rMiyDQfTKDdF4waJZVMNBo3756LrjqWvx+Uqu
         YUChMNl5OqsT3s2xQgrEam4BBdAY7udkaWus5AzAw2TzSEJBo3NCpEwDqwkCYLbRLfd8
         fybgncwk6Tj2DZwLIKOqOwCxWhCoOPapIlWQyFXjHUVXxbk2ZxKCPuu1UED/aY6somHg
         yIBJJ4JxSlyvTDU1HSgiaL/NtwBvtmQY2dHlPPSYHo0wIkxLB+Iwgu6HNPtk9woKFm/u
         d4kG1BrLOD4wMzXVVulUtpJGQ2+nIdMkPcKIqJAvmOwH3g3Sf5MgpzPv5y+ZvrwLCfRB
         qFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545718; x=1697150518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxe0ak/46bJpsp3A6ERBsLYtpfqO5S6jfq8NjVc/4Bc=;
        b=aT/SqVF+F0XiDZZTFuDCbWBQnKBzekLktgMdsGj7BwQ2rVpdkpaQ2KASE6Oxtg9xLs
         VMgPdMDVZZ4HM2E6RzpKlywTnoH+LTz21TklEy/ugaYCdQHEPo9ZF9iXtKu75z9pClHt
         uuvhTDNGPTp/cbXXwPTb5ZvfUAxB7sLrZtaLy0BbqEZGSnLpB94BAQhJBI6b2QLgkLsg
         Ki9ofj0aJYDW1bqIIozVug6TEI2zdMK18rTq44oQh77hD7q8QFQGmj3+gCoyEsjIeFB8
         M2fpQEIH8mqYltCRtqXpGNtwU4z2HCjZvDkak9lygLL3HMvHvEHU6V4ov1PANcBWwo2q
         GTjg==
X-Gm-Message-State: AOJu0YxxF9DletxRrz4W8IVBRrfMD3mv5AZZBHk69JqHnOt0tBxU5h77
        K0wHo7FwszYYjV/Y7AwVp+WQ8Q==
X-Google-Smtp-Source: AGHT+IExNB53+dKAaQteMJJ3tL4g6Y2tu2/fzVZjUxh9Ut9cNeMdab+Ao7SyFlG70dLxdVCGxvodhA==
X-Received: by 2002:a05:6512:61c:b0:503:38c1:c848 with SMTP id b28-20020a056512061c00b0050338c1c848mr4902498lfe.50.1696545718603;
        Thu, 05 Oct 2023 15:41:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d24-20020ac25458000000b005009b979e3dsm31121lfn.303.2023.10.05.15.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 15:41:58 -0700 (PDT)
Message-ID: <1ad8c0f9-33cb-4d50-acce-b71c5a06cb71@linaro.org>
Date:   Fri, 6 Oct 2023 01:41:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/dp: Inline dp_display_is_sink_count_zero()
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230906181226.2198441-1-swboyd@chromium.org>
 <20230906181226.2198441-2-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230906181226.2198441-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 21:12, Stephen Boyd wrote:
> This function is basically a one-liner when you ignore the debug
> logging. Just inline the function and drop the log to simplify the code.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

