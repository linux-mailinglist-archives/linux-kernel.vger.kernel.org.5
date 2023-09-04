Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFB791261
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbjIDHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjIDHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:40:13 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E6DF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:40:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230904074004euoutp020c4e59488bbf388e40b08924756a945e~BoiKuVtxP1288712887euoutp02O
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:40:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230904074004euoutp020c4e59488bbf388e40b08924756a945e~BoiKuVtxP1288712887euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693813204;
        bh=uhAR/9DyW/KVOWM6KOdsFdL7C/YBFtqZQZGJdYxut1M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=O0G/GjoSGJiWE8QKDk3qnPG7ttj/FrzshuglHGlQqqTe6HMb5Rt/w/8qNCQ8TS2ML
         p45BW2Hc6HqtpbRDzMybN69uBVGcI31jOMA9b5ukktknhKA/5UVf6R5tSA/UaqRZ7P
         X/NHuZZ8wiJypfASHbX5cVXobwUJh4bCUmQ4EyVw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230904074004eucas1p1278d9793d3bdd0c664b346d9f8316937~BoiKSak0G1223212232eucas1p1P;
        Mon,  4 Sep 2023 07:40:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.A0.37758.4D985F46; Mon,  4
        Sep 2023 08:40:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230904074003eucas1p1c8b2d6c5cbe5e30d0346214ec83d37d6~BoiJz8f6W1890118901eucas1p1j;
        Mon,  4 Sep 2023 07:40:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230904074003eusmtrp226eed6eaed18e51aac6cfc073fa57798~BoiJzTIpI2851328513eusmtrp2G;
        Mon,  4 Sep 2023 07:40:03 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-1a-64f589d4ab3e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.ED.10549.3D985F46; Mon,  4
        Sep 2023 08:40:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230904074003eusmtip24530cc82436955aeae5e20878ff85321~BoiJkm55I1969619696eusmtip2d;
        Mon,  4 Sep 2023 07:40:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Mon, 4 Sep 2023 08:40:02 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 4 Sep
        2023 08:40:02 +0100
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
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
Thread-Topic: [PATCH 1/2] MAINTAINERS: update Rust webpage
Thread-Index: AQHZ22Orv0V2FdXDn0q24BJYl7b34rAKPgaA
Date:   Mon, 4 Sep 2023 07:40:01 +0000
Message-ID: <87ttsatmi6.fsf@samsung.com>
In-Reply-To: <20230830165949.127475-1-ojeda@kernel.org>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7pXOr+mGKy5zmHxd/Z2dosT15tY
        LD5ca2K1uHFhP7PFmi2NTBYXz7xmtLi8aw6bxcr5y4GsE5cYLdY/O8xssWHZWkYHbo8lnb+Y
        PHbOusvusWBTqcemVZ1sHi82z2T0+N6+h82jp20Tk8fnTXIBHFFcNimpOZllqUX6dglcGZcW
        zmcseCBUsXTXf7YGxg0CXYycHBICJhJ9zzczdzFycQgJrGCUmPD3KJTzhVHiautOFgjnM6PE
        gVnbmWFaNs0/zQiRWM4o8fxABztc1ZGuu6wQzmlGiY7/D1jhJnduOcMC0s8moC9xbc01sFki
        AsoSDQdesYEUMQs8YJZ40bwJKMHBISxgKdF/2gCixkri79+nrCBhEQEjiRcn/UHCLAIqEvv2
        XGMFsXkFNCS+TP3FBGJzCphLnFu4nx3EZhSQlXi08heYzSwgLnHryXwmiBcEJRbN3gP1jpjE
        v10P2SBsHYmz158wQtgGEluX7mOBsBUlrvXcZISYoydxY+oUNghbW2LZwtfMEDcISpyc+QQc
        XhIC3zgl1u6fDLXMReLx4xNQg4QlXh3fwg5hy0j83zmfaQKj9iwk981CsmMWkh2zkOxYwMiy
        ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzChnf53/OsOxhWvPuodYmTiYDzEKMHBrCTC
        K6f9KUWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDk2L6
        ordiyfm6Ttpf9EOm7cw7bODHNmHqd8aw2n//j0+XYf5jOVVPle+6Zajedp7NL099KK9yzd+p
        nbHO4L6XQdDm1E+HtmikJxVOV1ZPufrzyioFtvlNG4OffeQO27krLWxLiKLaR0vnL/+X3r7o
        IfF+hoCsn1HXtcXi1RXxxgF86c/cZscYaV94Oj1pZZBrkGKAuF6JtufUm7d+HdUR/3d7xasp
        3WY6p21Dcw6mb1sRpNO4amnRk/exO7l37vyp+3C30uW28jdJWdzK4bwvMjp2z3l4943Zde2V
        +QxLS9VUmeYVhie9fH7nSWBvQdL+cynbE43V1iiomTVnqC35W3jr67v/wmqaCSaPJ5neUGIp
        zkg01GIuKk4EAEpEvCzXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsVy+t/xe7qXO7+mGJzar2zxd/Z2dosT15tY
        LD5ca2K1uHFhP7PFmi2NTBYXz7xmtLi8aw6bxcr5y4GsE5cYLdY/O8xssWHZWkYHbo8lnb+Y
        PHbOusvusWBTqcemVZ1sHi82z2T0+N6+h82jp20Tk8fnTXIBHFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GZcWzmcseCBUsXTXf7YGxg0CXYyc
        HBICJhKb5p9m7GLk4hASWMoo8e/GcXaIhIzExi9XWSFsYYk/17rYIIo+Mkrsbf/EBOGcZpTY
        PGUSK4SzglFix4dnbCAtbAL6EtfWXGMGsUUElCUaDrwCa2cWeMAssepNB9AODg5hAUuJ/tMG
        EDVWEn//PmUFCYsIGEm8OOkPEmYRUJHYt+ca2BW8AhoSX6b+glrcxSjx69QvsPmcAuYS5xbu
        BzubUUBW4tHKX2A2s4C4xK0n85kgXhCQWLLnPDOELSrx8vE/qNd0JM5ef8IIYRtIbF26jwXC
        VpS41nOTEWKOnsSNqVPYIGxtiWULXzNDHCQocXLmE5YJjNKzkKybhaRlFpKWWUhaFjCyrGIU
        SS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMStuO/dy8g3Heq496hxiZOBgPMUpwMCuJ8Mppf0oR
        4k1JrKxKLcqPLyrNSS0+xGgKDKSJzFKiyfnAtJhXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQ
        nliSmp2aWpBaBNPHxMEp1cAktUF2w4sFibaTTq5J2Wb2c66W+gW7NuGjpzT3yV5ocvjT92JX
        64plj6xeqFqtuvPwj2HCvoCYCVPkFB/Wn3DkntL3aoPTfY/nBxbbZ73i2Wiksuvtx/29Klw5
        OlOFHq+TmLV4rbBjtVaLpOZvvRmicj08RclehYzW/z4efPdM40Xf8gC1acwGWhKREx1VVUXk
        tup/25Y6L5WvRzwo3+2M9YnQ48e5Z7c/tzr293RX+hSW/hPRwZ3PalzetM5RcKh3/Lupp7tA
        r/dGX6ttr/27nEfJRf4l/Ab/PZIDvA5ULOLldC5x886oFmDPr0ha8jX7w82X6tEuhc7nyq/f
        kxU9vfO4pvQ9lbO8Np3NLEosxRmJhlrMRcWJAB9XIBzTAwAA
