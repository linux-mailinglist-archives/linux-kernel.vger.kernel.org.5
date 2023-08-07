Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A90771DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHGKWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHGKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:21:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50910F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:21:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26837895fc8so2285729a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691403709; x=1692008509;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PyywCoLGp+O1Z93Z2utq9Fum5HGEIspUHxjWPAtdoyw=;
        b=Fyes8BdIBi6QT4FSfS3cg6xpIbgJaloNxe2QjDPRbTv9UT73KjBHeeSj7R/2mfqJPQ
         6bm8kE70rYTzU1LiVF880qxeEScCJJ73ylk3Ojte2hqXmLCJdwKVPGDk4fXgEoASMJwT
         rEYrxvk+NpEXXgZXE2Fq2wxuOai3CyiLDX5amAZtLpf2Vb8c4fhqEyI2gLglGJ43GEFG
         p6rg58D6oQ718LI43gTTW7F2eV0kZ0sWjW+3vPmAsLna+tDV7VKTnMkABYVyl4B3mHLD
         WyVtDaIHgBCCs5D4R1O0KG+KaKdDtjci5CvMb3ZDF+ckcw0eyR5IJKOGNRFnSnRH/Zsp
         hmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691403709; x=1692008509;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyywCoLGp+O1Z93Z2utq9Fum5HGEIspUHxjWPAtdoyw=;
        b=Vt9KtPSZQctlUDoV0PJpN+quc4gcCcTUBq1hCjC3Q6ej2tsOy1Go2zPRAuhu/2ne2c
         xwD1ndkaDkHlKuSVet0FZWAR7dUeSfddl8yivBkL9vM3zsiTogFy6IVud7uC8aY5eTGN
         IzSOrXLuDup1BQyMxkvojz+4gZqu/F8jhbeVVcxiQ3zmbu2qtowEXXD39+Je/48annOp
         vUe90nCgFqjPLZJnExWKWeHQjHdRjurL4KRJUGjGZI+lYcDQya5NB0dwsdTmAyjys4wh
         D1H8S/s16VbNhpXl5HRnwAqqZZf71BCHoc+HHz8yIMoKMyOqXH1Upl3UshTfSJo+6qB0
         yfkQ==
X-Gm-Message-State: AOJu0Yzws0q3Xq4siLFN6k3UeJLcdHIXeOaV1Zg58k0XeE/ENKms4DZi
        iGUlPc18Z0iZhzb2VLxPqfI=
X-Google-Smtp-Source: AGHT+IHm/aA2JfIrQOTKBW2DCE5zrxBiEIhsXUfCtgpZRCvHOajBYjBI0e07A4Bel50TYtKRe3JQ9A==
X-Received: by 2002:a17:90b:607:b0:268:1e95:4e25 with SMTP id gb7-20020a17090b060700b002681e954e25mr6388941pjb.17.1691403709254;
        Mon, 07 Aug 2023 03:21:49 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.242.210])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090a380400b0026822cb85casm6244365pjb.18.2023.08.07.03.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 03:21:48 -0700 (PDT)
Message-ID: <ccbe4bd6-5550-48ce-b056-42fc47e2e468@gmail.com>
Date:   Mon, 7 Aug 2023 15:51:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] refactor file signing program
From:   Shreenidhi Shedi <yesshedi@gmail.com>
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
 <8d20e867-1c13-4d2a-9802-b9570085fd25@gmail.com>
Content-Language: en-US
In-Reply-To: <8d20e867-1c13-4d2a-9802-b9570085fd25@gmail.com>
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

