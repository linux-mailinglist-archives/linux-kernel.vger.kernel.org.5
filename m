Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAD76E7EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjHCMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHCMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:09:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B142D5F;
        Thu,  3 Aug 2023 05:09:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f090310dso803433b3a.0;
        Thu, 03 Aug 2023 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691064544; x=1691669344;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx2oQNP8dRig7LZXLqCiP6SuqwiYqFZRo7LyhqCpqHE=;
        b=IWonB6QUJ4N8aOKnWPyxE8cS5xjIgORpLfILdZrQsbCOO+rypbS3BZuhJ5KnTCcCFw
         EKXkMK4V/+m0CuWpQlg7DK+azW1pksjVKIuso4yhfG0CBhGGFsGtAgFeqQbJaL1T57P4
         1eSFYN823Wr3GtpwgzB+R+U/ian13/p8aL0tkVOwnDr+lNmCDXcz7UxxirryGzDC0WQt
         Wz3JvSPqCxOyV9i8zgawCugOmAlBAO9fQ8pinx8H2W4WCVhVcqvET5JPaLI0ttTn9W15
         DDatRD3T2sqadjeIhlY/QycfDE5FlnIbMic4TJ342EP/TC4kb0AfxZF8W++k0AKpcYLu
         04/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691064544; x=1691669344;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx2oQNP8dRig7LZXLqCiP6SuqwiYqFZRo7LyhqCpqHE=;
        b=hmrRD+9GjOFHqs0d8Hv0stjO9TyA7/QOsxFfYCpcXe4jDskezdZ2rhap4qmTFjeB//
         vZl+bN/Zwucf8Kcn9+oC0CU4pCn3BIpgS7nHhT+tBP7aAhqkdIx9tA/M/nvih4tvGMqr
         R+fN8lDT24BsP1hWxFiChdhXSTB0Ddk56Wij7z0k2ZC0qjn0jGyK3p4FByxh6EnJL3BH
         08usM8FwGj2vVGStijPFPz84S6JkLU2JwuqPdr7ohAdm5HK2gTGX0UO5Ow6M/EswitAR
         YhkybyC/APmSxhDWUe5Tw8AsdNqxpqlIcWRofTwZykYbea8Opl+sa5LCBbGEUmPQospS
         Wt9A==
X-Gm-Message-State: ABy/qLZXa6QUvLVa5VLH2xElQuy6P2jOoVHJpYhIwcMLKMS4UU1WVYvw
        VvE3yMp/G2HBNcmwZMhefoGTlO6sAZo=
X-Google-Smtp-Source: APBJJlHfPOmNVqzk4UYYb0aPNzRDVgHbymXt7FDbUU5DACSUoqSe98naInUtdRs/F8Go2LAhLORjsw==
X-Received: by 2002:a05:6a00:ad4:b0:681:c372:5aa4 with SMTP id c20-20020a056a000ad400b00681c3725aa4mr23931679pfl.27.1691064543845;
        Thu, 03 Aug 2023 05:09:03 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id v14-20020a62a50e000000b00681783cfc85sm13083358pfm.144.2023.08.03.05.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 05:09:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to
 requirements
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20230803032408.2514989-1-joel@joelfernandes.org>
Date:   Thu, 3 Aug 2023 20:08:42 +0800
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
Message-Id: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
References: <20230803032408.2514989-1-joel@joelfernandes.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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


> 2023=E5=B9=B48=E6=9C=883=E6=97=A5 11:24=EF=BC=8CJoel Fernandes =
(Google) <joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Add a detailed note to explain the potential side effects of
> plain-accessing the gp pointer using a plain load, without using the
> rcu_dereference() macros; which might trip neighboring code that does
> use rcu_dereference().
>=20
> I haven't verified this with a compiler, but this is what I gather =
from
> the below link using Will's experience with READ_ONCE().
>=20
> Link: =
https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck/
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
> 1 file changed, 32 insertions(+)
>=20
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst =
b/Documentation/RCU/Design/Requirements/Requirements.rst
> index f3b605285a87..e0b896d3fb9b 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference =
counting
> .. |high-quality implementation of C11 memory_order_consume [PDF]| =
replace:: high-quality implementation of C11 ``memory_order_consume`` =
[PDF]
> .. _high-quality implementation of C11 memory_order_consume [PDF]: =
http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
>=20
> +Note that, there can be strange side effects (due to compiler =
optimizations) if
> +``gp`` is ever accessed using a plain load (i.e. without =
``READ_ONCE()`` or
> +``rcu_dereference()``) potentially hurting any succeeding
> +``rcu_dereference()``. For example, consider the code:
> +
> +   ::
> +
> +       1 bool do_something_gp(void)
> +       2 {
> +       3   void *tmp;
> +       4   rcu_read_lock();
> +       5   tmp =3D gp; // Plain-load of GP.
> +       6   printk("Point gp =3D %p\n", tmp);
> +       7
> +       8   p =3D rcu_dereference(gp);
> +       9   if (p) {
> +      10     do_something(p->a, p->b);
> +      11     rcu_read_unlock();
> +      12     return true;
> +      13   }
> +      14   rcu_read_unlock();
> +      15   return false;
> +      16 }
> +
> +The behavior of plain accesses involved in a data race is =
non-deterministic in
> +the face of compiler optimizations. Since accesses to the ``gp`` =
pointer is
> +by-design a data race, the compiler could trip this code by caching =
the value
> +of ``gp`` into a register in line 5, and then using the value of the =
register
> +to satisfy the load in line 10. Thus it is important to never mix

Will=E2=80=99s example is:

	 // Assume *ptr is initially 0 and somebody else writes it to 1
	 // concurrently

	 foo =3D *ptr;
	 bar =3D READ_ONCE(*ptr);
	 baz =3D *ptr;

Then the compiler is within its right to reorder it to:

	foo =3D *ptr;
 	baz =3D *ptr;
 	bar =3D READ_ONCE(*ptr);

So, the result foo =3D=3D baz =3D=3D 0 but bar =3D=3D 1 is perfectly =
legal.

But the example here is different, the compiler can not use the value =
loaded from line 5
unless the compiler can deduce that the tmp is equals to p in which case =
the address dependency
doesn=E2=80=99t exist anymore.

What am I missing here?

> +plain accesses of a memory location with rcu_dereference() of the =
same memory
> +location, in code involved in a data race.
> +
> In short, updaters use rcu_assign_pointer() and readers use
> rcu_dereference(), and these two RCU API elements work together to
> ensure that readers have a consistent view of newly added data =
elements.
> --=20
> 2.41.0.585.gd2178a4bd4-goog
>=20

