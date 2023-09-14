Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB287A02CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjINLiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjINLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:37:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FA1FCA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:37:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1004908a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694691474; x=1695296274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzwnWQaCHzBNH4v5E5Ke/WgGPb/4HugJ4oItdNzqjvk=;
        b=v0pBHutV/yJHoQnVE/SclR+kd/lAyTaDfztyvl3Nd2FVd3fE+cetAfgKp2GuuiOT7K
         yed+waClmOoiGJq6dUD3rKjPKFdj5YW82eupVh67ZcLOahQDRHCHRtxlWQkrJ5OC4Ggo
         Avc5GFgDLkY3UuGug2YDKXTfXIWd6NNv0kduVtiH3kPoLY9LKnlj99Zau7doj5K8rRP8
         su9uGdZ55JkBGBiGivC+79NkdXnzJdnCQC3EOvkigVBvKwNa1ToxqGJPpO1ojN5cLfHI
         6nsVA9qqmcPHxKt5KMGjcAIYoAGMwrgZBhfg3QqDeJkbIqQNA57yBlorOMziLLw6vdCk
         4tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691474; x=1695296274;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzwnWQaCHzBNH4v5E5Ke/WgGPb/4HugJ4oItdNzqjvk=;
        b=oiYPwqKLBDTiuwj95I8IG+sQ2l4++nUrHMsiGqgppgxx/FVen5C5iHdu7qwuEGBzM2
         1B8STKqVBhEZ06s4+ZSibWevvx+hxsYyZGQ6/5DZhxPI8C+j6EPccaz/5cWzCMFDS27f
         znoQnTRfReZsNbe+N29ix5uzBnlr8taYk6eipJsFXy2tTnbSL/rpD4s8oosB8LV3z9rW
         EArN950FSB0405kQI4YJWyybhMGP5uUerLnww33b1WC3cXxu8Tws2DoJPvm3SydUxOpW
         MvbOdqe2vDf0/4vc5WCnEIQUD3JPJ2g6rnK3LBIhVEU4q8Ff+53QFPR8PmZRkvr6eMo1
         8LAw==
X-Gm-Message-State: AOJu0YzwbhzXT+EsXUzi3naTu75Sx714DP+0exhDK7H6KWgZfOj9/AXT
        /Jr8ZyEdNNZqNRmakRUYiEEw+LoGeLDnX+P+oofnXA==
X-Google-Smtp-Source: AGHT+IHcLGAnJsuW8PiNRY0KSZ5FpORn6oFuuYSmN3nEiEkcyNdroRMVB3j+Olo1VO+5Z9DPv5hraQ==
X-Received: by 2002:aa7:c904:0:b0:525:69ec:e1c8 with SMTP id b4-20020aa7c904000000b0052569ece1c8mr4000556edt.40.1694691473953;
        Thu, 14 Sep 2023 04:37:53 -0700 (PDT)
Received: from [192.168.37.232] (178235177003.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.3])
        by smtp.gmail.com with ESMTPSA id i3-20020aa7c703000000b0051dfa2e30b2sm815967edq.9.2023.09.14.04.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 04:37:53 -0700 (PDT)
Message-ID: <adef5503-39f2-4fc5-a445-3c173d86c57e@linaro.org>
Date:   Thu, 14 Sep 2023 13:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] pmdomain: qcom: Move Kconfig options to the
 pmdomain subsystem
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
References: <20230914111753.586627-1-ulf.hansson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230914111753.586627-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2023 13:17, Ulf Hansson wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc subsystem to the pmdomain subsystem.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
