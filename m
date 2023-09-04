Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA9791CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbjIDSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjIDSSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:18:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB113E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:18:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso263632166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693851491; x=1694456291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKdwNWdd8MKIUtzO2CwHBtHdaVpj3bj4pqyGolLxsu8=;
        b=KUNCtchTXWdY/kHdX8btydtBLPiom7PvHGyQJdpKkBLYo7yTECJE3JPX5U6nAhDosA
         GwnqiKc3xsQBDB60Whv5OxKDYa8+q1m++w+s9fAIhFL/Ck1cwBUMEAokgPoSY2xrVa3U
         xItbMZo5dAW9FHT/UGt2MtQCRZyota3pD4Q88G6Wt9C99ucnJR72BDY5EtjcRmWSQABK
         b10zMZ2ICbWUBFBijbVIXz9K3w0wxyMYV9pNhCqYr5wKSG82jnccxzn35T3d0tjknSow
         d6ee5vnJSTi7e2pauthyi9j+799zs5uLWsTiAU1XJFDnifyENZtW9bp7aas65X0D0KHw
         Rphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693851491; x=1694456291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKdwNWdd8MKIUtzO2CwHBtHdaVpj3bj4pqyGolLxsu8=;
        b=FSOtUQ8oRpwPGrK3wjlFA2IpRbimDd8ayL5QQb5Yku1G4dHDW3EJDIdxiOEe4w/Tus
         bVWe73reH2ArVJXbVOCm8qrM2pYP+jkXS+mkLxguzAO464BI9bAcaCia6AidQd/pKvaW
         7XC3xdvvDtrOTj/ws81Qvf77/w8wrIjYOAfFUHEuHOJibyp84GxSLNq4ehcEqIHFBxd4
         ZQtPatJycOs2GIDmM5Yg9hVfjNFvW6OQKdZrkZO94DNFlndFa6hihbsvt/RlSbcI/S5f
         q/Tinl7/jSbL4aAGM12wMdRoMq43lzTPa2l9zXjnJu8MypkX4WunTFdqsE7YyynMyP4C
         WMaQ==
X-Gm-Message-State: AOJu0YzXaDIzRHJghAe9sAe7JNwV6GV2+gy2lzfUlqogu/OInq35ek6M
        ijaN3Uptc+5I5VKG5CXtJxerRA==
X-Google-Smtp-Source: AGHT+IGKLkmv5ey9l6v+EY5Cixdjp6lyK40R0g9Sk3lM038cen/kxOs67ppzIYPrUNriEEno9Bf5OA==
X-Received: by 2002:a17:906:220f:b0:9a2:c5a:6c9d with SMTP id s15-20020a170906220f00b009a20c5a6c9dmr7859251ejs.62.1693851491536;
        Mon, 04 Sep 2023 11:18:11 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906264400b0099bcd1fa5b0sm6508035ejc.192.2023.09.04.11.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 11:18:10 -0700 (PDT)
Message-ID: <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
Date:   Mon, 4 Sep 2023 20:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: RecursionError when try to check bindings (ubuntu 22.04 /
 Python3.10)
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
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

On 03/09/2023 13:08, Frank Wunderlich wrote:
> Hi,
> 
> i tried to check a binding-file with 6.5 kernelsource and get this error
> 
>   GNU nano 6.2                                                            dt.log
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> Traceback (most recent call last):
>   File "/home/frank/.local/bin/dt-mk-schema", line 38, in <module>
>     schemas = dtschema.DTValidator(args.schemas).schemas
>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator.py", line 354, in __init__
>     self.schemas = process_schemas(schema_files)
>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator.py", line 271, in process_schemas
>     sch = process_schema(os.path.abspath(filename))
>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator.py", line 248, in process_schema
>     dtsch.is_valid()
>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/schema.py", line 145, in is_valid
>     for error in self.DtValidator(self.DtValidator.META_SCHEMA).iter_errors(self):
>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 242, in iter_errors
>     for error in errors:
>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_validators.py", line 362, in allOf
>     yield from validator.descend(instance, subschema, schema_path=index)
>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 258, in descend
>     for error in self.evolve(schema=schema).iter_errors(instance):
> 
> block from line 242-258 repeats many times (~2000 lines in log)
> 
>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 242, in iter_errors
>     for error in errors:
>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_legacy_validators.py", line 216, in recursiveRef
>     lookup_url, next_target = validator.resolver.resolve(each)
>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 835, in resolve
>     url = self._urljoin_cache(self.resolution_scope, ref).rstrip("/")
> RecursionError: maximum recursion depth exceeded in comparison
> 
> make[2]: *** [Documentation/devicetree/bindings/Makefile:68: Documentation/devicetree/bindings/processed-schema.json] Error 1
> make[2]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.json'
> make[1]: *** [/media/data_nvme/git/kernel/BPI-R2-4.14/Makefile:1516: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> my command is (after importing defconfig, also tried a clean before):
> 
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check
> 
> already did an update of dtschema with "pip3 install dtschema --upgrade" and also an uninstall/install of this python-package
> 
> $ pip3 show dtschema
> Name: dtschema
> Version: 2023.7
> Summary: DeviceTree validation schema and tools
> Home-page: https://github.com/devicetree-org/dt-schema
> Author: Rob Herring
> Author-email: robh@kernel.org
> License: BSD
> Location: /home/frank/.local/lib/python3.10/site-packages
> Requires: jsonschema, pylibfdt, rfc3987, ruamel.yaml
> Required-by:
> 
> any idea what can be the cause?

Can you share the reproduction steps? This probably is some error in
schema which is then not nicely handled by dtschema.

Best regards,
Krzysztof

