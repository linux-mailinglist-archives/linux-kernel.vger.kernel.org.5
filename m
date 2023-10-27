Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D37D8E27
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJ0FaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0FaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:30:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8511AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:30:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b8a88038b4so2151627a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698384603; x=1698989403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDCChaj1gissqjEBEAMXe/0tc+K9t0+uAP8/ShNGqvA=;
        b=LNADWBZAnh8NUreCJD4I3fKYf5PCkPmAYq4KJbAXktmFrV16Xe+gaZJc7z+MOenP19
         ydXLRRg4bS7Xar3tZ5Zgv728l50zfg7wf4VITMa8oz9+U5yMRj8XxSysI4rhsf8zmoRH
         nOMT5ketnzbVFbd33vGWI6UGGC8E96WgZewF3N6Sicf19QycYvHQElk9fZpPtIIgUHok
         ZDiQFsyU9lbm7xbvIYNlPveyd+FzxpgAxAzXGZenE/RpFLNNdbm6Z7VhacumYmvP8AiR
         KAPrnJWD0Nc0X+Fmzkw6MDEify8v8BhRUtsNZZcVxyc+R6WRRf6JvmZXy18WCi905bPj
         mTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698384603; x=1698989403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDCChaj1gissqjEBEAMXe/0tc+K9t0+uAP8/ShNGqvA=;
        b=TJdFUkVcKd1MZBeVjWiQGCfDYogsRDu20A5Gwkm/qmkaqqjCWJ4u5IT+WpNWSdarog
         UhjzLWpQwKv+tkHvXeCckdPRh8OM4wWrimeiSBBHgYvARzb9nA/MQWziscu+Li92dYwL
         It2+bRsGk+NVZfeUWIxcyY1HXQ8V+K/DPFIQxynMtYxw6BNXXWMxdaBRdzfS3z3jWsmN
         Tdjijn6MeEngB0O0HcJ0bWU3OD/9+3XXx5LeL0zHjKEZ7Pa9fiH7R/dTnpSxTztvNq6s
         sKOIpQaiAqKW/0eC9HZX7IgXrAaI0EkYG4JCil4Rpf8amN8n2RlE+Ivje4hM3PAGsiLW
         ywgg==
X-Gm-Message-State: AOJu0YyXt8uucRt8r+q/POdy6HE/REZkGQWYHulX6Uk8Xhse/b0GwwWg
        Rv6GQxJvEoEXBJ5gnePDQNlIaw==
X-Google-Smtp-Source: AGHT+IEDdiUnBtNGv3NqKyoW3hwNthvCCMtRZ9osKz/+i+r83pEqPvuYCWs+QgwVReFiGJCBLU3PzA==
X-Received: by 2002:a17:90b:3a90:b0:277:5cd5:6f80 with SMTP id om16-20020a17090b3a9000b002775cd56f80mr5789495pjb.16.1698384603045;
        Thu, 26 Oct 2023 22:30:03 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id so3-20020a17090b1f8300b0027d0a60b9c9sm2554765pjb.28.2023.10.26.22.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 22:30:02 -0700 (PDT)
Date:   Fri, 27 Oct 2023 11:00:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-hw: document SM8560 CPUFREQ
 Hardware
Message-ID: <20231027053000.hitqlo4a6lusdgzw@vireshk-i7>
References: <20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-23, 09:25, Neil Armstrong wrote:
> Document the CPUFREQ Hardware on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
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
