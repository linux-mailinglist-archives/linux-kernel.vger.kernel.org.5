Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F076F361
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjHCT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCT00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:26:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935D73A80;
        Thu,  3 Aug 2023 12:26:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc02bd4eafso11450655ad.1;
        Thu, 03 Aug 2023 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691090785; x=1691695585;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkwdY9e/9MMGS88fBKDkYbx5CtiT5bHBQRYcXXTAFL4=;
        b=aqzTxZj5sul4FXzniCvo0yd75HrZrdpKxGHWGwQVxDDPl3CL0yKtUTmYWsT2IJvPOP
         gcGhJ3FX/b22lP5o5KmarieUV6Wp0Aj++r71Vmk6Bz1PERKdDJMqLnkZKoMkPFT+BFJR
         +m7KjvdRyVC7lWa9mq6N2rNs5MsFga8nGAylo9WfgKlkB5N78duawKT8iC00WFZOXWDp
         AJ5NplH6tWO1kDBAzQvAGK78s3o+iBhWM6nP/TMUsSuEzBJfURGvng5oR2FhmJm6TUDG
         9C/nMADHZY0F33tk4SDj9Nz6crrArd6qRIJdibqYDXjdVunNR7BGSBZ3ufZTx7nwoewK
         igcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090785; x=1691695585;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkwdY9e/9MMGS88fBKDkYbx5CtiT5bHBQRYcXXTAFL4=;
        b=DHq1eRQdsnBqDHGyvaOwMhEvaD0vx/HlPoys7yK/QJ8m8TUqfqkJI2eC2k5HMGyvZt
         BAEfeECFRBA1aYH6FTH4fYTp2gYzi0QeJbjJlOUgqxW2tbJEMRs+jSfi9nhfNBDutiBc
         WxC0VPiitQjX2SPPPv2XkWkyCxrbwSlOZlPrkUEIV/IdxrhpbYVSJ2JkqM1dSPdc+q4C
         FXCrINuu8dzJGuwY9FivESa6SCHRsCl8krdYndttBM6Vsx0aLAhbEIr9uKRwls9p0gko
         8OVW0GxrgBXlH3lEKQWPAduVYMci5XDpaUxRo5tgRF9smPHfCPSFiFW2zFGHWJNbJNhf
         GdXA==
X-Gm-Message-State: ABy/qLZeQvqEBLKiJ2hQJHcGF5N00N39b1Q2b/2eTsFC16/h1QP92K1R
        BzML07p21zoZKR/fspGplSk=
X-Google-Smtp-Source: APBJJlEPw2ntYxiXliTObYv3t8EmpTsYqFncu72o4bvoUu4UW2FM43ifW9SbRVXxpgGr0o6dPxq9Ug==
X-Received: by 2002:a17:902:db06:b0:1b8:1bac:3782 with SMTP id m6-20020a170902db0600b001b81bac3782mr23101626plx.6.1691090784873;
        Thu, 03 Aug 2023 12:26:24 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b001b85bb5fd77sm222664plb.119.2023.08.03.12.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 12:26:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to
 requirements
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAEXW_YRXA3j3k9VRuZJ7d=yo6__TRpeE6igrQ+GEZiyKtFmUOQ@mail.gmail.com>
Date:   Fri, 4 Aug 2023 03:25:57 +0800
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
 <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
 <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
 <CAEXW_YRXA3j3k9VRuZJ7d=yo6__TRpeE6igrQ+GEZiyKtFmUOQ@mail.gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B48=E6=9C=884=E6=97=A5 00:01=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Aug 3, 2023 at 9:36=E2=80=AFAM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>>=20
