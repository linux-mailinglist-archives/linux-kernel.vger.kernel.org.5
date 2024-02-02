Return-Path: <linux-kernel+bounces-49033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB73784650E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B06B221F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6A15B1;
	Fri,  2 Feb 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="omyKORj3"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2010E5;
	Fri,  2 Feb 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833458; cv=none; b=PHvDsst2tYc8o0ky6iq4P8bU576cs1Y6Ph6ADOtihIzJinCQPkTsciY8wZpB4bHUn6XxhFhe/BmJAp4zsCg6RktSrl85LVBnUttdCK4E6sDDRo1JBOJ+Ctjnh7MVw39sZfNTzJVUPOHmn+Dtn41TSeACiaJqkFBOfjW3TnNyhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833458; c=relaxed/simple;
	bh=1G1Hf/AKmvsNtapf4VajHWWFuQLIbvuniMxnZ9fRZcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaXBKT9L1jro3TbYBa0AbgO/iE9ptwEQRDWRSjJI57ABIZsWynW8wpLhVAxksMf4aXgR2Ef87PAYHhDazRPrpZsQ2g/WzDMtZZgDbKhGpk0PkfXq1muxHjYgSK/2WA/SDZlKrOCjwJpBOMr9VDhbDr5du2WMCAHAQdK2JMa05Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=omyKORj3; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B37273F27D;
	Fri,  2 Feb 2024 00:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706833447;
	bh=8dp6QpR84geF7D+Bb8eus3kCDbO3GAA0YrZR3DXAPu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=omyKORj3CgQlILSlOQxXlqkalpJNCuT5mO0BUP6XxEGEaXueRMRXQFwblbqRqNLlN
	 DZdznD8l8hsQuyQCBdZ0AxWVyJzHe8QHWswFwrvFbBfOCLrDcZTQeifTjby3AlmWk3
	 X8/VEw8NE7aULcfgdr40p4BhTdHmTlWPcufkYwk0MNKXcQLCj/Y3R1A7SPyMZJsuGG
	 5VWNhytJASFB+yIo1LQHOkDltPqGcvA2wV+LeNGDIsKkztIVA9e6soIco2wT+VgTh1
	 XELVQp0bCt3bSTXTyzHatH7CleMhz3N5yIV53DGU7Ru1fZwiA730pu0GgyVvDs4g6u
	 9JVandcUCca7Q==
Message-ID: <bdfdb8af-6cab-4e3c-acf8-68a774805fd3@canonical.com>
Date: Thu, 1 Feb 2024 16:24:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 00/42] LSM: General module stacking
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, mic@digikod.net
References: <20231215221636.105680-1-casey.ref@schaufler-ca.com>
 <20231215221636.105680-1-casey@schaufler-ca.com>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 14:15, Casey Schaufler wrote:
