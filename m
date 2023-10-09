Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2C7BEE98
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378940AbjJIW4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378939AbjJIW4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:56:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16459D;
        Mon,  9 Oct 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696892163;
        bh=lZbOeY8h0q3Stw3D5TP1TELS51wD9sHI+rTHHE3IsOE=;
        h=Date:From:To:Cc:Subject:From;
        b=DD+wQnSWA8fpbfNKQ8T2sXTsMAE0CRShgGpOhmFJ4Y8e5r6UEzqi2yp5u6MVxsuWN
         thMP7+gZt1oW1GiZfmXyWiNXbE54mrY7QihsOulKz8MoyUpGILGpchZ5X0rYDvKcPf
         BX5UBtaHYH88MZrdN38lqLreTaxtmGMVUpFlMDbrAlnLxa5sfmXafi0v1LmrmFrUAa
         3tSGhgN/3W+q1jfkw2MaAVCr0OddweUlbKdPiRaZApSoplhtJ7hfyf9CyyBrKXPAGG
         yHanuPL7UkL3cp+V4kCK2MDrqdeWECg0EjJf8Yl133aBv7oaiYU4no7WoZrwNBF1CJ
         Ws4YJDQg8ZiPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4Dsb2cMBz4xQm;
        Tue, 10 Oct 2023 09:56:03 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 09:56:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm-perf tree
Message-ID: <20231010095601.1443903c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LULx.hQtM29MVS1rQFZKik+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LULx.hQtM29MVS1rQFZKik+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-perf tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/perf/arm_cspmu/ampere_cspmu.c: In function 'ampere_cspmu_set_ev_fil=
ter':
drivers/perf/arm_cspmu/ampere_cspmu.c:164:9: error: implicit declaration of=
 function 'writel' [-Werror=3Dimplicit-function-declaration]
  164 |         writel(threshold, cspmu->base0 + PMAUXR0);
      |         ^~~~~~
cc1: all warnings being treated as errors

Caused by commit

  290a9c0e55f8 ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC =
PMU")

I have used the arm-perf tree from next-20231009 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/LULx.hQtM29MVS1rQFZKik+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkhQEACgkQAVBC80lX
0Gww2Af+KFRVSTri6Lj+GzcrshGD+r44dXBjnda3Rx4ITzRPT66QYuyqPYev6BJF
BffFvWnR7ynd8F/TeITAziGjHI9xZkz6F44cW+hhoSf/HLst5RRM34PR909mNV5I
WXeGsczTHCOmk00RBg7MHwqwlBTO5Z9RvMJzI16jzp8ZMlH8MwQDtu9RIjEl60iV
M/kR9jBYXtJZLcO+E/UL5BJPVn3Ohsd2X8WWLiraS889aprFn/ke2caFtaxwy8bX
49k2Jbx48GGczu7AgZHQeyNzVvPbpbcJNnG2zrkBp/SJEbZEsFeSVjgoz+zkfyIZ
aY2rRzYVA8R2rtb52ZBofYPtExwhpw==
=Ly/C
-----END PGP SIGNATURE-----

--Sig_/LULx.hQtM29MVS1rQFZKik+--