>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 =E4=B8=8B=E5=8D=888:35=EF=BC=8CJoel =
Fernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>>=20
>>>> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> =
wrote:
>>>>=20
>>>> =EF=BB=BF
>>>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes =
(Google) <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>> Add a detailed note to explain the potential side effects of
>>>>> plain-accessing the gp pointer using a plain load, without using =
the
>>>>> rcu_dereference() macros; which might trip neighboring code that =
does
>>>>> use rcu_dereference().
>>>>>=20
>>>>> I haven't verified this with a compiler, but this is what I gather =
from
>>>>> the below link using Will's experience with READ_ONCE().
>>>>>=20
>>>>> Link: =
https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck/
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>> ---
>>>>> .../RCU/Design/Requirements/Requirements.rst  | 32 =
+++++++++++++++++++
>>>>> 1 file changed, 32 insertions(+)
>>>>>=20
>>>>> diff --git =
a/Documentation/RCU/Design/Requirements/Requirements.rst =
b/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>> index f3b605285a87..e0b896d3fb9b 100644
>>>>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
>>>>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference =
counting
>>>>> .. |high-quality implementation of C11 memory_order_consume [PDF]| =
replace:: high-quality implementation of C11 ``memory_order_consume`` =
[PDF]
>>>>> .. _high-quality implementation of C11 memory_order_consume [PDF]: =
http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
>>>>>=20
>>>>> +Note that, there can be strange side effects (due to compiler =
optimizations) if
>>>>> +``gp`` is ever accessed using a plain load (i.e. without =
``READ_ONCE()`` or
>>>>> +``rcu_dereference()``) potentially hurting any succeeding
>>>>> +``rcu_dereference()``. For example, consider the code:
>>>>> +
>>>>> +   ::
>>>>> +
>>>>> +       1 bool do_something_gp(void)
>>>>> +       2 {
>>>>> +       3   void *tmp;
>>>>> +       4   rcu_read_lock();
>>>>> +       5   tmp =3D gp; // Plain-load of GP.
>>>>> +       6   printk("Point gp =3D %p\n", tmp);
>>>>> +       7
>>>>> +       8   p =3D rcu_dereference(gp);
>>>>> +       9   if (p) {
>>>>> +      10     do_something(p->a, p->b);
>>>>> +      11     rcu_read_unlock();
>>>>> +      12     return true;
>>>>> +      13   }
>>>>> +      14   rcu_read_unlock();
>>>>> +      15   return false;
>>>>> +      16 }
>>>>> +
>>>>> +The behavior of plain accesses involved in a data race is =
non-deterministic in
>>>>> +the face of compiler optimizations. Since accesses to the ``gp`` =
pointer is
>>>>> +by-design a data race, the compiler could trip this code by =
caching the value
>>>>> +of ``gp`` into a register in line 5, and then using the value of =
the register
>>>>> +to satisfy the load in line 10. Thus it is important to never mix
>>>>=20
>>>> Will=E2=80=99s example is:
>>>>=20
>>>>   // Assume *ptr is initially 0 and somebody else writes it to 1
>>>>   // concurrently
>>>>=20
>>>>   foo =3D *ptr;
>>>>   bar =3D READ_ONCE(*ptr);
>>>>   baz =3D *ptr;
>>>>=20
>>>> Then the compiler is within its right to reorder it to:
>>>>=20
>>>>  foo =3D *ptr;
>>>>  baz =3D *ptr;
>>>>  bar =3D READ_ONCE(*ptr);
>>>>=20
>>>> So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is =
perfectly legal.
>>>=20
>>> Yes, a bad outcome is perfectly legal amidst data race. Who said it =
is not legal?
>>=20
>> My understanding is that it is legal even without data race, and the =
compiler only keeps the order of volatile access.
>=20
> Yes, but I can bet on it the author of the code would not have
> intended such an outcome, if they did then Will wouldn't have been
> debugging it ;-). That's why I called it a bad outcome. The goal of
> this patch is to document such a possible unintentional outcome.
>=20
>>>> But the example here is different,
>>>=20
>>> That is intentional. Wills discussion partially triggered this. =
Though I am wondering
>>> if we should document that as well.
>>>=20
>>>> the compiler can not use the value loaded from line 5
>>>> unless the compiler can deduce that the tmp is equals to p in which =
case the address dependency
>>>> doesn=E2=80=99t exist anymore.
>>>>=20
>>>> What am I missing here?
>>>=20
>>> Maybe you are trying to rationalize too much that the sequence =
mentioned cannot result
>>> in a counter intuitive outcome like I did?
>>>=20
>>> The point AFAIU is not just about line 10 but that the compiler can =
replace any of the
>>> lines after the plain access with the cached value.
>>=20
>> Well, IIUC, according to the C standard, the compiler can do anything =
if there is a data race (undefined behavior).
>>=20
>> However, what if a write is not protected with WRITE_ONCE and the =
read is marked with READ_ONCE?
>> That=E2=80=99s also a data race, right? But the kernel considers it =
is Okay if the write is machine word aligned.
>=20
> Yes, but there is a compiler between the HLL code and what the
> processor sees which can tear the write. How can not using
> WRITE_ONCE() prevent store-tearing? See [1]. My understanding is that
> it is OK only if the reader did a NULL check. In that case the torn

Yes, a write-write data race where the value is the same is also fine.

But they are still data race, if the compiler is within its right to do =
anything it likes (due to data race),
we still need WRITE_ONCE() in these cases, though it=E2=80=99s =
semantically safe.

IIUC, even with _ONCE(), the compiler is within its right do anything =
according to the standard (at least before the upcoming C23), because =
the standard doesn=E2=80=99t consider a volatile access to be atomic.

However, the kernel consider the volatile access to be atomic, right?

BTW, line 5 in the example is likely to be optimized away. And yes, the =
compiler can cache the value loaded from line 5 from the perspective of =
undefined behavior, even if I believe it would be a compiler bug from =
the perspective of kernel.

> result will not change the semantics of the program. But otherwise,
> that's bad.
>=20
> [1] https://lwn.net/Articles/793253/#Store%20Tearing
>=20
> thanks,
>=20
> - Joel
>=20
>=20
>>=20
>>>=20
>>> Thanks.
>>>=20
>>>=20
>>>=20
>>>>=20
>>>>> +plain accesses of a memory location with rcu_dereference() of the =
same memory
>>>>> +location, in code involved in a data race.
>>>>> +
>>>>> In short, updaters use rcu_assign_pointer() and readers use
>>>>> rcu_dereference(), and these two RCU API elements work together to
>>>>> ensure that readers have a consistent view of newly added data =
elements.
>>>>> --
>>>>> 2.41.0.585.gd2178a4bd4-goog


