Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42EA7CF84E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjJSMHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjJSMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:06:21 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F172125
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231019120432euoutp020f2f2da0e8ddd3cadbaafe6d90daa3c8~PgK7GNKML3187131871euoutp02Z
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231019120432euoutp020f2f2da0e8ddd3cadbaafe6d90daa3c8~PgK7GNKML3187131871euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697717072;
        bh=UuT+43MuAJ7Xse3ZkxctwKmSJQDv0cIYRJ0g7MYPtEA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jsmBkI5iSobFkj/VRlsFyUuZqxgsw64j5SDaEd8wpU5u9+8cN8ZqlkHAimNdn3gSA
         TzL8rMltnfKkj2Q4tbI7LRZGLNfVa1Ds5SAS0XdOsXtOto2Z8zak8de4Gf+LF59RWs
         nvnRSlHLmDw5Fd/542Xq8UN1AP5/7aim8Vvmv6uA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231019120432eucas1p270299039be97a250c566e4dc96592c8f~PgK6saScF0294502945eucas1p2U;
        Thu, 19 Oct 2023 12:04:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AB.79.37758.05B11356; Thu, 19
        Oct 2023 13:04:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231019120431eucas1p2f7e355c1c628c4350188735acd9a0ed1~PgK6L2tt72673826738eucas1p2t;
        Thu, 19 Oct 2023 12:04:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019120431eusmtrp29e8e54a76ee4175eae53d81d0881dfbf~PgK6LIQ591929519295eusmtrp2C;
        Thu, 19 Oct 2023 12:04:31 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-6d-65311b50912e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 22.11.10549.F4B11356; Thu, 19
        Oct 2023 13:04:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231019120431eusmtip235d3a457cb6e89ca1d9b2c5258a2a618~PgK6BFGy10517305173eusmtip2n;
        Thu, 19 Oct 2023 12:04:31 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 19 Oct 2023 13:04:30 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 19 Oct
        2023 13:04:30 +0100
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
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: docs: fix logo replacement
Thread-Topic: [PATCH] rust: docs: fix logo replacement
Thread-Index: AQHaAdvAuvbjg/ia0k6JWzKMfPbkfbBQ9EoA
Date:   Thu, 19 Oct 2023 12:04:30 +0000
Message-ID: <87o7guizsn.fsf@samsung.com>
In-Reply-To: <20231018155527.1015059-1-ojeda@kernel.org>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7oB0oapBpeXsFv8nb2d3eLE9SYW
        iw/XmlgtblzYz2yxZksjk8XFM68ZLS7vmsNmsXL+ciDrxCVGi/XPDjNbLNj4iNFiw7K1jA48
        Hks6fzF57Jx1l91jwaZSj02rOtk8XmyeyejxvX0Pm0dP2yYmj8+b5AI4orhsUlJzMstSi/Tt
        Ergyrk3pYir4LVrxrVOlgfGTUBcjJ4eEgInEh+fTWEBsIYEVjBKrbotA2F8YJf71hUPYnxkl
        ZvaIdTFygNU/+iDbxcgFFF7OKDHl5wE2CAeoZsG11UwQzhlGic2NX9ghnJWMEr/nvwBbwSag
        L3FtzTVmEFtEQFmi4cArNhCbWWAyi8TLX2AnCQuYSsy53MMGUWMm8fLBVKh6I4k9Ez6zgtgs
        AqoST2ZNBKvhFdCQaDsymwnE5hSwkNg4eTOYzSggK/Fo5S92iPniEreezGeCeFlQYtHsPcwQ
        tpjEv10P2SBsHYmz158wQtgGEluX7mOBsJUldn+ewwIxR0/ixtQpUDdrSyxb+JoZ4gZBiZMz
        n7CAPCwh8I9TYsfeB1CDXCRuPOqAWiYs8er4FnYIW0bi/875TBMYtWchuW8Wkh2zkOyYhWTH
        AkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIEp7fS/4193MK549VHvECMTB+MhRgkO
        ZiURXlUPg1Qh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkG
        ps4s6cUecjdr7RpXRLotNdmlWhV3dEZu+J4dnBq/FBs2HdXKEcsIFBXPvrSp7wND4fcDk2cs
        mWTKVFk9dYuKwOYnh7s1L/+d+ZBbovPA2qVzwr5ERwWey1xbxDjNadH9mR+XBnPvvPD6R2ax
        Wt/fIy3ZPkbaXPEF0w3+bGeb9Du459hefoWp7366rJrZLFT/1czu9n7RnkU15+f2R00R3FTe
        Lc+5VedO8YXnGt6lCk4aojm2yaue3/n86dvyTXzXvthdnMTtM7n+3gV+4Vlxm1+wfz1T/sDP
        UvDpRXZ28+NH/kX7dqtzy+euzZirxr/v5zr3AwFSVnfZ3N/YaIpN3JsdfvxjpeCFea/ZWuL2
        SiqxFGckGmoxFxUnAgCdQHbM2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xe7r+0oapBv9Pq1n8nb2d3eLE9SYW
        iw/XmlgtblzYz2yxZksjk8XFM68ZLS7vmsNmsXL+ciDrxCVGi/XPDjNbLNj4iNFiw7K1jA48
        Hks6fzF57Jx1l91jwaZSj02rOtk8XmyeyejxvX0Pm0dP2yYmj8+b5AI4ovRsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyrk3pYir4LVrxrVOlgfGT
        UBcjB4eEgInEow+yXYxcHEICSxklHm7tYeli5ASKy0hs/HKVFcIWlvhzrYsNougjo8Tu3kWM
        EM4ZRonFmw5DZVYySvS/vwbWziagL3FtzTVmEFtEQFmi4cArsCJmgcksEpe/HAObKyxgKjHn
        cg8bRJGZxMsHU6EajCT2TPgMVsMioCrxZNZEsBpeAQ2JtiOzmSC2dTNKbL99GqyBU8BCYuPk
        zUwgNqOArMSjlb/YQWxmAXGJW0/mM0E8ISCxZM95ZghbVOLl439Qz+lInL3+hBHCNpDYunQf
        NACUJXZ/nsMCMUdP4sbUKWwQtrbEsoWvmSEOEpQ4OfMJywRG6VlI1s1C0jILScssJC0LGFlW
        MYqklhbnpucWG+oVJ+YWl+al6yXn525iBKanbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4VT0M
        UoV4UxIrq1KL8uOLSnNSiw8xmgIDaSKzlGhyPjBB5pXEG5oZmBqamFkamFqaGSuJ83oWdCQK
        CaQnlqRmp6YWpBbB9DFxcEo1MIn3Vp/r3My4x4nt9asPj+r4P/jtuP521qTdzTeXihr3c53W
        WZ+6j3WP/uOGbdt1F0iaJ2hLnZe55Pv4e/XZ5zs27dy5XrFg23mxvlka0yN2qPxO7TwTJLiu
        7SRP4pU7/Mvut5337lGcLVL4zP3S9IT2pjyjcPGVh4x2b6y49+ty4q/APu6/xxmv7f/kcNAm
        e1Lh59suX5SPf2510r/MqddfvuRKT+b7Ns5JchX1G08tXVNRmy5/ft5l5+bbFV9TLKfmRrWH
        Z9emfbrDnqvIt3+W891jMzO+P14ZZpxk4vFx/zLNKwVBf1l1cn/2r5hzc6Of1PwHE/+l3npz
        UDvGQXxK5hPdhxN0+C1qz+zq0BdSYinOSDTUYi4qTgQAksfPnNgDAAA=
