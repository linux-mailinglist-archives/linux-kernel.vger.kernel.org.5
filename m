Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1789C763D94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjGZRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGZRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:20:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862A2D70
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:20:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so56065e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690392029; x=1690996829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQVjGeQBTwIGF74QpeE9j3WXo3RNKuiGdQLE3UJ3ZV4=;
        b=t7Gtt61QfceQoiaJ6bMXB2K/QpFjaKH8QPC6SIiQYbc73jRKSROZ3Y+ZQFSEtVlRxd
         s1JJ2GmCz5OpKTfWS+BxQimueWdDBwbmYb1xm9wiPJiWjxB8gnb5Ecd9vHrMGNEHfU0E
         LaiINSPonUf88Fc9sC7TO2YvBbvZdtYbiCtiz2/ZY9PZ5uIK6lyHRZUoamUe5L7HDtPp
         DH6F0piVB7LBUS5CoQ1kQamJR+3FJSFp9gReAnvVS4v+KJ4pQIR/y3KfWMa6NGY9RgWS
         4hXHfMHxM2Z5dWxFtiXQm+imWN6Skrl37hPNXAJPB0CQmH+EUQYMfqRmi9EeCblOFyod
         gWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690392029; x=1690996829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQVjGeQBTwIGF74QpeE9j3WXo3RNKuiGdQLE3UJ3ZV4=;
        b=D6My2KqoPJDgTkKp7/ifo/+oqOTxHY+TUphCWegAZL/VTqpy62Glb6uu/0WmPDyVAE
         vrMtScowf3eo2A4e9pzWi6SkZ2o3RcLS0mjiQ/67t7UZ2OiI4+kWK2OA5+lUBbhcxNmH
         +/qK6H8dy97DCO4Qn+yC8s/p1rLFxzBmuXg5qJdyZHya6uqSlDGnE0vrPnIzp+fZhqpE
         Q6Quf+dob7De1uvd0qgrnkaUQ0ppIOlIKB4zkLjiHgSwqHUKn/CIF4VxJXVni6E45YKz
         6UkL+rBc2Xdv3+uZuX1PLE7MV5pFyPtmmVZJjE5UeC6h7GOVcjoTZeoUFdTyOpZPVYHr
         Z+Hg==
X-Gm-Message-State: ABy/qLbrjTJWLKlXKOMCmKJo2XBVhvQKHXUtPo15v6BvbfqU03oIfrE6
        sEVpz0LsFLeGOxmVdEOe98cvmQ==
X-Google-Smtp-Source: APBJJlFnCfEb0mDbLU3iC/Vxggmqeo9BGk+0xd2hOCcAhBjcLwlJ4LXeBDCrPGQNaCh5pOy5UIbl0w==
X-Received: by 2002:a05:6512:3493:b0:4fb:8de9:ac0e with SMTP id v19-20020a056512349300b004fb8de9ac0emr1876209lfr.1.1690392028671;
        Wed, 26 Jul 2023 10:20:28 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512014900b004fb8ff1f531sm3334272lfo.70.2023.07.26.10.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:20:28 -0700 (PDT)
Message-ID: <5667c93a-408f-3802-b168-f3a145dfcb43@linaro.org>
Date:   Wed, 26 Jul 2023 19:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] interconnect: qcom: qcm2290: Set AB coefficients
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
 <20230726-topic-icc_coeff-v1-2-31616960818c@linaro.org>
 <ZMFVZJa647SNwrJX@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZMFVZJa647SNwrJX@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2023 19:18, Stephan Gerhold wrote:
> On Wed, Jul 26, 2023 at 06:25:44PM +0200, Konrad Dybcio wrote:
>> Some buses need additional manual adjustments atop the usual
>> calculations. Fill in the missing coefficients.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> What about the funny util-fact/vrail-comp on the mas-apps-proc node
> downstream?
Can't see it neither on msm-5.4 (with the icc API) nor in the 4.19 (msmbus)
device tree.

Konrad
