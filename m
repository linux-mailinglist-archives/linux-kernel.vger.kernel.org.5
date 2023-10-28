Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F557DA6A2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjJ1LGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1LGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:06:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15753B4;
        Sat, 28 Oct 2023 04:06:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564b6276941so2408760a12.3;
        Sat, 28 Oct 2023 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698491166; x=1699095966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtYtgyOM9UtFee+JFxK1SBHozQSbcJd7lO6xgsYMlqs=;
        b=FF8Kul9kYeTGNBzg9Thx52tM3b3B5I3vzCWqDHtfMFDuUbOLVW7NArAYOs0WRqXJCH
         RnC57G4T7Pi2jzesXTXRjmGKAV+GMbyPrcT56FGV+x1F5Udxia5XG4mWav2wUryMxHvC
         sXx1QAtCnD42Qp795++g9gzWCH40SgNNxA7Uyr0qz9E60D8xFD+GNpgHJo7pDYmfqGEk
         8KlK72iN/lzcnhDvRYqHcaxIhZsGdeSj3hRy+72s5E3o5I4ynvYobB+nRNiBgVVXoBjx
         3fzI4ag/07kRjuswCYzkRfJrY1Krtozd440QAGh3KpHpzLPx7lCgt9VrK5lIRd18i++q
         EMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698491166; x=1699095966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtYtgyOM9UtFee+JFxK1SBHozQSbcJd7lO6xgsYMlqs=;
        b=W6eHAyKh8kAVD8thM6QoR2ct2wgq2pXRkkZaWxIjRFlpf12X/jj6U2TOwUjGC1me4a
         uD1AykBAWh4i13wWKw88KODJyD7We4YXy0+2W7eUuFUsE4+YpyKrHUi2P/n/hcJeMmqH
         0YJWnbrf76+bsJ3wCPFHyDOL4pmCtKPldu4FcJ4Bribj2HzbYTcsC+ZoHm2Hi/YOFDzs
         2ASaKVLL37znO/jf+nKEAAsd2MwFO6RbtXS9ySnrTjbbDGXfpZQcQcqKxYcq+oMc8Dze
         V7Lg7sYy+3Sx3/oWAjZSMOzTxarftIVAelyKaGQvMFBGCSDnJN1WXwAz7G8B8pG/CB28
         f6vg==
X-Gm-Message-State: AOJu0YyEm1tcus7MZsnvJ6/iDXtTORWxanN55BCPNNuST5kFOs+5qN5r
        UA0dykhMABOqnwXnNxL3p2M=
X-Google-Smtp-Source: AGHT+IHJITxpOSrEzugXRqz4MUXI5stA8yntxtM6zq/Z8aAygi7sn+DbIkgrJI5A5auo3ycqd3M6rA==
X-Received: by 2002:a05:6a20:4323:b0:17b:9d92:7d0 with SMTP id h35-20020a056a20432300b0017b9d9207d0mr6723863pzk.52.1698491166458;
        Sat, 28 Oct 2023 04:06:06 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fa41-20020a056a002d2900b006bf536bcd23sm2781936pfb.161.2023.10.28.04.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 04:06:05 -0700 (PDT)
Message-ID: <68ad3c1c-bc5b-4dd5-9183-202d8b04b45f@gmail.com>
Date:   Sat, 28 Oct 2023 18:05:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: storage: set 1.50 as the lower bcdDevice for older
 "Super Top" compatibility
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LihaSika <lihasika@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux USB Storage <usb-storage@lists.one-eyed-alien.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Milan Svoboda <milan.svoboda@centrum.cz>,
        Matthieu Castet <castet.matthieu@free.fr>
References: <ZTsR-RhhjxSpqrsz@debian.me>
 <055de764-c422-4c22-a79b-dd4db56122ce@gmail.com>
 <2023102704-stable-lid-c86a@gregkh>
 <7484f7c8-a49c-4111-83f0-bb6db2906fae@gmail.com>
 <2023102729-spent-ninja-7e39@gregkh>
 <037e5af2-3afd-4a37-a4d7-6dc87af605c7@gmail.com>
 <21c2b8ee-7753-413e-98f9-d1401edf5c73@gmail.com>
 <2023102720-emotion-overlying-9bb4@gregkh>
 <ccf7d12a-8362-4916-b3e0-f4150f54affd@gmail.com> <ZTyyDXYR4f6WKdLM@debian.me>
 <2023102848-esteemed-reptile-851f@gregkh>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2023102848-esteemed-reptile-851f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2023 17:23, Greg Kroah-Hartman wrote:
> On Sat, Oct 28, 2023 at 02:02:37PM +0700, Bagas Sanjaya wrote:
>> On Fri, Oct 27, 2023 at 08:28:04PM +0300, LihaSika wrote:
>>> Change lower bcdDevice value for "Super Top USB 2.0  SATA BRIDGE" to match
>>> 1.50. I have such an older device with bcdDevice=1.50 and it will not work
>>> otherwise.
>>
>> What about below description?
>>
>> ```
>> Some old USB hard drives using Super Top USB 2.0 SATA bridge have lower
>> minimum bcdDevice value than currently allowed (1.60). Such devices
>> cannot be used by ums-cypress driver since their bcdDevice is out of range.
>>
>> Lower minimum bcdDevice to fix that. 
>> ```
>>
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Liha Sikanen <lihasika@gmail.com>
>>
>> Is your intended author name in your From: header or Signed-off-by: trailer?
>>
>> Also, don't forget to add Fixes: tag; that is:
>>
>> Fixes: a9c143c82608 ("usb-storage: restrict bcdDevice range for Super Top in Cypress ATACB")
>>
>> When above reviews are addressed, resend as v2. Make sure that the patch
>> subject begins with `[PATCH v2]`.
> 
> There's no need, I can take this as-is, thanks.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

