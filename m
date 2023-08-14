Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA877C0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjHNTWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjHNTVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:21:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98310DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:21:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso6069174a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692040908; x=1692645708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZITc41fWR3jpgB8PGLmoYdFzSTWTyUb5ijn5aqBVuKA=;
        b=Rmv5FqZ/bQZ4IhDXE2ASVxBcmjvK9/iXAilJkM1X7EqPUtZiG9NxSfn0f62AamjobR
         ZTzoCXKzxSybbaYXeToCjfhpMjlp7EQAS9xNcd5gI0RIfGfMClf73JRfNWYB6VVhk3sD
         X+DP4ZV5RCZ/7/sr6YFDU6MnxKYmRJOeYnRJQRnv0P+1VycKLoGEefr6toLQcUqO2HyL
         t9v6OlIDpb0ivbEMri1vul9EeP74HiHxM4OW1MBzVQ1dKKg/kzl2ZeRibwNpFa4afifq
         El4Eq8vM9aa6AKPzRrfB3jMAfVKXFsOrRa5TEjqmoP6baWfO1QoLOJD+UfSl9Gp2T9Pg
         qydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040908; x=1692645708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZITc41fWR3jpgB8PGLmoYdFzSTWTyUb5ijn5aqBVuKA=;
        b=H0LIF/ZtmsYRS5WyBkTZ1C6az5diDpJad0A6PQ4SqtiZVUEGdfCcwJh4EUMmVeFqe3
         kjrkGZd+VxjhiyOCjtRNSnRySuMSrctia+WlR4keMKnGRz0Op4JB2QfuItUKYlPd59t7
         XrFRqMVHSPsZ16cT8o4hk9KX/LPU7mG9terALcZZtjcr2USxO6jP9Zved/BVzeQYa6Jy
         42bZevNeXyIj7tOgMVCs1NVhhjWpcbEuPAGOtrNeMFkDrVKmD2EH+afTm7bgtn/FF4iU
         wz5enTK3C9/8CmLBLcerM20fLBxWRnb2OG/CGcfJZWPOOnPOcM3EqxGM+ZM1veVw9F7o
         7lzg==
X-Gm-Message-State: AOJu0YwOnJYOcT62QmCBtpMlgtbfN88F0NgxZbR9ssZZFEQTo267u6vH
        YV3yCT206QDlFr/2BO38KwB4r6HHURhqW3ykVuI=
X-Google-Smtp-Source: AGHT+IGV02ywoYIQLLNfA9i2YcB4KVh0qjZBfknBTqo0YTqkYsSmO/usRrWcz1kIGi6jKLxPqCAn7A==
X-Received: by 2002:a17:906:74da:b0:99d:b7d4:3ac0 with SMTP id z26-20020a17090674da00b0099db7d43ac0mr2017146ejl.28.1692040907769;
        Mon, 14 Aug 2023 12:21:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id i5-20020a170906850500b0098951bb4dc3sm5932372ejx.184.2023.08.14.12.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:21:47 -0700 (PDT)
Message-ID: <8c7f28c4-ac9f-ee9e-e9f1-c58709ffaf14@linaro.org>
Date:   Mon, 14 Aug 2023 21:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-3-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810045314.2676833-3-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 06:53, Vignesh Raghavendra wrote:
> From: Bryan Brattlof <bb@ti.com>
> 
> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
> 

...

> +
> +		gic_its: msi-controller@1820000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> +			msi-controller;
> +			#msi-cells = <1>;
> +		};
> +	};
> +
> +	dmss: bus@48000000 {
> +		compatible = "simple-mfd";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-ranges;
> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
> +
> +		ti,sci-dev-id = <25>;

Are you sure this passes dtbs_check?


> +
> +		secure_proxy_main: mailbox@4d000000 {
> +			compatible = "ti,am654-secure-proxy";
> +			#mbox-cells = <1>;
> +			reg-names = "target_data", "rt", "scfg";
> +			reg = <0x00 0x4d000000 0x00 0x80000>,
> +			      <0x00 0x4a600000 0x00 0x80000>,
> +			      <0x00 0x4a400000 0x00 0x80000>;
> +			interrupt-names = "rx_012";
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};


Best regards,
Krzysztof

