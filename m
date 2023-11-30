Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE07FEEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbjK3MKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbjK3MKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:10:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9ED46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:10:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA446C433C7;
        Thu, 30 Nov 2023 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701346209;
        bh=p1J/0ikNTrqptbAR2XxBCgc8ltrQEzzWP5Mk8ngM4uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAlKBklLAqdkH4XfzrpRSQIrLiABlL9tt/MeVbnIb25N5Kh5GkeyTVvqRngS7VW83
         56sbh5NWaVD3Wq2AtWJ6IwMRMQ2U2M2Ld2DdJWSuz0bRRHzblQij9GC2e8ZuBDqMxC
         cL2lXI0Klb5jX/fRdTBY0ojRoJcgf2NZf2BupwkaZyOMkscNW+pgjDisw+8YB77/+z
         q1/DHpUc0U7rBkvwxeuh5W9OVEesDKkQmkiMlD1Ay8jA0K2e9UpQ+86Nk0ZMfuoPd9
         tYWm9nL0fjtUfYaiUJuEc9GG8VmkjCXSiDvrX5epaVbCGZf6JZZsSgwtOc9p94rGQL
         nB0x76x2IGz+g==
Date:   Thu, 30 Nov 2023 12:10:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Message-ID: <20231130-laborious-dwarf-6913457466ad@spud>
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAK9=C2WAv5jJBt56xBea268DeyUA+YvbU7i+ahVjueafCi-r6A@mail.gmail.com>
 <20231130-decibel-passenger-6e932b1ce554@spud>
 <CAK9=C2Vsx8ddpYiqUhvqnJpdb-FKeNhLz3PsVpSeEz4TeQHiEg@mail.gmail.com>
 <20231130-shower-award-3cd5f1bba5db@spud>
 <CAK9=C2WgN=3BjxS+nF2ibFQoquNwXfxr_UQv8Kbf1+e4Teyfcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/EQWHXVT+7tBrA/1"
Content-Disposition: inline
In-Reply-To: <CAK9=C2WgN=3BjxS+nF2ibFQoquNwXfxr_UQv8Kbf1+e4Teyfcw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/EQWHXVT+7tBrA/1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 05:18:15PM +0530, Anup Patel wrote:
> On Thu, Nov 30, 2023 at 5:15=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:

> > > and add separate "riscv" prefixed DT binding for RISC-V mtimer.
> >
> > Do you know of any users for a "riscv,mtimer" binding that are not
> > covered by existing bindings for the clint?
>=20
> Ventana Veyron-v1 implements a mtimer per-cluster (or chiplet)
> which is compatible to "riscv,mtimer" (i.e. we have both mtime
> and mtimecmp MMIO registers).

Okay, thanks. I guess iff veyron-v1 DT support shows up (or other
similar devices) we can go ahead with a "riscv,mtimer" binding then.
I had thought that you guys were going to be using ACPI though, so
I guess the "other similar devices" applies.



--/EQWHXVT+7tBrA/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWh7mwAKCRB4tDGHoIJi
0mnsAPwOJxP1SKjjaIbQZInh5XnG5Ta3y8YxHd/Psl7fzAGd+QEAruMpJX1VXjzE
vEq7ApAaXOnfVF9Bhq+Bw7f8pmKZngA=
=FDEk
-----END PGP SIGNATURE-----

--/EQWHXVT+7tBrA/1--
