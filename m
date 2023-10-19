Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B767CF833
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345592AbjJSMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbjJSMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:04:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1F1FCE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:03:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231019120353euoutp02f57253d499d52c832d92a8aa0465663a~PgKXBVaXf3187231872euoutp02F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:03:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231019120353euoutp02f57253d499d52c832d92a8aa0465663a~PgKXBVaXf3187231872euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697717033;
        bh=Pl2pglJ8vteCsuKaY+7utYmmg4JPu8Nl70f+8wtaZdQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gTYYynkpn9mYsvXRB4aKjQB7P+RJwpcZWIuqgOGon12qu+lhkblxA7FwI6GQi8/YY
         iSkXk3n0IMwMd/uqAmOUNiw9ey9/ljzmJwudFNi3n2oqOST4wLiCeJe6oTPN0HuXeO
         q0XbeyUOzUCLzsm0gHMreSmFt/bNZFETHlbAraDA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231019120353eucas1p2669f0cd91acbdf3258bb0db640d6fb92~PgKWqwaEx0934509345eucas1p23;
        Thu, 19 Oct 2023 12:03:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.81.11320.92B11356; Thu, 19
        Oct 2023 13:03:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231019120353eucas1p1b523f24f9e6b7b2266d7e3fcb7562b43~PgKWL-HNI0542005420eucas1p1m;
        Thu, 19 Oct 2023 12:03:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019120352eusmtrp1cbd462659d7b33ce018c20526cb28c3f~PgKWFWQe63276532765eusmtrp1q;
        Thu, 19 Oct 2023 12:03:52 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-99-65311b293796
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.E0.10549.82B11356; Thu, 19
        Oct 2023 13:03:52 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231019120352eusmtip2a76008e7ee2d0830c48a6ffb97cac334~PgKV2iJxw0457004570eusmtip2w;
        Thu, 19 Oct 2023 12:03:52 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 19 Oct 2023 13:03:52 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 19 Oct
        2023 13:03:52 +0100
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 2/2] kbuild: remove old Rust docs output path
Thread-Topic: [PATCH 2/2] kbuild: remove old Rust docs output path
Thread-Index: AQHaAdysR6IIS0NbkUKo+EtvDXfUhLBQ9AmA
Date:   Thu, 19 Oct 2023 12:03:51 +0000
Message-ID: <87sf66iztq.fsf@samsung.com>
In-Reply-To: <20231018160145.1017340-2-ojeda@kernel.org>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTHfW5vb29Lai61k2dFIYGQoGzlrZtPFsbUSbxmWaJbdNm+uDpu
        kK1QbAV1MZMC0vAiY2NMbNlsUSwlMFwtE8qLDJOCAzKhrrCaOiBtU2HxBdStaOlsL0v49jvn
        /M/5n+fkITkiDSEh8wuPM6pCuSKBEOC/2AO/v74tNp1JC9q2oH775yiov85Do9NlOHrkLOOi
        mds3OKjDqsFQQ50OQ54hLUCT44sAGSsv4+iFrQdDDlszgeZmZ7hIa/YS6FF9CEO+gVEuMl80
        AeQYnQKoy3eTg65e6QToToWWu/MV+uxUkKBtw9cI+nLVCkb36tw82mAppi3tVQTtv3YB0Jfq
        Grj0P9p+gq6ttGD0siVuf9QngqxcRpFfwqhSsz8VHK0q/ZNbpOOfHLQaQSno5VUDPgkpGfT/
        XcOtBgJSRLUBOLvUgbHBEwADMyZOWCWilgFsevZeNSAjHW0PMlmNCcBv6kI4G7zU/PXtBMEG
        4wB2V5jW5poBdIw5IqMIKhU6O5wRFlOJsHRoIdLBoYw8+MPEHAgXNlG74G/LQR4r2g0nu6e5
        YW8xlQFv1UeF0ziVBNt8nUSYhVQydK0+x8LMpxC8+sAVaQXUVjhvXokwh4qBLs9FjH10NGzR
        93NY3gxXbXMEy6/BiWkPYDkNdrcO4iwnwr7lZpydI4Uzjd8RLKfAK8ZFDrtDNLx1wbOm/0MA
        55eS2XPtgeWuM2x6E1wYsa7dfQsca6jF60GKbt12unUOunUOunUOBoC3gximWF2Qx6gzCpkT
        UrW8QF1cmCf9TFlgAS9/6djqyJMeYFp4LB0GGAmGASQ5CWJhEp3GiIS58lNfMirlYVWxglEP
        g1gST4gRJuXGMyIqT36c+YJhihjV/1WM5EtKsa2XpmqeKjwuc46at3JP1hQ4Fnpr53xRSby+
        Y+K2uevw18mDS973CfuAf7V3495zA1kbmivifM1+03PaMew8gPWLsxPTgzllkta6SuU+b6bY
        674eLQzpZUmGPe80Lu24++73eo2pNeUs7+033U994/6bksBiRpSsR5M/9CJE7Wg8T6YeqY2m
        WyYT263P5oDnxwPMR6eMRq01PrvCe/qO/6dfq6La++4pNp5sGXn1oLA8074r66t/a+pveMZP
        l3947IQwAN2zmdtk5MO+3DhFr1t65FyyafeG+/s3H7KPGrY/hvcl84f2LvzcWUJ/LGpSnlF2
        xX7gPM/vvGvI0bzx8GACrj4qT9/OUanl/wGmOjkIFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH855zenqQNTlgCe/AyyzDMdHSlsLeOmFs++DBDwZjsmwgKZ2c
        AAot66FOd8mqGyCwkU7nEqqUdnKxnQwoolw6ZJUIBRcuOsqYkl06xmABSTFmTNhajkv49nsu
        /+eWh8LDjWQUVaAtYfVaTaGE3EQMrw1M74mLlrOyzkU5ct0+hlYv3hCiQe8ZAj2cOCNAk6M3
        cXT12mkMna82Y8jXVw7Q2J15gGxl9QR60t2Jobvdl0j0y8+TAlRu/51ED03/Ymjm20EBstc1
        AXR3cByglplbOGptbAbo3iflgrQIpnR8lWS63e0kU1+xgjFd5gdCxuo0ME5HBcnMttcA5nL1
        eQHzuNxFMp+WOTHG79yWEZop3afXGUrY5/J1XEmKJEuOFFK5CkkVSpVUnvhS9l5FkiQhdV8u
        W1hwgtUnpOZI8yuMPwqKzSEne6/ZgBF0CSsBRUFaCa8sJFaCTVQ43QCgyeQjKkFIwL8Fti3/
        IOB5M3wyUUnySUsA3v/YI+SNOwDOjVhx3rADeMvTti4n6QQ4cXUCD7KYjoHGvrl1OU7bhNA8
        3CIMBjbTr8Ih/6qQT3oNjnV4BcGZxLQCekyhQTdBx8IrM81kkEV0HJxa+wfjm3UB2OO8iQUD
        ITSCrQtT63UAvRX+al9ZZ5yOhFO+OozfgYb1rhGc5wj4529rT3fbDb/3+gDPMtjR0Pt0/xjY
        479E8HWkcPLCFyTP8bDRNo/zA4VBT42PMIFo84Z25g0S8waJeYPECggHELMGriiviJNLOU0R
        Z9DmSY/qipwg8IrXb//d3gksc0tSN8Ao4AaQwiViUSwjY8NFuZpT77F6nVpvKGQ5N0gKHOlz
        PCriqC7wy9oStTxZliRXJqtkSarkREmkKL34rCacztOUsMdZtpjV/6/DqJAoI/bMMTGHD1xU
        niP+EN0vVWeIL/iz3ti/03G9EL719a7Tpob3QabhganU63XUDh20Hm/K2O05tTPXkjaiztac
        uLe/7lGMhODMzPRoc1ZdlS9tmaM+3IotgvltVnXtgcX5dOZd+ZJRYDly2ZHyna6AOjD0utoy
        Glf2QWjCCzYytlZzcMtaVWPZ3sX+N3ush3pnv+nHi+N3nK0+HHnyyz6Dq2qHVbKSs6fjUFO0
        c3lh+2eWmrTpoggiMTznp/GwzrS/slJB8lcuo03r8ttfrHiU0b90rq0zZRjkvvI8puBuHPlo
        MKz18Xa1aeAd7WwfE5Men61sdLtfVvWPpWQ+e/htY0tg+HyNfBeu5zT/AUxh2agTBAAA
