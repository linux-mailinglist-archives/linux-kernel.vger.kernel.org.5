Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485DD7C9CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 02:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjJPASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPASR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 20:18:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C87E95;
        Sun, 15 Oct 2023 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697415490;
        bh=X+yjzqQ/M8r2t7sAenrVpODtLZMQgz7CZQ9WIa84mw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xtx20EM5E7C+DxJZesUmNzEVq2KUoxQnt9jpmsd3Nz4q9YT5BPMw0Ie6IMW7AIVF7
         CvBmetjhd7jRaJfCv1p0ICpp1orqq9+zRFbgKKIP6bpay40x6Di5jndrDu5QcIyq4w
         kY/bJzcCoj8hwueIAv6jVMQ7mhpxXMO3qdHx0I/WIIGE6sHu8cCslOA2zIPKeXC8EZ
         NwqbaOqJ4FFTxF6QAjQtppCYxKHqhyqCBw/mTP3xGIG6sMlgmfkn3sVJFeLhq+etsA
         9qSpz2XRtXWvnELAiEC4HPAMAYbPLdeMAjBNTNMkYJNhVJCjmv1P7MWoagnbHq6ZIO
         /c3WCeRuXE3fw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7yPZ0Yj9z4wcJ;
        Mon, 16 Oct 2023 11:18:10 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 11:18:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231016111808.6e5f59e7@canb.auug.org.au>
In-Reply-To: <20231010124357.5251e100@canb.auug.org.au>
References: <20231010124357.5251e100@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bZXCSpXsG4YUtU9oyrPX_nj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bZXCSpXsG4YUtU9oyrPX_nj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 10 Oct 2023 12:43:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In fun=
ction 'dml_core_mode_support':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8229:1:=
 error: the frame size of 2736 bytes is larger than 2048 bytes [-Werror=3Df=
rame-larger-than=3D]
>  8229 | } // dml_core_mode_support
>       | ^
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   7966f319c66d ("drm/amd/display: Introduce DML2")
>=20
> (or maybe something later that changed storage size).
>=20
> I have used the amdgpu tree from next-20231009 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/bZXCSpXsG4YUtU9oyrPX_nj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUsgUAACgkQAVBC80lX
0GwK2AgAhuLmW/8R6gMNZzJHi+4BzhZy7T7JunG2/muaGvjyFxp5Kqyf9kE3Jnue
XopZtUuVGLzQ5wMAzezO6VS/LcsVwmOpEUlFl/Q2AhRO6Sy8+PjS/rG+Yknx+lwf
lhOKdC7e6JsQ71nF3TKBXqe6x+yIx73W9y5RX4LeADeVK6GV1R5P1fOMfTP5Fqi0
+k0FdIb/iV2Dt6kAo34kyqi5cdD0/1DTrQxSTC5fUHLJlPdLVxKD2enrrk7x4yi5
8gG1hTSaSJyjcec5tsvb0LhIIzU/yWH3VX4N0/Bhf0aaXZwLU79T56bmP2hhsghx
F7Gk3laUeczAHBvo2n06ZYhLUg0D/w==
=SCv8
-----END PGP SIGNATURE-----

--Sig_/bZXCSpXsG4YUtU9oyrPX_nj--
