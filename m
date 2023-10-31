Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DC7DC72C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbjJaHXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbjJaHXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:23:08 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5008F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:23:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231031072301euoutp0178f2e58ea6e3f78662a5e05252103768~TIEjOGfKf2914729147euoutp01y
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231031072301euoutp0178f2e58ea6e3f78662a5e05252103768~TIEjOGfKf2914729147euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698736981;
        bh=1uYHkbsV5u2NBiN1eUWz+2QSJ2DT21D89y8Ixj1J8JY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bhLyobmh3q/adHjRwv2qZjJYXCSdGNtK3uJ4bNvhkQqXNpLU9wZ1hT277N8J4swaF
         2CZ3LmKxhK3SdtBnkfF1CKTaAykKs8MzF9pzLl+Mir4beXpYai37VMsGnozJ1Eqx8A
         Jjd1I/i+fnAgR7RFZEyO+dMW/QfYDcRgHAkw8Eyo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231031072300eucas1p212a4998cf4db22ac68c2f39b07683b1f~TIEiu0Ymj0147101471eucas1p2W;
        Tue, 31 Oct 2023 07:23:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A3.C4.11320.45BA0456; Tue, 31
        Oct 2023 07:23:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231031072300eucas1p282cad5700201f4c07f337c48675a0104~TIEiVi1ne1097410974eucas1p2p;
        Tue, 31 Oct 2023 07:23:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231031072300eusmtrp1f7efdc55585041a959b862ccfe175585~TIEiU0OhT2895128951eusmtrp1h;
        Tue, 31 Oct 2023 07:23:00 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-b2-6540ab547c78
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.74.25043.45BA0456; Tue, 31
        Oct 2023 07:23:00 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031072300eusmtip1fdd627821f6fab5a2b357d355447e011~TIEiGu-VW1818118181eusmtip1q;
        Tue, 31 Oct 2023 07:23:00 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 31 Oct 2023 07:22:59 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 31 Oct
        2023 07:22:59 +0000
