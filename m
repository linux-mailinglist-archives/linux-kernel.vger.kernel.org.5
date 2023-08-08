Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF017745CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHHSqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjHHSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171774AA8B;
        Tue,  8 Aug 2023 09:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7AF76254F;
        Tue,  8 Aug 2023 13:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A05FC433C7;
        Tue,  8 Aug 2023 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691500412;
        bh=CD0ufiG3nAoVG6VwJg+1gXVvFXW3WqH9W+OfEUubutU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xrd/rkrwZzOaPiJToz5IEiSANDWww27dyd63pY8Y3Xh3Y6r2ob4CEye9hp0bCkW3u
         jxcEA1dGIZsW3JuwDjxhNeFT/yT8j0XwECU3HuMP1sQxFzjh+2lEgm28zQA/0yXeC8
         +wkXDPOIUV2CJbvyz97qwyyOImcr5PiOLEdyZ3Ka0i7IVwTy92Ch3BlnB+t+hy8zME
         l2Cb94VOWnB/Dkw4Ejc5SBgLIPlNCgSdBn2L2CuDpcl2Tc7Go8mCaw9JgKcThkGZEb
         YG69lnEW+2OVCMZ2xYwA60ZmxkUVAtuXxVJn+9xqYKRt5SJa9mCISl7cZA0RiQ2ZKs
         rQ5lgd45MyLbA==
Date:   Tue, 8 Aug 2023 14:13:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Message-ID: <20230808-humility-rut-e1e46cf75708@spud>
References: <20230802-purse-hydrant-6f44f77364b0@wendy>
 <20230802-detention-second-82ab2b53e07a@wendy>
 <3e066032031e4552b4b7903755deb669@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qg9u4gSpdwUq1o1/"
Content-Disposition: inline
In-Reply-To: <3e066032031e4552b4b7903755deb669@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qg9u4gSpdwUq1o1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2023 at 12:44:07AM +0000, JeeHeng Sia wrote:

> > +/* SBI implementation IDs */
> > +#define SBI_IMP_OPENSBI	1
> I would suggest to create an enum struct for the SBI Imp ID in
> the sbi.h file. What do you think?

I'm not really sure what the advantage of doing so is.

--qg9u4gSpdwUq1o1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNI/dwAKCRB4tDGHoIJi
0g9OAP9rXh4mheB9oj7xanTMiA+0dCjIXkz4ZFQ5YWlhs+GuLQD+NdUYNiTilS/Q
A/GvpEnisAu6ETAprP5ROKjO+STbjQ8=
=ag5L
-----END PGP SIGNATURE-----

--qg9u4gSpdwUq1o1/--
