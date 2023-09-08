Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2575979856E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbjIHKFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbjIHKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:05:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260032101
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:04:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so2460049a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694167453; x=1694772253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tSzGcdP81zhgMfNddSyrc2+uCL5+l0gqW3eptRGyaY0=;
        b=qetY8HaRM3SGCTXyVkvn8KJ94sYzOpfKS+eJjeooYvsAAJUnT+qu4keERS3BmMzrfo
         vn+QlCQ/ukgqp39F53pCfIDwG3h1KTW19MVFerVOjyxVuE+NNXVjh76AWGB7NrHagkHK
         3aBlJcGh3X4RmoJfHO3K1VbTjn55BgAou7Ao3RlLbhiMEag1SA97Sh7klYDnWQNwqcYz
         CCDP52leCKKOGqobPIKcwjtTLJOKBUm5hlNsRUzVTWyy/Octa/CwhNujwEtPT5vGz/Zb
         fus5UGVk27IUZIt5jqwjH3hdK4USfAHslDghVr384oCktOLZijj00nGFeWhSiUUEGnvR
         7Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167453; x=1694772253;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSzGcdP81zhgMfNddSyrc2+uCL5+l0gqW3eptRGyaY0=;
        b=fk/6UzkEb34Fa/9CN96acaQOD2mGWkEfdqRW4S8HFdMbenBAFkU7UJM+Z8Ts5nEvP9
         qAtclvg/+Aw7xhbziIFlf4plw0AdwtlM8BUGQIbB1j9JDCpkycVh/NScSImuy6eM4ugK
         TRv47wLbAYm4/TCRqhwKAORiXOeTXjKCs+10QqTTcV3VjiOqvihvbMya+bLbVWmISQxg
         Wgx6we/rnw2L8gRkpwZwpaq6scGeADoTiXSu/VfmCnsmd7m+DOiK+7r5AwEQYMwQqci7
         5kzsXKRXN8nwGtMwf/wEDNcCOtGNrJ5xTsIIRXYh1N9x/span54HlgJDnhPZr5rVaSTH
         /gmA==
X-Gm-Message-State: AOJu0YzXLYVY5APcaK+CEU54nNL13EVz7fbwr/y/4Sozz80iiGkEanY0
        MvUOBFOuUoZox7Yu3zrkPnZr0w==
X-Google-Smtp-Source: AGHT+IFeaE19G/2qD5HIRDGBKJwEZXGW1uXXw7OLcI/yfvWeenXKYLXSSjpHqrTTjhDhxx8coX6MIw==
X-Received: by 2002:a50:fe8e:0:b0:52c:84c4:a0bf with SMTP id d14-20020a50fe8e000000b0052c84c4a0bfmr1421834edt.30.1694167453464;
        Fri, 08 Sep 2023 03:04:13 -0700 (PDT)
Received: from [192.168.37.232] (178235177197.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.197])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005256aaa6e7asm820449edb.78.2023.09.08.03.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 03:04:13 -0700 (PDT)
Message-ID: <41d1e364-40a4-48b2-97ef-6c76d238002e@linaro.org>
Date:   Fri, 8 Sep 2023 12:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] media: qcom: camss: Move vfe_disable into a
 common routine where applicable
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
 <20230907164410.36651-16-bryan.odonoghue@linaro.org>
 <8b424303-09c9-4270-abfd-4f209f5c41e0@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <8b424303-09c9-4270-abfd-4f209f5c41e0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.09.2023 12:02, Konrad Dybcio wrote:
> On 7.09.2023 18:44, Bryan O'Donoghue wrote:
>> We can move vfe_disable() into a common routine in the core VFE file
>> provided we make wm_stop() a VFE specific callback.
>>
>> The callback is required to capture the case where VFE 17x currently isn't
>> VC enabled where as VFE 480 is.
>>
>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
Actually there's 

ret = vfe_reset(vfe);

return ret;


which could just be

return vfe_reset(vfe);


Konrad
