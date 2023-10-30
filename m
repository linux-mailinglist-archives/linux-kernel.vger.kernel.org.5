Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A07DB1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJ3CFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3CFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:05:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917DFBE;
        Sun, 29 Oct 2023 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698631507;
        bh=52RizNGpmKkqAZFiOEDmBruszolwlq3hzFn8IkpOql0=;
        h=Date:From:To:Cc:Subject:From;
        b=n8xemMT4pznIXJc5bFCpGOAFbnYaYTEcgg04W4//JHXpeuEqndMqF5gbI66eWChSS
         2VeA7RhTSZ7PR9OrxGjsuonauQlBK6NF26eIlvBOc+QA1WJ5kuVrh8MbhgWpkJE5ei
         ZAH0Sx+CHDkzcrTNSHF06qOgMMTOmNYrbPnIT+3mMSQirn0ew7pPFUWT3RlWF5wbIH
         0+bve+uNYXJ41HomVvI1JffsuC1Io0HWGK/MsXiZKP60UhAqfXBARyIqa4b/WwFN5C
         GSb3n1ath3icXFe1Yhe0+5biSDZm3v/uzwWYMclsaNehamnIuyiV3g/vBVTIZbLlO2
         Pa8veoKPXopeQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJc6T0CBWz4wd1;
        Mon, 30 Oct 2023 13:05:04 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 13:05:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm-arm tree
Message-ID: <20231030130504.16f486a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KOsrrmIzvFSxNZ5oYKnB8W_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KOsrrmIzvFSxNZ5oYKnB8W_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  Documentation/virt/kvm/api.rst

between commits:

  6656cda0f3b2 ("KVM: arm64: Document KVM_ARM_GET_REG_WRITABLE_MASKS")
  dafa493dd01d ("KVM: arm64: Document vCPU feature selection UAPIs")

from the kvm-arm tree and commits:

  8e555bf388af ("KVM: Introduce KVM_SET_USER_MEMORY_REGION2")
  e82df88abb18 ("KVM: Introduce per-page memory attributes")
  fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific=
 backing memory")
  a2e4643a589a ("KVM: Add transparent hugepage support for dedicated guest =
memory")

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

diff --cc Documentation/virt/kvm/api.rst
index d75c9a7a7193,205b0c3020c2..000000000000
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@@ -6124,56 -6107,137 +6161,187 @@@ writes to the CNTVCT_EL0 and CNTPCT_EL
  interface. No error will be returned, but the resulting offset will not be
  applied.
 =20
 -4.139 KVM_SET_USER_MEMORY_REGION2
 +.. _KVM_ARM_GET_REG_WRITABLE_MASKS:
 +
 +4.139 KVM_ARM_GET_REG_WRITABLE_MASKS
 +-------------------------------------------
 +
 +:Capability: KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES
 +:Architectures: arm64
 +:Type: vm ioctl
 +:Parameters: struct reg_mask_range (in/out)
 +:Returns: 0 on success, < 0 on error
 +
 +
 +::
 +
 +        #define KVM_ARM_FEATURE_ID_RANGE	0
 +        #define KVM_ARM_FEATURE_ID_RANGE_SIZE	(3 * 8 * 8)
 +
 +        struct reg_mask_range {
 +                __u64 addr;             /* Pointer to mask array */
 +                __u32 range;            /* Requested range */
 +                __u32 reserved[13];
 +        };
 +
 +This ioctl copies the writable masks for a selected range of registers to
 +userspace.
 +
 +The ``addr`` field is a pointer to the destination array where KVM copies
 +the writable masks.
 +
 +The ``range`` field indicates the requested range of registers.
 +``KVM_CHECK_EXTENSION`` for the ``KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES``
 +capability returns the supported ranges, expressed as a set of flags. Each
 +flag's bit index represents a possible value for the ``range`` field.
 +All other values are reserved for future use and KVM may return an error.
 +
 +The ``reserved[13]`` array is reserved for future use and should be 0, or
 +KVM may return an error.
 +
 +KVM_ARM_FEATURE_ID_RANGE (0)
 +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 +
 +The Feature ID range is defined as the AArch64 System register space with
 +op0=3D=3D3, op1=3D=3D{0, 1, 3}, CRn=3D=3D0, CRm=3D=3D{0-7}, op2=3D=3D{0-7=
}.
 +
 +The mask returned array pointed to by ``addr`` is indexed by the macro
 +``ARM64_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)``, allowing userspa=
