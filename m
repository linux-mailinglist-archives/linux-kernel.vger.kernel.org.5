Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3268060C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbjLEVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbjLEVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:25:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED521B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:25:29 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77d66c7af31so17198985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811529; x=1702416329; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CMVMFfhvbOdfB8cvyMD4FKpTO+rRmK8hhOgtlFXL7rk=;
        b=Mbql03Ab+1n0b6FoLfHBcRAz3M+47RE7/Ew9sZIAZezRHzNAxuzX1DdgKJPB8P/TGA
         OEmS2cM8tyiyTkWDY2NSXursEd96L6QHC0xjwJOfxRR61W/tGePkYhYL2YioqEuCDUUS
         kPVF7zjN32aAWft0yM7jVo5dlGe0lU91PpQZ4/Nm6h2vDgf171e+Lxy6clGl8+yrimyp
         Wkl/Qjz5rKTo0l5/X1LkGASLQGtmXXBPTbs57smIGFFWJSWDFDI1w5a5NtuwF3aro2Ip
         DBEi/6lb6nxWvHOXr7XqUkd11cSCrW0JQHiOd94xoiWssyboAMYnTeGp7oVFVe2i+p4n
         kISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811529; x=1702416329;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMVMFfhvbOdfB8cvyMD4FKpTO+rRmK8hhOgtlFXL7rk=;
        b=dnaUMsRZgk1I00vokRYYEHwna9xeUqYKf0YfZr4e1aNCq61JvfCrq7XVsKV9TTmXeu
         1RaaU3iBRoP4SQG48rWiq7um6r8OM+As+Z+5UGMo3Dkx3NXcJdRZQM81I6PwjI6ooqHU
         /dLYKYg60F63UKjsaCrGpn0tT1Ds+Xqtn5zuxm7Xvg0e+OYI+p0o2vqRvd50MPJ2OYVY
         GsxRxOvUHRvMSyHNkrSwBhqLpdbXspYoI6935aj79ZnIHGy2R0U0fWGteeD/MuW34/uU
         Rd2CY5z0HC0kkdn+N05KYxF5q7Ce7XKxj6GJnlTxYJBh641+H+RRbUvk+0OarQLsiPdt
         yzfw==
X-Gm-Message-State: AOJu0Yw4UKGG/rBAbZmrU+Ssh7D4/wZBCjn5Keu9RGD8G6gVeVWAz96L
        wHt6N8SRcgmXS6BWNxjbTuy7
X-Google-Smtp-Source: AGHT+IH7OLGZe+bSiTCv7KItvdnzkZ/6BNIFysl6tMyjl2tNshYTK30o06KIqGAeXAlEmbt9QK/1EQ==
X-Received: by 2002:a05:620a:f0b:b0:77d:72cf:c47 with SMTP id v11-20020a05620a0f0b00b0077d72cf0c47mr2828909qkl.35.1701811528715;
        Tue, 05 Dec 2023 13:25:28 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id qx3-20020a05620a8b8300b0077da68b8801sm5405116qkn.65.2023.12.05.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:25:28 -0800 (PST)
Date:   Tue, 05 Dec 2023 16:25:27 -0500
Message-ID: <c88dd2922f2689e2ede5bbf4a0e43a0a@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: Re: [PATCH 4/16] capability: use vfsuid_t for vfs_caps rootids
References: <20231129-idmap-fscap-refactor-v1-4-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-4-da5a26058a5b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2023 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org> wrote:
> 
> The rootid is a kuid_t, but it contains an id which maped into a mount
> idmapping, so it is really a vfsuid. This is confusing and creates
> potential for misuse of the value, so change it to vfsuid_t.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/capability.h | 3 ++-
>  kernel/auditsc.c           | 5 +++--
>  security/commoncap.c       | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)

It might be nice if AS_KUIDT() and friends were named in such a way
as to indicate that they require a vfsuid_t parameter.  At least the
call to __vfsuid_val() should flag a type mismatch if some other type
is used.  Regardless, that is more of a general VFS issue and not a
problem specific to this patchset.

With the same understanding about the capabilities code and Serge ...

Acked-by: Paul Moore <paul@paul-moore.com> (Audit,LSM)

> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index c24477e660fc..eb46d346bbbc 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -16,6 +16,7 @@
>  #include <uapi/linux/capability.h>
>  #include <linux/uidgid.h>
>  #include <linux/bits.h>
> +#include <linux/vfsid.h>
>  
>  #define _KERNEL_CAPABILITY_VERSION _LINUX_CAPABILITY_VERSION_3
>  
> @@ -26,7 +27,7 @@ typedef struct { u64 val; } kernel_cap_t;
>  /* same as vfs_ns_cap_data but in cpu endian and always filled completely */
>  struct vfs_caps {
>  	__u32 magic_etc;
> -	kuid_t rootid;
> +	vfsuid_t rootid;
>  	kernel_cap_t permitted;
>  	kernel_cap_t inheritable;
>  };
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 783d0bf69ca5..65691450b080 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -65,6 +65,7 @@
>  #include <uapi/linux/netfilter/nf_tables.h>
>  #include <uapi/linux/openat2.h> // struct open_how
>  #include <uapi/linux/fanotify.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include "audit.h"
>  
> @@ -2260,7 +2261,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  	name->fcap.permitted = caps.permitted;
>  	name->fcap.inheritable = caps.inheritable;
>  	name->fcap.fE = !!(caps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> -	name->fcap.rootid = caps.rootid;
> +	name->fcap.rootid = AS_KUIDT(caps.rootid);
>  	name->fcap_ver = (caps.magic_etc & VFS_CAP_REVISION_MASK) >>
>  				VFS_CAP_REVISION_SHIFT;
>  
> @@ -2816,7 +2817,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  	ax->fcap.permitted = vcaps.permitted;
>  	ax->fcap.inheritable = vcaps.inheritable;
>  	ax->fcap.fE = !!(vcaps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> -	ax->fcap.rootid = vcaps.rootid;
> +	ax->fcap.rootid = AS_KUIDT(vcaps.rootid);
>  	ax->fcap_ver = (vcaps.magic_etc & VFS_CAP_REVISION_MASK) >> VFS_CAP_REVISION_SHIFT;
>  
>  	ax->old_pcap.permitted   = old->cap_permitted;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cf130d81b8b4..3d045d377e5e 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -710,7 +710,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  	cpu_caps->permitted.val &= CAP_VALID_MASK;
>  	cpu_caps->inheritable.val &= CAP_VALID_MASK;
>  
> -	cpu_caps->rootid = vfsuid_into_kuid(rootvfsuid);
> +	cpu_caps->rootid = rootvfsuid;
>  
>  	return 0;
>  }
> -- 
> 2.43.0

--
paul-moore.com
