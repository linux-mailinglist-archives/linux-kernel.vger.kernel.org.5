Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32937DE049
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjKAL0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:26:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243F110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:26:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54366784377so3041735a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698837992; x=1699442792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BcnzubYf14PsFo9Ecx9xFCXIIflA4maBXpAaBf5c+l4=;
        b=Oi14AxvNFDdlTupliki3GGHwT2TrMNUkPeLh3OewjHG7B8dtpgbvF0mdwHDE6bt7GE
         J1D6bHdw1SlgzgbQG6lW/Ag69RJfBx2qRayIoqnN4Cu2f9YxIqlWHijkG5iHiSuHbpob
         3bUZzjqPqts0ub2EgeJ9YYKeEmW2CgPFyeQIO0dnnJomWQ19mIWqAtblWMaoBUkYBlEm
         uBNR7q1EcCV6TPAYyN6buSZaY7WXJpSSdoF8BvmQz2HMxY5imlsJi86eQhqzXBxERmub
         aJHQta8BTe5f7KGnjXcqdqte8DneIjwTxyeaMeonRwH6xgTX9UY0AizGxIROQG8ZcjoT
         Pdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698837992; x=1699442792;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcnzubYf14PsFo9Ecx9xFCXIIflA4maBXpAaBf5c+l4=;
        b=XEra3HUqBQZcUX2djnRCEBw00ElfSvUyKojIznhS/e98v4qXZmtdgV96SKS5EYK7sY
         O/ZGakmjDIIcFhDPjAkPEbYDdlCjR+r+0pl7Q/voT+AW9BUK2Gl5m52rOab77HgI6GwE
         hD7xL8tZdiEjuLrt8w3OBVtKnWFJH19QnHSNzMvST0DVSxkw6RlmINIBFq0+/XpFgkmY
         cJVZs7UtL6zWq+xoO+ULwajQMUvtS4VlL47r69sZNbbVu7r9d87+VG0hLRFtzD6Nkyrw
         KsvgapkWDmLS8xS8CWaKAFOSuxZbxNOojhuCSlsqIaHg3YOZ20MNHlqvTGBi+2ZRN3xR
         BU4g==
X-Gm-Message-State: AOJu0Yy+eiYqJg867HvwAyOHpHbl6IsiuD1YorSdBO4owHNoqLHhjZpF
        8Iifl4O3BWHMdMoYvoBsQG6H3w==
X-Google-Smtp-Source: AGHT+IFmmvpK+hehTtlk1xu86DRPjHoFJOI37zn0r/9RSY6rZl+PSj3AOV8UTiDSX9xNZeoV0FtrcQ==
X-Received: by 2002:aa7:c309:0:b0:53d:eca8:8775 with SMTP id l9-20020aa7c309000000b0053deca88775mr12464926edq.26.1698837992196;
        Wed, 01 Nov 2023 04:26:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b0053e2a64b5f8sm959138edi.14.2023.11.01.04.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 04:26:31 -0700 (PDT)
Message-ID: <cb247586-6d36-45e4-b5b7-c49b390de406@linaro.org>
Date:   Wed, 1 Nov 2023 12:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] dt-bindings: usb: add no-64-bit-support
 property
To:     Conor Dooley <conor@kernel.org>, Naveen Kumar <mnkumar@google.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, royluo@google.com,
        devicetree@vger.kernel.org
References: <20231101101625.4151442-1-mnkumar@google.com>
 <20231101101625.4151442-3-mnkumar@google.com>
 <20231101-diffused-iguana-f411619dc72a@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231101-diffused-iguana-f411619dc72a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 11:38, Conor Dooley wrote:
> On Wed, Nov 01, 2023 at 10:16:25AM +0000, Naveen Kumar wrote:
>> From: Naveen Kumar M <mnkumar@google.com>
>>
>> Add a new DT option to specify whether a host controller is able to
>> support 64-bit DMA memory pointers
> 
> What host controllers are broken?
> 
>> Signed-off-by: Naveen Kumar M <mnkumar@google.com>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> index 180a261c3e8f..20dc134004f3 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> @@ -25,6 +25,10 @@ properties:
>>      description: Set if the controller has broken port disable mechanism
>>      type: boolean
>>  
>> +  quirk-no-64-bit-support:
>> +    description: Set if the xHC doesn't support 64-bit DMA memory pointers
> 
> To set this property, you need to know that the host controller is
> broken, so why not just make the driver set the quirk once it sees that
> the host controller is one of the broken ones?
> Unless there are "sometimes broken" host controllers, a dedicated
> property should not be needed, right?

Yep, this looks like property specific to given XHCI controller, thus
can be implied from compatible and there is no need for new DT property
at all.

Also, there is no single DTS user of this property. It looks like you
add it for some out-of-tree vendor or non-upstreamable code, which
personally I would not care about. Feel free to prove me wrong by adding
it to respective DTS in other patchset linked here.

Best regards,
Krzysztof