ce
 +to know what fields can be changed for the system register described by
 +``op0, op1, crn, crm, op2``. KVM rejects ID register values that describe=
 a
 +superset of the features supported by the system.
 +
++4.140 KVM_SET_USER_MEMORY_REGION2
+ ---------------------------------
+=20
+ :Capability: KVM_CAP_USER_MEMORY2
+ :Architectures: all
+ :Type: vm ioctl
+ :Parameters: struct kvm_userspace_memory_region2 (in)
+ :Returns: 0 on success, -1 on error
+=20
+ KVM_SET_USER_MEMORY_REGION2 is an extension to KVM_SET_USER_MEMORY_REGION=
 that
+ allows mapping guest_memfd memory into a guest.  All fields shared with
+ KVM_SET_USER_MEMORY_REGION identically.  Userspace can set KVM_MEM_PRIVAT=
E in
+ flags to have KVM bind the memory region to a given guest_memfd range of
+ [guest_memfd_offset, guest_memfd_offset + memory_size].  The target guest=
_memfd
+ must point at a file created via KVM_CREATE_GUEST_MEMFD on the current VM=
, and
+ the target range must not be bound to any other memory region.  All stand=
ard
+ bounds checks apply (use common sense).
+=20
+ ::
+=20
+   struct kvm_userspace_memory_region2 {
+ 	__u32 slot;
+ 	__u32 flags;
+ 	__u64 guest_phys_addr;
+ 	__u64 memory_size; /* bytes */
+ 	__u64 userspace_addr; /* start of the userspace allocated memory */
+   __u64 guest_memfd_offset;
+ 	__u32 guest_memfd;
+ 	__u32 pad1;
+ 	__u64 pad2[14];
+   };
+=20
+ A KVM_MEM_PRIVATE region _must_ have a valid guest_memfd (private memory)=
 and
+ userspace_addr (shared memory).  However, "valid" for userspace_addr simp=
ly
+ means that the address itself must be a legal userspace address.  The bac=
king
+ mapping for userspace_addr is not required to be valid/populated at the t=
ime of
+ KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped/allo=
cated
+ on-demand.
+=20
+ When mapping a gfn into the guest, KVM selects shared vs. private, i.e co=
nsumes
+ userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_P=
RIVATE
+ state.  At VM creation time, all memory is shared, i.e. the PRIVATE attri=
bute
+ is '0' for all gfns.  Userspace can control whether memory is shared/priv=
ate by
+ toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as ne=
eded.
+=20
 -4.140 KVM_SET_MEMORY_ATTRIBUTES
++4.141 KVM_SET_MEMORY_ATTRIBUTES
+ -------------------------------
+=20
+ :Capability: KVM_CAP_MEMORY_ATTRIBUTES
+ :Architectures: x86
+ :Type: vm ioctl
+ :Parameters: struct kvm_memory_attributes(in)
+ :Returns: 0 on success, <0 on error
+=20
+ KVM_SET_MEMORY_ATTRIBUTES allows userspace to set memory attributes for a=
 range
+ of guest physical memory.
+=20
+ ::
+=20
+   struct kvm_memory_attributes {
+ 	__u64 address;
+ 	__u64 size;
+ 	__u64 attributes;
+ 	__u64 flags;
+   };
+=20
+   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+=20
+ The address and size must be page aligned.  The supported attributes can =
be
+ retrieved via ioctl(KVM_CHECK_EXTENSION) on KVM_CAP_MEMORY_ATTRIBUTES.  If
+ executed on a VM, KVM_CAP_MEMORY_ATTRIBUTES precisely returns the attribu=
tes
+ supported by that VM.  If executed at system scope, KVM_CAP_MEMORY_ATTRIB=
UTES
+ returns all attributes supported by KVM.  The only attribute defined at t=
his
+ time is KVM_MEMORY_ATTRIBUTE_PRIVATE, which marks the associated gfn as b=
eing
+ guest private memory.
+=20
+ Note, there is no "get" API.  Userspace is responsible for explicitly tra=
cking
+ the state of a gfn/page as needed.
+=20
+ The "flags" field is reserved for future extensions and must be '0'.
+=20
 -4.141 KVM_CREATE_GUEST_MEMFD
