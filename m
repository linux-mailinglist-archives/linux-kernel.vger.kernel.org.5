Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4D789691
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHZMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjHZMLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:11:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059572115
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:11:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50078eba7afso2767149e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693051886; x=1693656686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S47Ld8+HxlEOF86UAXFKswEn3qKLP+JRPgvJkyAgFDk=;
        b=Tlv+ZwAJypuxHc3xzXGyzSSTYoWYDYZtwwNfjxlYVfyitgfO77Qzo/o3cLhwJRATFo
         yyrACvdVvt4zcAwyFYEYrc8SfhBP7BLlXbAfYAcpPa/ySkIcRCoenDLUFKp7MvuwN5QT
         9kPe/D/qhY9D3uE1Q3L19kYggGayUO0/6LtW5ttFCFoSXf/NDYRmotbazytV/S+uLdSH
         KLJa+IsJ0i5TtNcLqn8MC0nUlkeIIL52AB8/AQv/0sb7bH4wCPwgnWyDoG2l5UDYZaV+
         0kxFpEjb6ZHFDr5fQe1VA47mVoHUgOuZsU2BDc9RUTA9R6WGNhfedrAhdNtVLMejnPsn
         zv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693051886; x=1693656686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S47Ld8+HxlEOF86UAXFKswEn3qKLP+JRPgvJkyAgFDk=;
        b=fU3XwF946pnaUtNf/6L5kqbA4P2ksi0XEF0WDmrMNPfRgV70hr8hcUldQoou4/1Prd
         YVImikfqpiXhSv6DRoCsYvdLAJyKa876pYeYboGt5uSemDNMDTjdXNP2Fa+bhwSQN1+G
         WE1gfi8TjtSGPVO7QA+p875LPGft/S93Q5an+M/XiIG2EQpoqyFqJBcInqXhNwzWG+d3
         1bQlLNyqBjLrgo2JdiIu+TrLDg386l3iCE36tSGn5HGKlsUVNjnHm6P3wPFIm4wGo1Le
         qMSakL8HuTSLstaA4CZgm05kUQ7R06LfJS/npycYPAAKWu7PF9ZXq97/gRkyUndkVKxt
         XBFw==
X-Gm-Message-State: AOJu0Yw0Zjsw8Ujyk6PoOONFjN1odZqmfYqhdiae0qteAr4zra6kSsIi
        yGEUCT/ETP/P7Sx9rIHUHqXc7Q==
X-Google-Smtp-Source: AGHT+IGNZ8RP3RjWrXlfzmEPoBXohNSwEXZ67B0VfipA4+8teOZe4S0mMEoz3L774z4NUTZsTeawug==
X-Received: by 2002:a19:f505:0:b0:500:a240:7240 with SMTP id j5-20020a19f505000000b00500a2407240mr4483361lfb.52.1693051886220;
        Sat, 26 Aug 2023 05:11:26 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id ep2-20020a056512484200b004fe951827easm685219lfb.196.2023.08.26.05.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 05:11:25 -0700 (PDT)
Message-ID: <0acf952f-edd4-4f62-8b07-0fe727526d96@linaro.org>
Date:   Sat, 26 Aug 2023 14:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] media: qcom: camss: Functionally decompose
 CSIPHY clock lookups
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-12-bryan.odonoghue@linaro.org>
 <d8e54e0a-b176-49eb-9d8d-66324cdcd2e8@linaro.org>
 <1b15ca0d-0781-c3f8-4822-fce3a7fbb7e7@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1b15ca0d-0781-c3f8-4822-fce3a7fbb7e7@linaro.org>
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

On 26.08.2023 14:07, Bryan O'Donoghue wrote:
> On 26/08/2023 11:12, Konrad Dybcio wrote:
>>> -            csiphy->rate_set[i] = true;
>>> +        for (k = 0; k < camss->res->csiphy_num; k++) {
>>> +            csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
>>> +                                      "csiphy%d_timer", k);
>> This entire functions is like.. soooo over-engineered
> 
> I'm going to accept your compliment there.
> 
> 
>> adding something like csiphy_timer_clks and cisphy_clks and stuff
>> would make this string comparison mess unnecessary
> 
> I don't understand your comment.
> 
> Having a litany of static comparisons is definitely inferior to a generic helper function.

portray this

struct camss_whatever_it_was_called {
	struct clk_bulk_data *csiphy_clks;
	struct clk_bulk_data *csiphy_timer_clks;
	[...]
}

and then

clk_bulk_prepare_enable(csiphy_clks)

etc

instead of weird looping and matching

Konrad
