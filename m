Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0AE79832A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbjIHHSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjIHHSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:18:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0AE1BC8;
        Fri,  8 Sep 2023 00:18:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so2967283e87.1;
        Fri, 08 Sep 2023 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694157482; x=1694762282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smf62hNaj0uPO3gBbh1PGmNcBmE2E6aTkzmFVeY/thc=;
        b=TesyKRAopNb1CqujJfQfPkm5MpFt8GJI2jbhkgHbomAbofZ6dknbAZc+IhXtfXpyqJ
         ohMCkNtyJ6cc1Vn3wsknthKomc6Tn8uSbEvMV1/SnJsTrKI+gZLJ2g1rkIJME4J5UgCK
         7+iIhagqrNdrQerWKv/D3NG2XKo0i/VsJCVFVfxUfwfCcoVSgELqC7FObQPGAQ5YK3Yb
         9H77UQ8QBrtUMDNqQ9sm/YFMFYH5kEg7AuAPmtBWlNmnni4v0Uoe1uUc/nVpGMPTw091
         +DYfOSpBvoAFNJyXzBv6SQ2jXdEG26XGe+Ks0b7ACpXGuqIvhXybOc8GB6DUz8T0PkAJ
         BUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694157482; x=1694762282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smf62hNaj0uPO3gBbh1PGmNcBmE2E6aTkzmFVeY/thc=;
        b=r1ZFDHaxEvQ5yNOo4gihWMt87d5p5qGZjC8h5MW5RrtiQMlJ45+ZHo60JGeQ1PzFIm
         AcqZcE+YcihBi28Oz0xTAfVM5MmuEAhGsGsciOgKo0E1nDLUHVTFc6bxvH1/QEM/pjIG
         ahOPjYmEnSYfByfFcOHgHSY7GltT2WOFoFBoDtkwQEAz26FTXU7YN5NqZkSCm3G/0srZ
         DQvLSLVdktUd7AK/rA/VWnpW0ZM3OssCWk4ovwSoMSyceDazDIrIKimDUTDJJlzlMu0I
         vATZeCYPRtQ8PD3cjFGe7omZHbidDMV7OBvRAQXyD8cKxm9WWMmVyYsuho5neju6nYGZ
         UycQ==
X-Gm-Message-State: AOJu0YxhvCPDEJM49+hrEtzkxOnaIazyOv0m0r/zmA4AcELj85/UVT1v
        GrV3yu7dP9jlC3FeZWm7ah8=
X-Google-Smtp-Source: AGHT+IFvYcLcQiX/WNdwXlR0SJaMJDqkELEUc8cSoI79tSPyREwua0CZkJEU+nKRYdn+1ABxf8/dSA==
X-Received: by 2002:ac2:58e1:0:b0:4ff:7004:545e with SMTP id v1-20020ac258e1000000b004ff7004545emr1124685lfo.4.1694157482223;
        Fri, 08 Sep 2023 00:18:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id z13-20020a19f70d000000b005007fc9cccasm195517lfe.94.2023.09.08.00.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:18:01 -0700 (PDT)
Message-ID: <4b5ea58a-bee3-26cf-2c0d-e08fc4d1b051@gmail.com>
Date:   Fri, 8 Sep 2023 10:18:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: Add ROHM BM1390 pressure sensor
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        ang.iglesiasg@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org
References: <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
 <20230908071421.1309276-1-bbara93@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230908071421.1309276-1-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 10:14, Benjamin Bara wrote:
> Hi Matti,
> 
> just accidentally saw your series.
> 
> On Wed, Sep 06, 2023 at 03:37:19PM +0300, Matti Vaittinen wrote:
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pressure-sensor@5d {
>> +            compatible = "kionix,kx022a";
> 
> I think the compatible in the example is not right.

Indeed it's not! Great catch! Thanks! Must be fixed in v2.

Oh - and long time no see - I hope you had a great summer :) I'm waiting 
to see you continuing the regulator stuff ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

