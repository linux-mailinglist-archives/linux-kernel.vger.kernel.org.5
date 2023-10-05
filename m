Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E977B9F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjJEOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjJEOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:19:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE521FFC;
        Wed,  4 Oct 2023 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696478498;
        bh=8hwLjXwET4o8Ewk9EJoup9Fux12qGBp+CzVvTVah41A=;
        h=Date:From:To:Cc:Subject:From;
        b=usACGtcVBIG5QV5n0kiT9UsPv1aFYz/MakQMgBcU/hsYJ9pBBUvipZ23LKijKCE10
         Y3bcaxywqiimfp6hEpcmWaIurqndE+94UI8apJwmseyJNrbyv+/gwdX5OXApWsNMzZ
         Y1bsJuf4kUi2N2TMMAdfPVBeOysGty4qsPqp0dddfarRGeEgS+1rpSV0M+5EZQZqUh
         cEGe8jFotzwhGjIfzkZOzSNjeXYUzpOrNletEcLBe8m1PBdgqpzFLL0WpQLnfXu66I
         ZEhHzWQAD2Xi3/vbh5+E1XhTFWKqZJFFSENDlkZoQiMirafwVNXgZz18fWhCQueZ+F
         65aKYerik5Ytg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1HtV42t5z4xF2;
        Thu,  5 Oct 2023 15:01:38 +1100 (AEDT)
Date:   Thu, 5 Oct 2023 15:01:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc-fixes tree
Message-ID: <20231005150137.7fd88e0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C0eruhIm2Bsg/K9zqghPzZ6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C0eruhIm2Bsg/K9zqghPzZ6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc-fixes tree, today's linux-next build (htmldocs)
produced this warning:

include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand  * @NOUVEAU_G=
ETPARAM_EXEC_PUSH_MAX
 on line 49 - I thought it was a doc line

Introduced by commit

  d59e75eef52d ("drm/nouveau: exec: report max pushs through getparam")

--=20
Cheers,
Stephen Rothwell

--Sig_/C0eruhIm2Bsg/K9zqghPzZ6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUeNSEACgkQAVBC80lX
0Gwo8wf/bkcPs2VTv8jFW7ZltypmPhFXK2vqas8Ep7Blb4k3Fwx+QpE+sEe54fWn
YM8M583OMpLCB5Ys7kgJNm2lxzis1gizQGltnDmjzf/KqZGMrmERXwbpTIg+WLrT
4sc1qgC9dhHDnffXDbGY+yO3jtHWNYKhN2BMQh1JLExeC/ac63L6dEVI7/VWXvIM
lLCm2DT4sDlaawB3LzIMCsyH1i8iPGwPXffTnKYjIrOr1HhznUy2jN1vWVxnGtm+
dRoxvnNdosFYJbLKFPE6M+uRWWZdxZoMY0YFPUHmxjmCFZlQV2w7Gz4M6IR9Uk5I
EG+Y9ON3HDJRynWFev6D5xexw10ZCg==
=1USU
-----END PGP SIGNATURE-----

--Sig_/C0eruhIm2Bsg/K9zqghPzZ6--
