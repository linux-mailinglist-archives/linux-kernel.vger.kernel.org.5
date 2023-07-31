Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CAB769172
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGaJTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjGaJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:18:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D47B1BD8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:17:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so45478381fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795028; x=1691399828;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5KvgIxXrNBW+ICpRpcD8ldB4nPJk8pR1BpuMuP6iUoA=;
        b=jyDUsroFZnsQwdHDhpyfjJP16KxJ2Bm3z32mGNUxbV5AHato4TcsXK7RKrVP2LJdY/
         2/4KGWkwKj29qTEg3NPF/FF7ee8ZQGx+k2qRXcWjefmx6ibIi9+xy3R1razFVaP1PFKa
         6Jtl+rqNRvuQfxLSu2mx15L9eQdM6902mvBKTDu+aS3k0rzLZD0oHUK6UxauVZYKtyY4
         c7br/qTJpA4rq1rdijEybfTYzdxfZH2WJnNUYaEMM+NKQjZxgi45XY5eJ1hx75KxqwKM
         fYorjbTqUmbPTZzEIVRr+Jhvxzwd6OBdNAwC6anYBfq0jTLVYDUpyc2MP48HJS/4qJlg
         S3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795028; x=1691399828;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KvgIxXrNBW+ICpRpcD8ldB4nPJk8pR1BpuMuP6iUoA=;
        b=atZwW7CIXaR+DyPA0o2h47SB+ztQo3ro4JGAip5K56c9MduYZmGlcZckPGjDFJmvwd
         KJoYyifH7bYot6sNj6NDKMwa5L36VE0eKy3MZ2vnJVrUmR67V8SQ5+DwYdwTuQp48/VR
         HhlNvxeQ3EWeohzOGlxhoynrQLeQEvyWyqUtVy114NoDAycwoLCHuaZ0jH7vLpBdoGou
         gnW8B3HHc1mC1KNZ/lWoq1pI1DxSgyqrMXY1PKz2WYmOBRtP2nZohPQ3kgZ2dcRb1xKI
         7JeiArmGHWqv4LH0GRQp89DqDDExGk2yCDTRzOcMN1ojnxNJ5qKI5gkU9cKpcQ0nx05i
         VGWA==
X-Gm-Message-State: ABy/qLaLQwf3/rkl/vBRoyASuYMLmItoHg6e7gcj+lpIar5PMZXV+bdU
        cFqmUXnKEMXgokVu6Wbuqe+lsA==
X-Google-Smtp-Source: APBJJlFhbontxRh2AYxqpfnm5ytn+b3cKOcZKI0ursWXowN0xpSywbzEKe4jSNS+2JWGR7yjRKMYcg==
X-Received: by 2002:a2e:910f:0:b0:2b9:5695:d10d with SMTP id m15-20020a2e910f000000b002b95695d10dmr5741521ljg.36.1690795028263;
        Mon, 31 Jul 2023 02:17:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b003fbe791a0e8sm10745362wmm.0.2023.07.31.02.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:17:07 -0700 (PDT)
Message-ID: <55cbdbba-39c6-7415-37db-97d2c35412cb@linaro.org>
Date:   Mon, 31 Jul 2023 11:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        zelong dong <zelong.dong@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
 <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
Organization: Linaro Developer Services
In-Reply-To: <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 17:49, Philipp Zabel wrote:
> On Mi, 2023-07-19 at 14:09 +0800, zelong dong wrote:
>> From: Zelong Dong <zelong.dong@amlogic.com>
>>
>> Add new compatible and DT bindings for Amlogic C3 Reset Controller
>>
>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>> ---
>>   .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>>   include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
>>   2 files changed, 120 insertions(+)
>>   create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> index d3fdee89d4f8..f0c6c0df0ce3 100644
>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>> @@ -18,6 +18,7 @@ properties:
>>         - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>>         - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>         - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>> +      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>   
>>     reg:
>>       maxItems: 1
>> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
>> new file mode 100644
>> index 000000000000..d9127863f603
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
> 
> Given that this is only included by
> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
> moved to arch/arm64/boot/dts/amlogic ?

Maybe I missed something, but since when should we move bindings headers to arch/xxx/boot/dts/vendor ?

Neil

> 
> regards
> Philipp

