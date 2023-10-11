Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9D7C54FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbjJKNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjJKNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:10:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2FD93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:10:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9bf22fe05so13141215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697029826; x=1697634626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wOM+rVlEncWtIcaSta6xu6eHLCRdmG5bClAcyA0Ctk=;
        b=TU2uBtXlitx+CHhGMa+FWij7ZLeN35+OYF0js5BuGZ8lPVqauJZoZA7tb2mimsUfJ0
         xUt6PlDDTDwrx11IceUDHWfe5Giceslm7D4fwItNpZyjBfHXkJmgoen0z2yYtRqUZ9Pw
         mHiYrAN8VhTPrL0yI6a4taCGROmJkH35jYtT+MIuI6O+qe4te51UxTm0ID7Uej3Gni7N
         C7sqgDefBY5vm2MSIDA77vQkBHGB1mucxOv7VYOXqUhSIR1fCZ1M8ZIeUgrMv/BVd3Vp
         Z+mMEHFUiXxaxrEXCjfXfVLWmDQDuzUWK23oEAza35A2PdFv3b6Y1j4a/Uo6XGQfOVLb
         SZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029826; x=1697634626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wOM+rVlEncWtIcaSta6xu6eHLCRdmG5bClAcyA0Ctk=;
        b=jRdabmlcWHMPj4But3FRhb8qe6esmKEAWLZzTpEg149eKPASkebdogLvl5mi21mV4T
         5KDrFbI+jb9zKC/ZNtTV9AYUXq7WZvItFwRBs/Kx3S1KzpNRBP1j9fj1LjsMnvQA2Rr0
         zxU7zBIG/sFkbzp/mwrGGpXZGZsBs+t54AUt0MXV9p3FHua46iPfcpHuchLU+B9bgtJo
         uqupY3TwO0zmdppIC0AnjKEk7+H1pAKcEtj21yCwpBaBpF+kR1/YC/FRlpvLEEJEn2z1
         VnyBAlVhQSvDI/i6bGmIYaRb/8/1FqiguPivC3wvUF3tht2jPZFBhV/eXV0xVoWBMooI
         ombA==
X-Gm-Message-State: AOJu0YzR8f5xRsVDoqXIbQjUdFejZqx1k7wfmsFuf0k9whN+BHTU7Wcf
        L3FG9MZGG0x+iGa4red4PUB8NQ==
X-Google-Smtp-Source: AGHT+IGseWVdcAxiIA+AskawQ8BaACwpMMfoE1sBY3gJ6+fKWdR+1i5OXDFpqQOlX5oCL6NaPrPcEg==
X-Received: by 2002:a17:902:bf0c:b0:1bc:3944:9391 with SMTP id bi12-20020a170902bf0c00b001bc39449391mr16639073plb.25.1697029825684;
        Wed, 11 Oct 2023 06:10:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:92f1:e901:1eef:a22? (2403-580d-82f4-0-92f1-e901-1eef-a22.ip6.aussiebb.net. [2403:580d:82f4:0:92f1:e901:1eef:a22])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001c74df14e6esm13834862plh.51.2023.10.11.06.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 06:10:25 -0700 (PDT)
Message-ID: <689dc368-b504-4863-3603-13ba43fe4697@tweaklogic.com>
Date:   Wed, 11 Oct 2023 23:40:18 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
 <20231010145130.3d5ff9c7@jic23-huawei>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231010145130.3d5ff9c7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 00:21, Jonathan Cameron wrote:

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vin-supply:
>> +    description: Regulator supply to the sensor
> 
> Why vin?  It seems to be vdd on the datasheet.
> We tend to match the datasheet naming for power supplies as that is normally
> what is seen on circuit board schematics.
Got it, I'll fix it. Thanks for looking into it.

Regards,
Subhajit Ghosh
