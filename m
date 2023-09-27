Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5137B02B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjI0LYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjI0LYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:24:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA599FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:24:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5ff5f858dso52860915ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695813849; x=1696418649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gP1E3ybnFCNnfUSyv6qObP/eYdp0ZyA/1w1KLw4Ai0s=;
        b=g994XAxScpCtXbkNPu7tVi1r4u2zDiMmriuk5wp3c41cSFbOh5/hCcPXhR+A6K1SWo
         ac7lJxC40C60Xc17LQrPR1fc+p5eqyDdSdnp3+NsBAkgDajQGKbwNfYaXPpUfhVL16rJ
         RXM5w16shZUea0b9iAxTKqfRgXaeRbOmrVVM1yXuILMv8CUGAoWyvSc6M1ZCb5ie06/P
         bLUVpUEai/Qa2mC2AxldFnTfAcaBbJJSDQKfLXT0VUVyxhoyh3q8/iG/OI6RSVcpLVUS
         qRkPHRPYOazH1luM7MLO6v1sTcOqNGqBIICyI2ip8EClMzSwRFG/K8hGM6Y301VT66nn
         ap0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813849; x=1696418649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP1E3ybnFCNnfUSyv6qObP/eYdp0ZyA/1w1KLw4Ai0s=;
        b=bexju7fntghPjYAFwFXg3lffdMmOqGaxhKjJxZK4PbngxjX5k/mSy//6UaFtYUM4zo
         4KM2CDDoCQ6/RHpeZruw37KkQampLVMGJYqsI08ZmILfppB8BMRVJkMlFzhuQYWe49xH
         QogsZhnfs992ycvvM4+TwtjItU5PjtUwNn+TSActLk5j6WlBAvnnyEqIAt0ggUkl5b4C
         TOQNWemBCXP1Jy9iwEeoJBNlesmTOZZQh2gYPPBCm58iFM4Qz3dhXD9mw1YefECXc2N1
         G9oxCgSU3JntHuJ+3ELbJcr1FDEJgzJhR5WinLfW74kXgYOCiiU6gMRX1fkRJpyfHT2E
         tQTg==
X-Gm-Message-State: AOJu0YynBdSEu4KW3PXcyvXtGI0UUumj65rAeOrk06NugN5rmpKBpom7
        OZZZYAjH1CpDxlvDhaeV+d0V+Q==
X-Google-Smtp-Source: AGHT+IGev39zzv4dY6dg+otC4jHEFuclV1L0cE+VDxgx48elDLd1l4JA7PhiLb/3lGC7jEbvJTvjMg==
X-Received: by 2002:a17:902:e844:b0:1c4:2b87:76f0 with SMTP id t4-20020a170902e84400b001c42b8776f0mr1585486plg.47.1695813849268;
        Wed, 27 Sep 2023 04:24:09 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b001bd62419744sm12816123plr.147.2023.09.27.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:24:08 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:54:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 08/10] dt-bindings: cpufreq: qcom-cpufreq-nvmem:
 document IPQ9574
Message-ID: <20230927112406.teqtqq2phg2nrypk@vireshk-i7>
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <e0f54a4b249f24b10d3dc21a0224718e46ebd158.1693996662.git.quic_varada@quicinc.com>
 <2de8953c-f1c5-3c17-5c95-973ef550bc32@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de8953c-f1c5-3c17-5c95-973ef550bc32@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-23, 08:04, Krzysztof Kozlowski wrote:
> On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> > Document IPQ9574 compatible for Qcom NVMEM CPUFreq driver.
> > 
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied. Thanks.

-- 
viresh
