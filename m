Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3478E882
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjHaIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjHaIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:41:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71739E54
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:40:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so641919a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693471248; x=1694076048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oj9ZHh9uIvpj0ERp23NgRxjtB8A/WDYvtNWK07v2zI=;
        b=GN31XdmsfylTAo9cekW7yHl9SPIoQSERRZqVvKX9ghQGtgDJrGlRz72VEqdZXW6KCD
         TtnuLvFmoP0XGAFsX5cT+TMz3drzgOAeUgx/c3pmaz+WMY3R3+RQ7CpfUIZ32cFL4icK
         6ScXCJ29qa51V0/1izVjKUZ3ek3oikYN4S+v/x6/ZiyOuv8WDTVaP38jZAO5wHr5eRzN
         AQKMpLrCvgPkLdGkbg7OUjFop5/cYIffoh2Vc7O4BWPEEhU4rmYqMCgdtsWWNQUAleSq
         9ZSDAv3krMlnkFB4+5zA3usrBssuvJNCiTgJ9U7v6f/tTE7Wv9uj9TVZGAkaLlBBAO+w
         h9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471248; x=1694076048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oj9ZHh9uIvpj0ERp23NgRxjtB8A/WDYvtNWK07v2zI=;
        b=Zz9adQtW6Ge+3vxj8cB5QTFvyzSDR4v/vDCTcIUjSCa3TvavTPWHDXq2Y267gwcR+6
         6JHKvqGOkBNIYYpbkb/VpTL7GnD4NwGBXF961xS7qVD7aT/YmgKfrheQouaAYryVPV0P
         g1a5llkzFQa83+fD/vY9YFxKzMJdMsH8BZADaxO6vo5NZDL0nzSUeNc3pm0DaTLZGUTT
         1D/ALiHZmAz8NRLWPOdAhpEwtz8ayVGpdtNh9sGNFqnhKOmJfKZi2hosq9+4pIYH7FLF
         4hSFbvoMcwv/h7NoIXxs2+lRig+Fq9XO8Lm+NjwjWghc04FvYBfJqjyLovdUcTmBO7gF
         76SA==
X-Gm-Message-State: AOJu0YxcO+5vqwvlatTTjAjcRRPh7kWtF6LCkwBIEl1vNpPHa+yGxUgi
        wMEBSkUbX+ZR3j8Q4Wy35lfUow==
X-Google-Smtp-Source: AGHT+IEC5YtV2U2cEklN+/jylIkWH4T7gor9vRqdxcg0xCCXWtlM2PpTXI6h2lSgtqlfrGIVvathzQ==
X-Received: by 2002:a05:6402:646:b0:526:9c4:bc06 with SMTP id u6-20020a056402064600b0052609c4bc06mr3431058edx.18.1693471248160;
        Thu, 31 Aug 2023 01:40:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
        by smtp.gmail.com with ESMTPSA id l22-20020a056402345600b0052c11951f4asm522481edc.82.2023.08.31.01.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:40:47 -0700 (PDT)
Message-ID: <1cc2c8f8-1f9b-1d47-05d4-9bcad9a246cd@linaro.org>
Date:   Thu, 31 Aug 2023 10:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-5-keguang.zhang@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830134241.506464-5-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/8/23 15:42, Keguang Zhang wrote:
> Add two new F: entries for Loongson1 Ethernet driver
> and dt-binding document.
> Add a new F: entry for the rest Loongson-1 dt-binding documents.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V3 -> V4: Update the dt-binding document entry of Loongson1 Ethernet
> V2 -> V3: Update the entries and the commit message
> V1 -> V2: Improve the commit message
> 
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff1f273b4f36..2519d06b5aab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>   M:	Keguang Zhang <keguang.zhang@gmail.com>
>   L:	linux-mips@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> +F:	Documentation/devicetree/bindings/net/loongson,ls1*.yaml

Why not simply squash in patch 2

>   F:	arch/mips/include/asm/mach-loongson32/
>   F:	arch/mips/loongson32/
>   F:	drivers/*/*loongson1*
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

and 3 of this series?

>   MIPS/LOONGSON2EF ARCHITECTURE
>   M:	Jiaxun Yang <jiaxun.yang@flygoat.com>