From:   Andreas Hindborg <a.hindborg@samsung.com>
To:     Benno Lossin <benno.lossin@proton.me>
CC:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        "Viktor Garske" <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Thread-Topic: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Thread-Index: AQHaCEn51y1znPu5g0OLkL6vmknml7BjhYSA
Date:   Tue, 31 Oct 2023 07:22:59 +0000
Message-ID: <87bkcf6yst.fsf@samsung.com>
In-Reply-To: <20231026201855.1497680-1-benno.lossin@proton.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.64]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7ohqx1SDXZcN7f4O3s7u8WJ600s
        Fh+uNbFa3Liwn9lizZZGJouLZ14zWuzrPs5qcXnXHDaLvesvs1msnL+c0WL9s8PMFg9v32Sx
        mNcJ1Lth2VpGiyst7awO/B6f5j1n8ljS+YvJY+esu+weCzaVemxa1cnmMa9zHpPH9/Y9bB49
        bZuYPE5tmsvu8XmTXABXFJdNSmpOZllqkb5dAlfGinmXmQsaWSvOrfzD3sA4m6WLkZNDQsBE
        YsOJu+xdjFwcQgIrGCV+P93IBuF8YZR4s2E3C4TzmVHi+utNcC3fJ79jhUgsZ5S4fOUqE1zV
        3X9XoPrPMEp8WvSCGaRFSGAlo8TpK1kgNpuAvsS1NdfA4iICmhJ37/0H62YWeMIisWf+OTaQ
        hLCAu8TBRzcZIYo8JD5tfgNlG0n0rHoIdAcHB4uAqsT5gwIgYV4BDYmrsz6wgticAnYSH579
        YwexGQVkJR6t/AVmMwuIS9x6Mp8J4gVBiUWz9zBD2GIS/3Y9ZIOwdSTOXn/CCGEbSGxdug/q
        ZUWJaz0Q5zAL6EncmDqFDcLWlli28DUzxA2CEidnPgGHl4TAUi6JCbcnsEI0u0hcmP8VapCw
        xKvjW9ghbBmJ05N7WCYwas9Cct8sJDtmIdkxC8mOBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz
        0vWS83M3MQKT4el/x7/sYFz+6qPeIUYmDsZDjBIczEoivIdNHVKFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamFYdjb9y/eCvKmnL53lLc8PeXrv4OvJ9
        o2ntBBbOyUXK9WdX7Hxg4qbQy/NG+37Cu6rugP454i7Fuvc06wvfKPUeinE7v2NLbe2D2gtB
        NS777LNiKqc2brh73/6yE9cS2TXPLp7kTbuTypjS8sMt7cHRwIj7h48mcad+aRPgMGQ/PjtX
        wDU6yD914vGJTQ+vZis6dhpUCG1tVr8+Z9nXLfEx/VyTJvdcnnDZNX7O7coDpQ+Mv5tOv5jq
        6uLRzHFfgdWoxSTNOpV/v9yF8+K6HPPlWSbOWfA2RzvlCd+P+kOH7m5drbb867wi0fr44JJL
        3vLNgZ4t3Fn/2nTX25x9Fmz3+K6YruI6p5ucrM3SSizFGYmGWsxFxYkAkFkPSvUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsVy+t/xu7ohqx1SDVatlbL4O3s7u8WJ600s
        Fh+uNbFa3Liwn9lizZZGJouLZ14zWuzrPs5qcXnXHDaLvesvs1msnL+c0WL9s8PMFg9v32Sx
        mNcJ1Lth2VpGiyst7awO/B6f5j1n8ljS+YvJY+esu+weCzaVemxa1cnmMa9zHpPH9/Y9bB49
        bZuYPE5tmsvu8XmTXABXlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
        SmpOZllqkb5dgl7GinmXmQsaWSvOrfzD3sA4m6WLkZNDQsBE4vvkd6xdjFwcQgJLGSVOTv7B
        CJGQkdj45SorhC0s8edaFxtE0UdGidcn37JDOGcYJd79eg02SkhgJaNE/8tCEJtNQF/i2ppr
        zCC2iICmxN17/5lAGpgFnrBI7Jl/jg0kISzgLnHw0U1GiCIPiU+b30DZRhI9qx4CDeXgYBFQ
        lTh/UAAkzCugIXF11geoUycySjz+dgOsnlPATuLDs3/sIDajgKzEo5W/wGxmAXGJW0/mM0G8
        ICCxZM95ZghbVOLl439Qr+lInL3+BOplA4mtS/dBw0VR4loPxG3MAnoSN6ZOYYOwtSWWLXzN
        DHGQoMTJmU9YJjBKz0KybhaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj
        MKFtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjKTCMJjJL
        iSbnA1NqXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDE2dJ+4aF
        xwQONK6as+VG63vnnbNnLr5yP1JJqmwtQ6Hh5sKNTj7tZ+6Kn+HZaloo65l3PPKVUq4Xm1Ub
        g/HxdZK82auUeL8Zvi/KypzsoD/NT3XW50Vr3kVaXX9mMNnX5O56fc/tsy/oXX3eLqHRduHb
        0Z0TWueV65ns2dVlwb6e22CbuRWb0PySVCPj2dFc0s4afCvvbmH0LKtce2X1c7/1s1asV5v7
        nf/T4x88sz88Oij5c8lJ/SsCqrHOkxe93H7e3qcnpOmLys077ExOspOiNuVHLaw0Y9Sv/z/7
        bHyIhaPV1wU/5y1gnjr73T2PnNNfdilpLq1SWhAcJPL/2HNXHrP6plJz1WrZ+TI3nZVYijMS
        DbWYi4oTAT7RjqjxAwAA
X-CMS-MailID: 20231031072300eucas1p282cad5700201f4c07f337c48675a0104
X-Msg-Generator: CA
X-RootMTR: 20231026201959eucas1p171cfdadceae0ee703af26fa1ae6140a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231026201959eucas1p171cfdadceae0ee703af26fa1ae6140a9
References: <CGME20231026201959eucas1p171cfdadceae0ee703af26fa1ae6140a9@eucas1p1.samsung.com>
        <20231026201855.1497680-1-benno.lossin@proton.me>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <benno.lossin@proton.me> writes:

> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