> This patchset provides the changes required to allow arbitrary
> combination of all the existing Linux Security Modules (LSM).
> It does not provide for all possible configurations of all of
> co-existing modules. It does not ensure that the enforcement
> of policy provided by one module does not interfere with the
> behavior of another module.
> 
> The bulk of the code change is in support of the audit system.
> Because subjects and objects may have multiple LSM specific
> attributes that are used to make access control decisions it
> was necessary to enhance the audit system to report these
> security attributes. Separate audit records have been added
> to include the additional information for each of the audit
> event subject and object. Providing the required security
> information using 32-bit secids was no longer sufficient. A
> new structure, lsmblob, has been introduced to include the
> data for all relevant modules.
> 
> The lsmblob structure has an entry for each of the modules
> that has used secids. Each module provides a structure of
> its own which contains the information it uses. For SELinux
> this is a u32 secid. Smack provides a pointer into the label
> list. Modules that are not configured use conditional compilation
> to have empty structures.
> 
> Because audit records may need to include the text representation
> of more than one module's security attributes (commonly referred
> to as the "security context") the interfaces that convert the
> lsmblob into a text representation need to identify which module
> provided the text. An structure lsmcontext has been added that
> contains the text, its length and the identifier of the module
> than created it.
> 
> Security attributes for network facilities have provided certain
> challenges. The security information allowed in socket buffers
> and secmarks is limited to a single u32 secid, and there is no
> indication that this will ever be allowed to change. The netlabel
> subsystem, which provides CIPSO and CALIPSO labeling on internet
> packets, supports only one IP packet option at a time. Labeled
> NFS3 also supports only one security module. The existing modules
> have been updated to accept that they may not have access to
> these networking security attributes. The first module to
> register that uses them is given exclusive access.
> 
> The issue of multiple modules using the /proc/.../attr interfaces
> has been largely addressed for some time by the inclusion of module
> specific sub-directories. Applications should be using these except
> for the case of SELinux.
> 
> Patch 0001 removes an interface dependency on audit from IMA.
> Patch 0002 moves management of socket security blobs out of the
> 	modules and into the LSM infrastructure.
> Patch 0003 introduces the lsmblob structure.
> Patch 0004 introduces mechanism for the IMA mechanisms to handle
> 	the possibility of multiple modules that use attributes.
> Patches 0005-0015 add new interfaces and change existing interfaces
> 	to use the lsmblob to represent security data.
> Patches 0016-0021 replace a the use of string and length pairs to
> 	use a "security context" with an lsmcontext structure.
> Patches 0022-0026 implement audit records describing the multiple
> 	security attributes on subjects and objects.
> Patch 0027 removes scaffolding code used in support on lsmcontext.
> Patches 0028-0030 optimize LSM hooks for the networking single
> 	module user case.
> Patch 0031 implements mechanism to reserve use of network secmarks.
> Patch 0032 limits security_secctx_to_secid() to a single module.
> Patch 0033 removes the exclusive tag from AppArmor.
> Patches 0034-0035 adds mount operation security blobs.
> Patch 0036 moves management of key security blobs out of the
> 	modules and into the LSM infrastructure.
> Patch 0037 enables management of mount operation security blobs
> 	in the modules.
> Patches 0038-0039 remove scaffolding for lsmblobs.
> Patch 0040 implements mechanism to reserve use of netlabel.
> Patch 0041 restricts a hook used only by binder to a single module.
> Patch 0042 removes the exclusive tag from Smack.
> 
> https://github.com:cschaufler/lsm-stacking.git#stack-6.7-rc1-pcmoore-dev-v39-b
> 

This is now in testing on the Ubuntu Unstable 6.8 based kernels
https://launchpad.net/~canonical-kernel-team/+archive/ubuntu/unstable

and if all goes well will get rolled out to the noble (24.04) -proposed kernels
for broader testing soon.

