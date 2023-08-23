Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E5785A23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjHWOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjHWOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:14:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242FE59
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:14:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-760dff4b701so52298839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692800061; x=1693404861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMyyon3QN+hbZFoZ/vARY+KF8aozFo5wSbFsmf1im+w=;
        b=TyJYhqK2GWmAHPi/CeEvH/NvYWW+D0hg82sJpQGp71eGJs7eQVQCmfkCjyUvMe+/RR
         Rk07ZHeN0ZgzX8W5zj10TBqqZ5xRbpgGb2y89JPu9L7UizU8VCE6l22wDzJyWRVPYUSR
         /IG73EZhwvpTeJ7+1curpkzsT0UevRniaCou9DqiSZDN1FCzkPUccEWljfQcgZVA+FfF
         6Xkh1gEDTp7V0zOxSMXKHpt0HajJn8mklKV+/4RlIdhEzYtSlhlBbE0R1p5SbdGrG1cF
         Hr+x1OwNwT9p3FyyrMQRaMfc2sPM+TOQ5xl4oDLRqR+K1gy6vctwuBoSoezT/EU/UOOu
         QRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800061; x=1693404861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMyyon3QN+hbZFoZ/vARY+KF8aozFo5wSbFsmf1im+w=;
        b=ZgJ/yOe/oTzXcG3qKaEeyJafgXZzoI5C5xPrxrOSuDAnp4WNBCTw3X7I6aArZOAeSY
         lLz4iQTmuCSL2RdZQlld1LgoS4LA4mqEkG5ziB1RAoJWE8I3onD5eJjImY0rXL0wwmnq
         u8KJyNoLyHQS2hmg0bB2e8MtHFzsEWFobIqA/kl2Vq3jnIdl5hDOd2zKQD3Y6o+cP8Bm
         hcygjZaUmCjRufZz4Wx5lim4BPmvwzT97zi6VS7CvK+9+5W2PXNdraEjo0/eOcoFgwGQ
         MrmhaCwYFt1SMS4xYaHheInKw0WFGd8Lh5dKnV9skZ1VoYQ3qGvQHhplNJ7AFMZDmwJV
         yO8g==
X-Gm-Message-State: AOJu0YwxzGz4t3/1zr/tl4cOnvRDpXK/dIrhxLjPCzx50VhYn0rav0KD
        MvQHnH76dEcWnn/ds0RIEX3Z6A==
X-Google-Smtp-Source: AGHT+IEFsUFZXTWi9MTJZMZ60taXzV6GXYKpibK1KJ8w/iiTj1l7WtpSUSNfDiGCg0jqjod6PDyEHw==
X-Received: by 2002:a05:6602:3a17:b0:791:e6af:a72f with SMTP id by23-20020a0566023a1700b00791e6afa72fmr15481840iob.1.1692800061322;
        Wed, 23 Aug 2023 07:14:21 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c9-20020a5ea809000000b007836c7e8dccsm1900951ioa.17.2023.08.23.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:14:20 -0700 (PDT)
Message-ID: <3d78bf7a-b41c-4989-9ffa-88a24a95a978@kernel.dk>
Date:   Wed, 23 Aug 2023 08:14:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] partitions/ibm: refactor deprecated strncpy
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
References: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
 <20230823134936.14378-E-hca@linux.ibm.com>
 <20230823141304.14378-F-hca@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230823141304.14378-F-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 8:13 AM, Heiko Carstens wrote:
> On Wed, Aug 23, 2023 at 03:49:36PM +0200, Heiko Carstens wrote:
>> On Tue, Aug 22, 2023 at 11:59:26PM +0000, Justin Stitt wrote:
>>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>>
>>> A suitable replacement is `strscpy` [2] due to the fact that it
>>> guarantees NUL-termination on its destination buffer argument which is
>>> _not_ the case for `strncpy`!
>>>
>>> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
>>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>>> Link: https://github.com/KSPP/linux/issues/90
>>> Cc: linux-hardening@vger.kernel.org
>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>>> ---
>>>  block/partitions/ibm.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
>>> index 403756dbd50d..e5893cf71b57 100644
>>> --- a/block/partitions/ibm.c
>>> +++ b/block/partitions/ibm.c
>>> @@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
>>>  		    !strcmp(temp, "LNX1") ||
>>>  		    !strcmp(temp, "CMS1")) {
>>>  			if (!strcmp(temp, "VOL1")) {
>>> -				strncpy(type, label->vol.vollbl, 4);
>>> -				strncpy(name, label->vol.volid, 6);
>>> +				strscpy(type, label->vol.vollbl, 4);
>>> +				strscpy(name, label->vol.volid, 6);
>>>  			} else {
>>> -				strncpy(type, label->lnx.vollbl, 4);
>>> -				strncpy(name, label->lnx.volid, 6);
>>> +				strscpy(type, label->lnx.vollbl, 4);
>>> +				strscpy(name, label->lnx.volid, 6);
>>>  			}
>>>  			EBCASC(type, 4);
>>>  			EBCASC(name, 6);
>>
>> I'm quite sure this is not correct, since both type and name are not
>> necessarily NUL-terminated, and this code operates on purpose on such
>> strings.
>>
>> Since currently Stefan and Jan are both not available, I added Peter
>> Oberparleiter to Cc who hopefully knows better than me.
> 
> I was just made aware of that this patch is already in linux-next. And
> indeed: partition detection does not work anymore for DASDs. With this
> patch reverted it works again.
> 
> Jens, can you remove or revert this patch again, please?

Yep will drop it for now.

-- 
Jens Axboe

