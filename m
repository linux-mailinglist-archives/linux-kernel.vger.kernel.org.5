Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23CB796D97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbjIFXXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbjIFXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:23:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FCD199B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:22:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76da0ed3b7aso22981085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694042578; x=1694647378; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JyLgnDBJYphoRi84J21IgPf+ilIRiEV9Th+QE8elsEM=;
        b=RG08oSrAdvxTDuTUM8LrKflm2r0GL0d2AVCulMmDAA5AOm0+0C9WsUEd2djvNHALLA
         mShwQHyI20wyjJKicyZmXQdHyHVj2N37gr1fqewXu8wnYiy8jLJM0RELiikeXCf6ThJp
         vx6qWjNu0OmhXiXHoSR+8zw4xukH/PjcVvpIkqWEPbBxjl0B+RMD8SBZ2c2lJwvk+Ug+
         RvR8PqIzrD7kVeOdmTrO69wEdrNNI/Rz1LZQQfW5zn9WiX4LF1ET16lQ877AN//mnbTP
         uHEQq4q8RA330+CRSPcPqq7Ossyppegfa/LK5jLP7ujs+jC6EBIPa3bazHjLTEkBJX6R
         Y54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042578; x=1694647378;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyLgnDBJYphoRi84J21IgPf+ilIRiEV9Th+QE8elsEM=;
        b=H6wmhuePx0mmt0d9LFJwvIKem+F/iohyQ25gHvl45mqP69EXwBILbwAI+ehzWMkjpn
         UQIBWJQFZRlAVz9qYmD5WmF6V9fMIWTYQG/ehfVw/vQ94GV+OmS2DaifaENPFa1O678p
         4JVrSuuwzZ3H1MC/xRA3oHHIiC9imWi0bE6Vu1IMlOVHAu0BLfPgqlEXgo8TgKZQ27I0
         eqj1mgyYX5o7gt3AndnFMsziu3Pm3ViCCzdbe6Qy8NinvG/Knp5T3EmueclPdNN50GVN
         iGDYDufWkyjtrP5CifES9U1ZH4nPI12NT7ajArOZ+mwa/sJIcrkFy7lLRQqOwwJmSOwD
         4XEQ==
X-Gm-Message-State: AOJu0YwN/aeWUHjNaCF7pT7UFjgA+HCyB7wXYCpHtK9bDbA74fxDIP5t
        /P+kvIGZ/0WE7Ka6CN4g2Ivf
X-Google-Smtp-Source: AGHT+IHwauC9HkTF09HzRHGuvsDsEZfkrM0pvP2ZLytbwm89qxZikr07GAa6o4YJPUMtn8f88hrvYw==
X-Received: by 2002:a05:620a:3944:b0:765:7a1e:a456 with SMTP id qs4-20020a05620a394400b007657a1ea456mr19635332qkn.54.1694042578351;
        Wed, 06 Sep 2023 16:22:58 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a11b200b0076f206cf16fsm5305460qkk.89.2023.09.06.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:22:57 -0700 (PDT)
Date:   Wed, 06 Sep 2023 19:22:57 -0400
Message-ID: <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
References: <20230828195802.135055-5-casey@schaufler-ca.com>
In-Reply-To: <20230828195802.135055-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
> 
> The attribute value is provided in a lsm_ctx structure. The structure
> identifies the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
> 
> struct lsm_ctx {
>         __u64 id;
>         __u64 flags;
>         __u64 len;
>         __u64 ctx_len;
>         __u8 ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
>  include/linux/lsm_hook_defs.h       |   4 +
>  include/linux/lsm_hooks.h           |   1 +
>  include/linux/security.h            |  19 ++++
>  include/linux/syscalls.h            |   5 +
>  include/uapi/linux/lsm.h            |  36 +++++++
>  kernel/sys_ni.c                     |   2 +
>  security/Makefile                   |   1 +
>  security/lsm_syscalls.c             |  57 +++++++++++
>  security/security.c                 | 146 ++++++++++++++++++++++++++++
>  10 files changed, 341 insertions(+)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 security/lsm_syscalls.c

...

> diff --git a/security/security.c b/security/security.c
> index 82253294069c..aa4ade1f71b9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3798,6 +3798,152 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @uctx: the user-space destination for the information, or NULL
> + * @size: pointer to the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported.
> + *
> + * A NULL value for @uctx can be used to get both the number of attributes
> + * and the size of the data.
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> +			 size_t __user *size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> +	u8 __user *base = (u8 __user *)uctx;
> +	size_t total = 0;
> +	size_t entrysize;
> +	size_t left;
> +	bool toobig = false;
> +	bool single = false;
> +	int count = 0;
> +	int rc;
> +
> +	if (attr == LSM_ATTR_UNDEF)
> +		return -EINVAL;
> +	if (size == NULL)
> +		return -EINVAL;
> +	if (get_user(left, size))
> +		return -EFAULT;
> +
> +	if (flags) {
> +		/*
> +		 * Only flag supported is LSM_FLAG_SINGLE
> +		 */
> +		if (flags & LSM_FLAG_SINGLE)
> +			return -EINVAL;

Should this be something like the following?

  if (flags & ~LSM_FLAG_SINGLE)
    return -EINVAL;

> +		if (uctx &&
> +		    copy_struct_from_user(&lctx, sizeof(lctx), uctx, left))
> +			return -EFAULT;
> +		/*
> +		 * If the LSM ID isn't specified it is an error.
> +		 */
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +		single = true;
> +	}
> +
> +	/*
> +	 * In the usual case gather all the data from the LSMs.
> +	 * In the single case only get the data from the LSM specified.
> +	 */
> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (single) {
> +			if (count > 0)
> +				break;
> +			if (lctx.id != hp->lsmid->id)
> +				continue;
> +		}
> +		entrysize = left;
> +		if (base)
> +			uctx = (struct lsm_ctx __user *)(base + total);
> +		rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
> +		if (rc == -EOPNOTSUPP) {
> +			rc = 0;
> +			continue;
> +		}
> +		if (rc == -E2BIG) {
> +			toobig = true;
> +			left = 0;
> +			total += entrysize;
> +			continue;
> +		}
> +		if (rc < 0)
> +			return rc;
> +
> +		left -= entrysize;
> +		total += entrysize;
> +		count += rc;
> +	}
> +	if (put_user(total, size))
> +		return -EFAULT;
> +	if (toobig)
> +		return -E2BIG;
> +	if (count == 0)
> +		return LSM_RET_DEFAULT(getselfattr);
> +	return count;
> +}


--
paul-moore.com
