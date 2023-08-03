Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5D76EAD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjHCNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjHCNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:40:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A586D5272;
        Thu,  3 Aug 2023 06:37:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-687087d8ddaso831694b3a.1;
        Thu, 03 Aug 2023 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691069781; x=1691674581;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j0m2EXcCiaYM6mEksmZ227CxG30VUp//PgwcM1f+MU=;
        b=hZz1Fjmz9nyrPM7obS2fX4/CIUHQPHwok+kNhAjHxu4S+kuq9r0P5fXJX07b+4uvV1
         yM3DwOeZ3ehngD20K70IPonvodjEneK9PFHM6Z1jrZccR1ygLC+fooYe00BwnAg1nix4
         7lfQkwCpltox71Bg7lJT19i2Uk54eHpFfIQ6lvjLjXB9XAhjJ1NFXS/UCfFCRh7MuHfg
         YD2bWpFSbLT7ChmSbYF9kXqPJi9lW1fOItAyy9AN6Qu0IrA2oWl392DSiToM8G0LLlA9
         wHRFpk78fRu6qO2OpiQ0C8qIjgxHAIAIm4bx2jAmyLG53vp7hZ9QFbS4wTpVd6nK6iMB
         DeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691069781; x=1691674581;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j0m2EXcCiaYM6mEksmZ227CxG30VUp//PgwcM1f+MU=;
        b=MaimhHRyezOBgdOxVKJy4Zrmf6P1XTRvz8CY85+MvBKrie0d1NsVLJDvmj85qf2fR3
         +o1dWQkLSCivtN8bKnmk8xx4oNKB9DGXFc7DKRL2TIiAkZRy6B53SmyPXJaGRL86KsC9
         S+WppC+XMIByKfj2giziCiINI7TqFjiF+3upkr9+49oS8yepa+5Ghp98Li8z4DmougJw
         jVsG8WZZunuQjxHbmMvblX9gjCE/EyeeQhs7/t1LcPH41i/MFFqU2U/Uu/u6PVN1AQ87
         fv6X71PsLfWwBXF037lMctjSfxKlJWm0ED6ylF4Nq2UFYjtCzaI7AYrWKUiouB+m1iA0
         6duA==
X-Gm-Message-State: ABy/qLanNpq7+4GYvTnWGuHmJbYXWiYMukMgFAX5NjpIWr333ysArEPM
        7B2/C0f7SUhJSEWNBaQHCEI=
X-Google-Smtp-Source: APBJJlEd7XotJ9n2ZtdiVu4V1rXLW/mYylUm8INCMc/FiGbj5on9a3INsx0dS2l7penpA18dtC2aMQ==
X-Received: by 2002:a05:6a20:9192:b0:133:6219:15e2 with SMTP id v18-20020a056a20919200b00133621915e2mr22849544pzd.21.1691069781111;
        Thu, 03 Aug 2023 06:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0068718aadda7sm9728340pfn.108.2023.08.03.06.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:36:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to
 requirements
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
Date:   Thu, 3 Aug 2023 21:36:06 +0800
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
Message-Id: <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
 <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 =E4=B8=8B=E5=8D=888:35=EF=BC=8CJoel =
