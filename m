Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418597CB954
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQDdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:33:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF995;
        Mon, 16 Oct 2023 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697513607;
        bh=yRCoJV2qMIFqEbhhzDz5mR7MIpIhV2mYtHd7OSPZP3c=;
        h=Date:From:To:Cc:Subject:From;
        b=mdFY+N4ZVgHPzWQlyX9busDAuj0PlVhY1H4nZ003gaKxCgGw+K15XnFbxcik9x5Tn
         +yyg9XDwMHLyCX7zuzgnqzdj5D8zfIR9GRVst9/Z+mPblR5qFSQGpA+TXDbLc9hLs/
         68RDOGIR3U5nuecWvwZB/b8t7jpkxsEEs7u2OR67Iuzrv37w2l0GBSICDsfPW8sD0j
         //m+fGrbQQ2wjNajzxKyCFtHtKvE1Yq43/577aV9WTe1Zz5ICiyyuXRdr7h+8xr/lc
         lIUO+IsFeDM3Ue916yrYPWGIRQ8MtD8NuFwq9dtgjwBMo1PoGiBmQafxMFlNJF8ed4
         ZIAR9Ck/XfmkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8fhQ4Lzpz4wch;
        Tue, 17 Oct 2023 14:33:26 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 14:33:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the coresight tree
Message-ID: <20231017143324.75387a21@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hlAWXj6I76=5sGfcwUdaAFI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hlAWXj6I76=5sGfcwUdaAFI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the coresight tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:48: ERROR: Unexp=
ected indentation.
Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:48: WARNING: Blo=
ck quote ends without a blank line; unexpected unindent.

Introduced by commit

  535d80d3c10f ("coresight-tpdm: Add node to set dsb programming mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/hlAWXj6I76=5sGfcwUdaAFI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuAIQACgkQAVBC80lX
0GwNAQf+Od26e1yZPYGGbPN0wIyGR6p7bouebBzVJTsGML0sACW1hjp5j6BIZh7+
brw8kDZJ0ClAX/LaCYFrpzPpOi3O3KRbWQzoiXOaJX/wNy9EShdsrqo06NYtwOka
JF2H4Ddl8zpb0Xwy7wHyGcpQIG1coBAvo56euNSDGOny7IRF/d+32dTcJCmhMsni
943Z096VH1Mrh2STWErGeaRcVNDGXdfJe/HyAif2Mt0vtklAF/0cDWUGihSMMgPY
mMm8DWH0g4Ptape8yH0CJvwS/VbJbRSWwPC+/zrBTmVsMDEsInEJnqDLksdjIWTi
Uuc1bRxr6d1d2rLvAtlFfw1Qn/971Q==
=FKcj
-----END PGP SIGNATURE-----

--Sig_/hlAWXj6I76=5sGfcwUdaAFI--
