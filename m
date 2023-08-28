Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48978AEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjH1LWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjH1LV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:21:59 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD9B6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:21:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230828112152euoutp02fa5b7723439285b77a9fb2e17bdaf6e6~-iC0a1vl20279402794euoutp02d
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:21:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230828112152euoutp02fa5b7723439285b77a9fb2e17bdaf6e6~-iC0a1vl20279402794euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693221712;
        bh=VQPiQZ6BlJOv7UycB/t5qmClTXP5K+iValXtnswktQs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bKTesSLcdSWCtAEzPYbMrEhtIxPldXOJH0WLtyGV/KWxOfa6ZVrzFmcvzkTOdT3GI
         g8HTvhpfcEQ1hFqv+XFa8NEE+xlKMwLH1VBIDx5QYx76awPko89pL4d5zX6nUoTrdA
         WGKmhK6SxKcVWuUZIZMft5UxlIlC/eB8BVO2Wz3Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230828112151eucas1p2211c1c044945d76975c5cee44f3be17b~-iC0Exmga2794827948eucas1p2N;
        Mon, 28 Aug 2023 11:21:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CC.B3.37758.F438CE46; Mon, 28
        Aug 2023 12:21:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230828112151eucas1p2371f4cf778e6265e8ac5baf8ea91be4d~-iCzrf_N92792827928eucas1p2O;
        Mon, 28 Aug 2023 11:21:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230828112151eusmtrp255b7d9d3f203c26a979f5e6e1dfaefa5~-iCzqwsBN0113301133eusmtrp2i;
        Mon, 28 Aug 2023 11:21:51 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-d5-64ec834ff7df
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.7C.14344.F438CE46; Mon, 28
        Aug 2023 12:21:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230828112151eusmtip22b02f52c7432cc1694d03f92cc5371d9~-iCzf-P-23182131821eusmtip2p;
        Mon, 28 Aug 2023 11:21:51 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Mon, 28 Aug 2023 12:21:50 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 28 Aug
        2023 12:21:50 +0100
From:   Andreas Hindborg <a.hindborg@samsung.com>
To:     Alice Ryhl <aliceryhl@google.com>
CC:     "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "Tejun Heo" <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 4/7] rust: workqueue: add helper for defining
 work_struct fields
Thread-Topic: [PATCH v4 4/7] rust: workqueue: add helper for defining
        work_struct fields