> Casey Schaufler (42):
>    integrity: disassociate ima_filter_rule from security_audit_rule
>    SM: Infrastructure management of the sock security
>    LSM: Add the lsmblob data structure.
>    IMA: avoid label collisions with stacked LSMs
>    LSM: Use lsmblob in security_audit_rule_match
>    LSM: Add lsmblob_to_secctx hook
>    Audit: maintain an lsmblob in audit_context
>    LSM: Use lsmblob in security_ipc_getsecid
>    Audit: Update shutdown LSM data
>    LSM: Use lsmblob in security_current_getsecid
>    LSM: Use lsmblob in security_inode_getsecid
>    Audit: use an lsmblob in audit_names
>    LSM: Create new security_cred_getlsmblob LSM hook
>    Audit: Change context data from secid to lsmblob
>    Netlabel: Use lsmblob for audit data
>    LSM: Ensure the correct LSM context releaser
>    LSM: Use lsmcontext in security_secid_to_secctx
>    LSM: Use lsmcontext in security_lsmblob_to_secctx
>    LSM: Use lsmcontext in security_inode_getsecctx
>    LSM: Use lsmcontext in security_dentry_init_security
>    LSM: security_lsmblob_to_secctx module selection
>    Audit: Create audit_stamp structure
>    Audit: Allow multiple records in an audit_buffer
>    Audit: Add record for multiple task security contexts
>    audit: multiple subject lsm values for netlabel
>    Audit: Add record for multiple object contexts
>    LSM: Remove unused lsmcontext_init()
>    LSM: Improve logic in security_getprocattr
>    LSM: secctx provider check on release
>    LSM: Single calls in socket_getpeersec hooks
>    LSM: Exclusive secmark usage
>    LSM: Identify which LSM handles the context string
>    AppArmor: Remove the exclusive flag
>    LSM: Add mount opts blob size tracking
>    LSM: allocate mnt_opts blobs instead of module specific data
>    LSM: Infrastructure management of the key security blob
>    LSM: Infrastructure management of the mnt_opts security blob
>    LSM: Correct handling of ENOSYS in inode_setxattr
>    LSM: Remove lsmblob scaffolding
>    LSM: Allow reservation of netlabel
>    LSM: restrict security_cred_getsecid() to a single LSM
>    Smack: Remove LSM_FLAG_EXCLUSIVE
> 
>   Documentation/ABI/testing/ima_policy    |   8 +-
>   drivers/android/binder.c                |  25 +-
>   fs/ceph/super.h                         |   3 +-
>   fs/ceph/xattr.c                         |  15 +-
>   fs/fuse/dir.c                           |  35 +-
>   fs/nfs/dir.c                            |   2 +-
>   fs/nfs/inode.c                          |  17 +-
>   fs/nfs/internal.h                       |   8 +-
>   fs/nfs/nfs4proc.c                       |  16 +-
>   fs/nfs/nfs4xdr.c                        |  22 +-
>   fs/nfsd/nfs4xdr.c                       |  21 +-
>   include/linux/audit.h                   |  13 +
>   include/linux/lsm/apparmor.h            |  17 +
>   include/linux/lsm/bpf.h                 |  16 +
>   include/linux/lsm/selinux.h             |  16 +
>   include/linux/lsm/smack.h               |  17 +
>   include/linux/lsm_hook_defs.h           |  35 +-
>   include/linux/lsm_hooks.h               |   8 +
>   include/linux/nfs4.h                    |   8 +-
>   include/linux/nfs_fs.h                  |   2 +-
>   include/linux/security.h                | 158 +++++++--
>   include/net/netlabel.h                  |   2 +-
>   include/net/scm.h                       |  12 +-
>   include/uapi/linux/audit.h              |   2 +
>   kernel/audit.c                          | 269 +++++++++++----
>   kernel/audit.h                          |  20 +-
>   kernel/auditfilter.c                    |   9 +-
>   kernel/auditsc.c                        | 142 +++-----
>   net/ipv4/ip_sockglue.c                  |  12 +-
>   net/netfilter/nf_conntrack_netlink.c    |  16 +-
>   net/netfilter/nf_conntrack_standalone.c |  11 +-
>   net/netfilter/nfnetlink_queue.c         |  22 +-
>   net/netlabel/netlabel_unlabeled.c       |  46 ++-
>   net/netlabel/netlabel_user.c            |  10 +-
>   net/netlabel/netlabel_user.h            |   2 +-
>   security/apparmor/audit.c               |  19 +-
>   security/apparmor/include/audit.h       |   8 +-
>   security/apparmor/include/net.h         |   8 +-
>   security/apparmor/include/secid.h       |   5 +-
>   security/apparmor/lsm.c                 |  65 +---
>   security/apparmor/net.c                 |   2 +-
>   security/apparmor/secid.c               |  52 ++-
>   security/bpf/hooks.c                    |   1 +
>   security/integrity/ima/ima.h            |  32 +-
>   security/integrity/ima/ima_api.c        |   6 +-
>   security/integrity/ima/ima_appraise.c   |   6 +-
>   security/integrity/ima/ima_main.c       |  60 ++--
>   security/integrity/ima/ima_policy.c     |  91 +++++-
>   security/security.c                     | 415 ++++++++++++++++++------
>   security/selinux/hooks.c                | 285 +++++++++-------
>   security/selinux/include/audit.h        |  13 +-
>   security/selinux/include/netlabel.h     |   5 +
>   security/selinux/include/objsec.h       |  12 +
>   security/selinux/netlabel.c             |  27 +-
>   security/selinux/ss/services.c          |  20 +-
>   security/smack/smack.h                  |  22 ++
>   security/smack/smack_lsm.c              | 347 ++++++++++++--------
>   security/smack/smack_netfilter.c        |  12 +-
>   security/smack/smackfs.c                |  24 +-
>   59 files changed, 1691 insertions(+), 883 deletions(-)
>   create mode 100644 include/linux/lsm/apparmor.h
>   create mode 100644 include/linux/lsm/bpf.h
>   create mode 100644 include/linux/lsm/selinux.h
>   create mode 100644 include/linux/lsm/smack.h
> 


