Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E014D79CB41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjILJMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjILJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:12:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91E3170F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:12:47 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BBC73F65E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694509966;
        bh=XqCmz97wiINzvOoT4WgJ0jIs9/XOEFkVGg6FT5TVn8s=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AfP5do/6J5GIGAwXM5VWuPUlh1EAWHOhJdVtno3OjG1ctcBXJiQZatDq7avxUPtqc
         2lwZsaguzKfck41ndLSI+4HTawnb00sAKqFBUERkuZXcjCWUB4dPF10dulYGE95gMP
         8ymATo9/kgFeC5c9aD2/VGUFEXA76xfLUQlDNtRIeFuyPb9U3Zksy6yV6Cwvj8CJ3a
         qU6IBKt6cYWDnPFk693yUHf1D7W9ltKxNJ0bREg5Vi/ZXZPowZkl59OWjLP6EnIokN
         pNOPG38WgUVRro62gfOyFu7L6Cb+CxNMBv38r8n3xh5eyq9STldtYAzaqmPuHT2yLc
         SdvZWNjDZcZDA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4131d4bc82dso65565291cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509965; x=1695114765;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqCmz97wiINzvOoT4WgJ0jIs9/XOEFkVGg6FT5TVn8s=;
        b=WNoeRZWEuX0pbWWawYkZwLubYBZZQhOBNefYGDUv4DQyovgvof2WgHe33NDVBE87RJ
         iYbVKcCVXTtQSk4Tx3kAD82vbmSbH1hCvv8xJ25n2Y0Gr8KoXMfTotBhV0HAAaFkwePv
         /bA6cJxABz6JreE+FoCLXx1LJOVPGy+HgpM1/8gtLmcRW1NT2x//xeRaeTmJIIwEsErN
         y9gCFm7fuDvjOcZo4NQ48IN0QxSUzxf4laG7JL6PQ12xHh182qWJ5g3kbHzmgW2G269s
         OxoonG/N/CZOV+Ql7leaNFT9iKSjlFoz8T3W/KvRmc5SouvtE1j/chawdkaUpWziwZI0
         ZRXw==
X-Gm-Message-State: AOJu0Yyx1c3Fsh8dCRmP+ult/5/tyOWHVIarTt+4TJL7Q13x+o2pmaxS
        JP5Rm/JKJKd+fwUvU4xKzYMWHVw+nF/VoEsZp2oCSPHFBGpVDc8qVQcH6+zpld3zz4pJ7aZKGft
        1cz1iEIZGGvn7zGW4cQIcP82NMJTpAANcWlLlYA4W/KGSCPzJkGx9IDTSdw==
X-Received: by 2002:ac8:5a89:0:b0:412:1c5f:4783 with SMTP id c9-20020ac85a89000000b004121c5f4783mr15578477qtc.10.1694509965369;
        Tue, 12 Sep 2023 02:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQQlGlQgk/r9shaDmrB/tSYmyaL8Wp5LDCM9Gtr+QkolQC9uKaGfomkgojXdkeuMHTeIyAFpf8bRY5ZqnJUC4=
X-Received: by 2002:ac8:5a89:0:b0:412:1c5f:4783 with SMTP id
 c9-20020ac85a89000000b004121c5f4783mr15578458qtc.10.1694509965100; Tue, 12
 Sep 2023 02:12:45 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 02:12:44 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230912081402.51477-1-william.qiu@starfivetech.com>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Tue, 12 Sep 2023 02:12:44 -0700
Message-ID: <CAJM55Z_NjSVwCcS0MfHw3mAwsBuScAU0OXX1Ga1+TfQNHKB7Vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Remove properties from required
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

William Qiu wrote:
> Due to the change of tuning implementation, it's no longer necessary to
> use the "starfive,sysreg" property in dts, so remove it from required.

nit: again the device tree should be a description of the hardware, so the
justification here shouldn't be that the Linux driver doesn't use the field,
but that it turns out the registers aren't required for the peripheral to work
properly. Don't respin the series just for this though.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> index 51e1b04e799f..553a75195c2e 100644
> --- a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> @@ -55,7 +55,6 @@ required:
>    - clocks
>    - clock-names
>    - interrupts
> -  - starfive,sysreg
>
>  unevaluatedProperties: false
>
> @@ -73,5 +72,4 @@ examples:
>          fifo-depth = <32>;
>          fifo-watermark-aligned;
>          data-addr = <0>;
> -        starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
>      };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
