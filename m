Return-Path: <linux-kernel+bounces-123615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A595890BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8512A389C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71213A882;
	Thu, 28 Mar 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY1gzXDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB146BF;
	Thu, 28 Mar 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658735; cv=none; b=Awkjx5yzGY2Iewnz0yWwCncS4bIri7+MTaKhc+WILVHi3k7aZpPQ0XBDxhspNhvt+R/XoBd8cA73mdRNQQ8RIRahAlfoIPtPz6srPemOsBPHqdoBlPf+2DHfmVxM/nLeatE32twOO2+f/6chAblGG+F43XyRr+suyH8gp38TEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658735; c=relaxed/simple;
	bh=gz6qAnr95/mpG/Wqs8dMJHu4Z2DPzgH2FdBsH4EodMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OLSow+fYt1Tn4c3axBAznL1TWrnYRuRo/gnYHQNvOlMb/+G1jeX4pnEOpAIBMFihmhn1WjLw5sbaqXB0XU15y+uqCmUR3vkDQLwXmtW5HFZJ0SVwY1AhX6WD9N1BO5sdwHR7ZxpF/RLj4tVUeuGRnbU93YBCT9HC1XtR59+GdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY1gzXDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2B7C433F1;
	Thu, 28 Mar 2024 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658735;
	bh=gz6qAnr95/mpG/Wqs8dMJHu4Z2DPzgH2FdBsH4EodMo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KY1gzXDJJuyAE02bHXeN5LGzBm2HiYvLiYjeZtRbajfASuGamuG6nuF1eCmG5OsuE
	 pZLq+q5pdA8KSTQCSqViqjk4B7a9xTvtRtb5drLViSF9/aXRE3EiyqUm5Xw10Llx3o
	 6YPjqABnYQeZLKBohjHSvemMCUzTW4cX2iDOPLB7guLR6eDaOaxi1/fh1UW2Ol8hu3
	 5GvqDiQtXRtiEZRQPYXCzADTzD+A14jR70dfFiXCtfkqXfa1sT6ne+5w4d8M1gkstt
	 oKgBEqoQHGJy1DKI9SvZtdNFKHqamBmcweouFMPIFx6Mw2Rpxr5xXnNXSzK+OxUUf1
	 rRhsEogt6l+Sw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 22:45:28 +0200
Message-Id: <D05ODONHFJ9O.3VG0HLFPA1OB0@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v16 01/20] security: add ipe lsm
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Fan Wu" <wufan@linux.microsoft.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <tytso@mit.edu>, <ebiggers@kernel.org>, <axboe@kernel.dk>,
 <agk@redhat.com>, <snitzer@kernel.org>, <eparis@redhat.com>,
 <paul@paul-moore.com>
X-Mailer: aerc 0.17.0
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-2-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-2-git-send-email-wufan@linux.microsoft.com>

