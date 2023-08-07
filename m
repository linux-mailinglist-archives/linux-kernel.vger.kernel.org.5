Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC4771C24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHGIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:17:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C992170A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:17:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68706b39c4cso2793080b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691396252; x=1692001052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TboXqCz1t13S/bxUXpE9lmU/gBRz2RjSTcLQe4KLQB8=;
        b=ZN3xd0jwNy71Y35zWfAsWPL3CUIRQsJ16pSUWQw4NkNSP0Uyz6aqasF17ihPpiac8u
         huB+t5v9gWy2fiixSssIDwRyhi7QaFK+SGwVXVKdd2p366/CtZ4INlh6UZUXOdakAnWf
         +ZFPLr/wag+R3fhSDdmYbI/M7/RgMWwyDVOMDACOTVtI2GgaDmVxBgaL9DvPF1zeAlC7
         tZycIiQquFKWHwbUEn8ZMzw+Djk3djMcxWnH4Df9RPFOayFanASBHUf5ZGceeLATz7Z0
         COQgyQJNlj7psNCveG/nYlCx8xkvFoHiwMg/popWTFn1AoxvK/xg/No3ed4tJx0G5H3N
         +ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396252; x=1692001052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TboXqCz1t13S/bxUXpE9lmU/gBRz2RjSTcLQe4KLQB8=;
        b=KEy4o6bxuxefbYK0LpwnOk37mnWhz2f5XsLTqWej2oqb4NkG1iGpv8kYoqNLiJ3Btc
         kXLq8p5YsUkhKVz+4HhrpR7q7Kf+3+fVW1CqO1lMrAfSJOtuN8Nd7JjMGYPj7d+4tHfX
         oLhExiKqtac/tnmaY2buccDVEFbXQYEjmZoPPzNN+TvPKDxeo98FPYhN/5r844i5ty9K
         QRSgf0VMr4nAxTerBy2wKdqY9qzrc6d25tzSGOxwE1ypabq+MpXHz3hmMmMezxs5u+w0
         +OoYLvBDnjIs8VFZ4EJ0co9x2O9NURSMkbM3PVfSfAEt2kXin6cNVzFVkoW4zs8Q/XsR
         4+Bw==
X-Gm-Message-State: AOJu0Ywwauajil3Jo1pDVt+EhvGqeut0rRkN3AbGwd8u4noNPNUS6fsl
        daMfAWIUiWEIvxFnKhNHVbY=
X-Google-Smtp-Source: AGHT+IGGVKd8hRDvddAdD13ZeVuJOkzWR0piVGHE2QK6bMCU0/Oq7GCsY9oWdWSP6pDAuUaDyLqu1Q==
X-Received: by 2002:a05:6a20:8f06:b0:133:6b64:c92 with SMTP id b6-20020a056a208f0600b001336b640c92mr9551444pzk.44.1691396252480;
        Mon, 07 Aug 2023 01:17:32 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.242.210])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b0064398fe3451sm5521099pfn.217.2023.08.07.01.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:17:32 -0700 (PDT)
Message-ID: <8d20e867-1c13-4d2a-9802-b9570085fd25@gmail.com>
Date:   Mon, 7 Aug 2023 13:47:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] refactor file signing program
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh>
 <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
 <2023053148-ahead-overbite-863d@gregkh>
 <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
 <2023060155-mustard-mating-32b7@gregkh>
 <CAK7LNASUmc1nFEkEvmd9VKbD6VjOs2HhpwLY-GsduRFDFGOfvg@mail.gmail.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <CAK7LNASUmc1nFEkEvmd9VKbD6VjOs2HhpwLY-GsduRFDFGOfvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/23 07:53, Masahiro Yamada wrote:
