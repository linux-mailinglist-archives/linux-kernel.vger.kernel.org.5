Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83FD7F5D72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjKWLLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjKWLLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:11:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A11BD;
        Thu, 23 Nov 2023 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700737862; x=1701342662; i=j.neuschaefer@gmx.net;
        bh=LkE5Nuq5cpUfZVO4p3a9aPdP5nVFWe7nwzvBcr5GDNk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
         In-Reply-To;
        b=S7iVe7/0DFJ2Glol27Dhh4tQ2/MSVm6hQfrQTYHOjexz+b3exqTH6gjYP/ugO0dJ
         ywmNfO1UhMb720kxrgKEDi4jGPUGAHuManuT3bEKyfHmBWeFlQVGHaNeLDP5mBjx4
         md8PO1K0ouI3ETbJYh6QpvvLPPDKB/P0UmcmTwKl+wpGJtmcbm/CnMiBgIzDDg10P
         D+a+KXRbeDbEQKkjPmZqHFjfgXJiH4hpwyrgjc0aPj7T/oa9SrIH0X15+132g4w4l
         0TB4B9/IyFZck9/7XBEjAFQ0OwnZrirjoJJBNWFx3A9/ZAvdYycYiks+0KnKlcm6n
         0YCmGndubOBkrZkI4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1rY1Ne2r3T-00gsCP; Thu, 23
 Nov 2023 12:11:01 +0100
Date:   Thu, 23 Nov 2023 12:10:57 +0100
From:   =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v1 00/17] pinctrl: Convert struct group_desc to use
 struct pingroup
Message-ID: <ZV8zQZyT4Kwom-m_@probook>
References: <20231122164040.2262742-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ITcYWtdfuDR2w/Y2"
Content-Disposition: inline
In-Reply-To: <20231122164040.2262742-1-andriy.shevchenko@linux.intel.com>
X-Provags-ID: V03:K1:wGI5Xyg60PX5Zi8dLHVTABR+Ax9JUsCqbiZjKL4ncgCtAcMMEAg
 dvO2Gv8Fy9M1TFaBXJaUQ52G9VUbCo0zhirW5WpIJmiSbL4Ad71TGzG5CInLYjx4k0znTxp
 MsYKpvrDvhRcT8VzpTAal6yl9EyYSd4HX/pNnbueeTP18AtDFXhKZ/baUvLS1o0FqHAC39e
 kaH9t9h50tBeo/979hVUw==
UI-OutboundReport: notjunk:1;M01:P0:mCrqrZi3U7U=;hjgkNsvydEYHgYUAxEqXVR1jW+v
 WAXa6jsttiV3Ln4DZ0S5+IfJl56rm95DOKlTbmcQr9WKDtczoY7w0WO7tCbq2TdsLZY4M/XNV
 gjlNSBVDMGmX6Dx+i1B4+IqZD7nYXCg8bpeUVskTtGD2ehd+tuYqiLrKaUZYt5YX5Bi6SxaZk
 SiafR5fV2qFEZqSfzgTb3+oyzR8LUbyJT3Ch8FXlvqXpYkz1y4rpe9td7RUV0RTzb303uZ84G
 dHbPwbngHJ4KbtY3l92y2SoCUiA2cDtF1if6HCE9uEysOZnYbxtOBQ8jhcc9HERdxHZk10q+o
 0IcYykIaku/u4b3Y2qHwPM/lYiaeuJGZ3FjBMt/89ZPPId97BUvM34EE6lkv6iatlizmdH6k1
 9Iz2dRT9uzWLof1mSy5aZwc6Q0Nhtn1sjOHwJevNOgn+uZdhoe58sxHP3tO2eWNs9ntxLuftr
 dxttOpDHjf699kxi7zl5jdx3jOINoildv+AVS25xKHTs3VQBkXk8mikzFSRWrqccciuqI8+bc
 pcD5A8NygGPERdmPNO5o56xYOLncor6g9sVhjh6s9Tj8vkqN94iLpNjo25E4CUH/5kHIOQBD1
 rLIvJ8xE/MPsbZH5F8VJmuNMyMv159TRsi+r9tp7MBinkypKzTlxsh6bj+DuYsf0dK6FzGKvA
 J3lvXIqSfDD9+1BRjI5XZBww/49z0+lFBMkd+5NTSlbugIVD5/qS9adHgeiZPmIABBK0RYTeM
 Oz74R7Jyp+sKVRS0zp7ME8ExUBQJxin4+XkDnqd3mC4MmD5c7AiV6QKuKHcY48LWKfkT0YDvv
 pludqeafs1x5RDFyz3R7XvuaGFjXVyq64BT0Fe0GeeCnq3HuianeceIzs+dH6lSkmV58QdfiH
 1GPyNtEGK1v7vZz6hJoMkbkR36G+EnJNBQWGEWq1ExKq+NCHsm89f9ytrRtXmkg43No+v6wVP
 sgRCrNM1X0IPjxzWfH5ew/bkMSM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ITcYWtdfuDR2w/Y2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 06:35:32PM +0200, Andy Shevchenko wrote:
