Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633117C5213
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbjJKLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjJKLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:30:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C428F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:30:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso6287307f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697023824; x=1697628624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7jf66VDbLwDGQFts5Mk3zmoqfgZj1njMNnWJVHShyQ=;
        b=qBzjgIwoQtEpyNqxJ/rS+2TSxuOxqRm97dL0GLepZzyjCephxFRPk3vgRf1c6A9ZVo
         Uj09gs08wiLnktVlOUHN9QxxYZ1jnHUnZo0xROSqLqQcY4DB7YqiRvvC0ZtbVmPAi6Va
         1ACtFRHesEHtguYMJwJtWH4+Dfi0cuQ02qpo8R5C+KufmHUjrLu9tzPflJpefcyQsU06
         LjFu4mIvvTL4jndGfV4474nGv/YaJOEjkQTU6/rhnNKYEOelxOPYGu+VA3GWGIgteSTs
         LPCQ4QwoHcEGf7BN85S0t9EDnW71aejb9RJtdwlFk2X6jYrdGSlP9D6qCaVIiC/4P5Ha
         UsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023824; x=1697628624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7jf66VDbLwDGQFts5Mk3zmoqfgZj1njMNnWJVHShyQ=;
        b=xBps+VAiBdiwWIREZozHNspYrvgXcfE1FxtwLI2mwEYw7b2zPp8uGOsiXHy2dlERqt
         QjdMm9s4Gr2ks9VJsNc4qAdVY9J5Zmnb6QflxRFFKzifyDJox6Rm76xfB2F8YMSScMUZ
         4oaHwV5ryvYbrAcfXjX4/g5FpfL/yavzK/Bd73lFNZ1LWq9Yw/MB7zJgeQrFk6neFpxu
         qhXS6HzBCNyN/JBmpf0B/cCaFHquS2kw7Mmwg9QnpIYwX4hsPUG0R4lhQeH5bMnZ5Fz+
         VZz1a3krH5rzJk90sknggbkd2jx02FyrGPUOMP6VoZcHTvZoqDSMYlnvuNUZdMtlGcFk
         JoFA==
X-Gm-Message-State: AOJu0YziJfn0Xe/Y4/RkpQEy4AuptoIBY/kUBn2MVTsm/4oAsEJBgexO
        MzSX39MPHxWiU2pTohnEiwbldw==
X-Google-Smtp-Source: AGHT+IHuiNcQZJf+Rmj8oNoUni1H4MhMhq2pN9qd3b2XdAV7M3v2EdBQhAsQuJ+PZNTRTBZv3+imhg==
X-Received: by 2002:adf:c089:0:b0:32d:5cc0:2f0b with SMTP id d9-20020adfc089000000b0032d5cc02f0bmr2726061wrf.57.1697023823657;
        Wed, 11 Oct 2023 04:30:23 -0700 (PDT)
Received: from [172.30.204.240] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d424b000000b003248a490e3asm15280520wrr.39.2023.10.11.04.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 04:30:23 -0700 (PDT)
Message-ID: <90e45a4a-457d-4b89-aa05-ddf40fec6e2c@linaro.org>
Date:   Wed, 11 Oct 2023 13:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: export of_find_next_cache_node() for modules
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 13:27, Dmitry Baryshkov wrote:
> The qcom-cpufreq-nvmem module uses of_find_next_cache_node() function,
> so export it to be available to the modules.
> 
> Fixes: 7683a63c08ff ("cpufreq: qcom-nvmem: create L2 cache device")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Pity the testing robot didn't catch this

Konrad
