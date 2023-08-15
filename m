Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2377CB21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjHOKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjHOKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:25:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A381737;
        Tue, 15 Aug 2023 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692095110;
        bh=h0Q8kSMYgS1H76twMf1ZK29vSUGWr85lqa3F4xocwq0=;
        h=Date:From:To:Cc:Subject:From;
        b=d9xKgthkZ5yUpaNo4iIaZgiuu4lfj1F5meszW7ZgbB4429V38F9VTvhbPkiL1zFOj
         jH2IdZD3g/Be9q7Mt5+Wi8ydbPhXVktnHUj/oxcApjEyODlBGEGQe7YO6NpZBhCoFF
         LtDaAEEOxL0jjJ+xzKdqBx1bLsy9Ltpch+50IvQQfPflaa9QTNdms/2Tt/HRHUoqu+
         v75Lx+v1DvcaR8zHIL1wIY1TGpHbD7Rh2Rzfs1Gih5VdKCzz3QIWNHQp5kYyPNvTwK
         8Tc8yt/Aw6gZKtFqCimnMonf5an06uXrWKZcxwpj0AJfX5PWu0WMjhCfbJook/4V+R
         fahTa1yHzn+KQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ6pY5t3dz4wbP;
        Tue, 15 Aug 2023 20:25:09 +1000 (AEST)
Date:   Tue, 15 Aug 2023 20:25:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nvmem tree
Message-ID: <20230815202508.0523ecce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0_xSPiA.0YOLudN0Er95wUp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0_xSPiA.0YOLudN0Er95wUp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvmem tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/nvmem/sec-qfprom.c: In function 'sec_qfprom_probe':
drivers/nvmem/sec-qfprom.c:59:13: error: unused variable 'ret' [-Werror=3Du=
nused-variable]
   59 |         int ret;
      |             ^~~
cc1: all warnings being treated as errors

Caused by commit

  9c7f2bce8a0e ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")

I have used the nvmem tree from next-20230809 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/0_xSPiA.0YOLudN0Er95wUp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbUoQACgkQAVBC80lX
0Gz4nwgAn0xqkZClfJTV6HhzAOAjhwSDJ40VH1TCZFFWHuQE7qbmvL+qaLrUo06S
W0qywK7OqqIXa3x7ul57y3TZRokRTIUq4HlT68RWwgB0T8so9cv6/2BWq0W27xgB
Yedg+a5pqbkedXnUx92Dx8JVV/U1AZWYJ7hivYegOZPGcQuf6WQ6pHC9LaUU31Mr
TySHyDQSjg3VsrPAzzlL7MXcCYnCYBbkmb6lVrBLNteXjXhN118611cPZgpAZukW
qyfln8oY6RyPM7WYHB6KMq+bPXd5kwMya+NyIYZmqhGSxp7LnOwl8Iq5S5CBjabh
USAzFIvxrATSVC34QKaXUeCi7/Kwcg==
=O5vR
-----END PGP SIGNATURE-----

--Sig_/0_xSPiA.0YOLudN0Er95wUp--
