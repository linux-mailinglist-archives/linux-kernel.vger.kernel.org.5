Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2677A1E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjIOMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjIOMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:20:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA192273E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:20:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so32995321fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694780405; x=1695385205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52tjejpvxnE8EVFiMbyAusvH4BJALwybD9Pcm4LTKkU=;
        b=oPX4L/hHHkRvPGad9Q1rYbcez0sv5sc/Q8IXU5t9YF2q/OMWHDS96L9AXIYxiVXl1j
         d4IISqFLxHvdtvBHQEDRxYfblAmqnaiBNvll7hBHV6BoX6SY7LszjiH0gEq3U8Hqgt88
         Wh0TrcP8ez7MivCMYSFKrXRWrJBpOLcxKBCnlbw38VKzZYhPF9VA2bRXiH6nHiRfEEDy
         BBLCdQ8bU2wdpM/PjvsrKbIiH/kDhD4lR9rQHyOyTjq3+62xM9Vglk/MRSuoYhdPPe8B
         u17WKgO4BZ9RVKFnRjBySYhVNd4hLlb3KWoU5OvaAnv4w4hhRCfZAPlg/yOmdGeGshq/
         DypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780405; x=1695385205;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52tjejpvxnE8EVFiMbyAusvH4BJALwybD9Pcm4LTKkU=;
        b=u55lx6ORrv+FEpyScVLzH+j1eJV6R/XPNhz9Bka6F9twGcI9vgTrSMuv0bnbpCfQxb
         EbfPVhG4aZMmM5Fo7yTcnh2UcPmseXSNZz5ycVEMde0kEf2WWJbFAEOwLco1o01mNtUZ
         FVejX/t28gyq8XWJJsjBLKOpIaBmKu2C7q9w+1w3OVluOFr2hHSXK3lEpVVb3HZ91JXQ
         RmE/IoJWKvh4oShGxWPcIIFgDnZSvWQ1fljzc5sLzemNKEVa3z5CIBJ/JldwU/3kWbbQ
         HTOmtJFmYX0LnXSptpDT3urs6t+v42ackz18Oqcvna5+xH37UiL01Af4MfS2nRLPKZrQ
         t+0g==
X-Gm-Message-State: AOJu0Yyovsk0rdh6M4/8zxqxWPvioTbF26AnO1mYRJ47E7s/E6j87XcS
        1fKcKmCj/3g53YE7XlmCs8GgyA==
X-Google-Smtp-Source: AGHT+IEuaLoRu6BfkkK0RfPqU4MzcognEb/aFkTu1WQhdb96RMqVBnMjoxxbgnJqGTaec9hd0t0CDA==
X-Received: by 2002:a2e:9f0a:0:b0:2bc:be3c:9080 with SMTP id u10-20020a2e9f0a000000b002bcbe3c9080mr1318797ljk.27.1694780404833;
        Fri, 15 Sep 2023 05:20:04 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b? ([2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e978f000000b002bce38190a3sm696858lji.34.2023.09.15.05.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:20:04 -0700 (PDT)
Message-ID: <76f3bc23-8677-42bd-a3a5-43b17cbe552e@linaro.org>
Date:   Fri, 15 Sep 2023 14:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT
 flag from PLL clocks
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
 <20230913-gpll_cleanup-v2-1-c8ceb1a37680@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230913-gpll_cleanup-v2-1-c8ceb1a37680@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2023 08:59, Kathiravan Thirumoorthy wrote:
> GPLL, NSS crypto PLL clock rates are fixed and shouldn't be scaled based
> on the request from dependent clocks. Doing so will result in the
> unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag from the PLL
> clocks.
> 
> Cc: stable@vger.kernel.org
> Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
Stephen, do you think there should be some sort of error
or at least warning thrown when SET_RATE_PARENT is used with
RO ops?

Konrad
