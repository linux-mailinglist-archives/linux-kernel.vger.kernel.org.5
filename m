Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329D67CF807
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbjJSMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjJSMD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:03:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE71D76
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:03:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231019120306euoutp0131c257a0715634ee8649e4910c603472~PgJq8cnE_0264302643euoutp01q
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:03:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231019120306euoutp0131c257a0715634ee8649e4910c603472~PgJq8cnE_0264302643euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697716986;
        bh=LpU5UTDD6kkn0qMxKSNmVh5Ejl9/sBb0jdJHEpZGTI4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hOdIO8gPSSn8Yo2Er60fQoLfUw/QfNbfYF/pG2Kauc9ZsGE6HKEIMLLd3u+9TGg6f
         qxTs8rrBdzkluUt1yxqOc7RsBfRub5CXTum5jM6HTUhy/XiGSg3/1WFgfZc55g03J/
         144xQ7om7DeR2zsE9dcXf7wxE9N5GscaSKidpKuE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231019120306eucas1p1fe7f7431c7f471bd2c741c29e603cd7c~PgJqYxCq80765407654eucas1p1i;
        Thu, 19 Oct 2023 12:03:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EA.19.37758.9FA11356; Thu, 19
        Oct 2023 13:03:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231019120305eucas1p13232bbcd5c6357f4d892ae1527e43447~PgJp-yO120789107891eucas1p1f;
        Thu, 19 Oct 2023 12:03:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019120305eusmtrp18877a9a0e2989cf58e25c2bc8880cc82~PgJp7yGQn3232332323eusmtrp1V;
        Thu, 19 Oct 2023 12:03:05 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-08-65311af9f569
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.C0.10549.9FA11356; Thu, 19
        Oct 2023 13:03:05 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231019120305eusmtip13c260a0fd0204d287c92715637e2c27c~PgJpsodoE2779827798eusmtip1G;
        Thu, 19 Oct 2023 12:03:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 19 Oct 2023 13:03:04 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 19 Oct
        2023 13:03:04 +0100