Thread-Index: AQHZ2aHWyjhGrDdcWUuOhpl6ciq6/A==
Date:   Mon, 28 Aug 2023 11:21:50 +0000
Message-ID: <87y1hvtnsi.fsf@samsung.com>
In-Reply-To: <20230828104807.1581592-5-aliceryhl@google.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87r+zW9SDI5d07H4O3s7u8WJ600s
        Fh+uNbFa3Liwn9lizZZGJouLZ14zWkxdu5vJ4vKuOWwWK+cvZ7S4fOISo8X6Z4eZLX4tP8po
        sWHZWkYHXo8lnb+YPHbOusvusWBTqcemVZ1sHi82z2T0+N6+h82jp20Tk8fnTXIBHFFcNimp
        OZllqUX6dglcGb3LdzAVHBWpeHl7LnMD4zaBLkZODgkBE4nD16eydzFycQgJrGCUeLn+KwtI
        QkjgC6PEqnk1EInPjBJLPjcxwnRM+bCHHaJoOaPE+TZ/uKJjv1dDJc4wSqyYqgyRWMkoMe1G
        O1g3m4C+xLU115hBbBEBVYkztxrYQGxmgaUsEjcuyIDYwgKREo8e7GWFqImSmNl4iRHC1pP4
        MbERzGYB6t049wDYMl4BDYmWWdfB4pwCNhJbGheDvcAoICvxaOUvdoj54hK3nsxngvhAUGLR
        7D3MELaYxL9dD9kgbB2Js9efQH1pILF16T4WCFtR4lrPTUaIOXoSN6ZOgbpZW2LZwtfMEDcI
        Spyc+YQF5GEJgTYuidf7pkENdZFoW98EtVhY4tXxLewQtozE/53zmSYwas9Cct8sJDtmIdkx
        C8mOBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIT3Ol/x7/uYFzx6qPeIUYmDsZD
        jBIczEoivJccX6UI8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi
        4JRqYFL+vv7yBEcu1eKmw3e+LYi6Lx8a+V+v/1J2W6nI1EcvHkSsmSAf6f5DzkbAUnRBza3N
        RY1rNa9stFom/Jlvmi6zQvSFha/2t4U18Jc15Jbf28BWmxomrv79VdKsj/GXJRKYf7t9dkjP
        mHQ5aJ+O07Vpkv7rpqveWfD5wn5965oi97Y5KxYp7vIW/Vp1RHbHrVlnY+WfOy5zrWx4JG4q
        GyB4eIqV+9rUPzwLFR6F1Qo3TW658ERANP7P1gqfxWcn/J97/oqJQcH2f7oPl5b9dgzduGAt
        z5bdNjnlj15xrH3j/2vdAf3XXYL8755vejlp7uQp780V5zc16lmF9Ol7XVbun2lYJpm1Yfup
        JWJCt4qVWIozEg21mIuKEwFqsNfV3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/xe7r+zW9SDJ48F7X4O3s7u8WJ600s
        Fh+uNbFa3Liwn9lizZZGJouLZ14zWkxdu5vJ4vKuOWwWK+cvZ7S4fOISo8X6Z4eZLX4tP8po
        sWHZWkYHXo8lnb+YPHbOusvusWBTqcemVZ1sHi82z2T0+N6+h82jp20Tk8fnTXIBHFF6NkX5
        pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb3LdzAVHBWp
        eHl7LnMD4zaBLkZODgkBE4kpH/awdzFycQgJLGWUWHNzKhNEQkZi45errBC2sMSfa11sILaQ
        wEdGibZlARD2GUaJj6+ZIJpXMkp8unifGSTBJqAvcW3NNTBbREBV4sytBjaQImaBpSwSv17e
        YwFJCAtESjx6sJcVoihKYsvMXSwQtp7Ej4mNjCA2C1DzxrkH2EFsXgENiZZZ1xkhNudK7J72
        G+wiTgEbiS2Ni8F6GQVkJR6t/AVWzywgLnHryXyobwQkluw5zwxhi0q8fPwP6jMdibPXnzBC
        2AYSW5fuY4GwFSWu9dxkhJijJ3Fj6hQ2CFtbYtnC18wQ9whKnJz5hGUCo/QsJOtmIWmZhaRl
        FpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLT1LZjP7fsYFz56qPeIUYmDsZDjBIc
        zEoivJccX6UI8aYkVlalFuXHF5XmpBYfYjQFhtFEZinR5HxgoswriTc0MzA1NDGzNDC1NDNW
        Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamBSX//gbenzF7xmJx5/jjt/Ob+r6M2tfdobsndx
        W6hJ2LE+D8l6v/2ywbXNt6NP8E+36LsSLLM0bkmgUJ3AA8HafVNmyO5qMDMP+BTol1RatP/2
        MuG3kedXhnfwbP5gtWZCljJPvn7qi6kBOuFOUjG3lN4//b4wde4yP+VtTzdf+6Tf4uq4Romx
        Y12MlW5IdMbuZsk6Bf9rO24pOE4/dLC39ErJ1kVFTBNOhfm7pH2Sn3vq5peKWbdWTwiqPr1x
        MkPYrYtiNXO+XZ8QsfrKovPHdvTFLT6gmX29gEOKZ7LEpFX5osXdWu9y3s9ZsX/yiqRtu3pW
        8eyS+WTl63zW2/i+5YeMOG6By9od92573zqUoMRSnJFoqMVcVJwIAHH6aoDcAwAA
X-CMS-MailID: 20230828112151eucas1p2371f4cf778e6265e8ac5baf8ea91be4d
X-Msg-Generator: CA
X-RootMTR: 20230828112151eucas1p2371f4cf778e6265e8ac5baf8ea91be4d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230828112151eucas1p2371f4cf778e6265e8ac5baf8ea91be4d
References: <20230828104807.1581592-1-aliceryhl@google.com>
        <20230828104807.1581592-5-aliceryhl@google.com>
        <CGME20230828112151eucas1p2371f4cf778e6265e8ac5baf8ea91be4d@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
>
> There are three important pieces that are relevant when doing this:
>
>  * The pointer type.
>  * The work item struct. This is what the pointer points at.
>  * The `work_struct` field. This is a field of the work item struct.
>
> This patch introduces a separate trait for each piece. The pointer type
> is given a `WorkItemPointer` trait, which pointer types need to
> implement to be usable with the workqueue. This trait will be
> implemented for `Arc` and `Box` in a later patch in this patchset.
> Implementing this trait is unsafe because this is where the
> `container_of` operation happens, but user-code will not need to
> implement it themselves.
>
> The work item struct should then implement the `WorkItem` trait. This
> trait is where user-code specifies what they want to happen when a work
> item is executed. It also specifies what the correct pointer type is.
>
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T, ID>`. The trait is marked unsafe
> because the OFFSET constant must be correct, but we provide an
> `impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
> The macro expands to something that only compiles if the specified field
> really has the type `Work<T>`. It is used like this:
>
> ```
> struct MyWorkItem {
>     work_field: Work<MyWorkItem, 1>,
> }
>
> impl_has_work! {
>     impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> }
> ```
>
> Note that since the `Work` type is annotated with an id, you can have
> several `work_struct` fields by using a different id for each one.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
