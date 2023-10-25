Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0427D661E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjJYJCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJYJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:02:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE5B3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:02:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5427135b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224552; x=1698829352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4n2kked+3bfxJ6EXIMUDeHZq/0tPr9IzhDqluMrojuQ=;
        b=KvuUQsvTvbCp/sqt/uGVb68pWrXfdG2LG6Lp0xNY4EDpAAPdsDMwoofTCbo426rgjK
         x3Q4sn2j7GNRs0/3YQdxwNtWZmutmLv1aqNrTjsVTo/SsUawRUQMq7Da1P+RQNuUNYqw
         ONwxi9Zjc/XRuwBYDzMisgeNijK14lrhHKOfJHNjbOWYCTfdeeVrPBPWjah5AUuecsGW
         xwBe2zub4asg4/aoEZQ8zgsvMNLw0E3lAmEZiBQAxdDAP/E8mKGCg98XCtRFanOP42I1
         FOgmBcn3cv4DixoKxPTfnoJmxMZZ6WjSOSzv+3TFdctTv0qgo4HFjgL68qB+Q4pd5nw8
         EI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224552; x=1698829352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n2kked+3bfxJ6EXIMUDeHZq/0tPr9IzhDqluMrojuQ=;
        b=ZmmWAoNshb78KyRkCTSUx8oGd/+a3f1tWU+rAQIOX5kOk4bkcPfEalKQB1alSAWbPe
         82FMT+ZkTYblECQ3lL0o3pzLW78YR4Z3xz0IDwdyxTeIoRErOH/V2uWUnOTFcvBmCfOi
         VzXw4kNPFgYtAYusEa+sJgEpGpyzvJJt6d64VRoU/H5vaxURHay637rhRdF/7yOGp15C
         bQkJm3meh1kJveSiJxE3yzgVe6PzHtcTork0FBKhtXZ8jS1Va/CnFxKttChKviNApivi
         XW5RkmanDBZBkgMvUCMgqf6jo8rtHz2URkcYYAwnwLjq4oukMEIFh+YI5kgfsY+z7ZDN
         ezHQ==
X-Gm-Message-State: AOJu0Yy1+Ase5f/+1pOAq5DIEDXSWTiSNCuee6mo1Y9M+ugFmcpiRkZh
        Eg1bWpQ1Q8t/69fm+q9AYx1j2w==
X-Google-Smtp-Source: AGHT+IHlvO6WHkTUoNPCtH3XnUWsHWlqDlLhIZ6DN84y+xqxEAusCOS4G6ZLCtqTKO218dxEh9Ws/g==
X-Received: by 2002:a05:6a20:12c5:b0:17b:40:ccd6 with SMTP id v5-20020a056a2012c500b0017b0040ccd6mr5787438pzg.2.1698224551695;
        Wed, 25 Oct 2023 02:02:31 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b00688c733fe92sm8886602pfo.215.2023.10.25.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:02:31 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:32:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: cpufreq: qcom-hw: document SM8650
 CPUFREQ Hardware
Message-ID: <20231025090229.hkuir4vubmpic7me@vireshk-i7>
References: <20231025-topic-sm8650-upstream-bindings-cpufreq-v2-1-340e1c583f53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-cpufreq-v2-1-340e1c583f53@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-23, 10:27, Neil Armstrong wrote:
> Document the CPUFREQ Hardware on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
> Changes in v2:
> - Fixed typo in subject
> - Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 0177d1ef0bf9..56fc71d6a081 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -43,6 +43,7 @@ properties:
>                - qcom,sm8350-cpufreq-epss
>                - qcom,sm8450-cpufreq-epss
>                - qcom,sm8550-cpufreq-epss
> +              - qcom,sm8650-cpufreq-epss
>            - const: qcom,cpufreq-epss
>  
>    reg:

Applied. Thanks.

-- 
viresh
