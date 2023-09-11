Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9779B836
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354251AbjIKVxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbjIKKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:48:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE2F0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:48:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bd6611873aso67658291fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694429289; x=1695034089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0NJnWblCqOTP51XSAQK8tnzGeOeFatQIb5bjkiY0jA=;
        b=v+MMXu9/Q1EbdaSF3eYLtAp3lF94CqGqA3sve3d/m1Fd/mygRY+QeGZN3sgYRRagnZ
         K0e9BPcvxCOPoD22avX4y5W5KithIUurrMk9RwSrMndiVj2WSWMPfgvfeaIIaSbRvmdp
         UdY7Vmx0jKbDo3+4Qyn+KlzgA128jSSpnfXCDksBuUhg2qNT6SHQ1bz/2vgWQYnBStTa
         Nk651GUm6xGq0Z99Lbz3Wtun6+vt/Sd1Y7tcqf0sikLI6/UKs4AdWXAFLkJVtDFzZr3Z
         ekM+gkToHm3Z/GJ8Q75rDI/oRAM68QWJu5bowbMVjEmshCHnhql/fO1/ix/lkFOU5sqD
         51+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694429289; x=1695034089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0NJnWblCqOTP51XSAQK8tnzGeOeFatQIb5bjkiY0jA=;
        b=lVXwhD6xsc4N2wgRPlyE4527smD/RfQmqsc1DQthr9Ic40sG7884yjR1UM2uKYyVAX
         JznQNKh8aEKTnB5ilPKxjue+kSkQwy9IxrtDzcPKh3eScDAmtlSZlJz0tjVd1UH37bFA
         IerHH/ognY+sIBHJjCvljLaAKlC3DThUyH9WatAIY/LTA7/vuu46V6+M9qxfDxgMNttO
         6dGAHh5u0lcNdiDGcH5Z3YFi8Imk+NIP4s+Zh7C+jqo2RMclleSoNUgM/Ndj1xi6Dz3X
         F6X7n+SRvJQqhbSmhDOCa3Fn2ALzvJXIQ2bkQFTrkzuhUZG4X5CMhRn9vzFmAOS90YV4
         dwhw==
X-Gm-Message-State: AOJu0YwZ5xS3vYwdR/GM/sGCKIEYeMs2rOt/zS3ISqNE99VSd0wwJQem
        EhuYyBE/C/wc68elE9ojadYmtQ==
X-Google-Smtp-Source: AGHT+IF1kWFgjhTcfyqVhPg4mnrxV5lAVUVkKc0L/x88oGcAPqEy+maF7vc3htIrGNZH5i4r3ZmbAQ==
X-Received: by 2002:a2e:9a86:0:b0:2b9:d28c:9c2d with SMTP id p6-20020a2e9a86000000b002b9d28c9c2dmr7295461lji.23.1694429289253;
        Mon, 11 Sep 2023 03:48:09 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr. [176.171.221.76])
        by smtp.gmail.com with ESMTPSA id rp26-20020a170906d97a00b00988be3c1d87sm5122443ejb.116.2023.09.11.03.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:48:08 -0700 (PDT)
Message-ID: <c94138d2-1bfa-2815-a766-b7904e35a86f@linaro.org>
Date:   Mon, 11 Sep 2023 12:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
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
 <20230830134241.506464-4-keguang.zhang@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830134241.506464-4-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/8/23 15:42, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> Partially based on the previous work by Serge Semin.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V3 -> V4: Drop ls1x_dwmac_syscon definition and its instances
>            Drop three redundant fields from the ls1x_dwmac structure
>            Drop the ls1x_dwmac_init() method.
>            Some minor improvements
> V2 -> V3: Determine the device ID by physical
>            base address(suggested by Serge Semin)
>            Use regmap instead of regmap fields
>            Use syscon_regmap_lookup_by_phandle()
>            Some minor fixes
> V1 -> V2: Fix the build errors due to CONFIG_OF being unset
>            Change struct reg_field definitions to const
>            Rename the syscon property to "loongson,dwmac-syscon"
>            Add MII PHY mode for LS1C
> 
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>   .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 ++++++++++++++++++
>   3 files changed, 231 insertions(+)
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

Squash:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index ff1f273b4f36..2519d06b5aab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
  M:	Keguang Zhang <keguang.zhang@gmail.com>
  L:	linux-mips@vger.kernel.org
  S:	Maintained
  F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
  F:	Documentation/devicetree/bindings/net/loongson,ls1*.yaml
  F:	arch/mips/include/asm/mach-loongson32/
  F:	arch/mips/loongson32/
  F:	drivers/*/*loongson1*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
---
