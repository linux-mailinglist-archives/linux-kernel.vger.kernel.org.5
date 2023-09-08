Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B4798172
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbjIHFLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjIHFK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:10:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AD1997;
        Thu,  7 Sep 2023 22:10:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so29925071fa.0;
        Thu, 07 Sep 2023 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694149853; x=1694754653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFHIUWHnNmQApPV1/bfs0UvEu6K4rETbQH94CLPjy5c=;
        b=gU3UFauFYxA/UNNBQERw6lLlxVkI0wWg17LCUBk4zRQE5I4N/vCdNV86fWvfVZ6QW5
         KXYa3xNIUTMkTtz7rz81iB7rmwhGqrGOFZ1U4V8HoZGJIqWFD6a43eQcG6U2rZ7c28wv
         NbOCp/Dx7dnDN6Xlx2mj5ooJmFHrpsfoqsjvkMynswE2IHLf//g4zbBEdfUl76Li43KX
         MduII7CRzgwSaRNv10Z96+n0++RET2VmtbTsV2YkS16j+7Dyasws5hZT4hR8KYH1IZEt
         rSVW85QpK4OFU9Of65KX7jHX5cK3dUhXKHlwISum/Je4m4HC7WOKD0zI3JIfmNb+xpYa
         fqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694149853; x=1694754653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFHIUWHnNmQApPV1/bfs0UvEu6K4rETbQH94CLPjy5c=;
        b=deu/YwOg6zn3lb8VqYL+REoAE1zwud0pyA8TkGi+QwmoityPzGtzZ1/LV1wpME1bTY
         h/4jKlG5VGjd2P1wQ3q65SP2G7DIlYX2DzQRunOR+htAKZKhNh+6X37tlMZ89NnLRPDv
         Epbl/rt1o6uPbAR2AgH6CBthrJGqQBSc34LYUVdlzh966MzKvF/gbWqUgjXYg5fgVMKT
         8jwUfh8W99Kq1xB6lXrSUGkMJBAxgpVupZTia+vYKP/8Z9zjzlzLhn5W/KWUeQ0bg0y7
         CCj7XcAzW2OGbEPpFsuh8BpFasJBcoF58NvfWOA82tmqsE8JWC6ta6hS4OBg/pgDxdjn
         uHBg==
X-Gm-Message-State: AOJu0Yw/g7l+2ifNWuR253AdGxhit6kFTLBx/70N0Tw0l2PNZlrW8lQ0
        mChRN0Dt4z3uFPrBFptb3bU=
X-Google-Smtp-Source: AGHT+IHkmwL6J0JEYxPcyvxzepIZkzQPEW1RAz1nnotQMfzOKs9sBDFOzF2NCkc3prdt5tH+8Pu3Kg==
X-Received: by 2002:a2e:900f:0:b0:2bc:dfab:5dc8 with SMTP id h15-20020a2e900f000000b002bcdfab5dc8mr843564ljg.37.1694149853049;
        Thu, 07 Sep 2023 22:10:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id m14-20020a2e910e000000b002ba161bdc9asm161751ljg.79.2023.09.07.22.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 22:10:52 -0700 (PDT)
Message-ID: <e02bcbc0-ff86-e330-ab85-1a6e202063a6@gmail.com>
Date:   Fri, 8 Sep 2023 08:10:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: Add ROHM BM1390 pressure sensor
Content-Language: en-US, en-GB
To:     Conor Dooley <conor@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
 <20230907-e9e5cdcef1e6c88c1f6afbdd@fedora>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230907-e9e5cdcef1e6c88c1f6afbdd@fedora>
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

On 9/7/23 13:08, Conor Dooley wrote:
> On Wed, Sep 06, 2023 at 03:37:19PM +0300, Matti Vaittinen wrote:
>> BM1390GLV-Z is a pressure sensor which performs internal temperature
>> compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
>> and sample averaging and IIR filtering is built in sensor. Temperature
>> measurement is also supported.
>>
>> Add dt-bindings for the sensor.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   .../bindings/iio/pressure/rohm,bm1390.yaml    | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
>> new file mode 100644
>> index 000000000000..d681fdd0f5ea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/pressure/rohm,bm1390.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BM1390 pressure sensor
>> +
>> +maintainers:
>> +  - Matti Vaittinen <mazziesaccount@gmail.com>
>> +
>> +description: |
> 
> You've got no formatting to preserve the | is not needed.
> 
>> +  BM1390GLV-Z is a pressure sensor which performs internal temperature
>> +  compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
>> +  and sample averaging and IIR filtering is built in sensor.
> 
> nit: "built in to the sensor." or just "built-in."
> 
> Otherwise this seems alright to me,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


Thanks Conor! I'll fix them for v2 :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

