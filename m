Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669B7C6FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378940AbjJLN62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjJLN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:58:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947CBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:58:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40651b22977so2503885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697119102; x=1697723902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcZvz58OosH2lGDIuEl6DlOcic+0phQ3UfuxYsqp/eA=;
        b=bS1KB5alZItqEXsKSpKZChPuetxarSfDefIQlPQUL5Ay2HjljtHTOvIbq5kngcbdwN
         TJp3vQMcLSL4GQdxeY5eMJ9wovKknNP3zZzSOyFG/jKczvQ7hi0x6VtFyMj8D3BDzmTb
         FIjvo4epH31IG5ABKQu+qBDdLofOerMFih0Avxh/2HLYtmRdkOPoTUcr05V50R8YdaVf
         pDX7wKtqbMARDULUEhnQy00dEr3X7FQE4ERiVr3m1NOtIhouwmYQzew2IxCc8437pMA3
         JUdCnlLBZJhW8i6lCUT3cE4rFWXpqzhxoKtcQqr1Q2CsmlAQjugkj9LS+LIdiaUxsxrm
         8HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697119102; x=1697723902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcZvz58OosH2lGDIuEl6DlOcic+0phQ3UfuxYsqp/eA=;
        b=ezuPhXm11APNcDmvmlZ2iHxxD8dH7sU5ohSHXgjNNvXYJG5QLIAtVddDAgzMQKnaNo
         nRG7QatRLRRlOMPrRsCyuusyJREmVjojf5E2R8L92dEVDuHB0zvBVdU391jVZrona2dh
         DAZAdGhJIJPPwHSlRqT49Y4nnsUTqR2Uzb0GbggpVRJzBjnuxDRJYnYQtUrzof9ypiNE
         Ljdhv3Pj+mw2/W4+ymhvQAw4vOrY4CPp5pV51AJlp31xaNzhSqQ9xozmLc2ux8jdfo5n
         lnmcmZKoPxztH7aC1CE8ow6bQP85ZcLCFa3OTEtNobTzbFtl9jvj+Caz0Bd+E0k53MAt
         sy6w==
X-Gm-Message-State: AOJu0Yx5E/S8/FTbgf7a5cSHoxLW6JKCbTZY4Uj/5w9QX9p+9rTYYWn9
        9HE0hIXdmhntvTz9Zw/r6u22Kw==
X-Google-Smtp-Source: AGHT+IEX4nDwJ5QBbqXM1eRAqAHPm4dDRQbr5bVhX7vDfoHgWUlVU7DOUB46kNI1sT4S5KCCp8cx2w==
X-Received: by 2002:a05:600c:1d18:b0:404:72f9:d59a with SMTP id l24-20020a05600c1d1800b0040472f9d59amr21765331wms.0.1697119101941;
        Thu, 12 Oct 2023 06:58:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3fed:c1e5:145f:8179? ([2a01:e0a:999:a3a0:3fed:c1e5:145f:8179])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b00327df8fcbd9sm18598356wrv.9.2023.10.12.06.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 06:58:21 -0700 (PDT)
Message-ID: <3f4784c7-a6a6-4567-bd80-7e3e82abed16@rivosinc.com>
Date:   Thu, 12 Oct 2023 15:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/13] dt-bindings: riscv: add Zihintntl ISA extension
 description
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-11-cleger@rivosinc.com>
 <20231012-ambiguity-angular-d8c69cc01535@spud>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231012-ambiguity-angular-d8c69cc01535@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2023 15:50, Conor Dooley wrote:
> On Wed, Oct 11, 2023 at 01:14:35PM +0200, Clément Léger wrote:
>> Add description for Zihintntl ISA extension[1] which can now be
>> reported through hwprobe for userspace usage.
>> 
>> [1]
>> https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view
>
>> 
> Ditto. Who is even hosting this google drive anyway? I'd rather see 
> GitHub links to docs from the releases, but since youre pointing at
> the ISA manual I suppose those do not really exist.

Acked, I'll fix all these as "Links:"

Regarding the pdf sources themselves, I actually used the links as
referred on the RISC-V wiki [1] which is the wiki mentioned from the
riscv.org website [2]. I do not like it but there does not seems to have
a proper specification release website...

Maybe pointing only to a specific commit on the github repo that
mentioned that the extension was ratified is better.

Thanks,

Clément

[1] https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
[2] https://riscv.org/technical/specifications/

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks, Conor.
>> 
>> Signed-off-by: Clément Léger <cleger@rivosinc.com> --- 
>> Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++ 
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> b/Documentation/devicetree/bindings/riscv/extensions.yaml index
>> 4c923800d751..70c2b0351357 100644 ---
>> a/Documentation/devicetree/bindings/riscv/extensions.yaml +++
>> b/Documentation/devicetree/bindings/riscv/extensions.yaml @@ -247,6
>> +247,12 @@ properties: The standard Zihintpause extension for pause
>> hints, as ratified in commit d8ab5c7 ("Zihintpause is ratified") of
>> the riscv-isa-manual.
>> 
>> +        - const: zihintntl +          description: +
>> The standard Zihintntl extension for non-temporal locality hints,
>> as +            ratified in commit 0dc91f5 ("Zihintntl is
>> ratified") of the +            riscv-isa-manual. + - const: zihpm 
>> description: The standard Zihpm extension for hardware performance
>> counters, as -- 2.42.0
>> 
