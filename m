Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446F75C354
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGUJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjGUJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4030E7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140666191F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F9EC433C8;
        Fri, 21 Jul 2023 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689932646;
        bh=vg1iS6TqPnxcsCXPtgC9VmWtpHR/B3JeLo+VLSKPK+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0RxbaTdEsTplNhbhV08j63QtGMQ47JHzKg1tDYO7xQFdL9/I05jKzr/G48yQduOS
         g29jvId3iFQfWQdtLonrRE72g+T5nIvjjGdmE+vef0412/x9oX2sru9Y2Uji7wfMDu
         Vo2jtdxlpgtLtgKU13Y5Gz5yqsX8rgttZQE7h95dZCa9OUERka8xZHwOmhrRi4+3iu
         PMO00nDPB7AKMXpzWi0uTNSRqIeeNOQssbHUfNLa7qp/kZ81NEY05GUh+lwBMuA0GH
         lfwqUGX7Q37BQg4cfu9DNEIegKM80Im0fjUQryr3MBYV1AcBvV8S+qqHnyKfvtJprI
         7GEXkiQHTkJrg==
Date:   Fri, 21 Jul 2023 10:44:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Message-ID: <20230721-obedience-prenatal-77f3c02632be@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <20230719-confront-grass-6d0eb304b94f@spud>
 <CAH2o1u5pZQ6iKThFLgnn+_BBZ=j8fu91URYYxwWbfVt3OyerAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bb74xYmNkzitL0eS"
Content-Disposition: inline
In-Reply-To: <CAH2o1u5pZQ6iKThFLgnn+_BBZ=j8fu91URYYxwWbfVt3OyerAA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bb74xYmNkzitL0eS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 02:43:51PM -0700, Tomasz Jeznach wrote:
> On Wed, Jul 19, 2023 at 1:50=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:

> > Also, since I am not going to reply to any of these iommu driver patches
> > in a meaningful capacity, please run checkpatch.pl on your work. There
> > are well over 100 style etc complaints that it has highlighted. Sparse
> > has also gone a bit nuts, with many warnings along the lines of:
> > drivers/iommu/riscv/iommu.c:1568:29: warning: incorrect type in assignm=
ent (different base types)
> > drivers/iommu/riscv/iommu.c:1568:29:    expected unsigned long long [us=
ertype] iohgatp
> > drivers/iommu/riscv/iommu.c:1568:29:    got restricted __le64 [usertype]
> >
> > I can provide you the full list when the patchwork automation has run
> > through the series.
> >
>=20
> Thank you, a list of used lint checkers definitely would help.

checkpatch is mentioned in the patch submission documentation ;)

Anyway, here's the series on patchwork:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D767543
You can see there's quite a few failure for each patch, so you'll need
to resolve those.

Also, I noticed the 32-bit build is broken in some patches, so please
build this driver for 32-bit before sending a v2.

Thanks,
Conor.

--Bb74xYmNkzitL0eS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLpTYQAKCRB4tDGHoIJi
0gp3AP9Uu+N+UWJpTrOtyTMHJZALMqgzVXOLJnRbY6L5gf62VgEA/3W2q8TO3Y/X
leRuhecE+t9nh2XAuTKFTKQn/I0vgwQ=
=YnhF
-----END PGP SIGNATURE-----

--Bb74xYmNkzitL0eS--
