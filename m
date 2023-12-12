Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1180ED5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjLLNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjLLNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:23:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF7B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702387414; x=1733923414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ObudWEFWUPe/g9pCDQ+nl/6o1bGXYJC6k72mCY/W68=;
  b=Nngf4Q1eFRPWhke5G68Fxv56Kc6e2cTzEPXRF2yl4C/krIuGADmoEQ3S
   wJeNA1H+j27SO0RJ3PQN9QEtvX5uHBf6UVmIV/Ot3S+8RcM+209+7cUdF
   2YvZr7p0JNGJj696PbCa304S3BsO48U43CScW2ijqjoDe0rRBXsGbXtsg
   Zwvxk/U0VgBfVq8Vhev6iWhBTvgQRYeelGU0I19gisFHTG6oQJ0aSrqio
   CTNSAoPDYS+qUe7fGLZej1LFbMSmK57yRFJjXK/uUUAzR9Rslfi8q4G1p
   1ayr02o1d+yCPYXA0xiTiQWLep6+lm7j6eJpsTrs/sXCqvmKGo5pFK/UG
   Q==;
X-CSE-ConnectionGUID: E8h4WABqSWKzeAU7QsIu6A==
X-CSE-MsgGUID: OwNyOmFoQ6WtJyxN3Eqtcg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="asc'?scan'208";a="14074704"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 06:23:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 06:23:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Dec 2023 06:23:17 -0700
Date:   Tue, 12 Dec 2023 13:22:46 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Frederik Haxel <haxel@fzi.de>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guo Ren <guoren@kernel.org>, Nam Cao <namcaov@gmail.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>, Baoquan He <bhe@redhat.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fix XIP boot and make XIP testable in QEMU
Message-ID: <20231212-customary-hardcover-e19462bf8e75@wendy>
References: <20231212130116.848530-1-haxel@fzi.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xSuSDjmgmyqSuJoL"
Content-Disposition: inline
In-Reply-To: <20231212130116.848530-1-haxel@fzi.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xSuSDjmgmyqSuJoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 02:01:11PM +0100, Frederik Haxel wrote:
> XIP boot seems to be broken for some time now. A likely reason why no one
> seems to have noticed this is that XIP is more difficult to test, as it is
> currently not easily testable with QEMU.
>=20
> These patches fix the XIP boot and allow an XIP build without BUILTIN_DTB,
> which in turn makes it easier to test an image with the QEMU virt machine.


Are you actually using XIP in something other than QEMU? The fact that
some of the blamed fixes are over 18 months old suggests that you are
not actively using XIP builds of the mainline kernel.
There is a desire to remove XIP support (among other things), so if you
do actually have a use case for it, speak up.

--xSuSDjmgmyqSuJoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXhepgAKCRB4tDGHoIJi
0jcqAQCByPwOCiYOjlVouNbs/zKoh371UnfHZ1BeZJiI/QsL0QD/SOI4PuK+QXAU
+SeC5o/vGm6VXMQZICUQ9Qdax13aTA4=
=UatY
-----END PGP SIGNATURE-----

--xSuSDjmgmyqSuJoL--
