Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636A07CF057
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjJSGrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjJSGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:47:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508811B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:46:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso4738685a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697698016; x=1698302816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5ZJsyvfM+Zq9ZLZKJ7GPs5PPw+WA8Q5sgTdxbhgzH0=;
        b=cxFHLl2gYPeArWdD8OdZ4mejp6dc7r3gfj3kn5D0G1algYTxcvkAHOWrjrGPG6ETBx
         J9wxDboo42wHck5krM4EmfLvigMCRwOcAbB4P0piU/sFyylFhkXpz2KpMYP51vcWLj8H
         eDk2lCNmjp6P6zE/yCTWiY6tQfa+b8GFDjVo8jN1qwQZNBCfmoAaNDupYVN8vVQJe/Un
         z3N7vdLp03UAjESWeomWEdaGJQnAFhmQOGiE4NdEvYuSG290mSr+1xFr5U/3AOGaYD0v
         +NYO7o+tCy1MapE75cB8P3o9iaFGcuhwIi50J/KmL8H0RE7BAjd0H96c2M3/ncaInnqg
         0Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698016; x=1698302816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ZJsyvfM+Zq9ZLZKJ7GPs5PPw+WA8Q5sgTdxbhgzH0=;
        b=szMoCcPWt3bcQvMMvEQS8I93hJMmmzqSoCxYyFedausO2Ow4cJR10ESKrhb4K7sIst
         t2wIoiUsm7pU/Xi2xk/G6j+ijocM1Dk4ITvkt0uhGdIPbhdvBR2jdcCn9QJajSweSLcA
         ioN728vs6l/iOn9JLFYVxxQw/YdeUR41QCnnB8p+aFNIJSkZHI3CUUa2kT5XDaV/rgJm
         lW1BZ63Ask42sbiH0duOnRX+78A6rMtd4AJ34mqxs2N/1WTTHU2uXg2TkKY/+pnEDxPN
         KNU5L03O8UVSOWvo8+7+8ql2LzI5+1lnZsd6slvYn4UeXG+QGJ6tHSb+9oe15TNSDbAU
         qkQw==
X-Gm-Message-State: AOJu0YyOzZdvXYpbf5K/QYYWiFE5c+ZmR+0HGoN0nGSSGbxbD0bUL72x
        UpaZLEF9OMuutOz92+pQR33V3Q==
X-Google-Smtp-Source: AGHT+IFth7U4xLVcr3gM1uaQR6mB4u9ZWR6FF+K5XnVT1FArumGmO27ywj8s+aGrhbgtYNodIWf60A==
X-Received: by 2002:a05:6a21:7741:b0:13a:59b1:c884 with SMTP id bc1-20020a056a21774100b0013a59b1c884mr1325731pzc.40.1697698016581;
        Wed, 18 Oct 2023 23:46:56 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d68200b001c5f77e23a8sm1071860ply.73.2023.10.18.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:46:56 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:16:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] cpufreq: qcom-nvmem: add support for ipq806x
Message-ID: <20231019064653.feqpjdmblm7mmsug@vireshk-i7>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013173854.7399-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-23, 19:38, Christian Marangi wrote:
> The first patch of this series was split to a separate series as it
> doesn't depend on [1] and can be applied right away,
> [1] introduced some breaking change to function that ipq806x, ipq807x
> patch was dropped to permit an easier rebase and merge of both.
> 
> This small series adds support for ipq806x qcom-cpufreq-nvmem driver.
> Special function are required to make use of the opp-supported-hw
> binding by hardcoding custom bits based on the qcom SoC ID.
> 
> The qcom-cpufreq-nvmem driver had recent changes to also improve
> support for apq8064. Because of this, this series depends on a
> just merged series.
> 
> Depends on [1].
> 
> [1] https://lore.kernel.org/linux-pm/20231010063235.rj2ehxugtjr5x2xr@vireshk-i7/T/#t
> 
> Christian Marangi (4):
>   dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
>   dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt
>     property

Applied above two. Thanks.

>   cpufreq: qcom-nvmem: add support for IPQ8064

This doesn't apply/build anymore.

>   ARM: dts: qcom: ipq8064: Add CPU OPP table

-- 
viresh
