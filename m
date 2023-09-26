Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632487AF4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjIZUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbjIZUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:07:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F3139
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:07:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c136ee106so1179076466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695758844; x=1696363644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnPN1NOYmkf+oNudX673WFOim8syjAZ8/Se4c2tU2Nc=;
        b=CN/ZO5Cr3TelCc9UIRzrIv9ENKncxKTvpQhTJE7AwYdNWMEhhRrbV1VoSSSFCCFBDG
         WseRZyyreYNXgwuUQokKQMZfL2fPsb4qCuCfyEmWk+WA11H+HmNmpdYwUtgR6Q52oq8z
         Et2/gy8WLeg7dOfUS7j910GrGAo3NikB38Cdea4evmL1t7H+IherJtcMsPGQjZSyZZQY
         lXEXPNm1EvhDDDy8yHbrOVR0RMNP8bp2rrRJ1sGjZ5oGin1GAaOp8VI9x+JkU1MpmN5a
         Lyt80MyuLoGwzvhMVA0WU/gROCyAshNcgn3zB7RWXUADqUFOpIgk8paoxUO1SVywFuZ3
         AdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758844; x=1696363644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnPN1NOYmkf+oNudX673WFOim8syjAZ8/Se4c2tU2Nc=;
        b=rDdlU5DH15pCfHa26TL0uFMrL7lIe/bqUUkdJ3VSHvTDPRUPT3DiJ1qMBjYxFhBu+f
         2m9GYkRYYMhiWYP9NkGVnZWlc3w2QycK7vPBm2KROqFkFAbPa/ifCkWHDaMfJoCs9cW/
         0JBpaAgOSnCSgN2HTLWb2MWCqeHJB9Dkla7qYK3dS37Rk7mx3eW+MKAQVZX3zEHjtlhD
         /6uvYSWf5AwEx/yiXOPZqhgHL2pm/dgzy0VYLuDiJzylUS5u342hWod917kq2Q3Ip+2B
         sb0Bsai00gvb+HtJarZ4nAC4UICDLJz1WhxI+1tITyzdHUmN0pgTCBL+Ka1HM5GL9TAV
         KfBw==
X-Gm-Message-State: AOJu0YwyUG3KP2sheoKJESYEqRn67WSlAweuALl7/yiQuz0jd/MiU7ZY
        JHInLOAPleoEsRbs6cLA7STTkw==
X-Google-Smtp-Source: AGHT+IEpcloLUT7V/Nzji/sun7iJolr6vWxw/e3GcLqXFw2c32z0CZyuBUDDPjlr4esUEcapUYoVyQ==
X-Received: by 2002:a17:906:310d:b0:9a2:24f9:fabe with SMTP id 13-20020a170906310d00b009a224f9fabemr10679684ejx.66.1695758843936;
        Tue, 26 Sep 2023 13:07:23 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b009ae54eba5casm8218821ejd.102.2023.09.26.13.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:07:23 -0700 (PDT)
Message-ID: <47a4bc7d-3f87-4a55-9905-19df20a9e03d@linaro.org>
Date:   Tue, 26 Sep 2023 22:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable tsens and thermal for sa8775p SoC
Content-Language: en-US
To:     Priyansh Jain <quic_priyjain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, kernel@quicinc.com
References: <20230926085948.23046-1-quic_priyjain@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230926085948.23046-1-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 10:59, Priyansh Jain wrote:
> Adding compatible string in TSENS dt-bindings, device node
> for TSENS controller and Thermal zone support
> 
> Changes since v3:
"since v3", but this is v2.. but only in the cover letter?
Did you mean "in v3"?

I guess this is the v3 series, but you accidentally sent the cover
letter with "v2" in the title and then resent it separately at [1]?

Please consider using the b4 tool [2], it makes such mistakes not
happen and simplifies a couple more things for both the submitters
and maintainers.


[1] https://lore.kernel.org/linux-arm-msm/28473da7-e194-4581-a1d9-6ef574d52ed7@linaro.org/T/#t
[2] https://b4.docs.kernel.org/en/latest/index.html

Konrad
