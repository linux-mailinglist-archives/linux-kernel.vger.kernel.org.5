Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB81780A6E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574375AbjLHPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574388AbjLHPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:10:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B95026B1;
        Fri,  8 Dec 2023 07:09:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso2535809e87.2;
        Fri, 08 Dec 2023 07:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048172; x=1702652972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ty/29TTzygGMDv96OFi4fv1KRAlm0fzyRN/+tNsm1iU=;
        b=nqES9lyySV7KcxEf5D1DvZ2mWGR1YcQ20T1kIG25Nmv1G/vnxAyEcNR8RoXmJRH9pm
         ytqFnzKF3XTgkalvod0iTedrtz6ADhKE2cukmTpKaPLAW1pjgAr3+2ZhEcMtacxQcEUd
         0ThXlov0LCPZhh8nNBoP0J485RAhH0+gzzGDNDjIqBbZp98gdXMlKCmzDUIw3usUGyDJ
         3ZicbMfMQ65BH8LvNY8SPEPFEFI/81kCXhTCn32idXcSwGcG+01P8085TMk5FwZuZ3yY
         q7fjmOQkWLVqdqkt1IPITo8M+Rr75Khg9F07O4LyjCXD2v/hsezDSxYnpxaMc3uhyKi6
         8bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048172; x=1702652972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty/29TTzygGMDv96OFi4fv1KRAlm0fzyRN/+tNsm1iU=;
        b=ETopoIN65eWlTOh2MB61YLUe5//Qw7tZuOjba5S2x/LgQuhGHwrPW5RZFvux+RT8xi
         8Z4Qg+AuQvUm3QOfBEN++K+e3PXENIB66wEbPdvCBrwO3tdUH+AXkJfRxBUzcGHDO9Ze
         3kMLeQ3NBw/TQoPrxyFHHC8W0h/pm83DN5Ppl0+nRVMQqM2AJUE9tJyuPCEWfGVyBbRN
         MBM7zN27lIjxG9tGtsJmSNSDagInwTYZ0VxeA6HAjUPTabZQDK9sUcuj2iSZTIQbJyP6
         bN44/ctyCypLRuLlw7fSxVbNwTljbgF8ahGSZQh6T46mr1wueTjPEt8GlCOlfTXuZukq
         pSQA==
X-Gm-Message-State: AOJu0YwrczprWE2BfUbGwu8EPOSHFdHgM7Tf0gNwLIIL9bahHwCl/blQ
        PK7nh1jYk8FRWQCzc/GS+qQ=
X-Google-Smtp-Source: AGHT+IE2/HriMnM04UsszHZPIN2IhDpaQZtu1ft/pq6NRm1cZ88jw68F7XlsEf61IuibCKqQ90+M3g==
X-Received: by 2002:ac2:5194:0:b0:50c:11:473e with SMTP id u20-20020ac25194000000b0050c0011473emr12611lfi.89.1702048171893;
        Fri, 08 Dec 2023 07:09:31 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:c92f:1e77:f6cd:6d02? (2a02-8389-41cf-e200-c92f-1e77-f6cd-6d02.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:c92f:1e77:f6cd:6d02])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056402207200b00542db304680sm846815edb.63.2023.12.08.07.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:09:31 -0800 (PST)
Message-ID: <79a9bb81-4488-47d1-a24e-f4abde097d43@gmail.com>
Date:   Fri, 8 Dec 2023 16:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hwmon: Add support for Amphenol ChipCap 2
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
 <20231020-topic-chipcap2-v3-5-5b3bb50a5f0b@gmail.com>
 <04475f91-bdce-4677-894c-74c2bb8233d9@sirena.org.uk>
 <5b62afcb-254d-4dfc-8332-7979c62ea2c2@gmail.com>
 <6cce1b87-a9a9-4554-9dae-c24d1d276fb5@sirena.org.uk>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <6cce1b87-a9a9-4554-9dae-c24d1d276fb5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.23 21:44, Mark Brown wrote:

> There is a specific API for exclusive regulators which the driver is not
> using, and it's unconditionally doing the disable/enable cycle here.
> 

That is right, I will call regulator_get_exclusive() instead.

> The driver needs to be explicitly configured for this and have separate
> code paths for normal operation and operation where the supply can be
> bounced like this.  In neither code path should the supply be optional.
> Right now we don't have a mechanism for discovering optionally exclusive
> and enable/disablable supplies which is what the device needs, we could
> potentially add that since this does seem like a viable use case and we
> already have enough information in the DT to say if the supply matches
> the constraints.  Probably the two properties queryable separately.  If
> that API were added then the driver would do a normal regulator_get()
> then check if it has the capabilities it needs and either keep the
> supply on all the time (or possibly just during measurements?) or enable
> the alarm functionality.
In that case I will split the driver development into two steps. First I
will stick to the existing API and implement only the code path where an
exclusive regulator is required i.e. not optional, which will simplify
the review process considerably.

When the driver makes it through and all other issues are also solved, I
will work on the optional exclusive regulator. This is probably an edge
case and it will increase complexity to actually use half of the device
capabilities to save the exclusive regulator, but at some point I would
like to offer that as well.

Thank you again and best regards,
Javier Carrasco
