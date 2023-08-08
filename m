Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3736E77432D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHHR6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjHHR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:57:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA07C20BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:26:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so868369066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511952; x=1692116752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBFUcCspHh6dxdrkfuuOEO6juHB5MNMMgkhIdl8JPKw=;
        b=homzsOJkinUB3qVwUrTTFxw1/RpACqzVep0SsNJHtOKJXEsgMIJlWZPGKF2u+/Qudt
         EqFOvvrhwg5ZtNAKAkQshc8YqKuLnTXwvMPiTZ/jr7FQ6SrIVl2HvEnoFSc7myZKCpPD
         +i5nUKAxhrVsxz67fjNklieainsBdZuMpStpbWkZUMrxxyGbiPF+Jgnlb9zpyJz/McNQ
         HbWLqsTJdOleEUyClMFsQcaUKaBg8rOYqcHMkRkMze3cOQTejpVXWP3eDCKJmnONmQDg
         4dn3Z78OF6ggxOWZkHlOUi4CZnpL7FJSsLBTtyaL8s7zMTvdi41cyi+qaN6OH1ilFzm3
         DUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511952; x=1692116752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBFUcCspHh6dxdrkfuuOEO6juHB5MNMMgkhIdl8JPKw=;
        b=YWRKbxcU4G0A7pbMAY+Uxt/8ESjfkid4CfBPRkN+wIXYyYvoOXeaE6mtkElPM5fWHO
         p5RDeBzGnj0cr3ze7BAx5tEfsN/egXYn4K4tRwVbf3BrtnV1W1Lk76vuGGzbY+FHYrR8
         srxPJhGFj91WZlNaFYlDjZQM/aREhy8rJWmL8L0aCnZlk/HMvzsDC0B5QeISYRxjPUfb
         yh59ZwrwUBdYDiIcQUV9+lwwp4T0XYHcIlNHc8Mo+oJNYhj1HUuYs6a+dWVM0maonkZt
         u7k9OVu0++WLjV4O7A0BjRafcDQ+9Sa/bObpeVZuAMgOPP+RxBrjNaBB7N3yM1dc7liP
         Rm2Q==
X-Gm-Message-State: AOJu0YxB0xDWYoKaIE8n0wMHin8Tw/u7N5uudvXgoB5Uv1sk80DxXOqK
        0pJY1En8JRvz8gDlU9WKgIpyVfGOOdSfMhZMBlk=
X-Google-Smtp-Source: AGHT+IHk2BvRm8j1jnDKBgP6SoHnZU3IlkoOaxXADvivuxuFYKi60dVBzJbBLV6p4YhMvkK40qUjlQ==
X-Received: by 2002:a1c:4c12:0:b0:3fc:7eb:1119 with SMTP id z18-20020a1c4c12000000b003fc07eb1119mr8203000wmf.15.1691501567467;
        Tue, 08 Aug 2023 06:32:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c214300b003fe407ca05bsm15171974wml.37.2023.08.08.06.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 06:32:47 -0700 (PDT)
Message-ID: <3fe9526f-6ef0-29bf-e45d-3e4eb6ba162a@linaro.org>
Date:   Tue, 8 Aug 2023 15:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] arm64: defconfig: Enable TI PRUSS
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, srk@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20230808130131.3081482-1-danishanwar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808130131.3081482-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 15:01, MD Danish Anwar wrote:
> The Programmable Realtime Unit - Industrial Communication Subsystem
> (PRU-ICSS) known as PRUSS, is a low-latency microcontroller subsystem
> used for industrial networking and other hard real-time functions in
> the TI K3 SoCs such as AM654x, AM64x.
> 
> AM654x-EVM, AM64xx-EVM, and iot2050 use the PRUSS driver.
> 
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

