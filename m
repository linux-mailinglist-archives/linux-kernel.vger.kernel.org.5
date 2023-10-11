Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD47C54BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjJKNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjJKNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:04:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278919E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:04:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso4449890a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697029461; x=1697634261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKGDsSgRWaVRqguRQzytVv1LFKTRkfGDmTPgMhFGmI4=;
        b=NUC94I6JIABY3ySPzqj2qvktDwsPMfsa+rKp9EFeCRa6qj+xkG3RykpkJVLxrCAcFm
         4G3NxHQX7ZXltrOe3p5l5NhfumYNwRzZqriAZ715UzgJs5nedWt3/408MFmRbqiXoRK5
         b46NwkW9uUnrIAW3VVcXuQgrovTE0UmJGYmpzOXYEp33cWKgnjI1AmG+pQSioxZsjqOP
         KlclJxkSzNr181bYhcx16SuednbjK9WZBATI0R7YVIvI7IY5OFDKMlq349Z4lMJPYhS9
         ypqOpw9H8Og4Y/ZquWP5NCI2gLmzy1N2Qjya6ciRnlvC3rurwoyXjf0Ity0KekzjWZlM
         zpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029461; x=1697634261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKGDsSgRWaVRqguRQzytVv1LFKTRkfGDmTPgMhFGmI4=;
        b=hWUxzCTxsrPS/kyaSjR6DS6v3vtbveRxJ6Pnj0puCxk2a9gfVLY4RYjalVJ41Nelwb
         ECe+iC8z+RzjZ7xkgA8050t36nML1qRzzPk0G/bfU3gglMLLz/Vz0CKO4NZTUtZGZiiV
         OZMfC8Zpwhjc5snEQx39RhlOVWEF3hVq4vrVmyr3FNBdJ1kFFAzZGwhASx5ZfFiDY50v
         tWCIW+UvOLZh1bc76MyMDQEZNJi/GaTOmFOGJUJsvLf7gwLDcG5P3jrG/EnOIF0hxC6V
         ROD/cdocF5cpCPvWGaPNNfYRdNsnNre2WVL6whgMB9XnR7CsLv1bgadO0qiCVCGTO5WO
         CoPA==
X-Gm-Message-State: AOJu0YxBWhmiup2NMO4Q4LIgpUSSErmCTdSex3NUfSEl6at9ADEEcEUX
        TAs3k8MRurkLUmbvx80PexUETg==
X-Google-Smtp-Source: AGHT+IHbRm3s2xZzTaph0FHcK0YjQdqB2JHxO34y+v1bOoDkYN44ErW9Cudd/NnuxxI1L7fxSi23kQ==
X-Received: by 2002:a17:90b:4f46:b0:267:f9c4:c0a8 with SMTP id pj6-20020a17090b4f4600b00267f9c4c0a8mr17714675pjb.4.1697029461274;
        Wed, 11 Oct 2023 06:04:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:92f1:e901:1eef:a22? (2403-580d-82f4-0-92f1-e901-1eef-a22.ip6.aussiebb.net. [2403:580d:82f4:0:92f1:e901:1eef:a22])
        by smtp.gmail.com with ESMTPSA id c6-20020a17090ad90600b0027d0de51454sm734373pjv.19.2023.10.11.06.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 06:04:20 -0700 (PDT)
Message-ID: <70bb5281-18f6-f5b3-9226-7a7d552671f2@tweaklogic.com>
Date:   Wed, 11 Oct 2023 23:34:12 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
To:     Rob Herring <robh@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
 <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
 <20231010161900.GA999361-robh@kernel.org>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231010161900.GA999361-robh@kernel.org>
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

On 11/10/23 02:49, Rob Herring wrote:

>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: avago,apds9306
>>
>> I see the driver supports two different variants of this IC, differentiated
>> by the part-ID register. Variants are named as apds9306 and apds9306-065. I
>> wonder if we could/should have different compatibles for them?
> 
> If 1 compatible is sufficient to know how to power on both devices and
> read the part-ID register, then no need for different compatibles.
> 
> Rob
Understood. Thanks Rob.

Regards,
Subhajit Ghosh
