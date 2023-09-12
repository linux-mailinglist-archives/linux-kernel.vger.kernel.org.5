Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CA79C745
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjILG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjILG5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:57:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DDBE75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:56:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso688067966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694501818; x=1695106618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdwS3Dp8UxVxbTR5dihAC6rDZGiq3O8yNGuM15TcGAE=;
        b=TRsf19W8ST8jv1aX6A5srf5WvAlS+N5vgvMr9x8jTIgK5kZ7TsZDjuSf5kMZ9xDRv7
         mnZLqMtZm699jBcwjGMo/S6BjegIVDxKxYzjgG/NZr3RYtOBxdauuG5ycmPmxxwseIAO
         TTuWV3pJ8KpQTN9nkdQCS/CHPQrFHvwGVxWS7Uk+wNDuybbkAA9nJ/jEYOqBFNbdqc+G
         bRTYI5lYwE0ejozBs/OSWhHJ4rWdxHKeGUvAqXOqQe7shjIMA3+yLOQL+gq+MTxQFQsf
         QtzS+EPEx9II+ZYgWol91MvwCC4VLfZu4iqU6MBdEdZ0WCnzOhzDbTjuYMYweeCDpn5P
         FLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501818; x=1695106618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdwS3Dp8UxVxbTR5dihAC6rDZGiq3O8yNGuM15TcGAE=;
        b=bReavulXFDq66Cqh58bbKsoAISBvj0Vk3i+HeVv1nf6HXSylpDjXN5W88syBp6IXfH
         qqnFes1PnfOB5CRida83xWXFb/id8sSnOHGXVMMcTTsExdNxLboV7VDj0NFtfFqxpzaK
         7v4y/2x2HBCMCo3b/OGXX0KX/5O/3OjwGtxF/qE1qA/HCnQwRHpemfz/D1lQcL6R2hdO
         P8CL5mQXQ5L2aA8f9TzYgdyhfc7T6bvOiEyxOpmPNea1XaD0/yr3A+OqLVU2gnxudei4
         5e6VC0NgrINOYl47wygQ0ISZnYuF/wsDmfb2ha2N+vQ4mauLL36Dg1uOm+CcR6ZM0WgR
         wx5g==
X-Gm-Message-State: AOJu0YzvFTLtQ+HiVJxcQcaB1s4vndiVTOCgZsv1D82+eL1qza1Ax4XP
        OWxOrRt5fidZ0dtiBMB8JVnOXQ==
X-Google-Smtp-Source: AGHT+IGsHcqBRbU4/A48OeTmm+oTiQrJ8KjLOOUBjhyErBnz1SVJiC4AbVuxvSYGLFoOD64uPIvzbg==
X-Received: by 2002:a17:906:2246:b0:9a1:f3a6:b906 with SMTP id 6-20020a170906224600b009a1f3a6b906mr10980386ejr.36.1694501818448;
        Mon, 11 Sep 2023 23:56:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b009930042510csm6310504eja.222.2023.09.11.23.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:56:57 -0700 (PDT)
Message-ID: <06a007ad-ab6b-2ed0-8f70-6837680c8684@linaro.org>
Date:   Tue, 12 Sep 2023 08:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
Content-Language: en-US
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor@kernel.org>,
        "Cusco, Ana-Maria" <Ana-Maria.Cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
 <20230816110906.144540-2-ana-maria.cusco@analog.com>
 <20230816-stoop-exonerate-148c7bdc01c2@spud>
 <SN7PR03MB7132732C9DB517378897DADA8EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SN7PR03MB7132732C9DB517378897DADA8EF1A@SN7PR03MB7132.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 08:36, Hennerich, Michael wrote:
> 
> 
>> -----Original Message-----
>> From: Conor Dooley <conor@kernel.org>
>> Sent: Mittwoch, 16. August 2023 16:37
>> To: Cusco, Ana-Maria <Ana-Maria.Cusco@analog.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
>> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
>> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/2] dt-bindings: iio: hmc425a: add entry for HMC540S
>>
>> [External]
>>
>> On Wed, Aug 16, 2023 at 02:09:06PM +0300, Ana-Maria Cusco wrote:
>>> Added support for HMC540SLP3E broadband 4-bit Silicon IC digital
>>> attenuator with a 15 dB control range and wide frequency coverage
>>> (0.1 to 8 GHz).
>>>
>>> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Adding missing Signed-off-by tag
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Why it is missing? What is the purpose of this adding?

Best regards,
Krzysztof

