Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9836813629
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjLNQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:26:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1D125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:26:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-33642ab735dso1322734f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702571195; x=1703175995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d3HeMFEjkwHLi7a2aWd2MzxpoFFChdWdBBE6lzLD8F4=;
        b=M20oTh2iF05ntjBX4vKHfCTF5JIyWpC75ZGJ9rjvE2ShSvj7T3uTVZzffPiURdiUCc
         bbf9Uixllt3KdPNStfQzWU/LwPLYAGMeiUFk6LOu/x+9usH9BmaKiCO67Jgah7pzmTK3
         LNCTbEg8mPlKkbGeewzLnRzSPVpXO+afx19VDPc3ZrAavivG3CG2JjwU0E6QF9E0opIg
         5KO3hNhufN/7cbE1GsJrbWfi4QgGsNMN0wjRSAkFqTRVh2LONlHRY3h1Rjv8Y1N0mMSk
         3KK9q+8amPFQd1d3+qI147bLJORyCohbM1nIK17Pqc+8amwjyQQZIZh1zj/nbUMLKd1w
         tCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571195; x=1703175995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3HeMFEjkwHLi7a2aWd2MzxpoFFChdWdBBE6lzLD8F4=;
        b=tu3c/2GBRJk4SMwaN3ab0gLj8GaoU1i0mpKbqZU/YuEciOtQz2jGgFiIODeQmNOyEH
         gkKhWoOk3lEobR6F1nzBgxBHbzBA7+B0DlaF59ly5uW+sMLtxAV+FXLlrKSKgOKzYdV+
         k6pWV2ttP79m5Fz10WVkPDtOsrKu9Jj+WuVM5GueRA/69T7rGZD0pfsCVsdhIzwy4K1t
         x59CNznxn/ItabPTsGX7dDawmEyZDa9T9XkmKKyI22ARM1iz+P8TLQ4diFruJjwnfBU+
         4dUH3wfUmsHAmkodg5+V+7iUcxLzkdNnWmLtkjojtVhEh35NVg4sRWqk3knjIFhlEXlw
         kz1g==
X-Gm-Message-State: AOJu0Yw6Yb3TD3dd4vIaGwyIx67JeLUpmXOS74CrtV4jbvfdjAoAIK5Q
        nmS3U1cHiJa0j4Y8KAW/yB8DzQ==
X-Google-Smtp-Source: AGHT+IESLwwtCRBsH1tvNGs61R1lIWDuRr9DdZreW/J14JEfwpuA8biE1eOR+NhxMzWS4jy1tttlpg==
X-Received: by 2002:a5d:4652:0:b0:336:344d:8d41 with SMTP id j18-20020a5d4652000000b00336344d8d41mr1276005wrs.221.1702571194831;
        Thu, 14 Dec 2023 08:26:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d5452000000b00336367631efsm5557996wrv.65.2023.12.14.08.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:26:34 -0800 (PST)
Message-ID: <6df9fb93-85cf-4c03-b0cd-781d4f42db30@linaro.org>
Date:   Thu, 14 Dec 2023 17:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: display: rockchip,inno-hdmi: Document
 RK3128 compatible
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alex Bee <knaerzche@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <288857ab-bebd-4f80-9cdc-9b04fa6c7386@gmail.com>
 <df84a0cc-cb38-431f-864b-012ada7bb0d5@linaro.org> <2221612.3VsfAaAtOV@diego>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2221612.3VsfAaAtOV@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2023 17:20, Heiko Stübner wrote:
> Am Donnerstag, 14. Dezember 2023, 17:07:27 CET schrieb Krzysztof Kozlowski:
>> On 14/12/2023 16:22, Alex Bee wrote:
>>>
>>> Am 14.12.23 um 08:53 schrieb Krzysztof Kozlowski:
>>>> On 13/12/2023 20:51, Alex Bee wrote:
>>>>> Document the compatible for RK3128's HDMI controller block.
>>>>> The integration for this SoC is somewhat different here: It needs the PHY's
>>>> Please wrap commit message according to Linux coding style / submission
>>>> process (neither too early nor over the limit):
>>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>> OK. Not sure why checkpatch --strict  didn't tell me that I'm over the 
>>> limit here.
>>>>
>>>>> reference clock rate to calculate the ddc bus frequency correctly. This
>>>>> clock is part of a power-domain (PD_VIO), so this gets added as an optional
>>>>> property too.
>>>> If clock is part of power domain, then the power domain must be in the
>>>> clock controller, not here. So either you put power domain in wrong
>>>> place or you used incorrect reason for a change.
>>>   Rockchip defines it's powerdomains per clock and I was little to much 
>>> in that world when writing this. Actually the controller itself is part 
>>> of the powerdomain. Will rephrase.
>>
>> Does it mean you have like 200 different power domains in one SoC? Then
>> how are they different than clock if there is one-to-one mapping?
> 
> It's more like the other way around. Controllers and their clocks belong
> to specific power-domains. So there are of course more clocks than domains.

That's fine and expected. Here the comment was suggested that you need
to add power-domain because clock is in power-domain. That would be
clearly wrong and instead the clock controller should model the power
domain relationship.
> 
> 
> 
> 

Best regards,
Krzysztof

