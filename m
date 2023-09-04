Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049D791D91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbjIDTV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbjIDTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:21:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1DCC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:21:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso567408966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693855277; x=1694460077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwnC0dmhx4Pgj4fjSL9ekmpcafpEJcWhNeC+Qal32kU=;
        b=PH4BLQ0BOZlrkLLdBy5A48tHL5Gu+9cxkMBmBTSuKPZeL6OD0b4svI7QKfivI4ZIBG
         LlVgoLkyFt/wZQ3fkMAiyHe2c3X5UZGqiNcfwRyDE7FYxeYnohmF6xh6g6UQoALEk8XO
         ssiYxQx23cxOIlRaWoh9fnSA89PhFO2JbzcGkzYcmnqw/Yiy0UkL7L7a5Y2iNkeQEPKW
         9NjKFRpmR4owyoSOBVqeH3uJMEcSCtAaB1xRjtMjVT92PMo9LUDJ5ZO4pwCGQokO3H4v
         aN45pP56Dl+XWwouD1+1LExr5tcCc9Z3gJX28uZp58/lBBpq2pcq9nI028OeOi3pk+Yb
         VjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855277; x=1694460077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwnC0dmhx4Pgj4fjSL9ekmpcafpEJcWhNeC+Qal32kU=;
        b=XCb3w10j3/PZ9QL7sdCj2qvHV+W2ii8u3FA/t4QkHiIZncDbZumsBB6qTVUJNs7WBV
         F57D3cYjzR9egiOHBoK1sXiaynG9xp6YFjdcsHunkPb6DEI2kJ+F7syuh/rOH8tD3Aty
         1s2o6AfL6pi72fDpZEdzviX1YVoR3Talu/u6hRdmDAis6YjFs76EOuyZWdAxq6TGFVdx
         NuiMpQ52W6o/1qHq16OTKzmrjpvYGxGdW9Uas1pSixXue/UVqEs1wa9X8Ci68bJYIxY5
         mxxY8weD7alFp2b+iyZTNOymL+HXR5W3L7sKaysyvVrN91zP5F/xv0t+Th5xRR+coKUZ
         o2xw==
X-Gm-Message-State: AOJu0Yw4afe/GKt7CUUO0QNdCZhtJ7xh8xQgQtJCLi35zCVpe1hvj1XA
        Gv+LIniC4phjcPQBeGWm9bujjPb+krKW0hqtBI0=
X-Google-Smtp-Source: AGHT+IGvDPMJNDSlbBzc9CgR/mKwcdCe7XGdruTJhshUD2iMe++6t6XsPrzXId5efeRKdU3EtA2PGw==
X-Received: by 2002:a17:906:109b:b0:9a2:474:4aa1 with SMTP id u27-20020a170906109b00b009a204744aa1mr12712578eju.10.1693855276881;
        Mon, 04 Sep 2023 12:21:16 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qw14-20020a170906fcae00b0099b7276235esm6602040ejb.93.2023.09.04.12.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:21:16 -0700 (PDT)
Message-ID: <20659635-21ae-5023-99b8-a61e8651ca5a@linaro.org>
Date:   Mon, 4 Sep 2023 21:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Aw: Re: RecursionError when try to check bindings (ubuntu 22.04 /
 Python3.10)
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
 <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
 <trinity-387c30fb-f681-4886-a86c-3f66c77bd5f5-1693852391761@3c-app-gmx-bs26>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-387c30fb-f681-4886-a86c-3f66c77bd5f5-1693852391761@3c-app-gmx-bs26>
Content-Type: text/plain; charset=UTF-8
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

On 04/09/2023 20:33, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Montag, 04. September 2023 um 20:18 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> An: "Frank Wunderlich" <frank-w@public-files.de>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
>> Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>> Betreff: Re: RecursionError when try to check bindings (ubuntu 22.04 / Python3.10)
>>
>> On 03/09/2023 13:08, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> i tried to check a binding-file with 6.5 kernelsource and get this error
>>>
>>>   LINT    Documentation/devicetree/bindings
>>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>> Traceback (most recent call last):
>>>   File "/home/frank/.local/bin/dt-mk-schema", line 38, in <module>
>>>     schemas = dtschema.DTValidator(args.schemas).schemas
>>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator.py", line 354, in __init__
>>>     self.schemas = process_schemas(schema_files)
>>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator.py", line 271, in process_schemas
>>>     sch = process_schema(os.path.abspath(filename))
>>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator.py", line 248, in process_schema
>>>     dtsch.is_valid()
>>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/schema.py", line 145, in is_valid
>>>     for error in self.DtValidator(self.DtValidator.META_SCHEMA).iter_errors(self):
>>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 242, in iter_errors
>>>     for error in errors:
>>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_validators.py", line 362, in allOf
>>>     yield from validator.descend(instance, subschema, schema_path=index)
>>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 258, in descend
>>>     for error in self.evolve(schema=schema).iter_errors(instance):
>>>
>>> block from line 242-258 repeats many times (~2000 lines in log)
>>>
>>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 242, in iter_errors
>>>     for error in errors:
>>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_legacy_validators.py", line 216, in recursiveRef
>>>     lookup_url, next_target = validator.resolver.resolve(each)
>>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validators.py", line 835, in resolve
>>>     url = self._urljoin_cache(self.resolution_scope, ref).rstrip("/")
>>> RecursionError: maximum recursion depth exceeded in comparison
>>>
>>> make[2]: *** [Documentation/devicetree/bindings/Makefile:68: Documentation/devicetree/bindings/processed-schema.json] Error 1
>>> make[2]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.json'
>>> make[1]: *** [/media/data_nvme/git/kernel/BPI-R2-4.14/Makefile:1516: dt_binding_check] Error 2
>>> make: *** [Makefile:234: __sub-make] Error 2
>>>
>>> my command is (after importing defconfig, also tried a clean before):
>>>
>>> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check
>>>
>>> already did an update of dtschema with "pip3 install dtschema --upgrade" and also an uninstall/install of this python-package
>>>
>>> $ pip3 show dtschema
>>> Name: dtschema
>>> Version: 2023.7
>>> Summary: DeviceTree validation schema and tools
>>> Home-page: https://github.com/devicetree-org/dt-schema
>>> Author: Rob Herring
>>> Author-email: robh@kernel.org
>>> License: BSD
>>> Location: /home/frank/.local/lib/python3.10/site-packages
>>> Requires: jsonschema, pylibfdt, rfc3987, ruamel.yaml
>>> Required-by:
>>>
>>> any idea what can be the cause?
>>
>> Can you share the reproduction steps? This probably is some error in
>> schema which is then not nicely handled by dtschema.
> 
> there is not much more than i already told...
> 
> git checkout v6.5 #to have clean mainline version
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig #use mainline default config
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check
> 
> it does not tell me a special binding file which is broken...it seems it has a problem with the self generated processed-schema.json, but it deletes the file.
> 
> maybe there is a way to skip this removal to analyse this file...have looked into my site-packages, but have not found the position of file deletion
> 
> btw. i get the same error also if i do not pass a file to dt-validate command...

Cannot reproduce it. Are you sure you are no mixing Python versions or
packages (e.g. pip and pip3)?

Best regards,
Krzysztof

