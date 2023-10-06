Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C277BB5CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjJFLDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjJFLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:03:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95FDB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:03:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564b6276941so1424943a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696590209; x=1697195009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxFEgt05/Om310YXHqztn12qfKEglhAS71n4alSmu1w=;
        b=e3yUzQd8CmCbQ6hVTGYl4tVVxHeaJ56vwmjPNSrfz0ZxwgR7/DmL8g5lD3NedI1n7C
         Va3Nu0iNwHN9UEmIikDyvuaAnh93aYttSGzY00gxtNCOGNRdaLW18pIHAG1Irk+zRa/g
         EjCImSUFFq7BgSizT8B0hL2tP7Li2r8uHu16iD1bBMLy280sy1QvE4arWyll6pk83X3i
         OLa8rEzwJ0VrNv3GiUZgJSmRy2vY064xZtSFk/Vot0bfY7WR9SDNvE0P3o8biFnG62vy
         GxnlALWDMk1tEha2x8nueu+5vzWiCmoJrW9XKJHJw0tdcSAHOc8axaOOcwNlWqw7M7r0
         QqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590209; x=1697195009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxFEgt05/Om310YXHqztn12qfKEglhAS71n4alSmu1w=;
        b=eXjBWJUdb4sks9z4yXhM80IpAs8qgDcLA6VxMNRARFe2e8A3LE6/gkkhvpfRn17eqP
         osBdiY5yFgFoOG3joleYcI7g5mXwyKhkblD0tMH2nuDJSvLRmKNCbC6eLhHoZG5Sbvzm
         9Hg/+s3wmGRskEehbY5Iru1WM56y1HiWIo+TMI9bhz1XtsT6ahe/hb0eCqjR/g2OpAl5
         qrJSsMR7BEwiaTkfI24faY6fMBBYIRVb6Km8Zo2aC34TlCbVYPUKpxka7nPQCEhWv4lI
         XihGnfSzecHg8uHuscteXVREqcWFtim5za9L+ZRUMqIBqLWq/kzw0EQPwoYBZn+Roq8d
         Bu9w==
X-Gm-Message-State: AOJu0Yy5Yt5+7Ut4PvDryuiVxUg938wnt6JuwlIKV1lKrpUhbN4I6ncN
        bhi5/t4Kt4TxSbnXmKLiBtliPTxP+wvb1IJDvkbFSw==
X-Google-Smtp-Source: AGHT+IGMeleG8BhIDxGOoRXVXqrxaKbP2xb5o3A0nxBRYxw9lKmKLkt+Rpnbik0fai3k1AB+dOAJvhFzxodtaomXtss=
X-Received: by 2002:a17:90a:9513:b0:269:46d7:f1db with SMTP id
 t19-20020a17090a951300b0026946d7f1dbmr8304821pjo.32.1696590208682; Fri, 06
 Oct 2023 04:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230929133754.857678-1-lcherian@marvell.com> <20230929133754.857678-2-lcherian@marvell.com>
In-Reply-To: <20230929133754.857678-2-lcherian@marvell.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 6 Oct 2023 12:03:17 +0100
Message-ID: <CAJ9a7VhzARGmywQFPNCZ27D5UKEEPSR9_hmL5fo3daFWpB26Vg@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: arm: coresight-tmc: Add "memory-region" property
To:     Linu Cherian <lcherian@marvell.com>
Cc:     suzuki.poulose@arm.com, james.clark@arm.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sgoutham@marvell.com,
        gcherian@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linu

On Fri, 29 Sept 2023 at 14:38, Linu Cherian <lcherian@marvell.com> wrote:
>
> memory-region 0: Reserved trace buffer memory
>
>   TMC ETR: When available, use this reserved memory region for
>   trace data capture. Same region is used for trace data
>   retention after a panic or watchdog reset.
>
>   TMC ETF: When available, use this reserved memory region for
>   trace data retention synced from internal SRAM after a panic or
>   watchdog reset.
>
> memory-region 1: Reserved meta data memory
>
>   TMC ETR, ETF: When available, use this memory for register
>   snapshot retention synced from hardware registers after a panic
>   or watchdog reset.
>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>  .../bindings/arm/arm,coresight-tmc.yaml       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> index cb8dceaca70e..45ca4d02d73e 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> @@ -101,6 +101,22 @@ properties:
>            and ETF configurations.
>          $ref: /schemas/graph.yaml#/properties/port
>
> +  memory-region:
> +    items:
> +      - description: Reserved trace buffer memory for ETR and ETF sinks.
> +          For ETR, this reserved memory region is used for trace data capture.
> +          Same region is used for trace data retention as well after a panic
> +          or watchdog reset.
> +          For ETF, this reserved memory region is used for retention of trace
> +          data synced from internal SRAM after a panic or watchdog reset.
> +

Is there a valid use case for ETR where we use these areas when there
is not a panic/reset situation?

Either way - the description should perhaps mention that these areas
are only used if specifically selected by the driver - the default
memory usage models for ETR / perf are otherwise unaltered.

> +      - description: Reserved meta data memory. Used for ETR and ETF sinks.
> +
> +  memory-region-names:
> +    items:
> +      - const: trace-mem
> +      - const: metadata-mem
> +

Is there a constraint required here? If we are using the memory area
for trace in a panic situation, then we must have the meta data memory
area defined?
Perhaps a set of names such as "etr-trace-mem", "panic-trace-mem" ,
"panic-metadata-mem", were the first is for general ETR trace in
non-panic situation and then constrain the "panic-" areas to appear
together.
The "etr-trace-mem", "panic-trace-mem" could easily point to the same area.

>  required:
>    - compatible
>    - reg
> @@ -115,6 +131,9 @@ examples:
>      etr@20070000 {
>          compatible = "arm,coresight-tmc", "arm,primecell";
>          reg = <0x20070000 0x1000>;
> +        memory-region = <&etr_trace_mem_reserved>,
> +                       <&etr_mdata_mem_reserved>;
> +        memory-region-names = "trace-mem", "metadata-mem";
>
>          clocks = <&oscclk6a>;
>          clock-names = "apb_pclk";
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