++4.142 KVM_CREATE_GUEST_MEMFD
+ ----------------------------
+=20
+ :Capability: KVM_CAP_GUEST_MEMFD
+ :Architectures: none
+ :Type: vm ioctl
+ :Parameters: struct struct kvm_create_guest_memfd(in)
+ :Returns: 0 on success, <0 on error
+=20
+ KVM_CREATE_GUEST_MEMFD creates an anonymous file and returns a file descr=
iptor
+ that refers to it.  guest_memfd files are roughly analogous to files crea=
ted
+ via memfd_create(), e.g. guest_memfd files live in RAM, have volatile sto=
rage,
+ and are automatically released when the last reference is dropped.  Unlike
+ "regular" memfd_create() files, guest_memfd files are bound to their owni=
ng
+ virtual machine (see below), cannot be mapped, read, or written by usersp=
ace,
+ and cannot be resized  (guest_memfd files do however support PUNCH_HOLE).
+=20
+ ::
+=20
+   struct kvm_create_guest_memfd {
+ 	__u64 size;
+ 	__u64 flags;
+ 	__u64 reserved[6];
+   };
+=20
+   #define KVM_GUEST_MEMFD_ALLOW_HUGEPAGE         (1ULL << 0)
+=20
+ Conceptually, the inode backing a guest_memfd file represents physical me=
mory,
+ i.e. is coupled to the virtual machine as a thing, not to a "struct kvm".=
  The
+ file itself, which is bound to a "struct kvm", is that instance's view of=
 the
+ underlying memory, e.g. effectively provides the translation of guest add=
resses
+ to host memory.  This allows for use cases where multiple KVM structures =
are
+ used to manage a single virtual machine, e.g. when performing intrahost
+ migration of a virtual machine.
+=20
+ KVM currently only supports mapping guest_memfd via KVM_SET_USER_MEMORY_R=
EGION2,
+ and more specifically via the guest_memfd and guest_memfd_offset fields in
+ "struct kvm_userspace_memory_region2", where guest_memfd_offset is the of=
fset
+ into the guest_memfd instance.  For a given guest_memfd file, there can b=
e at
+ most one mapping per page, i.e. binding multiple memory regions to a sing=
le
+ guest_memfd range is not allowed (any number of memory regions can be bou=
nd to
+ a single guest_memfd file, but the bound ranges must not overlap).
+=20
+ If KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is set in flags, KVM will attempt to al=
locate
+ and map hugepages for the guest_memfd file.  This is currently best effor=
t.  If
+ KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is set, the size must be aligned to the ma=
ximum
+ transparent hugepage size supported by the kernel
+=20
+ See KVM_SET_USER_MEMORY_REGION2 for additional details.
+=20
  5. The kvm_run structure
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =20

--Sig_/KOsrrmIzvFSxNZ5oYKnB8W_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/D1AACgkQAVBC80lX
0GyV2Qf/WxqqvxEy/hKxsKsM3QfJsLqAjSup4dQr4c7r2vRxQLJDTKassLg5mGjK
Sw0Ye+h8fhQkdX9Xof6VEzovmtBsSfwH36uizdK0GBwxFDjN4GbHldP6eHySuAE2
2DVJ7o7+fmaSoKYygKlrKiGxfWMgxXG3kY8pYEcqZHf6m/5ZRLdv8SbISK52JVlJ
ahsCZNd/MwfONr5+JuRv418nKThs77QSxDJ+Nne/nrEZxmmEtSu6EnskgwxM1MDr
mud+WPWDvFeAVGxL+Rkm9m0xt5PigtFoU6+bi5k+vlsiaZBgYRYWbvTIrAga9wM8
SVR16Dad0NsKDCjNvy+Q7zgJCdhXtQ==
=Fmnw
-----END PGP SIGNATURE-----

--Sig_/KOsrrmIzvFSxNZ5oYKnB8W_--
