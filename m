Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE87B1234
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI1FpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1FpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:45:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F1F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:45:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c63164a2b6so38096375ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695879911; x=1696484711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1po4QCL/vfZvRXEI6cbnozLV6z7wkt57VPjtFFVRx+4=;
        b=azIFbW7nBqPJ5JYqkp06XJlvhRQo7hQqTZD2Vv5sAtkd4GYVwxAa2aK3+9ftZ2rN1G
         KOAb/KRqsyKNPFIIBOpmc4byY+BuuqvmTNTcCT4JoMlgek2F3SGgQnSYFA3YCLSKq6RL
         MfWYuUjRbjTdQauL+3KHHA6wlxUsYUqB+kvjGW5KDeKytSTtn7Owwt9MqFjMDH3Spzx9
         0klBMZ9NIheH8UxYnPQymHrUfOs3TK8bHukmG/v3FqIV66QmbdLQ1HYn2iYnp7FuZlK0
         MSEqyO21GiLNVuglYmopFx3MS+76GX6awnDPrWsWlT0CRxmA0yjXGe50XX9OQgJLpD3Q
         D33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695879911; x=1696484711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1po4QCL/vfZvRXEI6cbnozLV6z7wkt57VPjtFFVRx+4=;
        b=BnMiV7Z0JjwIlLtmOvEAJjqdoo+A1p+V+XJu3lWwRRf2XVzi4Jwu84nBYa6NMGvgq/
         U0mANZYhGjPqJSyXrwibP49w1pdv9WNxYKNSoP+rmnRNmGAPTSXd2zXjT22L9YpR544t
         kCd/5GsPQqnfaFRR0QzXTak18mZG2IAWO8WeHl/2kfuyekmN7pZeksZbyi1zVZmSCp03
         WhJGt+qv4RJC6CkdSYbBHqcgn9CrbhW0aGShnLHb3AGCYgFSPQrGD02iqEKQpYVldrrx
         nHh8LZqIbeLYtowDTFoyhdtKjSDxFrVl4YzXLjH6cY29llbroDm6ZIYEvryoNB3cVpZB
         +Bzg==
X-Gm-Message-State: AOJu0Yx2M7jzn5m2e7Qjvq51I622Ema8IJoiEt6MKdlMjGLL6UjXsaAj
        aP3yCWQHKzg6/JpwRigehTw=
X-Google-Smtp-Source: AGHT+IELqje0FoM85hxwVlD34PuP+Nlgusq598wS6q3HJ7NppiBtH6Zwj3AAUJB3sL8cq8jwBinliA==
X-Received: by 2002:a17:902:d4ce:b0:1c4:5a9:a45e with SMTP id o14-20020a170902d4ce00b001c405a9a45emr292775plg.27.1695879911271;
        Wed, 27 Sep 2023 22:45:11 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001c61901ed37sm7634233plb.191.2023.09.27.22.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 22:45:10 -0700 (PDT)
Message-ID: <d853c947-c939-440b-9dd1-063c70e16509@gmail.com>
Date:   Thu, 28 Sep 2023 12:45:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My brand new vivo V25 Pro 5G Android mobile phone is running on
 Linux kernel 4.19.191+
To:     Turritopsis Dohrnii Teo En Ming <tdtem@protonmail.com>
Cc:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ceo@teo-en-ming-corp.com
References: <P8CgyFkx_9MPXgwLiaVhdarl-IlxfJVH1voL4ttdXP0yJcLyE5nw9y537LZceOC6BkXVxzuwXjQHmeGGUDI_VbPgfDXengI-5A9ua9csUqc=@protonmail.com>
 <ZQzlFgJTZzTVkKeN@debian.me>
 <BeZs4jBxhofIdjWavbuANlZ5zUrV2Wtdf9QMX5CPx_X_KT4PvKvD8c4Qc0LP_LPjKyvIy3SOjTMFgkq4xlrSKSubWZrzJLuudmSCo1Q9wLE=@protonmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <BeZs4jBxhofIdjWavbuANlZ5zUrV2Wtdf9QMX5CPx_X_KT4PvKvD8c4Qc0LP_LPjKyvIy3SOjTMFgkq4xlrSKSubWZrzJLuudmSCo1Q9wLE=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 22:40, Turritopsis Dohrnii Teo En Ming wrote:
> 
> 
> 
> 
> 
> Sent with Proton Mail secure email.
> 

When replying to public mailing lists (like LKML), use Reply-all
button on your mail client. And also, don't top post; reply inline
with appropriate context instead.

See also Documentation/process/email-clients.rst for why you should
not use Proton Mail (spoiler: encrypted mail lock-in).

> ------- Original Message -------
> On Friday, September 22nd, 2023 at 8:51 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> 
>> [trimming personal and obvious political info]
>>
>> On Thu, Sep 21, 2023 at 04:20:06PM +0000, Turritopsis Dohrnii Teo En Ming wrote:
>>
>>> My brand new vivo V25 Pro 5G Android mobile phone is running on Linux kernel 4.19.191+. Are there any severe/critical security vulnerabilities in Linux kernel 4.19.191+ that will allow government-sponsored or state-backed hackers or Advanced Persistent Threats (APTs) to take over absolute control of my brand new vivo mobile phone? Can I download, compile and install the latest Linux kernel 6.5.4 from sources on my brand new vivo mobile phone by myself? I would like to know how I can do it.
>>
>>
>> There are Android Security Bulletin listings on [1], with vivo-specific
>> bulletins can be found at [2].
>>
>> For building kernels, you can follow official Android guide [3]. Or
>> you can also visit XDA forums [4] where people posted their own custom
>> kernels. But usually your vendor (vivo) takes care of kernel updates
>> anyway.
> 
> So if I want to build the latest Linux kernel 6.5.4 for my vivo V25 Pro 5G mobile phone, I can follow the guides at link [3] and link [4].
> 

Good luck hacking Android kernel for your phone!

>>> Opening and using apps is now a slow and painful experience. The phone camera is even worse. Taking a photo or selfie takes 2-3 seconds. If you move the phone by a bit before the 3 seconds is up, your photo or selfie will turn out very blur. So you need to set a timer of 2 seconds when you take a selfie or photo. Taking videos with the phone camera is also very laggy and choppy. The recorded video will turn out to be choppy.
>>
>>
>> What is your Samsung phone specification then?
> 
> My Samsung phone is the Samsung Galaxy A32 5G. The specs can be found on gsmarena.com.
> 

Link please?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

