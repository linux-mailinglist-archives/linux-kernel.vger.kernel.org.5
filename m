Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0B7F19DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjKTR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKTR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:27:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27711F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:27:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40839807e82so12711895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700501270; x=1701106070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dbp99EO1nCYm8hYFRfZK7t7+MT7LrrpJ9uCMQlSDqSE=;
        b=ocJEyoL7/IIYa7qkBSBE4V2IQV/psllD/5sEmDXu8BlGfL3pv/G0a3mZrGKi1jVwHJ
         V68DmFrFqRxzvAUMbNrmtPH/vq1mLgvrwAnJZiCwjkY9rIKOMt+iFQNOw6+uh//cE9k4
         I2uWVPGxqjzPW870J60sFf65ETXOuL4bVdIcjQbpc0kUjeM263tHhAEgzqQfImtanQSz
         YMLhJXQSZKTLojcfo+J0sK9bd8BbhB3/hMJPimBGd5dBp1uzOgO0dO1URud5W6fu9GjA
         uz2/EB/KVuY5xNC0PY4a9zJg5VqrQMBrp5paFjxaG+06sogB+EU2U9XITjXNu6w5KWsd
         Fr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501270; x=1701106070;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbp99EO1nCYm8hYFRfZK7t7+MT7LrrpJ9uCMQlSDqSE=;
        b=cl8GwznIHAU2LtvitBbdAaaiEcLXjB1Wrk3xCuUj5lIvqRB1lE8R4sJCAO4WjuP2NG
         wImrusRSrp1snJf1r0LUaomot79jcPcp4CFsvi6N07Uyim0Ynq67DDtXGQfcA2fqO8qE
         cJLd/STbx1kcG6aAjJTTujzoQQuM9OWJFAqZ0QRK/fYymD6krN+rjKcMlmtgRMViaFkB
         epzUpVwlpDPNvk9qQbI1+OLMeg13pXrkWJNeHGxsT9yn6wCKVXDeF97oeyf1DD4oC+ek
         Gh6tAzA+2hayi9iPfBnvjT/H99ds+/y8wWnRbqIJkZf1BZDXUb+dpNkeWHkiZxOQg4z4
         Vw0w==
X-Gm-Message-State: AOJu0Yyi9/v0UQqaKDIdM2Bylf5i3y2Hnquat3kQxP592DAAm9TF/veo
        a08G/INFjw3aNS5cIBaH+vCVew==
X-Google-Smtp-Source: AGHT+IHYTOoFZdClK+006yEkt1ULbvHomDBQOGOS7mAcZ5Y1WlCRb56Y0mQ2bedb2VgFjSqyDbibRw==
X-Received: by 2002:a1c:4c09:0:b0:407:73fc:6818 with SMTP id z9-20020a1c4c09000000b0040773fc6818mr153939wmf.2.1700501270354;
        Mon, 20 Nov 2023 09:27:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id k21-20020a7bc415000000b004042dbb8925sm18262046wmi.38.2023.11.20.09.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:27:49 -0800 (PST)
Message-ID: <e8670fdb-aa7d-4dc4-ba46-53967f1fe7fb@linaro.org>
Date:   Mon, 20 Nov 2023 18:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Implement vendor resets for PSCI SYSTEM_RESET2
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
References: <20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com>
 <417cb5cb-01f5-4d01-8bbe-aa2286fca43e@linaro.org>
 <39b694e9-3275-43b0-a1af-4e2ef7facda3@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <39b694e9-3275-43b0-a1af-4e2ef7facda3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 17:03, Elliot Berman wrote:
> 
> 
> On 11/20/2023 2:55 AM, Krzysztof Kozlowski wrote:
>> On 17/11/2023 22:18, Elliot Berman wrote:
>>> The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
>>> reset types which could be mapped to the reboot argument.
>>>
>>> Setting up reboot on Qualcomm devices can be inconsistent from chipset
>>> to chipset.  Generally, there is a PMIC register that gets written to
>>> decide the reboot type. There is also sometimes a cookie that can be
>>> written to indicate that the bootloader should behave differently than a
>>> regular boot. These knobs evolve over product generations and require 
>>> more drivers. Qualcomm firmwares are beginning to expose vendor
>>> SYSTEM_RESET2 types to simplify driver requirements from Linux.
>>>
>>> Add support in PSCI to statically wire reboot mode commands from
>>> userspace to a vendor reset and cookie value using the device tree. The
>>> DT bindings are similar to reboot mode framework except that 2
>>> integers are accepted (the type and cookie). Also, reboot mode framework
>>> is intended to program, but not reboot, the host. PSCI SYSTEM_RESET2
>>> does both. I've not added support for reading ACPI tables since I don't
>>> have any device which provides them + firmware that supports vendor
>>> SYSTEM_RESET2 types.
>>>
>>> Previous discussions around SYSTEM_RESET2:
>>> - https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
>>> - https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/
>>
>> Please link here upstream DTS user for this.
> 
> The changes are applicable for SM8650, but hasn't yet landed in arm64/for-next/core.
> 
> I'll include it in the v2 with note.

It's enough if you link to lore or any other upstream-oriented tree with
that user. Does not have to be merged.

Best regards,
Krzysztof

