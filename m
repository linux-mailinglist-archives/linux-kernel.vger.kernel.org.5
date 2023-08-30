Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E378E10C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjH3U4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjH3U4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:56:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD1CD6;
        Wed, 30 Aug 2023 13:56:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007c8308c3so479236e87.0;
        Wed, 30 Aug 2023 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693428902; x=1694033702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Udxb/qQo1p8Z+MDmbTBUbKzMtdm6Oq0GxFma8TsU8Zk=;
        b=qZi3KlJX1W2WceRok9Da+Qt4dk2Gr64tSk4xQafH/0ocztWkjeBeyPIipE6mwi+OLZ
         XLHSfWnrG5st0DK9TxTU8ZxK1z3c461nV2x4ZIiMBAOC7c2/FgiQZvD4ATqLfjroVWLL
         4pfzWud3oRVSue2C0E79EXm/7jqTjzRzA7EQX+ug2BBwKv/JBAdbJCa6cgodaqLF4Vza
         xDSCq5RbxLpFezYL413TyCfge130qjrd5jsUW4OIvNSLX3pB+lXWPt+ZVeGYXNxeGWnl
         /lQ4WMy0or4/CcvYvZ9nT1dWtCyWshjiVfu+jnL0MDpa38L/uYzjn8ELsRkSWPR51Em/
         TgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428902; x=1694033702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udxb/qQo1p8Z+MDmbTBUbKzMtdm6Oq0GxFma8TsU8Zk=;
        b=dBJktzHEWJk2BAvLZkpR5dhxqJRi3RDIBQBOBuSwrK+nt2HMDLUGapLKlj5cQQMsjE
         oYqSr+BIJBUV3aTl0O5kxoihIa1gbjpy62Ih6QCDjF45FAymEwr5ahcJ7ROPYyFLLwvg
         QciqijGM7V5cm3kZIeJfoRLnVlHmthix4OLsF9XRNKgWV30lztgcIcmDqY0uyY85zAtR
         Z2hGgENsMfwJ3GaKt70rVsN+YgIEdVQB7sT8sQJ4HuoO1OnQrMW1usEiBOL9HV4G0bjo
         zTpSNVWfR45W9cSiZKfKPvwEaTxvMqQwI/kFEbgomS2x2YV54k2UgPhbNQWg8v9fNBpY
         wvMA==
X-Gm-Message-State: AOJu0YwFsuPE6eeBuknthnlp3VovR9wYgNZehh1vbzozlJzkNJmyfrJu
        bDsENl+Dihy/uUDOtBhPsKumj51GFuE=
X-Google-Smtp-Source: AGHT+IEd83HZEK9PQdUm3/KOvgiwNFVVM3zGuDXye5UFrdF/jSBm7lVUfkHIq6Nvp4gBJ3LgsjKYQw==
X-Received: by 2002:a05:651c:228:b0:2bc:b61d:44c9 with SMTP id z8-20020a05651c022800b002bcb61d44c9mr2612112ljn.53.1693427948523;
        Wed, 30 Aug 2023 13:39:08 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ch26-20020a170906c2da00b0099de082442esm7539315ejb.70.2023.08.30.13.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:39:08 -0700 (PDT)
Message-ID: <c4c48d12-c4ce-4bdc-a3f9-c6020067681b@gmail.com>
Date:   Wed, 30 Aug 2023 22:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb-storage: how to extend quirks flags to 64bit?
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f9e8acb5-32d5-4a30-859f-d4336a86b31a@gmail.com>
 <6f8b825b-bc41-4080-8128-4a6f0a43f779@rowland.harvard.edu>
 <34aa2eea-5417-4e46-91a0-aac1a46a84cf@gmail.com>
 <2d580337-eaf3-47fb-afa7-1006d9a257ea@rowland.harvard.edu>
Content-Language: en-US
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <2d580337-eaf3-47fb-afa7-1006d9a257ea@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/27/23 20:55, Alan Stern wrote:

...

>>>> Someone will need a new quirks flag in the future anyway... :)
>>>
>>> I can think of only one way to accomplish this on 32-bit systems: Change
>>> the driver_info field from a bit array to an index into a static table
>>> of 64-bit flags values.  Each unusual_devs structure would have its own
>>> entry in this table.  As far as I can tell, the other unusual_*.h tables
>>> could retain their current driver_info interpretations, since no new
>>> quirk bits are likely to be relevant to them.
>>>
>>> Making this change would be an awkward nuisance, but it should be
>>> doable.
>>
>> Hm, yes, thanks for the idea,that is a possible solution.
>> It will need to modify all unusual macros, though. Just I am not sure I want
>> to spent time patching all the drivers as I have not way how to test it.
> 
> I don't think it will be necessary to change all those macros, just the
> ones in usual_tables.c.  And to create the new table containing the
> actual flag values, of course.
> 
> There will also have to be a new argument to usb_stor_probe1()
> specifying whether the id->driver_info field is standard (i.e., it
> contains the flags directly) or is one of the new indirect index values.
> 
> And you'll have to figure out a comparable change to the dynamic device
> ID table mechanism.
> 
> (If you want to be really fancy about it, you could design things in
> such a way that the indirect flags approach is used only on 32-bit
> systems.  64-bit systems can put the new flag bits directly into the
> driver_info field.  However, it's probably best not to worry about this
> initially.)

Hi Alan,

So, I really tried this approach, spent more time on in than I expected, but
produced working code... that I am really not proud of :-]
(Thus avoiding to send it here, for now.)

I pushed it to my dm-cryptsetup branch here
https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/log/?h=dm-cryptsetup

The last patch is the reason why I need it, just for reference.
More comments in the patch headers.

Could you please check it if it is *really* what we want?
If so, I'll rebase it for usb next tree and send as a patchset.

But the macro magic is crazy... and I really did not find the better way.

Anyway, it also uncovered some problems
  - some macros need to be changed a little bit, there is even old one unused
  - duplicity of entries in UAS and mass-storage are strange (and complicates
    the approach).
    I guess the sorting is intentionally that mass-storage is included
    before UAS, so the mass-storage quirk is found as the first (for non-UAS).
    (While UAS drive includes only own header.)
- the patch significantly increases size of module for 32bit
   (64bit system use the direct flag store approach)
- I stored a pointer to the flags array, not the index. Perhaps it should be
   index only (trivial change, though).

Thanks,
Milan


