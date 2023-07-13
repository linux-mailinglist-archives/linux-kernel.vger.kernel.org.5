Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894C751E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjGMKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjGMJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:59:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B387026B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:59:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so4358125e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242357; x=1691834357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfGF94MMBcItJ6e1QKfjFxJbCT5K/y3Yw5zZ80cqzUo=;
        b=RX/2R95emqRU0/kqzZOeren1e7sASJz5H3Q+9BX1GCwE9RxNhiPGJgRRnCRXzBkEnF
         gPERfgVzy2c2BsMA8TvxffL0BRX2q6nAk8BwzqPW6uEVOSMX5InaZ0oWIqG2ti1ofIjG
         PUpftrLqcd6pswZKvH4qm6DhP3KeBc+RSy82e4xsn1ci4U5iSnAL/nRJ268WVQCjDnpn
         96qCJFJ57ykJSUcCpqVmJGXORNrxy8Ke0KPXGWcCg1g8ueM/UkDx5nsIxjSSBFFul7tJ
         SFJRw1ozRDUmp7wOYmdVTvB6cBXxOo0CltAvSdqZ0bmHwVrSKwNY+68QYqCr2Qabsk++
         cwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242357; x=1691834357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfGF94MMBcItJ6e1QKfjFxJbCT5K/y3Yw5zZ80cqzUo=;
        b=jZQLHFPoh6uJwoLTDRZHjQ4FmN3ZdEJxm7IKJHFwbxTJd66fiynAMLuzngIAtOkepF
         6Ph/xcp/JdJXaIwb2oreAvFGhEEtJsw8mItt9l7RqORoAaz7rwI4K+AHyjUYeKBhH1pv
         6xyltu8Lz9A/Z0K7oaAhXlrcncKsP5IBHsKDxDvTMbXnmViZp+h+8fTUdNUBSDdEuCdR
         GIkF/0Ix3GKzORPG7oY6cwpG+DjRF2Y7xICjadBzpMyeDg09crVaPcp1Ts9K2wBcKkP0
         si0vPT3d2I0QsDM2PGLaGG6pJA83igpawQFt5W9u4L1IF5ksfTdIBbPa6xYAF/oa8ntF
         43hg==
X-Gm-Message-State: ABy/qLZF262vvk3xBCL+MZcUpslo2vhejKSTqmDSsqHohtI02NQ4pO99
        ISyrTZkaDbe1V8QFUq3MPZt2rw==
X-Google-Smtp-Source: APBJJlE1vSef8lYrRI74FNpcCNSo3OMLYJY9thlLZ6Vno1ZNvXLJk23M3Ev81CwvC3qVpAPSm/SGww==
X-Received: by 2002:a05:6000:1189:b0:314:521:ce0a with SMTP id g9-20020a056000118900b003140521ce0amr1072111wrx.40.1689242357177;
        Thu, 13 Jul 2023 02:59:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d66ca000000b00313f9085119sm7482114wrw.113.2023.07.13.02.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:59:16 -0700 (PDT)
Message-ID: <1de2a372-e167-515d-0a0d-6fcad4a1e051@linaro.org>
Date:   Thu, 13 Jul 2023 11:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-2-huaqian.li@siemens.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713095127.1230109-2-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 11:51, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
> watchdog cause. Add a reserved memory to know the last reboot was caused
> by the watchdog card. In the reserved memory, some specific info will be
> saved to indicate whether the watchdog reset was triggered in last
> boot.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  .../devicetree/bindings/watchdog/ti,rti-wdt.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index fc553211e42d..8c16fd3929ec 100644
> --- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> @@ -34,6 +34,18 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Contains the watchdog reserved memory. It is optional.
> +      In the reserved memory, the specified values, which are
> +      PON_REASON_SOF_NUM(0xBBBBCCCC), PON_REASON_MAGIC_NUM(0xDDDDDDDD),
> +      and PON_REASON_EOF_NUM(0xCCCCBBBB), are pre-stored at the first
> +      3 * 4 bytes to tell that last boot was caused by watchdog reset.
> +      Once the PON reason is captured by driver(rti_wdt.c), the driver
> +      is supposed to wipe the whole memory region.
> +
> +

If there is going to be new version, only one blank line, not two.

In any case:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

