Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA797D81D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbjJZLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjJZLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:34:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538B1B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:34:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32db8f8441eso583278f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698320069; x=1698924869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guG/4XeVgfANKrbZu4mGuhf3LMfrQDPCzTLE4W9xTUQ=;
        b=CcTu02xmrvd6uRdisUSflC264cuI3LaRZaMPUmMAM0Le/0hRKug8zchKwTCFTJI+/W
         L7o5BqsG4o0FD3uLRbShrXzZtcZ2ijAlqBs2INot0WJ8aXeIs993Km7A/e2u34mnBpgU
         4PnvJaH//HnHLo+mXMa8Z7aIeRP1Svfm40UNRXiuf89TOTeMdFZ0XIaBrtGCguXiUIIb
         IYYjhnxKptGHiOkCH6RjX6lo049quIcPEN80G3YbR9PRdQ8gXb4B/s53wGmtznJ26kXF
         K9jQpRTymjG953grbhLwDthysc4vMla/ETH/qSE20qi6LOOi+agptyHlsHsYnIOHsDE0
         teJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698320069; x=1698924869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guG/4XeVgfANKrbZu4mGuhf3LMfrQDPCzTLE4W9xTUQ=;
        b=Rya1avpOPsUJEHR0DjrOZDLeryqTDFuhOBNdJT25QmcoO8zNi9EC742QwKN7RGo6xo
         qsgUlOAKRPf2NlcQLqHjfgQfEWwGdBC2sCJjPEa7yzw0V3jXdqzPHgt2ONsCmYV2zqUK
         HjLpQ/Op6ogOYSSOnJuy/yZfXqq3EVpGjDh29ae9ggmYImJooD5mrfWRy/lNGu17uHlB
         h0w6uyD8H0O11EHUVfg3jUHoFHQxLrfAnEkM2g+hd0RtiRS5108TBnePpqKYn/ScRQi/
         S4NZqabtYTSD+NmrQ+Ge+WXpq/HQPgQ3rVlWptmUpqr8PXOUyNT44mhkZ3qN7l63wdBm
         55Wg==
X-Gm-Message-State: AOJu0YzBVfhIXeFt1RPTyPKOvH3YGrwV9MlTT+A8sMjQmM2tSvWHaIs7
        /C83IPa1JMNV1vRvsku6Db6dlw==
X-Google-Smtp-Source: AGHT+IHSkVTTrHEK5sk3YvrLqIt1UC98bLaicwEdKbLfLHhFFxSyL8PtT3Zt2NSsN8z3RRf7Nbph4A==
X-Received: by 2002:a05:6000:a:b0:32d:8830:cda1 with SMTP id h10-20020a056000000a00b0032d8830cda1mr13865846wrx.63.1698320069155;
        Thu, 26 Oct 2023 04:34:29 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id w5-20020adfee45000000b00317a04131c5sm14075315wro.57.2023.10.26.04.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:34:28 -0700 (PDT)
Message-ID: <6d44b972-9337-472a-9010-71ebaa0d45cf@linaro.org>
Date:   Thu, 26 Oct 2023 12:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 3/4] clk: qcom: camcc-sc8280xp: Add sc8280xp
 CAMCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
 <20231026105345.3376-4-bryan.odonoghue@linaro.org>
 <20e2801d-df4f-436e-a677-2c81d43e3273@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20e2801d-df4f-436e-a677-2c81d43e3273@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 12:21, Konrad Dybcio wrote:
>> +    .flags = HW_CTRL | RETAIN_FF_ENABLE,
> This should really be HW_CTRL_TRIGGER from [1]
> 
> and then downstream uses cam_bps_transfer_gdsc_control and
> cam_bps_get_gdsc_control to control hw (fast) or sw (normal) mode
> 
> similarly in drivers/cam_icp/icp_hw/ipe_hw/ipe_soc.c for IPE

I'm happy to do such a conversion if said patch hits -next, qcom-next or 
clk-next before this patch, otherwise I'd rather not gate this driver on 
stuff that's not queued anywhere.

There's alot of CAMSS stuff driver/compat/dtsi that is gated on having 
the CAMCC upstream, effectively all of the CAMSS stuff for sc8280xp.

Fair ?

---
bod


