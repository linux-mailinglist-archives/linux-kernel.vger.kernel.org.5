Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8652B7C8844
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjJMPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjJMPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:04:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339BDBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406650da82bso21961725e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697209475; x=1697814275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2fXOeIOSxHCEJY2qt7THUklIs9H7amkjVqfQ6mRci4=;
        b=d04LvtvHBk5d6U+vr7tQHzJbpxa7oQU+tCbIOSJIWJ43Ojz8n2dSoIRXXFA4Db9CmP
         clhfbO9iFRB0Mixy9yCgytNdEQMnaorflZFyDPt0C0MW3Ffr7DaNfxQ8vCIN/wEEjniZ
         bEjpcwOlcI/wKsqFS2uGL5xwOhA5leX1WkY1uMqgTLTfPJIJIXnnjClLUJj2JzrIAZWR
         WvnLEyoG7s6VTilB4t5I94c5W/Xt550TPRXG7SR/CvGYbPBi3ZiM8WRPafX7Z37XnAuV
         aDOJZfJwKWRlnEiYIE6CFCoptmJdn021Mfhlt7PfUM8yCnNOMXoeZkKuoGjjNNL4e61y
         34RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209475; x=1697814275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2fXOeIOSxHCEJY2qt7THUklIs9H7amkjVqfQ6mRci4=;
        b=lWPRm2EzXqFlbjoqb7IAUVkWzupShvYqPc3RuZVGLfju0WaIi27DPAJNg2igIBY+kw
         O56f7NHoZ/bErFs6zj1j+KRBoQPsOBzi6tiILsaT07BoNdQyEVr30QNV/dH80jBHUw2C
         zPvQTR9rodJQ67yCOylC7DGKDUYWi22xY6fMNNL5RQG2x9X2LA8+6BnX4LnCTZhi4cml
         cKFBPWyL5Sc0JTgPgoPvkkr7A34vui5J1WydhHV0gIr7Kt15MuKBe53Jp/QGgkCTGaYn
         +1px8So0KD6LhdwgXosqXP1m4YKZHNvcZBfb5uU8/YxgfWfnL/m67KWF9qHEdI74PHa9
         Q5IQ==
X-Gm-Message-State: AOJu0Yz6YWYfgGxVD3a+K1R2K+8JzdjcU6U9N2VMzwObRYi2wicS5oJP
        JT2g5UxL3eDDnyQtEammCuWBjw==
X-Google-Smtp-Source: AGHT+IHkpkHn0nVBln6OE9hJD9E5VAEMlY+r3kNX7xH+hzWXZqyhUQPMpqPtmcndI6w6mxiR0Zsetw==
X-Received: by 2002:a7b:cb89:0:b0:401:b6f6:d8fd with SMTP id m9-20020a7bcb89000000b00401b6f6d8fdmr23348860wmi.6.1697209474868;
        Fri, 13 Oct 2023 08:04:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0040641a9d49bsm384403wmg.17.2023.10.13.08.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:04:34 -0700 (PDT)
Message-ID: <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
Date:   Fri, 13 Oct 2023 17:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1 master
 and MAINTAINERS entry
Content-Language: en-US
To:     Kris Chaplin <kris.chaplin@amd.com>, thomas.delev@amd.com,
        michal.simek@amd.com, robh+dt@kernel.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231013093109.37165-2-kris.chaplin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 11:30, Kris Chaplin wrote:
> Add YAML DT Schema for the AMD w1 master IP.
> 
> This hardware guarantees protocol timing for driving off-board devices such
> as thermal sensors, proms, etc using the 1wire protocol.
> 
> Add MAINTAINERS entry for DT Schema.
> 
> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
> ---
>  .../bindings/w1/amd,axi-1wire-master.yaml     | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> 
> diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> new file mode 100644
> index 000000000000..41f7294a84a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/w1/amd,axi-1wire-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD AXI 1-wire bus master for Programmable Logic
> +
> +maintainers:
> +  - Kris Chaplin <kris.chaplin@amd.com>
> +
> +properties:
> +  compatible:
> +    const: amd,axi-1wire-master

That's a quite generic compatible. axi is ARM term, 1-wire is the name
of the bus and master is the role. Concatenating three common words does
not create unique device name. Compatibles are supposed to be specific
and this is really relaxed. Anything can be over AXI, everything in
1wire is 1wire and every master device is a master.



Best regards,
Krzysztof

