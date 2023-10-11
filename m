Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99AF7C5B44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbjJKS0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjJKS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:26:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F92BA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:26:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50336768615so251172e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697048768; x=1697653568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhaMMjUnOGS0snHYgCTJqAmCtSDPr4g2Spu2v7RzFSs=;
        b=pOajQnojjdMb1a5mZZN4VIeggGqvq+Z6aRZbtGzbmawN4rONbvAQdhBnsROfAEwkNk
         HFpxEsQgaUZSV8RZPnj/eQEmRvBtSXApMKT44t65zCSiFObq9c950xTHLsy2Cxls6/2w
         /JChni43UDj+m/HrPW+qRIPuMDl9E4obPpbBLsAZxH878MiG2Sm9uuhmqWEj9JFqjQfH
         d2kaHgKHPyt5u4CWTKIJlOEWudnHHHEp/F9b3SqA/ps2fKDPxRGMi3vzpaiGWo0ZKmtc
         +MPEu8X66qW79UUyp+Z0r4XXMjaBgZKZsRQf4dwM79OV7mizHOr4w+qPrzws1L+CUZlR
         CO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048768; x=1697653568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhaMMjUnOGS0snHYgCTJqAmCtSDPr4g2Spu2v7RzFSs=;
        b=DMIRE6GwOaQXkYkmpJ/IrC8O8JvKEhEGKn5ZhFTjI8AnFDs2Rl9nMI8DVHObVdDjoO
         VHjJYT7Vy/5kHhTVcs+ALf62KSGwfWdaWldOm87wXnDpeD3LvmeqshPTihI3u93iExEi
         RvNn1IlolSdBs+/hpvtNeua8WinO3FNmDL392lYbSuXLazr5QnPTwHagoyI//OUlvM/G
         FHb505SKyhI8Qb4QfPrbj2sDMDEYMAJXTzjRdhqmKmyp24VCcuF7nmGNiPlC+2BleMKT
         Is1X2c0hMD9R+VehVW9ZCjDB74Rs1yhDiHIHIRQDXhDI3PtzZ6wij5w36E9sg1hkiUdL
         ZvQQ==
X-Gm-Message-State: AOJu0YwMwxAeIFf7i46fAxCtipMH3S8pgcpnsOenwqnMliJ2Db7kn8M1
        LWFTXhwk1jiiLkrc8kTcImvnhA==
X-Google-Smtp-Source: AGHT+IFIQJKuaflQSrmmNd4avkHuLSJlTQxyhkmlvVp6ZFvXYbsrbTPzUobPhnyafRwU98QeWKTaCQ==
X-Received: by 2002:a19:6414:0:b0:4fb:8435:3efc with SMTP id y20-20020a196414000000b004fb84353efcmr16377878lfb.16.1697048768272;
        Wed, 11 Oct 2023 11:26:08 -0700 (PDT)
Received: from [172.30.204.35] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z10-20020ac24f8a000000b004fe2de20d88sm2372674lfs.232.2023.10.11.11.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:26:07 -0700 (PDT)
Message-ID: <67a76151-30ab-4e85-9dfc-0078a83d8830@linaro.org>
Date:   Wed, 11 Oct 2023 20:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: document HTC
 Corporation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
 <20231011-htc-memul-v1-1-76e57873190c@z3ntu.xyz>
 <9f270d15-6705-4392-b2cf-49edf5bc2d3b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9f270d15-6705-4392-b2cf-49edf5bc2d3b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 20:24, Krzysztof Kozlowski wrote:
> On 11/10/2023 19:02, Luca Weiss wrote:
>> Add the vendor prefix for HTC (https://www.htc.com/).
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
> 
> So it is the first HTC device in upstream? That's a surprise...
Same feeling, this was very unexpected!

Konrad
