Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B23E7D96D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjJ0LmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbjJ0LmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:42:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2010A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:42:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1446428b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698406939; x=1699011739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui+0X6RaOuqdgWAsDjJ4EPnCuY3qudStVnPGxxdS4w8=;
        b=Y18zZWQpSkvMLu0XXlyA6JQoWdUREYAxQDTsdJNFo3Tq/+VDNUIaOvVVJOdO1MmLEr
         ndVDcNmK3RieV7zzy6ezk/H7kub7nEYjx/fRLkH1+YOXxrWBzEtuFhycdMPlPSIr0o8H
         i68slCGay+rBE5gacmWSta6+h9uCCD8obwrBEEs7qYSPV9Q6I3zEbKt1HQjGpW/h+KVK
         bmgZ3KbjYIaV8UsR9eHsMO4q+asXhPwjlkqLDfyQv2Jwv+i3LwFOJ+zpEKtM63neh2Sz
         X9EyJKFSDL/Y4ap1ygwOL/0jpOk1ihEHXvZj3u+gb4iCfBx91Q0sRtlZAj8AamjE1JYm
         NT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698406939; x=1699011739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui+0X6RaOuqdgWAsDjJ4EPnCuY3qudStVnPGxxdS4w8=;
        b=a/4YxzDDtJXhrkUDwF6Wm1PMb2grtVeFPfxobJj5gr12EUGr+qp2Ta3n4OpuLMx7cq
         7OxuHQUymtzJVfitdINCOB+2m2JHo1j+yvZIj5dmVNFHAK4/WPTgrSWsRkAJ55KkRYxH
         yPbJBMS6ja97a1rc1Vf59J25gYsD2MlrrVZf//pCgHK0KOWnNIBntM7jhoW10lqpk2JM
         c3GKyM36qly/uyvop2duDZceunM70sHQAwvPuWjvBS0Whm9DxWmWTNg1e9gwVLE35w6q
         STmrMbCsSNWdj2q7VwpSyeMJe/pCPbJMGuGMjNZU2684I9+31uLAgsDhcs/U0SI3wpCW
         KibA==
X-Gm-Message-State: AOJu0YyAhKgbpVKmxyUSzX2DOhA1a9rQijm67y6V6RI9QA8F6IIH14hm
        HFhdLG6LJfgs/wskafahj4DI/A==
X-Google-Smtp-Source: AGHT+IGGyKRa3hQHUhJilPpV747GjhOTRZGEgbsYmHh2pSPtU1N4qqaDf2+sIRpTV6aCdutQx9ddqg==
X-Received: by 2002:a05:6a00:230d:b0:68c:44ed:fb6 with SMTP id h13-20020a056a00230d00b0068c44ed0fb6mr3387285pfh.16.1698406939330;
        Fri, 27 Oct 2023 04:42:19 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:c232:f53e:32d4:5510? (2403-580d-82f4-0-c232-f53e-32d4-5510.ip6.aussiebb.net. [2403:580d:82f4:0:c232:f53e:32d4:5510])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78c55000000b0069ee4242f89sm1228768pfd.13.2023.10.27.04.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 04:42:19 -0700 (PDT)
Message-ID: <ab671f50-7a0f-4e72-98a0-fa4d5f2ed889@tweaklogic.com>
Date:   Fri, 27 Oct 2023 22:12:11 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <d7ba077d-6bcd-4e04-b678-51e4bbc935ca@linaro.org>
 <9e55b561-a0ad-4503-9f20-b7c98507afa0@tweaklogic.com>
 <ebcf3e9f-2bc2-4d91-8b5c-51405236e4ab@linaro.org>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <ebcf3e9f-2bc2-4d91-8b5c-51405236e4ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/23 21:34, Krzysztof Kozlowski wrote:
> On 27/10/2023 10:42, Subhajit Ghosh wrote:
>> 4. Conor reviewed the patch and said that it would be better that I handle all
>>      these operations in apds9306 driver (this) patch series rather than submitting
>>      a new patch.
>>      "Ahh apologies then. The best course of action would likely be to include
>>       the patch merging the two bindings in your series adding the third user."
>> 5. As per this patch series -- RFC->v0->v1-v2
> 
> RFC was the first version sent to mailing list. So after RFC there is
> second version - v2. This is v4.

Acknowledging all your other comments. Appreciate your time and effort in reviewing
this. One last question on this - So what version should I use for the patchset
which I will submit next - "v3" or "v5" in the Subject of the emails?

Regards,
Subhajit Ghosh