X-CMS-MailID: 20231019120353eucas1p1b523f24f9e6b7b2266d7e3fcb7562b43
X-Msg-Generator: CA
X-RootMTR: 20231018160211eucas1p20859b897fc44428db3ead0809c6d299c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231018160211eucas1p20859b897fc44428db3ead0809c6d299c
References: <20231018160145.1017340-1-ojeda@kernel.org>
        <CGME20231018160211eucas1p20859b897fc44428db3ead0809c6d299c@eucas1p2.samsung.com>
        <20231018160145.1017340-2-ojeda@kernel.org>
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

> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`. The `make cleandocs` target
> takes care of cleaning it now since it is integrated with the rest
> of the documentation.
>
> Thus remove the old reference.
>
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

 ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 373649c7374e..040018111f32 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1474,7 +1474,7 @@ endif # CONFIG_MODULES
>  # Directories & files removed with 'make clean'
>  CLEAN_FILES +=3D vmlinux.symvers modules-only.symvers \
>  	       modules.builtin modules.builtin.modinfo modules.nsdeps \
> -	       compile_commands.json .thinlto-cache rust/test rust/doc \
> +	       compile_commands.json .thinlto-cache rust/test \
>  	       rust-project.json .vmlinux.objs .vmlinux.export.c
> =20
>  # Directories & files removed with 'make mrproper'