On Thu Mar 28, 2024 at 10:17 PM EET, Fan Wu wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
>
> Integrity Policy Enforcement (IPE) is an LSM that provides an
> complimentary approach to Mandatory Access Control than existing LSMs
> today.
>
> Existing LSMs have centered around the concept of access to a resource
> should be controlled by the current user's credentials. IPE's approach,
> is that access to a resource should be controlled by the system's trust
> of a current resource.
>
> The basis of this approach is defining a global policy to specify which
> resource can be trusted.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + Split evaluation loop, access control hooks,
>     and evaluation loop from policy parser and userspace
>     interface to pass mailing list character limit
>
> v3:
>   + Move ipe_load_properties to patch 04.
>   + Remove useless 0-initializations
>   + Prefix extern variables with ipe_
>   + Remove kernel module parameters, as these are
>     exposed through sysctls.
>   + Add more prose to the IPE base config option
>     help text.
>   + Use GFP_KERNEL for audit_log_start.
>   + Remove unnecessary caching system.
>   + Remove comments from headers
>   + Use rcu_access_pointer for rcu-pointer null check
>   + Remove usage of reqprot; use prot only.
>   + Move policy load and activation audit event to 03/12
>
> v4:
>   + Remove sysctls in favor of securityfs nodes
>   + Re-add kernel module parameters, as these are now
>     exposed through securityfs.
>   + Refactor property audit loop to a separate function.
>
> v5:
>   + fix minor grammatical errors
>   + do not group rule by curly-brace in audit record,
>     reconstruct the exact rule.
>
> v6:
>   + No changes
>
> v7:
>   + Further split lsm creation into a separate commit from the
>     evaluation loop and audit system, for easier review.
>
>   + Introduce the concept of an ipe_context, a scoped way to
>     introduce execution policies, used initially for allowing for
>     kunit tests in isolation.
>
> v8:
>   + Follow lsmname_hook_name convention for lsm hooks.
>   + Move LSM blob accessors to ipe.c and mark LSM blobs as static.
>
> v9:
>   + Remove ipe_context for simplification
>
> v10:
>   + Add github url
>
> v11:
>   + Correct github url
>   + Move ipe before bpf
>
> v12:
>   + Switch to use lsm_id instead of string for lsm name
>
> v13:
>   + No changes
>
> v14:
>   + No changes
>
> v15:
>   + Add missing code in tools/testing/selftests/lsm/lsm_list_modules_test=
c
>
> v16:
>   + No changes
> ---
>  MAINTAINERS                                   |  7 ++++
>  include/uapi/linux/lsm.h                      |  1 +
>  security/Kconfig                              | 11 ++---
>  security/Makefile                             |  1 +
>  security/ipe/Kconfig                          | 17 ++++++++
>  security/ipe/Makefile                         |  9 ++++
>  security/ipe/ipe.c                            | 41 +++++++++++++++++++
>  security/ipe/ipe.h                            | 16 ++++++++
>  security/security.c                           |  3 +-
>  .../selftests/lsm/lsm_list_modules_test.c     |  3 ++
>  10 files changed, 103 insertions(+), 6 deletions(-)
>  create mode 100644 security/ipe/Kconfig
>  create mode 100644 security/ipe/Makefile
>  create mode 100644 security/ipe/ipe.c
>  create mode 100644 security/ipe/ipe.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 079a86e680bc..16e29f2361c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10744,6 +10744,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel=
/git/zohar/linux-integrity.git
>  F:	security/integrity/
>  F:	security/integrity/ima/
> =20
> +INTEGRITY POLICY ENFORCEMENT (IPE)
> +M:	Fan Wu <wufan@linux.microsoft.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Supported
> +T:	git https://github.com/microsoft/ipe.git
> +F:	security/ipe/
> +
>  INTEL 810/815 FRAMEBUFFER DRIVER
>  M:	Antonino Daplas <adaplas@gmail.com>
>  L:	linux-fbdev@vger.kernel.org

