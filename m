Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A467867A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbjHXGmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbjHXGmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:42:12 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6054C1716
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:42:02 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230824064159euoutp010c6d6230ba3d6c6c16e47c175f682b2b~_PpTzwavl1331813318euoutp01Y
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:41:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230824064159euoutp010c6d6230ba3d6c6c16e47c175f682b2b~_PpTzwavl1331813318euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692859319;
        bh=pUmxRM83H3hPfH5q9K2Tm5tvur4KAIlpeP6pDPyB8SM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VTAfBeC5uZFmAUStzw8O+QU8cK6hAAjtsj33fjE6gdJp2grTIBUFVRHztYbiRf3bU
         InwUZzx1TyO02XtQS1s5Sgh8EEq51/cCwuY/DHcB/9ZEDCF1M0GBa05lMaaxh4JjJl
         /ily2ufwZdzc1JjmKDUKr1UDURbzUQP6gYGmqr7w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230824064157eucas1p13dd030b30dfde1d5f8cabce08b9a039b~_PpSdbcbF0594005940eucas1p1C;
        Thu, 24 Aug 2023 06:41:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AE.8C.42423.5BBF6E46; Thu, 24
        Aug 2023 07:41:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230824064157eucas1p1023586f5eec1f0bed1464a7a388b3ad3~_PpSAPKed0592305923eucas1p1C;
        Thu, 24 Aug 2023 06:41:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230824064157eusmtrp20e977ff431bc6722598ffc56c495d2e7~_PpR-gm__0717307173eusmtrp2T;
        Thu, 24 Aug 2023 06:41:57 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-a9-64e6fbb54379
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.75.14344.5BBF6E46; Thu, 24
        Aug 2023 07:41:57 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230824064157eusmtip246268c6b99399374e45c67e04d59c789~_PpR1RPmk1967019670eusmtip2d;
        Thu, 24 Aug 2023 06:41:57 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 24 Aug 2023 07:41:57 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 24 Aug
        2023 07:41:56 +0100
From:   Andreas Hindborg <a.hindborg@samsung.com>
To:     Miguel Ojeda <ojeda@kernel.org>
CC:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 1/2] rust: arc: add explicit `drop()` around
 `Box::from_raw()`
Thread-Topic: [PATCH 1/2] rust: arc: add explicit `drop()` around
        `Box::from_raw()`
Thread-Index: AQHZ1duEypdgNEUaJ0yfoLAXoIgAyq/475mA
Date:   Thu, 24 Aug 2023 06:41:55 +0000
Message-ID: <877cpl7xhp.fsf@samsung.com>
In-Reply-To: <20230823160244.188033-2-ojeda@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.210.248.72]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pbfz9LMTj11tTi7+zt7BYnrjex
        WHy41sRqcePCfmaLNVsamSwunnnNaHF51xw2i5XzlwNZJy4xWqx/dpjZYsOytYwO3B5LOn8x
        eeycdZfdY8GmUo9NqzrZPF5snsno8b19D5tHT9smJo/Pm+QCOKK4bFJSczLLUov07RK4Mnb+
        PM5ccEuk4tHppYwNjDf5uxg5OSQETCQOLf7C3MXIxSEksIJR4t+t9ywQzhdGieXvTrBCOJ8Z
        JVr2T2aEadl6+DZUYjmjxOMNTexwVf8n3YTqPwPU8nYWVNlKRolr8x8xg/SzCehLXFtzDcwW
        EVCWaDjwig2kiFngAbPEi+ZNYAlhgRCJMz/uMUEUhUps3HAIyjaSaFnyiAXEZhFQlVgy8S9Y
        Pa+AhkTvuoVgNqeAucTiK2/AbEYBWYlHK3+xg9jMAuISt57MZ4J4QlBi0ew9zBC2mMS/XQ/Z
        IGwdibPXn0A9aiCxdek+FghbSWLKlvfMEHP0JG5MncIGYWtLLFv4GuoGQYmTM5+AvS8h8I1T
        4vHW9VALXCROLN0PtUBY4tXxLewQtozE/53zmSYwas9Cct8sJDtmIdkxC8mOBYwsqxjFU0uL
        c9NTiw3zUsv1ihNzi0vz0vWS83M3MQKT2ul/xz/tYJz76qPeIUYmDsZDjBIczEoivF98nqUI
        8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYMpnW5t81kSc
        bVXRwlUB+9ys05s4rvx76fTJqr4u1VbKZWO+kuD6oyeatu5UYJWw28eWlq+iziJQwbNQ5kB3
        Z/j94Go1td6Hao+TZh8wmbky/M/ag+ambWYysRwFBxlXyMzytdKPnFXmvarI5afW1dK6WefW
        PK7/dLP5Nusr/dOMvP84Nm1ivNhRtt4z5KCmcevuTzPq6yapzS+5tf/Mt3k80+s6Z9hfXOOq
        V+KR5qdmF6pg1qP17TTHffajM5rP3/bmCmN/lxSWvXfDg1kGc9VevXmkUjfps46sanP1Q4tD
        ExQENrxebnEwx/d54bJPjzpcRF7fWFb4YJsFc8Is97rVjo0i278+dJ757ojiYiWW4oxEQy3m
        ouJEAO+WnSrZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsVy+t/xe7pbfz9LMdgxRcLi7+zt7BYnrjex
        WHy41sRqcePCfmaLNVsamSwunnnNaHF51xw2i5XzlwNZJy4xWqx/dpjZYsOytYwO3B5LOn8x
        eeycdZfdY8GmUo9NqzrZPF5snsno8b19D5tHT9smJo/Pm+QCOKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mnb+PM5ccEuk4tHppYwNjDf5uxg5
        OSQETCS2Hr7N2sXIxSEksJRR4v2TQ2wQCRmJjV+uskLYwhJ/rnWBxYUEPjJKLHojD9FwhlFi
        4udjbBDOSkaJO2uXM4NUsQnoS1xbcw3MFhFQlmg48AqsiFngAbPEqjcd7CAJYYEQiTM/7jFB
        FIVK7G25zw5hG0m0LHnEAmKzCKhKLJn4F2wQr4CGRO+6hcwQZ2xnlPi3TB/E5hQwl1h85Q1Y
        nFFAVuLRyl9gc5gFxCVuPZnPBPGCgMSSPeeZIWxRiZeP/0G9piNx9voTRgjbQGLr0n0sELaS
        xJQt75kh5uhJ3Jg6hQ3C1pZYtvA11D2CEidnPmGZwCg9C8m6WUhaZiFpmYWkZQEjyypGkdTS
        4tz03GIjveLE3OLSvHS95PzcTYzApLTt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO8Xn2cpQrwp
        iZVVqUX58UWlOanFhxhNgWE0kVlKNDkfmBbzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
        UrNTUwtSi2D6mDg4pRqYIp+Wl6QKFS7L0mOu/cPA9rqLPzLcp3KKeWvAPautT96dF3mz2Hz9
        nOl7Rb41vJ51g0PKxem20nPvD2q5k7q2m8iffR/fe8TpnvOTrlP7Pl5M9tEvZVtcpvfzmuTO
        OH/lVb8vvl7aJBH3/klnsrvYGsWA7usbPS79DI9/p2Wxe+Xlly7S/4LPycU6qegLta/WDbib
        sTBlomdK+P6bmx6skF9yYN4Kqd9bjr/2nLKMoU+R9bHvSY60hkNc+4tVsnSlnOcFy/05bvdI
        ceeRzTrL3j8wmc/3aZ5letTLbE7Wm1aFErfrPTw3/zMs3DHFLPeSkdbcPUd/VOf+rNujfOly
        3To37pjG2U2zVi58zndQRYmlOCPRUIu5qDgRAJmifW7TAwAA
