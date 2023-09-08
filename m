Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D426797F96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbjIHASa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjIHAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:18:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61419BD;
        Thu,  7 Sep 2023 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694132301;
        bh=fpKdjFrfIKXIXJ9t1+BvKKKPcMvMMkRf2U7lxYASI5Y=;
        h=Date:From:To:Cc:Subject:From;
        b=tOm/PaJJ2xxuCiCj7jqwsRrzejvpDnYqOXYohjy1fwPO4pbVHVvEaZYs+gofApOri
         +wZAXhDwT2BjW/y/YX9jhqQcrJ6bnhYwZ+IrP+9Mk09NgQpVWfv7tuwI6TWULW/5N9
         zjPZBSK50HYcoK+gd7UIcdLaj70vBjBr7cIivHUmq9hQJsVeMREsM2GOLeD75ZJAdV
         eUttHAwKQXNpvbZoVj4rKDmLrCXZ6QFH76MFTgadwg3V4eO+EOOVjL0Pb8fgQLi1Fq
         rfYzxYKG3DcAeJexdHFscLhJGv2AW3zGEs68YFg0J1iuWmSTNMnX7JWbJAOc/Cx3TN
         lWZkt4S37TTWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RhcCK04wdz4xFC;
        Fri,  8 Sep 2023 10:18:20 +1000 (AEST)