On 07/08/23 13:47, Shreenidhi Shedi wrote:
> On 07/08/23 07:53, Masahiro Yamada wrote:
>> On Thu, Jun 1, 2023 at 6:08 PM Greg KH <gregkh@linuxfoundation.org> 
>> wrote:
>>>
>>> On Thu, Jun 01, 2023 at 02:33:23PM +0530, Shreenidhi Shedi wrote:
>>>> On Wed, 31-May-2023 22:20, Greg KH wrote:
>>>>> On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
>>>>>> On Wed, 31-May-2023 20:08, Greg KH wrote:
>>>>>>> On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
>>>>>>>> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
>>>>>>>> Can you please review the latest patch series? I think I have 
>>>>>>>> addressed your
>>>>>>>> concerns. Thanks.
>>>>>>>
>>>>>>> The big question is, "who is going to use these new features"?  This
>>>>>>> tool is only used by the in-kernel build scripts, and if they do not
>>>>>>> take advantage of these new options you have added, why are they 
>>>>>>> needed?
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>
>>>>>> Hi Greg,
>>>>>>
>>>>>> Thanks for the response.
>>>>>>
>>>>>> We use it in VMware Photon OS. Following is the link for the same.
>>>>>> https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4
>>>>>>
>>>>>> If this change goes in, it will give a slight push to our build 
>>>>>> performance.
>>>>>
>>>>> What exactly do you mean by "slight push"?
>>>>
>>>> Instead of invoking the signing tool binary for each module, we can 
>>>> pass
>>>> modules in bulk and it will reduce the build time by couple of seconds.
>>>
>>> Then why not modify the in-kernel build system to also do this, allowing
>>> everyone to save time and money (i.e. energy)?
>>>
>>> Why keep the build savings to yourself?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> If I understand correctly,
>> "sign-file: add support to sign modules in bulk"
>> is the only benefit in the patchset.
>>
>> I tested the bulk option, but I did not see build savings.
>>
>>
>>
>> My evaluation:
>> 1.  'make allmodconfig all', then 'make modules_install'.
>>          (9476 modules installed)
>>
>> 2.  I ran 'perf stat' for single signing vs bulk signing
>>        (5 runs for each).
>>        I changed the -n option in scripts/signfile.sh
>>
>>
>>
>>
>> A.  single sign
>>
>> Sign one module per scripts/sign-file invocation.
>>
>> find "${MODULES_PATH}" -name *.ko -type f -print0 | \
>>          xargs -r -0 -P$(nproc) -x -n1 sh -c "..."
>>
>>
>>
>>   Performance counter stats for './signfile-single.sh' (5 runs):
>>
>>               22.33 +- 2.26 seconds time elapsed  ( +- 10.12% )
>>
>>
>>
>>
>> B. bulk sign
>>
>> Sign 32 modules per scripts/sign-file invocation
>>
>> find "${MODULES_PATH}" -name *.ko -type f -print0 | \
>>          xargs -r -0 -P$(nproc) -x -n32 sh -c "..."
>>
>>
>>   Performance counter stats for './signfile-bulk.sh' (5 runs):
>>
>>               24.78 +- 3.01 seconds time elapsed  ( +- 12.14% )
>>
>>
>>
>>
>> The bulk option decreases the process forks of scripts/sign-file
>> but I did not get even "slight push".
>>
>>
>>
> 
> That's some really interesting data. I'm surprised that with stand alone 
> run bulk signing is not performing as expected. Can you give the full 
> command you used for bulk sign? Reduced number of forks should 
> eventually lead to getting more done in less time.
> 
> But I got ~1.4 seconds boost when I did "make module_install".
> 
> I gave the data in my other response as well. Copying the same here 
> because this has in better context.
> 
> root@ph5dev:~/linux-6.3.5 # ./test.sh orig
> 
> real    0m14.699s
> user    0m55.519s
> sys    0m9.036s
> 
> root@ph5dev:~/linux-6.3.5 # ./test.sh new
> 
> real    0m13.327s
> user    0m46.885s
> sys    0m6.770s
> 
> Here is my test script.
> ```
> #!/bin/bash
> 
> set -e
> 
> if [ "$1" != "new" ] && [ "$1" != "orig" ]; then
>     echo "invalid arg, ($0 [orig|new])" >&2
>     exit 1
> fi
> 
> rm -rf $PWD/tmp
> 
> s="scripts/sign-file.c"
> m="scripts/Makefile.modinst"
> fns=($s $m)
> 
> for f in ${fns[@]}; do
>       cp $f.$1 $f
> done
> 
> cd scripts
> gcc -o sign-file sign-file.c -lcrypto
> cd -
> 
> time make modules_install INSTALL_MOD_PATH=$PWD/tmp -s -j$(nproc)
> ```
> 

I ran the signfile script again using perf. Almost same as the method 
you followed.

I have 991 modules in the target modules directory. Following is the report:

```
root@ph5dev:~/linux-6.3.5 #
perf stat ./signfile.sh sha384 certs/signing_key.pem 1

  Performance counter stats for './signfile.sh sha384 
certs/signing_key.pem 1':

          18,498.62 msec task-clock                       #    7.901 
CPUs utilized
              6,211      context-switches                 #  335.755 /sec
                 52      cpu-migrations                   #    2.811 /sec
            554,414      page-faults                      #   29.971 K/sec


        2.341202651 seconds time elapsed

       14.891415000 seconds user
        3.018111000 seconds sys


root@ph5dev:~/linux-6.3.5 #
perf stat ./signfile.sh sha384 certs/signing_key.pem 32

  Performance counter stats for './signfile.sh sha384 
certs/signing_key.pem 32':

           8,397.24 msec task-clock                       #    7.548 
CPUs utilized
              1,237      context-switches                 #  147.310 /sec
                  0      cpu-migrations                   #    0.000 /sec
             22,529      page-faults                      #    2.683 K/sec


        1.112510013 seconds time elapsed

        8.057543000 seconds user
        0.323572000 seconds sys
```

And now the interesting part. I tested the time saved with only 
modules_sign.

root@ph5dev:~/linux-6.3.5 # ./b.sh new

real	0m1.756s
user	0m8.481s
sys	0m0.553s

root@ph5dev:~/linux-6.3.5 # ./b.sh orig

real	0m3.078s
user	0m16.801s
sys	0m3.096s

root@ph5dev:~/linux-6.3.5 # ./b.sh new

real	0m1.757s
user	0m8.554s
sys	0m0.504s

root@ph5dev:~/linux-6.3.5 # ./b.sh orig

real	0m3.098s
user	0m16.855s
sys	0m3.073s

And signfile.sh script also shows the same. I tweaked it a bit to accept 
number of process as another arg.

root@ph5dev:~/linux-6.3.5 #
time ./signfile.sh sha384 certs/signing_key.pem 1

real	0m2.343s
user	0m14.916s
sys	0m2.890s

root@ph5dev:~/linux-6.3.5 #
time ./signfile.sh sha384 certs/signing_key.pem 32

real	0m1.120s
user	0m8.120s
sys	0m0.276s

So, every run is saving ~2 seconds of time. I think something is wrong 
in the way you tested. Please check once at your end.

-- 
Shedi