> On Thu, Jun 1, 2023 at 6:08 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jun 01, 2023 at 02:33:23PM +0530, Shreenidhi Shedi wrote:
>>> On Wed, 31-May-2023 22:20, Greg KH wrote:
>>>> On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
>>>>> On Wed, 31-May-2023 20:08, Greg KH wrote:
>>>>>> On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
>>>>>>> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
>>>>>>> Can you please review the latest patch series? I think I have addressed your
>>>>>>> concerns. Thanks.
>>>>>>
>>>>>> The big question is, "who is going to use these new features"?  This
>>>>>> tool is only used by the in-kernel build scripts, and if they do not
>>>>>> take advantage of these new options you have added, why are they needed?
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> Hi Greg,
>>>>>
>>>>> Thanks for the response.
>>>>>
>>>>> We use it in VMware Photon OS. Following is the link for the same.
>>>>> https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4
>>>>>
>>>>> If this change goes in, it will give a slight push to our build performance.
>>>>
>>>> What exactly do you mean by "slight push"?
>>>
>>> Instead of invoking the signing tool binary for each module, we can pass
>>> modules in bulk and it will reduce the build time by couple of seconds.
>>
>> Then why not modify the in-kernel build system to also do this, allowing
>> everyone to save time and money (i.e. energy)?
>>
>> Why keep the build savings to yourself?
>>
>> thanks,
>>
>> greg k-h
> 
> 
> If I understand correctly,
> "sign-file: add support to sign modules in bulk"
> is the only benefit in the patchset.
> 
> I tested the bulk option, but I did not see build savings.
> 
> 
> 
> My evaluation:
> 1.  'make allmodconfig all', then 'make modules_install'.
>          (9476 modules installed)
> 
> 2.  I ran 'perf stat' for single signing vs bulk signing
>        (5 runs for each).
>        I changed the -n option in scripts/signfile.sh
> 
> 
> 
> 
> A.  single sign
> 
> Sign one module per scripts/sign-file invocation.
> 
> find "${MODULES_PATH}" -name *.ko -type f -print0 | \
>          xargs -r -0 -P$(nproc) -x -n1 sh -c "..."
> 
> 
> 
>   Performance counter stats for './signfile-single.sh' (5 runs):
> 
>               22.33 +- 2.26 seconds time elapsed  ( +- 10.12% )
> 
> 
> 
> 
> B. bulk sign
> 
> Sign 32 modules per scripts/sign-file invocation
> 
> find "${MODULES_PATH}" -name *.ko -type f -print0 | \
>          xargs -r -0 -P$(nproc) -x -n32 sh -c "..."
> 
> 
>   Performance counter stats for './signfile-bulk.sh' (5 runs):
> 
>               24.78 +- 3.01 seconds time elapsed  ( +- 12.14% )
> 
> 
> 
> 
> The bulk option decreases the process forks of scripts/sign-file
> but I did not get even "slight push".
> 
> 
> 

That's some really interesting data. I'm surprised that with stand alone 
run bulk signing is not performing as expected. Can you give the full 
command you used for bulk sign? Reduced number of forks should 
eventually lead to getting more done in less time.

But I got ~1.4 seconds boost when I did "make module_install".

I gave the data in my other response as well. Copying the same here 
because this has in better context.

root@ph5dev:~/linux-6.3.5 # ./test.sh orig

real	0m14.699s
user	0m55.519s
sys	0m9.036s

root@ph5dev:~/linux-6.3.5 # ./test.sh new

real	0m13.327s
user	0m46.885s
sys	0m6.770s

Here is my test script.
```
#!/bin/bash

set -e

if [ "$1" != "new" ] && [ "$1" != "orig" ]; then
    echo "invalid arg, ($0 [orig|new])" >&2
    exit 1
fi

rm -rf $PWD/tmp

s="scripts/sign-file.c"
m="scripts/Makefile.modinst"
fns=($s $m)

for f in ${fns[@]}; do
      cp $f.$1 $f
done

cd scripts
gcc -o sign-file sign-file.c -lcrypto
cd -

time make modules_install INSTALL_MOD_PATH=$PWD/tmp -s -j$(nproc)
```

-- 
Shedi

