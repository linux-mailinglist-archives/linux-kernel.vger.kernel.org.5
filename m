Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569A7B9FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjJEObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjJEO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CB6A5E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:31:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so616496f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696487493; x=1697092293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5W+5km9oY3CezrKFXltA7PDU8akry8lgWTdEDkyo4E=;
        b=JqZhlby9mRmDNUZGRtv+4Pxy/lzBHMDdoHmYzJUq6kzUP96peVrOBWHILfG9B6Pvjq
         rmHCIREdLx4x6mO7bcFQpcOPM3r4UeiFvY7Q69c1vO0J5ZeW0SsMJ6SuQxB6urD2qPWP
         MJpGPFviPlF3b7j3YLy45WOQbnkxoOPPMbWUjMQuGfgPWqxxa1Ve1cSRea1e5Bn2wuA2
         DSY68wPIVpfIqM+hVDrsZQnNx/DhUbDp0yKIcL2Anpb+TvGM7ljBbOEfYxU/4KdFSPXk
         an4AwXFIiRBUsk8qrDhJG9HPRTCysuQrW+bjJjqq0U7Yobfq/+Es9kH0pEx6wMue/It7
         OTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696487493; x=1697092293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5W+5km9oY3CezrKFXltA7PDU8akry8lgWTdEDkyo4E=;
        b=q3Hd6kATvZS2xskMKYh3fRfnEj4bVZo3iIV8NhwPwXpx3UfySuFxxFpdaOyLer+t9r
         K8A+b6ayya/qGltdbp7RzBegT/hiLj7hzfkK1KxcrOgMzLSyUfEBs0Yz5YTxMEc0Mx/D
         RMYvfBW+8EzBaVIeBt/gbJ8oi3m9RbjTna/SlEX9T4DFaApC1s39bOZqnyQnwMruB3CG
         lxXnDWJUQC4Tf4rdL4oVhQ4tUGKPU5uvrU4b/Za3lRIVxDHrDPqz32daiJX/CtnBzLgt
         nlQpbkf1r0B3dh53eH0qwL4zDdE1D4U/xVROSnw77PbMfQteQ3htqweM4BDCgR0IiG3J
         WUVw==
X-Gm-Message-State: AOJu0YxnUMg0tMXMoXzR1Bb0kgxvrdwsuS4n9rK1INOj/dXuJNrKnirK
        O98Hw998MzesLrKsVnuOR7jwNA==
X-Google-Smtp-Source: AGHT+IF4ixdIQfW3FK081CqPPePUbhMJmhpRDt6pintjSlT07UJabiR7lKPTEYKF9KJP1v7iLMdJUA==
X-Received: by 2002:a05:6000:100e:b0:320:485:7010 with SMTP id a14-20020a056000100e00b0032004857010mr4128536wrx.67.1696487493496;
        Wed, 04 Oct 2023 23:31:33 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
        by smtp.gmail.com with ESMTPSA id y17-20020a5d6151000000b0031f82743e25sm939874wrt.67.2023.10.04.23.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 23:31:33 -0700 (PDT)
Message-ID: <ebd12a11-551f-f66b-293b-f7fc2dfee31d@linaro.org>
Date:   Thu, 5 Oct 2023 08:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
Content-Language: en-US
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004161038.2818327-6-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 18:10, Gregory CLEMENT wrote:
> The MIPS Warrior I-class I6500 was announced by Imagination
> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>   Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


