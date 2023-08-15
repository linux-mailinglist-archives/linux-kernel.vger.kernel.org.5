Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07E77C7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjHOGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjHOGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:32:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA61BD4;
        Mon, 14 Aug 2023 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692081126;
        bh=RY0OavXa8ncwwz9ubrLdQIXiXhRqIwnxT0LAgC8wYaY=;
        h=Date:From:To:Cc:Subject:From;
        b=sJC0DM2pk0m6uk8DCNnybQQMlC4t6I35pC56zXP9zJ5tdkBFlX1uSolJ1Rw0rXlqw
         rN/GPhSjDJDcEiCR2dma6ithQcQDmrD4q37UF+/bNe+CTe4sL5c4NhusCIOoj8lss/
         nzR11lsYDCEokkvxS/C/zurcfUPR44NIFgpKrNNbFAqXckkqoIwt/0BBRgOKeeIP7T
         XUyakfvy32GlLYlWmS0jFNvQE46UpgLw21SAWexZLJb/GEsjHOs96rZx3MaEXlctnu
         H+4u6aKPDLklZ9UWJInM1yJBw9v/ivGNlDQphy3ifZ2GcLrir5324jKnzq1pr3m9ba
         uylptqV/vuZMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ1dd0DyRz4wbP;
        Tue, 15 Aug 2023 16:32:04 +1000 (AEST)
Date:   Tue, 15 Aug 2023 16:32:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm-riscv
 tree
Message-ID: <20230815163203.0501fb1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W2NakETR8hKNhKhHdAQCB5m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W2NakETR8hKNhKhHdAQCB5m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  tools/testing/selftests/kvm/Makefile

between commits:

  17da79e009c3 ("KVM: arm64: selftests: Split get-reg-list test code")
  477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")

from the kvm-riscv tree and commit:

  5d1d46f9d56f ("KVM: selftests: Add a selftest for guest prints and format=
ted asserts")

from the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/Makefile
index 8852c37fbc2d,77026907968f..000000000000
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@@ -151,7 -154,7 +153,8 @@@ TEST_GEN_PROGS_aarch64 +=3D access_tracki
  TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
  TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
  TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
 +TEST_GEN_PROGS_aarch64 +=3D get-reg-list
+ TEST_GEN_PROGS_aarch64 +=3D guest_print_test
  TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
  TEST_GEN_PROGS_aarch64 +=3D kvm_page_table_test
  TEST_GEN_PROGS_aarch64 +=3D memslot_modification_stress_test
@@@ -166,9 -169,9 +169,10 @@@ TEST_GEN_PROGS_s390x +=3D s390x/reset
  TEST_GEN_PROGS_s390x +=3D s390x/sync_regs_test
  TEST_GEN_PROGS_s390x +=3D s390x/tprot
  TEST_GEN_PROGS_s390x +=3D s390x/cmma_test
 +TEST_GEN_PROGS_s390x +=3D s390x/debug_test
  TEST_GEN_PROGS_s390x +=3D demand_paging_test
  TEST_GEN_PROGS_s390x +=3D dirty_log_test
+ TEST_GEN_PROGS_s390x +=3D guest_print_test
  TEST_GEN_PROGS_s390x +=3D kvm_create_max_vcpus
  TEST_GEN_PROGS_s390x +=3D kvm_page_table_test
  TEST_GEN_PROGS_s390x +=3D rseq_test
@@@ -177,7 -180,7 +181,8 @@@ TEST_GEN_PROGS_s390x +=3D kvm_binary_stat
 =20
  TEST_GEN_PROGS_riscv +=3D demand_paging_test
  TEST_GEN_PROGS_riscv +=3D dirty_log_test
 +TEST_GEN_PROGS_riscv +=3D get-reg-list
+ TEST_GEN_PROGS_riscv +=3D guest_print_test
  TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
  TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
  TEST_GEN_PROGS_riscv +=3D set_memory_region_test

--Sig_/W2NakETR8hKNhKhHdAQCB5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbG+MACgkQAVBC80lX
0Gy0aAf9GiHz2t3t08gWSgD7N5lFVEV7VXHgWOcdBY/zc+r1GEMVdpNdjGtaUGbB
XsgxJ9egPUlHeRcbYqewqs7eLe13gUlS2lWHoZd7ZVdkN43Q0d8nGGcBypf/ZfnC
Nv7AJlrFz36AmSHlzoCnDApcQd0cLj9B099o+wIBubGib8bVub1DfyGX2K+JXRJI
86rpwZJt+KpT+eixMrwwC/C6Aiz2aeKTw0K0vqMd6eolNcj8tPdRcAZXrUARjcOv
9PZjrVO6TdkFAeq7vqXOid3iOMMOv0wMep1/moFws9+28PwQwNaVByPwSyGdbLy/
n0ArfZ9C7lJUHHqNSHlA/3NeTbX0rA==
=XaAv
-----END PGP SIGNATURE-----

--Sig_/W2NakETR8hKNhKhHdAQCB5m--
