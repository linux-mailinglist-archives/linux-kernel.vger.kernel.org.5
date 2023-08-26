Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C7789764
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjHZO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjHZO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:29:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC22105
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:29:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so5888449a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693060169; x=1693664969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UoHwOTKGuupL476rFcW8I642v+ujJo8hTqxA/kEoIVc=;
        b=yFKGic01iRVPyL4PsX55rDX8WIy7c6znpSM5R8aLe7RpP2VBqVwYhnRKZRjfQfvBkJ
         SVd9InmtFtKNB8srwsbuTS66sEYRqZ2KtjwaHberQH1SvHeqYDYW/Q6TGLRanL3NdEpb
         7xgifl+p3XTssLpg9RiB7OKGDuueJ1Sj1F0p2ydK+ELRu1bDqxbShFXVYfLJj+lK8uQr
         AdST1hMObcMpVt4oXJ6oZORjh560bj9PyOEnYSVbVCYSgA5iaSoglN7uekh1N5PIAu+m
         oCytOa8GlenkygJhgMH7P2sh+oUCPIeqhEhi3wRFZVx4BcSvzFvBV7QF6VG3YR9sfT4F
         YesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693060169; x=1693664969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoHwOTKGuupL476rFcW8I642v+ujJo8hTqxA/kEoIVc=;
        b=QTZLcFMnygNoUj91+1BkmEmZykeAlKu4SN6wCQ3au+wNnl8S6DWMQkkuxy8/N2Jtjs
         sBVGlP3H6ZoU0MZ7tlPwyJG8l5upwJz2lSV3raWMuOVPDoxY0wA/f8gPAso+2iFuFhmu
         Ty7B/A+DGXwpXdHNlfPZYLmrgtciDLiCkuR1rLeB26Gvu50Kw1m4iuy6+e6kEMZuumaW
         frhr0DqQQNUIppCYE3rwxVFN3FxK9qojb7/UvQX0WFXVidkZbX3/xKEcULfZ0ob1VH8G
         6sBpnbX51xXlhvDl2LSpeML167u2nWnEZLrPW2bKjAGlN7vYWeWLdb/mma6qCWx0pb0+
         PHcg==
X-Gm-Message-State: AOJu0YyAHFUXt7mZrFUrmDWVOAPH4NzlF4O0Ud+xQcEcsgsyPcr2IO94
        ebioi1VTU4WHwobPCbdAkKGgKw==
X-Google-Smtp-Source: AGHT+IFFtNX5/1x+vPBsm+ndbnTzoPdNJBmv/tkhp3W8Qop5+BkHCGF+0A7SABanuHFJLm3T355oQw==
X-Received: by 2002:a17:907:7804:b0:9a1:914e:491a with SMTP id la4-20020a170907780400b009a1914e491amr19325263ejc.3.1693060169184;
        Sat, 26 Aug 2023 07:29:29 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l8-20020a1709067d4800b009a1c4d04989sm2227595ejp.217.2023.08.26.07.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 07:29:28 -0700 (PDT)
Message-ID: <5847be93-68c3-95fb-1d3e-9678804b9a70@linaro.org>
Date:   Sat, 26 Aug 2023 16:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] clk: qcom: Add SM6115 LPASSCC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org>
 <20230825-topic-6115_lpasscc-v1-3-d4857be298e3@linaro.org>
 <a9d52cd9-845e-ff88-3c26-858cb6604e43@linaro.org>
 <CAA8EJprEnMjbKw2fbU1X7GV=ANARNhofSQh49Bdo1kvuOskbbQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJprEnMjbKw2fbU1X7GV=ANARNhofSQh49Bdo1kvuOskbbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 16:09, Dmitry Baryshkov wrote:

>>> +MODULE_DEVICE_TABLE(of, lpasscc_sm6115_match_table);
>>
>> Everything here is almost the same as sc8280xp one, so this should be
>> added to sc8280xp. You cut some boilerplate and additional driver.
> 
> We have been there. It quickly becomes a nightmare to maintain.
> Consider dispcc-sm8250.c

Because too much was added. I do not propose to keep all resets here.

> 
> But I agree with you, this code looks too similar. If we expect more
> similar lpasscc drivers, which provide no clocks, just several resets,
> maybe we can create a common generic wrapper and make resets lists
> corresponding driver data?

This would also work.

Best regards,
Krzysztof

