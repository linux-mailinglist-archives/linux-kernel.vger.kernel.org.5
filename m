Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605877C0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjHNTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjHNTl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:41:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA01701
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:41:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso43972365e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042116; x=1692646916;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hWVokt/CwUyrFGLpSEZU7jNylhLXHRK0ucHWHSV3+I=;
        b=TUKdKob8s0T4JkeeDvT2dwa/tAVm1CqbadyrTRnxa2IyDq45IUs0P9sEW9ak6SMtgo
         1iflsz9PnPw9auzulLS72OisiSeffETp0ki6FH2/Y7SK89qbuA11pWT7RwXZ6hpV1Yxj
         W/9xWndQTr4Wl0hbN2lO7LxVKa8DMfZq0J5jWre84hqkR63wpu7cjlKJ/4vYdlW+1RjN
         MV0HpPpVW1R8qyHkFMu8yg9f1sK3/pLyUGyqne54imype5AVfb70csLNauvHHvP5WPND
         er5RusW1g7jMG3e2B5X/Scx70aQRAYXpwRO8izMi4S91t9MulmSU9aFuBp0UwqPNJ+1i
         Toyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042116; x=1692646916;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hWVokt/CwUyrFGLpSEZU7jNylhLXHRK0ucHWHSV3+I=;
        b=YPGaznMV5advrt57sf198w10alp43pbKvYARbaPvocFclvfUNyoLosYoiw/eOmC1RY
         5uKmrLS1IPGespqT35xdK5VDRNk7hL7elwRv8u+TvB+jn8yOgzrkHH9M1rkNPRRPPL/Q
         Kod5N1/qbb0mR37ODxMraSS4VmBmN/3DAvU/4HTsBvYo6qkxcpMliT4VqoECXlQ34o3Q
         ubBXh5l3CILNk8cttRWE1AmBUtiUOzgWLCZ/hRm1F3LJlIzCAmqQfhrTBcsyRT/+E8St
         SXWwrgWuOsPb48elXeuxKBc4fslrBUNKAAFVRugchTjjRBYXhaAqe24wMoT4yZSFjVZY
         xYDA==
X-Gm-Message-State: AOJu0YxPi05tSRq3O4DLu0bEbApJ24U48hhwKtV8L9qFoDqdIgOJd+3S
        GHqkZBPk9p0+13eBweYswe6/IQ==
X-Google-Smtp-Source: AGHT+IG0u5gtxp32TUl77yAObK7hqWwBKPwbNr+WC1w31y4c6uk0yZmWJwLX5Q0Imes/bQTO1MKiEQ==
X-Received: by 2002:a7b:cbc7:0:b0:3f6:91c:4e86 with SMTP id n7-20020a7bcbc7000000b003f6091c4e86mr7729047wmi.3.1692042115963;
        Mon, 14 Aug 2023 12:41:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fe61c33df5sm18296228wmh.3.2023.08.14.12.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:41:55 -0700 (PDT)
Message-ID: <ae1107f7-d48e-d89f-4de9-f8d01abcc3e2@linaro.org>
Date:   Mon, 14 Aug 2023 21:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richardcochran@gmail.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
        linux-fsd@tesla.com, pankaj.dubey@samsung.com,
        swathi.ks@samsung.com, ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jayati Sahu <jayati.sahu@samsung.com>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037@epcas5p1.samsung.com>
 <20230814112539.70453-5-sriranjani.p@samsung.com>
 <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
In-Reply-To: <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 21:41, Krzysztof Kozlowski wrote:
> On 14/08/2023 13:25, Sriranjani P wrote:
>> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
>> FSYS0 block and other in PERIC block.
>>
>> Adds device tree node for Ethernet in PERIC Block and enables the same for
>> FSD platform.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
>> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>> ---
>>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
>>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
>>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 +++++++++++
>>  3 files changed, 94 insertions(+)
> 
> Looks duplicated.

Ah, not, it's another block.

My question whether this was tested remains...

Best regards,
Krzysztof

