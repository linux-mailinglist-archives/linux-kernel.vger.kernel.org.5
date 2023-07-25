Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807A7613A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjGYLMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjGYLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3951FC6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F4761681
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC9BC433C7;
        Tue, 25 Jul 2023 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690283488;
        bh=0c00IIl4jNKUbzeZGk38M6Ww7nU9z5KnWG+sqFdmzd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G90AbqXTzqV9gJ3g/IByNaPfrY5CDlbuwQB9NYOZWZiw6+JqHfW7Yh0Nk273J06Bj
         fxNJBNd9viw1HaQLebeVpCoVDQVGcDRmFCPKWg/uWf0IameHekRvCoGmjbrUjasRc+
         kY2oGbfGC3TV7HQu4t5jQjm0pvmqGxQP/0dbq/55JOftneAxUyFJTLlf8TahpLC9PB
         1VTWON3+Hv2GZIEU8mmu91Q0h61Rpf7b19DbJxv3zsYjNkf1u0W3XmqJur1ONn9D6M
         b0oNBkGHmfElfSk/eJ+hgscqNhMmuxq5A5zm1gr/MiCN6KrAa+iggtg7EHKGf9RHRd
         xDQY4GgO1e/pg==
Date:   Tue, 25 Jul 2023 12:11:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     sunran001@208suo.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: fix application of sizeof to
 pointer
Message-ID: <39df7dfb-b4ef-4775-b756-9bf8eb20731e@sirena.org.uk>
References: <20230720073836.3285-1-xujianghui@cdjrlc.com>
 <74739aaaa05f52084757b526bc8348c8@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+IPDrYl3L8ucP/um"
Content-Disposition: inline
In-Reply-To: <74739aaaa05f52084757b526bc8348c8@208suo.com>
X-Cookie: Bones: "The man's DEAD, Jim!"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+IPDrYl3L8ucP/um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 04:43:57PM +0800, sunran001@208suo.com wrote:
> The coccinelle check report:
> ./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
> sizeof to pointer

This doesn't apply against current code, please check and resend.

--+IPDrYl3L8ucP/um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/rdsACgkQJNaLcl1U
h9BqfAf/c6lCoyIpyVjweqxzgRXJYLCVnq3RkbPAJ3ccrrlou1q5m7QCyvHAegPk
iJmM5DQBdCY+NJPIB8qFf+ixn2gO2x70sbcalETQ6P4Y8hCBf9x+NNsGDsbMz4QE
R43xj9Ld+T3l+ynuws/M326ZkuwyLU5WfNS9npZARJfVhzz/tioF44GIsXJ/0l7L
3FRpDW0xdaK4T1M8j6QGSBkUuwLAop/DnWr0DNa0U67t9WVlaVLZDRXPV3bC8FZj
phZqVUT4h475SYiUrjvTZqtSyPHcg7Dmav+MkeaqyZxGgqdXqyVoq/Y2ABVKyOIV
EtwPtOJnMd5/32DAbSlS17A8tv5cEA==
=BTjl
-----END PGP SIGNATURE-----

--+IPDrYl3L8ucP/um--
