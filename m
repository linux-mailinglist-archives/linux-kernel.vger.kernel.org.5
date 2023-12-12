Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3A80DFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjLLAEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjLLAEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:04:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE461D6;
        Mon, 11 Dec 2023 16:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702339457;
        bh=UYeug0TkALRuKsXEvg5RGABft1sb5wpjMQeuFth69n8=;
        h=Date:From:To:Cc:Subject:From;
        b=GOT9eiSCgrH41VXo+nidTNDvBzNW6VEzDgCuEpoQdRXEWrhY42B+Pd4Hmvw9W6Gc9
         Ws6BQFV0g/MPU7LhWbi2g2QsKJ8vjxaOwSW538Ac42IpH2M5tAuK1vKarrzY2JXBZH
         MvKp4Gx72Z1j9GxwPmye8/lEQqGhuQF0qRIl25+UUQkCwVwqEKb67RiJAGnkCADOcO
         DMJxm8JmUERHklEi1u90oGeHnxgwmj+zzu2az90PZ7I/0vVEvZ9tTZGXnoRlF00qPH
         mTF7tJ1hyopy5ixG0WO3Dh3PvqF1aWV87Yypuh5qtHMTkEDePNRU9JxhTA2gmKBBmf
         ln/ugliQcUWDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpzPF0W2Bz4xGl;
        Tue, 12 Dec 2023 11:04:17 +1100 (AEDT)
Date:   Tue, 12 Dec 2023 11:04:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20231212110415.6f849fb4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d51_/xTNjGL=+PDFCQ_=FRm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d51_/xTNjGL=+PDFCQ_=FRm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpu/drm/drm_atomic_uapi.c:366:1: warning: 'drm_atomic_replace_prope=
rty_blob_from_id' defined but not used [-Wunused-function]
  366 | drm_atomic_replace_property_blob_from_id(struct drm_device *dev,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  1d2b049e4582 ("drm/drm_property: make replace_property_blob_from_id a DRM=
 helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/d51_/xTNjGL=+PDFCQ_=FRm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV3o4AACgkQAVBC80lX
0GxXfAf9ErV1nhD9ueslUkYTMwByvQzvkSLhEkIUg/H37C0BN66pF84JuqAZQ93Q
6NsWX/tyA+mFC9u8k9xgvMnpb0YyFiEyRp2Tk2LGqYtNP/cdemU0TqnXwJJDq3Y+
IZcwKuYl3SAqMFfzuQ127+CmErOteCLZUl0izsPCZ2j5k+XwruMbqLEjkBpiM5DA
a2At2C18xGIGZUDJlPRI99jycRLa752P6DuXU0SnPbDAz+UhymIOG015B4YkzVg7
NcSmoSL1h/3qPKUs535ZEbArlf9AMZmFZBvWGm24hGK9rkhNNumqxzsZIMECi8fX
/x6iPdgmVwnN6aQ/eM7DgnKXN+fa4Q==
=Vudi
-----END PGP SIGNATURE-----

--Sig_/d51_/xTNjGL=+PDFCQ_=FRm--
