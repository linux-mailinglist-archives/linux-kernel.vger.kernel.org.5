Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB4775007
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjHIBDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:03:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D9FB;
        Tue,  8 Aug 2023 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691543017;
        bh=Y16kprpEo00MEaWjNLS2gHaHCAM9o2k8HgEOxN1xh/c=;
        h=Date:From:To:Cc:Subject:From;
        b=dqKimCA8yokk4TbYyRrBpsodT7q2zEU9jso/N0R085o8U6p9UXITnGKlmfGg9wOzh
         FGuRnOQH7eMzGV+lRRo7bjQbIOs1qse6rBgUzDV/Ziq0/BTOVR0KqNSsuMLAfdlGvb
         pE7Tdf0cH6XeePkUX9e/oYu3bLMJvpdyVGpE8irU+SR7oHT3tXbgGEBD76oHhLfX87
         y/lYovKYeTpChUGX45OKTEOI8NMtzNLFbwg3yymlel8jqAEYClNrXaDSlv2k/ebXdG
         ZMplR+1led/7sxOBMAMILx51nTHUgdfbcm9NjXPAb9mKj3XM9CKTajD/G+HXTX483V
         1g8GyrkOVERYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLBdN2XyZz4wqX;
        Wed,  9 Aug 2023 11:03:35 +1000 (AEST)
Date:   Wed, 9 Aug 2023 11:03:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the nfsd tree
Message-ID: <20230809110334.63b7c566@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jBABNubXVx_rOnM0DH/5UmW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jBABNubXVx_rOnM0DH/5UmW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  block/blk-flush.c

between commit:

  bed5a600c6b0 ("block: Revert 615939a2ae73")

from the nfsd tree and commits:

  28b241237470 ("blk-flush: fix rq->flush.seq for post-flush requests")
  b175c86739d3 ("blk-flush: count inflight flush_data requests")

from the block tree.

I fixed it up (I used the former, though I wonder if 28b241237470 fixes
what the revert is trying to work around) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/jBABNubXVx_rOnM0DH/5UmW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTS5eYACgkQAVBC80lX
0Gx0mQf+IbSq2UQwNmusD+Hs+m2WQO1qtnfEBLLDFnytqO1vK12mTsFwlUVoQRZz
BGnLdBrKQSFwCeTFo1UGdOBnAu+47mHB6sref7/LHZB6cuEiVf2qlajocCgWU6cS
7LezpqLn6JrGMn7nKI7GtdgjSkr9fRqqrgkTPNWREIpGosOUZUsuzlpV7AomAjXM
qnilHK+17zKxTI86XyYCoO0Gug163WpJTt6FQxurt+LCahUk6at+/5a8kXwxOHGg
0G4bgYsRAxRfAIhbGUtgut+dI1ORpp+Vv4YwKI8YwnYHpYmtgh7W6xSBOubcGrv3
rm4ypFDYvLXEwa/v9GK1K9Bizc6bNg==
=nJqu
-----END PGP SIGNATURE-----

--Sig_/jBABNubXVx_rOnM0DH/5UmW--
