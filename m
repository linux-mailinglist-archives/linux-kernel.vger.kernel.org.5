Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689F7EFC69
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbjKRAGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRAGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:06:15 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EEDD7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:06:11 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50930f126b1so3365264e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700265969; x=1700870769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkuSxfBC4F+DNLrW68HIrLQZh2sF2jMkW+/1oAq+d0E=;
        b=LZRZKrJ8BEjwR1LlXQQhr49mBNtLxYqUPbXDOS+b2mXWH9cJaAXWM2vWMrrDhTRTj7
         bSRcRl7bbbmuCeAI5JbqXG+BxoMZHMX9oBRmujnUBhxGdmLC+ZTTNGr6bKEh37nPDf/Y
         WQ+hcXlK+m2N5k9VLidoFBnxVNVsp+268v3AqQDi5ZMKTraNsriOaHljwKjn0OqXC9yz
         TTdwqqsq8L+6ZjcMGilQIcFGoa5ph36oNc4lZAYsnHCxYkrzS5PE5HnRDBpF5sVi6Pdf
         J+HNZgICbLM+tActzsrNUJsK67SwJjVLnguZ8tJela3fjuB5+nastQt3o6xsWoakqa3n
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265969; x=1700870769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkuSxfBC4F+DNLrW68HIrLQZh2sF2jMkW+/1oAq+d0E=;
        b=ib5y0bsiqsR0q2pc8KjuImuvEePjv5hEpjSXnr0Ru+e2mabsHnNz2q4PRuYgShvFJ+
         PkTxIwk3Jh5HHU8kHNOi59U9ASl8qsKYw4HS41VQoVwQToDyW+XrP67MC00qiUL/p80h
         5/9tEGm4fVTLFSIYolpyyuRnJVG8dKHZRGuEsoEkBQw+AgKgq8lq4aqJg8TadgPwotqe
         Xz0Keh7QTe3WrmGdKgXGTgcABaF1nj9cjC2t7yZP4XsNg31lKUY45RRG/DhtOHpIURxT
         NZXhSo2Nsl43BbIdq1Pa+E0+qRlEN8+wxuZQ001WrywNZaezRRsBuFOM7pfR3sGjhtOx
         Yi4w==
X-Gm-Message-State: AOJu0YyIHe5p6DUv2HID2g2d5Yr+TqcP77XGPsZa4PMHQqJWGHtN9QhT
        1/Rpq3UWjckoMO5r0OWbdCZTcA==
X-Google-Smtp-Source: AGHT+IF3EYLf/B1NjPvHxo4zxynXWYMW6ljJWIj9L+81F5pUXD3r1olmF3CI8NaR46EVAodUBTG9AQ==
X-Received: by 2002:a05:6512:480f:b0:509:489f:d84e with SMTP id eo15-20020a056512480f00b00509489fd84emr845440lfb.37.1700265969447;
        Fri, 17 Nov 2023 16:06:09 -0800 (PST)
Received: from [192.168.201.100] (178235187040.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.40])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0052ffc2e82f1sm1190361edq.4.2023.11.17.16.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 16:06:09 -0800 (PST)
Message-ID: <2e0d2c55-fb2f-4903-a555-f51019942c6e@linaro.org>
Date:   Sat, 18 Nov 2023 01:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] clk: qcom: Add Global Clock controller (GCC)
 driver for X1E80100
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231117092737.28362-1-quic_sibis@quicinc.com>
 <20231117092737.28362-3-quic_sibis@quicinc.com>
 <ec9d03f7-7158-4309-9a04-b08c69b89f39@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ec9d03f7-7158-4309-9a04-b08c69b89f39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2023 21:50, Bryan O'Donoghue wrote:
> On 17/11/2023 09:27, Sibi Sankar wrote:
>> * Use shared ops in the x1e80100 gcc driver [Bryan].
> 
> This looks better to me now / more consistent with what we have in sc8280xp - where we do try to hit suspend and => retention/parking matters.
Parking the clock is separate from putting the system to sleep.

IIUC we usually use shared ops on clocks that may have different users
(e.g. not only controlled by Linux) and/or that are crucial to the
functioning of hardware (like AXI clocks, which if gated would make
the system crash on any access attempt, from any subsystem, unless
turned on beforehand)

Perhaps Dmitry can use some clearer wording than me..

Konrad
