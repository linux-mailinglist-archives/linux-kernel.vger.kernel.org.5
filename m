Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30BE7FBB25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbjK1NQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345059AbjK1NQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:16:12 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B210D8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:16:18 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so71054071fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177376; x=1701782176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmeGSvtEsOAwFPC0jalyYEqEza/s+5wNIdTIQtIdcwI=;
        b=PcrMzjCG+PCUYDXVVFIQ0EBfkvuPnkCgqM7PfIH72Zl6IKJ+8zWbqv++SsqVRKElru
         8M2w/F6wq+jUlWl0cBGq1W0R5bPuyTfVRH3FdoNbToeS/shpKThFF7f9JqpFFSeJ0FKY
         7jzdtdQvESiXKBsdZ3PWUiT1epKSYX5G/zu7EA3PxWNojw7mvV+dM75L8l25OuCIYmp6
         tnV6iRGAi2MY0klCC7s/gkbD4X0LPDubgeOGNUJNS2e3mJpo9iGmJaHGdq+G0Pn7rzoT
         c3ILKFSw9ZD5zdNg1WglU2Wv2d+1IYXdRyDwrHQOnAGAW3QJNo3KGgBft8aodfGFIgOw
         MNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177376; x=1701782176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmeGSvtEsOAwFPC0jalyYEqEza/s+5wNIdTIQtIdcwI=;
        b=TZy8Bpav+eaDoY5KxLdatVaE4vLdPrFryzoAOoou9GM1R8atJgBxaYkFwq9nNycRrC
         6wQr3MkoU7BnUYTQO0/eJwsLezx0ZcPsqKvUuYRH/i3iypstyNdCfZaWrNa0jNOudJZe
         YG3nIH/jQpe9LEugNs8VH45rK8JAO6O+2NO71AcMd1iLBOgS6WEaq2E6W3lqEkgK/19c
         pQbjl8Vbi7oGw44Hlh9o4PUolgmEKzHfFyRJ7LLJHZNkQ9xoZPt6PMgdXGzc/B4jFqRX
         YCP3sV6EtKYfCkEMqH5tewL/1N2aUNFLJsRJQ8dyfR3pustcs7JrkIxg5Y6fiYXZ7rQP
         5uRQ==
X-Gm-Message-State: AOJu0Yw3fMnH7FXypAFDk4Wh0aJPb0z9qGhkiK24PTvK37nkdkKd2yoV
        iab3K307lJRDMJ3GauwYWZ5Cpw==
X-Google-Smtp-Source: AGHT+IFskJyn7Zq5NG/6PRdOGtYuywm3exL/CEYWZRl+u7wYVqyx+UY7EtVtNQLM/KOV4FpstpD10A==
X-Received: by 2002:a2e:958e:0:b0:2c9:b9f8:c51e with SMTP id w14-20020a2e958e000000b002c9b9f8c51emr194960ljh.22.1701177376551;
        Tue, 28 Nov 2023 05:16:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:16:16 -0800 (PST)
Message-ID: <0ab17fbe-1247-4f79-9a48-50cb185154ee@linaro.org>
Date:   Tue, 28 Nov 2023 15:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: qrb2210-rb1: Set up HDMI
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
 <20231125-topic-rb1_feat-v2-10-979b28f35e4a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-10-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add the required nodes to support display output via the HDMI port.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

