Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC77792C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbjHKPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjHKPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00AC30E8;
        Fri, 11 Aug 2023 08:18:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe655796faso3366158e87.2;
        Fri, 11 Aug 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691767111; x=1692371911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2Azdm+Z9WDL6vIrfXuT+H5mK8T/u1u/omx6m7wli9A=;
        b=S6HKyWMQSYb/qxWb7XKpbyw8KlETPf8/o3PUYYurRQsSNAP3edzO7cAfKdG0Mc4fRN
         5xpYSjkOlnODCwNxmKkg2SJmGxw/UGFlioKDQx8oitl+mvaMBmq2OPJhYCW35Ug3dDUa
         O9UVjdVaKDm+wqoQOc5eGPx/CXfTp9Z9HN/+t69yTRlmNNxqqxqN9HfcF3KfA2JC/SK4
         vE9hKFeUgYNOJ24BACL8enfTX88zeMm9vn+H2XdmyJ8Ib/d36KoVC+pAkr7qHbCSrtlS
         3nU2VTWYC7rBGPkK37DrQU+cZ6bpdLAcERy6MObrchoFKA4AKAo5MIskbH3wmOdXunb+
         4oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767111; x=1692371911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2Azdm+Z9WDL6vIrfXuT+H5mK8T/u1u/omx6m7wli9A=;
        b=cGhGPkimpSkHWJekE+xT2AKlXuqsPAYwcsi+cSDOBn4bAmqfTwiHfAvFSzRWdFVFBK
         FCiduLyM1ckdPiehPF7xMdMAGIeJVutyvg8FHn6JiBc1rRouSDv0kZQYyiTQBNmS8WTA
         v9rH6k3lfQjjGtSMLnulzm8sfNanC0KszEw0BfTIIuXCXY6mskW62plG2XnS0VaG5oO6
         j5y8SYRgwaNJA009wSQ8/57l/VNDZC1bNwEL6yYyawDSkDnjzfdd7t+d4QIpMSheeaZS
         5AxDpE1sJY10xni9/JYycql4KY7k9jgSa3H0UtlH5DR99x18Al0SvZq5g52e3PSw60B+
         QY3A==
X-Gm-Message-State: AOJu0Yw9zUwSbr8V1AapZFYulkEhMGIzFT5Nbk3QybcY9A1coezMSr95
        pGHzLr3b2Tyn6obFmNcSrLw90jnWBwZQvj0y
X-Google-Smtp-Source: AGHT+IFW9eRKAQpO8COZ8RJXWaaOstMf3+q6RMdsZOGs2SqykOGizzTx7XxCoH3fk6KzrxFfznJ0Gw==
X-Received: by 2002:ac2:4ecc:0:b0:4fb:9d61:db4d with SMTP id p12-20020ac24ecc000000b004fb9d61db4dmr1584007lfr.18.1691767110914;
        Fri, 11 Aug 2023 08:18:30 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm756424lfi.3.2023.08.11.08.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:18:30 -0700 (PDT)
Message-ID: <cb5e3bbe-19d4-4989-adaf-5b7827982184@gmail.com>
Date:   Fri, 11 Aug 2023 18:20:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] soc: ti: k3-ringacc: Add additional register regions
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230809175932.2553156-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230809175932.2553156-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 09/08/2023 20:59, Vignesh Raghavendra wrote:
> Ringacc on TI K3 SoCs have configuration registers region which is
> usually hidden from Linux and configured via Device Manager Firmware
> APIs. But certain early SWs like bootloader which run before Device
> Manager is fully up would need to directly configure these registers and
> thus require to be in DT description.
> 
> This add bindings for the cfg region and also adds them to DT files.
> Backward compatibility is maintained to existing DT by only mandating
> existing regions to be present and this new region as optional.
> 
> Nishanth: I am hoping its possible for you to take bindings and DT
> via k3-dts-next once reviewed.

I have similar concern/question as for the DMA side, let me copy that
here as well:
These regions were 'hidden' from Linux or other open coded access for a
reason.
If I recall the main reason is security and the need to make sure that
the allocation of the channels not been violated.

IMho the boot loader should be no exception and it should be using the
DM firmware to configure the DMAs.

Or has the security concern been dropped and SW can do whatever it wants?

> 
> Vignesh Raghavendra (2):
>    dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region
>    arm64: dts: ti: k3: Add cfg reg region to ringacc node
> 
>   Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml | 9 +++++++--
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi                 | 5 +++--
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                  | 6 ++++--
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                | 5 +++--
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi          | 6 ++++--
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                | 5 +++--
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi          | 5 +++--
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi               | 5 +++--
>   arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi         | 5 +++--
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi               | 5 +++--
>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi         | 5 +++--
>   11 files changed, 39 insertions(+), 22 deletions(-)
> 

-- 
Péter
