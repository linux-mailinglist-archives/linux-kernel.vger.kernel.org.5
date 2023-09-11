Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABE79B565
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbjIKVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjIKKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:47:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517BEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:47:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a9cd066db5so543018866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694429237; x=1695034037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZtKfEYhqkPEDT7kYfKYKbjw5LAGLLC/AvM8pJEf11E=;
        b=xMOvJXilFyyddQuAECxFjaERWGdJHTWK6+fXZdjb2zp5PY05hk1qDFnpyQcfVExsMZ
         nwHnNIoFCl0YQhw4ZdZuQodkthi3vXGu50c1axLZmOWBEKbtzOE0FRDNINP+mdOL8FNl
         rw1f4UUV7caMl7WsK7x2DoL8FKIDx60FvJNd7vt+eboIF33WyU2OdxhZ31MtYOHa+u97
         lmOGwY3tyYvQmdeSBjX1gWIN+eaknKkYCwonfx0FXFQFxI6cGS/00xkBh0fLbDEde6F+
         kgcywLooTxy3XVXc3wcQYOCN45Rop8PW+Y9xeAWPt2iZakUymtDB2JBWPWtoAMluLN+V
         xb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694429237; x=1695034037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZtKfEYhqkPEDT7kYfKYKbjw5LAGLLC/AvM8pJEf11E=;
        b=EJ+t9qiXB+srH5ckyaOpSpdAvfImMkf3mYXJd0gTR9RDtgecRmmEjuWgtIACcJxRAr
         yZpSQRixVbPyomJ/Lil1Y+Ol+R/+MSup54hiBkKdj2rfvtE5B+vmKnFQHzu7o4E4APmN
         JVl6m7RIWR5b7UULFlQhDeW6u4rhAKjyvY7G0vhp8+roPKhrlZD/92bjo1vGUAH0GLEn
         gHWgfK7zxODYEfAWp9YjQg+YLQcz1v3+yVi+AlRAyE6I+KMmj3/AP01iJPFIhRnxPYeB
         N0p61sx4U5kxQb8VO+YgRkhppX5de9JvS5RXZkwzW04evDi3a2IysTHj/dBObyY4NyyQ
         1IBA==
X-Gm-Message-State: AOJu0YxWiUgd5YbKHHhAoodc1SPswq0X+HTN//wTWJ7lHLaWPWytrb19
        azCcNYrfDwGwN5WdKTR/XwFP3Q==
X-Google-Smtp-Source: AGHT+IEhCVG0bDd8mw7oaQ/AnTyRP9aiXmQy/pIVwW3hSWYCQgiB8WukqJX3T6/6fJbc20K2QFegwQ==
X-Received: by 2002:a17:906:5db4:b0:9aa:e13:426a with SMTP id n20-20020a1709065db400b009aa0e13426amr4779637ejv.73.1694429237522;
        Mon, 11 Sep 2023 03:47:17 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr. [176.171.221.76])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709062b0700b009a1dbf55665sm5164198ejg.161.2023.09.11.03.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:47:16 -0700 (PDT)
Message-ID: <5afdb9b9-e335-a774-fccb-d64382e02d07@linaro.org>
Date:   Mon, 11 Sep 2023 12:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
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
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-3-keguang.zhang@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830134241.506464-3-keguang.zhang@gmail.com>
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
> Add devicetree binding document for Loongson-1 Ethernet controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> V3 -> V4: Add "|" to description part
>            Amend "phy-mode" property
> V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
>            and loongson,ls1c-emac.yaml (suggested by Serge Semin)
>            Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
>            Rename loongson,dwmac-syscon to loongson,ls1-syscon
>            Amend the title
>            Add description
>            Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not sure)
> V1 -> V2: Fix "clock-names" and "interrupt-names" property
>            Rename the syscon property to "loongson,dwmac-syscon"
>            Drop "phy-handle" and "phy-mode" requirement
>            Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
>            to snps,dwmac.yaml
> 
>   .../bindings/net/loongson,ls1b-gmac.yaml      | 114 ++++++++++++++++++
>   .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++++++++++
>   2 files changed, 227 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
>   create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml

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
+F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
+F:	Documentation/devicetree/bindings/net/loongson,ls1*.yaml
  F:	arch/mips/include/asm/mach-loongson32/
  F:	arch/mips/loongson32/
  F:	drivers/*/*loongson1*
---