MAINTAINER updates should be split into separate commits, preferably to
the tail of the series because it is stamp for the full feature not a
subportion of it.

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 33d8c9f4aa6b..938593dfd5da 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -64,6 +64,7 @@ struct lsm_ctx {
>  #define LSM_ID_LANDLOCK		110
>  #define LSM_ID_IMA		111
>  #define LSM_ID_EVM		112
> +#define LSM_ID_IPE		113
> =20
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
> diff --git a/security/Kconfig b/security/Kconfig
> index 412e76f1575d..9fb8f9b14972 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -192,6 +192,7 @@ source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
> +source "security/ipe/Kconfig"
> =20
>  source "security/integrity/Kconfig"
> =20
> @@ -231,11 +232,11 @@ endchoice
> =20
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,=
apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smac=
k,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAUL=
T_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECUR=
ITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,=
apparmor,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,=
apparmor,ipe,bpf" if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smac=
k,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DE=
FAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_S=
ECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,=
apparmor,ipe,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list, except for those with order
> diff --git a/security/Makefile b/security/Makefile
> index 59f238490665..cc0982214b84 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
>  obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+=3D bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D landlock/
> +obj-$(CONFIG_SECURITY_IPE)		+=3D ipe/
> =20
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+=3D integrity/
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> new file mode 100644
> index 000000000000..e4875fb04883
> --- /dev/null
> +++ b/security/ipe/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Integrity Policy Enforcement (IPE) configuration
> +#
> +
> +menuconfig SECURITY_IPE
> +	bool "Integrity Policy Enforcement (IPE)"
> +	depends on SECURITY && SECURITYFS
> +	select PKCS7_MESSAGE_PARSER
> +	select SYSTEM_DATA_VERIFICATION
> +	help
> +	  This option enables the Integrity Policy Enforcement LSM
> +	  allowing users to define a policy to enforce a trust-based access
> +	  control. A key feature of IPE is a customizable policy to allow
> +	  admins to reconfigure trust requirements on the fly.
> +
> +	  If unsure, answer N.
> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> new file mode 100644
> index 000000000000..f7a80d0f18f8
> --- /dev/null
> +++ b/security/ipe/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) Microsoft Corporation. All rights reserved.
> +#
> +# Makefile for building the IPE module as part of the kernel tree.
> +#
> +
> +obj-$(CONFIG_SECURITY_IPE) +=3D \
> +	ipe.o \
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> new file mode 100644
> index 000000000000..b013aed15e73
> --- /dev/null
> +++ b/security/ipe/ipe.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +#include <uapi/linux/lsm.h>
> +

Not sure if this new line adds any clarity but you can keep it if you
want I neither mind that much.

> +#include "ipe.h"
> +
> +static struct lsm_blob_sizes ipe_blobs __ro_after_init =3D {
> +};
> +
> +static const struct lsm_id ipe_lsmid =3D {
> +	.name =3D "ipe",
> +	.id =3D LSM_ID_IPE,
> +};
> +
> +static struct security_hook_list ipe_hooks[] __ro_after_init =3D {
> +};
> +
> +/**
> + * ipe_init - Entry point of IPE.
> + *
> + * This is called at LSM init, which happens occurs early during kernel
> + * start up. During this phase, IPE registers its hooks and loads the
> + * builtin boot policy.
> + * Return:
> + * * 0		- OK
> + * * -ENOMEM	- Out of memory

Just a suggestion:

* 0:		OK
* -ENOMEM:	Out of memory (OOM)

Rationale being more readable (less convoluted).

And also sort of symmetrical how parameters are formatted in kdoc.

> + */
> +static int __init ipe_init(void)
> +{
> +	security_add_hooks(ipe_hooks, ARRAY_SIZE(ipe_hooks), &ipe_lsmid);
> +
> +	return 0;
> +}
> +
> +DEFINE_LSM(ipe) =3D {
> +	.name =3D "ipe",
> +	.init =3D ipe_init,
> +	.blobs =3D &ipe_blobs,
> +};
> diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
> new file mode 100644
> index 000000000000..a1c68d0fc2e0
> --- /dev/null
> +++ b/security/ipe/ipe.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +
> +#ifndef _IPE_H
> +#define _IPE_H
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt) "IPE: " fmt

s/IPE/ipe/


> +
> +#include <linux/lsm_hooks.h>
> +
> +#endif /* _IPE_H */
> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..287bfac6b471 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -51,7 +51,8 @@
>  	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> -	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
> +	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_IPE) ? 1 : 0))
> =20
>  /*
>   * These are descriptions of the reasons that can be passed to the
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/=
testing/selftests/lsm/lsm_list_modules_test.c
> index 06d24d4679a6..1cc8a977c711 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -128,6 +128,9 @@ TEST(correct_lsm_list_modules)
>  		case LSM_ID_EVM:
>  			name =3D "evm";
>  			break;
> +		case LSM_ID_IPE:
> +			name =3D "ipe";
> +			break;
>  		default:
>  			name =3D "INVALID";
>  			break;

BR, Jarkko

