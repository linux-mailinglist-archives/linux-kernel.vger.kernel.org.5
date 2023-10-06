Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228D7BB025
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJFBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJFBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:44:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC7E4;
        Thu,  5 Oct 2023 18:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696556690;
        bh=FEZ5Zt1GmousPutMjHkXHKTXZftkzEH+5BRetQ9SLH8=;
        h=Date:From:To:Cc:Subject:From;
        b=QPsAkMu3ouwOCN8SrhzPXaAqTmCtz+DPaSeZTeqeRbim3p4EL/Vlcb7Wkz/onPK4o
         T1E+FTSDxp8+LLlWXhFpOAZ8II+WFxUh/Xn7KHhCL3cUyJoO4riWlwVwTBi5+32CHz
         afj8enCEZX0e6VY5M1szvDeLMGHCMXPXxjTDJdOJppSflqRAdoZRX7/DO89tcwuRDe
         isQ2AZNzN8vN4pZPaYIXdlgTcW0cvYq8+fEIdx6QRsnpDNp8GLJ8daYEKki2XwK1LU
         FymHFqlrMdektyMorj/NzUaH9sHM6QEo0HtDDsgK4wFAv8iCiVKGbYANgcIjb/tjXw
         JsB41dGJP8kpg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1rp93DYFz4x5k;
        Fri,  6 Oct 2023 12:44:49 +1100 (AEDT)
Date:   Fri, 6 Oct 2023 12:44:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-msm-lumag tree with the
 drm-misc tree
Message-ID: <20231006124447.10031f6e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eXIVIosoXmtrWkP4jtgIGQQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eXIVIosoXmtrWkP4jtgIGQQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm-lumag tree got a conflict in:

  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h

between commit:

  8f5d3daad715 ("drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by=
")

from the drm-misc tree and commits:

  eb7af0e86349 ("drm/msm/dpu: add helper to get IRQ-related data")
  07e7d96dcb08 ("drm/msm/dpu: make the irq table size static")

from the drm-msm-lumag tree.

I fixed it up (the latter 2 replaced what was updated by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eXIVIosoXmtrWkP4jtgIGQQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUfZo8ACgkQAVBC80lX
0GzxjAgAoMVn3jWTorqxP+K3iyB+pqlcIgz90HiPbveLth6LEasVkPQQJsRKMUlt
MgH791r86UQGTWQi1YTAfhGxj+wBrXUFYXzAUjlYsGLyBY8+q/reb3Tt+IydPBTB
ZVWA50yhpS4c4jTkOKob8Y06hegR7anpPlypRxeSEU9beG8ZogLXN51FSGjiJBYX
HquwMYxEWAqHBTk10vzSEEDEg8wVdmr6rdv7Gz4MbBdaJhqKEZaxNTkVGXXuy+kn
jePWgxTaCPXNPzBW4+yJNVrkTdF4RklSCUoNuRKgFesWRLBnCabFVgwv7WVY4Ig1
2p5BV5lb3L4x5JS07YcBEx69kL29VA==
=D7A5
-----END PGP SIGNATURE-----

--Sig_/eXIVIosoXmtrWkP4jtgIGQQ--
