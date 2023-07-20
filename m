Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ABC75B17C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGTOpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGTOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:45:52 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 07:45:41 PDT
Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5E26B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:45:41 -0700 (PDT)
X-Authed-Username: dG10YWxwZXlAcmNuLmNvbQ==
Authentication-Results:  smtp02.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [96.237.161.173] ([96.237.161.173:51681] helo=[192.168.0.206])
        by smtp.rcn.com (envelope-from <tom@talpey.com>)
        (ecelerity 4.4.0.19839 r(msys-ecelerity:tags/4.4.0.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
        id AB/37-10976-1E349B46; Thu, 20 Jul 2023 10:25:37 -0400
Message-ID: <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com>
Date:   Thu, 20 Jul 2023 10:25:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Content-Language: en-US
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Steve French <smfrench@gmail.com>
Cc:     linkinjeon@kernel.org, shaggy@kernel.org,
        linux-cifs@vger.kernel.org, krisman@collabora.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20230628232417.120844-1-linux@treblig.org>
 <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
 <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdejiecutefuodetggdotefrodftvfcurfhrohhf
X-Vade-Analysis-2: ihhlvgemucfujgfpteevqfftpdftvefppdfgpfggqdftvefppdfqfgfvnecuuegrihhlohhuthemucef
X-Vade-Analysis-3: tddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdl
X-Vade-Analysis-4: geelmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhomhcu
X-Vade-Analysis-5: vfgrlhhpvgihuceothhomhesthgrlhhpvgihrdgtohhmqeenucggtffrrghtthgvrhhnpeelgeffvedu
X-Vade-Analysis-6: fffftdekgfduhfeffeeffeeiiedvfeeifedvuddutddtudegfefgjeenucffohhmrghinhepghhithhh
X-Vade-Analysis-7: uhgsrdhiohdpthhrvggslhhighdrohhrghenucfkphepleeirddvfeejrdduiedurddujeefnecuvehl
X-Vade-Analysis-8: uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepleeirddvfeejrdduiedurddujeefpdhh
X-Vade-Analysis-9: vghloheplgduledvrdduieekrddtrddvtdeingdpmhgrihhlfhhrohhmpehtohhmsehtrghlphgvhidr
X-Vade-Analysis-10: tghomhdprhgtphhtthhopegurghvvgdrkhhlvghikhgrmhhpsehorhgrtghlvgdrtghomhdprhgtphht
X-Vade-Analysis-11: thhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepshhmfhhrvghntghhsehgmhgr
X-Vade-Analysis-12: ihhlrdgtohhmpdhrtghpthhtoheplhhinhhkihhnjhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphht
X-Vade-Analysis-13: thhopehshhgrghhghieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehv
X-Vade-Analysis-14: ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsmhgrnhestgholhhlrggsohhrrgdr
X-Vade-Analysis-15: tghomh
X-Vade-Client: RCN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2023 6:06 PM, Dave Kleikamp wrote:
> On 7/19/23 4:58PM, Dr. David Alan Gilbert wrote:
>> * Steve French (smfrench@gmail.com) wrote:
>>> The related question is which tree to send it from, if no problems
>>> reported (presumably mine since it mostly affect cifs.ko and ksmbd.ko,
>>> and because there hasn't been activity in fs/nls for years)
>>
>> That was my hope, given that ~half of the patches are directly on that
>> code, and it's the only very active tree this touches as far as I can
>> tell.
>>
>>> On Wed, Jul 19, 2023 at 12:56 PM Steve French <smfrench@gmail.com> 
>>> wrote:
>>>>
>>>> No objections to this on my part.  If Shaggy is ok with the JFS
>>>> change, we could target it for 6.6-rc1 if it tests out ok
> 
> For the series:
> Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> Steve,
> Feel free to pull in even the 4th patch into your tree with my consent. 
> Or if you're more comfortable, I could submit it after yours hits mainline.
> 
> Shaggy

The changes look good to me but there is one quirk with the
copyrights and SPDX in patch 2.

In the new fs/nls/nls_ucs2_utils.c, the SPDX line changes from
a "/* ... */" form to "// ...", which may be a proper update, but
then partway down, adds the same SPDX in "/* ... */ form. These
should at least be consistent.

> +++ b/fs/nls/nls_ucs2_utils.c
> @@ -1,19 +1,25 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> +// SPDX-License-Identifier: GPL-2.0-or-later

vs

> +++ b/fs/nls/nls_ucs2_utils.h
> @@ -0,0 +1,297 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Second, the copyright in fs/nls/nls_ucs2_utils.c is a bit of
a mash-up (adding 2009 especially).

I think it's better to keep the exact text of both copyrights,
perhaps with a note as to which files had them previously, and
adding some new note/blank line to separate the recent contributions
from Namjae and you from the ancient history.

> +++ b/fs/nls/nls_ucs2_utils.c
> ...
> - *   Some of the source code in this file came from fs/cifs/uniupr.h
> - *   Copyright (c) International Business Machines  Corp., 2000,2002
> - *
> - * uniupr.h - Unicode compressed case ranges
> + *   Some of the source code in this file came from fs/cifs/cifs_unicode.c
> + *   via fs/smb/unicode.c and fs/smb/uniupr.h and fs/cifs/uniupr.h
> + *   Copyright (c) International Business Machines  Corp., 2000,2002,2009
> + *   Modified by Steve French (sfrench@us.ibm.com)
> + *   Modified by Namjae Jeon (linkinjeon@kernel.org)
> + *   Modified by Dr. David Alan Gilbert <linux@treblig.org>

Apart from considering these:

Reviewed-by: Tom Talpey <tom@talpey.com>

Nice work!

>>
>> Thanks.
>>
>> Dave
>>
>>>> On Wed, Jul 12, 2023 at 6:28 PM Dr. David Alan Gilbert 
>>>> <dave@treblig.org> wrote:
>>>>>
>>>>> * linux@treblig.org (linux@treblig.org) wrote:
>>>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>>>
>>>>>> The smb client and server code have (mostly) duplicated code
>>>>>> for unicode manipulation, in particular upper case handling.
>>>>>>
>>>>>> Flatten this lot into shared code.
>>>>>
>>>>> Gentle two week ping on this please.
>>>>>
>>>>> Dave
>>>>>
>>>>> (Apologies to the 3 of you who already got a copy of this ping,
>>>>> recent due to a missing header ',' )
>>>>>
>>>>>> There's some code that's slightly different between the two, and
>>>>>> I've not attempted to share that - this should be strictly a no
>>>>>> behaviour change set.
>>>>>>
>>>>>> In addition, the same tables and code are shared in jfs, however
>>>>>> there's very little testing available for the unicode in there,
>>>>>> so just share the raw data tables.
>>>>>>
>>>>>> I suspect there's more UCS-2 code that can be shared, in the NLS code
>>>>>> and in the UCS-2 code used by the EFI interfaces.
>>>>>>
>>>>>> Lightly tested with a module and a monolithic build, and just 
>>>>>> mounting
>>>>>> itself.
>>>>>>
>>>>>> This dupe was found using PMD:
>>>>>>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>>>>>>
>>>>>> Dave
>>>>>>
>>>>>> Version 2
>>>>>>    Moved the shared code to fs/nls after v1 feedback.
>>>>>>    Renamed shared tables from Smb to Nls prefix
>>>>>>    Move UniStrcat as well
>>>>>>    Share the JFS tables
>>>>>>
>>>>>> Dr. David Alan Gilbert (4):
>>>>>>    fs/smb: Remove unicode 'lower' tables
>>>>>>    fs/smb: Swing unicode common code from smb->NLS
>>>>>>    fs/smb/client: Use common code in client
>>>>>>    fs/jfs: Use common ucs2 upper case table
>>>>>>
>>>>>>   fs/jfs/Kconfig               |   1 +
>>>>>>   fs/jfs/Makefile              |   2 +-
>>>>>>   fs/jfs/jfs_unicode.h         |  17 +-
>>>>>>   fs/jfs/jfs_uniupr.c          | 121 -------------
>>>>>>   fs/nls/Kconfig               |   8 +
>>>>>>   fs/nls/Makefile              |   1 +
>>>>>>   fs/nls/nls_ucs2_data.h       |  15 ++
>>>>>>   fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
>>>>>>   fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
>>>>>>   fs/smb/client/Kconfig        |   1 +
>>>>>>   fs/smb/client/cifs_unicode.c |   1 -
>>>>>>   fs/smb/client/cifs_unicode.h | 330 
>>>>>> +----------------------------------
>>>>>>   fs/smb/client/cifs_uniupr.h  | 239 -------------------------
>>>>>>   fs/smb/server/Kconfig        |   1 +
>>>>>>   fs/smb/server/unicode.c      |   1 -
>>>>>>   fs/smb/server/unicode.h      | 325 
>>>>>> +---------------------------------
>>>>>>   fs/smb/server/uniupr.h       | 268 ----------------------------
>>>>>>   17 files changed, 467 insertions(+), 1293 deletions(-)
>>>>>>   delete mode 100644 fs/jfs/jfs_uniupr.c
>>>>>>   create mode 100644 fs/nls/nls_ucs2_data.h
>>>>>>   create mode 100644 fs/nls/nls_ucs2_utils.c
>>>>>>   create mode 100644 fs/nls/nls_ucs2_utils.h
>>>>>>   delete mode 100644 fs/smb/client/cifs_uniupr.h
>>>>>>   delete mode 100644 fs/smb/server/uniupr.h
>>>>>>
>>>>>> -- 
>>>>>> 2.41.0
>>>>>>
>>>>> -- 
>>>>>   -----Open up your eyes, open up your mind, open up your code -------
>>>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>>>>> \        dave @ treblig.org |                               | In Hex /
>>>>>   \ _________________________|_____ http://www.treblig.org   |_______/
>>>>
>>>>
>>>>
>>>> -- 
>>>> Thanks,
>>>>
>>>> Steve
>>>
>>>
>>>
>>> -- 
>>> Thanks,
>>>
>>> Steve
> 
