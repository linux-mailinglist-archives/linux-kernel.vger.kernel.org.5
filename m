Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D873757958
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGRKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGRKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79BE4F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F14676150D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088D0C433C8;
        Tue, 18 Jul 2023 10:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689676508;
        bh=ZaV5omOlT2FFoTiy5x+BQBA23UgpYYE/AVU0DfbIVtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyAvhMU1M+Dc9IEDGp/WfPcK5G0ExSCINvtx/5zAyJyQyBHchSyuo6u/AxHdavCnA
         yhxRxBBK8UqsbHGypBr8bT10T8RxkUyMNZdfSPcysSz8Ox49/jQ0CWAlmjJbh7kj4Q
         /dgOQE3Gp/9wc+BRejZmlTZ6tmunMe6Z3y30Ibf/rBEwkeVI6NoA/37apg57rqBWXc
         Cb6iaq4zhj37nrbGf7lUb+f3QQGP2JumhbV/CJZSwxE5csgsGNJbVcTtKs8l8HrvCG
         1RvZd287l4/up933k2DXq1cpia/75oC3ZqVSrEPy32PiVb0etEGxEOyP5TdSkMnsiT
         J3GnJYXLC7fXQ==
Date:   Tue, 18 Jul 2023 11:35:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: Reduce ARCH_KMALLOC_MINALIGN to 8
Message-ID: <20230718-survive-duration-5bea1a07ece0@spud>
References: <20230716165147.1897-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ohkQUed4+afNqPTA"
Content-Disposition: inline
In-Reply-To: <20230716165147.1897-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ohkQUed4+afNqPTA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 12:51:45AM +0800, Jisheng Zhang wrote:
> Since v1
>  - remove preparation patches since they have been merged
>  - adjust Kconfig entry to keep entries sorted

>  - add new function riscv_set_dma_cache_alignment() to set the
>    dma_cache_alignment var.

Yeah, looks a lot more straightforward now than in v1, thanks.

--ohkQUed4+afNqPTA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLZq2AAKCRB4tDGHoIJi
0lK/AQDpSk3Y7G5SPZ6seWkhMA17sWxm3a/pvfsQwgN+7QPyRwD+OP3z97omY0XI
MdkIwhNl2lMpl4EPexXOoDGtDSMNYAQ=
=1hO1
-----END PGP SIGNATURE-----

--ohkQUed4+afNqPTA--
