Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6101978A415
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjH1B7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjH1B7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:59:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B6123;
        Sun, 27 Aug 2023 18:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693187958;
        bh=TwiVx+Gk5YrAjqwDRPJq3dvpHrshJIsLdi83JkGKn4U=;
        h=Date:From:To:Cc:Subject:From;
        b=ovN27nZ+vcs1E+XljI5zrThucLZEGVnrFbVsJwxLq9tdp7rhs4qM+QOONuI6U4zeP
         3cU6Rc7WdolUZbGpruwkffnf7ClIGZfPWODkQA9tVka01yq1OFyBWl0jaVnhN0h9pK
         MTPfuiRwwtH9uqqtFzhphqpYGFA3htJd4bvC7QLCBN30zPHm3f5h97WKJIPTFa9MpL
         isezlxceCr1K7axmwvhT+6xgwXZhse8SWsHmTbLF6OgumRzUFsC1ZSBmpSJPOYUm5X
         aB05HNtEx6P4k/d7s2+Xdt4+gDfygtbxUczdiDK0sWjV8Ev0mjEHmgY2fEE9nQlp7N
         HHHUI0VDzVSZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYtys4dn9z4wxN;
        Mon, 28 Aug 2023 11:59:17 +1000 (AEST)
Date:   Mon, 28 Aug 2023 11:59:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20230828115916.05500911@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Me4zUz3El3i3C_40_n0CWaj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Me4zUz3El3i3C_40_n0CWaj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  kernel/trace/trace.c

between commit:

  eecb91b9f98d ("tracing: Fix memleak due to race between current_tracer an=
d trace")

from Linus' tree and commit:

  9182b519b8c9 ("tracing: Remove unnecessary copying of tr->current_trace")

from the ftrace tree.

I fixed it up (I just used the latter version - more may be
necessary?) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Me4zUz3El3i3C_40_n0CWaj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTr/3QACgkQAVBC80lX
0Gw26wf9Gbt4ugKUdUuTigmPs8IGKtIg+LRrMQiJFFtBPmMREDk50nCe9oS1mZ65
VPMeq34mEBmvxOsaMUXQbgx5L86dBIV5aZ/tJ35P6gXVdKS+eWN3dzQWz6H8wSgb
pNWVJDcoDR8JIBmIdBfwLvhrAg9ImR2jfw3wVXNIgK3UrMLK1eCJy9XtJDH5e9N6
WxtScGgoYxscW5Pz3+/1LSHaMAFLJoPHC5AkdtNN5xxRZof2hUX7R/FQf0eEEgxi
LEqGM19lMTNnRGB7/2AkyOv4p19HEMyCpmlSpZapWKyRlwvNuS21eakGrL084d7L
BNNnqSQ3rHNbnpFDs/0GCexM/bn/ug==
=26yg
-----END PGP SIGNATURE-----

--Sig_/Me4zUz3El3i3C_40_n0CWaj--