X-CMS-MailID: 20231019120431eucas1p2f7e355c1c628c4350188735acd9a0ed1
X-Msg-Generator: CA
X-RootMTR: 20231018155602eucas1p14b9439c5249a921e1d5eda1e2e23eebf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231018155602eucas1p14b9439c5249a921e1d5eda1e2e23eebf
References: <CGME20231018155602eucas1p14b9439c5249a921e1d5eda1e2e23eebf@eucas1p1.samsung.com>
        <20231018155527.1015059-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <ojeda@kernel.org> writes:

> The static files placement by `rustdoc` changed in Rust 1.67.0 [1],
> but the custom code we have to replace the logo in the generated
> HTML files did not get updated.
>
> Thus update it to have the Linux logo again in the output.
>
> Hopefully `rustdoc` will eventually support a custom logo from
> a local file [2], so that we do not need to maintain this hack
> on our side.
>
> Link: https://protect2.fireeye.com/v1/url?k=3D3606269f-578d33a5-3607add0-=
74fe4860008a-47cdfdc2f1793629&q=3D1&e=3Dca2ce79b-669b-4a80-b032-30bab50cf45=
5&u=3Dhttps%3A%2F%2Fgithub.com%2Frust-lang%2Frust%2Fpull%2F101702 [1]
> Link: https://protect2.fireeye.com/v1/url?k=3Dfaa866e4-9b2373de-faa9edab-=
74fe4860008a-e32c39efb11c5865&q=3D1&e=3Dca2ce79b-669b-4a80-b032-30bab50cf45=
5&u=3Dhttps%3A%2F%2Fgithub.com%2Frust-lang%2Frfcs%2Fpull%2F3226 [2]
> Fixes: 3ed03f4da06e ("rust: upgrade to Rust 1.68.2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> ---
>  rust/Makefile | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 87958e864be0..08af1f869f0c 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -93,15 +93,14 @@ quiet_cmd_rustdoc =3D RUSTDOC $(if $(rustdoc_host),H,=
 ) $<
>  # and then retouch the generated files.
>  rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>      rustdoc-alloc rustdoc-kernel
> -	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)
> -	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)
> +	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/stati=
c.files/
> +	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/s=
tatic.files/
>  	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 se=
d -Ei \
> -		-e 's:rust-logo\.svg:logo.svg:g' \
> -		-e 's:rust-logo\.png:logo.svg:g' \
> -		-e 's:favicon\.svg:logo.svg:g' \
> -		-e 's:<link rel=3D"alternate icon" type=3D"image/png" href=3D"[./]*fav=
icon-(16x16|32x32)\.png">::g'
> -	$(Q)echo '.logo-container > img { object-fit: contain; }' \
> -		>> $(rustdoc_output)/rustdoc.css
> +		-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
> +		-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
> +		-e 's:<link rel=3D"alternate icon" type=3D"image/png" href=3D"[/.]+/st=
atic\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g'
> +	$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
> +		echo ".logo-container > img { object-fit: contain; }" >> $$f; done
> =20
>  rustdoc-macros: private rustdoc_host =3D yes
>  rustdoc-macros: private rustc_target_flags =3D --crate-type proc-macro \
