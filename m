Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ADC7A90E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIUCbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUCbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:31:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C99E;
        Wed, 20 Sep 2023 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695263484;
        bh=rrKsNa5C1soZq1fFRc7nMu3zzxokdr6j2JJqc0o1XEA=;
        h=Date:From:To:Cc:Subject:From;
        b=U8XTfYRki8mhxr87CB2+cUoKLA+/Uo2SDojiMu1ybKMR4HqqndGGIsO1BES+5XjXM
         rX5cOzRy9uR0lHQq+u2X55ur/hmuq5OETeTG2ZAfc6bQz7ulg7VtRS4qlZRq7lU7Lu
         IhsgzvMBcAexbxu4+Gj5paqMwQcxlQdjNauLudVDYXh9CX/YPwA7urxg9KVEb0h8BX
         SGGy9qVLEbn6PUt9YIGb3U+jl8+X286XZ1BtccqBFpmJJ0dipDZHUPFt7PSW6nSpja
         7R/zTYEzaK4NSQrC0dnpViW484Nt6hnMnWqQ5P9sDdcDrVq5OMnvo6xyD+2VPcRVWc
         yujeZMzvYFisA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrfXq72TTz4x3j;
        Thu, 21 Sep 2023 12:31:23 +1000 (AEST)
Date:   Thu, 21 Sep 2023 12:31:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230921123123.2362fbc1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qppQxBL+5GzDCGM6gTAfvDt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qppQxBL+5GzDCGM6gTAfvDt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/pm/amdgpu_pm.c:988: ERROR: Unexpected indentation.

Introduced by commit

  615585d09b33 ("Documentation/amdgpu: Modify pp_dpm_*clk details")

--=20
Cheers,
Stephen Rothwell

--Sig_/qppQxBL+5GzDCGM6gTAfvDt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULqvsACgkQAVBC80lX
0GyMewf/dsjYrj5+rnOGCfecPa4SHEZgWPV8X3Y0dpO/K4XAGZXdfmpJ6VXxHAur
NC+ixuFKsbkUPBrJjii9+4c34jvsvQ6wJv6ISFtN9m7OLAlF3wXgQzWi0cXkauy6
9UHBYGNl1v6thLBbL6n6XFBOoLzwIaMsB7D0hSNRSsL8nA+NagyusO6IQQ4/0f68
ggQqpDIJGgmTncXPjKDakHQ7Fr3urIo7fbg3jix6y3hd1R9itvYe7TR0uY1ROTxw
3WqGBSnxGGoNry0gRQ2w/wGmSJPZuokJDwvdv5oN4YrBBNbZ4BcAuvOdsPInPk74
A0A2ItwoCrVLkmLBRQ5sFLIGH0rXRg==
=Xvtd
-----END PGP SIGNATURE-----

--Sig_/qppQxBL+5GzDCGM6gTAfvDt--