Date:   Fri, 8 Sep 2023 10:18:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the kvm-x86 tree
Message-ID: <20230908101819.65e8994c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MlhS=k.9dxUGq+xnQ3sZrxE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MlhS=k.9dxUGq+xnQ3sZrxE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  004c297c327f ("KVM: x86/mmu: Harden TDP MMU iteration against root w/o sh=
adow page")
  064a5ab685bd ("KVM: x86/mmu: Cleanup sanity check of SPTEs at SP free")
  1265fb534fa1 ("KVM: x86: Remove the unused page-track hook track_flush_sl=
ot()")
  21baf78ef845 ("KVM: x86/mmu: BUG() in rmap helpers iff CONFIG_BUG_ON_DATA=
_CORRUPTION=3Dy")
  21e0e1efd880 ("KVM: x86/mmu: Assert that correct locks are held for page =
write-tracking")
  2431c9ab231a ("KVM: x86/mmu: Drop infrastructure for multiple page-track =
modes")
  2d28b1230c1c ("drm/i915/gvt: Drop final dependencies on KVM internal deta=
ils")
  2f502998b046 ("KVM: x86/mmu: Move kvm_arch_flush_shadow_{all,memslot}() t=
o mmu.c")
  3e90c27b4209 ("KVM: x86/mmu: Guard against collision with KVM-defined PFE=
RR_IMPLICIT_ACCESS")
  3f8eb1d7d3ee ("KVM: drm/i915/gvt: Drop @vcpu from KVM's ->track_write() h=
ook")
  472ba3231883 ("KVM: x86/mmu: Plumb "struct kvm" all the way to pte_list_r=
emove()")
  4879a4370304 ("drm/i915/gvt: Use an "unsigned long" to iterate over memsl=
ot gfns")
  49a83e190b5b ("drm/i915/gvt: Protect gfn hash table with vgpu_lock")
  4b42f39917c1 ("KVM: x86/mmu: Rename page-track APIs to reflect the new re=
ality")
  4f121b5d2228 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode wi=
thout PAE enabled")
  537eef32e720 ("drm/i915/gvt: Explicitly check that vGPU is attached befor=
e shadowing")
  5a9481e69942 ("KVM: x86/mmu: Delete pgprintk() and all its usage")
  6a718c54c2ee ("drm/i915/gvt: Don't try to unpin an empty page range")
  6d6ff9e6db15 ("KVM: x86/mmu: Bug the VM if write-tracking is used but not=
 enabled")
  732f57612d5c ("KVM: x86/mmu: Add helper to convert root hpa to shadow pag=
e")
  81d4621b7d9f ("KVM: x86/mmu: Disallow guest from using !visible slots for=
 page tables")
  823ab2ea8429 ("drm/i915/gvt: remove interface intel_gvt_is_valid_gfn")
  865327865164 ("drm/i915/gvt: Verify pfn is "valid" before dereferencing "=
struct page"")
  982758f88bb9 ("KVM: x86/mmu: Replace MMU_DEBUG with proper KVM_PROVE_MMU =
Kconfig")
  9e3f832edfca ("KVM: x86/mmu: Harden new PGD against roots without shadow =
pages")
  a328a359d99b ("KVM: x86/mmu: Use dummy root, backed by zero page, for !vi=
sible guest roots")
  a41e34b05da7 ("drm/i915/gvt: Don't bother removing write-protection on to=
-be-deleted slot")
  ac5e77621712 ("drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()")
  b9ae8a09f357 ("drm/i915/gvt: switch from ->track_flush_slot() to ->track_=
remove_region()")
  bc90c971dcb7 ("KVM: x86/mmu: Use BUILD_BUG_ON_INVALID() for KVM_MMU_WARN_=
ON() stub")
  bfd926291c58 ("KVM: x86/mmu: Include mmu.h in spte.h")
  c7784ee6cc06 ("KVM: x86/mmu: Avoid pointer arithmetic when iterating over=
 SPTEs")
  c94811471997 ("drm/i915/gvt: Error out on an attempt to shadowing an unkn=
own GTT entry type")
  ca181aa50724 ("KVM: x86/mmu: Drop @slot param from exported/external page=
-track APIs")
  e19314998321 ("KVM: x86/mmu: Move the lockdep_assert of mmu_lock to insid=
e clear_dirty_pt_masked()")
  e1cb291d66ac ("KVM: x86/mmu: Rename MMU_WARN_ON() to KVM_MMU_WARN_ON()")
  e27395fb1b87 ("drm/i915/gvt: Verify hugepages are contiguous in physical =
address space")
  e2fe84fb5eae ("KVM: x86/mmu: Don't rely on page-track mechanism to flush =
on memslot change")
  eae2d71635a1 ("KVM: x86/mmu: Handle KVM bookkeeping in page-track APIs, n=
ot callers")
  ed501863ae54 ("KVM: x86/mmu: Delete rmap_printk() and all its usage")
  f018c319cc2f ("drm/i915/gvt: Don't rely on KVM's gfn_to_pfn() to query po=
ssible 2M GTT")
  f01ebf874adb ("KVM: x86/mmu: Delete the "dbg" module param")
  f1c58cdb8e04 ("KVM: x86/mmu: Don't bounce through page-track mechanism fo=
r guest PTEs")
  f969ecabe30b ("drm/i915/gvt: Put the page reference obtained by KVM's gfn=
_to_pfn()")

--=20
Cheers,
Stephen Rothwell

--Sig_/MlhS=k.9dxUGq+xnQ3sZrxE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT6aEsACgkQAVBC80lX
0Gwi+Af/aiEDXUxbKKPHHX5Yi9PyeaqrZPpJnq7/OWPinah0s8UwtkVNA2vOLiiS
b3Xg5TraoGO+gU9PwudvRCwBrdLE2S5kLWofEluI47lKJzYAjZZN5AaI/6bKVHK5
Jf6Izki9rVcSB7uv9nTxbBtyFoSdsR91osH2XXPEsDHhJjOerVs+yihk9Ylq+47C
U0BqPJfpi25vLYJlS94/IR1Crr2ZXf8YMwgLGoezV5YBuwrgkxh9Mg/JWO713u0N
1uzvc2s9rTOpUYsu+HucCfwT3VT2MqDJCnG1x6WQ1dEYaajbJ8lW4X2X1IU+eQeu
0pP83EjsppoovGyuF1NGAE7nqbxI/A==
=cARn
-----END PGP SIGNATURE-----

--Sig_/MlhS=k.9dxUGq+xnQ3sZrxE--