> The struct group_desc has a lot of duplication with struct pingroup.=20
> Deduplicate that by embeddind the latter in the former and convert
> users.

It is strange to me that struct pingroup was introduced without any
reference to the pre-existing struct group_desc, but it's good to see
them unified at last.

Even better might be to move the definitions next to each other in the
same file, so that anyone who finds one, also finds the other.


Thanks,
Jonathan

>=20
> Linus, assuming everything is fine, I can push this to my tree.
> Or you can apply it (assumming all CIs and people are happy with
> the series).
>=20
> NB. This series contains previously sent patches for Qualcomm and
> Nuovoton. Here the updated version for Qualcomm that splits previous
> patch to two and fixes compilation warnings.
>=20
> NB. The function_desc is in plan to follow the similar deduplication.

--ITcYWtdfuDR2w/Y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmVfMyAACgkQCDBEmo7z
X9tfixAAghfTTH5Cq8CFefsef3u1AwmB5dL8brGS/xkDMXHN/RwR0sn/Zr/kxANZ
Ko9qr9vnCVoSmNi8MwdIRBGOugPq+ZnD40EXBsBtW0BzwkqH9U3tRMhbpucS7F+7
k+BDoiMeVa7vBNvRQK6XltOa9KRlbppR6wmesPZkzsTJyk/iLCCNTcNBekW8KbQp
HNCfDoQS0m4cpYW66VdUP7hgBleB/Fjn6ttt0udhrEuFFL5hlKLn87dEo43224nm
o/DNGFVXXt9Mn+FxxWhhAx01nvc3TaGlCuLqbPXb8v/cyffRFY9SmRa1aJY21zJN
vr/a+eW7RB5Pi3MAKu8hYEv6nG7Hu/GCN9/hRGpfCv6hat+qyQU0TGRuAmJTKLre
PxlacpHbRhsGZByRg/sT1cfYA17+EMDuWHDIO7Yj06TNSJdZKO4ucPwdC4Q6zjJc
pf+gQDIGOU+A/rLwh0HD4ZH30vavQ5uEj0xJhmsUmL+rb+EY78Xj90sGSXvrpCNE
J/A/1gRjF670OFsRq8+4eMxZ3e5DUx/oNobi5IbAHNnfHh88kjlcYJ1TSBPkvIfR
czTkc3e6E+n1whHAD9XzIdI+QuftgWXoHr2FFozxoH36a01YAM9t1WJX7BvLCS/9
YL9i3b/NVhvojwn71TmOgomDm0aKznw/Q2QtJ9PYINrXbh1pyCU=
=qPNB
-----END PGP SIGNATURE-----

--ITcYWtdfuDR2w/Y2--
