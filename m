Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3487E8F19
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 09:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjKLIDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 03:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjKLIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 03:03:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8212D7C;
        Sun, 12 Nov 2023 00:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699776214; x=1700381014; i=deller@gmx.de;
        bh=7rWhyYjbLD4wTMG1UfPB84prkOZjeSCZ4WRf691IXV0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=pH+SI6lQgdt7lEbnBOP9FLq/lgEeXjuzT8QYpHLcZlef15MG1NiRZ8xE5f+61vfP
         noxKk8kuqWjsX/dIU/jcM2EoOkGKBJ7I3N2qH4TPxzKRpEpQ7mFDW1d0a7JzOykUy
         Sfl/8Ook6nd/PXMNgsSDlIQHYR193Oz0+WCo/ie927OQPOyNayrgfojoPZjO9K6SN
         yc6HZcSaUQUcNEvmDbHyHsuXgCKCgt80fKVz8lPOrwXUaPE4MSkpvMfBfIIAUFsL/
         Ivp/H7QGz0xK2h5pDXhjtWEoIZyxAzmve45fYXKK/1/HpJpidjKosXp8e0eyhgvsd
         EVg697ktnLVI8UoJ+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.50]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1qi5qL2eRz-00Nzep; Sun, 12
 Nov 2023 09:03:34 +0100
Message-ID: <30f63f4f-eeeb-45e9-8f90-e58a3a644a65@gmx.de>
Date:   Sun, 12 Nov 2023 09:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bisected stability regression in 6.6
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <dave@treblig.org>,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        HelgeDeller@treblig.org
Cc:     Sam James <sam@gentoo.org>, linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
 <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de> <87edgw6kuz.fsf@gentoo.org>
 <9a84b68e9a538a66842dccc5efb8bdf8@matoro.tk> <ZVAo0wbqiSC3kB3-@gallifrey>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZVAo0wbqiSC3kB3-@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oUYYnxe3gXcSAwnc+uDN+6/rzYqwdDMLK6EBzC+uYx4ZyN7wZ02
 p0Tpo5MtObYovr8C1ISAElEFBz9yFY8a9k9gcOJOUNVyy7n9Gel/wNCKIgLPJNQskJPPWhu
 SOtmuz9S1Tx7b9e/IAFi6KQiz0K3NT6OG1KRZL1nGWp5ZeorDBCsx5yiiLL4aBq121M5w9k
 i/zmn1DkFD0c9MZfXE2dg==
UI-OutboundReport: notjunk:1;M01:P0:Wxenm6C2JDE=;Ecb8cRh7VoiwP/HUtbt+kg3+MVz
 ZV87PPICBf59dgUNzVfqp9Uz8V0eWjv0CsaDFyt7qbK8UWPKZAnv0J237++9qWMFiSkm9Z6A+
 21ojcsbyamZnFBQXWsnzoIEonTyYLcVskrX6SOSydZ9WZrbcKmvTMqQLEwWd53LnJYO+EWNL3
 lAU5ZAa4XMbGOjvyzmu19JbFT0x6JPLqo/81JqVDJkIX3lNjGDqLVDUaUx/IBLIP1bDs/fWQK
 sLSkmhlP8OoMqpF0LDkqQkK4ZTMd9YbDBNMVY7vYlpkZt/PBRIxXk9xrnQ+wBC7CtHVGI2csm
 k+EX5w+1xUTTxobpVkV8wjs6v8rTkdEzu7hZY85xuXIiGRlL2XTqFKCNxDJvecab6HASy6juq
 aIMHXLeKypxhFBFYbCm9A+U/hZI5HmoW+CGy2dv4R0JzbT+aCQOsDp+8WED2yKByKaFAAic1O
 L9lK8FjpUdHlYPhLAuuPu8hbEaMgyxoxI5JPb9RhcmAW5q7XAMCzlwIXJqnf5Hapj7O125cvP
 xIbR54QRdFnTdxFXwCJ1Os9EoBeuSzFkobmfIoSpegnQO5Vxc6xHEqkQXiUU3GTnTcQTLLzwK
 oO2CnCtyTAd6QMLy6MP+xWRTgMVNw1ssEDghHh7n0mEmrcaCa20pJP6+ESIbdDRr89cKJ9gT4
 SrCVUGAeDCxN+hE75YbuJmTT70DXFClJZhPuj04op4P7Gg5f8HfuVgjPtEfQdLI3Rz1iOBR2P
 6MQYnbTeY+RnBd7EzhV5+3At7yCNgpRjjw3zbuakDYQbrUXLmtIPKdpyifxKOTXkoK9v4x8O1
 iiUTxRimXea+//C4LMkXaQVIgP7QhRCjBR7n1v44z4bqSUZaaF4HGgD6SB5Fg514jzyVPRPRU
 Vw0SKgxqbPNEwqhoNwl+wTmSrenW2aLkbIkCNhd9JaY7yIhMNmlomgCzAxeD3rKmAPRxWKwMR
 EIhF3g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/23 02:22, Dr. David Alan Gilbert wrote:
