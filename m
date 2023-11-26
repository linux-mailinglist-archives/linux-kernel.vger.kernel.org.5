Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C527F9570
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKZVLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZVLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:11:16 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D71DE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:11:22 -0800 (PST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BB6E3F887
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701033081;
        bh=rvglDuo/fTyCEy2eZikNSrK0RCDTjL208TqZkqJiFe0=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rF7ZL7DWiOlmkxo5D3tdkHBrCdRXfkvw96tgfpCD14Ze5W+t0jdbaCZEWE1WME1ze
         BYm/0ssQxpd0s/L//45wZUhefP9tNN+FGybnA8UUgSjS0IKBl3rthEQ4hBXqpRCr/S
         eE25Wd/3jBzxQQBoRk62UY4mzcgen5sdmuoOW4tmFX3ISQEfsmN0B7pw0pC6XrxYoP
         Kn6isA86eVuMirIbDsSW8TiV0v/eGP4zpmLGZFcQ9PQ56JZ+rxLN6LjmNPTuxmea25
         DU1jqct1r65uOFUeKY40iyU9kNsUMn/qsGvPB/pf4E7khheApsA7qZ2rjmui0En04q
         gsdXNeviD4Kyg==
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b397865606so88380639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701033079; x=1701637879;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvglDuo/fTyCEy2eZikNSrK0RCDTjL208TqZkqJiFe0=;
        b=eghEvmrymyaaYkVT/8XxYaHM5/J3QvZbNpHCp1U0onQ0HB1J2FiVUZnD4C0N4mGXVA
         nVAckpzPY7LWC25AF0S/KEJaQTEOxE9ADpMjRn4WpPELbkVPNCpHFEPzqhAj+11aL/Tu
         6cgbitJFMzoh/hWbfk7jyu3iCw9GKxtHyIntnthATU+u4nZVfMigm1XTpG2QKI6WuyWr
         nPJrU3cQkjXeGZgYT+XLrV1sBJRMVa0heSCqXlakq8mSUp//mj+BrWz7bNS6NxIB9II9
         ois/TIXkon9QcEeSrGo0qQdyemM5E2v7CCRTMGr4ycFvZPETn8bZ0stFMu7BNvgB7WuR
         OHpg==
X-Gm-Message-State: AOJu0YxLyaJXi/RCGSd+0feOLI69mwEOF4zrJ8NqzQ6JRSNv0gZcNHMu
        fmSENcLQeTriAru59MqSk4+KF/6ItSAyQHtNCJAaYHLzx29U4L+HFDCiMMkpDM3g9rvi8NSTDPD
        gUECL4nzyzNby8SDaoFkI3qKYkriCFpOxyNjr9rFTqPKL8LpqTdCh58zesxuoxOjaLg==
X-Received: by 2002:a0c:e241:0:b0:679:2f94:865c with SMTP id x1-20020a0ce241000000b006792f94865cmr10212344qvl.2.1701033058748;
        Sun, 26 Nov 2023 13:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYWNxo8Vh6oRaTbtMwPUh8NeMnB/m/b1dccmMlQVlfIUn9lkEBCVo+foSjrK/Vattp6N8+q2aLZGzM4wRhZ9g=
X-Received: by 2002:a0c:e241:0:b0:679:2f94:865c with SMTP id
 x1-20020a0ce241000000b006792f94865cmr10212317qvl.2.1701033058505; Sun, 26 Nov
 2023 13:10:58 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Nov 2023 22:10:57 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
Mime-Version: 1.0
Date:   Sun, 26 Nov 2023 22:10:57 +0100
Message-ID: <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian Ciocaltea wrote:
> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> RGMII-ID.
>
> TODO: Verify if manual adjustment of the RX internal delay is needed. If
> yes, add the mdio & phy sub-nodes.

Sorry for being late here. I've tested that removing the mdio and phy nodes on
the the Starlight board works fine, but the rx-internal-delay-ps = <900>
property not needed on any of my VisionFive V1 boards either. So I wonder why
you need that on your board

Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
you still set it to "rgmii-id", so which is it?

You've alse removed the phy reset gpio on the Starlight board:

  snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>

Why?

>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> index 7cda3a89020a..d3f4c99d98da 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> @@ -11,3 +11,8 @@ / {
>  	model = "BeagleV Starlight Beta";
>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
>  };
> +
> +&gmac {
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};

Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
so why can't these be set in the jh7100-common.dtsi?

/Emil

> --
> 2.42.0
>
