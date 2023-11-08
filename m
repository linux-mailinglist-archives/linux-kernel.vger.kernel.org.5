Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A77E4EEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjKHCbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKHCba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:31:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FA19A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:31:28 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77bac408851so30697085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699410687; x=1700015487; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbkEkmaPK3/ui+Xn8VLbQvKYhD+dtLCrbQNgJWW9Ttg=;
        b=LxhvSUCZhnOYe4al9vU9nZT/XFft3qyhdedcJE2ikW68nA4I10jWpCEu5i0Sb/5VbM
         q7z5/VZBF1kvPWWhF2vcUHMtohr9RtujrDQKv0bsWKyQ47jD9aQO9xDWM2OQC2PD+Gj8
         k4LbOORnT4SdzMUHXB38Ns+Y4tiFMDkVWqb2OXcgzRjpATF2t/wSczWHNBU1rBzXE33R
         4Q1TxGHe64FuLNjM+OcLamxCHHH+XmdoW+8JE+ho0D5v1VU4st7kASzDoVGbgx86uYxe
         2uagRDMfBDuRIAuZ+k0ow3aEs3y9g1jyHdzQETZ0Z+57qTvlU4Um2sIXYZYjegoK9wQI
         3WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410687; x=1700015487;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkEkmaPK3/ui+Xn8VLbQvKYhD+dtLCrbQNgJWW9Ttg=;
        b=rJysUUP8Pa4veVc/bshXJwD+A9tV59kX7IUuS5JNatCxvE6x5rsCsCAqQg5fnTUlJD
         Sw2IKoJAudAZ0cmir9rg7dXSEVkO96THhX1e2cWOjZXjdZtHeu1rNpGbFIcTWzbC6F8D
         e5j5ImmeG9BFexHzLTSbvqHkBDdq6LHH49qMT0bl6INTlnaKT38vU98ozJHDbfAi+qUt
         ZTcbsUuD9mQljb+bg/+u2mD//8RhNoea9co1gOOC/UjrwmD7d+mAzFHGEZphCElZAva+
         +AsHJVglE3z7iiAnNzfQX+5V1jvPvb7oJgQhIWFlhI/DRgapprZTgDFFZyRPJ/b5yTB4
         LjQg==
X-Gm-Message-State: AOJu0Ywgeh+NhQySi2cqyu27o1RUtSFGBH5qx4ZY9ukvDK3VAoyqw1YJ
        m6Oq+ddwwUzLaI+XWxmbMhRm
X-Google-Smtp-Source: AGHT+IHTQ17LSA0ZChaX7vVfOq7M+l/b0UClJGf/WWYEXhjE85AkbiAYBvrrWJaZNK86n6MyC7kFYg==
X-Received: by 2002:a05:6214:b26:b0:66f:ac87:73b7 with SMTP id w6-20020a0562140b2600b0066fac8773b7mr6056996qvj.15.1699410687064;
        Tue, 07 Nov 2023 18:31:27 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m13-20020ad4504d000000b0064f3b0d0143sm548809qvq.142.2023.11.07.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:31:26 -0800 (PST)
Date:   Tue, 07 Nov 2023 21:31:26 -0500
Message-ID: <2b8269b7c58ebf9b260b4e2a0676bc22.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
References: <20231020155819.24000-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-5-maxime.coquelin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2023 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> This patch introduces LSM hooks for devices creation,
> destruction and opening operations, checking the
> application is allowed to perform these operations for
> the Virtio device type.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
>  include/linux/lsm_hook_defs.h       |  4 +++
>  include/linux/security.h            | 15 ++++++++
>  security/security.c                 | 42 ++++++++++++++++++++++
>  security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  6 files changed, 130 insertions(+)

My apologies for the late reply, I've been trying to work my way through
the review backlog but it has been taking longer than expected; comments
below ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2aa0e219d721..65d9262a37f7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2016 Mellanox Technologies
>   */
>  
> +#include "av_permissions.h"
>  #include <linux/init.h>
>  #include <linux/kd.h>
>  #include <linux/kernel.h>
> @@ -92,6 +93,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
>  #include <linux/io_uring.h>
> +#include <uapi/linux/virtio_ids.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>  }
>  #endif /* CONFIG_IO_URING */
>  
> +static int vduse_check_device_type(u32 sid, u32 device_id)
> +{
> +	u32 requested;
> +
> +	if (device_id == VIRTIO_ID_NET)
> +		requested = VDUSE__NET;
> +	else if (device_id == VIRTIO_ID_BLOCK)
> +		requested = VDUSE__BLOCK;
> +	else
> +		return -EINVAL;
> +
> +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
> +}
> +
> +static int selinux_vduse_dev_create(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}

I see there has been some discussion about the need for a dedicated
create hook as opposed to using the existing ioctl controls.  I think
one important point that has been missing from the discussion is the
idea of labeling the newly created device.  Unfortunately prior to a
few minutes ago I hadn't ever looked at VDUSE so please correct me if
I get some things wrong :)

From what I can see userspace creates a new VDUSE device with
ioctl(VDUSE_CREATE_DEV), which trigger the creation of a new
/dev/vduse/XXX device which will be labeled according to the udev
and SELinux configuration, likely with a generic udev label.  My
question is if we want to be able to uniquely label each VDUSE
device based on the process that initiates the device creation
with the call to ioctl()?  If that is the case, we would need a
create hook not only to control the creation of the device, but to
record the triggering process' label in the new device; this label
would then be used in subsequent VDUSE open and destroy operations.
The normal device file I/O operations would still be subject to the
standard SELinux file I/O permissions using the device file label
assigned by systemd/udev when the device was created.

> +static int selinux_vduse_dev_destroy(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVDESTROY, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
> +static int selinux_vduse_dev_open(u32 device_id)
> +{
> +	u32 sid = current_sid();
> +	int ret;
> +
> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVOPEN, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return vduse_check_device_type(sid, device_id);
> +}
> +
>  /*
>   * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>   * 1. any hooks that don't belong to (2.) or (3.) below,
> @@ -7243,6 +7295,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  #ifdef CONFIG_PERF_EVENTS
>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>  #endif
> +	LSM_HOOK_INIT(vduse_dev_create, selinux_vduse_dev_create),
> +	LSM_HOOK_INIT(vduse_dev_destroy, selinux_vduse_dev_destroy),
> +	LSM_HOOK_INIT(vduse_dev_open, selinux_vduse_dev_open),
>  };
>  
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..d3dc37fb03d4 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
>  	  { "override_creds", "sqpoll", "cmd", NULL } },
>  	{ "user_namespace",
>  	  { "create", NULL } },
> +	{ "vduse",
> +	  { "devcreate", "devdestroy", "devopen", "net", "block", NULL} },

I think we can just call the permissions "create", "open", and "destroy"
since the "dev" prefix is somewhat implied by this being a dedicated
VDUSE object class.

I don't see where you are using the "net" and "block" permissions above,
is this a leftover from a prior draft of this patch or are you planning
to do something with these permissions?

>  	{ NULL }
>    };
>  
> -- 
> 2.41.0

--
paul-moore.com