Fernandes <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> wrote:
>>=20
>> =EF=BB=BF
>>> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes =
(Google) <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Add a detailed note to explain the potential side effects of
>>> plain-accessing the gp pointer using a plain load, without using the
>>> rcu_dereference() macros; which might trip neighboring code that =
does
>>> use rcu_dereference().
>>>=20
>>> I haven't verified this with a compiler, but this is what I gather =
from
>>> the below link using Will's experience with READ_ONCE().
>>>=20
>>> Link: =
https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck/
>>> Cc: Will Deacon <will@kernel.org>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> ---
>>> .../RCU/Design/Requirements/Requirements.rst  | 32 =
+++++++++++++++++++
>>> 1 file changed, 32 insertions(+)
>>>=20
>>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst =
b/Documentation/RCU/Design/Requirements/Requirements.rst
>>> index f3b605285a87..e0b896d3fb9b 100644
>>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
>>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
>>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference =
counting
>>> .. |high-quality implementation of C11 memory_order_consume [PDF]| =
replace:: high-quality implementation of C11 ``memory_order_consume`` =
[PDF]
>>> .. _high-quality implementation of C11 memory_order_consume [PDF]: =
http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
>>>=20
>>> +Note that, there can be strange side effects (due to compiler =
optimizations) if
>>> +``gp`` is ever accessed using a plain load (i.e. without =
``READ_ONCE()`` or
>>> +``rcu_dereference()``) potentially hurting any succeeding
>>> +``rcu_dereference()``. For example, consider the code:
>>> +
>>> +   ::
>>> +
>>> +       1 bool do_something_gp(void)
>>> +       2 {
>>> +       3   void *tmp;
>>> +       4   rcu_read_lock();
>>> +       5   tmp =3D gp; // Plain-load of GP.
>>> +       6   printk("Point gp =3D %p\n", tmp);
>>> +       7
>>> +       8   p =3D rcu_dereference(gp);
>>> +       9   if (p) {
>>> +      10     do_something(p->a, p->b);
>>> +      11     rcu_read_unlock();
>>> +      12     return true;
>>> +      13   }
>>> +      14   rcu_read_unlock();
>>> +      15   return false;
>>> +      16 }
>>> +
>>> +The behavior of plain accesses involved in a data race is =
non-deterministic in
>>> +the face of compiler optimizations. Since accesses to the ``gp`` =
pointer is
>>> +by-design a data race, the compiler could trip this code by caching =
the value
>>> +of ``gp`` into a register in line 5, and then using the value of =
the register
>>> +to satisfy the load in line 10. Thus it is important to never mix
>>=20
>> Will=E2=80=99s example is:
>>=20
>>    // Assume *ptr is initially 0 and somebody else writes it to 1
>>    // concurrently
>>=20
>>    foo =3D *ptr;
>>    bar =3D READ_ONCE(*ptr);
>>    baz =3D *ptr;
>>=20
>> Then the compiler is within its right to reorder it to:
>>=20
>>   foo =3D *ptr;
>>   baz =3D *ptr;
>>   bar =3D READ_ONCE(*ptr);
>>=20
>> So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is perfectly =
legal.
>=20
> Yes, a bad outcome is perfectly legal amidst data race. Who said it is =
not legal?

My understanding is that it is legal even without data race, and the =
compiler only keeps the order of volatile access.

>=20
>>=20
>> But the example here is different,
>=20
> That is intentional. Wills discussion partially triggered this. Though =
I am wondering
> if we should document that as well.
>=20
>> the compiler can not use the value loaded from line 5
>> unless the compiler can deduce that the tmp is equals to p in which =
case the address dependency
>> doesn=E2=80=99t exist anymore.
>>=20
>> What am I missing here?
>=20
> Maybe you are trying to rationalize too much that the sequence =
mentioned cannot result
> in a counter intuitive outcome like I did?
>=20
> The point AFAIU is not just about line 10 but that the compiler can =
replace any of the
> lines after the plain access with the cached value.

Well, IIUC, according to the C standard, the compiler can do anything if =
there is a data race (undefined behavior).

However, what if a write is not protected with WRITE_ONCE and the read =
is marked with READ_ONCE?
That=E2=80=99s also a data race, right? But the kernel considers it is =
Okay if the write is machine word aligned.

>=20
> Thanks.
>=20
>=20
>=20
>>=20
>>> +plain accesses of a memory location with rcu_dereference() of the =
same memory
>>> +location, in code involved in a data race.
>>> +
>>> In short, updaters use rcu_assign_pointer() and readers use
>>> rcu_dereference(), and these two RCU API elements work together to
>>> ensure that readers have a consistent view of newly added data =
elements.
>>> --=20
>>> 2.41.0.585.gd2178a4bd4-goog

