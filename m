Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9B7D8957
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJZUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjJZUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:01:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEB1BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:01:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507975d34e8so1955085e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698350492; x=1698955292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzGqz/duyYPElwwtqx/hjizAGVszVP9AWvS4e26Osn0=;
        b=J0w1uwlWD3G4/I5eKcsjcmfHTeMX/UuBqnTC7R+cjHCx4xW+Ok0imZ0h5WcUWdsLsM
         2+82/18TOZ4wSdUUVIHMZwTgBfP88Ug/LvlDnI/koBop7wa/uafvIpOVrcoV6HqMxywe
         maEscMA1KtU/Zygw9Do42nx7vVL9YZ7IoZFRM0FAusXBkiDlQFMGspaluTCpkFAGfisp
         T1ttwk5E3VtBN1CJ/1aNxXYyy9304f7Bp48iQtnxIJVWG3xv+JjVh4FgNTBizhypC2jT
         i3P9tOALnObBePfdSRnsj002TJhS+Ldf0tefhzBqSRjy4SXbkWKy07hz9eRIdhbL8YUK
         fkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350492; x=1698955292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzGqz/duyYPElwwtqx/hjizAGVszVP9AWvS4e26Osn0=;
        b=HAYfCEq8tsFuKUC8C0fzrmR3cHM/heyJWpAnsOEOE25GQ3/6YO7cddwN/ISX8QhW2u
         1FfboP3TN56UU/aTO8jTsLDGe6opB7bATd9puFOHopVhImigPVyVe0NZxUwQ75bdOM0a
         edSZY3gYDprCU0XOxipk3WDc9IutGaAHeiXPqPRmQxLUoiQzV0F0ZWKh9K4Tkpx3ZOMn
         2/dyIW+PRL/wfY/oYLuj/uBg/rDocorcPZeY13aeNEGy/qPqyX2mDply+QWzjuth25kb
         JjuNC7xhwlMGXP/W6YdOJhznofqWHEaKL7VdJveXhwNMLifLVVAk3ZAoKbwCbuAO0sE3
         KtGQ==
X-Gm-Message-State: AOJu0Yw7g+1QYCaVIpznOSxYomZYnEWfaboSxNyeHhhFM9f6m2VvW6cT
        baRpod3I9RO/K0iEL7IOtFuKxg==
X-Google-Smtp-Source: AGHT+IHhxtpFa1NlJRvaWu3AoOoyJeppQxaOVSGhWnU+RXFu75zgVS2yrEFL9xfgFkxYE9BbFWyilA==
X-Received: by 2002:a05:6512:3d0b:b0:500:8f66:5941 with SMTP id d11-20020a0565123d0b00b005008f665941mr337184lfv.50.1698350492352;
        Thu, 26 Oct 2023 13:01:32 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m21-20020a194355000000b00501b9fc977csm3137765lfj.37.2023.10.26.13.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 13:01:31 -0700 (PDT)
Message-ID: <a6cc8d55-2892-478f-ad8a-a9a4359abb7d@linaro.org>
Date:   Thu, 26 Oct 2023 22:01:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
 <20231013173854.7399-4-ansuelsmth@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231013173854.7399-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 19:38, Christian Marangi wrote:
> IPQ8064 comes in 3 families:
> * IPQ8062 up to 1.0GHz
> * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> * IPQ8065/IPQ8069 up to 1.7Ghz
> 
> So, in order to be able to support one OPP table, add support for
> IPQ8064 family based of SMEM SoC ID-s and correctly set the version so
> opp-supported-hw can be correctly used.
> 
> Bit are set with the following logic:
> * IPQ8062 BIT 0
> * IPQ8064/IPQ8066/IPQ8068 BIT 1
> * IPQ8065/IPQ8069 BIT 2
> 
> speed is never fused, only pvs values are fused.
> 
> IPQ806x SoC doesn't have pvs_version so we drop and we use the new
> pattern:
> opp-microvolt-speed0-pvs<PSV_VALUE>
> 
> Example:
> - for ipq8062 psv2
>    opp-microvolt-speed0-pvs2 = < 925000 878750 971250>
> 
> Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
