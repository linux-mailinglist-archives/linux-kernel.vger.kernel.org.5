Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527EC7A5CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjISIuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:50:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722C116;
        Tue, 19 Sep 2023 01:49:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404724ec0dcso14178075e9.1;
        Tue, 19 Sep 2023 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695113392; x=1695718192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exiMKXlmKqEZjAmWh24CVE5oMgfZfVOUNfwCFRqqxrU=;
        b=Q0+rPjYH4Br1JAvfXUCt4szAQENB1i3QaZbMfC/xM0p3DvtYNmhHRAVj6bp9fj7oc0
         n64VWZQkTueQ/gF+HItgcwbEEAO6aOJXbPPN46twuHmSphSeRNkMue30wuFg0Ul/ZY1a
         vaP2YY3eFo74iouD93geqFFFt40N2iEak2C3y0XUQ61V6xMhBQ/C2ALLhsvh+I/E2ec6
         OgIxPs3ZX/KAnslZp8mBsGXsefHqjhYY1+koW08tQfBdg0gulAFUmMT+rdMmLv3OfZFT
         K45N05H0zLUaZKMMBn0zMst/ME04hUFoTdcUNutI+Vh6TGnIpY4cEXPO4dxpg3bUVkqe
         S3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113392; x=1695718192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exiMKXlmKqEZjAmWh24CVE5oMgfZfVOUNfwCFRqqxrU=;
        b=Y4MERR1YaxX5WKHxAxZyLN4mUO2ywMMM4/WJ48N5oATdPPuDF6gFcRq0xcLZKtldOF
         s4tqLnGSYwvRA8aam2Zvxjvi1BdpQVvenr/72cvkGZ3nut3cCtywhp+gfTFpbyroA9Jg
         kWISijQUmn9evSwADtP6IdqE4m16pvbea2n2V9BDhuWajP+KBE7yp5t5zgx/koGUvNZr
         P2qnP5iaXAd/cEouAXMRgEYqCUAdYJ76E3ChAgiHrMF7+G+csfgxhVffHXwry0/wTMp/
         gAc5dMZ+tO+osCG/cHToA4iyfRwcloeIB5rgxXZiCn89L4OOjqZ3GSAYFaJVGR1DDaZE
         SQkg==
X-Gm-Message-State: AOJu0Yx1gbftuSs/mdhueGxYNZjLSLtlIPyU+krP/o5Hadi/8X2SHHfk
        ebL02sL1ihZ19dPK1avBNTo=
X-Google-Smtp-Source: AGHT+IFSaZXdS6lNtcobsxSr4Tq131VXS6gtxOTc+ltT4kbOMLdLQVVah9+36WNOCjKJUKpGxTTu/Q==
X-Received: by 2002:a05:600c:3ba3:b0:3fe:dd78:8fbc with SMTP id n35-20020a05600c3ba300b003fedd788fbcmr10297405wms.3.1695113392326;
        Tue, 19 Sep 2023 01:49:52 -0700 (PDT)
Received: from [10.0.0.26] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003fbe4cecc3bsm17296088wmc.16.2023.09.19.01.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:49:51 -0700 (PDT)
Message-ID: <cfd84f9f-a549-a90d-5a24-b4f36ab085df@gmail.com>
Date:   Tue, 19 Sep 2023 12:49:49 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] ALSA: docs: Add Marian M2 driver documentation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
 <878r92bnnx.fsf@meer.lwn.net>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <878r92bnnx.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 11:57, Jonathan Corbet wrote:
> Ivan Orlov <ivan.orlov0322@gmail.com> writes:
> 
>> Add documentation for the new MARIAN Seraph M2 sound card. It covers
>> current development status, available controls of the card and
>> information about the integrated loopback.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>> V1 -> V2:
>> - Remove redundant documentation fix from the next patch in the series
> 
> One quick comment below...
> 
>>   Documentation/sound/cards/index.rst     |   1 +
>>   Documentation/sound/cards/marian-m2.rst | 104 ++++++++++++++++++++++++
>>   2 files changed, 105 insertions(+)
>>   create mode 100644 Documentation/sound/cards/marian-m2.rst
>>
>> diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
>> index e68bbb13c384..e873592d8d00 100644
>> --- a/Documentation/sound/cards/index.rst
>> +++ b/Documentation/sound/cards/index.rst
>> @@ -19,3 +19,4 @@ Card-Specific Information
>>      serial-u16550
>>      img-spdif-in
>>      pcmtest
>> +   marian-m2
>> diff --git a/Documentation/sound/cards/marian-m2.rst b/Documentation/sound/cards/marian-m2.rst
>> new file mode 100644
>> index 000000000000..bf12445e20d7
>> --- /dev/null
>> +++ b/Documentation/sound/cards/marian-m2.rst
>> @@ -0,0 +1,104 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=======================
>> +MARIAN Seraph M2 Driver
>> +=======================
>> +
>> +Sep 18, 2023
>> +
>> +Ivan Orlov <ivan.orlov0322@gmail.com>
>> +
>> +STATE OF DEVELOPMENT
>> +====================
>> +
>> +This driver is based on the driver written by Florian Faber in 2012, which seemed to work fine.
>> +However, the initial code contained multiple issues, which had to be solved before sending the
>> +driver upstream.
> 
> Sticking to the 80-column limit is best for documentation, especially
> when there is no reason to go over it.
> 
>> +The vendor lost the full documentation, so what we have here was recovered from drafts and found
>> +after experiments with the card.
>> +
>> +What seems to be working fine:
>> +- Playback and capture for all supported rates
>> +- Integrated loopback (with some exceptions, see below)
>> +
>> +MEMORY MODEL
>> +============
>> +
>> +The hardware requires one huge contiguous DMA space to be allocated. After allocation, the bus address of
>> +this buffer should be written to the hardware register.
>> +
>> +We can split this space into two parts: the first one contains samples for capture, another one contains
>> +play samples:
>> +
>> +CAPTURE_CH_0, CAPTURE_CH_1, ..., CAPTURE_CH_127 | PLAY_CH_0, PLAY_CH_1, ..., PLAY_CH_127
> 
> You should really use literal blocks for this (and a lot that follows)
> or it won't render the way you want in HTML.  The simplest way to do
> that is to use a double colon ("...samples::") and to indent the literal
> text.
> 
> (OK, two comments, sorry about the off-by-one...:)
> 
> Thanks,
> 
> jon

Hi Jonathan,

Thank you for the review, I'll rewrite the documentation so it will 
follow the 80-column rule. Also, in the next version I will use the 
literal blocks.

Thanks again!

--
Kind regards,
Ivan Orlov
