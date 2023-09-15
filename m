Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE867A169A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjIOG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjIOG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:56:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9751A271D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:56:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99de884ad25so244042266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694760966; x=1695365766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltJuwa423HiOTIp2QE2F7B4IlgvNgI+I1HiwiC0w6k0=;
        b=pjMoU+ZwLr4ExweTVifcnRyLVL/V+RU221cWKHg2lOC0168+UqJP+SXwFU9t4zUZ+H
         RmBzbNXQWO8E3G7T/KxQGhFvtb9s4PyMoAMq5pn2fo3VPpyNUys/SgyfWh7bH6hdK00D
         X5URPFBSIwXPcSIcPGKPqGFjfcnhAeHxxi9tLKaBJ0wYEPLzLKywKTYC02MdJLZQyNMz
         GhXMeYcYTkLixRWFbqODbtYZtwmHfX49Zc34GYKB1iISes2WkQ/zO7kRLlTWxal8dz+Z
         A69RQa9tPK+K3o+uH9uqAMfUmCehkEtduS3nYri9KVf1WD73/KQm1QX5WVtrH4BdmRBf
         8xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760966; x=1695365766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltJuwa423HiOTIp2QE2F7B4IlgvNgI+I1HiwiC0w6k0=;
        b=EDuOsowhP8N7S4U9i5aerDSv6w3jeyirIM+YYdGb/23xX5CMwsHuwDdy/5gVR2U3Sq
         BzsI9oUmDamZaWSN4M3bmsRTD6HjWb5OOKhzfrOIoPL6H/GepZ/wmKSfDh5JOoTmZC7o
         dsGBTSwXfIwapBBi62duzG90KFqVH7sgPOQ+5gbfHRcXlnpe9o3eHuOACzIq4M6u6qz3
         FrAywlw474uZm7vfcj5BPnkPDItrPdnx8gH7Gzbl37WPceB8hKcbMkgKfMmF8NM722m/
         hIhPtiffasFqbHL7JNvTCjAifGlQtD08lnSKBGrvx+lYOZlc+GdcWNbvULJMZGQjvRKM
         MQ6Q==
X-Gm-Message-State: AOJu0YyRkI+cPzqznFmgUBCpUwnVkArdcClYmEAoWEeZ5BGvWsELGChx
        cAfU07FHsDpdJIJz/9KmyAZWJw==
X-Google-Smtp-Source: AGHT+IHrYQakxC7i2ztZo8CHtMZzEPwiiHt2oaQ/EMEOa+o0maCDcZHF1ZYRrhEJTf32eaAsHra9YQ==
X-Received: by 2002:a17:906:1050:b0:9a1:cb3c:ba5c with SMTP id j16-20020a170906105000b009a1cb3cba5cmr570091ejj.68.1694760966103;
        Thu, 14 Sep 2023 23:56:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906080a00b00997d76981e0sm1973363ejd.208.2023.09.14.23.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 23:56:05 -0700 (PDT)
Message-ID: <232585f0-772d-36a4-02de-f2698ec7bb5e@linaro.org>
Date:   Fri, 15 Sep 2023 08:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] dt-bindings: usb: tps6598x: add reset-gpios property
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
 <20230912-topic-tps6598x_reset-v1-2-78dc0bf61790@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912-topic-tps6598x_reset-v1-2-78dc0bf61790@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 08:50, Javier Carrasco wrote:
> The TPS6598x driver supports an optional high-level reset GPIO.

What driver supports or not, it does not matter. The question is (and
commit msg should say) whether hardware has such reset pin or not.

> Document the new property and add it to the example.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index 5497a60cddbc..b1a621e06127 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -23,6 +23,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  reset-gpios:
> +    description: GPIO used for the HRESET pin.

This probably answers that yes - it is a pin in hardware...

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