From:   Andreas Hindborg <a.hindborg@samsung.com>
To:     Miguel Ojeda <ojeda@kernel.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Akira Yokosawa <akiyks@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH 1/2] docs: rust: update Rust docs output path
Thread-Topic: [PATCH 1/2] docs: rust: update Rust docs output path
Thread-Index: AQHaAdxzF0ONNLvru0SJFatPcIFbDLBQ89sA
Date:   Thu, 19 Oct 2023 12:03:03 +0000
Message-ID: <87wmviizv2.fsf@samsung.com>
In-Reply-To: <20231018160145.1017340-1-ojeda@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.210.248.240]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7o/pQxTDT5etrTYcyzL4u/s7ewW
        J643sVh8uNbEanHjwn5mizVbGpksJvfNYrJ4cqCd0eLimdeMFgvblrBY/Nm1g8ni8q45bBYP
        H9xgtVg5fzmjxeUTlxgt1j87zGyxYdlaRosrLe2sDkIerZf+snks6fzF5LFz1l12jwWbSj02
        repk83ixeSajx+K+yawe39v3sHn0tG1i8vi8SS6AK4rLJiU1J7MstUjfLoEro3dpakEvZ8Xm
        6xwNjA/Zuxg5OSQETCS2ft7PBmILCaxglLj+JLaLkQvI/sIoseb1XnYI5zOjxJ71JxhhOpbd
        uguVWM4osbj5OQtEO1DV9lNMEIkzjBJ/DpxhhHBWMkqcnfoYbCGbgL7EtTXXmEFsEQFliYYD
        r9hAipgFlrBJrJv/kxUkISzgKLH1zltWiCInidP/vkDZRhKN+z+ArWMRUJW4u+0/mM0roCHR
        trQFbCingIXEx47NYLcyCshKPFr5C2wxs4C4xK0n85kgfhCUWDR7DzOELSbxb9dDNghbR+Ls
        9SdQfxpIbF26jwXCVpbY/XkOC8QcPYkbU6ewQdjaEssWvmaGuEFQ4uTMJywgz0gIbOSS6JzX
        BjSIA8hxkZh90QtijrDEq+NboCEvI3F6cg/LBEbtWUjOm4VkxSwkK2YhWbGAkWUVo3hqaXFu
        emqxcV5quV5xYm5xaV66XnJ+7iZGYIo8/e/41x2MK1591DvEyMTBeIhRgoNZSYRX1cMgVYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoGpjmeWs+QMUQ2r
        Vz5a+Vemv2x1T5+lJTCnQl77qsGNGy5unyvOmAQeuxfM4zdL9rQbT43QW5+FQieOSSyYoX91
        Sa5BiUjTn/Mi2aI7ioSl93OIe53NsMw8dCzj5PmQk+0FbtZWn1llpxtLcMxOfvFgd2vMWvaE
        Ii82wU+PhO/6TokTUiwRWvH1ibTJo62F15f/DVRQ+abC5uovHOF8LUshb+GxYoWkl8JlJx58
        rzn1fHJ33/1DR00efdnJtOXhOlWTM3pTjG+KBxisP/pcfvEvo5f2TDrVohM2XlPkPJCrM9/z
        8KrIE7svXd7yUfvN7pr6YP3S7ybbn55M1b3/XMw3XTtmvdqBJaf93i0zfD1JiaU4I9FQi7mo
        OBEA96rQSwAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVy+t/xu7o/pQxTDXa0SljsOZZl8Xf2dnaL
        E9ebWCw+XGtitbhxYT+zxZotjUwWk/tmMVk8OdDOaHHxzGtGi4VtS1gs/uzawWRxedccNouH
        D26wWqycv5zR4vKJS4wW658dZrbYsGwto8WVlnZWByGP1kt/2TyWdP5i8tg56y67x4JNpR6b
        VnWyebzYPJPRY3HfZFaP7+172Dx62jYxeXzeJBfAFaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0bs0taCXs2LzdY4GxofsXYycHBICJhLLbt0F
        srk4hASWMkpsn9DDDJGQkdj45SorhC0s8edaFxtE0UdGiQttN6GcM4wSJydPh3JWMkq0Hr7P
        AtLCJqAvcW3NNbBRIgLKEg0HXoEVMQssYZNYd/IwWJGwgKPE1jtvWSGKnCRO//sCZRtJNO7/
        AFbDIqAqcXfbfzCbV0BDom1pCzPEtm5GiRP9K9hAEpwCFhIfOzYzgtiMArISj1b+AvuOWUBc
        4taT+UwQTwhILNlzHuo5UYmXj/9BPacjcfb6E0YI20Bi69J9LBC2ssTuz3NYIOboSdyYOoUN
        wtaWWLbwNTPEQYISJ2c+YZnAKD0LybpZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8
        dL3k/NxNjMBkt+3Yz807GOe9+qh3iJGJg/EQowQHs5IIr6qHQaoQb0piZVVqUX58UWlOavEh
        RlNgIE1klhJNzgem27ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6p
        BibZ9T/k399jPdET72+tftg+XrBce0co44yDBs9+5aWxiry6XeEceia4Xbj8xM9r1zMOzV0S
        Zd4jpSJ312R7Z9bLC2qPriTNLv9vZHRIznhJ9+aS3odPJ8aVZk/YtvB7ysfWN801USJSl/gc
        bLW2zvutrn/pxM172uarym53p7572dlt+nSC83bmogLXnZubL39S+7CkQzbQ0lTY6ZU9W9Ny
        ASFuNv/bNYxvl70WOucd+3p6yrlJJ6X2zgt7qPox4faKt1ErH75LnfrlqXeAnOyUk6vXVkw+
        r5QjJ5qWYmzRmjsp84LTrU3Xrit9P87rn7TAaO/Rj0E/tdr/sviVWjr8P1zP0vX9kqhi+YaY
        nYeUWIozEg21mIuKEwEcOIRS/wMAAA==
X-CMS-MailID: 20231019120305eucas1p13232bbcd5c6357f4d892ae1527e43447
X-Msg-Generator: CA
X-RootMTR: 20231018160207eucas1p1db839e2eb9a2ad39013c08c0e6f4624e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231018160207eucas1p1db839e2eb9a2ad39013c08c0e6f4624e
References: <CGME20231018160207eucas1p1db839e2eb9a2ad39013c08c0e6f4624e@eucas1p1.samsung.com>
        <20231018160145.1017340-1-ojeda@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <ojeda@kernel.org> writes:

> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`, thus update the old reference.
>
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> ---
>  Documentation/rust/general-information.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/rust/general-information.rst b/Documentation/r=
ust/general-information.rst
> index 49029ee82e55..081397827a7e 100644
> --- a/Documentation/rust/general-information.rst
> +++ b/Documentation/rust/general-information.rst
> @@ -29,7 +29,7 @@ target with the same invocation used for compilation, e=
.g.::
> =20
>  To read the docs locally in your web browser, run e.g.::
> =20
> -	xdg-open rust/doc/kernel/index.html
> +	xdg-open Documentation/output/rust/rustdoc/kernel/index.html
> =20
>  To learn about how to write the documentation, please see coding-guideli=
nes.rst.
> =20
>
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