> * matoro (matoro_mailinglist_kernel@matoro.tk) wrote:
>> On 2023-11-11 16:27, Sam James wrote:
>>> Helge Deller <deller@gmx.de> writes:
>>>
>>>> On 11/11/23 07:31, matoro wrote:
>>>>> Hi Helge, I have bisected a regression in 6.6 which is causing
>>>>> userspace segfaults at a significantly increased rate in kernel 6.6.
>>>>> There seems to be a pathological case triggered by the ninja build
>>>>> tool.  The test case I have been using is cmake with ninja backend t=
o
>>>>> attempt to build the nghttp2 package.  In 6.6, this segfaults, not a=
t
>>>>> the same location every time, but with enough reliability that I was
>>>>> able to use it as a bisection regression case, including immediately
>>>>> after a reboot.  In the kernel log, these show up as "trap #15: Data
>>>>> TLB miss fault" messages.  Now these messages can and do show up in
>>>>> 6.5 causing segfaults, but never immediately after a reboot and
>>>>> infrequently enough that the system is stable.  With kernel 6.6 I am
>>>>> completely unable to build nghttp2 under any circumstances.
>>>>>
>>>>> I have bisected this down to the following commit:
>>>>>
>>>>> $ git bisect good
>>>>> 3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
>>>>> commit 3033cd4307681c60db6d08f398a64484b36e0b0f
>>>>> Author: Helge Deller <deller@gmx.de>
>>>>> Date:=C2=A0=C2=A0 Sat Aug 19 00:53:28 2023 +0200
>>>>>
>>>>>   =C2=A0=C2=A0=C2=A0 parisc: Use generic mmap top-down layout and br=
k randomization
>>>>>
>>>>>   =C2=A0=C2=A0=C2=A0 parisc uses a top-down layout by default that e=
xactly fits
>>>>> the generic
>>>>>   =C2=A0=C2=A0=C2=A0 functions, so get rid of arch specific code and=
 use the
>>>>> generic version
>>>>>   =C2=A0=C2=A0=C2=A0 by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAY=
OUT.
>>>>>
>>>>>   =C2=A0=C2=A0=C2=A0 Note that on parisc the stack always grows up a=
nd a "unlimited stack"
>>>>>   =C2=A0=C2=A0=C2=A0 simply means that the value as defined in
>>>>> CONFIG_STACK_MAX_DEFAULT_SIZE_MB
>>>>>   =C2=A0=C2=A0=C2=A0 should be used. So RLIM_INFINITY is not an indi=
cator to use
>>>>> the legacy
>>>>>   =C2=A0=C2=A0=C2=A0 memory layout.
>>>>>
>>>>>   =C2=A0=C2=A0=C2=A0 Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>
>>>>>   =C2=A0arch/parisc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++
>>>>>   =C2=A0arch/parisc/kernel/process.c=C2=A0=C2=A0=C2=A0 | 14 --------=
---
>>>>>   =C2=A0arch/parisc/kernel/sys_parisc.c | 54
>>>>> +----------------------------------------
>>>>>   =C2=A0mm/util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 5 +++-
>>>>>   =C2=A04 files changed, 22 insertions(+), 68 deletions(-)
>>>>
>>>> Thanks for your report!
>>>> I think it's quite unlikely that this patch introduces such a bad
>>>> regression.
>>>> I'd suspect some other bad commmit, but I'll try to reproduce.
>>>
>>> matoro, does a revert apply cleanly? Does it help?
>>
>> Yes, I just tested this and it cleanly reverts on linux-6.6.y and the r=
evert
>> does fix the issue.
>
> Helge:
>    In that patch is:
>
> diff --git a/mm/util.c b/mm/util.c
> index dd12b9531ac4c..8810206444977 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -396,7 +396,10 @@ static int mmap_is_legacy(struct rlimit *rlim_stack=
)
>          if (current->personality & ADDR_COMPAT_LAYOUT)
>                  return 1;
>
> -       if (rlim_stack->rlim_cur =3D=3D RLIM_INFINITY)
> +       /* On parisc the stack always grows up - so a unlimited stack sh=
ould
> +        * not be an indicator to use the legacy memory layout. */
> +       if (rlim_stack->rlim_cur =3D=3D RLIM_INFINITY &&
> +               !IS_ENABLED(CONFIG_STACK_GROWSUP))
>                  return 1;
>
>          return sysctl_legacy_va_layout;
>
> is that:
>     '!IS_ENABLED(CONFIG_STACK_GROWSUP))'
>
>   the right way around?
>
> That feels inverted to me;  non-parisc don't have that config
> set, so !IS_ENABLED... is true,  so they return 1 instead of checking
> the flag?

Right. For non-parisc the behaviour didn't change with my patch, and this
is intended. If rlim_stack->rlim_cur =3D=3D RLIM_INFINITY, non-parisc retu=
rn 1 as before.

Note that matoro reported a regression specifically on the parisc platform=
.

This change:
-       if (rlim_stack->rlim_cur =3D=3D RLIM_INFINITY)
+       if (rlim_stack->rlim_cur =3D=3D RLIM_INFINITY &&
+               !IS_ENABLED(CONFIG_STACK_GROWSUP))
just changes the behaviour on parisc.
On parisc rlim_stack->rlim_cur =3D=3D RLIM_INFINITY" is always true, unles=
s the user
changed the stack limit manually. If unchanged, mmap_is_legacy() should re=
turn
sysctl_legacy_va_layout, otherwise 1.

So, I think that part of the patch is OK.

Helge
