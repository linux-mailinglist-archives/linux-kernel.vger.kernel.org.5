Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7550C7A3FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjIRDm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbjIRDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:41:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3C310A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:41:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-570a432468bso3660940a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1695008506; x=1695613306; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LChi52F8W125oBVQox7w/tsu4dA5p1CWPdYepEsEMA=;
        b=HeEhc5cj6uTCEweUUrxkp38SGf0W7FprBeZqJe342Avdd3+p4+eGyT5xM8PXvlUcNZ
         JwYhr7pyeceRXcPJlMzz4/X8WMT3aBN07xSreSh5OkpjfeG6WA30KpDuF8MXQyRy6eSt
         bNcC6S9wxmdk0hjuGO37yPENLvcnSyVSMTQ5fHN5KNexRtcvli5R253BkjGFfDQ2w6+g
         tKincdCyD5IEj0fUPMKob3N9dmnPDtIaci/TDYvGXkNujHX+VYlGL54um0DrhSUy5Y2B
         UMNzm3ifEsawCmUCqXBhvAdwyYpdowxti2xh6J0trnGoyBBH1Vp2dZbghzORWe13XVVJ
         T0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695008506; x=1695613306;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LChi52F8W125oBVQox7w/tsu4dA5p1CWPdYepEsEMA=;
        b=Jybw16unSszivYbPbekrB4qZwo/LenJmL1TioqUE+o4zLhmBmSgCNndbActv9t1A+U
         P2HCjAOHo1kSE1j72zxZgchi2ssktPW+FUizrqDOYAN0Nx1Z8506uzdD3raNyo7vXuYF
         lXognCYMiUofdMwqlahEiz2EzUk/WbiP5kIsVZTYYg3DZkzPDcNxWtsuKa5FAyuIIF5X
         wGQJ7jOA+W4oZ7/vp8LlOkoiZ8CrptBBtXut8+iBb0mF982BHy6PNiAKellGGVFCA89D
         TC49kZETO/HmyF+ZTOHqGz+vKCW+l8evi4imZgCREdg9+5DJc+Dq4eUB9WPKowGkf3gZ
         knqg==
X-Gm-Message-State: AOJu0YwunoLjx3I3SsLRECFSnf2Ti9M4pYqdtBH4Uh+KR6PWD8Ne2jtb
        oCkTKoAVfoTsChvwJLNKvbp0wg==
X-Google-Smtp-Source: AGHT+IGn4FTGbH1QQhmBd7k+Pa26rEKOe+zz97KcSNNTL00qwRvLl5Krgy9F/0sHC6c9u6hycUN4ig==
X-Received: by 2002:a17:90a:5d92:b0:26b:374f:97c2 with SMTP id t18-20020a17090a5d9200b0026b374f97c2mr10633316pji.6.1695008506328;
        Sun, 17 Sep 2023 20:41:46 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a08ca00b00262e604724dsm7900314pjn.50.2023.09.17.20.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 20:41:45 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Mario Limonciello'" <mario.limonciello@amd.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Swapnil Sapkal'" <swapnil.sapkal@amd.com>, <Ray.Huang@amd.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <rafael.j.wysocki@intel.com>, "Doug Smythies" <dsmythies@telus.net>
References: <001701d9e9ae$02438120$06ca8360$@telus.net> <e8a05f05-deec-4784-9627-354939ad30f6@amd.com>
In-Reply-To: <e8a05f05-deec-4784-9627-354939ad30f6@amd.com>
Subject: RE: [PATCH] tools/power/x86/intel_pstate_tracer: python minimum version
Date:   Sun, 17 Sep 2023 20:41:49 -0700
Message-ID: <002201d9e9e2$0ea11a20$2be34e60$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHZ2qIP8m8g/xv1WN/ewv41PaKNWAIKXfLusA+3S2A=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023.09.17 17:57 Mario wrote:
> On 9/17/2023 16:29, Doug Smythies wrote:
>> From: Doug Smythies <dsmythies@telus.net>
>>=20
>> Change the minimum python version from 2.7 to 3.6.
>> Remove a 2.X backwards compatibility line.
>>=20
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> ---
>>   .../x86/intel_pstate_tracer/intel_pstate_tracer.py     | 10 =
+++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git =
a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py =
b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> index ec3323100e1a..6b0790e6465a 100755
>> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/env python
>> +#!/usr/bin/env python3
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   # -*- coding: utf-8 -*-
>>   #
>> @@ -11,9 +11,9 @@ then this utility enables and collects trace data =
for a user specified interval
>>   and generates performance plots.
>>=20
>>   Prerequisites:
>> -    Python version 2.7.x or higher
>> +    Python version 3.6.x or higher
>>       gnuplot 5.0 or higher
>> -    gnuplot-py 1.8 or higher
>> +    phython3-gnuplot 1.8 or higher
>
> Presumably you mean 'python3-gnuplot'.

Oh Darn. Yes. I'll send a V2.

>>       (Most of the distributions have these required packages. They =
may be called
>>        gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, =
... )
>>=20
>
> Likewise here too.
>
>> @@ -23,7 +23,7 @@ Prerequisites:
>>       see print_help(): for Usage and Output details
>>=20
>>   """
>> -from __future__ import print_function
>> +
>>   from datetime import datetime
>>   import subprocess
>>   import os
>> @@ -562,7 +562,7 @@ if __name__ =3D=3D "__main__":
>>=20
>>       # Temporary (or perhaps not)
>>       cur_version =3D sys.version_info
>> -    print('python version (should be >=3D 2.7):')
>> +    print('python version (should be >=3D 3.6):')
>>       print(cur_version)
>
> Is this block printing the version really needed at all?
> I don't see 'cur_version' used anywhere else in the file.

Well, it is there to make it easy to know what the
requirements are and what the actual version is.
The minimum version is not enforced.

>>       # Left as "cleanup" for potential future re-run ability.
>> --
>> 2.25.1


