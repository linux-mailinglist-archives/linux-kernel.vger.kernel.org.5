Return-Path: <linux-kernel+bounces-94943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F78746FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C67E1F232CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0414F78;
	Thu,  7 Mar 2024 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BKoxBLRk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729FC10A34;
	Thu,  7 Mar 2024 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783669; cv=none; b=gWDAgXvmB59b6IoRzAeEvnvXkJQY4z6280JutHqGI6F1b02nvoIdHmY3ZeH8OQLA3M+DLsut01llgUzgcmGKqcGreU1shZ98In+zihouM9gPeqIo32neGIxxiRLxbdIgCRI5aQxIACUGk+5Y45hFkexYpKr+iSKFwZPCFuGzYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783669; c=relaxed/simple;
	bh=qNi91CWOqVKhggynDhBOv3fa1Kp5Iq79QEjC8p3C1gI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eqmZxNAUA8LGLhx3tibumNrU4AQYmjpIk9gQYPMeSby1ipUIJiMk1WSHPfrphOFTTL3oK7Szy+XUEp6TJk0ofmXfc7KupaavmiyJmOf69JFlL5FrbTy9gvpyr1uD+LUrUgiSbqzj5m7FO/Bqei+W1JpcYNpsAoUPrCQTiGCfRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BKoxBLRk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709783664;
	bh=W0LESQ9VQRAvUyGzI8xRmeOzSdHn7kffUo4AxhmfFoc=;
	h=Date:From:To:Cc:Subject:From;
	b=BKoxBLRkHTELq74eBdnFk1eBb0P2eaO7zGQsBs1au3DmKjeNf9Tn2g1w4B6JVc6gz
	 tEH4Bl15WfY0/nSot3tGdO24oDkkQQfyNTwmb5GGyEyQCZy6zjNGd6XeR7qzxfRkkO
	 Q6CmmlJ6aDCyA0R9/K5cXLiTrYt9z1qJIj+GMD4Hv5AB5mq14Jhv7XkTXRofYYTz7i
	 HmkUaaaeeZWwdusREa7YHJvSIrQ8VMCixOe1oK8Oew07HekTTk8wtzJK7jRwio5NHY
	 6y1OBUa2TktH7Q8F0VvMvpKl1nYmYOlS+UTlbT/7yc/XjRlJhE+65dnIUUVHXes6/G
	 rZHBXG7Thtz3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqwR41067z4wb2;
	Thu,  7 Mar 2024 14:54:23 +1100 (AEDT)
Date: Thu, 7 Mar 2024 14:54:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anup Patel <anup@brainfault.org>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: linux-next: manual merge of the kvm-riscv tree with the perf tree
Message-ID: <20240307145422.0de43782@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gx32OxjYXRynYks=V_TAuA_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Gx32OxjYXRynYks=V_TAuA_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  tools/testing/selftests/kvm/Makefile

between commit:

  c2bd08ba20a5 ("treewide: remove meaningless assignments in Makefiles")

from the perf tree and commit:

  2c5af1c84603 ("selftests/kvm: Fix issues with $(SPLIT_TESTS)")

from the kvm-riscv tree.

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
index 14684aeb4b55,426f85798aea..000000000000
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@@ -267,10 -270,13 +270,13 @@@ TEST_GEN_OBJ =3D $(patsubst %, %.o, $(TES
  TEST_GEN_OBJ +=3D $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
  TEST_DEP_FILES =3D $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
  TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(LIBKVM_OBJS))
- TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
+ TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(SPLIT_TEST_GEN_OBJ))
  -include $(TEST_DEP_FILES)
 =20
- $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
 -x :=3D $(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ=
) $(LIBKVM_S_OBJ))))
++$(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ) $(LIB=
KVM_S_OBJ))))
+=20
+ $(filter-out $(SPLIT_TEST_GEN_PROGS), $(TEST_GEN_PROGS)) \
+ $(TEST_GEN_PROGS_EXTENDED): %: %.o
  	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) =
$(LDLIBS) -o $@
  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
@@@ -298,8 -305,8 +305,8 @@@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(G
  $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 =20
 -x :=3D $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
- $(SPLIT_TESTS_OBJS): $(GEN_HDRS)
+ $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
  $(TEST_GEN_OBJ): $(GEN_HDRS)

--Sig_/Gx32OxjYXRynYks=V_TAuA_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpOm4ACgkQAVBC80lX
0GxEbwf+KsrAfopZtcpVF/CpQQPrYkgw/+fsv10bCa21klhtPpJRDhWMpcAtIFEt
auCGzr5NGjFVgCCub4QdkaJErQNlDJpRjnUlH9279D8+ua4BJ1h5A8NeJCcXNYr1
lv1/wUzmKpX6RHhgQhWge/H+D8EImyShZ+ik1Uh9K8MpWitoeB4W4GfC7QDV0sw8
ulp08rcdjt9szraibkzbNLTvQTaTJh3aqyM4NdvxuZNKdWTmNx0K2m7n8/bU27An
q/pF/0PhwJ5rOiYzuAlZivwhp1iZEkiogqeELWkV3f/kWAJy8YqCwpWS8ScrK+fl
niQ9iJLaJNkwnTLPUIa4tSgub0p+6A==
=Ij9J
-----END PGP SIGNATURE-----

--Sig_/Gx32OxjYXRynYks=V_TAuA_--

