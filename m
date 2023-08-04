Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717FD770617
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHDQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHDQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:33:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A8E7;
        Fri,  4 Aug 2023 09:33:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b2b60731so15817085ad.2;
        Fri, 04 Aug 2023 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691166803; x=1691771603;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zUbJG0vNvOSjbaG5BW1E6w7zVIXM3WGSGO6CRILvPk=;
        b=gf1ZN7J1Njt17I/hnulTGGLsW+J0Z5NZXPV+XvdQxCkIRh5urgM+6psdsVkAlOyDwO
         MSPbOWNqRE5bCyO/t+GMUE/+SZJKXVnDct135Sb4YBD2jPuupGDxRpcBXGfU3C3nRxJk
         k7rDIzRp2wRN5mB3jAf1YWixbI7ofH5Is8i3K3afPXTKfOghoW3qYAy3TUjhliP9sZ4q
         2cNA1uck+xyKCcxS5OiHKij6ZHLPI9pwiBiXhlysp4/oF4+sYYdNKA0pWzwEjJDvd8nq
         vrPACOo/fei6SRqLdUAIxMS0wZMFVBkjO7v+TbET9RqnKZkzzMIsbmBcibJ6HMu9KJ6y
         /N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166803; x=1691771603;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zUbJG0vNvOSjbaG5BW1E6w7zVIXM3WGSGO6CRILvPk=;
        b=DLKs5Lpk3kv3LfurRdw8oXNJ9vP343BvMGCBs9H1rm2lRE2OttDwVbJu9RDyryRAB4
         chcRWi9WCt10wfnmxKe5dGnBnmWlFRGc1GyfXWDVDX/kumdkRuz9iRX3rCPl9P0Q8TeE
         569556lfiHHbRESYlYazap01BUj8TQVLvooduzljPjU3OrwsZHgwU43uOB0nfIEWpenO
         0C2eKlubVMkyrlSfoqkU7XPlwnbSRZiDTyGh79lwzvM9Oh/KzgnA1melq/dDRsWXQD48
         CgYaHWup1rojnk+LpHv73z1DBEiliP5bNvqRdOU65uMKqncCTX/OOrtNr7/OoafnBYov
         Qimg==
X-Gm-Message-State: AOJu0Yz1DHINUhQWwoq21v312Ki8+FDS5AWrhp+oNtf6ApxYCKbuFIC2
        iQdQfYIYyhVCPem1GV33VSKSnZ4JmAg=
X-Google-Smtp-Source: AGHT+IHul1Nv0wZnQ7/SJVYhL7LA+a5xoo2SEKtdh3x2agzpbIWhw44NuHUQvzYGdsoOnXVHWowwaA==
X-Received: by 2002:a17:902:c246:b0:1bb:b86e:8d6d with SMTP id 6-20020a170902c24600b001bbb86e8d6dmr2054741plg.29.1691166802975;
        Fri, 04 Aug 2023 09:33:22 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001bba3650448sm1979650plk.258.2023.08.04.09.33.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:33:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to
 requirements
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
Date:   Sat, 5 Aug 2023 00:33:03 +0800
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Will Deacon <will@kernel.org>,
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
Message-Id: <DFBE4F45-BF8B-4267-93C7-B085A88BE356@gmail.com>
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
 <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
 <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
 <CAEXW_YRXA3j3k9VRuZJ7d=yo6__TRpeE6igrQ+GEZiyKtFmUOQ@mail.gmail.com>
 <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
 <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
>=20
> Volatile accesses are not specified very well in the standard.  =
However,
> as a practical matter, compilers that wish to be able to device =
drivers
> (whether in kernels or userspace applications) must compile those =
volatile
> accesses in such a way to allow reliable device drivers to be written.
>=20
>> However, the kernel consider the volatile access to be atomic, right?
>=20
> The compiler must therefore act as if a volatile access to an aligned
> machine-word size location is atomic.  To see this, consider accesses
> to memory that is shared by a device driver and that device's =
firmware,
> both of which are written in either C or C++.

I learned these things a few months ago. But still thank you!

The real problem is that there may be a data race at line 5, so Joel is =
correct that the compiler
can cache the value loaded from line 5 according to the standard given =
that the standard says that
a data race result in undefined behavior, so the compiler might be =
allowed to do anything. But from the
perspective of the kernel, line 5 is likely a diagnostic read, so it=E2=80=
=99s fine without READ_ONCE() and the
compiler is not allowed to cache the value.

This situation is like the volatile access.

Am I missing something?

>=20
> Does that help?
>=20
> Thanx, Paul
>=20
>> BTW, line 5 in the example is likely to be optimized away. And yes, =
the compiler can cache the value loaded from line 5 from the perspective =
of undefined behavior, even if I believe it would be a compiler bug from =
the perspective of kernel.
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