X-CMS-MailID: 20230904074003eucas1p1c8b2d6c5cbe5e30d0346214ec83d37d6
X-Msg-Generator: CA
X-RootMTR: 20230830170041eucas1p139eda9d21701ab726a9b36751b819ada
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230830170041eucas1p139eda9d21701ab726a9b36751b819ada
References: <CGME20230830170041eucas1p139eda9d21701ab726a9b36751b819ada@eucas1p1.samsung.com>
        <20230830165949.127475-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <ojeda@kernel.org> writes:

> A few months ago we started a webpage for the Rust subsystem and
> the overall Rust for Linux project [1].
>
> The current `W:` field of the Rust entry points to the GitHub
> repository, since originally we kept information in a `README.md`
> file that got rendered by GitHub when visiting that URL.
>
> That information was moved into the webpage and got expanded.
> The webpage is also nowadays the entry point to the project,
> and we pointed the "Website" GitHub metadata field to it.
>
> Thus update the `W:` field to point to the actual webpage.
>
> Link: https://protect2.fireeye.com/v1/url?k=3Df6de0e95-97551ba3-f6df85da-=
74fe485fffe0-40da65c741bc6c5c&q=3D1&e=3Db1890d46-d9fd-4c52-9067-813223d7997=
8&u=3Dhttps%3A%2F%2Frust-for-linux.com%2F [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12601a47c839..7c8088e9a11b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18558,7 +18558,7 @@ R:	Andreas Hindborg <a.hindborg@samsung.com>
>  R:	Alice Ryhl <aliceryhl@google.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
> -W:	https://protect2.fireeye.com/v1/url?k=3D562fa4e0-37a4b1d6-562e2faf-74=
fe485fffe0-41ef9448fbcb2236&q=3D1&e=3Db1890d46-d9fd-4c52-9067-813223d79978&=
u=3Dhttps%3A%2F%2Fgithub.com%2FRust-for-Linux%2Flinux
> +W:	https://protect2.fireeye.com/v1/url?k=3D9d6f1261-fce40757-9d6e992e-74=
fe485fffe0-96ce3590ad5e7466&q=3D1&e=3Db1890d46-d9fd-4c52-9067-813223d79978&=
u=3Dhttps%3A%2F%2Frust-for-linux.com%2F
>  B:	https://protect2.fireeye.com/v1/url?k=3Dbce0bede-dd6babe8-bce13591-74=
fe485fffe0-1eb20aae852614aa&q=3D1&e=3Db1890d46-d9fd-4c52-9067-813223d79978&=
u=3Dhttps%3A%2F%2Fgithub.com%2FRust-for-Linux%2Flinux%2Fissues
>  C:	zulip://rust-for-linux.zulipchat.com
>  T: git
> https://protect2.fireeye.com/v1/url?k=3Ddb2bb7f4-baa0a2c2-db2a3cbb-74fe48=
5fffe0-2d91ea432710b07e&q=3D1&e=3Db1890d46-d9fd-4c52-9067-813223d79978&u=3D=
https%3A%2F%2Fgithub.com%2FRust-for-Linux%2Flinux.git
> rust-next
>
> base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51

I was about to complain about the strange link you put. It took me a few
seconds to realize what was going on.

Perhaps we should start signing the patches?

Best regards,
Andreas=