X-CMS-MailID: 20230824064157eucas1p1023586f5eec1f0bed1464a7a388b3ad3
X-Msg-Generator: CA
X-RootMTR: 20230823160307eucas1p10d2cc77f1ee1c9129681eb585a386521
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230823160307eucas1p10d2cc77f1ee1c9129681eb585a386521
References: <20230823160244.188033-1-ojeda@kernel.org>
        <CGME20230823160307eucas1p10d2cc77f1ee1c9129681eb585a386521@eucas1p1.samsung.com>
        <20230823160244.188033-2-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <ojeda@kernel.org> writes:

> `Box::from_raw()` is `#[must_use]`, which means the result cannot
> go unused.
>
> In Rust 1.71.0, this was not detected because the block expression
> swallows the diagnostic [1]:
>
>     unsafe { Box::from_raw(self.ptr.as_ptr()) };
>
> It would have been detected, however, if the line had been instead:
>
>     unsafe { Box::from_raw(self.ptr.as_ptr()); }
>
> i.e. the semicolon being inside the `unsafe` block, rather than
> outside.
>
> In Rust 1.72.0, the compiler started warning about this [2], so
> without this patch we will get:
>
>         error: unused return value of `alloc::boxed::Box::<T>::from_raw` =
that must be used
>         --> rust/kernel/sync/arc.rs:302:22
>         |
>     302 |             unsafe { Box::from_raw(self.ptr.as_ptr()) };
>         |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D note: call `drop(Box::from_raw(ptr))` if you intend to drop t=
he `Box`
>         =3D note: `-D unused-must-use` implied by `-D warnings`
>     help: use `let _ =3D ...` to ignore the resulting value
>         |
>     302 |             unsafe { let _ =3D Box::from_raw(self.ptr.as_ptr())=
; };
>         |                      +++++++                                 +
>
> Thus add an add an explicit `drop()` as the `#[must_use]`'s
> annotation suggests (instead of the more general help line).
>
> Link: https://protect2.fireeye.com/v1/url?k=3D9e9028e1-ff1b3dd7-9e91a3ae-=
74fe485cbff1-f2bfda5f7702c68e&q=3D1&e=3D66bd90a6-86db-48e7-8538-c118c3f45ba=
a&u=3Dhttps%3A%2F%2Fgithub.com%2Frust-lang%2Frust%2Fissues%2F104253 [1]
> Link: https://protect2.fireeye.com/v1/url?k=3D89300613-e8bb1325-89318d5c-=
74fe485cbff1-fcf76e46b008b25a&q=3D1&e=3D66bd90a6-86db-48e7-8538-c118c3f45ba=
a&u=3Dhttps%3A%2F%2Fgithub.com%2Frust-lang%2Frust%2Fpull%2F112529 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/sync/arc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 172f563976a9..4c14d540a581 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -299,7 +299,7 @@ fn drop(&mut self) {
>              // The count reached zero, we must free the memory.
>              //
>              // SAFETY: The pointer was initialised from the result of `B=
ox::leak`.
> -            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> +            unsafe { drop(Box::from_raw(self.ptr.as_ptr())) };
>          }
>      }
>  }
