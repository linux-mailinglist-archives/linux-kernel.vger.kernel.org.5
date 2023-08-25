Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8C787F33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjHYFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjHYFNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:13:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F191BD9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:13:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99d937b83efso58660566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692940424; x=1693545224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Atdwlr4ZDNiktFeelgF93mSGgIj/iGi0rNQszZlVpA4=;
        b=JRqmp0QSyt72qo5V3cY0Y5k8QRHmC1Ls5KH6YuJFu1V7KG3KZvjUZ2uvVFpanGmaaU
         wlb3p5+BP9+JQ8HphFo4omJCJAdQyBJ/nm9rZ+QqDLK1LK9qz8C+eZ/QkJsp+FWhmvjx
         iKbREA1UX34MRYfAcxZ9mZojJKrvJj6XzSrG9twaF5iDKmenYtdKh8qWlmrfH5cDJtyl
         QLXjB01usvhO/upOTIRrUW5ktHTjqZHRlV3orlT9Jgg9KxchkFkADCm7lva/vevDro42
         ZgX2dSu2aWqWUiV16z0g2lYoqXgAaPoXMgNe+Xrag0NqcFB6pOOI4Ye+jWPM57RqRBOx
         xnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692940424; x=1693545224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Atdwlr4ZDNiktFeelgF93mSGgIj/iGi0rNQszZlVpA4=;
        b=L5ub5u30qpgYUyiKB73fjziFcc+TkaP52mEvJ/P0yFmEDxqmrqMqVrwWa/KZhnzO8r
         CGGJReMeC6/l3WTHjw3xMMp9vaX25ZtCpGLyR4ZNc65ejp+IGJ7Ee2t66/aLhJKWov2I
         kTlURX7K4fjuOZrCF7m08/tru7YO8N8Fc9nXfuSwpCFNQ8HFE9hV+Cz/6WiC5RaVmEB+
         cZ74ToaHrbWZ2mKGr8ddjK27cqp5VdJAWcsn2hR6qbKbXWormVVj5cjnyckK25VBlR2d
         JUxALaTZ+ybt/KUpM0dPRTTArlKCtKRCsER/jRR67KJjXd/q0sh6HxTRxjwfozKD+rK8
         S7Mg==
X-Gm-Message-State: AOJu0YyaibnLfpX3L25y5zEIBB1c4VQnnmPtqnSHy2kefVfxkM3Iwzvr
        KMZmx/IFlQzCAsFC0Q1J10g=
X-Google-Smtp-Source: AGHT+IEgarRabzEcG24RtoV2YIp8m8hWRSh94oPfHQvl0dgLnog3qHo8ZEbPuFDN1wXxUV+4gMXAbw==
X-Received: by 2002:a17:907:1de6:b0:9a1:f21e:cdfd with SMTP id og38-20020a1709071de600b009a1f21ecdfdmr4319104ejc.34.1692940423527;
        Thu, 24 Aug 2023 22:13:43 -0700 (PDT)
Received: from [192.168.0.101] (ip5f5aba12.dynamic.kabel-deutschland.de. [95.90.186.18])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090626d600b00993159ce075sm505143ejc.210.2023.08.24.22.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 22:13:43 -0700 (PDT)
Message-ID: <69226eca-d345-f6fa-59fe-3c55674cc534@gmail.com>
Date:   Fri, 25 Aug 2023 07:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] staging: rtl8192e: prefer strscpy over strncpy
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230805075114.15186-1-straube.linux@gmail.com>
 <2023080952-maroon-waviness-9621@gregkh>
 <b15bc777-b470-3c15-5ea7-8ef2f89622c3@gmail.com>
 <cbca3311-2d5d-4b87-8966-e2b57d74d6e1@kadam.mountain>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <cbca3311-2d5d-4b87-8966-e2b57d74d6e1@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 07:01, Dan Carpenter wrote:
> On Wed, Aug 09, 2023 at 08:02:05PM +0200, Michael Straube wrote:
>> On 8/9/23 14:21, Greg KH wrote:
>>> On Sat, Aug 05, 2023 at 09:51:14AM +0200, Michael Straube wrote:
>>>> Replace strncpy with strscpy in two places where the destination buffer
>>>> should be NUL-terminated. Found by checkpatch.
>>>>
>>>> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90
>>>
>>> If a global search/replace could be done, it would have happend a long
>>> time ago.
>>>
>>> How was this tested?  The functions work differently, are you sure there
>>> is no change in functionality here?
>>>
>>
>> It was only compile tested. To me it looked as it does not change
>> functionality, but looking a bit deeper at it I'm not sure anymore.
>> So, we should leave it as is.
> 
> So there are three main differences between strncpy() and strcpy().
> 
> 1) The return.
> 2) strncpy() will always write net->hidden_ssid_len bytes.  If the
>     string to copy is smaller than net->hidden_ssid_len bytes it will
>     fill the rest with zeroes.  This can be important for preventing
>     information leaks.
> 3) strscpy() will always add a NUL terminator where strncpy() just
>     truncates a too long string without adding a terminator.
> 
> We want #3.  We don't care about #1.  The only thing to check is #2.
> 
> regards,
> dan carpenter
> 

Thank you Dan,

so in this case we should/could replace strncpy with strscpy_pad,
correct?

regards,
Michael
