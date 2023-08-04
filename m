Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711477051A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjHDPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHDPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:47:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485C212D;
        Fri,  4 Aug 2023 08:47:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso16251485ad.2;
        Fri, 04 Aug 2023 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691164049; x=1691768849;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ctInikzj3f4VpN981g0mMHNMH1CbLINvv2oH+wydFI=;
        b=JYTWbas5LEdXilRfPo6X+gqolIBnQ6MBx32VolWDIsJGJFBkx187sI0DHIMtztbUBO
         re/CgVZQXMeZDRl8/SMXYIplCydyGN+lFpv7PwUpvWIGW7tcTnMgRcUlN9UfmwIYgahG
         tuJdRJK14XWPS8eW+nO9ZJUc1zlcDC9IGD4jInbslWUgZndhzX/GkN0sFwPcCozxu5Ft
         39K+ODuTFqYtmIuWUD5LZ26+0GqCnay6e7Dbf27Yoo3F4XeKBHxsdmtcUBsQ04VlTEFM
         QqZQpbybpdpXGyQB4AVQ1RN2Jj0RhxJuTiXudICOK5l4TwnuHxVNPmAFEwohf+S38350
         N5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164049; x=1691768849;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ctInikzj3f4VpN981g0mMHNMH1CbLINvv2oH+wydFI=;
        b=krZfRD0V0RVm+dGxCU1MXHY3buNubi2ZRxdhtu4+RxoiY97+gvArZI/f94lQhtWCsM
         Onp17qZ1mSBfEqdT1U2GC6512q+B8UagvQ5LrXtxAjXZ3bSGr9DMBkLWyA1Vu58Rs/dp
         bI/BZTzYG6GTvQDOj3MaiY+J9shhFFclJ0KkODpqcwUvRF/OG9UHh1yHwqHmN9xNSfXF
         I1b9e5b87DHTERLmqnpBEUFD57lHrlCwl7vAnQk68zwXabkf5AsikDF6da/PR63/3VLa
         xT/u5Yov6AV7TdqQMwz8WiezZk4J5DA4r2VrTIq6Kos28uVHNhMORjWg/NJtOiv4f4Dx
         DHfg==
X-Gm-Message-State: AOJu0YwAl44MlKF4o4MFUXmsKqBn1ALcBfX019PG7nuV9nfaDcUdUcAl
        /PCsyMeCRdNAt43dOltsvkE=
X-Google-Smtp-Source: AGHT+IHK1+GmGTe5McxKKfiRHWuia9yCNRvRVTipWjE0B5SPJN6DbVW0YYSfmF7ikfMX18/fWFw9ug==
X-Received: by 2002:a17:902:ecc8:b0:1bb:32de:95c5 with SMTP id a8-20020a170902ecc800b001bb32de95c5mr2297892plh.65.1691164049245;
        Fri, 04 Aug 2023 08:47:29 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902a40800b001b8b73da7b1sm1914812plq.227.2023.08.04.08.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Aug 2023 08:47:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to
 requirements
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <6B0A9441-5DB5-476B-B94C-F0BDF1505095@joelfernandes.org>
Date:   Fri, 4 Aug 2023 23:47:07 +0800
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
Message-Id: <E6EDDDE7-5D59-4284-931E-23E3636C8CF0@gmail.com>
References: <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
 <6B0A9441-5DB5-476B-B94C-F0BDF1505095@joelfernandes.org>
To:     Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
>>>=20
>>>>>> But the example here is different,
>>>>>=20
>>>>> That is intentional. Wills discussion partially triggered this. =
Though I am wondering
>>>>> if we should document that as well.
>>>>>=20
>>>>>> the compiler can not use the value loaded from line 5
>>>>>> unless the compiler can deduce that the tmp is equals to p in =
which case the address dependency
>>>>>> doesn=E2=80=99t exist anymore.
>>>>>>=20
>>>>>> What am I missing here?
>>>>>=20
>>>>> Maybe you are trying to rationalize too much that the sequence =
mentioned cannot result
>>>>> in a counter intuitive outcome like I did?
>>>>>=20
>>>>> The point AFAIU is not just about line 10 but that the compiler =
can replace any of the
>>>>> lines after the plain access with the cached value.
>>>>=20
>>>> Well, IIUC, according to the C standard, the compiler can do =
anything if there is a data race (undefined behavior).
>>>>=20
>>>> However, what if a write is not protected with WRITE_ONCE and the =
read is marked with READ_ONCE?
>>>> That=E2=80=99s also a data race, right? But the kernel considers it =
is Okay if the write is machine word aligned.
>>>=20
>>> Yes, but there is a compiler between the HLL code and what the
>>> processor sees which can tear the write. How can not using
>>> WRITE_ONCE() prevent store-tearing? See [1]. My understanding is =
that
>>> it is OK only if the reader did a NULL check. In that case the torn
>>=20
>> Yes, a write-write data race where the value is the same is also =
fine.
>>=20
>> But they are still data race, if the compiler is within its right to =
do anything it likes (due to data race),
>> we still need WRITE_ONCE() in these cases, though it=E2=80=99s =
semantically safe.
>>=20
>> IIUC, even with _ONCE(), the compiler is within its right do anything =
according to the standard (at least before the upcoming C23), because =
the standard doesn=E2=80=99t consider a volatile access to be atomic.
>>=20
>> However, the kernel consider the volatile access to be atomic, right?
>>=20
>> BTW, line 5 in the example is likely to be optimized away. And yes, =
the compiler can cache the value loaded from line 5 from the perspective =
of undefined behavior, even if I believe it would be a compiler bug from =
the perspective of kernel.
>=20
> I am actually a bit lost with what you are trying to say.  Are you =
saying that mixing
> plain accesses with marked accesses is an acceptable practice?=20


I=E2=80=99m trying to say that sometimes data race is fine, that=E2=80=99s=
 why we have the data_race().

Even if the standard says data race results in UB.

And IMHO, the possible data race at line 5 in this example is also fine, =
unless the compiler=20
deduces that the value of gp is always the same.


>=20
> I would like others to weight in as well since I am not seeing what =
Alan is suggesting.
> AFAICS, in the absence of barrier(), any optimization caused by plain =
access
> makes it a bad practice to mix it.
>=20
> Thanks,
>=20
> - Joel
>=20
>=20
>=20
>>=20
>>> result will not change the semantics of the program. But otherwise,
>>> that's bad.
>>>=20
>>> [1] https://lwn.net/Articles/793253/#Store%20Tearing
>>>=20
>>> thanks,
>>>=20
>>> - Joel
>>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>> Thanks.
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>> +plain accesses of a memory location with rcu_dereference() of =
the same memory
>>>>>>> +location, in code involved in a data race.
>>>>>>> +
>>>>>>> In short, updaters use rcu_assign_pointer() and readers use
>>>>>>> rcu_dereference(), and these two RCU API elements work together =
to
>>>>>>> ensure that readers have a consistent view of newly added data =
elements.
>>>>>>> --
>>>>>>> 2.41.0.585.gd2178a4bd4-goog


